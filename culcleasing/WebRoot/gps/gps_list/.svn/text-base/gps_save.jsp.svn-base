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
String savetype =getStr( request.getParameter("savetype") );

//获取系统时间
String datestr=getSystemDate(0); 
boolean bflag = true;
String machine_type = "";
String machine_no="";
String sim_no="";
String gps_terminal_type = "";
String gps_index_type = "";
String install_date="";

String gpsinfo_id = "";
String contract_id = "";
String car_group="";
String service_begindate = "";
String service_enddate = "";
String renewals_enddate1 = "";
String renewals_enddate2 = "";
String location_test = "";
String remote_Control_test = "";
String acc_statistics = "";
String polling_state = "";
String billable_date1="";
String billable_date2 = "";
String billable_date3 = "";
String stop_record = "";
String stop_reason = "";
String relief_record = "";
String gps_right = "";
String dismantle = "";
String dismantle_date = "";
String remark = "";

String message  ="";
String sqlstr;
ResultSet rs=null;
String nulls="null";
if(!(savetype.equals("")||savetype==null)){//为非上传操作
	int fag=0;
	gpsinfo_id = getStr( request.getParameter("gpsinfo_id") );
	contract_id = getStr( request.getParameter("contract_id") );
	machine_type = getStr( request.getParameter("machine_type") );
	machine_no = getStr( request.getParameter("machine_no") );
	sim_no = getStr( request.getParameter("sim_no") );
	gps_terminal_type = getStr( request.getParameter("gps_terminal_type") );
	gps_index_type = getStr( request.getParameter("gps_index_type") );
	install_date = getStr( request.getParameter("install_date") );
	car_group = getStr( request.getParameter("car_group") );
	service_begindate = getStr( request.getParameter("service_begindate") );
	service_begindate=service_begindate.equals("")?nulls:"'"+service_begindate+"'";
	service_enddate = getStr( request.getParameter("service_enddate") );
	service_enddate=service_enddate.equals("")?nulls:"'"+service_enddate+"'";
	renewals_enddate1 = getStr( request.getParameter("renewals_enddate1") );
	renewals_enddate1=renewals_enddate1.equals("")?nulls:"'"+renewals_enddate1+"'";
	renewals_enddate2 = getStr( request.getParameter("renewals_enddate2") );
	renewals_enddate2=renewals_enddate2.equals("")?nulls:"'"+renewals_enddate2+"'";
	location_test = getStr( request.getParameter("location_test") );
	remote_Control_test = getStr( request.getParameter("remote_Control_test") );
	acc_statistics = getStr( request.getParameter("acc_statistics") );
	polling_state = getStr( request.getParameter("polling_state") );
	billable_date1 = getStr( request.getParameter("billable_date1") );
	billable_date1=billable_date1.equals("")?nulls:"'"+billable_date1+"'";
	billable_date2 = getStr( request.getParameter("billable_date2") );
	billable_date2=billable_date2.equals("")?nulls:"'"+billable_date2+"'";
	billable_date3 = getStr( request.getParameter("billable_date3") );
	billable_date3=billable_date3.equals("")?nulls:"'"+billable_date3+"'";
	stop_record = getStr( request.getParameter("stop_record") );
	stop_reason = getStr( request.getParameter("stop_reason") );
	relief_record = getStr( request.getParameter("relief_record") );
	gps_right = getStr( request.getParameter("gps_right") );
	dismantle = getStr( request.getParameter("dismantle") );
	dismantle_date = getStr( request.getParameter("dismantle_date") );
	remark = getStr( request.getParameter("remark") );
	//根据机编号查找合同编号
	sqlstr="select contract_id from contract_equip where equip_sn='"+machine_no+"'";
	rs=db1.executeQuery(sqlstr);
	if(rs.next()){
		contract_id = getDBStr( rs.getString("contract_id") );
	}
	rs.close();
    if(savetype.equals("add")){		
	    message="添加GPS";
		sqlstr="insert into examine_info( contract_id,machine_type,machine_no,sim_no,gps_terminal_type,gps_index_type,install_date,car_group,service_begindate,service_enddate,renewals_enddate1,renewals_enddate2,location_test,remote_Control_test,acc_statistics,polling_state,billable_date1,billable_date2,billable_date3,stop_record,stop_reason,relief_record,gps_right,dismantle,dismantle_date,remark) values ('"+contract_id+"','"+machine_type+"','"+machine_no+"','"+sim_no+"','"+gps_terminal_type+"','"+gps_index_type+"','"+install_date+"','"+car_group+"','"+service_begindate+"',"+service_enddate+","+renewals_enddate1+","+renewals_enddate2+",'"+location_test+"','"+remote_Control_test+"','"+acc_statistics+"','"+polling_state+"',"+billable_date1+","+billable_date2+","+billable_date3+",'"+stop_record+"','"+stop_reason+"','"+relief_record+"','"+gps_right+"','"+dismantle+"','"+dismantle_date+"','"+remark+"');";
		System.out.println(sqlstr);
		fag=db.executeUpdate(sqlstr);
		db.close();
    }else if(savetype.equals("mod")){
		message="修改GPS";
		sqlstr="select equip_sn from contract_equip where equip_sn='"+machine_no+"'";
		rs = db.executeQuery(sqlstr); 
		if (rs.next()){
					sqlstr="select sim_no from examine_info where sim_no='"+sim_no+"' and gpsinfo_id<>'"+gpsinfo_id+"'";
					System.out.println(sqlstr);
					rs=db1.executeQuery(sqlstr);
					if(rs.next()){
						message="SIM卡号已存在!修改GPS相关信息";
					}else{
	 	 				 sqlstr="update examine_info set sim_no='"+sim_no+"',gps_terminal_type='"+gps_terminal_type+"',machine_no='"+machine_no+"',gps_index_type='"+gps_index_type+"',install_date='"+install_date+"',car_group='"+car_group+"',service_begindate="+service_begindate+",service_enddate="+service_enddate+",renewals_enddate1="+renewals_enddate1+",renewals_enddate2="+renewals_enddate2+",location_test='"+location_test+"',remote_Control_test='"+remote_Control_test+"',acc_statistics='"+acc_statistics+"',polling_state='"+polling_state+"',billable_date1="+billable_date1+",billable_date2="+billable_date2+",billable_date3="+billable_date3+",stop_record='"+stop_record+"',stop_reason='"+stop_reason+"',relief_record='"+relief_record+"',gps_right='"+gps_right+"',dismantle='"+dismantle+"',dismantle_date='"+dismantle_date+"',remark='"+remark+"' where  gpsinfo_id='"+gpsinfo_id+"'";
						 System.out.println(sqlstr);
						fag=db.executeUpdate(sqlstr);
					}
		}else{
			message="机编号不存在!修改GPS相关信息";
		}
		db.close();
    }else if(savetype.equals("del")){
		message="删除GPS";
	    sqlstr="delete from examine_info where  gpsinfo_id='"+gpsinfo_id+"'";
	    fag = db.executeUpdate(sqlstr);
		db.close();
    }
	if(fag==0){
		%>
        <script>
		alert("<%=message%>失败!");
		opener.location.reload();
		this.close();
		</script>
		<%		
	}else{
		%>
        <script>
		opener.window.location.href = "gps_list.jsp";
		alert("<%=message%>成功!");
		this.close();
		</script>
		<%
	}	
}else{	//上传操作
	String czy =(String) session.getAttribute("czid");
	String errMsg ="";
	int iallcol =0;
	String uid=czy;
	String filePath;
	String fileName = "";
	//设定附件相对路径
	String path = pageContext.getServletContext().getRealPath("/");
	String allpath =path + "\\upload\\gps_list\\"+datestr+"\\";
	fileBean.setObjectPath( allpath );
	//设定上传附件总体大小限制
	fileBean.setSize(8*1024*1024);
	//设定上传附件文件类型
	fileBean.setSuffix(".xls");
	//设定上传用户ID
	if ( ( czy != null ) && ( !czy.equals("") ) ) {
	   //uid=czy.substring(7);
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
				boolean insert=true;
				for(int row=1;row<obj.length;row++){
					String []objrow = obj[row];
					//gpsinfo_id=String.valueOf(Integer.parseInt(objrow[0].toString()));
					//gpsinfo_id=formatNumberDoubleZero(objrow[0]);//ID作为自增列不进行读取\
					//对其他数据的读入,需要根据XSL文件想匹配
					//machine_type = objrow[1];//设备型号
					machine_type=formatNumberDoubleZero(machine_type);
					if(machine_type==""){
						machine_type=objrow[1];
					}
					machine_no=objrow[2];//机编号
					sim_no = formatNumberDoubleZero(objrow[3]);//SIM卡号
					install_date = objrow[4];//安装日期
					if(sim_no==""||sim_no.equals("")){
						errMsg+="\\n第"+row+"行数据SIM卡号为空!! ";
						insert=false;
					}else{
						if(machine_no==""||machine_no.equals("")){
							errMsg+="\\n第"+row+"行数据机编号为空!";
							insert=false;
						}else{
						//根据机编号查找合同编号
							sqlstr="select contract_id from contract_equip where equip_sn='"+machine_no+"'";
							System.out.println(sqlstr);
							rs=db1.executeQuery(sqlstr);
							if(rs.next()){
								contract_id = getDBStr( rs.getString("contract_id") );
								rs.close();
								sqlstr="select device_type as machine_type from contract_equip where contract_id='"+contract_id+"'";
								System.out.println(sqlstr);
								rs=db1.executeQuery(sqlstr);
								if(rs.next()){
									machine_type=getDBStr( rs.getString("machine_type") );//设备型号
								}
								rs.close();
							}else{
								errMsg+="\\nSIM卡号为:"+sim_no+"(机编号为:"+machine_no+")没有找到对应的合同!";
								insert=false;
							}
						}
					}
					sqlstr="select machine_no from examine_info where machine_no='"+machine_no+"'";
					System.out.println(sqlstr);
					rs=db1.executeQuery(sqlstr);
					if(rs.next()){
						errMsg+="\\nSIM卡号为:"+sim_no+"(机编号为:"+machine_no+")的信息以在数据库中以存在,(机编号已存在)!";
						insert=false;
					}
					rs.close();
					sqlstr="select sim_no from examine_info where sim_no='"+sim_no+"'";
					System.out.println(sqlstr);
					rs=db1.executeQuery(sqlstr);
					if(rs.next()){
						errMsg+="\\nSIM卡号为:"+sim_no+"(机编号为:"+machine_no+")的信息以在数据库中以存在,(SIM卡号重复)!";
						insert=false;
					}
					rs.close();
					if(insert){
						sqlstr="insert into examine_info( machine_type,machine_no,sim_no,install_date,gps_terminal_type,contract_id) values ('"+machine_type+"','"+machine_no+"','"+sim_no+"','"+install_date+"','"+gps_terminal_type+"','"+contract_id+"')";
						System.out.print(sqlstr);
						int fag=0;
						fag=db.executeUpdate(sqlstr);
						 if(fag!=0){iallcol++;}
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
    db1.close();
	if(bflag&&message.equals("")){
	%>
	<script>
	window.close();
	alert("数据已成功读取!本次共上传<%=iallcol%>条GPS记录!");
	<%
	if(errMsg!=""||(!errMsg.equals(""))){
		%>
		alert("但是其中某些数据出现了如下错误:<%=errMsg%>");
		<%
	}
	%>
	opener.location.reload();
	</script>
	<%
	}else{
		
		System.out.println("message:"+message);
	%>
	<script>
	window.close();
	alert("上传数据失败,execl文件<%=errMsg%>数据格式错误");
	opener.location.reload();
	</script>
	<%
	}
	%>
    <script>
		opener.window.location.href = "gps_list.jsp";
		this.close();
	</script>
	<%
}
%>