<%@ page language="java" import="java.util.*" pageEncoding="utf-8" errorPage="/public/pageError.jsp"%>
<%@ include file="../../public/simpleHeadImport.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>   
<title>或有租金修订</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>

<script type="text/javascript"  src="../../js/jquery.js"></script>
<script type="text/javascript" src="../../js/numberseparation.js"></script>
<script src="../../js/validator.js"></script>
<script src="../../js/calend.js"></script>
<link href="../../css/stleasing_tabledata.css" rel="stylesheet" type="text/css" >
<script type="text/javascript">
//表单提交事件
function verification(){
	if(Validator.Validate(form1,2)){
		$("input[type='text']").focus();  
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
	var leas_separate_ratio =$("input[id='leas_separate_ratio_"+i+"']").val();
	var leas_plan_rent =$("input[id='leas_plan_rent_"+i+"']").val();
	var leas_other_out =$("input[id='leas_other_out_"+i+"']").val();
	var leas_fact_rent =$("input[id='leas_fact_rent_"+i+"']").val();
	var leas_all_in =$("input[id='leas_all_in_"+i+"']").val();
	
	if(	equip_operation_revenue!="" || leas_separate_ratio!=""||leas_plan_rent!=""||
		leas_other_out!=""||leas_fact_rent!=""||leas_all_in!=""){
		
		$("input[type='text']").focus();  
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

	
	//查询当前的起始编号
	int i=1;
	int indexNum = 1;
	
	String plan_bank_name ="";
	String plan_bank_no ="";
	
	sqlstr="select count(id)+1 num from fund_rent_plan_medi where contract_id='"+contract_id+"' and begin_id='"+begin_id+"' ";
	rs = db.executeQuery(sqlstr);
	if(rs.next()){
		indexNum = rs.getInt("num");
	}
	
	sqlstr="select count(id) num from fund_rent_plan_medi_temp where contract_id='"+contract_id+"' and begin_id='"+begin_id+"' and doc_id='"+doc_id+"'";
	rs = db.executeQuery(sqlstr);
	if(rs.next()){
		indexNum += rs.getInt("num");
	}
	
	rs.close();
 %>
 
 <body style="overflow:auto;">
   <table border="0" style="border-collapse:collapse;" align="center" cellpadding="2"  
   	cellspacing="1" width="100%" class="maintab_content_table">
   	<tr class="maintab_content_table_title">
   		<th width="80px;">租金期次</th>
   		<th>租赁物件当月运营月收入</th>
   		
   		<th>结算起始日</th>  
   		<th>结算截止日</th>  
   		
   		<th>租赁公司分成比例</th>    		
   		<th>我司应收租金合计</th>
   		<th>其他减项</th>
   		
   		<th>我司实收租金</th>
   		<th>我司累计所得</th>   
   		 		
   		<th>收入结算日</th>  
   		<th>计划收取时间</th>
   		<th>操作</th>
   	</tr>
   	<% 
   		String str="rent_list,equip_operation_revenue,leas_separate_ratio,leas_plan_rent,";
   		str +="leas_other_out,leas_fact_rent,leas_all_in,leas_rent_start_date,leas_rent_end_date,income_hire_date,plan_date,plan_bank_name,plan_bank_no";
   		
   		sqlstr = " Select "+str+" from fund_rent_plan_medi_temp where contract_id='"+contract_id+"' and doc_id='"+doc_id+"' and begin_id='"+begin_id+"' ORDER BY rent_list";
   		System.out.println("查询--------"+sqlstr);
   		rs = db.executeQuery(sqlstr);
   		while(rs.next()){
   			i++;
   	%>

    	<form action="rent_plan_up.jsp" name="form<%=i %>" target="blank" method="get">
	    	<tr>
				<td class="noNewLine">
				<input type="text" id="rent_list_<%=i %>" name="rent_list" label="租金期次" size="6" Require="true" readonly="readonly" value="<%=getDBStr(rs.getString("rent_list")) %>">
				</td>
			<td class="noNewLine"><input type="text" label="租赁物件当月运营月收入" Require="true" id="equip_operation_revenue_<%=i %>" name="equip_operation_revenue"   value="<%=getDBStr(rs.getString("equip_operation_revenue")) %>">
			<span class="biTian">*</span></td>
				<td class="noNewLine">
					<input name="leas_rent_start_date" id="leas_rent_start_date" type="text" Require="true" label="结算起始日" value="<%=getDBDateStr(rs.getString("leas_rent_start_date")) %>"  
				 	size="13" maxlength="20"  Require="true" readonly="readonly"/>
					<img  onClick="openCalendar(leas_rent_start_date);return false" style="cursor:pointer; " 
					 src="../../images/fdmo_63.gif" width="20" height="19" border="0" align="absmiddle">
					<span class="biTian">*</span>
				</td>
				<td class="noNewLine">
					<input name="leas_rent_end_date" id="leas_rent_end_date" type="text" Require="true" label="结算截止日" value="<%=getDBDateStr(rs.getString("leas_rent_end_date")) %>"  
				 	size="13" maxlength="20"  Require="true" readonly="readonly"/>
					<img  onClick="openCalendar(leas_rent_end_date);return false" style="cursor:pointer; " 
					 src="../../images/fdmo_63.gif" width="20" height="19" border="0" align="absmiddle">
					<span class="biTian">*</span>
				</td>
				
				<td class="noNewLine"><input type="text" label="租赁公司分成比例" Require="true" id="leas_separate_ratio_<%=i %>" name="leas_separate_ratio"  value="<%=getDBStr(rs.getString("leas_separate_ratio")) %>"><span class="biTian">*</span></td>
				<td class="noNewLine"><input type="text" label="我司应收租金合计	" Require="true" id="leas_plan_rent_<%=i %>" name="leas_plan_rent"  value="<%=getDBStr(rs.getString("leas_plan_rent")) %>"><span class="biTian">*</span></td>
				<td class="noNewLine"><input type="text" label="其他减项	" Require="true" id="leas_other_out_<%=i %>" name="leas_other_out"  value="<%=getDBStr(rs.getString("leas_other_out")) %>"><span class="biTian">*</span></td>
				<td class="noNewLine"><input type="text" label="我司实收租金	" Require="true" id="leas_fact_rent_<%=i %>" name="leas_fact_rent"  value="<%=getDBStr(rs.getString("leas_fact_rent")) %>"><span class="biTian">*</span></td>
				<td class="noNewLine"><input type="text" label="我司累计所得" Require="true" id="leas_all_in_<%=i %>" name="leas_all_in"  value="<%=getDBStr(rs.getString("leas_all_in")) %>"><span class="biTian">*</span></td>
				
				<td class="noNewLine">
					<input name="income_hire_date" id="income_hire_date" type="text" Require="true" label="收入结算日" value="<%=getDBDateStr(rs.getString("income_hire_date")) %>"  
				 	size="13" maxlength="20"  Require="true" readonly="readonly"/>
					<img  onClick="openCalendar(income_hire_date);return false" style="cursor:pointer; " 
					 src="../../images/fdmo_63.gif" width="20" height="19" border="0" align="absmiddle">
					<span class="biTian">*</span>
				</td>
				
				<td class="noNewLine">
					<input name="plan_date" id="plan_date" type="text" Require="true" label="计划收取时间" value="<%=getDBDateStr(rs.getString("plan_date")) %>"  
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
    	
    	<form action="rent_plan_save.jsp" name="form1" target="blank" method="get" >
    	<%
			sqlstr="select plan_bank_name,plan_bank_no from begin_info_medi where contract_id='"+contract_id+"' and begin_id='"+begin_id+"' ";
			rs=db.executeQuery(sqlstr);
			if(rs.next()){
	    		plan_bank_name=getDBStr(rs.getString("plan_bank_name"));
	    		plan_bank_no =getDBStr(rs.getString("plan_bank_no"));
			}
			rs.close();
    	%>
	    <tr>		
			<td class="noNewLine"><input type="text" id="rent_list" name="rent_list" size="6" readonly="readonly" value="<%=indexNum %>"></td>
			<td class="noNewLine"><input type="text" label="租赁物件当月运营月收入" Require="true" id="equip_operation_revenuef" name="equip_operation_revenue" value=""><span class="biTian">*</span></td>
			<td class="noNewLine">
			<input name="leas_rent_start_date" id="leas_rent_start_date" Require="true" label="结算起始日" type="text" value="<%=nowDateTime%>"  
			 	size="13" maxlength="20"  Require="true" readonly="readonly"/>
				<img  onClick="openCalendar(leas_rent_start_date);return false" style="cursor:pointer; " 
				 src="../../images/fdmo_63.gif" width="20" height="19" border="0" align="absmiddle">
				 <span class="biTian">*</span>
			</td>
			
			<td class="noNewLine">
			<input name="leas_rent_end_date" id="leas_rent_end_date" Require="true" label="结算截止日" type="text" value="<%=nowDateTime%>"  
			 	size="13" maxlength="20"  Require="true" readonly="readonly"/>
				<img  onClick="openCalendar(leas_rent_end_date);return false" style="cursor:pointer; " 
				 src="../../images/fdmo_63.gif" width="20" height="19" border="0" align="absmiddle">
				 <span class="biTian">*</span>
			</td>
			
			
			<td class="noNewLine"><input type="text" label="租赁公司分成比例" Require="true" id="leas_separate_ratiof" name="leas_separate_ratio" value=""><span class="biTian">*</span></td>
			<td class="noNewLine"><input type="text" label="我司应收租金合计" Require="true" id="leas_plan_rentf" name="leas_plan_rent" value=""><span class="biTian">*</span></td>
			<td class="noNewLine"><input type="text" label="其他减项" Require="true" id="leas_other_outf" name="leas_other_out" value=""><span class="biTian">*</span></td>
			<td class="noNewLine"><input type="text" label="我司实收租金" Require="true" id="leas_fact_rentf" name="leas_fact_rent" value=""><span class="biTian">*</span></td>
			<td class="noNewLine"><input type="text" label="我司累计所得" Require="true" id="leas_all_inf" name="leas_all_in" value=""><span class="biTian">*</span></td>
			
			<td class="noNewLine">
				<input name="income_hire_date" id="income_hire_date" type="text" Require="true" label="收入结算日" value="<%=nowDateTime %>"  
			 	size="13" maxlength="20"  Require="true" readonly="readonly"/>
				<img  onClick="openCalendar(income_hire_date);return false" style="cursor:pointer; " 
				 src="../../images/fdmo_63.gif" width="20" height="19" border="0" align="absmiddle">
				<span class="biTian">*</span>
			</td>
				
			<td class="noNewLine">
			<input name="plan_date" id="plan_date" Require="true" label="计划收取时间" type="text" value="<%=nowDateTime%>"  
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
   			<input type="hidden" name="plan_bank_name" value="<%=plan_bank_name %>" />
   			<input type="hidden" name="plan_bank_no" value="<%=plan_bank_no %>" />
			</td>						 		
    	</tr>
	</form>
    </table>
  </body>
  
<script type="text/javascript">
	$(document).ready(function() {
	    $("input[type='text'][name!='rent_list'][name!='leas_rent_start_date'][name!='leas_rent_end_date'][name!='income_hire_date'][name!='plan_date']").each(function(u) {
			$(this).blur(function (){mouse(this.value,this.id)});
			$(this).focus(function (){huifumouse(this.value,this.id)});
		 });
		 
		 $("input[type='text']").blur();
	});
</script>
</html>
