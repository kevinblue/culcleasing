<%@ page contentType="text/html; charset=gbk" language="java"%>
<%@ page import="dbconn.*"%>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" />
<jsp:useBean id="right" scope="page" class="com.filter.FilterCredit" /> 
<%@ page import="java.sql.*"%>
<%@ include file="../../func/common.jsp"%>

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gbk">
		<title>��ͬ��Ϣ - ��Ѻ���״̬</title>
		<link href="../../css/global.css" rel="stylesheet" type="text/css">
		<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
		<script src="../../js/comm.js"></script>
		<script src="../../js/validator.js"></script>
		<SCRIPT Language="Javascript" SRC="/tenwa/js/public.js"></SCRIPT>
		<SCRIPT Language="Javascript" SRC="/tenwa/js/publicEvent.js"></SCRIPT>
		<script language="javascript" src="/dict/js/js_dictionary.js"></script>
		<script language="javascript" src="/dict/js/ajax_popupDialog.js"></script>
	</head>

	<body onload="fun_winMax();">
		<form name="form2" action="dywj_list.jsp" name="dataNav" onSubmit="return goPage()">
			<!--���⿪ʼ-->
			<table border="0" width="100%" cellspacing="0" cellpadding="0"
				height="25">
				<tr class="tree_title_txt">
					<td nowrap width="100%" class="tree_title_txt" valign="middle"
						id="cwCellTopTitTxt">
						��ͬ��Ϣ &gt; ��Ѻ���״̬
					</td>
				</tr>
			</table>
			<!--�������-->

			<!--������Ͳ�������ʼ-->

			<table border="0" width="100%" id="table8" cellspacing="0"
				cellpadding="0" style="margin-top:2px;">
				<tr class="maintab">
					<td align="left" width="1%">

<%
String dqczy=(String) session.getAttribute("czyid");
if ((dqczy==null) || (dqczy.equals("")))
{
  dqczy="����֤";
  response.sendRedirect("../../noright.jsp");
}

int canedit=0;
if (right.CheckRight("zlwjgl-dywzt-list",dqczy)>0) canedit=1;
%>
<script>
if (<%=canedit%>==0){
	window.close();
	opener.alert("��û�в���Ȩ�ޣ�");
}

</script>
<%
//--------����ΪȨ�޿���-----------------------------
	String sqlstr = "";
	ResultSet rs;
	String wherestr = " where 1=1";
	String searchFld = getStr(request.getParameter("searchFld"));
	String searchKey = getStr(request.getParameter("searchKey"));
	String searchFld_tmp = "";
	int i = 0;

	String contract_id = getStr(request.getParameter("contract_id"));
	if (contract_id.equals("")) {
		wherestr = " where 1=0";
	} else {
		wherestr = wherestr + " and contract_guarantee_equip.contract_id='"
		+ contract_id + "'";
	}

	String cust_name = "";
	sqlstr = "select vi_contract_info.cust_name from vi_contract_info where vi_contract_info.contract_id='"
			+ contract_id + "'";
	rs = db.executeQuery(sqlstr);
	if (rs.next()) {
		cust_name = getDBStr(rs.getString("cust_name"));
	}
	rs.close();

	sqlstr = "select contract_guarantee_equip.id,contract_guarantee_equip.equip_guarantee_type, contract_guarantee_equip.eqip_name,contract_guarantee_equip.equip_num,contract_guarantee_equip.total_price, contract_guarantee_equip.memo,contract_guarantee_equip.equip_status,contract_guarantee_equip.status_date from contract_guarantee_equip"
			+ wherestr;
	//System.out.println("sqlstr=================="+sqlstr);
%>



<!--������ť��ʼ-->
<table border="0" cellspacing="0" cellpadding="0">
	<tr class="maintab">
		<td>
		<BUTTON class="btn_2" name="btnSave" value="����"  type="button" onclick="form1.submit();">
<img src="../../images/save.gif" align="absmiddle" border="0" >����</button>
		<input type="hidden" name="contract_id" value="<%=contract_id%>">
		</td>
		
	</tr>
