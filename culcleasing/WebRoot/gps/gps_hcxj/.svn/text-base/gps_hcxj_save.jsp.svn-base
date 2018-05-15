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
String czyid=(String)session.getAttribute("czyid");
String savetype =getStr( request.getParameter("savetype") );

//获取系统时间
String datestr=getSystemDate(0); 
boolean bflag = true;
String hcpolling_id="";
String headquarters="";
String car_type="";
String car_no="";
String car_model="";
String sim_no="";
String province="";
String city="";
String address="";
String agents="";
String carservices_state="";
String polling_condition="";
String polling_date="";
String fall_time="";

String message  ="";
String sqlstr;
ResultSet rs=null;

if(!(savetype.equals("")||savetype==null)){//为非上传操作
	int fag=0;
	hcpolling_id = getStr( request.getParameter("czid") );
	headquarters = getStr( request.getParameter("headquarters") );
	car_type = getStr( request.getParameter("car_type") );
	car_no = getStr( request.getParameter("car_no") );
	car_model = getStr( request.getParameter("car_model") );
	sim_no = getStr( request.getParameter("sim_no") );
	province = getStr( request.getParameter("province") );
	city = getStr( request.getParameter("city") );
	address = getStr( request.getParameter("address") );
	agents = getStr( request.getParameter("agents") );
	carservices_state = getStr( request.getParameter("carservices_state") );
	polling_condition = getStr( request.getParameter("polling_condition") );
	polling_date = getStr( request.getParameter("polling_date") );
	fall_time = getStr( request.getParameter("fall_time") );
    if(savetype.equals("add")){		
	    message="添加GPS巡检报告";
		sqlstr="insert into hcexamine_info( headquarters,car_type,car_no,car_model,sim_no,province,city,address,agents,carservices_state,polling_condition,polling_date,fall_time) values ('"+headquarters+"','"+car_type+"','"+car_no+"','"+car_model+"','"+sim_no+"','"+province+"','"+city+"','"+address+"','"+agents+"','"+carservices_state+"','"+polling_condition+"','"+polling_date+"','"+fall_time+"')";
		fag=db.executeUpdate(sqlstr);
		db.close();
    }else if(savetype.equals("mod")){
		message="修改GPS巡检报告";
	   sqlstr="update hcexamine_info set  headquarters='"+headquarters+"',province='"+province+"',city='"+city+"',address='"+address+"',agents='"+agents+"',carservices_state='"+carservices_state+"',polling_condition='"+polling_condition+"',polling_date='"+polling_date+"',fall_time='"+fall_time+"' where  hcpolling_id='"+hcpolling_id+"'";
		fag=db.executeUpdate(sqlstr);
		db.close();
    }else if(savetype.equals("del")){
		message="删除GPS巡检报告";
		sqlstr="delete from hcexamine_details where  hcpolling_id='"+hcpolling_id+"'";
	    fag = db.executeUpdate(sqlstr);
	    sqlstr="delete from hcexamine_info where  hcpolling_id='"+hcpolling_id+"'";
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
		opener.window.location.href = "gps_hcxj_list.jsp";
		alert("<%=message%>成功!");
		this.close();
		</script>
		<%
	}	
}else{	//上传操作
	//String czy =(String) session.getAttribute("czid");
	String errMsg ="";
	int iallcol =0;
	String uid=czyid;
	String filePath;
	String fileName = "";
	//设定附件相对路径
	String path = pageContext.getServletContext().getRealPath("/");
	String allpath =path + "\\upload\\gps_hcxj\\"+datestr+"\\";
	fileBean.setObjectPath( allpath );
	//设定上传附件总体大小限制
	fileBean.setSize(8*1024*1024);
	//设定上传附件文件类型
	fileBean.setSuffix(".xls");
	//设定上传用户ID
	if ( ( czyid != null ) && ( !czyid.equals("") ) ) {
	  // uid=czyid.substring(7);
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
				try{
				String temp_data="";
				//对其他数据的读入,需要根据XSL文件想匹配
				temp_data=(String)obj[0][0];
				System.out.println(temp_data);
				temp_data=temp_data.substring(temp_data.indexOf("总 部")+4);
				headquarters=temp_data;//总部
				temp_data=(String)obj[0][4];
				System.out.println(temp_data);
				temp_data=temp_data.substring(temp_data.indexOf("车辆类型")+5);
				car_type=temp_data;//车辆类型
				temp_data=(String)obj[0][8];
				System.out.println(temp_data);
				temp_data=temp_data.substring(temp_data.indexOf("车牌号")+4);
				car_no=temp_data;//车牌号
				temp_data=(String)obj[1][4];
				System.out.println(temp_data);
				temp_data=temp_data.substring(temp_data.indexOf("车辆型号")+5);
				car_model=temp_data;//车辆型号
				temp_data=(String)obj[1][8];
				System.out.println(temp_data);
				temp_data=temp_data.substring(temp_data.indexOf("SIM卡号")+6);
				sim_no=temp_data;//SIM卡号
				temp_data=(String)obj[0][12];
				System.out.println(temp_data);
				temp_data=temp_data.substring(temp_data.indexOf("省份")+3);
				//此处应在根据temp_data查出省份代码
				province="1";//省份
				temp_data=(String)obj[1][12];
				System.out.println(temp_data);
				temp_data=temp_data.substring(temp_data.indexOf("到")+2);
				//此处应在根据temp_data查出城市代码
				city="1";//市
				temp_data=(String)obj[2][12];
				System.out.println(temp_data);
				//temp_data=temp_data.substring(temp_data.indexOf("城市")+1);
				address=temp_data;//区
				temp_data=(String)obj[1][0];
				System.out.println(temp_data);
				temp_data=temp_data.substring(temp_data.indexOf("代 理")+4);
				agents=temp_data;//代理商
				temp_data=(String)obj[3][0];
				System.out.println(temp_data);
				temp_data=temp_data.substring(temp_data.indexOf("车辆服务状态")+7);
				carservices_state = temp_data;//车辆服务状态 
				temp_data=(String)obj[2][8];
				System.out.println(temp_data);
				temp_data=temp_data.substring(temp_data.indexOf("巡检日期")+5);
				polling_date=temp_data;//巡检日期
				temp_data=(String)obj[2][4];
				System.out.println(temp_data);
				temp_data=temp_data.substring(temp_data.indexOf("巡检条件")+5);
				polling_condition = temp_data;//巡检条件 
				temp_data=(String)obj[3][4];
				System.out.println(temp_data);
				temp_data=temp_data.substring(temp_data.indexOf("巡检失败天数")+6,temp_data.length()-2);
				fall_time=formatNumberDoubleZero(temp_data);//巡检失败天数
				 sqlstr="select machine_type,model from vi_sim_no where sim_no='"+sim_no+"'";
				 rs = db.executeQuery(sqlstr);
				if(rs.next()){
					String machine_type=rs.getString("machine_type");
					String model=rs.getString("model");
				sqlstr="insert into hcexamine_info( headquarters,car_type,car_no,car_model,sim_no,province,city,address,agents,carservices_state,polling_condition,polling_date,fall_time) values ('"+headquarters+"','"+model+"','"+car_no+"','"+machine_type+"','"+sim_no+"','"+province+"','"+city+"','"+address+"','"+agents+"','"+carservices_state+"','"+polling_condition+"','"+polling_date+"','"+fall_time+"')";
				int fag=0;
				System.out.println(sqlstr);
				fag=db.executeUpdate(sqlstr);
				if(fag!=0){
					sqlstr="select @@identity as id";
					rs = db.executeQuery(sqlstr);
					rs.next();
					hcpolling_id=getDBStr( rs.getString("id") );
					rs.close();
					iallcol=0;
					for(int row=5;row<obj.length;row++){//循环读取巡检报告明细
					  String []objrow = obj[row];
					  car_no=objrow[0];//车牌号
					  sim_no = formatNumberDoubleZero(objrow[1])+"";//SIM卡号
					  agents=(String)objrow[2];//代理商
					  polling_date = (String)objrow[3];//日期
					  String longitude = (String)objrow[4];//经度
					  String latitude=(String)objrow[5];//纬度
					  String speed = (String)objrow[6];//速度
					  String worktime = (String)objrow[7];//累计工作小时数
					  String state = (String)objrow[8];//状态
					  String lock_state = (String)objrow[9];//锁车状态
					  String fixed_state = (String)objrow[10];//定位状态
					  String online_time = (String)objrow[14];//入网时间
					  String services_endtime = (String)objrow[15];//服务截止时间
					  sqlstr="select sim_no from examine_info where sim_no='"+sim_no+"'";
					  rs = db.executeQuery(sqlstr);
					  if(rs.next()){
						  sqlstr="insert into hcexamine_details( hcpolling_id,cai_no,sim_no,agents,polling_date,longitude,latitude,speed,worktime,state,lock_state,fixed_state,online_time,services_endtime) values ('"+hcpolling_id+"','"+car_no+"','"+sim_no+"','"+agents+"','"+polling_date+"','"+longitude+"','"+latitude+"','"+speed+"','"+worktime+"','"+state+"','"+lock_state+"','"+fixed_state+"','"+online_time+"','"+services_endtime+"')";
					      fag=db.executeUpdate(sqlstr);
					 	  if(fag!=0){	
						     iallcol++;
						  }
					  }else{
						  errMsg+=sim_no+"卡号不存在!";
					  }
					}
				}else{
					 bflag = false;
				}
				}else{
					errMsg+=sim_no+"卡号不存在!";
				}
				}catch(Exception e){
					bflag = false;
					System.out.println(e.toString());
					System.out.println("巡检异常的车辆统计导入失败,可能是数据格式错误!");
					errMsg="导入失败,可能是数据格式错误!(可参考的错误信息:"+e.toString()+")";
					sqlstr="delete from hcexamine_info where hcpolling_id='"+hcpolling_id+"'";
					db1.executeUpdate(sqlstr);
					sqlstr="delete from hcexamine_details where hcpolling_id='"+hcpolling_id+"'";
					db1.executeUpdate(sqlstr);
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
		opener.window.location.href = "gps_hcxj_list.jsp";
		this.close();
	</script>
	<%
}
%>