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
//导入项
String tzpolling_id = "";
String polling_date="";
String right_num="";
String fall_num = "";
String import_date="";

String message  ="";
String sqlstr;
ResultSet rs=null;

if(!(savetype.equals("")||savetype==null)){//为非上传操作
	int fag=0;
	tzpolling_id = getStr( request.getParameter("czid") );
	polling_date = getStr( request.getParameter("polling_date") );
	right_num = getStr( request.getParameter("right_num") );
	fall_num = getStr( request.getParameter("fall_num") );
	import_date = getStr( request.getParameter("import_date") );
    if(savetype.equals("add")){		
	    message="添加GPS巡检报告";
		sqlstr="insert into tzexamine_info( polling_date,right_num,fall_num,import_date,importer) values ('"+polling_date+"','"+right_num+"','"+fall_num+"','"+datestr+"','"+czyid+"')";
		System.out.println(sqlstr);
		fag=db.executeUpdate(sqlstr);
		db.close();
    }else if(savetype.equals("mod")){
		message="修改GPS巡检报告";
	   sqlstr="update tzexamine_info set  polling_date='"+polling_date+"',right_num='"+right_num+"',fall_num='"+fall_num+"' where  tzpolling_id='"+tzpolling_id+"'";
		fag=db.executeUpdate(sqlstr);
		db.close();
    }else if(savetype.equals("del")){
		message="删除GPS巡检报告";
		sqlstr="delete from tzexamine_details where  tzpolling_id='"+tzpolling_id+"'";
	    fag = db.executeUpdate(sqlstr);
	    sqlstr="delete from tzexamine_info where  tzpolling_id='"+tzpolling_id+"'";
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
		opener.window.location.href = "gps_tzxj_list.jsp";
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
	String allpath =path + "\\upload\\gps_tzxj\\"+datestr+"\\";
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
		System.out.print(allpath+saObjectFile[j]+"!!");
			execlBean.setExecl(allpath+saObjectFile[j]);
			if(execlBean.getFlag()){
				String [][]obj = execlBean.getObject();
				try{
				  String temp=(String)obj[0][0];//A2单元格数据 其个格式为 "     2009年11月05日巡检情况      入网车辆：1193辆  巡检失败：57辆"
				  //System.out.println(temp);
				  int temp_star=temp.indexOf("入网车辆");
				  int temp_end=temp.indexOf("辆",temp_star+4);
				  right_num=temp.substring(temp_star+5,temp_end);//入网车辆
				  System.out.print("入网车辆"+right_num);
				  temp_star=temp.indexOf("巡检失败",temp_end);
				  temp_end=temp.indexOf("辆",temp_star);
				  fall_num=temp.substring(temp_star+5,temp_end);//巡检失败车辆
				  System.out.print("巡检失败车辆"+fall_num);
				  temp_end=temp.indexOf("年");
				  String year_t=temp.substring(temp_end-4,temp_end);
				  temp_end=temp.indexOf("月");
				  String month_t=temp.substring(temp_end-2,temp_end);
				  temp_end=temp.indexOf("日");
				  String day_t=temp.substring(temp_end-2,temp_end);
				  polling_date=year_t+"-"+month_t+"-"+day_t;
				  sqlstr="insert into tzexamine_info( polling_date,right_num,fall_num,import_date,importer) values ('"+polling_date+"','"+right_num+"','"+fall_num+"','"+datestr+"','"+czyid+"')";
				  System.out.println("===scl====="+sqlstr);
				  int fag=0;
				  fag=db.executeUpdate(sqlstr);
				  if(fag!=0){
					  System.out.println("明细导入!");
					  //iallcol++;
					  sqlstr="select @@identity as id";
					  rs = db.executeQuery(sqlstr);
					  if(rs.next()){
					  tzpolling_id=getDBStr( rs.getString("id") );
					  }
					  rs.close();
					  for(int row=3;row<obj.length;row++){//循环读取巡检报告明细
						  String []objrow = obj[row];
						  String gpstpye=objrow[1];//GPS型号
						  String sim_no = formatNumberDoubleZero(objrow[3]);//SIM卡号
						 /* String cai_no = formatNumberDoubleZero(objrow[2]);//车牌号
						  if(cai_no==""){
							  cai_no=objrow[2];
						  }*/
						  String cai_no=objrow[2];
						  import_date=objrow[4];//巡检日期
						  String province=objrow[5];//省
						  String city = objrow[6];//市
						  String address = objrow[7];//区
						  String state=objrow[8];//状态
						  String cusname = objrow[9];//客户名称
						  String branch_company=objrow[10];//分公司
						 /* //查找城市ID
						  sqlstr="select id from jb_csxx where csmc='"+city+"'";
						  rs=db1.executeQuery(sqlstr);
						  rs.next();
						  city=getDBStr( rs.getString("id") );
						  rs.close();
						  */
					 sqlstr="select cust_id,sale_id from vi_sim_no where sim_no='"+sim_no+"'";
					  System.out.println(sqlstr);
					  rs = db.executeQuery(sqlstr);
					  if(rs.next()){						  
						  sqlstr="insert into tzexamine_details( tzpolling_id,gpstpye,cai_no,sim_no,import_date,province,city,address,state,cusname,branch_company) values ('"+tzpolling_id+"','"+gpstpye+"','"+cai_no+"','"+sim_no+"','"+import_date+"','"+province+"','"+city+"','"+address+"','"+state+"','"+rs.getString("cust_id")+"','"+rs.getString("sale_id")+"');";
						  System.out.print(sqlstr);
						  fag=db.executeUpdate(sqlstr);
						  //if(fag!=0){
						  	iallcol=iallcol+1;
						  //}
					  }else{
						 errMsg+=sim_no+"不存在!";
					  }
					  }					  
				  }else{
					  bflag = false;
				  }
				}catch(Exception e){
					bflag = false;
					System.out.println(e.toString());
					errMsg+="导入失败,可能是数据格式错误!(可参考错误信息:"+e.toString()+")";
					//数据回滚
					sqlstr="delete from tzexamine_info where tzpolling_id='"+tzpolling_id+"'";
					db1.executeUpdate(sqlstr);
					sqlstr="delete from tzexamine_details where tzpolling_id='"+tzpolling_id+"'";
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
		opener.window.location.href = "gps_tzxj_list.jsp";
		this.close();
	</script>
	<%
}
%>