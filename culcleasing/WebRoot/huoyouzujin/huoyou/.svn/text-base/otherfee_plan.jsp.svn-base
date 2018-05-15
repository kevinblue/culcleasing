<%@ page language="java" import="java.util.*" pageEncoding="utf-8" errorPage="/public/pageError.jsp"%>
<%@ include file="../../public/simpleHeadImport.jsp"%>

<html>
<head>   
<title>或有租金修订(其他金额)</title>
<script type="text/javascript"  src="../../js/jquery.js"></script>
<script type="text/javascript" src="../../js/numberseparation.js"></script>
<script language="javascript" src="/dict/js/js_dictionary.js"></script>
<script src="../../js/validator.js"></script>
<script src="../../js/calend.js"></script>
<link href="../../css/stleasing_tabledata.css" rel="stylesheet" type="text/css" >
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
	
<script type="text/javascript">
//表单提交事件
function verification(){
	if(Validator.Validate(form1,2)){
		$("input[name='otherfee_money']").focus();   
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
	
	var otherfee_money =$("input[id='otherfee_money_"+i+"']").val();
	
	if(	otherfee_money!=""){
		$("input[id='otherfee_money_"+i+"']").focus();  
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
	String begin_id=getStr(request.getParameter("begin_id"));
 	String contract_id=getStr(request.getParameter("contract_id"));
	String doc_id=getStr(request.getParameter("doc_id"));
	String nowDateTime = getSystemDate(0);//当前格式化之后的时间

  	//序列号
 	int i=1;
 	int indexNum = 1;

	String sqlstring="select count(id)+1 num from fund_otherfee_plan_medi where contract_id='"+contract_id+"' and begin_id='"+begin_id+"' ";
	rs = db.executeQuery(sqlstring);
	if(rs.next()){
		indexNum =rs.getInt("num");
	}
		
	sqlstr="select count(id) num from fund_otherfee_plan_medi_temp where contract_id='"+contract_id+"' and begin_id='"+begin_id+"' and doc_id='"+doc_id+"'";
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
   		<th width="100px;">其他金额期次</th>
   		<th>款项类型</th>
   		
   		<th>款项方式</th>    		
   		<th>其他费用金额</th>
   		<th>计划收支时间</th>
   		
   		<th>操作</th>
   	</tr>
   	
   	<%
   		String otherfee_paytype = "";
   		String otherfee_feetype = "";
   		String str="otherfee_list,otherfee_feetype,otherfee_paytype,otherfee_money,";
   		str +="plan_date";
   		String sql = "select "+str+" from fund_otherfee_plan_medi_temp where  contract_id='"+contract_id+"' and doc_id='"+doc_id+"' and begin_id='"+begin_id+"' ";

   		rs = db.executeQuery(sql);
   		while(rs.next()){
   			i++;		
   			otherfee_paytype= getDBStr(rs.getString("otherfee_paytype"));
   			otherfee_feetype=getDBStr(rs.getString("otherfee_feetype"));
   	%>
    	<form action="otherfee_plan_up.jsp" name="form<%=i %>" target="blank" method="get" >
	    	<tr>
				<td class="noNewLine" ><input type="text" name="otherfee_list" label="其他金额期次" size="6" Require="true" readonly="readonly" value="<%=getDBStr(rs.getString("otherfee_list")) %>"></td>
				<td class="noNewLine">
					<select style="width:100" name="otherfee_feetype<%=i %>" id="otherfee_feetype" label="款项类型" Require="true" ></select>
					<script language="javascript" class="text">
						dict_list("otherfee_feetype<%=i %>","root.otherfee_feetype","<%=otherfee_feetype%>","title");
					</script>
					 <span class="biTian">*</span>
				</td>
				
				<td class="noNewLine" >
					<input type="radio" name="otherfee_paytype" style="border: 0px" value="收款" <%="收款".equals(otherfee_paytype)?"checked=checked":"" %>>收款
		    		<input type="radio" name="otherfee_paytype" style="border: 0px" value="付款" <%="付款".equals(otherfee_paytype)?"checked=checked":"" %>>付款
 					<span class="biTian">*</span>
				</td>
				
				<td class="noNewLine" ><input type="text" id="otherfee_money_<%=i %>" name="otherfee_money" label="其他费用金额" Require="true"  value="<%=getDBStr(rs.getString("otherfee_money")) %>"> <span class="biTian">*</span></td>

				<td class="noNewLine" >
				<input name="plan_date" id="plan_date" type="text" label="计划收支时间" Require="true"  value="<%=getDBDateStr(rs.getString("plan_date")) %>"  
					 	size="13" maxlength="20"  Require="true" readonly="readonly"/>
						<img  onClick="openCalendar(plan_date);return false" style="cursor:pointer; " 
						 src="../../images/fdmo_63.gif" width="20" height="19" border="0" align="absmiddle">
				
				 <span class="biTian">*</span>
				</td >
				
				<td class="noNewLine">
				<input type="submit" name="up" value="修改" onclick="return verification1('<%=i %>');"/> 
				&nbsp;&nbsp;
				<input type="submit" name="up" value="删除"/>
				
	    		<input type="hidden" name="i_index"  value="<%=i %>">
	    		<input type="hidden" name="contract_id"  value="<%=contract_id %>">
	    		<input type="hidden" name="begin_id"  value="<%=begin_id %>">
	    		<input type="hidden" name="doc_id"  value="<%=doc_id %>">
				</td>	
	    	</tr>
    	</form>
    	<%}rs.close(); %>
    		
    		<form action="otherfee_plan_save.jsp" name="form1" target="blank" method="get">
			    <tr>
					<td class="noNewLine">
					<input type="text" name="otherfee_list" label="其他金额期次" Require="true" size="6" readonly="readonly" value="<%=indexNum %>"></td>
					<td class="noNewLine">
						<select style="width:100" name="otherfee_feetypet" id="otherfee_feetype" label="款项类型" Require="true" >
						<span class="biTian">*</span></select>
						<script language="javascript" class="text">
							dict_list("otherfee_feetypet","root.otherfee_feetype","root.otherfee_feetype.001","title");
						</script>
						<span class="biTian">*</span>
					</td>
					
					<td class="noNewLine">
					 <input type="radio" name="otherfee_paytype" style="border: 0px" value="收款" >收款
		    		 <input type="radio" name="otherfee_paytype" style="border: 0px" value="付款" checked="checked">付款
		    		 <span class="biTian">*</span>
					</td>
					
					<td class="noNewLine"><input type="text" id="otherfee_moneyf" name="otherfee_money" label="其他费用金额" Require="true"  value=""> <span class="biTian">*</span></td>
					<td class="noNewLine">
					<input name="plan_date" id="plan_date" type="text" value="<%=nowDateTime%>"  
					 	size="13" maxlength="20"   label="计划收支时间" Require="true" readonly="readonly"/>
						<img  onClick="openCalendar(plan_date);return false" style="cursor:pointer; " 
						 src="../../images/fdmo_63.gif" width="20" height="19" border="0" align="absmiddle">
						  <span class="biTian">*</span>
					</td>
					<td class="noNewLine">
						<input type="button" value="添加" onclick="return verification();"/>
						<input type="hidden" name="contract_id" readonly="readonly" value="<%=contract_id %>">
				    	<input type="hidden" name="doc_id" readonly="readonly" value="<%=doc_id %>">
				    	<input type="hidden" name="begin_id" readonly="readonly" value="<%=begin_id %>">
					</td>						 		
		    	</tr>
			</form>
    </table>
  </body>
<script type="text/javascript">
	$(document).ready(function() {
	    $("input[type='text'][name!='otherfee_list']").each(function(u) {
			$(this).blur(function (){mouse(this.value,this.id)});
			$(this).focus(function (){huifumouse(this.value,this.id)});
		 });
		 
		 $("input[name='otherfee_money']").blur();
	});
</script>
</html>