</table>
<!--������ť����-->
					</td>
					<td align="right" width="90%">


						<!--��ҳ���ƿ�ʼ-->


						<%
							int intPageSize = 15; //һҳ��ʾ�ļ�¼��
							int intRowCount = 0; //��¼����
							int intPageCount = 1; //��ҳ��
							int intPage; //����ʾҳ��
							String strPage = getStr(request.getParameter("page")); //ȡ�ô���ʾҳ��
							if (strPage.equals("")) { //������QueryString��û��page��һ����������ʱ��ʾ��һҳ����
								intPage = 1;
							} else {
								intPage = java.lang.Integer.parseInt(strPage);
								if (intPage < 1)
									intPage = 1;
							}

							rs = db.executeQuery(sqlstr);

							
								rs.last(); //��ȡ��¼����
								intRowCount = rs.getRow();
								intPageCount = (intRowCount + intPageSize - 1) / intPageSize; //������ҳ��
								if (intPage > intPageCount)
									intPage = intPageCount; //��������ʾ��ҳ��
								if (intPageCount > 0)
									rs.absolute((intPage - 1) * intPageSize + 1); //����¼ָ�붨λ������ʾҳ�ĵ�һ����¼��
								i = 0;
						%>


						<table border="0" cellspacing="0" cellpadding="0">
							<tr class="maintab">
								<script>
		var cp = <%=intPage%>;
		var lp = <%=intPageCount%>;
		var nf = document.dataNav;
	</script>
								<td nowrap>
									��
									<%=intRowCount%>
									�� /
									<%=intPageCount%>
									ҳ
									<%
								if (intPage > 1) {
								%>
									<img align="absmiddle" style="cursor:pointer; "
										onClick="goPage('first')" src="../../images/ico_first.gif"
										alt="��һҳ" border="0">
									<img align="absmiddle" style="cursor:pointer; "
										onClick="goPage('prev')" src="../../images/ico_prev.gif"
										alt="��һҳ" border="0">
									<%
									} else {
									%>
									<img align="absmiddle" style="filter:Gray;"
										src="../../images/ico_first.gif" alt="��һҳ" border="0">
									<img align="absmiddle" style="filter:Gray;"
										src="../../images/ico_prev.gif" alt="��һҳ" border="0">
									<%
									}
									%>
									��
									<font color="red"><%=intPage%>
									</font> ҳ
									<%
									if (intPage < intPageCount) {
									%>
									<img align="absmiddle" style="cursor:pointer; "
										onClick="goPage('next')" src="../../images/ico_next.gif"
										alt="��һҳ" border="0">
									<img align="absmiddle" style="cursor:pointer; "
										onClick="goPage('last')" src="../../images/ico_last.gif"
										alt="���ҳ" border="0">
									<%
									} else {
									%>
									<img align="absmiddle" style="filter:Gray;"
										src="../../images/ico_next.gif" alt="��һҳ" border="0">
									<img align="absmiddle" style="filter:Gray;"
										src="../../images/ico_last.gif" alt="���ҳ" border="0">
									<%
									}
									%>
								</td>

								<td nowrap>
									<img align="absmiddle" src="../../images/sbtn_split.gif">
								</td>

								<td nowrap>
									ת��
									<input name="page" type="text" size="2" value="1">
									ҳ
									<img align="absmiddle" style="cursor:pointer; "
										onClick="goPage('jump')" src="../../images/goto.gif" alt="ִ��"
										border="0" align="absmiddle">
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</form>

		<!--��ҳ���ƽ���-->






		<!--����ʼ-->

		<div
			style="vertical-align:top;height:200px;width:100%;overflow:auto;position: relative; left: 0px; top: 0px"
			id="mydiv";>
			<form name="form1" method="post" action="dywj_save.jsp" target="_blank"
				onSubmit="return Validator.Validate(this,3);">
				<table border="0" style="border-collapse:collapse;" align="center"
					cellpadding="0" cellspacing="0" width="100%"
					class="maintab_content_table">
					<tr><td width="15%" nowrap>��ͬ���:<%= contract_id%></td><td align="left" nowrap>�ͻ�:<%= cust_name%></td></tr>
				</table>
				
				<table border="0" style="border-collapse:collapse;" align="center"
					cellpadding="2" cellspacing="1" width="100%"
					class="maintab_content_table">
					<tr class="maintab_content_table_title">
						<th>��Ѻ/��Ѻ</th>
						<th>����Ѻ������</th>
						<th>����</th>
						<th>�۸�</th>
						<th>����</th>
						<th>���״̬</th>
						<th>״̬����</th>
					</tr>


					<%
					rs.previous();
					if (rs.next()) {
					while (i < intPageSize && !rs.isAfterLast()) {
					%>

					<tr>
						<td><%=getDBStr(rs.getString("equip_guarantee_type"))%></td>
						<td><%=getDBStr(rs.getString("eqip_name"))%></td>
						<td align="right"><%=getDBStr(rs.getString("equip_num"))%></td>
						<td align="right"><%=formatNumberStr(getDBStr(rs.getString("total_price")),"#,##0.00")%></td>
						<td><%=getDBStr(rs.getString("memo"))%></td>
						<td>
							<select name="equip_status<%=i%>"></select>
							<script language="javascript">dict_list("equip_status<%=i%>","dy_equip_status","<%=getDBStr(rs.getString("equip_status"))%>","name");</script>
						</td>
						<td>
							<input name="status_date<%=i%>" type="text" size="10" readonly
								maxlength="10" dataType="Date" Require="true"
								value="<%=getDBDateStr(rs.getString("status_date"))%>">
							<img onClick="openCalendar(status_date<%=i%>);return false"
								style="cursor:pointer; " src="../../images/tbtn_overtime.gif"
								width="20" height="19" border="0" align="absmiddle">
							<input type="hidden" name="equip_id<%=i%>" value="<%=getDBStr(rs.getString("id"))%>">
						</td>
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
		<input type="hidden" name="i" value="<%=i%>">
		<!--�������-->
		</form>
	</body>
</html>
