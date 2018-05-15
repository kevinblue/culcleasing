<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*" %> 
<%@ page import="com.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<jsp:useBean id="db1" scope="page" class="dbconn.Conn" /> 
<jsp:useBean id="right" scope="page" class="com.filter.FilterCredit" /> 
<%@ include file="../../func/common.jsp"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<link href="../../css/global.css" rel="stylesheet" type="text/css">
</head>

<body>
<object codebase="http://leasing.tenwa.com/wsReport.cab#version=4,6,0,1" classid="clsid:08D91289-1761-4006-8294-FDE48B9F29BD" width="100%" height="100%" id="obj"></object>

<%
String dqczy=(String) session.getAttribute("czyid");

//--------以上为权限控制-----------------------------
String sqlstr;
ResultSet rs;
ResultSet rs1;

String curr_date = getSystemDate(0);
String czid = getStr( request.getParameter("czid") );
String stype = getStr( request.getParameter("savetype") );



String s_date = getStr( request.getParameter("s_date") );	//开始日期
String e_date = getStr( request.getParameter("e_date") );	//结束日期
String bad_date = getStr( request.getParameter("bad_date") );	//逾期结算日期
String print_flag= getStr( request.getParameter("print_flag") );//打印标志
String searchFld = getStr( request.getParameter("searchFld") );
String searchKey = getStr( request.getParameter("searchKey") );

String end_date="";//租赁合同结束日期：如果要发送的租赁通知书的日期＝保证金抵扣到的期项则取该期项的偿还计划日期
String c_punish="";//当期罚息
String hire_date="";//对于已经没有预期租金的期项，计算逾期天数时逾期天数的结束日期应该是该期回笼的最后一次日期


String client_postcode="";
String client_address="";
String client_address1="";
String client_address2="";
String cust_name="";
String client_linkman="";
String phone="";
String contract_id="";
String curr_plan_date="";
String curr_rent="";
String curr_rent_list="";

String pena_rate="";
String lessor_name="";
String bank_name="";
String lease_acc_number="";

String total_money="";
String total_money_bad="";
String curr_badRent="";
String curr_punishInterest="";
String line_str1="";
String line_str2="";
String line_str3="";
String line_str4="";
String line_str5="";
String line_str6="";
String pre_rent_list="";
String pre_pre_rent_list="";
String pre_pre_pre_rent_list="";
String pre_rent="";
String pre_pre_rent="";
String pre_pre_pre_rent="";
String pre_days="";
String pre_pre_days="";
String pre_pre_pre_days="";
String pre_punish="";
String pre_pre_punish="";
String pre_pre_pre_punish="";

String nominalprice="";
String deduRent="";
String deduList="";
String deduList_money="";//可抵扣保证金：交易结构中的承租客户的可抵扣保证金与剩余保证金之中的小者
String show_flag="";//是否显示ｗｏｒｄ文档中红字部分:1不显示，０显示
//String filepath="d:/新租赁系统付款通知书样稿96.jpg";
String filepath="http://192.168.1.21:9080/sealA4.jpg";

String notice_contact="";
String notice_content="";
String notice_explanation="";
String notice_note="";









//---------------------------
%>

<!--翻页控制开始-->


<script language="VBScript">
'obj.SetBackGround ("<%=filepath%>") '加载票据背景
obj.Init
obj.PageSize = 3	'A4
obj.SetTextColor RGB(0, 0, 0)
obj.SetOutline 0, 0, 2, 0, RGB(0, 0, 0)

obj.LeftMargin=107
obj.TopMargin=16

obj.SetFont "宋体", 1
obj.SetFontSize 15
obj.SetFontStyle 0,1,0

obj.DrawObject "", "http://192.168.1.21:9080/sealA4.jpg", 1, "", 5, "1,2,3,4", "", "false,1"

<% if(client_address.length()<=30){%>
obj.DrawObject "<%=client_postcode%>", "", 0, "", 1, "1,2,3,4", "0,84", "false,2"
obj.DrawObject "<%=client_address%>", "", 0, "", 1, "1,2,3,4", "0,108", "false,2"
<%}else{%>
obj.DrawObject "<%=client_postcode%>", "", 0, "", 1, "1,2,3,4", "0,60", "false,2"

obj.DrawObject "<%=client_address1%>", "", 0, "", 1, "1,2,3,4", "0,84", "false,2"
obj.DrawObject "<%=client_address2%>", "", 0, "", 1, "1,2,3,4", "0,108", "false,2"
<%}%>


obj.DrawObject "<%=cust_name%>", "", 0, "", 1, "1,2,3,4", "0,134", "false,2"
obj.DrawObject "<%=client_linkman%>", "", 0, "", 1, "1,2,3,4", "0,158", "false,2"

