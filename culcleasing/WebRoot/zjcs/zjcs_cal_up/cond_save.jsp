<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*" %> 
<%@ page import="com.container.*" %>
<%@page import="com.tenwa.log.LogWriter"%>
<%@page import="com.tenwa.util.CurrencyUtil"%>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<jsp:useBean id="fileBean" scope="page" class="com.UploadBean" />
<jsp:useBean id="execlBean" scope="page" class="com.UploadExecl" />
<%@ include file="../../func/common_simple.jsp"%>

<%
//当前登陆人
String czy = (String) session.getAttribute("czyid");

//基础变量
String datestr=getSystemDate(0); 
boolean bflag = true;
String errMsg = "";
String sqlstr;
ResultSet rs = null;
String uid="";

//excel对应字段名称
String ebdata_id = "";
String own_bank = ""; //本方银行
String own_account = ""; //本方账户
String own_acc_number = "";//本方账号
String client_bank = ""; //对方银行
String client_account = "";//对方账户
String client_acc_number = "";//对方账号
String client_name = "";//付款人
String money_type = "人民币";//到账金额类型
String fact_money = "";//到账金额
String fact_date = "";//到账时间
String used_money = "0";//已使用金额
String left_money = "";//有效金额
String sn = "";//流水号
String status = "0";//状态 0代表 有效  1代表 无效
String business_flag = "0"; //是否租赁相关 0有关 1无关
String summary = "";//备注 、摘要
String upload_date = "";//上传时间

double dalldata=0;
int iallcol=0;

//上传excel参数
String filePath;
String message = "";


//设定附件相对路径
String path = pageContext.getServletContext().getRealPath("/");
filePath = "\\ebank_excel\\"+datestr+"\\";
String allpath =path + "\\ebank_excel\\"+datestr+"\\";
fileBean.setObjectPath( allpath );
//设定上传附件总体大小限制 
fileBean.setSize(8*1024*1024);

//设定上传附件文件类型
fileBean.setSuffix(".xls");

//设定上传用户ID
if ( ( czy != null ) && ( !czy.equals("") ) ) {
   uid=czy.substring(7);
}
fileBean.setUserid(uid);
fileBean.setSourceFile(request);
String [] saSourceFile = fileBean.getSourceFile();
String [] saObjectFile = fileBean.getObjectFileName();
String [] saDescription = fileBean.getDescription();
int iCount = fileBean.getCount();
String sObjectPath = fileBean.getObjectPath();
//表单非文件类型参数
String ebank_date = fileBean.getFieldValue("ebank_date");
upload_date = ebank_date;
//判断是否一天只能上传一次 --暂时屏蔽
int dateflag=0;

