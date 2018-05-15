<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>

<%@ include file="../../public/simpleHeadImport.jsp"%>
<jsp:useBean id="db1" scope="page" class="dbconn.Conn" />
<jsp:useBean id="db2" scope="page" class="dbconn.Conn" />
<jsp:useBean id="db3" scope="page" class="dbconn.Conn" />
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>项目资料 - 修改</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/validator.js"></script>
<script src="../../js/calend.js"></script>

<script language="javascript" src="/dict/js/js_dictionary.js"></script>
<script language="javascript" src="/dict/js/ajax_popupDialog.js"></script>

<script Language="Javascript" src="../../js/jquery.js"></script>
<script type="text/javascript">
/** 
 * 加载完毕document之后立马执行的js代码
 */
$(document).ready(function(){
	var sqlIds = "";//选中数据的所有Id
	//页面全选
	$("input[name='ck_all']").click(function(){
		if($(this).attr("checked")){
			$("input[name='inverse_ck_all']").attr("checked",false);
			$("input[name='data_ck_all']").attr("checked",false);
			$("input[name='list']").attr("checked",true);
		}else{
			$("input[name='list']").attr("checked",false);
		}
	});
	//反选功能
	$("input[name='inverse_ck_all']").click(function(){
			$("input[name='ck_all']").attr("checked",false);
			$("input[name='data_ck_all']").attr("checked",false);
			$("input[name='list']").each(function(){
				$(this).attr("checked",!$(this).attr("checked"));
			});
	});
	//数据全选 -- 页面配合选中
	$("input[name='data_ck_all']").click(function(){
		if($(this).attr("checked")){
			$("input[name='inverse_ck_all']").attr("checked",false);
			$("input[name='ck_all']").attr("checked",false);
			$("input[name='list']").attr("checked",true);
		}else{
			$("input[name='list']").attr("checked",false);
		}
	});
});

function checkAm(){
	var $amou = $(":checkbox:checked").length;
	if($amou>0){
		$(":input[name='ckAmount']").val("2");
	}else{
		if(!confirm("您未选择付款前提，确认提交吗？")){
			return false;
		}
	}
}
//展开所有
function expendAll(){
	
}
//收缩所有
function oxpendAll(){
	
}
</script>
</head>

<!-- 公共变量 -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- 公共变量 -->

<!-- 下拉值 -->
<%@ include file="../../public/selectData.jsp"%>
<!-- 下拉值 -->

<%
//提取参数proj_id,doc_id
String proj_id = getStr( request.getParameter("proj_id") );
String doc_id = getStr( request.getParameter("doc_id") );
%>

<body onLoad="public_onload(44)" style="border:0px solid #8DB2E3;">
<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle" align="left">项目资料清单</td>
</tr>
<tr>
<td align=center width=100% height=100% valign="top">
<div class="mydivtab" id="mydiv" style="overflow: auto;">

<form name="form1" method="post" action="proj_matersave.jsp" onSubmit="return checkAm();">
<input type="hidden" name="type" value="save">
<input type="hidden" name="proj_id" value="<%=proj_id %>">
<input type="hidden" name="doc_id" value="<%=doc_id %>">
<input type="hidden" name="ckAmount" value="0">