obj.DrawObject "----------------------------------------------------------------", "", 0, "", 1, "1,2,3,4", "0,176", "false,2"
obj.DrawObject "----------------------------------------------------------------", "", 0, "", 1, "1,2,3,4", "3,176", "false,2"

obj.SetFontSize 28
obj.SetFontStyle 0,1,1
obj.DrawObject "付 款 通 知 书", "", 0, "", 1, "1,2,3,4", "186,190", "false,2"


obj.SetFontSize 15
obj.SetFontStyle 0,1,0
obj.DrawObject "<%=cust_name%>：", "", 0, "", 1, "1,2,3,4", "0,248", "false,2"

obj.LineInterval=1
obj.SetFontSize 13
obj.SetFontStyle 0,0,0
obj.DrawObject "根据贵我双方签订的编号为 <%=contract_id%> 的租赁合同规定：", "", 0, "", 1, "1,2,3,4", "28,288", "false,2"

obj.DrawObject "（1）贵方应于", "", 0, "", 1, "1,2,3,4", "0,310", "false,2"
obj.SetFontStyle 0,1,0
obj.DrawObject "<%=curr_plan_date%>年<%=curr_plan_date%>月<%=curr_plan_date%>日", "", 0, "", 1, "1,2,3,4", "92,310", "false,2"

obj.SetFontStyle 0,0,0
obj.DrawObject "（应到账日）以前向我公司账户汇入当期款项：", "", 0, "", 1, "1,2,3,4", "192,310", "false,2"
obj.DrawObject "第<%=curr_rent_list%>期租金 金额为 ￥<%=curr_rent%>元", "", 0, "", 1, "1,2,3,4", "28,330", "false,2"
<%if(!line_str1.equals("")||!line_str3.equals("")||!line_str5.equals("")){%>
obj.DrawObject "（2）须立即向我司支付以下逾期款项：", "", 0, "", 1, "1,2,3,4", "0,370", "false,2"
<%}%>
<%if(!line_str1.equals("")){%>
obj.DrawObject "<%=line_str1%>", "", 0, "", 1, "1,2,3,4", "28,390", "false,2"
<%}%>
<%if(!line_str3.equals("")){%>
obj.DrawObject "<%=line_str3%>", "", 0, "", 1, "1,2,3,4", "28,410", "false,2"
<%}%>
<%if(!line_str5.equals("")){%>
obj.DrawObject "<%=line_str5%>", "", 0, "", 1, "1,2,3,4", "28,432", "false,2"
<%}%>



<%if(show_flag.equals("0")){%>
obj.DrawObject "（3）需支付", "", 0, "", 1, "1,2,3,4", "0,472", "false,2"
obj.SetFontStyle 0,1,1
obj.DrawObject "名义留购价￥<%=nominalprice%>元", "", 0, "", 1, "1,2,3,4", "70,472", "false,2"
obj.SetFontStyle 0,0,0
obj.DrawObject "，并于约定支付日以前将", "", 0, "", 1, "1,2,3,4", "212,472", "false,2"
obj.SetFontStyle 0,1,1
obj.DrawObject "保证金收据", "", 0, "", 1, "1,2,3,4", "358,472", "false,2"
obj.SetFontStyle 0,0,0
obj.DrawObject "寄还至我公司，", "", 0, "", 1, "1,2,3,4", "428,472", "false,2"
obj.DrawObject "以便进行设备所有权转移手续。", "", 0, "", 1, "1,2,3,4", "0,492", "false,2"
<%}%>

<%if(show_flag.equals("0")){%>
obj.SetFontStyle 0,1,0
obj.DrawObject "合同结清款合计：", "", 0, "", 1, "1,2,3,4", "0,532", "false,2"
obj.SetFontStyle 0,1,1
obj.DrawObject "￥<%=total_money%>元  ", "", 0, "", 1, "1,2,3,4", "122,532", "false,2"
obj.SetFontStyle 0,0,0
<%}%>



'obj.DrawObject "", "", 0, "562,550", 1, "1,2,3,4", "", "true,1"
'obj.DrawObject "", "", 0, "564,124", 1, "", "", "true,1"
obj.DrawObject "---------------------------------------------------------------------------------", "", 0, "", 1, "1,2,3,4", "-8,562", "false,2"
obj.DrawObject "---------------------------------------------------------------------------------", "", 0, "", 1, "1,2,3,4", "-5,562", "false,2"
obj.DrawObject "---------------------------------------------------------------------------------", "", 0, "", 1, "1,2,3,4", "-8,726", "false,2"
obj.DrawObject "---------------------------------------------------------------------------------", "", 0, "", 1, "1,2,3,4", "-5,726", "false,2"

