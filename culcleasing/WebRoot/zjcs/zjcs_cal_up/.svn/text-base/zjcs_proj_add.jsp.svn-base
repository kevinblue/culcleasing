<%@ page contentType="text/html; charset=gbk" language="java" %>
<%@ page import="java.sql.*" %> 
<%@ page import="java.util.ArrayList"%> 
<%@ page import="java.util.List"%>
<%@ page import="com.tenwa.log.LogWriter"%>
<%@ page import="com.tenwa.bean.ConditionBean"%>
<%@page import="java.util.Date"%> 
<%@ include file="../../func/common_simple.jsp"%>

<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<jsp:useBean id="condition" scope="page" class="com.condition.ConditionOperating" />

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<!-- 项目立项--拟商务条件 表：contract_condition_temp  项目交易结构-->
<title>租金测算 - 项目交易结构</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/validator.js"></script>
<SCRIPT  Language="Javascript"  SRC="/tenwa/js/public.js"></SCRIPT>
<SCRIPT  Language="Javascript"  SRC="/tenwa/js/publicEvent.js"></SCRIPT>
<script language="javascript" src="/dict/js/js_dictionary.js"></script>
<script language="javascript" src="/dict/js/ajax_popupDialog.js"></script>
<script src="../../js/calend.js"></script>

<script Language="Javascript" src="../../js/jquery.js"></script>
<script Language="Javascript">
function downloadTemplate(){
	var measure_typeVal = $("#measure_type").val();
	alert(measure_typeVal);
	window.open("file_download.jsp?measure_type="+measure_typeVal);
}
function showUploadDiv(){
	$("#uploadDiv").fadeIn("slow");
}
</script>
</head>
<body onload="public_onload(0);">

<%
	//基础参数	
	String user_id = (String)session.getAttribute("czyid");//取得登录人的ID 用于取得登录人的name
	//获取参数
	String proj_id = getStr(request.getParameter("proj_id"));
	String nowDateTime = getSystemDate(0);//当前格式化之后的时间
%> 
<!-- form表单跳转到zjcs_projSave.jsp页面    doCument.forms[0].onsubmit()-->
<form name="form1" method="post" target="rentplan" action="zjcs_projSave.jsp" onSubmit="return Validator.Validate(this,2);check_allInput();">
<table  class="title_top" width=100% height="100%" align=center cellspacing=0 border="0" cellpadding="0">

