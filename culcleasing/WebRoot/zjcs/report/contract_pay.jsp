<%@ page contentType="text/html; charset=gbk" language="java"%>

<%@ page import="dbconn.*"%>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" />
<jsp:useBean id="right" scope="page" class="com.filter.FilterCredit" />
<%@ page import="java.sql.*"%>
<%@ include file="../../func/common.jsp"%>

<!-- 05.002 -->
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
		<title>��Ŀ��ϸ��ѯ���� - ��Ŀ��ϸ</title>
	<link href="../../css/global.css" rel="stylesheet" type="text/css">
		<script src="../../js/comm.js"></script>
		<script src="../../js/delitem.js"></script>
	
	</head>

	<body onload="public_onload(0);">
		<form action="contract_pay.jsp" name="dataNav"
			onSubmit="return goPage()">
			
			<!--���⿪ʼ-->
			<table border="0" width="100%" cellspacing="0" cellpadding="0"
				height="25">
				<tr class="tree_title_txt">
					<td nowrap width="100%" class="tree_title_txt" valign="middle"
						id="cwCellTopTitTxt">
						��Ŀ��ϸ��ѯ����&gt; ��Ŀ��ϸ
					</td>
				</tr>
			</table>
			<!--�������-->
<%
//String curr_date = getSystemDate(0);
//��Ŀ����
String project_name=getStr(request.getParameter("project_name"));
//����
String industry_type=getStr(request.getParameter("industry_type"));
//��Ŀ����
String proj_manage=getStr(request.getParameter("proj_manage"));
//�Ƿ�����
String yes_yuqi=getStr(request.getParameter("yes_yuqi"));
//�Ƿ����շ�Ϣ
String yes_faxi=getStr(request.getParameter("yes_faxi"));
//�ƻ�ʱ���


String start_date = getStr(request.getParameter("start_date"));
String end_date = getStr(request.getParameter("end_date"));
String sqlstr="";
String expsqlstr="";


ResultSet rs=null;
String wherestr=" where 1=1";
if(!project_name.equals("")){
	wherestr+=" and project_name like '%"+project_name+"%'";
	}
if(!industry_type.equals("")){
	wherestr+=" and industry_type like '%"+industry_type+"%'";
	}
	if(!proj_manage.equals("")){
		wherestr+=" and proj_manage like '%"+proj_manage+"%'";
	}
if(!yes_yuqi.equals("")){
	wherestr+=" and yes_yuqi like '%"+yes_yuqi+"%'";
	}
if(!yes_faxi.equals("")){
	wherestr+=" and yes_faxi like '%"+yes_faxi+"%'";
	}




