<%@ page contentType="text/html; charset=gbk" language="java"%>
<%@ page import="dbconn.*"%>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" />
<%@ page import="java.sql.*"%>
<%@ include file="../../func/common_simple.jsp"%>

<jsp:useBean id="condition" scope="page" class="com.condition.ConditionOperating" />
<html>
<head>
<title>  租金测算 - 不规则租金测算 </title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script type="text/javascript">
	//生成不规则对应的租金测算数据
	function init_bgzcs(temp,measure_id,proj_id,contract_id){
		dataNav.action = "zjcs_sg_cl.jsp?temp="+temp+"&measure_id="+measure_id+"&proj_id="+proj_id+"&contract_id="+contract_id;
		dataNav.target = "_blank";	
		dataNav.method = "post";
		dataNav.submit();
		//opener.parent.location.reload();
		//ClickOk();
	}
	function ClickOk()    
	{    
		
		window.parent.opener.addText('ok');
		window.parent.close(); 
	}  

</script>
</head>

<%
		int flag = 0;
		String sqlstr;
		ResultSet rs;
		String curr_date = getSystemDate(0);
		String wherestr = " where 1=1";
		//项目和交易的做成一个
		String doc_id = getStr(request.getParameter("doc_id"));//文档编号
		String contract_id = getStr(request.getParameter("contract_id"));//合同编号
		String proj_id = getStr(request.getParameter("proj_id"));//项目编号
		String temp = getStr(request.getParameter("temp"));//用于判断是项目还是合同的操作
		String query_rent_sql = "";
		//
		if (temp.equals("proj_zjcs")){//
			flag = condition.init_fund_rent_plan_proj_temp(proj_id,doc_id);
			sqlstr = "select * from fund_rent_plan_proj_temp where   proj_id='"+proj_id+"' and measure_id='"+doc_id+"' order by rent_list";
			query_rent_sql = sqlstr;
		} 
