<%@ page contentType="text/html; charset=gbk" language="java"  %>
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common.jsp"%>
<jsp:useBean id="right" scope="page" class="com.filter.FilterCredit" />
<%!public String getMenoStr(String str)  //request字符串中文处理
{
	try
	{
		String temp_p=str;
		if(str.indexOf(".")==0||str.indexOf(".")==-1){
			return "";
		}else if(str.indexOf("。")==0||str.length()>1){
			return str.substring(1,str.length());
		}
	}
	catch(Exception e)
	{
	 
	}
	return "";
}%>
<%
String dqczy=(String) session.getAttribute("czyid");
if ((dqczy==null) || (dqczy.equals("")))
{
  dqczy="无认证";
  response.sendRedirect("../../noright.jsp");
}
int canedit=0;
if (right.CheckRight("contract-htxs-list",dqczy)>0) canedit=1;
if (canedit==0) response.sendRedirect("../../noright.jsp");
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>合同文件&gt;合同管理 </title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
</head>

<body  onload="public_onload(0)">
<form action="htxs_list.jsp" name="dataNav" onSubmit="return goPage()">
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
			<tr class="tree_title_txt">
				<td nowrap width="100%" class="tree_title_txt" 

valign="middle" id="cwCellTopTitTxt">
				合同管理 &gt; 合同文件</td>
			</tr>