//expsqlstr="SELECT distinct dbo.contract_info.project_name, dbo.contract_info.contract_id, dbo.contract_info.industry_type, dbo.GETUSERNAME(dbo.contract_info.proj_manage) AS proj_manage, dbo.contract_info.sign_date, (CASE WHEN ffp.rent IS NULL THEN 0 ELSE ffp.rent END) + ffcp.plan_money AS proj_total, CAST(ff.fact_money AS numeric(10, 2)) AS fact_money, CAST((CASE WHEN ff2.fee IS NULL THEN 0 ELSE ff2.fee END) AS numeric(10, 2)) AS fee_t, CAST((CASE WHEN income2.penalty IS NULL THEN 0 ELSE income2.penalty END) AS numeric(10, 2)) AS penalty_received, frpd.rent_t + (CASE WHEN f1.first_pay1 IS NULL THEN 0 ELSE f1.first_pay1 END) AS rent_due, CASE WHEN fundrp_1.rent2 IS NULL THEN 0 ELSE fundrp_1.rent2 END + CASE WHEN f2.first_pay2 IS NULL THEN 0 ELSE f2.first_pay2 END AS rent_out, CAST(CASE WHEN income1.rent IS NULL THEN 0 ELSE income1.rent END + (CASE WHEN ff3.yishou IS NULL THEN 0 ELSE ff3.yishou END) AS numeric(10, 2)) AS rent_received, (CASE WHEN frpd.rent_t IS NULL THEN 0 ELSE frpd.rent_t END) + (CASE WHEN f1.first_pay1 IS NULL THEN 0 ELSE f1.first_pay1 END) - CAST(CASE WHEN income1.rent IS NULL THEN 0 ELSE income1.rent END + (CASE WHEN ff3.yishou IS NULL THEN 0 ELSE ff3.yishou END) AS numeric(10, 2)) AS yuqi_e, (CASE WHEN ((CASE WHEN frpd.rent_t IS NULL THEN 0 ELSE frpd.rent_t END) + (CASE WHEN f1.first_pay1 IS NULL THEN 0 ELSE f1.first_pay1 END)) - CAST(CASE WHEN income1.rent IS NULL THEN 0 ELSE income1.rent END + (CASE WHEN ff3.yishou IS NULL THEN 0 ELSE ff3.yishou END) AS numeric(10, 2)) > 0 THEN '��' ELSE '��' END) AS yes_faxi, CONVERT(decimal(10, 2), (frpd.rent_t + (CASE WHEN f1.first_pay1 IS NULL THEN 0 ELSE f1.first_pay1 END) - CAST(CASE WHEN income1.rent IS NULL THEN 0 ELSE income1.rent END + (CASE WHEN ff3.yishou IS NULL THEN 0 ELSE ff3.yishou END) AS numeric(10, 2))) / (frpd.rent_t + (CASE WHEN f1.first_pay1 IS NULL THEN 0 ELSE f1.first_pay1 END))) * 1 AS late_p1, CONVERT(decimal(10, 2),(CASE WHEN income1.rent IS NULL THEN 0 ELSE income1.rent END + (CASE WHEN ff3.yishou IS NULL THEN 0 ELSE ff3.yishou END)) / (frpd.rent_t + (CASE WHEN f1.first_pay1 IS NULL THEN 0 ELSE f1.first_pay1 END)) * 1.0) AS received_p1,(CASE WHEN (((CASE WHEN frpd.rent_t IS NULL THEN 0 ELSE frpd.rent_t END) + (CASE WHEN f1.first_pay1 IS NULL THEN 0 ELSE f1.first_pay1 END)) - CAST(CASE WHEN income1.rent IS NULL THEN 0 ELSE income1.rent END + (CASE WHEN ff3.yishou IS NULL THEN 0 ELSE ff3.yishou END) AS numeric(10, 2))) > 0 THEN '��' ELSE '��' END) AS yes_yuqi FROM dbo.contract_info LEFT OUTER JOIN dbo.proj_info ON dbo.proj_info.proj_id = dbo.contract_info.proj_id LEFT OUTER JOIN(SELECT contract_id, SUM(fact_money) AS fact_money FROM dbo.fund_fund_charge WHERE (item_method = '����')and fact_date>='"+start_date+"' and fact_date<='"+end_date+"' GROUP BY contract_id) AS ff ON dbo.contract_info.contract_id = ff.contract_id LEFT OUTER JOIN(SELECT contract_id, SUM(fact_money) AS fee FROM dbo.fund_fund_charge AS fund_fund_charge_1 WHERE (fee_type = '14') and fact_date>='"+start_date+"' and fact_date<='"+end_date+"' GROUP BY contract_id) AS ff2 ON dbo.contract_info.contract_id = ff2.contract_id LEFT OUTER JOIN(SELECT contract_id, plan_date, SUM(plan_money) AS first_pay1 FROM dbo.fund_fund_charge_plan WHERE (fee_type = '11') AND (plan_date <= GETDATE() and plan_date>='"+start_date+"' and plan_date<='"+end_date+"') GROUP BY contract_id, plan_date) AS f1 ON f1.contract_id = dbo.contract_info.contract_id LEFT OUTER JOIN(SELECT contract_id, fact_date, SUM(fact_money) AS yishou FROM dbo.fund_fund_charge AS fund_fund_charge_2 WHERE (fee_type = '11') and fact_date>='"+start_date+"' and fact_date<='"+end_date+"' GROUP BY contract_id, fact_date) AS ff3 ON ff3.contract_id = dbo.contract_info.contract_id LEFT OUTER JOIN (SELECT contract_id, SUM(plan_money) AS first_pay2 FROM  dbo.fund_fund_charge_plan AS fund_fund_charge_plan_2 WHERE  (fee_type = '11') AND (plan_date > GETDATE()) GROUP BY contract_id) AS f2 ON f2.contract_id = dbo.contract_info.contract_id LEFT OUTER JOIN(SELECT contract_id, SUM(rent) AS rent FROM  dbo.fund_rent_income GROUP BY contract_id) AS income1 ON income1.contract_id = dbo.contract_info.contract_id LEFT OUTER JOIN (SELECT contract_id, hire_date, SUM(penalty) AS penalty FROM  dbo.fund_rent_income AS fund_rent_income_1 GROUP BY contract_id, hire_date) AS income2 ON income2.contract_id = dbo.contract_info.contract_id LEFT OUTER JOIN (SELECT contract_id, SUM(plan_money) AS plan_money FROM dbo.fund_fund_charge_plan AS fund_fund_charge_plan_1 WHERE (fee_type = '11') GROUP BY contract_id) AS ffcp ON ffcp.contract_id = dbo.contract_info.contract_id LEFT OUTER JOIN (SELECT contract_id, SUM(rent) AS rent FROM dbo.fund_rent_plan AS fund_rent_plan_1 GROUP BY contract_id) AS ffp ON ffp.contract_id = dbo.contract_info.contract_id LEFT OUTER JOIN (SELECT contract_id, plan_date, SUM(rent) AS rent_t FROM dbo.fund_rent_plan WHERE (plan_date <= GETDATE()) GROUP BY contract_id, plan_date) AS frpd ON frpd.contract_id = dbo.contract_info.contract_id LEFT OUTER JOIN (SELECT contract_id, SUM(rent) AS rent2 FROM dbo.fund_rent_plan AS fund_rent_plan_2 WHERE plan_date > GETDATE() GROUP BY contract_id) AS fundrp_1 ON fundrp_1.contract_id = dbo.contract_info.contract_id "+wherestr+" order by contract_info.project_name ";
//expsqlstr="select * from vi_contract_pays"+wherestr+" order by industry_type asc";
 
 sqlstr="SELECT distinct dbo.contract_info.project_name, dbo.contract_info.contract_id, dbo.contract_info.industry_type, dbo.GETUSERNAME(dbo.contract_info.proj_manage) AS proj_manage, dbo.contract_info.sign_date, (CASE WHEN ffp.rent IS NULL THEN 0 ELSE ffp.rent END) + ffcp.plan_money AS proj_total, CAST(ff.fact_money AS numeric(10, 2)) AS fact_money, CAST((CASE WHEN ff2.fee IS NULL THEN 0 ELSE ff2.fee END) AS numeric(10, 2)) AS fee_t, CAST((CASE WHEN income2.penalty IS NULL THEN 0 ELSE income2.penalty END) AS numeric(10, 2)) AS penalty_received, frpd.rent_t + (CASE WHEN f1.first_pay1 IS NULL THEN 0 ELSE f1.first_pay1 END) AS rent_due, CASE WHEN fundrp_1.rent2 IS NULL THEN 0 ELSE fundrp_1.rent2 END + CASE WHEN f2.first_pay2 IS NULL THEN 0 ELSE f2.first_pay2 END AS rent_out, CAST(CASE WHEN income1.rent IS NULL THEN 0 ELSE income1.rent END + (CASE WHEN ff3.yishou IS NULL THEN 0 ELSE ff3.yishou END) AS numeric(10, 2)) AS rent_received, (CASE WHEN frpd.rent_t IS NULL THEN 0 ELSE frpd.rent_t END) + (CASE WHEN f1.first_pay1 IS NULL THEN 0 ELSE f1.first_pay1 END) - CAST(CASE WHEN income1.rent IS NULL THEN 0 ELSE income1.rent END + (CASE WHEN ff3.yishou IS NULL THEN 0 ELSE ff3.yishou END) AS numeric(10, 2)) AS yuqi_e, (CASE WHEN ((CASE WHEN frpd.rent_t IS NULL THEN 0 ELSE frpd.rent_t END) + (CASE WHEN f1.first_pay1 IS NULL THEN 0 ELSE f1.first_pay1 END)) - CAST(CASE WHEN income1.rent IS NULL THEN 0 ELSE income1.rent END + (CASE WHEN ff3.yishou IS NULL THEN 0 ELSE ff3.yishou END) AS numeric(10, 2)) > 0 THEN '��' ELSE '��' END) AS yes_faxi, CONVERT(decimal(10, 2), (frpd.rent_t + (CASE WHEN f1.first_pay1 IS NULL THEN 0 ELSE f1.first_pay1 END) - CAST(CASE WHEN income1.rent IS NULL THEN 0 ELSE income1.rent END + (CASE WHEN ff3.yishou IS NULL THEN 0 ELSE ff3.yishou END) AS numeric(10, 2))) / (frpd.rent_t + (CASE WHEN f1.first_pay1 IS NULL THEN 0 ELSE f1.first_pay1 END))) * 1 AS late_p1, CONVERT(decimal(10, 2),(CASE WHEN income1.rent IS NULL THEN 0 ELSE income1.rent END + (CASE WHEN ff3.yishou IS NULL THEN 0 ELSE ff3.yishou END)) / (frpd.rent_t + (CASE WHEN f1.first_pay1 IS NULL THEN 0 ELSE f1.first_pay1 END)) * 1.0) AS received_p1,(CASE WHEN (((CASE WHEN frpd.rent_t IS NULL THEN 0 ELSE frpd.rent_t END) + (CASE WHEN f1.first_pay1 IS NULL THEN 0 ELSE f1.first_pay1 END)) - CAST(CASE WHEN income1.rent IS NULL THEN 0 ELSE income1.rent END + (CASE WHEN ff3.yishou IS NULL THEN 0 ELSE ff3.yishou END) AS numeric(10, 2))) > 0 THEN '��' ELSE '��' END) AS yes_yuqi FROM dbo.contract_info LEFT OUTER JOIN dbo.proj_info ON dbo.proj_info.proj_id = dbo.contract_info.proj_id LEFT OUTER JOIN(SELECT contract_id, SUM(fact_money) AS fact_money FROM dbo.fund_fund_charge WHERE (item_method = '����')and fact_date>='"+start_date+"' and fact_date<='"+end_date+"' GROUP BY contract_id) AS ff ON dbo.contract_info.contract_id = ff.contract_id LEFT OUTER JOIN(SELECT contract_id, SUM(fact_money) AS fee FROM dbo.fund_fund_charge AS fund_fund_charge_1 WHERE (fee_type = '14') and fact_date>='"+start_date+"' and fact_date<='"+end_date+"' GROUP BY contract_id) AS ff2 ON dbo.contract_info.contract_id = ff2.contract_id LEFT OUTER JOIN(SELECT contract_id, plan_date, SUM(plan_money) AS first_pay1 FROM dbo.fund_fund_charge_plan WHERE (fee_type = '11') AND (plan_date <= GETDATE() and plan_date>='"+start_date+"' and plan_date<='"+end_date+"') GROUP BY contract_id, plan_date) AS f1 ON f1.contract_id = dbo.contract_info.contract_id LEFT OUTER JOIN(SELECT contract_id, fact_date, SUM(fact_money) AS yishou FROM dbo.fund_fund_charge AS fund_fund_charge_2 WHERE (fee_type = '11') and fact_date>='"+start_date+"' and fact_date<='"+end_date+"' GROUP BY contract_id, fact_date) AS ff3 ON ff3.contract_id = dbo.contract_info.contract_id LEFT OUTER JOIN (SELECT contract_id, SUM(plan_money) AS first_pay2 FROM  dbo.fund_fund_charge_plan AS fund_fund_charge_plan_2 WHERE  (fee_type = '11') AND (plan_date > GETDATE()) GROUP BY contract_id) AS f2 ON f2.contract_id = dbo.contract_info.contract_id LEFT OUTER JOIN(SELECT contract_id, SUM(rent) AS rent FROM  dbo.fund_rent_income GROUP BY contract_id) AS income1 ON income1.contract_id = dbo.contract_info.contract_id LEFT OUTER JOIN (SELECT contract_id, hire_date, SUM(penalty) AS penalty FROM  dbo.fund_rent_income AS fund_rent_income_1 GROUP BY contract_id, hire_date) AS income2 ON income2.contract_id = dbo.contract_info.contract_id LEFT OUTER JOIN (SELECT contract_id, SUM(plan_money) AS plan_money FROM dbo.fund_fund_charge_plan AS fund_fund_charge_plan_1 WHERE (fee_type = '11') GROUP BY contract_id) AS ffcp ON ffcp.contract_id = dbo.contract_info.contract_id LEFT OUTER JOIN (SELECT contract_id, SUM(rent) AS rent FROM dbo.fund_rent_plan AS fund_rent_plan_1 GROUP BY contract_id) AS ffp ON ffp.contract_id = dbo.contract_info.contract_id LEFT OUTER JOIN (SELECT contract_id, plan_date, SUM(rent) AS rent_t FROM dbo.fund_rent_plan WHERE (plan_date <= GETDATE()) GROUP BY contract_id, plan_date) AS frpd ON frpd.contract_id = dbo.contract_info.contract_id LEFT OUTER JOIN (SELECT contract_id, SUM(rent) AS rent2 FROM dbo.fund_rent_plan AS fund_rent_plan_2 WHERE plan_date > GETDATE() GROUP BY contract_id) AS fundrp_1 ON fundrp_1.contract_id = dbo.contract_info.contract_id "+wherestr +"order by contract_id asc";


  
    

