<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="java.sql.*" %>
<%@ page import="dbconn.*" %>
<%@ page import="java.io.File" %>
<%@ page import="com.container.*" %>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" />
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
String order_number = "";//序号
String arrive_date="";//到帐时间
String account_bank = "";//到帐银行
String acc_number="";//本方账号
String client_accnumber = "";//对方账号
String client_name = "";//对方单位
String fact_money = "";//金额
String summary = "";//摘要
String sn = "";//流水号
String ebdata_id="";//网银编号
String  sn_mes="";
ResultSet rs ;

int iallcol=0;

String filePath;
String fileName = "";
String message = "";

//设定附件相对路径
	String path = pageContext.getServletContext().getRealPath("/");
	String allpath =path + "\\upload\\wydr\\"+datestr+"\\";
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
	fileBean.setSourceFile(request);//文件上传
	String [] saSourceFile = fileBean.getSourceFile();
	String [] saObjectFile = fileBean.getObjectFileName();
	String [] saDescription = fileBean.getDescription();
	int iCount = fileBean.getCount();
	String sObjectPath = fileBean.getObjectPath();
    if(saObjectFile!=null){
	  for(int j=0;j<saObjectFile.length;j++){
		if(saObjectFile[j]!=null&&!saObjectFile[j].equals("")){ 
		System.out.print(allpath+saObjectFile[j]);
			execlBean.setExecl(allpath+saObjectFile[j]);
			if(execlBean.getFlag()){
				String [][]obj = execlBean.getObject();
				for(int row=0;row<obj.length;row++){
					try{
						String []objrow = obj[row];
						order_number=formatNumberDoubleZero(objrow[0]);
						arrive_date=objrow[1];
						account_bank=objrow[2];
						acc_number=formatNumberDoubleZero(objrow[3]);
						client_accnumber=formatNumberDoubleZero(objrow[4]);
						client_name=objrow[5];
						fact_money=formatNumberDoubleTwo(objrow[6]);
						summary=objrow[7];
						sn=formatNumberDoubleZero(objrow[8]);
						sqlstr="select sn from fund_ebank_data where sn='"+sn+"'";
						rs = db.executeQuery(sqlstr); 
						if ( rs.next() ) {
							sn_mes+=sn+",";
							continue;
						}
						//构建网银ID开始
						sqlstr = "select top 1  ebdata_id from fund_ebank_data order by ebdata_id desc";
						System.out.println(sqlstr);
						String temp_id="";
						String temp_date=datestr.replaceAll("-", "");//截取出年月日并去掉中间的-符号continue
						rs = db.executeQuery(sqlstr); 
						if ( rs.next() ) {
							temp_id = getDBStr( rs.getString("ebdata_id") );//获得最近一个产生的ID
						}
						rs.close();
						if ( ( temp_id == null ) || ( temp_id.equals("") ) ) {
							//这种情况表示数据库还没数据
							temp_id = temp_date + "0001";
						} else {
							//获得上一个ID的产生日期
							String old_date=temp_id.substring(0,8);
							if(old_date.equals(temp_date)){//同一天的数据插入则累加位数
								//获得上一次产生的ID的尾数号(4位)
								int temp_num=Integer.parseInt("1"+temp_id.substring(temp_id.length()-4,temp_id.length()));//为了转换是前面的零不丢失在数字前加1;
								temp_num++;//数字自加
								temp_id=String.valueOf(temp_num).substring(1);//获取后四位数字
								temp_id=String.valueOf(temp_date+temp_id);//完整取得ID
							}else{//不是同一天的数据从1开始加
								temp_id=temp_date+"0001";
							}
						}
						ebdata_id=temp_id;
						//构建网银ID结束
						sqlstr="insert into fund_ebank_data (ebdata_id,order_number,upload_date,arrive_date,account_bank,acc_number,client_name,client_accnumber,fact_money,summary,sn) values ('"+ebdata_id+"','"+order_number+"','"+datestr+"','"+arrive_date+"','"+account_bank+"','"+acc_number+"','"+client_name+"','"+client_accnumber+"','"+fact_money+"','"+summary+"','"+sn+"')";
						int fag=0;
						fag=db.executeUpdate(sqlstr); 
						if(fag!=0){
							iallcol++;
						}
						if(!(sn_mes.equals("")||sn_mes=="")){
							sn_mes=sn_mes.substring(0,sn_mes.length()-1);
							errMsg+="流水号为:"+sn_mes+"的网银数据已经存在!";
						}
					}catch(Exception e){
							bflag = false;
							message+="\\n导入文件错误!请确认此文件的数据格式正确!";
							break;
					}
				}
			}else{
				bflag = false;
				errMsg +=saObjectFile[j]+execlBean.getErrMsg()+";";
				execlBean.deleteFile(allpath+saObjectFile[j]);
			}
		 }
	  }
    }
	
    db.close();
	if(bflag&&message.equals("")){
		%>
<script>
		alert("上传数据成功!本次共上传<%=iallcol%>条网银记录");
		<%
		if(errMsg!=""||(!errMsg.equals(""))){
			%>
			alert("但是其中某些数据出现了如下错误:<%=errMsg%>");
			<%
		}
	}else{
		
		System.out.println("message:"+message);
	%>
	<script>
	alert("上传网银数据失败,可能的原因:<%=message%>");
	opener.location.reload();
	<%
	}
	%>
		opener.location.reload();
		this.close();
	</script>
<%
%>