</table>
<%
String searchFld = getStr( request.getParameter("searchFld") );
String searchKey = getStr( request.getParameter("searchKey") );
ResultSet rs;
String wherestr = " where 1=1";
if( searchFld.equals("客户名称") ) {
	wherestr += "and dbo.getcustnamebycontractid(info.contract_id) like '%"+searchKey+"%'";
}else if( searchFld.equals("合同编号") ) {
	wherestr += "and info.contract_id like '%"+searchKey+"%'";
}else{
	wherestr += " ";
}
String sqlstr="select distinct dbo.getcustnamebycontractid(info.contract_id) as cust_name,dbo.getcustcode(info.cust_id) as custcode,info.contract_id,UPPER(isnull(substring(contract_approve_status,0,charindex('_',contract_approve_status)),'')) as approve_place,dbo.fk_getname(info.vndr_id) as vndr_id,dbo.fk_getname(info.proj_dept) as proj_dept,filiale.province,(select top 1 isnull(rent,0)+isnull(rent_adjust,0) from fund_rent_plan where contract_id=info.contract_id and datediff(dd,plan_date,getdate())<=0 order by id) as rent,(convert(varchar(2),(convert(decimal(2,0),first_payment_ratio)))+''+convert(varchar(2),(convert(decimal(2,0),income_number)))) as leas_mode,equip.equip_num,dbo.getmodelbyid(equip.device_type) as decive_type,equip.equip_sn,time.receive_date,condition.actual_start_date,condition.income_day,dbo.getapprovedstatus(info.contract_id) as approve_status,time.csmd_receive_date,dbo.getattach(info.contract_id) as attach_memo,(select case  list.head_contract when '0' then '否' when '1' then '是' else '不要' end from contract_list_info as list where list.contract_id=info.contract_id and contract_list_ID=037) as lease_fag,(select list.attach_memo from contract_list_info as list where list.contract_id=info.contract_id and contract_list_ID=037) as lease_fag_meno,(select case  list.head_contract when '0' then '否' when '1' then '是' else '不要' end from contract_list_info as list where list.contract_id=info.contract_id and contract_list_ID=038) as guarantor_fag,(select list.attach_memo from contract_list_info as list where list.contract_id=info.contract_id and contract_list_ID=038) as guarantor_fag_meno,(select case  list.head_contract when '0' then '否' when '1' then '是' else '不要' end from contract_list_info as list where list.contract_id=info.contract_id and contract_list_ID=039) as plan_fag,(select list.attach_memo from contract_list_info as list where list.contract_id=info.contract_id and contract_list_ID=039) as plan_fag_meno,(select case  list.head_contract when '0' then '否' when '1' then '是' else '不要' end from contract_list_info as list where list.contract_id=info.contract_id and contract_list_ID=040) as approve_fag,(select list.attach_memo from contract_list_info as list where list.contract_id=info.contract_id and contract_list_ID=040) as approve_fag_meno,(select case  list.head_contract when '0' then '否' when '1' then '是' else '不要' end from contract_list_info as list where list.contract_id=info.contract_id and contract_list_ID=042) as lease_con_fag,(select list.attach_memo from contract_list_info as list where list.contract_id=info.contract_id and contract_list_ID=042) as lease_con_fag_meno,(select case  list.head_contract when '0' then '否' when '1' then '是' else '不要' end from contract_list_info as list where list.contract_id=info.contract_id and contract_list_ID=043) as guaranty_fag,(select list.attach_memo from contract_list_info as list where list.contract_id=info.contract_id and contract_list_ID=043) as guaranty_fag_meno,(select case  list.head_contract when '0' then '否' when '1' then '是' else '不要' end from contract_list_info as list where list.contract_id=info.contract_id and contract_list_ID=044) as equip_fag,(select list.attach_memo from contract_list_info as list where list.contract_id=info.contract_id and contract_list_ID=044) as equip_fag_meno,(select case  list.head_contract when '0' then '否' when '1' then '是' else '不要' end from contract_list_info as list where list.contract_id=info.contract_id and contract_list_ID=045) as guarantee_fag,(select list.attach_memo from contract_list_info as list where list.contract_id=info.contract_id and contract_list_ID=045) as guarantee_fag_meno,(select case  list.head_contract when '0' then '否' when '1' then '是' else '不要' end from contract_list_info as list where list.contract_id=info.contract_id and contract_list_ID=046) as buy_fag,(select list.attach_memo from contract_list_info as list where list.contract_id=info.contract_id and contract_list_ID=046) as buy_fag_meno,(select case  list.head_contract when '0' then '否' when '1' then '是' else '不要' end from contract_list_info as list where list.contract_id=info.contract_id and contract_list_ID=047) as invoice_fag,(select list.attach_memo from contract_list_info as list where list.contract_id=info.contract_id and contract_list_ID=047) as invoice_fag_meno,(select case  list.head_contract when '0' then '否' when '1' then '是' else '不要' end from contract_list_info as list where list.contract_id=info.contract_id and contract_list_ID=048) as confer_fag,(select list.attach_memo from contract_list_info as list where list.contract_id=info.contract_id and contract_list_ID=048) as confer_fag_meno,(select case  list.head_contract when '0' then '否' when '1' then '是' else '不要' end from contract_list_info as list where list.contract_id=info.contract_id and contract_list_ID=049) as code_fag,(select list.attach_memo from contract_list_info as list where list.contract_id=info.contract_id and contract_list_ID=049) as code_fag_meno,(select case  list.head_contract when '0' then '否' when '1' then '是' else '不要' end from contract_list_info as list where list.contract_id=info.contract_id and contract_list_ID=050) as payment_fag,(select list.attach_memo from contract_list_info as list where list.contract_id=info.contract_id and contract_list_ID=050) as payment_fag_meno,(select case  list.head_contract when '0' then '否' when '1' then '是' else '不要' end from contract_list_info as list where list.contract_id=info.contract_id and contract_list_ID=051) as product_fag,(select list.attach_memo from contract_list_info as list where list.contract_id=info.contract_id and contract_list_ID=051) as product_fag_meno,(select case  list.head_contract when '0' then '否' when '1' then '是' else '不要' end from contract_list_info as list where list.contract_id=info.contract_id and contract_list_ID=052) as gps_fag,(select list.attach_memo from contract_list_info as list where list.contract_id=info.contract_id and contract_list_ID=052) as gps_fag_meno,(select case  list.head_contract when '0' then '否' when '1' then '是' else '不要' end from contract_list_info as list where list.contract_id=info.contract_id and contract_list_ID=053) as consent_fag,(select list.attach_memo from contract_list_info as list where list.contract_id=info.contract_id and contract_list_ID=053) as consent_fag_meno,(select case  list.head_contract when '0' then '否' when '1' then '是' else '不要' end from contract_list_info as list where list.contract_id=info.contract_id and contract_list_ID=054) as insure_fag,(select list.attach_memo from contract_list_info as list where list.contract_id=info.contract_id and contract_list_ID=054) as insure_fag_meno,(select case  list.head_contract when '0' then '否' when '1' then '是' else '不要' end from contract_list_info as list where list.contract_id=info.contract_id and contract_list_ID=055) as insure_invoice_fag,(select list.attach_memo from contract_list_info as list where list.contract_id=info.contract_id and contract_list_ID=055) as insure_invoice_fag_meno,(select case  list.head_contract when '0' then '否' when '1' then '是' else '不要' end from contract_list_info as list where list.contract_id=info.contract_id and contract_list_ID=056) as csa_confer_fag,(select list.attach_memo from contract_list_info as list where list.contract_id=info.contract_id and contract_list_ID=056) as csa_confer_fag_meno,(select case  list.head_contract when '0' then '否' when '1' then '是' else '不要' end from contract_list_info as list where list.contract_id=info.contract_id and contract_list_ID=057) as csa_invoice_fag,(select list.attach_memo from contract_list_info as list where list.contract_id=info.contract_id and contract_list_ID=057) as csa_invoice_fag_meno,accep.accept_method,accep.memo,proj.approve_date,time.document_date,time.payment_date,time.fund_date,his.receive_date,time.send_date,time.receive_date,time.branch_expdate from contract_info as info left join base_filiale_province as filiale on (info.proj_dept=filiale.filiale_id) left join contract_equip as equip on (info.contract_id=equip.contract_id) left join contract_condition as condition on (info.contract_id=condition.contract_id) left join contract_time_info as time on (info.contract_id=time.contract_id) left join equip_acceptance as accep on (info.contract_id=accep.contract_id) left join proj_info as proj on (info.proj_id=proj.proj_id) left join fund_down_payment_his as his on (info.contract_id=his.contract_id) "+ wherestr +" order by contract_id desc";
System.out.println(sqlstr);
%>
	