obj.DrawObject "说明：", "", 0, "", 1, "1,2,3,4", "0,574", "false,2"
obj.DrawObject "1、	依租赁合同第四条规定，贵方若出现逾期则须按日8%s%支付延付罚息。", "", 0, "", 1, "1,2,3,4", "0,594", "false,2"
obj.DrawObject "2、	本付款通知书所列逾期天数按逾期起始日至打印日记。", "", 0, "", 1, "1,2,3,4", "0,614", "false,2"
obj.SetFontStyle 0,1,0
obj.DrawObject "3、	如已全部支付本通知书所列的款项，请忽略本通知书；", "", 0, "", 1, "1,2,3,4", "0,634", "false,2"
obj.DrawObject "如已部分支付或尚未支付，请按本通知书所提示的内容按时足额支付所列的款项。", "", 0, "", 1, "1,2,3,4", "0,654", "false,2"
obj.SetFontStyle 0,0,0

<%if(show_flag.equals("0")){%>
obj.DrawObject "4、	该租赁合同约定于", "", 0, "", 1, "1,2,3,4", "0,674", "false,2"
obj.SetFontStyle 0,1,0
obj.DrawObject "<%=end_date%>结束。", "", 0, "", 1, "1,2,3,4", "136,674", "false,2"
obj.SetFontStyle 0,0,0
<%}%>

obj.DrawObject "温馨提示：从即日起，我们还将免费为您提供每期应付款手机短信提醒服务。如有疑问，请与", "", 0, "", 1, "1,2,3,4", "0,694", "false,2"
obj.DrawObject "我司客服联系。联系电话：800-820-6213", "", 0, "", 1, "1,2,3,4", "0,714", "false,2"

obj.SetFontStyle 0,1,0
obj.DrawObject "恒信金融租赁有限公司", "", 0, "", 1, "1,2,3,4", "438,756", "false,2"
obj.DrawObject "<%=bad_date%>年<%=bad_date%>月<%=bad_date%>日", "", 0, "", 1, "1,2,3,4", "466,778", "false,2"

obj.DrawObject "........................................................................", "", 0, "", 1, "1,2,3,4", "0,800", "false,2"

obj.SetFontStyle 0,0,0
obj.DrawObject "汇款便条", "", 0, "", 1, "1,2,3,4", "0,816", "false,2"
obj.DrawObject "汇：<%=lessor_name%> <%=bank_name%>：<%=lease_acc_number%>", "", 0, "", 1, "1,2,3,4", "0,838", "false,2"

obj.DrawObject "当期租金 ￥<%=curr_rent%>元", "", 0, "", 1, "1,2,3,4", "26,859", "false,2"
obj.DrawObject "当期罚息￥<%=c_punish%>元", "", 0, "", 1, "1,2,3,4", "26,878", "false,2"
obj.DrawObject "逾期款项 ￥<%=total_money_bad%>元", "", 0, "", 1, "1,2,3,4", "26,897", "false,2"

obj.SetFontStyle 0,0,1
<%if(show_flag.equals("0")){%>
obj.DrawObject "留购价 ￥<%=nominalprice%>元", "", 0, "", 1, "1,2,3,4", "26,918", "false,2"
<%}else{%>
obj.DrawObject "", "", 0, "", 1, "1,2,3,4", "26,918", "false,2"
<%}%>

obj.SetFontStyle 0,1,0
obj.DrawObject "合计￥<%=total_money%>元", "", 0, "", 1, "1,2,3,4", "26,938", "false,2"
obj.SetFontStyle 0,0,0
obj.DrawObject "汇款金额： RMB  ￥            元", "", 0, "", 1, "1,2,3,4", "0,959", "false,2"
obj.DrawObject "汇款备注： 支付合同 <%=contract_id%> 租金等。", "", 0, "", 1, "1,2,3,4", "0,979", "false,2"
obj.SetFontStyle 0,1,0
obj.DrawObject "（信息重要，请务必输入，谢谢！）", "", 0, "", 1, "1,2,3,4", "260,979", "false,2"

obj.SetFontSize 8
obj.DrawObject "Unitrust Finance & leasing Corporation", "", 0, "", 1, "1,2,3,4", "450,1000", "false,2"

obj.DrawObject "", "", 2, "", 5, "1,2,3,4", "", "false,1"
obj.DrawObject "", "", 0, "", 5, "1,2,3,4", "", "true,3"
</script>


<script language="VBScript">
obj.PrintPreview
</script>
<%
db.close();
db1.close();
%>



</body>
</html>