%>	
<!--���۵���ѯ��ʼ-->
<div style="width:100%;">
<fieldset style="width:100%;TEXT-ALIGN:center;margin:0px 5px 0px 5px;"> 
  <legend>&nbsp;��ѯ����
<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" style="cursor:hand" title="��ʾ/��������">&nbsp;
</legend>
<table border="0" width="100%" cellspacing="5" cellpadding="0">
<tr>
<td colspan="8">��Ŀ���� <input name="project_name" type="text" size="15" value="<%=project_name %>"></td>
<td>���� <input name="industry_type" type="text" size="15" value="<%=industry_type %>"></td>
<td>��Ŀ����<input name="proj_manage" type="text" size="15" value="<%=proj_manage %>"></td>
</tr>
<tr>
<td colspan="8">�Ƿ�Ϣ<select name="yes_faxi" class="text">
     <script>w(mSetOpt('<%=yes_faxi%>',"|��|��"));</script>
     </select></td>
<td class="text">�Ƿ����� <select name="yes_yuqi" class="text">
     <script>w(mSetOpt('<%=yes_yuqi%>',"|��|��"));</script>
     </select></td>
<td>�ƻ�ʱ��� <input name="start_date" type="text" size="10" readonly dataType="Date" value="<%=start_date %>"><img  onClick="openCalendar(start_date);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
�� <input name="end_date" type="text" size="10" readonly dataType="Date" value="<%=end_date %>">
<img  onClick="openCalendar(end_date);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
<input name="image" type="image" src="../../images/tbtn_searh.gif" alt="��ѯ" align="absmiddle"  onclick="xx.submit()">��ѯ</td>
</tr>