<table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:2px;">
			<tr class="maintab">
				<td align="left" colspan="2">
					&nbsp;按&nbsp;<select name="searchFld"><script>w(mSetOpt("<%= searchFld %>","|合同编号|客户名称"));</script></select>&nbsp;查询&nbsp;<input name="searchKey" accesskey="s" type="text" size="15" value="<%= searchKey %>">
		<input name="image" type="image" src="../../images/tbtn_searh.gif" alt="查询" align="absmiddle"  onclick="searchbar.submit();">
				</td>
			<!--</tr>
			<tr class="maintab">-->
				<td align="left" width="1%">
<!--操作按钮开始-->
<!--操作按钮结束-->
</td>
					 <td align="right" width="50%">
					 	
					 	
<!--翻页控制开始-->
<%
int intPageSize = 15;   //一页显示的记录数
	int intRowCount = 0;   //记录总数
	int intPageCount = 1; //总页数

	int intPage;       //待显示页码
	String strPage = getStr( request.getParameter("page") );          //取得待显示页码
	if( strPage.equals("") ){                                         //表明在QueryString

//中没有page这一个参数，此时显示第一页数据
	 intPage = 1;
	}else{
	  intPage = java.lang.Integer.parseInt(strPage);
	  if(intPage<1) intPage = 1;
	} 
rs=db.executeQuery(sqlstr); 


	rs.last();                                                  //获取记录总数
	intRowCount = rs.getRow();
	intPageCount = (intRowCount+intPageSize-1) / intPageSize;   //记算总页数
	if(intPage>intPageCount) intPage = intPageCount;            //调整待显示的页码
	if(intPageCount>0)
	   rs.absolute((intPage-1) * intPageSize + 1);              //将记录指针定位到待显示

//页的第一条记录上
	int i = 0; %>

<table border="0" cellspacing="0" cellpadding="0">
  <tr class="maintab">
	<script>
		var cp = <%= intPage %>;
		var lp = <%= intPageCount %>;
		var nf = document.dataNav;
	</script>
    <td nowrap>共 <%=intRowCount%> 条 / <%=intPageCount%> 页 
	<%if(intPage>1){%>	<img align="absmiddle" style="cursor:pointer; " 

onClick="goPage('first')" src="../../images/ico_first.gif" alt="第一页" border="0"><img 

align="absmiddle" style="cursor:pointer; " onClick="goPage('prev')" 

src="../../images/ico_prev.gif" alt="上一页"    border="0">
	<%}else{%><img align="absmiddle" style="filter:Gray;" 

src="../../images/ico_first.gif" alt="第一页"  border="0"><img align="absmiddle" 

style="filter:Gray;" src="../../images/ico_prev.gif" alt="上一页" border="0"><% } %>
	第 <font color="red"><%=intPage%></font> 页	
	<%if(intPage<intPageCount){%> <img align="absmiddle" style="cursor:pointer; " 

onClick="goPage('next')" src="../../images/ico_next.gif" alt="下一页" border="0"><img 

align="absmiddle" style="cursor:pointer; " onClick="goPage('last')" 

src="../../images/ico_last.gif" alt="最后页" border="0">
	<%}else{%><img align="absmiddle" style="filter:Gray;" src="../../images/ico_next.gif" 

alt="下一页" border="0"><img align="absmiddle" style="filter:Gray;" 

src="../../images/ico_last.gif" alt="最后页" border="0"><% } %></td>
	
    <td nowrap><img align="absmiddle" src="../../images/sbtn_split.gif"></td>
    
    <td nowrap>转到 <input name="page" type="text" size="2" value="1"> 页 <img 

