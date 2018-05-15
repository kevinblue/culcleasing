<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>合同信息 - 不规则租金测算修改</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script><script src="../../js/validator.js"></script>
<SCRIPT  Language="Javascript"  SRC="/tenwa/js/publicEvent.js"></SCRIPT>
<script type="text/javascript">
	
	function checkDate(){//检查日期
		//alert('join');
		var nowDateTime = document.getElementById('nowDateTime').value;
		var newDateTime = document.getElementById('plan_date').value;
		//alert(newDateTime);
		if(newDateTime < nowDateTime){
			alert("偿还日期不能小于当前日期!");
			document.getElementById('plan_date').value = nowDateTime;
			return false;
		}
	}
	//给租金赋值
	function fzValue(){
		//租金 = 本金 + 利息
		var corpus = document.getElementById('corpus_market').value;
		var interest = document.getElementById('interest_market').value;	
		var corpus_overage_market = document.getElementById('lease_money').value;
		//alert(corpus_overage_market);
		if(corpus == null || corpus == ''){
			alert("本金不能为空!");
			return false;
		}
		else if(interest == null || interest == ''){
			alert("利息不能为空!");
			return false;
		}
		else{
			var money = (parseFloat(corpus) + parseFloat(interest)).toFixed(2);
			//alert(parseFloat(money) > parseFloat(zero));
			//var zero = parseFloat("0.00").toFixed(2);
			//if(parseFloat(money) > parseFloat(zero)){
				document.getElementById('rent').value = money;//租金=本金加利息
				//剩余本金等于 = 上一期的剩余本金 - 本期的本金
				document.getElementById('corpus_overage_market').value = (parseFloat(corpus_overage_market) - parseFloat(corpus)).toFixed(2);
			//} 
			//else{//如果租金等于0
				//剩余本金等于 进入页面时候查询的剩余本金余额
				//document.getElementById('corpus_overage_market').value = corpus_overage_market;
				//document.getElementById('corpus_market').value = '0';//本金
				//document.getElementById('interest_market').value = '0';//利息
				//document.getElementById('rent').value  = '0';//租金
			//}
		}
	}
</script>
</head>

<%
	String dqczy = (String) session.getAttribute("czyid");
	if ((dqczy == null) || (dqczy.equals("")))
	{
		dqczy = "无认证";
	}
	//接参数
	String doc_id = getStr(request.getParameter("doc_id"));//文档编号
	String contract_id = getStr(request.getParameter("contract_id"));//合同编号
	String proj_id = getStr(request.getParameter("proj_id"));//项目编号
	String temp = getStr(request.getParameter("temp"));//用于判断是项目还是合同的操作
	String savetype = getStr(request.getParameter("savetype"));//操作类型
	String key_id = getStr(request.getParameter("itemselect"));//id
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");//格式化时间
	String nowDateTime = sdf.format(new Date());//当前格式化之后的时间
	ResultSet rs;
	
	String sqlstr = "";
	String	rent_list = "";//期项
	String	plan_date = "";//偿还日期
	String	rent = "";//租金
	String	corpus = "";//市场本金
	String	interest = "";//市场利息
	String	corpus_overage_market = "";//市场本金余额
	//判断要修改的期项是否是未回笼
	String plan_status = "";
	String table_where = "";
	String sqlstr1 = "";
	//项目交易结构
	if (temp.equals("proj_zjcs")){
		table_where = " proj_condition_temp where  proj_id = '"+proj_id+"' and measure_id = '"+doc_id+"'";
		sqlstr = " select * from fund_rent_plan_proj_temp where id = '"+key_id+"' and proj_id = '"+proj_id+"' and measure_id = '"+doc_id+"' ";
		sqlstr1 = " select * from fund_rent_plan_proj_temp where    proj_id = '"+proj_id+"' and measure_id = '"+doc_id+"'  ";
	}//项目交易的结束
	
	//###################################################################################################
	//	 合同偿还计划不规则
	else if(temp.equals("contract_zjcs")){
		table_where = " contract_condition_temp where contract_id = '"+contract_id+"' and measure_id = '"+doc_id+"'";
		sqlstr = " select * from fund_rent_plan_temp where id = '"+key_id+"' and contract_id = '"+contract_id+"' and measure_id = '"+doc_id+"' ";
		sqlstr1 = " select * from fund_rent_plan_temp where  contract_id = '"+contract_id+"' and measure_id = '"+doc_id+"' ";
	}