<table border="0" cellspacing="0" cellpadding="0" width="100%" class="tab_table_title">
  <tr>
  <td><span style="font-weight: bold;font-size: 15px;">项目编号</span></td>
  <td><span style="font-weight: bold;font-size: 15px;"><%=proj_id %></span></td>
  </tr>
  <tr>
    <td scope="row"><span style="font-weight: bold;font-size: 15px;">选择项目资料</span></td>
    <td scope="row">
    	<input name="ck_all" type="checkbox">全选
		<input name="inverse_ck_all" type="checkbox">反选
    </td>
   </tr>

   <tr>
	<td>
		<input name="btnSave" value="保存" type="submit" class="btn3_mouseout">
		&nbsp;&nbsp;
		<input name="btnClose" value="取消" type="button" onClick="window.close();" class="btn3_mouseout">
    </td>
	<td>
		<input name="zk" value="全部展开" type="button" onClick="expendAll()" class="btn3_mouseout">
		&nbsp;&nbsp;
		<input name="ss" value="全部收缩" type="button" onClick="oxpendAll();" class="btn3_mouseout" disabled="disabled">
	</td>
   </tr>
   
   <tr> 
    <td scope="row" colspan="2">
		<%
		String partSql = "";
		String partSql2 = "";
		String partSql3="";
		ResultSet rs1 = null;
		ResultSet rs2 = null;
		ResultSet rs3=null;
		String partName = "";
		String partTitle = "";
		String partName1 = "";
		String partTitle1 = "";
		//查询资料大类
		sqlstr = "select name,title from dbo.ifelc_conf_dictionary where parentid='ProjectMaterial' order by id";
		rs = db.executeQuery(sqlstr);
		String name = "";
		String title = "";
		while(rs.next()){
			name = getDBStr(rs.getString("name"));
			title = getDBStr(rs.getString("title"));
			%>
			<!--可折叠查询开始-->
			<div style="width:100%;" id="div1">
			<fieldset style="width:100%;TEXT-ALIGN:center;margin:0px 5px 0px 5px;"> 
			  <legend>&nbsp;<%=title %>
				<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" 
				style="cursor:hand" title="显示/隐藏内容">&nbsp;
			</legend>
			<table border="0" width="100%" cellspacing="5" cellpadding="0">
				
				<%
					partSql = "select name,title from ifelc_conf_dictionary where parentid='"+name+"' order by orderflag";
					System.out.println("qqqqqqqqqqqqqq"+partSql);
					rs1 = db1.executeQuery(partSql);
					while(rs1.next()){
						partName = getDBStr(rs1.getString("name"));
						partTitle = getDBStr(rs1.getString("title"));
						%>
						<!--可折叠查询开始-->
						<tr><td>
					<div style="width:100%;" id="div2">
					<fieldset style="width:100%;TEXT-ALIGN:center;margin:0px 5px 0px 5px;"> 
					  <legend>&nbsp;<%=partTitle %>
						<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" 
						style="cursor:hand" title="显示/隐藏内容">&nbsp;
					</legend>
					<table border="0" width="100%" cellspacing="5" cellpadding="0">
						<%
						partSql3="select name,title from ifelc_conf_dictionary where parentid='"+partName+"' order by orderflag";
						rs3=db3.executeQuery(partSql3);
						while(rs3.next()){
									partName1 = getDBStr(rs3.getString("name"));
									partTitle1 = getDBStr(rs3.getString("title"));
						
									//查询该资料是否选中
									partSql2 = "select id from proj_document_temp where document_id='"+partName1+"' and proj_id='"+proj_id+"' and doc_id='"+doc_id+"'";
									rs2 = db2.executeQuery(partSql2);
									if(rs2.next()){
										%>
										<tr>
										<td>
											<input type="checkbox" name="list" value="<%=partName1 %>" checked="checked"><%=partTitle1 %>
										</td>
										</tr>
										<%
									}else{
										%>
										<tr>
										<td>
											<input type="checkbox" name="list" value="<%=partName1 %>"><%=partTitle1 %>
										</td>
										</tr>
										<%
									}
									rs2.close();
									}
									rs3.close();
									%>
									</table>
					</fieldset>
					</div>
					</td>
					</tr>
									<%
								}
								rs1.close();
							%>
								
						
			
			</table>
			</fieldset>
			</div>
			<!--可折叠查询结束-->
			<%
		}
		rs.close();
		db.close();
		db1.close();
		db2.close();
		db3.close();
		%>		
		
    </td>
  </tr>
</table>



<div  style="margin:12px;text-align:right;">
<table border="0" cellspacing="0" cellpadding="0">
<tr valign="top"><td>
<input name="btnSave" value="保存" type="submit" class="btn3_mouseout"></td>

<td>
<input name="btnClose" value="取消" type="button" onClick="window.close();" class="btn3_mouseout">
</td>
</tr>
</table>
</div>
<!-- end cwToolbar -->

</form>
</div>
<!-- end cwMain -->
</table>
</body>
</html>