</table>
</fieldset>
</div>

			<!--������Ͳ�������ʼ-->

			<table border="0" width="100%" id="table8" cellspacing="0"
				cellpadding="0" style="margin-top:2px;">
				<tr class="maintab">
					<td align="left" width="1%">

					<!--������ť��ʼ-->
            <table border="0" cellspacing="0" cellpadding="0" >    
                <tr class="maintab">
				<!--
    				<td nowrap><input name="expsqlstr" type="hidden" value="<%=expsqlstr%>">
					<BUTTON class="btn_2" name="btnSave" value="����EXCEL"  type="button" onclick="xx_submit('����EXCEL')">
					<img src="../../images/save.gif" align="absmiddle" border="0">����EXCEL</button>
					</td>
            -->
			<td>
			 <input type="hidden" name="query_sql" id="query_sql" value="<%=expsqlstr%>"/>
					<a href="#" accesskey="n" 
						onClick="isExport()">
						<img   src="../../images/save.gif" alt="����" align="absmiddle">
					</a>
				</tr>
			</table>
<!--������ť����-->
				
					</td>
				<td align="right" width="90%">
		<!--��ҳ���ƿ�ʼ-->
<% 
	int intPageSize = 10;   //һҳ��ʾ�ļ�¼��
	int intRowCount = 0;   //��¼����
	int intPageCount = 1; //��ҳ��
	int intPage;       //����ʾҳ��
	String strPage = getStr( request.getParameter("page") );          //ȡ�ô���ʾҳ��
	if( strPage.equals("") ){                                         //������QueryString��û��page��һ����������ʱ��ʾ��һҳ����
	   intPage = 1;
	}else{
	   intPage = java.lang.Integer.parseInt(strPage);
	   if(intPage<1) intPage = 1;
	} 