//=============插入上传信息================
//取得导出流水号
String eup_id="";
sqlstr="select count(id)+1 as no from generate_no where generate_type='网银数据上传'";
rs=db.executeQuery(sqlstr);
if(rs.next()){
	eup_id=getDBStr( rs.getString("no") );
}rs.close();
sqlstr="insert into generate_no select '网银数据上传','"+datestr+"','"+eup_id+"'";
db.executeUpdate(sqlstr);
eup_id = "ebankup"+eup_id;
//上传基础信息			
sqlstr = "insert into fund_ebank_imp(up_id,upload_time,file_name,file_path,creator,create_date,modificator,modify_date)";
sqlstr+= "values('"+eup_id+"','"+ebank_date+"','"+saObjectFile[0]+"','"+filePath+"','"+czy+"','"+datestr+"','"+czy+"','"+datestr+"')";
db.executeUpdate(sqlstr);
//sqlstr="  select * from inter_finance_closeday where close_day>='"+ebank_date+"'";
//ResultSet rsCloseday = db1.executeQuery(sqlstr); 
//if(rsCloseday.next()){
//	dateflag=1;
//}
if(dateflag<1){
   if(saObjectFile!=null){
	for(int j=0;j<saObjectFile.length;j++){
		if(saObjectFile[j]!=null&&!saObjectFile[j].equals("")){
			execlBean.setExecl(allpath+saObjectFile[j]);
			if(execlBean.getFlag()){
				String [][]obj = execlBean.getObject(); //遍历1个sheet
				iallcol = obj.length;
				System.out.println("第一个sheet有："+iallcol+"行");
				for(int row=0;row<obj.length;row++){//遍历多行
					String []objrow = obj[row]; 
					
					LogWriter.logDebug(request, "第"+row+"行，===第8列值："+objrow[7]+"共"+objrow.length+"列");
					System.out.println("第"+row+"行，===第1列值："+objrow[0]+"共"+objrow.length+"列");
					
					own_bank = objrow[0];
					own_account = objrow[1];
					own_acc_number = objrow[2];
					client_bank = objrow[3];
					client_account = objrow[4];
					client_acc_number = objrow[5];
					client_name = objrow[6];
					fact_money = objrow[7];
					fact_date = objrow[8];
					sn=objrow[9];
					summary=objrow[10];
					left_money = fact_money;
					System.out.println("上传网银数据："+client_name);
					LogWriter.logDebug(request, "上传网银数据,付款人："+client_name);
					//判断如果付款账号没有数据则跳过
					if("".equals(client_acc_number)){
						iallcol--;
						System.out.println("第"+row+"行，===第1列值："+objrow[0]+"共"+objrow.length+"列，数据非法");
						continue;
					}
//					ResultSet rsCount = null;
//					sqlstr = "select count(*) as count from fund_ebank_data where order_number="+order_number;
//					System.out.println(sqlstr);
//					rsCount = db2.executeQuery(sqlstr);
//					boolean flag = false;
//					if(rsCount.next()){
//						if(Integer.parseInt(rsCount.getString("count"))>0){
//							flag = true;
//						}
//					}
//					if(!flag){
					//生成网银编号
					//sqlstr = "select dbo.wybhsc('"+client_acc_number+"') as xh";
					//rs = db.executeQuery(sqlstr); 
					//if ( rs.next() ) {
					//	ebdata_id = getDBStr( rs.getString("xh") );
					//}
					//rs.close();
					
					//生成网银编号
					sqlstr="select count(id)+1 as no from generate_no where generate_type='"+client_acc_number+"网银数据'";
					rs=db.executeQuery(sqlstr);
					if(rs.next()){
						ebdata_id=getDBStr( rs.getString("no") );
					}rs.close();
					sqlstr="insert into generate_no select '"+client_acc_number+"网银数据','"+datestr+"','"+ebdata_id+"'";
					db.executeUpdate(sqlstr);
					ebdata_id = client_acc_number+"_"+ebdata_id;
					
					//插入数据
					if(ebdata_id!=null&&!ebdata_id.equals("")&&!ebdata_id.equals("null")){
						sqlstr = "insert into fund_ebank_data (ebdata_id,up_id,own_bank,own_account,own_acc_number,client_bank,client_account,";
						sqlstr +=" client_acc_number,client_name,money_type,fact_money,fact_date,used_money,left_money,sn,status,business_flag,";
						sqlstr +=" summary,upload_date,creator,create_date) values (";
						sqlstr += "'"+ebdata_id+"'";
						sqlstr += ",'"+eup_id+"'";
						sqlstr += ",'"+own_bank+"'";
						sqlstr += ",'"+own_account+"'";
						sqlstr += ",'"+own_acc_number+"'";
						sqlstr += ",'"+client_bank+"'";
						sqlstr += ",'"+client_account+"'";
						sqlstr += ",'"+client_acc_number+"'";
						sqlstr += ",'"+client_name+"'";
						sqlstr += ",'"+money_type+"'";
						sqlstr += ",'"+fact_money+"'";
						sqlstr += ",'"+fact_date+"'";
						sqlstr += ",'"+used_money+"'";
						sqlstr += ",'"+left_money+"'";
						sqlstr += ",'"+sn+"'";
						sqlstr += ",'"+status+"'";
						sqlstr += ",'"+business_flag+"'";
						sqlstr += ",'"+summary+"'";
						sqlstr += ",'"+upload_date+"'";
						sqlstr += ",'"+czy+"'";
						sqlstr += ",'"+datestr+"')";
						System.out.println("KKKKKKKKKKKK"+sqlstr);
						LogWriter.logDebug(request, "插入网银数据："+sqlstr.substring(0,15));
						db.executeUpdate(sqlstr);
						if(fact_money!=null&&!fact_money.equals("")){
							dalldata += Double.parseDouble(fact_money);
						}
						
					}else{
						iallcol--;
						message+=client_acc_number+";";
					}
				} 
				//修改上传信息里的总金额与总数量
				sqlstr = "update fund_ebank_imp set sum_fact_money='"+dalldata+"',count_fact_imp='"+iallcol+"' where up_id='"+eup_id+"'";
				db.executeUpdate(sqlstr);	
				//日志操作
				String sqlLog = LogWriter.getSqlIntoDB(request, "网银数据导入", "数据导入", "导入项目总金额:"+dalldata+"数据总数量"+iallcol, sqlstr);
				db.executeUpdate(sqlLog);
			}else{
				bflag = false;
				errMsg +=saObjectFile[j]+execlBean.getErrMsg()+";";
				execlBean.deleteFile(allpath+saObjectFile[j]);
			}
		}
	}//for循环结束
   }
}

db.close();

if(dateflag<1){
	if(bflag && message.equals("")){
%>
<script type="text/javascript">
	window.close();
	opener.alert("上传网银数据成功!本次共上传<%=CurrencyUtil.convertIntAmount(iallcol) %>条网银记录，总金额<%=CurrencyUtil.convertFinance(dalldata)%>");
	opener.location.reload();
</script>
<%
}else{
	if(message.equals("")){
%>
<script type="text/javascript">
	window.close();
	opener.alert("上传网银数据失败,execl文件<%=errMsg%>数据格式错误");
	opener.location.reload();
</script>
<%
}else{
	message="序号"+message+"无法生成网银编号，请修改数据后单独上传";
	if(!bflag){
%>
<script type="text/javascript">
	window.close();
	opener.alert("上传网银数据失败,execl文件<%=errMsg%>数据格式错误");
	opener.alert("<%=message%>");
	opener.location.reload();
</script>
<%
	}else{
%>
<script type="text/javascript">
		window.close();
		opener.alert("<%=message%>,本次共上传<%=CurrencyUtil.convertIntAmount(iallcol) %>条网银记录，总金额<%=CurrencyUtil.convertFinance(dalldata)%>");
		opener.location.reload();
</script>
<%
		}
	}
}
}else{
%>
<script type="text/javascript">
		window.close();
		opener.alert("上传日期应大于最近一次的关帐日");
		opener.location.reload();
</script>
<%
}
%>