align="absmiddle" style="cursor:pointer; " onClick="goPage('jump')" 

src="../../images/goto.gif" alt="执行" border="0" align="absmiddle"></td>
 </tr>
</table>

<!-- end cwCellTop -->
</td>
</tr>
</table>
<div style="vertical-align:top;height:200px;width:100%;overflow:auto;position: relative; 

left: 0px; top: 0px"  id="mydiv";>

<form action="khmpxx_list.jsp" name="dataNav">

    <table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" 
		cellspacing="1" width="100%" class="maintab_content_table">
      <tr class="maintab_content_table_title">
<th>客户名&nbsp;&nbsp;&nbsp;&nbsp;</th>
<th>身份证号</th>
<th>合同编号</th>
<th>文件所在地</th>
<th>供应商&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>
<th>分公司</th>
<th>省份</th>
<th>月租金</th>
<th>融资模式</th>
<th>台数</th>
<th>型号</th>
<th>机器编号</th>
<th>收到文件日期</th>
<th>租赁起始日&nbsp;&nbsp;</th>
<th>分期租金支付日</th>
<th>文件状态</th>
<th>CSMD文件登记</th>
<th>不合格文件汇总</th>
<th>客户融资申请</th>
<th>备注</th>
<th>担保人信息表</th>
<th>备注</th>
<th>还款计划表</th>
<th>备注</th>
<th>信审标准</th>
<th>备注</th>
<th>融资合同</th>
<th>融资合同备注</th>
<th>担保书</th>
<th>担保书备注</th>
<th>租赁物交付证明书</th>
<th>租赁物交付证明书备注</th>
<th>抵押合同</th>
<th>抵押合同备注</th>
<th>购买合同</th>
<th>购买合同备注</th>
<th>设备发票</th>
<th>设备发票备注</th>
<th>授权扣款协议书</th>
<th>授权扣款协议书备注</th>
<th>建行借记卡复印件</th>
<th>龙卡卡号</th>
<th>期初付款文件</th>
<th>期初付款文件备注</th>
<th>产品合格证</th>
<th>产品合格证备注</th>
<th>GPS</th>
<th>GPS备注</th>
<th>保险事宜承诺书</th>
<th>保险事宜承诺书备注</th>
<th>保单</th>
<th>保单备注</th>
<th>发票</th>
<th>发票备注</th>
<th>CSA协议发票</th>
<th>CSA协议发票备注</th>
<th>CSA发票</th>
<th>CSA发票备注</th>
<th>验收报告</th>
<th>设备验收备注</th>
<th>信审日期</th>
<th>文件完整日期</th>
<th>递交付款文件日期</th>
<th>付款日期</th>
<th>首付发票</th>
<th>文件回寄日期</th>
<th>分公司收到文件日期</th>
<th>分公司转交客户日期</th>
</tr>
	  