%>
<%
		rs = db.executeQuery(sqlstr);
		System.out.println("sql==> : "+sqlstr);
		String ls_corpus_overage_market = "";//剩余本金的临时变量
		
		while(rs.next()){
			rent_list = getDBStr(rs.getString("rent_list") );
			plan_date = getDBDateStr(rs.getString("plan_date") );
			rent = formatNumberDoubleTwo(getDBStr(rs.getString("rent")));
			corpus = formatNumberDoubleTwo(getDBStr(rs.getString("corpus_market")));
			interest = formatNumberDoubleTwo(getDBStr(rs.getString("interest_market")));
			corpus_overage_market = formatNumberDoubleTwo(getDBStr(rs.getString("corpus_overage_market")));
			plan_status = getDBStr(rs.getString("plan_status"));
			sqlstr = ""; 
			if("1".equals(rent_list)){//如果是第一期，则剩余市场本金取交易结构中的剩余本金 
				sqlstr = " select * from "+table_where; 
				System.out.println("第一期情况查询交易结构中的租赁本金作为剩余本金"+sqlstr);
				rs = db.executeQuery(sqlstr);
				while(rs.next()){//租赁本金 作为最初的剩余本金值
					corpus_overage_market = getDBStr(rs.getString("lease_money"));
					ls_corpus_overage_market = corpus_overage_market;
				}
			}else{//否则取上一期的市场本金余额 
				int i = Integer.parseInt(rent_list)-1;
				sqlstr = sqlstr1 + " and rent_list = '"+i+"'"; 
				System.out.println("不为第一期则查询上一期的剩余本金余额"+sqlstr);
				rs = db.executeQuery(sqlstr);
				while(rs.next()){
					ls_corpus_overage_market = getDBStr(rs.getString("corpus_overage_market"));
				}
			}
			
			
		}

		if(plan_status.equals("已回笼")){
%>
		<script>
			window.close();
			opener.alert("该笔租金已回笼!");
			opener.location.reload();
		</script>
<%		
		}	
		rs.close();
		db.close();
%>
<!-- onload="fun_winMax();" -->
<body >
<form name="form1" method="post" action="zjcs_sg_save.jsp" onSubmit="return Validator.Validate(this,3);">
<input type="hidden" name="savetype" value="<%=savetype%>">
<input type="hidden" name="czid" value="<%=dqczy%>">
<input type="hidden" name="doc_id" value="<%=doc_id%>">
<input type="hidden" name="contract_id" value="<%=contract_id%>">
<input type="hidden" name="proj_id" value="<%=proj_id%>">
<input type="hidden" name="temp" value="<%=temp%>">
<input type="hidden" name="key_id" value="<%=key_id%>">
<!-- 刚进入时查询的市场本金 用它减去有可能输入的本金 得到一个差值   原本－现本＝差值 每期本金余额＝原每期本金余额＋差值 -->
<input type="hidden" type="join_ybcorpus" name="join_ybcorpus" value="<%=corpus%>">
<input type="hidden" type="nowDateTime" name="nowDateTime" value="<%=nowDateTime%>">
<input type="hidden" name="lease_money" id="lease_money" value="<%=ls_corpus_overage_market%>">

<div id=bgDiv>
<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle">
合同信息 &gt; 不规则租金测算修改
</td>
</tr>
<tr valign="top">
<td  align=center width=100% height=100%>
<table align=center width=96%  border="0" cellspacing="0" cellpadding="0" style="margin-top:0px">
<tr>
<td>
<!--操作按钮开始-->
<table border="0" cellspacing="0" cellpadding="0" height="30">
	  <tr>
	    <td>
<BUTTON class="btn_2" name="btnSave" value="保存"  type="submit" >
<img src="../../images/save.gif" align="absmiddle" border="0">保存</button>
<BUTTON class="btn_2" name="btnReset" value="取消" onclick="window.close();">
<img src="../../images/hg.gif" align="absmiddle" border="0">取消</button>

	    	</td>
	  </tr>