<tr valign="top">
	<td  align=center width=100% height=100%>
	<!-- 隐藏域传值  -->
	<div id="divH" class="tabBody" style="background:#ffffff;width:100%;height:430px;overflow:auto;">
	<div id="TD_tab_0">
		<table  border="0" cellspacing="0" cellpadding="0" width="100%" height=100%" align="center" class="tab_table_title">
			<tr><td colspan="8"></td></tr>
			<tr>
				<td colspan="8" align="left">
				
				租金计算方法：
				<select style="width: 100px;" id="measure_type" name="measure_type" Require="true" onchange="change_disable2()">
		        <script type="text/javascript">
			        	w(mSetOpt('1',
			        	"等额租金|等差租金|等比租金|等额本金|等差本金|等比本金|等额租金后付(均息法)|不等额租金|不等额本金|不规则",
			        	"1|2|3|4|7|6|5|8|9|0"));
		        </script>
		        </select>&nbsp;&nbsp;|
		         付租类型：
		        <select name="period_type" style="width: 60px;">
		        <script type="text/javascript">
			        w(mSetOpt('0',"期初|期末","1|0"));
		        </script>
		        </select>
		        
		        &nbsp;&nbsp;|
				<BUTTON class="btn_2" name="btnSave" value="租金测算" onClick="downloadTemplate();">
				<img src="../../images/fdmo_24.gif" align="absmiddle" border="0">下载</button>
		        &nbsp;&nbsp;|
				<BUTTON class="btn_2" name="btnSave" value="租金测算" onClick="dataHander('add_modal','cond_upload.jsp?proj_id=<%=proj_id %>&doc_id=<%=doc_id %>');">
				<img src="../../images/fdmo_23.gif" align="absmiddle" border="0">上传</button>
				&nbsp;&nbsp;|
				<BUTTON class="btn_2" name="btnSave" value="租金测算" onClick="submitForm()">
				<img src="../../images/save.gif" align="absmiddle" border="0">保存</button>
				&nbsp;&nbsp;&nbsp;
				<div id="uploadDiv" style="display:none;">
					<form name="upload_form" action="cond_save.jsp" enctype="multipart/form-data" method="post">
						上传文件：&nbsp;&nbsp; 
						 		<input type="file" name="uploadFile" style="width:250px;">
								<span class="biTian">允许上传的文件类型.xls 最大8M</span>
						<BUTTON class="btn_2" name="btnSave" type="button" onclick="fun_save()">
					 	<img src="../../images/sbtn_2Excel.gif" align="bottom" border="0">上传文件</button>		
					</form>
				</div>
				
				</td>
			</tr>
		
		  <tr>
		  	<!-- 隐藏字段开始 -->
		  	<input name="rate_adjustment_modulus" type="hidden" value="0"/>
		  	<input name="plan_irr" type="hidden" value="0.00"/>
		  	<input name="accountPrincipal" type="hidden" value="0"/>
		  	<input name="liugprice" type="hidden" value="0"/>
		  	<input name="rentScale" type="hidden" value="0"/>
		  	<input name="delay" type="hidden" value="0"/>
		  	<input name="grace" type="hidden" value="0"/>
		  	<input name="amt_return" type="hidden" value="否"/>
		  	<!-- 隐藏字段结束 -->
		  	<td scope="row" nowrap>项目编号</td>
		    <td>
		    	<input name="proj_id" id="proj_id" type="text" value="<%=proj_id%>" 
		    		  size="35" maxlength="50"/>
					<!-- dataType="Number" size="13" maxlength="50" maxB="50"  Require="true" -->
		    	<span class="biTian">*</span>
		     </td>
			 <td scope="row" nowrap>货币类型</td>
		     <td><!-- 这里从数据库字典表中获取所有货币的类型  暂时写死不清楚具体的字典表 -->
				<select style="width:100px;" name="currency" id="currency" Require="true" disabled="disabled"></select>
				<script language="javascript" class="text">
				dict_list("currency","currency_type","currency_type1","name");
				</script>
    				
		    	<span class="biTian">*</span>
			</td>
		    <td scope="row" nowrap>设备金额</td>
		    <td>
		    	<input name="equip_amt" id="equip_amt" type="text" 
		    		value="0" onchange="changeFirst_payment()"
		    		dataType="Money" size="13" maxlength="50" maxB="50"  Require="true"/>
		       	<span class="biTian">*</span>
		     </td>
		      <td scope="row" nowrap>首付款</td>
		      <td>
		    	<input name="first_payment" type="text" value="0" 
		    	onchange="changeFirst_payment()" dataType="Money" size="13" maxlength="50" 
		    	maxB="50"  Require="true"/>
		    	<span class="biTian">*</span>
		   	   </td> 
		  </tr> 
		  	
		  <tr>
		  	<!--  租赁本金 = 设备金额 - 首付款 onclick="changeFirst_payment()"   -->
		   <td scope="row" nowrap>租赁本金</td>
		     <td>
		    	<input name="lease_money" id="lease_money" value="0" 
		    	readonly type="text" Require="true" dataType="Money" size="13" maxlength="100" maxB="100" 
		    	Require="true"/>
		    	<span class="biTian">*</span>
			 </td>
			<td  scope="row" nowrap>租赁保证金</td>
			<td>
				<input name="caution_money" id="caution_money" value="0" 
					dataType="Money" size="13" maxlength="20" maxB="20"  Require="true" 
					onchange="assignment()" type="text"/>
				<span class="biTian">*</span>
			</td>
			<td  scope="row" nowrap>租赁手续费</td>
			<td>
				<input name="handling_charge" type="text" value="0" 
				 	dataType="Money" size="13" maxlength="20" 
				 	maxB="20"  Require="true" onchange="assignment()"/>
				<span class="biTian">*</span>
			</td>
			<td scope="row" nowrap>管理费</td>
		    <td colspan="">
		    	<input name="management_fee" type="text" value="0"  
		    		dataType="Money" size="13" maxlength="10" maxB="10"  Require="true" onchange=""/> 
				<span class="biTian">*</span>
			</td>
		  </tr>
		  
		  <tr>
			<td scope="row" nowrap>咨询费收入</td>
		  	<td>
		  		<input name="consulting_fee_in" type="text" value="0"  
					dataType="Money" size="13" maxlength="20" maxB="20"  Require="true" onchange="assignment()"/>
				<span class="biTian">*</span>
			</td>
		  	<td scope="row" nowrap>咨询费支出</td>
		  	<td>
		  		<input name="consulting_fee" type="text" value="0"  
					dataType="Money" size="13" maxlength="20" maxB="20"  Require="true" onchange="assignment()"/>
				<span class="biTian">*</span>
			</td>
			<!--  onKeyUp="value=value.replace(/[^\d]/g,'')"   -->
			<td  scope="row" nowrap>其他收入</td>
			<td>
				<input name="other_income" type="text" value="0" dataType="Money"
					  size="13" maxlength="20" onchange="assignment()" />
			</td>
			<td scope="row" nowrap>其他支出</td>
		    <td colspan="">
		    	<input name="other_expenditure" type="text" value="0" dataType="Money"
		    		  size="13" maxlength="10" onchange="assignment()"/> 
			</td>
		  </tr>	
		  
		  <tr>	
		  	<td  scope="row" nowrap>残值收入</td>
			<td>
				<input name="nominalprice" type="text" value="0" onchange="assignment()"
					dataType="Money" size="13" maxlength="20" maxB="20"  Require="true"/>
				<span class="biTian">*</span>
			</td>
		    <td  scope="row" nowrap>厂商返利</td>
			<td>
				<input name="return_amt" type="text" value="0"  
					dataType="Money" size="13" maxlength="20" maxB="20"  Require="true" onchange="assignment()"/>
				<span class="biTian">*</span>
			</td>
			<td  scope="row" nowrap>投保方式</td>
			<td>
				<select style="width: 100px;" name="insure_type" id="insure_type" Require="true"></select>
				<script language="javascript" class="text">
					dict_list("insure_type","insure_type","","name");
				</script>
   				<span class="biTian">*</span>
			</td>
			<td scope="row" nowrap>保费金额</td>
		    <td colspan="">
		   	 <input name="insure_money" type="text" value="0"  
					dataType="Money" size="13" maxlength="20" maxB="20"  Require="true" onchange="assignment()"/>
			</td>
		  </tr>
		  
		  <tr>
		   	<td scope="row" nowrap>净融资额</td>
		    <td>
		    	<!--  净融资额=设备款-保证金-手续费-厂商返佣-其他收入+咨询费+其他支出 【2010-07-23修改，增加需要 减去租前息】 -->
		    	<input name="net_lease_money" id="net_lease_money" type="text" value="" readonly onclick="assignment()" 
		    	dataType="Money" size="13" maxlength="20" maxB="20"/> 
		    		净融资额比例
    				<input name="lease_money_proportion" id="lease_money_proportion" type="text" 
					value="" size="5" 
					maxlength="10" readonly="readonly" 
					onclick="getlmp_value()" Require="true"/>% 
    				<span class="biTian">*</span>
			</td>
		  	<td  scope="row" nowrap>租赁年利率</td>
			<td nowrap="nowrap">
				<input name="year_rate" type="text" value="0.00"  
					dataType="Rate" size="13" maxlength="10" maxB="10"  Require="true"/>%
				<!--  	display: none; 
				<div id="" style="" align="right"> 
					<input type="button"class="button" value="导入" alt="从主协议报价信息中导入" onclick=""/>
				</div>	   --> 
				<span class="biTian">*</span>
			</td>  
			
		  	<td scope="row" nowrap>罚息日利率</td>
		    <td colspan="">
		    	<input name="pena_rate" type="text" value="5"  
		         size="13" maxlength="20" dataType="Money" size="13" maxlength="10" maxB="10"  Require="true" />%%
		         <!-- 另外的判断输入方式 只能输入整数 onKeyUp="value=value.replace(/[^\d]/g,'')"
		         	onblur="if(isNaN(document.all.tolerance_date.value)){
		            alert('免息期请正确输入天数');document.all.tolerance_date.focus();}"  
		          -->
		    	<span class="biTian">*</span>
			</td>  
			
			<td scope="row" nowrap>逾期宽限日</td>
		    <td> 
		    	<input name="free_defa_inter_day" type="text" value="0"  
		    		dataType="Integer" size="13" maxlength="10" maxB="10"  Require="true" 
		    		onKeyUp="value=value.replace(/[^\d]/g,'')"
		         	onblur="if(isNaN(document.all.free_defa_inter_day.value)){
		            alert('请正确输入逾期宽限日');document.all.free_defa_inter_day.focus();}"/>
		    	<span class="biTian">*</span>
			</td>
		  </tr>
		  
		   
		  
		   <tr>
		   <td scope="row" nowrap>付租方式</td>
		    <td>
		    	 <select name="income_number_year" id="income_number_year" style="width: 100px;" onchange="changIncome_number_year_value()">
					<script type="text/javascript">
						w(mSetOpt("","月付|双月付|季付|半年付|年付","1|2|3|6|12")); 
					</script>
				</select>
		    	<span class="biTian">*</span>
			</td>
			<td scope="row" nowrap>付租类型</td>
		    <td><select name="period_type" style="width: 100px;">
		        <script type="text/javascript">
			        w(mSetOpt('0',"期初|期末","1|0"));
		        </script>
		        </select>
		        <span class="biTian">*</span>
			</td> 
		    <!-- 还租次数=租赁期限/年还租次数 -->
		  	<td scope="row" nowrap>还租次数</td>
		    <td>
		    	<input name="income_number" type="text" value="0"    onChange="changLeaseT_value()"
		    		dataType="Integer" size="13" maxlength="10" maxB="10"  Require="true" />
		    	<span class="biTian">*</span>
			</td>
		   	<!-- 根据付租方式判断 -->
			<td scope="row" nowrap>租赁期限(月)</td>
		    <td>
		    	<input name="lease_term" type="text" value="0"  onClick="changLeaseT_value()" 
		    		dataType="Integer" size="13" maxlength="10" maxB="10"  Require="true" readonly/>
		    	<span class="biTian">*</span>
			</td>
			
		  </tr>	
		  
		  <tr>
		  	<td scope="row" nowrap>利率浮动类型</td>
		    <td>
		    	<select name="rate_float_type" onchange="changeOne()">
		        <script>
			        w(mSetOpt('0',"按央行利率浮动比率|按央行利率加点|固定调整租金金额|保持不变","0|1|2|3"));
		        </script>
		        </select> 
		    	<span class="biTian">*</span>
			</td>
			<td scope="row" nowrap>利率调整值</td>
		    <td>
		    	<input name="rate_float_amt" type="text" value="0"  onblur="alertChange()"
		    		dataType="Double" size="13" maxlength="10" maxB="10"  Require="true" />
		    	<span class="biTian">*</span>
			</td>
			<td colspan="2">
				<div id="div_rate"></div>
			</td>
			<td  scope="row" nowrap>预计IRR</td>
			<td>
				<input name="market_irr" type="text" value="0"  
				  size="13" maxlength="10" readonly/>
			</td> 
		  </tr>
		
		  <tr>
		  	<td scope="row" nowrap>租前息</td>
		    <td>
		    	<input name="before_interest" type="text" value="0"  onchange="assignment()"
		    		dataType="Money" size="13" maxlength="10" maxB="10"  Require="true" />
		    	<span class="biTian">*</span>
			</td>
			<td scope="row" nowrap>利息补贴</td>
		  	<td>
		  		<input name="rate_subsidy" type="text" value="0"  
					dataType="Money" size="13" maxlength="20" maxB="20"  Require="" onchange="assignment()"/>
				<span class="biTian"></span>
			</td>
			<td scope="row" nowrap>贴现息</td>
		  	<td>
		  		<input name="discount_rate" type="text" value="0"  
					dataType="Money" size="13" maxlength="20" maxB="20"  Require="" onchange="assignment()"/>
				<span class="biTian"></span>
			</td>
			<td  scope="row" nowrap>预计起租日</td>
			<td>
				<input name="start_date" type="text" value="<%=nowDateTime%>"  
					 size="13" maxlength="20"  Require="true" readonly="readonly"/>
				<img  onClick="openCalendar(start_date);return false" style="cursor:pointer; " 
				 src="../../images/fdmo_63.gif" width="20" height="19" border="0" align="absmiddle">
				<span class="biTian">*</span>
			</td>
		  </tr>
		  
		  <tr>
		  	
			<td  scope="row" nowrap>每月偿付日</td>
			<td>
				<select name="income_day" style="width: 100px;">
					<% 
						for(int i = 1;i <= 31;i++){
					%>
						<option value="<%=i%>"><%=i%></option>
					<% 
						}
					%>
				</select>	 
				<span class="biTian">*</span>
			</td>
			<td  scope="row" nowrap>租金计算方法</td>
			<td><!-- 等额本金2  暂时隐藏掉 不规则0|手工调整3  2010-08-12  -->
				<select style="width: 100px;" name="measure_type" Require="true" onchange="change_disable2()">
		        <script type="text/javascript">
			        	w(mSetOpt('1',
			        	"等额租金|等额租金后付(均息法)|不规则",
			        	"1|5|0"));
		        </script>
		        </select>
				<span class="biTian">*</span>
			</td> 
			<td scope="row" nowrap>调息方式</td>
		    <td>
		    	<select name="ajdust_style" style="width: 100px;">
		        <script type="text/javascript">
		        	w(mSetOpt('0',"按次日|按次月|按次期|按次年","0|1|2|3"));
		        </script>
		        </select> 
		    	<span class="biTian">*</span>
			</td>
			
			<td scope="row" nowrap>是否批量调息</td>
	   		<td>
	    	<select name="into_batch" style="width: 100px;">
		        <script type="text/javascript">
			        	w(mSetOpt('是',"是|否","是|否"));
		        </script>
	        </select>
			</td>
		</tr>
		  
		</table>
		</div>
		</div>
	</td>
	</tr>
</table>
</form>
</body>
</html>
