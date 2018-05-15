<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<jsp:useBean id="right" scope="page" class="com.filter.FilterCredit" />
<%@ include file="../../func/common.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>租金偿还计划 - 明细列表</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script type="text/javascript">
	function show(a){
		if(a=="a"){
		   document.getElementById("a").style.display="block";//    
		   document.getElementById("b").style.display="none";//
		   document.getElementById("c").style.display="none";//
		   document.getElementById("d").style.display="none";//
		}
		if(a=="b"){
		   document.getElementById("a").style.display="none";//
		   document.getElementById("b").style.display="block";//   
		   document.getElementById("c").style.display="none";//
		   document.getElementById("d").style.display="none";//
		}
		if(a=="c"){
		   document.getElementById("a").style.display="none";//
		   document.getElementById("b").style.display="none";//   
		   document.getElementById("c").style.display="block";//
		   document.getElementById("d").style.display="none";//
		}
		if(a=="d"){
		   document.getElementById("a").style.display="none";//
		   document.getElementById("b").style.display="none";//   
		   document.getElementById("c").style.display="none";//
		   document.getElementById("d").style.display="block";//
		}
	}
	function showColor1(){
		document.all("Form_s_tab_0").style.backgroundColor="#8DB2E3";
		document.all("Form_s_tab_1").style.backgroundColor="#DADDE5";
		document.all("Form_s_tab_2").style.backgroundColor="#DADDE5";
		document.all("Form_s_tab_3").style.backgroundColor="#DADDE5";
	}
	function showColor2(){
		document.all("Form_s_tab_0").style.backgroundColor="#DADDE5";
		document.all("Form_s_tab_1").style.backgroundColor="#8DB2E3";
		document.all("Form_s_tab_2").style.backgroundColor="#DADDE5";
		document.all("Form_s_tab_3").style.backgroundColor="#DADDE5";
	}
	function showColor3(){
		document.all("Form_s_tab_0").style.backgroundColor="#DADDE5";
		document.all("Form_s_tab_1").style.backgroundColor="#DADDE5";
		document.all("Form_s_tab_2").style.backgroundColor="#8DB2E3";
		document.all("Form_s_tab_3").style.backgroundColor="#DADDE5";
	}
	function showColor4(){
		document.all("Form_s_tab_0").style.backgroundColor="#DADDE5";
		document.all("Form_s_tab_1").style.backgroundColor="#DADDE5";
		document.all("Form_s_tab_2").style.backgroundColor="#DADDE5";
		document.all("Form_s_tab_3").style.backgroundColor="#8DB2E3";
	}
</script>
</head>
<% 
    String dqczy = (String) session.getAttribute("czyid");
    String proj_id = getStr(request.getParameter("proj_id")); //项目编号
	String doc_id = getStr(request.getParameter("doc_id"));//文档编号  "FA6FFC6AC326B1CF4825772E0027A83E";//
	String contract_id = getStr(request.getParameter("contract_id"));//合同编号 "2010-00002-002-175";//
	String plan_irr = getStr(request.getParameter("plan_irr"));//财务IRR
	String market_irr = getStr(request.getParameter("market_irr"));//市场IRR
	//show('a');showColor1()
%>
<body onLoad="show('a');showColor1();">
<div id="divH" class="tabBody" style="background:#ffffff;width:100%;height:100%;overflow:auto;">
<form name="form1" method="post" action="zics_div_list.jsp" onSubmit="return checkdata(this);">	
	<table border="0" cellspacing="0" cellpadding="0" width="100%">
		<tr><td bgcolor="" height="2" width="100%"></td></tr>
	</table>
	<table border="0" cellspacing="0" cellpadding="0">
		 <tr>
		  <td id="Form_s_tab_0" class="Form_tab" width=130 align=center onmousedown="showColor1()"  onClick="show('a')"  valign="middle">&nbsp;合同变更后偿还计划&nbsp;</td>
		  <td>&nbsp;</td>
		  <td id="Form_s_tab_1" class="Form_tab" width=130 align=center onmousedown="showColor2()"  onClick="show('b')"  valign="middle">&nbsp;合同变更后现金流列表&nbsp;</td>
		  <td>&nbsp;</td>
		  <td id="Form_s_tab_2" class="Form_tab" width=130 align=center onmousedown="showColor3()" onClick="show('c')"  valign="middle">&nbsp;会计变更后偿还计划&nbsp;</td>
		  <td>&nbsp;</td>
		  <td id="Form_s_tab_3" class="Form_tab" width=130 align=center onmousedown="showColor4()" onClick="show('d')"  valign="middle">&nbsp;会计变更后现金流列表&nbsp;</td>
		 </tr>
	</table>
	<table border="0" cellspacing="0" cellpadding="0" width="100%">
		<tr><td bgcolor="#8DB2E3" width="100%"><img height="1" width="1"></td></tr>
	</table>
	<div id="a" style="display:none;">
	   <iframe frameborder="0" name="market_plan" id="market_plan" width="100%"  style="funny:expression(autoResize())"
			 src="zq_newrent.jsp?contract_id=<%=contract_id%>&doc_id=<%=doc_id %>&proj_id=<%=proj_id%>">
	   </iframe>
	</div>
	<div id="b" style="display:none;">
	   <iframe frameborder="0" name="market_plan_xjl" id="market_plan_xjl" width="100%"  style="funny:expression(autoResize())" 
			src="../contract_zjcs/zjcs_xjl_mark.jsp?contract_id=<%=contract_id%>&doc_id=<%=doc_id%>&market_irr=<%=market_irr%>">>
	   </iframe>
	</div>
	
	<div id="c" style="display:none;">
 		<iframe frameborder="0" name="cw_plan" id="cw_plan" width="100%"  style="funny:expression(autoResize())"
		 src="market_newrent.jsp?contract_id=<%=contract_id%>&doc_id=<%=doc_id %>&proj_id=<%=proj_id%>">
		</iframe>
	</div>
	<div id="d" style="display:none;">
 		<iframe frameborder="0" name="cw_plan_xjl" id="cw_plan_xjl" width="100%"  style="funny:expression(autoResize())"
		 src="../contract_zjcs/zjcs_xjl.jsp?contract_id=<%=contract_id%>&doc_id=<%=doc_id%>&plan_irr=<%=plan_irr%>">
		</iframe>
	</div>
	<script type="text/javascript">
		//内部Iframe高度自适应
		function autoResize()
		{
			try
			{
				document.all["market_plan"].style.height=market_plan.document.body.scrollHeight
				document.all["market_plan_xjl"].style.height=market_plan_xjl.document.body.scrollHeight
				document.all["cw_plan"].style.height=cw_plan.document.body.scrollHeight
				document.all["cw_plan_xjl"].style.height=cw_plan_xjl.document.body.scrollHeight
			}
			catch(e)
			{
				//alert('#$%^%#$^$#exception');
			}
		}
	</script>
</form>
</div>
<!-- end cwMain -->
</body>
</html>
