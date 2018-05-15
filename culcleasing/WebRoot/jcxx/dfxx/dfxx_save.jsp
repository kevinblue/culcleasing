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
String dqczy = (String) session.getAttribute("czyid");
String evaluation_type = getStr( request.getParameter("czid") );

String target_id = getStr( request.getParameter("target_id") );
String doc_id = getStr( request.getParameter("doc_id") );
String order_number = "";
String item = "";
String []item_id = (String[]) request.getParameterValues("item_id") ;
String stype = getStr( request.getParameter("savetype") );
String standard_id = "";
String weighting_score = "";
String standard = "";
String disp_name = "";
String value = "";
String veto_flag = "";
String weighting = "";
String sqlstr;
ResultSet rs;
ResultSet rsSt ;
String datestr = getSystemDate(1); //获取系统时间
boolean flag = true;
//调整
String []adjust_item_id = (String[]) request.getParameterValues("adjust_item_id") ;
String adjust_score = "";
String adjust_order_number = "";
String other_condition = "";
String comment = "";
String comment_value = "";
if ( stype.equals("mod") ){      //修改操作
		sqlstr="delete from base_evaluation_score where evaluation_type="+evaluation_type+" and target_id='"+target_id+"' and doc_id='"+doc_id+"'";
		System.out.println("sqlstrsqlstr=="+sqlstr);
		db.executeUpdate(sqlstr);
		for(int i=0;i<item_id.length;i++){
			if(item_id[i]!=null&&!item_id[i].equals("")){
				sqlstr = "select * from base_evaluation_model where item_id="+item_id[i];
				System.out.println("sqlstrsqlstr=="+sqlstr);
				rs = db.executeQuery(sqlstr);
				if(rs.next()){
					item = getDBStr(rs.getString("item"));
					order_number = getDBStr(rs.getString("order_number"));
					weighting = getDBStr(rs.getString("weighting"));
				}
				rs.close();
				standard_id = getStr(request.getParameter("var_"+item_id[i]+"_standard"));
				weighting_score = getStr(request.getParameter("var_"+item_id[i]+"_weighting_score"));
				if(standard_id.split(",")[0]!=null&&!standard_id.split(",")[0].equals("")){
					sqlstr = "select * from base_evaluation_standard where standard_id = "+standard_id.split(",")[0];
					System.out.println("sqlstrsqlstr=="+sqlstr);
					rsSt = db.executeQuery(sqlstr);
					if(rsSt.next()){
						standard = getDBStr(rsSt.getString("standard"));
						disp_name = getDBStr(rsSt.getString("disp_name"));
						value = getDBStr(rsSt.getString("value"));
						veto_flag = getDBStr(rsSt.getString("veto_flag"));
						
					}
					rsSt.close();
					if(weighting_score!=null&&!("").equals(weighting_score)){
						sqlstr = "insert into base_evaluation_score (evaluation_type,target_id,order_number,item_id,item,standard_id,standard,disp_name,value,veto_flag,weighting,weighting_score,examiner,score_date,doc_id) values (";
						sqlstr += evaluation_type +",'"+target_id+"',"+order_number+",";
						sqlstr += item_id[i]+",'"+item+"',"+standard_id.split(",")[0]+",'";
						sqlstr += standard+"','"+disp_name+"',"+value+","+veto_flag+","+weighting+",";
						sqlstr += weighting_score+",'"+dqczy+"',"+datestr+",'"+doc_id+"')";
						System.out.println("sqlstrsqlstr=="+sqlstr);
						db.executeUpdate(sqlstr);
					}
				}
			}
		}
		sqlstr="delete from base_evaluation_adjust_score where evaluation_type="+evaluation_type+" and target_id='"+target_id+"'";
		System.out.println("sqlstrsqlstr=="+sqlstr);
		db.executeUpdate(sqlstr);
		if(adjust_item_id!=null){
			for(int i=0;i<adjust_item_id.length;i++){
				adjust_score = getStr(request.getParameter("score_adjust_"+adjust_item_id[i]+"_value"));
				comment_value = getStr(request.getParameter("comment_"+adjust_item_id[i]+"_value"));
				if(adjust_score!=null&&!("").equals(adjust_score)){
					sqlstr = "select * from base_evaluation_adjust where adjust_item_id="+adjust_item_id[i];
					ResultSet rsAd = db.executeQuery(sqlstr);
					if(rsAd.next()){
						adjust_order_number = getDBStr(rsAd.getString("order_number"));
						other_condition = getDBStr(rsAd.getString("other_condition"));
						comment = getDBStr(rsAd.getString("comment"));
					}
					rsAd.close();
					sqlstr = "insert into base_evaluation_adjust_score (evaluation_type,target_id,adjust_item_id,order_number,other_condition,comment_value,score_adjust,examiner,score_date,doc_id) values (";
					sqlstr += "'"+evaluation_type+"'";
					sqlstr += ",'"+target_id+"'";
					sqlstr += ","+adjust_item_id[i];
					sqlstr += ","+adjust_order_number;
					sqlstr += ",'"+other_condition+"'";
					sqlstr += ",'"+comment_value+"'";
					sqlstr += ","+adjust_score;
					sqlstr += ",'"+dqczy+"'";
					sqlstr += ", "+datestr;
					sqlstr += ",'"+doc_id+"')";
					System.out.println("sqlstrsqlstr=="+sqlstr);
					db.executeUpdate(sqlstr);
				}
			}
		}
%>
		<script>
			window.close();
			opener.alert("保存评分数据成功!");
			opener.location.reload();
		</script>
<%
		
}
db.close();
%>


</BODY>
</HTML>

