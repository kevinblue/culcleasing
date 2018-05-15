<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>

<%@ include file="../../public/simpleHeadImport.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>资金计划 - 新增</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/validator.js"></script>
<script src="../../js/calend.js"></script>

<script language="javascript" src="/dict/js/js_dictionary.js"></script>
<script language="javascript" src="/dict/js/ajax_popupDialog.js"></script>

<script Language="Javascript" src="../../js/jquery.js"></script>
<script type="text/javascript" src="../../js/stleasing_tabledata_nonewline.js"></script>
<script type="text/javascript" src="../../js/stleasing_function.js"></script>
<link href="../../css/stleasing_tabledata.css" rel="stylesheet" type="text/css">

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>资金计划 - 新增</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/validator.js"></script>
<script src="../../js/calend.js"></script>

<script language="javascript" src="/dict/js/js_dictionary.js"></script>
<script language="javascript" src="/dict/js/ajax_popupDialog.js"></script>

<script Language="Javascript" src="../../js/jquery.js"></script>
<script type="text/javascript" src="../../js/stleasing_tabledata_nonewline.js"></script>
<script type="text/javascript" src="../../js/stleasing_function.js"></script>
<link href="../../css/stleasing_tabledata.css" rel="stylesheet" type="text/css">
<!-- 公共变量 -->
<%@ include file="../../public/commonVariable.jsp"%>

</head>
<body>

		<form name="form1" method="post" action="upremark.jsp">
<table border="0" cellspacing="0" cellpadding="0" width="100%" class="tab_table_title">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle" align="left" colspan="2">设置资料&gt; 添加备注</td>
</tr>
				<%
		int id = Integer.parseInt(getStr(request.getParameter("id")));
		String contract_id =getStr(request.getParameter("contract_id"));
		String doc_id = getStr(request.getParameter("doc_id"));
		
		String col_str="id,contract_id,doc_id,document_id,doc_title,doc_par_title,text_status,electron_status,remark";
		sqlstr = "select "+col_str+" from vi_contract_document_temp where  id="+id+"and contract_id='"+contract_id+"' and doc_id='"+doc_id+"' order by doc_par_title";
		rs = db.executeQuery(sqlstr);
		while ( rs.next() ) {
	%>	
	<input type="hidden" name="id" value="<%=getDBStr(rs.getString("id")) %>"/>
				<tr class="maintab_content_table_title">
					<td scope="row" >
						资料大类
					</td>
					<td scope="row" align="left"><%=getDBStr(rs.getString("doc_par_title")) %></td>
					
				</tr>
				<tr class="maintab_content_table_title">
					<td scope="row" >
						资料小类
					</td>
					<td scope="row" align="left"><%=getDBStr(rs.getString("doc_title")) %></td>
				</tr>
				<tr class="maintab_content_table_title">
					<td scope="row" >
						文本是否归档
					</td>
					<td scope="row" align="left"><%=getDBStr(rs.getString("text_status")) %></td>

				</tr>
				<tr class="maintab_content_table_title">
					<td scope="row" >
						电子版是否归档
					</td>
					<td scope="row" align="left"><%=getDBStr(rs.getString("electron_status")) %></td>
				</tr>
				<tr class="maintab_content_table_title">
					<td scope="row">
						备注
					</td>
					<td scope="row" align="left">
    					<textarea rows="6" cols="4" name="remark"><%=getDBStr(rs.getString("remark")) %></textarea>
    				</td>
				</tr>
			</table>
		<%
			}
		 %>
		 	<div style="margin: 12px; text-align: right;">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr valign="top">
					<td>
						<input name="btnup" value="保存" type="submit" class="btn3_mouseout">
					</td>

					<td>
						<input name="btnClose" value="取消" type="button"
							onClick="window.close();" class="btn3_mouseout">
					</td>
				</tr>
			</table>
		</div>
		</form>

	
	</body>
</html>
<%if(null != db){db.close();}%>