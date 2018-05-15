<%@ page language="java" import="java.util.*" pageEncoding="utf-8" errorPage="/public/pageError.jsp"%>
<%@ include file="../../public/simpleHeadImport.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>   
<title>或有租金修订(管理服务费)</title>
<script src="../../js/validator.js"></script>
<script type="text/javascript"  src="../../js/jquery.js"></script>
<script type="text/javascript" src="../../js/numberseparation.js"></script>
<script src="../../js/calend.js"></script>
<link href="../../css/stleasing_tabledata.css" rel="stylesheet" type="text/css" >
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script type="text/javascript">
//表单提交事件
function verification(){
	if(Validator.Validate(form1,2)){
		$("input[id='equip_operation_revenuef']").focus();
		$("input[id='managefee_moneyf']").focus();   
		form1.submit();
		return true;
	}else{
		return false;
	}
}

//表单提交事件
function verification1(i){
	var n =i
	var Myform ='form'+n;

	var equip_operation_revenue =$("input[id='equip_operation_revenue_"+i+"']").val();
	var managefee_money =$("input[id='managefee_money_"+i+"']").val();
	
	if(	equip_operation_revenue!="" || managefee_money!=""){
		$("input[id='equip_operation_revenue_"+i+"']").focus();
		$("input[id='managefee_money_"+i+"']").focus();  
		return true;
	}else{
		return false;
	}
}	
</script>
</head>
  
<!-- 公共变量 -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- 公共变量 -->
		
<%
  	String nowDateTime = getSystemDate(0);//当前格式化之后的时间
	String contract_id=getStr(request.getParameter("contract_id"));
	String doc_id=getStr(request.getParameter("doc_id"));
	String begin_id=getStr(request.getParameter("begin_id"));

  	//序列号
 	int i=1;
 	int indexNum = 1;
  	
 	sqlstr="select count(id)+1 num from fund_managefee_plan_medi where contract_id='"+contract_id+"' and begin_id='"+begin_id+"' ";
	rs = db.executeQuery(sqlstr);
	if(rs.next()){
		indexNum =rs.getInt("num");
 	}
	
	sqlstr="select count(id) num from fund_managefee_plan_medi_temp where contract_id='"+contract_id+"' and begin_id='"+begin_id+"' and doc_id='"+doc_id+"'";
	rs = db.executeQuery(sqlstr);
	if(rs.next()){
		indexNum += rs.getInt("num");
	}
	
	rs.close();
%>
    	
