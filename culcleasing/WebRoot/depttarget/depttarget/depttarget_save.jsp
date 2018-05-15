<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*" %> 
<%@ page import="com.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ include file="../../func/common.jsp"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<link href="../../css/global.css" rel="stylesheet" type="text/css">
</head>

<BODY>
<%
String sqlstr;
ResultSet rs;
String dqczy = (String) session.getAttribute("czyid");
String curr_date = getSystemDate(0);
String czid = getStr( request.getParameter("czid") );
String stype = getStr( request.getParameter("savetype") );

String target_year = getStr( request.getParameter("target_year") );
String dept_id = getStr( request.getParameter("dept_id") );
String target_1_asset = getStr( request.getParameter("target_1_asset") ).replaceAll(",","");target_1_asset=target_1_asset.equals("")?"0":target_1_asset;
String target_1_corpus = getStr( request.getParameter("target_1_corpus") ).replaceAll(",","");target_1_corpus=target_1_corpus.equals("")?"0":target_1_corpus;
String target_2_asset = getStr( request.getParameter("target_2_asset") ).replaceAll(",","");target_2_asset=target_2_asset.equals("")?"0":target_2_asset;
String target_2_corpus = getStr( request.getParameter("target_2_corpus") ).replaceAll(",","");target_2_corpus=target_2_corpus.equals("")?"0":target_2_corpus;
String target_3_asset = getStr( request.getParameter("target_3_asset") ).replaceAll(",","");target_3_asset=target_3_asset.equals("")?"0":target_3_asset;
String target_3_corpus = getStr( request.getParameter("target_3_corpus") ).replaceAll(",","");target_3_corpus=target_3_corpus.equals("")?"0":target_3_corpus;
String target_4_asset = getStr( request.getParameter("target_4_asset") ).replaceAll(",","");target_4_asset=target_4_asset.equals("")?"0":target_4_asset;
String target_4_corpus = getStr( request.getParameter("target_4_corpus") ).replaceAll(",","");target_4_corpus=target_4_corpus.equals("")?"0":target_4_corpus;
String target_5_asset = getStr( request.getParameter("target_5_asset") ).replaceAll(",","");target_5_asset=target_5_asset.equals("")?"0":target_5_asset;
String target_5_corpus = getStr( request.getParameter("target_5_corpus") ).replaceAll(",","");target_5_corpus=target_5_corpus.equals("")?"0":target_5_corpus;
String target_6_asset = getStr( request.getParameter("target_6_asset") ).replaceAll(",","");target_6_asset=target_6_asset.equals("")?"0":target_6_asset;
String target_6_corpus = getStr( request.getParameter("target_6_corpus") ).replaceAll(",","");target_6_corpus=target_6_corpus.equals("")?"0":target_6_corpus;
String target_7_asset = getStr( request.getParameter("target_7_asset") ).replaceAll(",","");target_7_asset=target_7_asset.equals("")?"0":target_7_asset;
String target_7_corpus = getStr( request.getParameter("target_7_corpus") ).replaceAll(",","");target_7_corpus=target_7_corpus.equals("")?"0":target_7_corpus;
String target_8_asset = getStr( request.getParameter("target_8_asset") ).replaceAll(",","");target_8_asset=target_8_asset.equals("")?"0":target_8_asset;
String target_8_corpus = getStr( request.getParameter("target_8_corpus") ).replaceAll(",","");target_8_corpus=target_8_corpus.equals("")?"0":target_8_corpus;
String target_9_asset = getStr( request.getParameter("target_9_asset") ).replaceAll(",","");target_9_asset=target_9_asset.equals("")?"0":target_9_asset;
String target_9_corpus = getStr( request.getParameter("target_9_corpus") ).replaceAll(",","");target_9_corpus=target_9_corpus.equals("")?"0":target_9_corpus;
String target_10_asset = getStr( request.getParameter("target_10_asset") ).replaceAll(",","");target_10_asset=target_10_asset.equals("")?"0":target_10_asset;
String target_10_corpus = getStr( request.getParameter("target_10_corpus") ).replaceAll(",","");target_10_corpus=target_10_corpus.equals("")?"0":target_10_corpus;
String target_11_asset = getStr( request.getParameter("target_11_asset") ).replaceAll(",","");target_11_asset=target_11_asset.equals("")?"0":target_11_asset;
String target_11_corpus = getStr( request.getParameter("target_11_corpus") ).replaceAll(",","");target_11_corpus=target_11_corpus.equals("")?"0":target_11_corpus;
String target_12_asset = getStr( request.getParameter("target_12_asset") ).replaceAll(",","");target_12_asset=target_12_asset.equals("")?"0":target_12_asset;
String target_12_corpus = getStr( request.getParameter("target_12_corpus") ).replaceAll(",","");target_12_corpus=target_12_corpus.equals("")?"0":target_12_corpus;