<%
if(intRowCount!=0){
	while(i<intPageSize && !rs.isAfterLast()){
%>
	  
      <tr class="cwDLRow" >
		<td><%=getDBStr( rs.getString("cust_name"))%></td>
        <td><%=getDBStr( rs.getString("custcode"))%></td>
        <td><%=getDBStr( rs.getString("contract_id"))%></td>
        <td><%=getDBStr( rs.getString("approve_place"))%></td>
        <td><%=getDBStr( rs.getString("vndr_id"))%></td>
        <td><%=getDBStr( rs.getString("proj_dept"))%></td>
        <td><%=getDBStr( rs.getString("province"))%></td>
        <td><%=formatNumberStr( rs.getString("rent"),"#,##0.00")%></td>
        <td><%=getDBStr( rs.getString("leas_mode"))%></td>
        <td><%=getDBStr( rs.getString("equip_num"))%></td>
        <td><%=getDBStr( rs.getString("decive_type"))%></td>
        <td><%=getDBStr( rs.getString("equip_sn"))%></td>
        <td><%=getDBDateStr( rs.getString("receive_date"))%></td>
        <td><%=getDBDateStr( rs.getString("actual_start_date"))%></td>
        <td>每月<%=getDBStr( rs.getString("income_day"))%>号</td>
        <td><%=getDBStr( rs.getString("approve_status"))%></td>
        <td><%=getDBDateStr( rs.getString("csmd_receive_date"))%></td>
        <td><%=getMenoStr( rs.getString("attach_memo"))%></td>
        <td><%=getDBStr( rs.getString("lease_fag"))%></td>
        <td><%=getMenoStr( rs.getString("lease_fag_meno"))%></td>
        <td><%=getDBStr( rs.getString("guarantor_fag"))%></td>
        <td><%=getMenoStr( rs.getString("guarantor_fag_meno"))%></td>
        <td><%=getDBStr( rs.getString("plan_fag"))%></td>
        <td><%=getMenoStr( rs.getString("plan_fag_meno"))%></td>
        <td><%=getDBStr( rs.getString("approve_fag"))%></td>
        <td><%=getMenoStr( rs.getString("approve_fag_meno"))%></td>
        <td><%=getDBStr( rs.getString("lease_con_fag"))%></td>
        <td><%=getMenoStr( rs.getString("lease_con_fag_meno"))%></td>
        <td><%=getDBStr( rs.getString("guaranty_fag"))%></td>
        <td><%=getMenoStr( rs.getString("guaranty_fag_meno"))%></td>
        <td><%=getDBStr( rs.getString("equip_fag"))%></td>
        <td><%=getMenoStr( rs.getString("equip_fag_meno"))%></td>
        <td><%=getDBStr( rs.getString("guarantee_fag"))%></td>
        <td><%=getMenoStr( rs.getString("guarantee_fag_meno"))%></td>
        <td><%=getDBStr( rs.getString("buy_fag"))%></td>
        <td><%=getMenoStr( rs.getString("buy_fag_meno"))%></td>
        <td><%=getDBStr( rs.getString("invoice_fag"))%></td>
        <td><%=getMenoStr( rs.getString("invoice_fag_meno"))%></td>
        <td><%=getDBStr( rs.getString("confer_fag"))%></td>
        <td><%=getMenoStr( rs.getString("confer_fag_meno"))%></td>
        <td><%=getDBStr( rs.getString("code_fag"))%></td>
        <td><%=getMenoStr( rs.getString("code_fag_meno"))%></td>
        <td><%=getDBStr( rs.getString("payment_fag"))%></td>
        <td><%=getMenoStr( rs.getString("payment_fag_meno"))%></td>
        <td><%=getDBStr( rs.getString("product_fag"))%></td>
        <td><%=getMenoStr( rs.getString("product_fag_meno"))%></td>
        <td><%=getDBStr( rs.getString("gps_fag"))%></td>
        <td><%=getMenoStr( rs.getString("gps_fag_meno"))%></td>
        <td><%=getDBStr( rs.getString("consent_fag"))%></td>
        <td><%=getMenoStr( rs.getString("consent_fag_meno"))%></td>
        <td><%=getDBStr( rs.getString("insure_fag"))%></td>
        <td><%=getMenoStr( rs.getString("insure_fag_meno"))%></td>
        <td><%=getDBStr( rs.getString("insure_invoice_fag"))%></td>
        <td><%=getMenoStr( rs.getString("insure_invoice_fag_meno"))%></td>
        <td><%=getDBStr( rs.getString("csa_confer_fag"))%></td>
        <td><%=getMenoStr( rs.getString("csa_confer_fag_meno"))%></td>
        <td><%=getDBStr( rs.getString("csa_invoice_fag"))%></td>
        <td><%=getMenoStr( rs.getString("csa_invoice_fag_meno"))%></td>
        <td><%=getDBStr( rs.getString("accept_method"))%></td>
        <td><%=getDBStr( rs.getString("memo"))%></td>
        <td><%=getDBDateStr( rs.getString("approve_date"))%></td>
        <td><%=getDBDateStr( rs.getString("document_date"))%></td>
        <td><%=getDBDateStr( rs.getString("payment_date"))%></td>
        <td><%=getDBDateStr( rs.getString("fund_date"))%></td>
        <td><%=getDBDateStr( rs.getString("receive_date"))%></td>
        <td><%=getDBDateStr( rs.getString("send_date"))%></td>
        <td><%=getDBDateStr( rs.getString("receive_date"))%></td>
        <td><%=getDBDateStr( rs.getString("branch_expdate"))%></td>
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
	</form>


<!-- end cwDataNav -->

</div>
<!-- end cwCellContent -->



<!-- end cwMain -->
</body>
</html>