//sqlstr="select * from vi_contract_pays"+wherestr+" order by industry_type asc";

//sqlstr="SELECT distinct dbo.contract_info.project_name, dbo.contract_info.contract_id, dbo.contract_info.industry_type, dbo.GETUSERNAME(dbo.contract_info.proj_manage) AS proj_manage, dbo.contract_info.sign_date, (CASE WHEN ffp.rent IS NULL THEN 0 ELSE ffp.rent END) + ffcp.plan_money AS proj_total, CAST(ff.fact_money AS numeric(10, 2)) AS fact_money, CAST((CASE WHEN ff2.fee IS NULL THEN 0 ELSE ff2.fee END) AS numeric(10, 2)) AS fee_t, CAST((CASE WHEN income2.penalty IS NULL THEN 0 ELSE income2.penalty END) AS numeric(10, 2)) AS penalty_received, frpd.rent_t + (CASE WHEN f1.first_pay1 IS NULL THEN 0 ELSE f1.first_pay1 END) AS rent_due, CASE WHEN fundrp_1.rent2 IS NULL THEN 0 ELSE fundrp_1.rent2 END + CASE WHEN f2.first_pay2 IS NULL THEN 0 ELSE f2.first_pay2 END AS rent_out, CAST(CASE WHEN income1.rent IS NULL THEN 0 ELSE income1.rent END + (CASE WHEN ff3.yishou IS NULL THEN 0 ELSE ff3.yishou END) AS numeric(10, 2)) AS rent_received, (CASE WHEN frpd.rent_t IS NULL THEN 0 ELSE frpd.rent_t END) + (CASE WHEN f1.first_pay1 IS NULL THEN 0 ELSE f1.first_pay1 END) - CAST(CASE WHEN income1.rent IS NULL THEN 0 ELSE income1.rent END + (CASE WHEN ff3.yishou IS NULL THEN 0 ELSE ff3.yishou END) AS numeric(10, 2)) AS yuqi_e, (CASE WHEN ((CASE WHEN frpd.rent_t IS NULL THEN 0 ELSE frpd.rent_t END) + (CASE WHEN f1.first_pay1 IS NULL THEN 0 ELSE f1.first_pay1 END)) - CAST(CASE WHEN income1.rent IS NULL THEN 0 ELSE income1.rent END + (CASE WHEN ff3.yishou IS NULL THEN 0 ELSE ff3.yishou END) AS numeric(10, 2)) > 0 THEN '��' ELSE '��' END) AS yes_faxi, CONVERT(decimal(10, 2), (frpd.rent_t + (CASE WHEN f1.first_pay1 IS NULL THEN 0 ELSE f1.first_pay1 END) - CAST(CASE WHEN income1.rent IS NULL THEN 0 ELSE income1.rent END + (CASE WHEN ff3.yishou IS NULL THEN 0 ELSE ff3.yishou END) AS numeric(10, 2))) / (frpd.rent_t + (CASE WHEN f1.first_pay1 IS NULL THEN 0 ELSE f1.first_pay1 END))) * 1 AS late_p1, CONVERT(decimal(10, 2),(CASE WHEN income1.rent IS NULL THEN 0 ELSE income1.rent END + (CASE WHEN ff3.yishou IS NULL THEN 0 ELSE ff3.yishou END)) / (frpd.rent_t + (CASE WHEN f1.first_pay1 IS NULL THEN 0 ELSE f1.first_pay1 END)) * 1.0) AS received_p1,(CASE WHEN (((CASE WHEN frpd.rent_t IS NULL THEN 0 ELSE frpd.rent_t END) + (CASE WHEN f1.first_pay1 IS NULL THEN 0 ELSE f1.first_pay1 END)) - CAST(CASE WHEN income1.rent IS NULL THEN 0 ELSE income1.rent END + (CASE WHEN ff3.yishou IS NULL THEN 0 ELSE ff3.yishou END) AS numeric(10, 2))) > 0 THEN '��' ELSE '��' END) AS yes_yuqi FROM dbo.contract_info LEFT OUTER JOIN dbo.proj_info ON dbo.proj_info.proj_id = dbo.contract_info.proj_id LEFT OUTER JOIN(SELECT contract_id, SUM(fact_money) AS fact_money FROM dbo.fund_fund_charge WHERE (item_method = '����')and fact_date>='"+start_date+"' and fact_date<='"+end_date+"' GROUP BY contract_id) AS ff ON dbo.contract_info.contract_id = ff.contract_id LEFT OUTER JOIN(SELECT contract_id, SUM(fact_money) AS fee FROM dbo.fund_fund_charge AS fund_fund_charge_1 WHERE (fee_type = '14') and fact_date>='"+start_date+"' and fact_date<='"+end_date+"' GROUP BY contract_id) AS ff2 ON dbo.contract_info.contract_id = ff2.contract_id LEFT OUTER JOIN(SELECT contract_id, plan_date, SUM(plan_money) AS first_pay1 FROM dbo.fund_fund_charge_plan WHERE (fee_type = '11') AND (plan_date <= GETDATE() and plan_date>='"+start_date+"' and plan_date<='"+end_date+"') GROUP BY contract_id, plan_date) AS f1 ON f1.contract_id = dbo.contract_info.contract_id LEFT OUTER JOIN(SELECT contract_id, fact_date, SUM(fact_money) AS yishou FROM dbo.fund_fund_charge AS fund_fund_charge_2 WHERE (fee_type = '11') and fact_date>='"+start_date+"' and fact_date<='"+end_date+"' GROUP BY contract_id, fact_date) AS ff3 ON ff3.contract_id = dbo.contract_info.contract_id LEFT OUTER JOIN (SELECT contract_id, SUM(plan_money) AS first_pay2 FROM  dbo.fund_fund_charge_plan AS fund_fund_charge_plan_2 WHERE  (fee_type = '11') AND (plan_date > GETDATE()) GROUP BY contract_id) AS f2 ON f2.contract_id = dbo.contract_info.contract_id LEFT OUTER JOIN(SELECT contract_id, SUM(rent) AS rent FROM  dbo.fund_rent_income GROUP BY contract_id) AS income1 ON income1.contract_id = dbo.contract_info.contract_id LEFT OUTER JOIN (SELECT contract_id, hire_date, SUM(penalty) AS penalty FROM  dbo.fund_rent_income AS fund_rent_income_1 GROUP BY contract_id, hire_date) AS income2 ON income2.contract_id = dbo.contract_info.contract_id LEFT OUTER JOIN (SELECT contract_id, SUM(plan_money) AS plan_money FROM dbo.fund_fund_charge_plan AS fund_fund_charge_plan_1 WHERE (fee_type = '11') GROUP BY contract_id) AS ffcp ON ffcp.contract_id = dbo.contract_info.contract_id LEFT OUTER JOIN (SELECT contract_id, SUM(rent) AS rent FROM dbo.fund_rent_plan AS fund_rent_plan_1 GROUP BY contract_id) AS ffp ON ffp.contract_id = dbo.contract_info.contract_id LEFT OUTER JOIN (SELECT contract_id, plan_date, SUM(rent) AS rent_t FROM dbo.fund_rent_plan WHERE (plan_date <= GETDATE()) GROUP BY contract_id, plan_date) AS frpd ON frpd.contract_id = dbo.contract_info.contract_id LEFT OUTER JOIN (SELECT contract_id, SUM(rent) AS rent2 FROM dbo.fund_rent_plan AS fund_rent_plan_2 WHERE plan_date > GETDATE() GROUP BY contract_id) AS fundrp_1 ON fundrp_1.contract_id = dbo.contract_info.contract_id "+wherestr +"order by contract_id asc";    
System.out.println("sqlstr=================="+sqlstr);