<body style="overflow:auto;">
    <table border="0" style="border-collapse:collapse;" align="center" cellpadding="2"  cellspacing="1" width="100%" class="maintab_content_table">
    	<tr class="maintab_content_table_title">
    		<th width="100px;">管理服务费期次</th>
    		<th>租赁物件当月运营月收入</th>
    		
    		<th>管理方服务费金额</th>    		
    		<th>管理方分成比例</th>
    		
    		<th>计划付款时间</th>
    		<th>操作</th>
    	</tr>
    	<%
    		String str="managefee_list,equip_operation_revenue,managefee_money,manage_separate_ratio,";
    		str +="managefee_pay_side,plan_date";
    		String sql = "select "+str+" from fund_managefee_plan_medi_temp where contract_id='"+contract_id+"' and doc_id='"+doc_id+"' and begin_id='"+begin_id+"' ";
    		rs = db.executeQuery(sql);

    		while(rs.next()){
    			i++;		
    	%>
    	<form action="managefee_plan_up.jsp" name="form<%=i %>" target="blank" method="get">
	    	<tr>
				<td class="noNewLine"><input type="text"  label="管理服务费期次" Require="true" size="6" id="managefee_list_<%=i %>" 
				name="managefee_list" readonly="readonly" value="<%=getDBStr(rs.getString("managefee_list")) %>"></td>
				<td class="noNewLine"><input type="text" label="租赁物件当月运营月收入" Require="true" id="equip_operation_revenue_<%=i %>" name="equip_operation_revenue"   value="<%=getDBStr(rs.getString("equip_operation_revenue")) %>"><span class="biTian">*</span></td>
				<td class="noNewLine"><input type="text" label="管理方服务费金额" Require="true" id="managefee_money_<%=i %>" name="managefee_money"  value="<%=getDBStr(rs.getString("managefee_money")) %>"><span class="biTian">*</span></td>
				<td class="noNewLine"><input type="text" label="管理方分成比例" Require="true" id="manage_separate_ratio_<%=i %>" name="manage_separate_ratio"  value="<%=getDBStr(rs.getString("manage_separate_ratio")) %>">%<span class="biTian">*</span></td>
				<td class="noNewLine">
					<input name="plan_date" id="plan_date" type="text" value="<%=getDBDateStr(rs.getString("plan_date")) %>"  
					 	size="13" maxlength="20"  Require="true" readonly="readonly"/>
						<img  onClick="openCalendar(plan_date);return false" style="cursor:pointer; " 
						 src="../../images/fdmo_63.gif" width="20" height="19" border="0" align="absmiddle">
				<span class="biTian">*</span>
				</td>
				<td class="noNewLine">
				<input type="submit" name="up" value="修改" onclick="return verification1('<%=i %>');"/> 
				&nbsp;&nbsp;
				<input type="submit" name="up" value="删除"/>
				
				<input type="hidden" name="contract_id"  value="<%=contract_id %>">
	    		<input type="hidden" name="begin_id"  value="<%=begin_id %>">
	    		<input type="hidden" name="doc_id"  value="<%=doc_id %>">
				</td>	
	    	</tr>
    	</form>
    	<%}rs.close(); %>
    	
    	<form action="managefee_plan_save.jsp" name="form1" target="blank" method="get">
    	<%
      		String managefee_pay_side ="";
    		sqlstr= "select (SELECT title FROM ifelc_conf_dictionary where parentid='root.manager_pay_type' AND name=begin_info_medi.manager_pay_type";
    		sqlstr += ") as title from begin_info_medi where contract_id='"+contract_id+"' and begin_id='"+begin_id+"' ";
    		rs=db.executeQuery(sqlstr);
    		if(rs.next()){
    			managefee_pay_side=getDBStr(rs.getString("title"));
    		}rs.close();
    	 %>
			    <tr>		
					<td class="noNewLine"><input type="text" label="管理服务费期次" Require="true" name="managefee_list" size="6" readonly="readonly" value="<%=indexNum %>"></td>
					<td class="noNewLine"><input type="text" label="租赁物件当月运营月收入" Require="true" id="equip_operation_revenuef" name="equip_operation_revenue" value=""><span class="biTian">*</span></td>
					<td class="noNewLine"><input type="text" label="管理方服务费金额" Require="true" id="managefee_moneyf" name="managefee_money" value=""><span class="biTian">*</span></td>
					<td class="noNewLine"><input type="text" label="管理方分成比例" Require="true" id="manage_separate_ratiof" name="manage_separate_ratio" value="">%<span class="biTian">*</span></td>
					<td class="noNewLine">
						<input name="plan_date" id="plan_date" type="text" value="<%=nowDateTime%>"  
					 	size="13" maxlength="20"  Require="true" readonly="readonly"/>
						<img  onClick="openCalendar(plan_date);return false" style="cursor:pointer; " 
						 src="../../images/fdmo_63.gif" width="20" height="19" border="0" align="absmiddle">
						 <span class="biTian">*</span>
					</td>
					<td class="noNewLine">
					<input type="button" value="添加" onclick="return verification();"/>
					<input type="hidden" name="contract_id" readonly="readonly" value="<%=contract_id %>">
			    	<input type="hidden" name="doc_id" readonly="readonly" value="<%=doc_id %>">
			    	<input type="hidden" name="begin_id" readonly="readonly" value="<%=begin_id %>">
			    	<input type="hidden" name="managefee_pay_side" readonly="readonly" value="<%=managefee_pay_side %>">
					</td>						 		
		    	</tr>
			</form>
    </table>
  </body>
  <script type="text/javascript">
	$(document).ready(function() {
	    $("input[type='text'][name!='managefee_list'][name!='manage_separate_ratio']").each(function(u) {
			$(this).blur(function (){mouse(this.value,this.id)});
			$(this).focus(function (){huifumouse(this.value,this.id)});
		 });
		 
		  $("input[name='equip_operation_revenue']").blur();
		  $("input[name='managefee_money']").blur();
	});
</script>
</html>