int flag=0;
String message="";
String reFlag_add="";
String reFlag_mod="";


if ( stype.equals("add") ){
	
	sqlstr="select * from base_dept_target where target_year="+target_year+" and dept_id='"+dept_id+"'";
	rs=db.executeQuery(sqlstr);
	if(rs.next()){
		reFlag_add="1";
	}rs.close();
	message="添加部门经营指标";
	if(reFlag_add.equals("")){
		sqlstr="insert into base_dept_target (target_year,dept_id,target_1_asset,target_1_corpus,target_2_asset,target_2_corpus,target_3_asset,target_3_corpus,target_4_asset,target_4_corpus,target_5_asset,target_5_corpus,target_6_asset,target_6_corpus,target_7_asset,target_7_corpus,target_8_asset,target_8_corpus,target_9_asset,target_9_corpus,target_10_asset,target_10_corpus,target_11_asset,target_11_corpus,target_12_asset,target_12_corpus) values("+target_year+",'"+dept_id+"',"+target_1_asset+","+target_1_corpus+","+target_2_asset+","+target_2_corpus+","+target_3_asset+","+target_3_corpus+","+target_4_asset+","+target_4_corpus+","+target_5_asset+","+target_5_corpus+","+target_6_asset+","+target_6_corpus+","+target_7_asset+","+target_7_corpus+","+target_8_asset+","+target_8_corpus+","+target_9_asset+","+target_9_corpus+","+target_10_asset+","+target_10_corpus+","+target_11_asset+","+target_11_corpus+","+target_12_asset+","+target_12_corpus+")";
		flag = db.executeUpdate(sqlstr);
	}else{
		%>
		<script>
			history.back(-1);
			alert("<%=message%>失败,部门年份不能重复!");
		</script>
		<%
	}
}
if ( stype.equals("mod") ){ 
	
	sqlstr="select * from base_dept_target where target_year="+target_year+" and dept_id='"+dept_id+"' and id<>"+czid;
	rs=db.executeQuery(sqlstr);
	if(rs.next()){
		reFlag_mod="1";
	}rs.close();
	message="修改部门经营指标";
	if(reFlag_mod.equals("")){
		sqlstr="update base_dept_target set target_year="+target_year+",dept_id='"+dept_id+"',target_1_asset="+target_1_asset+",target_1_corpus="+target_1_corpus+",target_2_asset="+target_2_asset+",target_2_corpus="+target_2_corpus+",target_3_asset="+target_3_asset+",target_3_corpus="+target_3_corpus+",target_4_asset="+target_4_asset+",target_4_corpus="+target_4_corpus+",target_5_asset="+target_5_asset+",target_5_corpus="+target_5_corpus+",target_6_asset="+target_6_asset+",target_6_corpus="+target_6_corpus+",target_7_asset="+target_7_asset+",target_7_corpus="+target_7_corpus+",target_8_asset="+target_8_asset+",target_8_corpus="+target_8_corpus+",target_9_asset="+target_9_asset+",target_9_corpus="+target_9_corpus+",target_10_asset="+target_10_asset+",target_10_corpus="+target_10_corpus+",target_11_asset="+target_11_asset+",target_11_corpus="+target_11_corpus+",target_12_asset="+target_12_asset+",target_12_corpus="+target_12_corpus+" where id="+czid;
		//System.out.println("sqlstr======================"+sqlstr);
		flag = db.executeUpdate(sqlstr);
	}else{
		%>
		<script>
			history.back(-1);
			alert("<%=message%>失败,部门年份不能重复!");
		</script>
		<%
	}
	
}
if ( stype.equals("del") ){ 
	sqlstr="delete from base_dept_target where id="+czid;
	flag = db.executeUpdate(sqlstr);
	message="删除部门经营指标";
}
if(flag!=0){
%>
<script>
			window.close();
			opener.alert("<%=message%>成功!");
			opener.location.reload();
		</script>
<%
}db.close();
%>