%>
	<body onload="public_onload(0);">
		<form action="chjhxg_list.jsp" name="dataNav" onSubmit="return goPage()">
		<input type="hidden" value="ok" id="isOk" >
			<!--标题开始-->
			<table border="0" width="100%" cellspacing="0" cellpadding="0"
				height="25">
				<tr class="tree_title_txt">
					<td nowrap width="100%" class="tree_title_txt" valign="middle"
						id="cwCellTopTitTxt">
						租金测算 &gt; 不规则租金测算
					</td>
				</tr>
			</table>
			<!--标题结束-->
			<!--副标题和操作区开始-->
			<table border="0" width="100%" id="table8" cellspacing="0"
				cellpadding="0" style="margin-top: 2px;">
				<tr class="maintab">
					<td align="left" width="1%">
						<!--操作按钮开始-->
						<table border="0" cellspacing="0" cellpadding="0">
							<tr class="maintab">
								<!--  
								<td>
									<a href="#" accesskey="n"
										onclick="dataHander('add','zjcs_sg_add.jsp?doc_id=<%=doc_id%>&contract_id=<%=contract_id%>&proj_id=<%=proj_id%>&temp=<%=temp%>&savetype=add&itemselect=',dataNav.itemselect);"><img
											align="absmiddle" src="../../images/sbtn_new.gif"
											alt="新增(Alt+N)" align="absmiddle">
									</a>
								</td>
								-->
								<td>
									<a href="#" accesskey="m"
										onclick="dataHander('mod','zjcs_sg_mod.jsp?doc_id=<%=doc_id%>&contract_id=<%=contract_id%>&proj_id=<%=proj_id%>&temp=<%=temp%>&savetype=mod&itemselect=',dataNav.itemselect);"><img
											align="absmiddle" src="../../images/sbtn_mod.gif"
											alt="修改(Alt+M)" align="absmiddle">
									</a>
								</td>
								<!--  
								<td>
									<a href="#" accesskey="d"
										onclick="dataHander('del','zics_sg_del.jsp?doc_id=<%=doc_id%>&contract_id=<%=contract_id%>&proj_id=<%=proj_id%>&temp=<%=temp%>&savetype=del&itemselect=',dataNav.itemselect);"><img
											align="absmiddle" src="../../images/sbtn_del.gif"
											alt="删除(Alt+D)" align="absmiddle">
									</a>
								</td>
								-->
								<td nowrap="nowrap">
									<BUTTON class="btn_2" name="btnSave" value="生成数据" onclick="init_bgzcs('<%=temp%>','<%=doc_id%>','<%=proj_id%>','<%=contract_id%>')"  alt="生成相关的租金数据(Alt+D)">
										<img src="../../images/sbtn_hz.gif" align="absmiddle" border="0" alt="生成相关的租金数据(Alt+D)">
										生成数据(生成对应的现金流以及不规则财务偿还计划)
									</button>
								</td>
							</tr>
						</table>
						<!--操作按钮结束-->
					</td>
					<td align="right" width="90%">

						<!--翻页控制开始-->
						<%
							int intPageSize = 200; //一页显示的记录数
							int intRowCount = 0; //记录总数
							int intPageCount = 1; //总页数
							int intPage; //待显示页码
							String strPage = getStr(request.getParameter("page")); //取得待显示页码
							if (strPage.equals("")) { //表明在QueryString中没有page这一个参数，此时显示第一页数据
								intPage = 1;
							} else {
								intPage = java.lang.Integer.parseInt(strPage);
								if (intPage < 1)
									intPage = 1;
							}

							rs = db.executeQuery(query_rent_sql);

							rs.last(); //获取记录总数
							intRowCount = rs.getRow();
							intPageCount = (intRowCount + intPageSize - 1) / intPageSize; //记算总页数
							if (intPage > intPageCount)
								intPage = intPageCount; //调整待显示的页码
							if (intPageCount > 0)
								rs.absolute((intPage - 1) * intPageSize + 1); //将记录指针定位到待显示页的第一条记录上
							int i = 0;
						%>


						<table border="0" cellspacing="0" cellpadding="0">
							<tr class="maintab">
								<script>
									var cp = <%=intPage%>;
									var lp = <%=intPageCount%>;
									var nf = document.dataNav;
								</script>
								<td nowrap>
									共 <%=intRowCount%> 条 / <%=intPageCount%> 页
								<% if (intPage > 1) { %>
									<img align="absmiddle" style="cursor: pointer;"
										onClick="goPage('first')" src="../../images/ico_first.gif" alt="第一页" border="0">
									<img align="absmiddle" style="cursor: pointer;"
										onClick="goPage('prev')" src="../../images/ico_prev.gif" alt="上一页" border="0">
									<% } else {
									%><img align="absmiddle" style="filter: Gray;"
										src="../../images/ico_first.gif" alt="第一页" border="0">
									<img align="absmiddle" style="filter: Gray;"
										src="../../images/ico_prev.gif" alt="上一页" border="0">
									<% } %> 第
									<font color="red"><%=intPage%></font> 页
									<% if (intPage < intPageCount) { %>
									<img align="absmiddle" style="cursor: pointer;"
										onClick="goPage('next')" src="../../images/ico_next.gif" alt="下一页" border="0">
									<img align="absmiddle" style="cursor: pointer;"
										onClick="goPage('last')" src="../../images/ico_last.gif" alt="最后页" border="0">
									<% } else {
									%><img align="absmiddle" style="filter: Gray;"
										src="../../images/ico_next.gif" alt="下一页" border="0">
									<img align="absmiddle" style="filter: Gray;"
										src="../../images/ico_last.gif" alt="最后页" border="0">
									<% } %>
								</td>
								<td nowrap>
									<img align="absmiddle" src="../../images/sbtn_split.gif">
								</td>
								<td nowrap>
									转到 <input name="page" type="text" size="2" value="1"> 页
									<img align="absmiddle" style="cursor: pointer;"
										onClick="goPage('jump')" src="../../images/goto.gif" alt="执行"
										border="0" align="absmiddle">
								</td>
							</tr>
						</table>

					</td>
				</tr>
			</table>

			<!--翻页控制结束-->

			<!--报表开始-->
			<div style="vertical-align: top; width: 100%; overflow: auto; position: relative;" id="mydiv";>
				<table border="0" style="border-collapse: collapse;" align="center"
					cellpadding="2" cellspacing="1" width="100%" class="maintab_content_table">
					<tr class="maintab_content_table_title">
						<th width="1%"></th>
						<th> 期项 </th>
						<th> 状态 </th>
						<th> 承付日期 </th>
						<th> 租金 </th>
						<th> 市场本金 </th>
						<th> 市场利息 </th>
						<th> 市场本金余额 </th>
					</tr>

					<%
						rs.previous();
						if (rs.next()) {
							while (i < intPageSize && !rs.isAfterLast()) {
					%>

					<tr>
						<td align="center">
							<!--  -->
							<input class="rd" type="radio" name="itemselect" id="itemselect"
								value="<%=getDBStr(rs.getString("id"))%>"/>
						</td>
						<td align="center"><%=getDBStr(rs.getString("rent_list"))%></td>
						<td align="center"><%=getDBStr(rs.getString("plan_status"))%></td>
						<td align="center"><%=getDBDateStr(rs.getString("plan_date"))%></td>
						<td align="center"><%=formatNumberStr(getDBStr(rs.getString("rent")),"#,##0.00")%></td>
						<td align="center"><%=formatNumberStr(getDBStr(rs.getString("corpus_market")),"#,##0.00")%></td>
						<td align="center"><%=formatNumberStr(getDBStr(rs.getString("interest_market")),"#,##0.00")%></td>
						<td align="center"><%=formatNumberStr(getDBStr(rs.getString("corpus_overage_market")),"#,##0.00")%></td>
					</tr>
					
					<%
						rs.next();
								i++;
							}
						}
						rs.close();
						db.close();
					%>
				</table>
			</div>
			<!--报表结束-->
		</form>
	</body>
</html>