rs = db.executeQuery(sqlstr); 

ResultSetMetaData rsmd = rs.getMetaData();
int numberOfColumns = rsmd.getColumnCount();

	rs.last();                                                       //��ȡ��¼����
	intRowCount = rs.getRow();
	intPageCount = ( intRowCount + intPageSize - 1) / intPageSize;   //������ҳ��
	if( intPage > intPageCount ) intPage = intPageCount;             //��������ʾ��ҳ��
	if( intPageCount > 0 )
	   rs.absolute( ( intPage-1 ) * intPageSize + 1 );               //����¼ָ�붨λ������ʾҳ�ĵ�һ����¼��
	int i = 0;
%>



<table border="0" cellspacing="0" cellpadding="0">
  <tr class="maintab">
	<script>
		var cp = <%= intPage %>;
		var lp = <%= intPageCount %>;
		var nf = document.dataNav;
	</script>
    <td nowrap>�� <%=intRowCount%> �� / <%=intPageCount%> ҳ 
	<%if(intPage>1){%>	<img align="absmiddle" style="cursor:pointer; " onClick="goPage('first')" src="../../images/ico_first.gif" alt="��һҳ" border="0"><img align="absmiddle" style="cursor:pointer; " onClick="goPage('prev')" src="../../images/ico_prev.gif" alt="��һҳ"    border="0">
	<%}else{%><img align="absmiddle" style="filter:Gray;" src="../../images/ico_first.gif" alt="��һҳ"  border="0"><img align="absmiddle" style="filter:Gray;" src="../../images/ico_prev.gif" alt="��һҳ" border="0"><% } %>
	�� <font color="red"><%=intPage%></font> ҳ	
	<%if(intPage<intPageCount){%> <img align="absmiddle" style="cursor:pointer; " onClick="goPage('next')" src="../../images/ico_next.gif" alt="��һҳ" border="0"><img align="absmiddle" style="cursor:pointer; " onClick="goPage('last')" src="../../images/ico_last.gif" alt="���ҳ" border="0">
	<%}else{%><img align="absmiddle" style="filter:Gray;" src="../../images/ico_next.gif" alt="��һҳ" border="0"><img align="absmiddle" style="filter:Gray;" src="../../images/ico_last.gif" alt="���ҳ" border="0"><% } %></td>
	
    <td nowrap><img align="absmiddle" src="../../images/sbtn_split.gif"></td>
    
    <td nowrap>ת�� <input name="page" type="text" size="2" value="1"> ҳ <img align="absmiddle" style="cursor:pointer; " onClick="goPage('jump')" src="../../images/goto.gif" alt="ִ��" border="0" align="absmiddle"></td>
 </tr>
