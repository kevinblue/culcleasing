<%@ page contentType="text/html; charset=gbk" language="java"%>

<%@page import="java.sql.*"%>
<%@page import="java.io.*"%>
<%@page import="com.datasync.*"%>

<%@ include file="/func/common_simple.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>����ӿ���Ϣ</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/calend.js"></script>

<script Language="Javascript" src="../../js/jquery.js"></script>
<script type="text/javascript"
	src="../../js/stleasing_tabledata_nonewline.js"></script>
<script type="text/javascript" src="../../js/stleasing_function.js"></script>
<link href="../../css/stleasing_tabledata.css" rel="stylesheet"
	type="text/css">
</head>


<!-- �������� -->
<%@ include file="../public/commonVariable.jsp"%>
<!-- �������� -->
<%
	Properties properties = new Properties();
	String realpath = FIDConfigReader.class.getClassLoader()
			.getResource("/FIDConfig.properties").getPath();
	InputStream is = null;
	try {
		is = new FileInputStream(realpath);
		properties.load(is);
	} catch (IOException e) {
		e.printStackTrace();
	} finally {
		if (is != null) {
			try {
				is.close();
			} catch (IOException e) {
				throw new RuntimeException("�ر�FIDConfig����Դ�����쳣", e);
			}
		}
	}
	String startTaskGlobalFundPlan = request
			.getParameter("startTaskGlobalFundPlan");
	properties.setProperty("startTaskGlobalFundPlan", startTaskGlobalFundPlan);

	String startTaskGlobalInterestSubsidy = request
			.getParameter("startTaskGlobalInterestSubsidy");
	properties.setProperty("startTaskGlobalInterestSubsidy", startTaskGlobalInterestSubsidy);

	String startTaskGlobalPaied = request
			.getParameter("startTaskGlobalPaied");
	properties.setProperty("startTaskGlobalPaied", startTaskGlobalPaied);

	String startTaskGlobalProjectEnd = request
			.getParameter("startTaskGlobalProjectEnd");
	properties.setProperty("startTaskGlobalProjectEnd", startTaskGlobalProjectEnd);

	String startTaskGlobalReceive = request.getParameter("startTaskGlobalReceive");
	properties.setProperty("startTaskGlobalReceive", startTaskGlobalReceive);

	String startTaskGlobalStartRent = request.getParameter("startTaskGlobalStartRent");
	properties.setProperty("startTaskGlobalStartRent", startTaskGlobalStartRent);

	String startTaskGlobalInterest = request
			.getParameter("startTaskGlobalInterest");
	properties.setProperty("startTaskGlobalInterest", startTaskGlobalInterest);
   
	
	String startTaskGlobalConfirm = request
	.getParameter("startTaskGlobalConfirm");
   properties.setProperty("startTaskGlobalConfirm", startTaskGlobalConfirm);

	// �ļ������     
	FileOutputStream fos = new FileOutputStream(realpath);
	// ��Properties���ϱ��浽����     
	properties.store(fos, "Copyright (c) Boxcode Studio");
	fos.close();// �ر���
%>

<style type="text/css">
td {
	text-align: center;
}
</style>