</table>
<!--操作按钮结束-->
</td>
</tr>
<tr><td height="1" bgcolor="#DFDFDF"></td></tr>
<tr><td height="5"></td></tr>
<tr><td width="100%">
 <table border="0" cellspacing="0" cellpadding="0">
 <tr>
  <td id="Form_tab_0" class="Form_tab" width=70 align=center onclick="chgTabN()"  valign="middle">修改信息</td>
  
  <td id="Form_tab_1" class="Form_tab" width=0 align=center onclick="chgTabN()"  valign="middle"></td>
  <td id="Form_tab_2" class="Form_tab" width=0 align=center onclick="chgTabN()"  valign="middle"></td>
  
 </tr>
 </table></td></tr> 
<tr><td class="tab_subline" width="100%" height="2"></td></tr>
</table>
<center>

<div id="divH" class="tabBody" style="background:#ffffff;width:96%;height:500px;overflow:auto;">
<div id="TD_tab_0">
<table class="tab_table_title" border="0" cellspacing="0" cellpadding="0" width="100%">
  <tr>
	<td>
		编号
	</td>
	<!-- 有可能是项目编号  -->
	<td colspan="4">
		<%
			if (temp.equals("proj_zjcs")) {
		%>
		<input name="name_id" type="text" size="50" maxB="50"
			Require="ture" value="<%=proj_id%>" readonly>
		<%
			}
			if (temp.equals("contract_zjcs")) {
		%>
		<input name="name_id" type="text" size="50" maxB="50"
			Require="ture" value="<%=contract_id%>" readonly>
		<%
			}
		%>
		<span class="biTian">*</span>
	</td>
</tr>	
  <tr>
	<td>期项</td>
    <td>
    	<input name="rent_list" type="text" size="20" 
    	maxB="20" Require="true" dataType="Integer" 
    	value="<%=rent_list%>" readonly="readonly"/>
    </td>
  	<td>偿还日期</td>
    <td>
    	<input name="plan_date" type="text" size="15" onchange="checkDate()"
    	 readonly maxlength="10" dataType="Date" Require="ture" 
    	 value="<%=plan_date%>"> 
    	 <img  onClick="openCalendar(plan_date);return false" 
    	 style="cursor:pointer; " src="../../images/tbtn_overtime.gif"
    	  width="20" height="19" border="0" align="absmiddle">
		<span class="biTian">*</span>
	</td>
  	<td>市场本金</td>
    <td>
    	<input name="corpus_market" type="text" size="20" maxB="20" 
    	Require="true" dataType="Money" value="<%=corpus%>" onchange="fzValue()"/>
    	<span class="biTian">*</span></td>
  </tr>
  
  <tr>
  	<td>利息</td>
    <td>
    	<input name="interest_market" type="text" size="20" onchange="fzValue()"
    		maxB="20" Require="true" dataType="Double" 
    		value="<%=interest%>" />
    		<span class="biTian">*</span></td>
    <td>租金</td>
    <td colspan="">
    	<input name="rent" type="text" size="20" 
    	maxB="20" Require="true" dataType="Money" 
    	value="<%=rent%>" readonly="readonly"/>
    </td>
    <td>市场本金余额</td>
    <td colspan="">
    	<input name="corpus_overage_market" id="corpus_overage_market"  type="text" size="20" maxB="20"
			  Require="true" dataType="Money"  value="<%=corpus_overage_market%>" readonly="readonly"/>
    </td>
  </tr>
</table>

</div>

</div>

<div id="TD_tab_1" style="display:none;"> 
  选择卡中的内容2
</div>
<div id="TD_tab_2" style="display:none;"> 
  选择卡中的内容3

选择卡中可能包含以下内容：

注意HTMLBody并不是选择卡中的内容，因此需要独立拿出来放在最后。

</div>

</center>
<table width=96% align=center border="0" cellspacing="0" cellpadding="0">
<tr><td width="50%"></td>
<td width="50%" valign="middle" align="right">&nbsp;</td></tr>
</table>
</td>
</tr>
</table>  
</div>
<!--添加结束-->

<!--控制选择卡和内置iframe的高度适应窗口-->
<script language="javascript">
ShowTabN(0);
reinitIframe();
//外部div高度自适应
function reinitIframe(){
var divH = document.getElementById("divH");
var reinitIframe_resize=function(){
divH.style.height=window.document.body.clientHeight-100;
}
reinitIframe_resize();
window.onresize=reinitIframe_resize;
}
//内部Iframe高度自适应
//function autoResize()
//{
//	try
//	{
//		document.all["UserBody1"].style.height=UserBody1.document.body.scrollHeight
//	}
//	catch(e)
//	{}
//}
</script>
</form>








<!-- end cwMain -->
</body>
</html>