</table>

</td>
</tr>
</table>

        <!--��ҳ���ƽ���-->
						
					</td>
				</tr>
			</table>
			<!--����ʼ-->
			<div
				style="vertical-align:top;width:100%;overflow:auto;position: relative;"
				id="mydiv";>

					<table border="0" style="border-collapse:collapse;" align="center"
						cellpadding="2" cellspacing="1" width="100%"
						class="maintab_content_table">
						<tr class="maintab_content_table_title">
						<!--  <th width="1%"></th> -->					
							 				
        <th width='80'>��Ŀ����</th>
        <th width='80'>��Ŀ���</th>
        <th>��Ŀ����</th>
        <th>����</th>
		<th>��ͬ��</th>
        <th>ǩԼ��</th>
        <th>�Ѹ���</th>
        <th>����������</th>
		<th>Ӧ�յ������</th>
        <th>Ӧ��δ�������</th>
        <th>�������</th>
        <th>���շ�Ϣ</th>
        <th>����ռ��</th>
        <th>���ڶ�</th>
        <th>����ռ��</th>
     
						</tr>
						<%	  
rs.previous();

if ( rs.next() ) {
	while( i < intPageSize && !rs.isAfterLast() ) {
%>

		<tr>
		<!--  
		<td></td>
        <td align="center"></td>
        -->
        <td align="center"><%=getDBStr(rs.getString("project_name"))%></td>
        <td align="center"><%=getDBStr(rs.getString("contract_id"))%></td>
        <td align="center"><%=getDBStr(rs.getString("proj_manage"))%></td>
        <td align="center"><%=getDBStr(rs.getString("industry_type")) %></td>
        <td align="center"><%=getDBStr(rs.getString("proj_total")) %></td>
		<td align="center"><%=getDBDateStr(rs.getString("sign_date"))%></td>
		<td align="center"><%=getDBStr(rs.getString("fact_money"))%></td>
        <td align="center"><%=getDBStr(rs.getString("fee_t")) %></td>
        <td align="center"><%=getDBStr(rs.getString("rent_due")) %></td>
        <td align="center"><%=formatNumberDoubleTwo(rs.getString("rent_out")) %></td>
        <td align="center"><%=formatNumberDoubleTwo(rs.getString("rent_received")) %></td>
        <td align="center"><%=formatNumberDoubleTwo(rs.getString("penalty_received")) %></td>
		<td align="center"><%=getDBStr(rs.getString("received_p1")) %>%</td>
		<td align="center"><%=formatNumberDoubleTwo(rs.getString("yuqi_e")) %></td>
		<td align="center"><%=getDBStr(rs.getString("late_p1")) %>%</td>
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

			<!--�������-->
		</form>
	</body>
</html>

</script>
<script type="text/javascript">
//����Excel
function isExport() {
	if (confirm("�Ƿ�ȷ�ϵ���Excel!")) {
		var form1 = document.getElementById("dataNav");
		dataNav.action="texport_save.jsp";
  		form1.submit();
		dataNav.action="contract_pay.jsp";
	}
    
	return false;
}
</script>
