<body onload="public_onload(0);">
	<form id="form" action="SaveFIConfig.jsp" name="dataNav">
		<!--���⿪ʼ-->
		<table border="0" width="100%" cellspacing="0" cellpadding="0"
			height="25">
			<tr class="tree_title_txt">
				<td nowrap width="100%" class="tree_title_txt" valign="middle"
					id="cwCellTopTitTxt">����ӿ���Ϣ</td>
			</tr>
		</table>
		<!--�������-->

		<!--������Ͳ�������ʼ-->
		<table border="0" width="100%" id="table8" cellspacing="0"
			cellpadding="0" style="margin-top: 2px;">
			<tr class="maintab">
				<td align="left" width="20%">
					<!--������ť��ʼ--> <!--������ť����-->
				</td>
				<td align="right" width="60%">
					<!--��ҳ���ƿ�ʼ--> <!-- ��ҳ���ƿ�ʼ --> <!--��ҳ���ƽ���-->
				</td>
			</tr>
		</table>


		<!--����ʼ-->
		<div
			style="vertical-align: top; width: 100%; overflow: auto; position: relative; left: 0px; top: 0px"
			id="mydiv">
			<table border="0" style="border-collapse: collapse;" align="center"
				cellpadding="2" cellspacing="1" width="100%"
				class="maintab_content_table">
				<tr class="maintab_content_table_title">
					<th width="8%"><input name="" type="checkbox"
						class="input_hide" onClick="CheckSelect(this.form);return false;"
						value="">ȫѡ/��ѡ</th>
					<th width="13%" align="center">��������</th>
					<th width="13%" align="center">��������</th>
					<th width="8%" align="center">ͬ������</th>
					<th width="30%" align="center">ERP��ͼ����</th>
					<th width="20%" align="center">ͬ��ʱ��</th>
					<th width="8%" align="center">����״̬</th>
				</tr>
				<tbody id="data">
					<tr>
						<td align="center" class="text_center"><input
							name="groupCheckbox" type="checkbox" value="startTaskGlobalFundPlan"
							class="input_hide"></td>
						<td>startTaskGlobalFundPlan</td>
						<td>�ʽ��ո��ƻ���Ϣͬ��</td>
						<td>ERP--> ORACLE</td>
						<td>vi_INTERFACE_fina_global_fundplan_nc</td>
						<td>ÿ���賿2��</td>
						<td>��<input type="radio" name="startTaskGlobalFundPlan"
							<%if (properties.getProperty("startTaskGlobalFundPlan").equals("on")) {%>
							checked <%}%> value="on">&nbsp;&nbsp; ��<input
							type="radio" name="startTaskGlobalFundPlan"
							<%if (properties.getProperty("startTaskGlobalFundPlan").equals("off")) {%>
							checked <%}%> value="off">
						</td>
					</tr>
					<tr>
						<td align="center" class="text_center"><input
							name="groupCheckbox" type="checkbox" value="startTaskGlobalConfirm"
							class="input_hide"></td>
						<td>startTaskGlobalConfirm</td>
						<td>��ͬ��ֹ��Ϣͬ��</td>
						<td>ERP--> ORACLE</td>
						<td>vi_INTERFACE_before_confirm_nc</td>
						<td>ÿ���賿2��</td>
						<td>��<input type="radio" name="startTaskGlobalConfirm"
							<%if (properties.getProperty("startTaskGlobalConfirm").equals("on")) {%>
							checked <%}%> value="on">&nbsp;&nbsp; ��<input
							type="radio" name="startTaskGlobalConfirm"
							<%if (properties.getProperty("startTaskGlobalConfirm").equals("off")) {%>
							checked <%}%> value="off">
						</td>
					</tr>

					<tr>
						<td align="center" class="text_center"><input
							name="groupCheckbox" type="checkbox" value="startTaskGlobalInterestSubsidy"
							class="input_hide"></td>
						<td>startTaskGlobalInterestSubsidy</td>
						<td>��Ϣ������Ϣͬ��</td>
						<td>ERP--> ORACLE</td>
						<td>vi_INTERFACE_fina_global_interestSubsidy_nc</td>
						<td>ÿ��10���賿2��</td>
						<td>��<input type="radio" name="startTaskGlobalInterestSubsidy"
							<%if (properties.getProperty("startTaskGlobalInterestSubsidy").equals("on")) {%>
							checked <%}%> value="on">&nbsp;&nbsp; ��<input
							type="radio" name="startTaskGlobalInterestSubsidy"
							<%if (properties.getProperty("startTaskGlobalInterestSubsidy").equals("off")) {%>
							checked <%}%> value="off">
						</td>
					</tr>

					<tr>
						<td align="center" class="text_center"><input
							name="groupCheckbox" type="checkbox" value="startTaskGlobalPaied"
							class="input_hide"></td>
						<td>startTaskGlobalPaied</td>
						<td>�����Ϣͬ��</td>
						<td>ERP--> ORACLE</td>
						<td>vi_INTERFACE_fina_global_paied_nc</td>
						<td>ÿ���賿2��</td>
						<td>��<input type="radio" name="startTaskGlobalPaied"
							<%if (properties.getProperty("startTaskGlobalPaied").equals("on")) {%>
							checked <%}%> value="on">&nbsp;&nbsp; ��<input
							type="radio" name="startTaskGlobalPaied"
							<%if (properties.getProperty("startTaskGlobalPaied").equals("off")) {%>
							checked <%}%> value="off">
						</td>
					</tr>

					<tr>
						<td align="center" class="text_center"><input
							name="groupCheckbox" type="checkbox" value="startTaskGlobalProjectEnd"
							class="input_hide"></td>
						<td>startTaskGlobalProjectEnd</td>
						<td>��ͬ������Ϣͬ��</td>
						<td>ERP--> ORACLE</td>
						<td>vi_INTERFACE_fina_global_htjq_nc</td>
						<td>ÿ���賿2��</td>
						<td>��<input type="radio" name="startTaskGlobalProjectEnd"
							<%if (properties.getProperty("startTaskGlobalProjectEnd").equals("on")) {%>
							checked <%}%> value="on">&nbsp;&nbsp; ��<input
							type="radio" name="startTaskGlobalProjectEnd"
							<%if (properties.getProperty("startTaskGlobalProjectEnd").equals("off")) {%>
							checked <%}%> value="off">
						</td>
					</tr>

					<tr>
						<td align="center" class="text_center"><input
							name="groupCheckbox" type="checkbox" value="startTaskGlobalReceive"
							class="input_hide"></td>
						<td>startTaskGlobalReceive</td>
						<td>�տ��Ϣͬ��</td>
						<td>ERP--> ORACLE</td>
						<td>vi_INTERFACE_fina_global_receive_nc</td>
						<td>ÿ���賿2��</td>
						<td>��<input type="radio" name="startTaskGlobalReceive"
							<%if (properties.getProperty("startTaskGlobalReceive").equals("on")) {%>
							checked <%}%> value="on">&nbsp;&nbsp; ��<input
							type="radio" name="startTaskGlobalReceive"
							<%if (properties.getProperty("startTaskGlobalReceive").equals("off")) {%>
							checked <%}%> value="off">
						</td>
					</tr>

					<tr>
						<td align="center" class="text_center"><input
							name="groupCheckbox" type="checkbox" value="startTaskGlobalStartRent"
							class="input_hide"></td>
						<td>startTaskGlobalStartRent</td>
						<td>������Ϣͬ��</td>
						<td>ERP--> ORACLE</td>
						<td>vi_INTERFACE_fina_global_start_rent_nc</td>
						<td>ÿ���賿2��</td>
						<td>��<input type="radio" name="startTaskGlobalStartRent"
							<%if (properties.getProperty("startTaskGlobalStartRent").equals("on")) {%>
							checked <%}%> value="on">&nbsp;&nbsp; ��<input
							type="radio" name="startTaskGlobalStartRent"
							<%if (properties.getProperty("startTaskGlobalStartRent").equals("off")) {%>
							checked <%}%> value="off">
						</td>
					</tr>

					<tr>
						<td align="center" class="text_center"><input
							name="groupCheckbox" type="checkbox" value="startTaskGlobalInterest"
							class="input_hide"></td>
						<td>startTaskGlobalInterest</td>
						<td>������Ϣ��Ϣͬ��</td>
						<td>ERP--> ORACLE</td>
						<td>vi_INTERFACE_fina_global_interest_nc</td>
						<td>ÿ��18���賿2��</td>
						<td>��<input type="radio" name="startTaskGlobalInterest"
							<%if (properties.getProperty("startTaskGlobalInterest").equals("on")) {%>
							checked <%}%> value="on">&nbsp;&nbsp; ��<input
							type="radio" name="startTaskGlobalInterest"
							<%if (properties.getProperty("startTaskGlobalInterest").equals("off")) {%>
							checked <%}%> value="off">
						</td>
					</tr>
					<tr>
						<td colspan="6"></td>
						<td align="center"><input type="button" name="b1" value="�ύ"
							onclick="submitForm();"></td>
					</tr>
				</tbody>
			</table>
		</div>
		<!--�������-->
	</form>
	<script type="text/javascript">
		alert("���������޸ĳɹ�!");
		window.location.href='FIConfig.jsp'
	</script>
</body>
</html>
