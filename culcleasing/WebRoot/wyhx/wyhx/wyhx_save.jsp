<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*" %> 
<%@ page import="java.io.File" %>
<%@ page import="com.container.*" %>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<jsp:useBean id="db1" scope="page" class="dbconn.Conn" /> 
<jsp:useBean id="fileBean" scope="page" class="com.UploadBean" />
<jsp:useBean id="execlBean" scope="page" class="com.UploadExecl" />
<%@ include file="../../func/common.jsp"%>
<%
String czy = (String) session.getAttribute("czyid");

//获取系统时间
String datestr=getSystemDate(0); 
boolean bflag = true;
String errMsg = "";
String sqlstr;
String uid="";
String order_number = "";
String arrive_date="";
String account_bank = "";
String acc_number="";
String client_accnumber = "";
String client_name = "";
String item_method = "";
String fact_money = "";
String summary = "";
String sn = "";
String ebdata_id = "";
double dalldata=0;
int iallcol=0;

String filePath;
String fileName = "";
String message = "";



//设定附件相对路径
String path = pageContext.getServletContext().getRealPath("/");
String allpath =path + "\\execl\\"+datestr+"\\";
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
String ebank_date = fileBean.getFieldValue("ebank_date");

int dateflag=0;
sqlstr="  select * from inter_finance_closeday where close_day>='"+ebank_date+"'";
ResultSet rsCloseday = db1.executeQuery(sqlstr); 
if(rsCloseday.next()){
	dateflag=1;
}

if(dateflag<1){
   if(saObjectFile!=null){
	for(int j=0;j<saObjectFile.length;j++){
		if(saObjectFile[j]!=null&&!saObjectFile[j].equals("")){
			execlBean.setExecl(allpath+saObjectFile[j]);
			if(execlBean.getFlag()){
				String [][]obj = execlBean.getObject();
				iallcol = obj.length;
				for(int row=0;row<obj.length;row++){
					String []objrow = obj[row];
					order_number = objrow[0];
					arrive_date=objrow[1];
					account_bank = objrow[2];
					acc_number=objrow[3];
					client_accnumber = objrow[4];
					client_name = objrow[5];
				//	item_method = objrow[6];
					fact_money = objrow[6];
					summary = objrow[7];
					sn = objrow[8];
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
						sqlstr = "select dbo.wybhsc('"+acc_number+"') as xh";
						System.out.println(sqlstr);
						ResultSet rs = db1.executeQuery(sqlstr); 
						if ( rs.next() ) {
							ebdata_id = getDBStr( rs.getString("xh") );
						}
						rs.close();
						if(ebdata_id!=null&&!ebdata_id.equals("")&&!ebdata_id.equals("null")){
							sqlstr = "insert into fund_ebank_data (ebdata_id,order_number,upload_date,arrive_date,account_bank,acc_number,client_accnumber,client_name,fact_money,summary,sn,creator,create_date,status,business_flag,tempfact_flag,evidence_flag) values (";
							sqlstr += "'"+ebdata_id+"'";
							sqlstr += ",'"+order_number+"'";
							sqlstr += ",'"+ebank_date+"'";
							sqlstr += ",'"+arrive_date+"'";
							sqlstr += ",'"+account_bank+"'";
							sqlstr += ",'"+acc_number+"'";
							sqlstr += ",'"+client_accnumber+"'";
							sqlstr += ",'"+client_name+"'";
							sqlstr += ",'"+fact_money+"'";
							sqlstr += ",'"+summary+"'";
							sqlstr += ",'"+sn+"'";
							sqlstr += ",'"+czy+"'";
							sqlstr += ",'"+datestr+"'";
							sqlstr += ",'有效'";
							sqlstr += ",'是'";
							sqlstr += ",'否'";
							sqlstr += ",'否'";
							sqlstr += ")";
							System.out.println(sqlstr);
							db.executeUpdate(sqlstr);
							if(fact_money!=null&&!fact_money.equals("")){
								dalldata += Double.parseDouble(fact_money);
							}
						}else{
							iallcol--;
							message+=order_number+";";
						}
//					}else{
//						sqlstr = "update fund_ebank_data set ";
//						sqlstr += " upload_date='"+ebank_date+"'";
//						sqlstr += ", arrive_date='"+arrive_date+"'";
//						sqlstr += ", account_bank='"+account_bank+"'";
//						sqlstr += ", acc_number='"+acc_number+"'";
//						sqlstr += ", client_accnumber='"+client_accnumber+"'";
//						sqlstr += ", client_name='"+client_name+"'";
//						sqlstr += ", fact_money='"+fact_money+"'";
//						sqlstr += ", summary='"+summary+"'";
//						sqlstr += ", sn='"+sn+"'";
//						sqlstr += ", modificator='"+czy+"'";
//						sqlstr += ", modify_date='"+datestr+"'";
//						sqlstr += " where order_number='"+order_number+"'";
//						System.out.println(sqlstr);
//						db.executeUpdate(sqlstr);
//					}
				} 
			}else{
				bflag = false;
				errMsg +=saObjectFile[j]+execlBean.getErrMsg()+";";
				execlBean.deleteFile(allpath+saObjectFile[j]);
			}
		}
	}
   }
}

db.close();
db1.close();

if(dateflag<1){
	if(bflag&&message.equals("")){
%>
<script>
			window.close();
			opener.alert("上传网银数据成功!本次共上传<%=iallcol%>条网银记录，总金额<%=formatNumberDoubleTwo(dalldata)%>");
			opener.location.reload();
		</script>
<%
	}else{
		System.out.println("message:"+message);
		if(message.equals("")){
%>
<script>
			window.close();
			opener.alert("上传网银数据失败,execl文件<%=errMsg%>数据格式错误");
			opener.location.reload();
		</script>
<%
		}else{
			message="序号"+message+"无法生成网银编号，请修改数据后单独上传";
			if(!bflag){
		%>
		<script>
				window.close();
				opener.alert("上传网银数据失败,execl文件<%=errMsg%>数据格式错误");
				opener.alert("<%=message%>");
				opener.location.reload();
			</script>
		<%
			}else{
				System.out.println(message+",本次共上传"+iallcol+"条网银记录，总金额"+formatNumberDoubleTwo(dalldata));
		%>
		<script>
				window.close();
				opener.alert("<%=message%>,本次共上传<%=iallcol%>条网银记录，总金额<%=formatNumberDoubleTwo(dalldata)%>");
				opener.location.reload();
		</script>
		<%
			}
		}
	}
}else{
%>
		<script>
				window.close();
				opener.alert("上传日期应大于最近一次的关帐日");
				opener.location.reload();
		</script>
<%
}
%>
<%if(null != db2){db2.close();}%>