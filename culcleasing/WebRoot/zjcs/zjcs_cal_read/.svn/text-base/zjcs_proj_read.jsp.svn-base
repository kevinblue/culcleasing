<%@ page contentType="text/html; charset=gbk" language="java" errorPage="/public/pageError.jsp" %>
<%@ page import="java.sql.*" %> 
<%@ page import="java.util.ArrayList"%> 
<%@ page import="java.util.List"%>
<%@ include file="../../func/common_simple.jsp"%>

<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<!-- 项目立项--拟商务条件 表：contract_condition_temp  项目交易结构-->
<title>租金测算 - 项目交易结构</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script language="javascript" src="/dict/js/js_dictionary.js"></script>

<script Language="Javascript" src="../../js/jquery.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	$(":input").attr("disabled","disabled");
});
</script>
</head>

<%
	ResultSet rs  = null;
	List<String> list = new ArrayList<String>();
	//获取参数 proj_id,doc_id
	String proj_id = getStr(request.getParameter("proj_id"));//合同编号   "001";//
	String doc_id = getStr(request.getParameter("doc_id"));//文档编号 "001";// measure_id
	//测试proj_id,doc_id
	//proj_id = "00007-03-02-2010-00162-00000";
	//doc_id = "F54FA93C6C6E0F0B4825780300334D18";
	
	StringBuffer querySql = new StringBuffer();
	//判断主键是否为空
	querySql.append("select proj_id,currency,equip_amt,first_payment,")//0-3
	 		.append("lease_money,caution_money,net_lease_money,")//4-6
	 		.append("handling_charge,income_number_year,lease_term,")//7-9
	 		.append("income_number,nominalprice,period_type,return_amt,")//10-13
	 		.append("year_rate,rate_float_type,before_interest,")//14-16
	 		.append("rate_adjustment_modulus,pena_rate,income_day,start_date,")//17-20
	 		.append("plan_irr,measure_type,other_income,other_expenditure,creator,")//21-25
	 		.append("create_date,modify_date,modificator,rate_float_amt,consulting_fee, ")//26-30
	 		.append("market_irr,  ")//新增字段 市场irr 31
	 		.append("lease_money_proportion,  ")//【新增字段 2010-07-27】32 净融资额比例
	 		.append("accountPrincipal,  ")//【新增字段 2010-08-06】33 会计核算本金
	 		.append("rentScale,  ")//【新增字段 2010-08-20】34 圆整到
	 		.append("liugprice,  ")//【新增字段 2010-09-21】35 留购价（原本的留购价改成残值）
	 		.append("delay,  ")//【新增字段 2010-10-20】36 延迟期数
	 		.append("grace,  ")//【新增字段 2010-10-20】37 宽限期数
	 		.append("management_fee,  ")//【新增字段 2010-11-11】38 管理费 
	 		.append("isnull(ajdustStyle,'0'),  ")//【新增字段 2010-11-23】39 调息方式
	 		.append("isnull(amt_return,'否') as amt_return  ")//【新增字段 2011-01-10】40 设备是否退还
	 	   //--新增
	 		.append(" ,into_batch  ")//【新增字段 2011-05-01】41 是否批量调息
		    .append(" ,discount_rate  ")//【新增字段 2011-05-01】42 贴现息
		    .append(" ,insure_type  ")//【新增字段 2011-05-01】43 投保方式
		    .append(" ,insure_money  ")//【新增字段 2011-05-01】44 保费金额
		    .append(" ,consulting_fee_in  ")//【新增字段 2011-05-01】45 咨询费收入
		    .append(" ,free_defa_inter_day  ")//【新增字段 2011-05-01】46 逾期宽限日
		    .append(" ,rate_subsidy  ")//【新增字段 2011-05-01】47 利息补贴
	 		.append(" from proj_condition_temp ")
	 	    .append(" where proj_id = '"+proj_id+"'")//合同编号
	 	    .append(" and measure_id = '"+doc_id+"' ");//文档编号
		System.out.println("项目交易只读结构的查询SQL-->   "+querySql.toString());
	 	rs = db.executeQuery(querySql.toString());//执行查询
	 	//rs.last(); //移到最后一行
		//int rowCount = rs.getRow(); //得到当前行号，也就是记录数
		//rs.beforeFirst(); //还要用到记录集，就把指针再移到初始化的位置
	 	while(rs.next()){
	 		//循环取值 取该表的前35列，下标从1开始取
	 		for(int j = 1;j <= 48;j++){
		 		list.add(getDBStr(rs.getString(j)));
	 		}
	 	} 
	 	if(list.size()==0){
	 		for(int j=1;j<=48;j++){
	 			list.add("");
	 		}
	 	}
	 	rs.close();
	 	db.close();
%> 
<body onLoad="public_onload(0)">

<form name="form1" method="post" target="rentplan" action="">
<table  class="title_top" width=100% height="100%" align=center cellspacing=0 border="0" cellpadding="0">

<tr valign="top">
	<td  align=center width=100% height=100%>
	<div id="divH" class="tabBody" style="background:#ffffff;width:100%;height:430px;overflow:auto;">
	<div id="TD_tab_0">
		<table  border="0" cellspacing="0" cellpadding="0" width="100%" height=100%" align="center" class="tab_table_title">
 			 <tr>
  				<td scope="row" nowrap>项目编号</td>
    			<td>
	    			<input name="proj_id" id="proj_id" type="text" value="<%=list.get(0)%>" 
	    		 	 size="35" maxlength="50" readonly="readonly"/>
	    			<span class="biTian">*</span>
     			</td>
	 			<td scope="row" nowrap>货币类型</td>
    		    <td> 
					<select name="currency" id="currency" Require="true" style="width: 100px;" disabled="disabled"></select>
					<script language="javascript">
					dict_list("currency","currency_type","<%=list.get(1) %>","name");
					</script>
    				<span class="biTian">*</span>
				</td>
    			<td scope="row" nowrap>设备金额</td>
    				<td>
    					<input name="equip_amt" id="equip_amt" type="text" 
    						value="<%=formatNumberDoubleTwo(getDBStr(list.get(2)))%>" 
    						size="13" maxlength="50" maxB="50"  disabled="disabled" />
       				<span  class="biTian">*</span>
     			</td>
      			<td scope="row" nowrap>首付款</td>
      			<td>
    				<input name="first_payment" type="text" value="<%=formatNumberDoubleTwo(getDBStr(list.get(3)))%>" 
    				dataType="Money" size="13" maxlength="50" maxB="50" disabled="disabled" />
    				<span class="biTian">*</span>
   	   			</td> 
  			</tr> 
  				
  			<tr>
   				<td scope="row" nowrap>租赁本金</td><!--  租赁本金 = 设备金额 - 首付款   -->
    			 <td>
    				<input name="lease_money" id="lease_money" 
    				value="<%=formatNumberDoubleTwo(getDBStr(list.get(4)))%>" 
    				readonly type="text" Require="true"     
    				dataType="Money" size="13" maxlength="100" maxB="100" Require="true"/>
    				<span class="biTian">*</span>
	 			</td>
				<td  scope="row" nowrap>租赁保证金</td>
				<td>
					<input name="caution_money" id="caution_money"    
					 value="<%=formatNumberDoubleTwo(getDBStr(list.get(5)))%>" 
					dataType="Money" size="13" maxlength="20" maxB="20"  Require="true" 
					onchange="assignment()" type="text"/>
					<span class="biTian">*</span>
				</td>
				<td  scope="row" nowrap>租赁手续费</td>
				<td>
					<input name="handling_charge" type="text" 
				    value="<%=formatNumberDoubleTwo(getDBStr(list.get(7)))%>" 
		 			dataType="Money" size="13" maxlength="20" 
		 			maxB="20"  Require="true" onchange="assignment()"/>
					<span class="biTian">*</span>
				</td>
				<td scope="row" nowrap>管理费</td><!-- onPropertyChange -->
			    <td colspan="">
			    	<input name="management_fee" type="text" value="<%=formatNumberDoubleTwo(getDBStr(list.get(38)))%>"  
			    		dataType="Money" size="13" maxlength="10" maxB="10"  Require="true" /> 
					<span class="biTian">*</span>
				</td>
  			</tr>
  			
  			<tr>
			<td scope="row" nowrap>咨询费收入</td>
		  	<td>
		  		<input name="consulting_fee_in" type="text" value="<%=formatNumberDoubleTwo(getDBStr(list.get(45)))%>"  
					dataType="Money" size="13" maxlength="20" 
					maxB="20"  Require="true"  />
				<span class="biTian">*</span>
			</td>
		  	<td scope="row" nowrap>咨询费支出</td>
		  	<td>
		  		<input name="consulting_fee" type="text" value="<%=formatNumberDoubleTwo(getDBStr(list.get(30)))%>"  
					dataType="Money" size="13" maxlength="20" 
					maxB="20"  Require="true"  />
				<span class="biTian">*</span>
			</td>
			<td  scope="row" nowrap>其他收入</td>
			<td>
				<input name="other_income" type="text" value="<%=formatNumberDoubleTwo(getDBStr(list.get(23)))%>"  
					dataType="Money" size="13" maxlength="20" maxB="20"  Require=""  />
			</td>
			<td scope="row" nowrap>其他支出</td>
		    <td colspan="">
		    	<input name="other_expenditure" type="text" value="<%=formatNumberDoubleTwo(getDBStr(list.get(24)))%>"  
		    		dataType="Money" size="13" maxlength="10" maxB="10"  Require="true"  /> 
			</td>
		</tr>
		  <tr>	
			<td  scope="row" nowrap>残值收入</td>
			<td>
				<input name="nominalprice" type="text" value="<%=formatNumberDoubleTwo(getDBStr(list.get(11)))%>"   
					dataType="Money" size="13" maxlength="20" maxB="20"  Require="true"/>
				<span class="biTian">*</span>
			</td>
		    <td  scope="row" nowrap>厂商返利</td>
			<td>
				<input name="return_amt" type="text" value="<%=formatNumberDoubleTwo(getDBStr(list.get(13)))%>"  
					dataType="Money" size="13" maxlength="20" 
					maxB="20"  Require="true"  />
				<span class="biTian">*</span>
			</td>
			
			<td  scope="row" nowrap>投保方式</td>
			<td>
				<select name="insure_type" id="insure_type" Require="true" style="width: 100px;"></select>
				<script language="javascript" class="text">
				dict_list("insure_type","insure_type","<%=list.get(43) %>","name");
				</script>
   				<span class="biTian">*</span>
			</td>
			<td scope="row" nowrap>保费金额</td>
		    <td colspan="">
		    	<input name="insure_money" type="text" value="<%=formatNumberDoubleTwo(getDBStr(list.get(44)))%>"  
					dataType="Money" size="13" maxlength="20" 
					maxB="20"  Require="true"  />
			</td>
		  </tr>
		  
  			
		  <tr> 
   				<!-- 净融资额=设备款-保证金-手续费-厂商返佣-其他收入+咨询费+其他支出  -->
  				<td scope="row" nowrap>净融资额</td>
   	 			<td>
    				<!-- onclick="assignment()"  净融资额 = 租赁本金 - 保证金  -->
    				<input name="net_lease_money" id="net_lease_money" type="text" 
    				value="<%=formatNumberDoubleTwo(getDBStr(list.get(6)))%>" readonly 
    				dataType="Money" size="13" maxlength="20" maxB="20"  
    				Require="true" onclick="assignment()"/> 
    				净融资额比例
    				<input name="lease_money_proportion" id="lease_money_proportion" type="text" 
					value="<%=formatNumberDoubleTwo(getDBStr(list.get(32)))%>" size="5" 
					maxlength="10" readonly="readonly" 
					onclick="getlmp_value()" Require="true"/>% 
    				<span class="biTian">*</span>
				</td>
			
				<!-- 根据付租方式、付租类型、租赁期限和设备退还从主协议报价信息中导入，允许手工修改 -->
				<td  scope="row" nowrap>租赁年利率</td>
				<td>
					<input name="year_rate" type="text" value="<%=formatNumberStr(getDBStr(list.get(14)),"#,##0.000000")%>"   
						dataType="Rate" size="13" maxlength="10" maxB="10"  Require="true" />%
						<!--  	    --> 
					<span class="biTian">*</span>
				</td>  
				
				<td scope="row" nowrap>罚息日利率</td>
			    <td colspan="">
			    	<input name="pena_rate" type="text" value="<%=formatNumberDoubleTwo(getDBStr(list.get(18)))%>"  
			         size="13" maxlength="20" dataType="Money" size="13" maxlength="10" maxB="10"  Require="true"/>%%
			         <!-- 另外的判断输入方式 只能输入整数 onKeyUp="value=value.replace(/[^\d]/g,'')"
			         	onblur="if(isNaN(document.all.tolerance_date.value)){
			            alert('免息期请正确输入天数');document.all.tolerance_date.focus();}"  
			          -->
			    	<span class="biTian">*</span>
				</td>  
				
				<td scope="row" nowrap>逾期宽限日</td>
			    <td> 
			    	<input name="free_defa_inter_day" type="text" value="<%=list.get(46) %>"  
			    		dataType="Integer" size="13" maxlength="10" maxB="10"/>
			    	<span class="biTian">*</span>
				</td>
		  </tr>	
		  
		   <tr>
			   <td scope="row" nowrap>付租方式</td>
	    			<td>
	    	 			<select name="income_number_year" id="income_number_year" 
	    	 				style="width:100px;">
						<script type="text/javascript">
								w(mSetOpt("<%=list.get(8)%>","月付|双月付|季付|半年付|年付","1|2|3|6|12")); 
						</script>
						</select>
	    				<span class="biTian">*</span>
					</td>
				<td scope="row" nowrap>付租类型</td>
			    <td>
			    <select style="width:100px;" name="period_type">
			        <script type="text/javascript">
				        	w(mSetOpt('<%=list.get(12)%>',"期初|期末","1|0"));
			        </script>
			     </select>
			     <span class="biTian">*</span>
				</td> 
			    <!-- 还租次数=租赁期限/年还租次数 -->
			  	<td scope="row" nowrap>还租次数</td>
			    <td>
			    	<input name="income_number" type="text" value="<%=list.get(10)%>" 
			    		dataType="Integer" size="13" maxlength="10" maxB="10"  Require="true" />
			    	<span class="biTian">*</span>
				</td>
			
			<!-- 根据付租方式判断 -->
			<td scope="row" nowrap>租赁期限(月)</td>
		    <td>
		    	<input name="lease_term" type="text" value="<%=list.get(9)%>"   
		    		dataType="Integer" size="13" maxlength="10" maxB="10"  Require="true" readonly="readonly"/>
		    	<span class="biTian">*</span>
			</td>
		  </tr>
			
		  <tr>
		  	<td scope="row" nowrap>利率浮动类型</td>
		    <td>
		    	<select name="rate_float_type"  >
		        <script type="text/javascript">
			        	w(mSetOpt('<%=list.get(15)%>',"按央行利率浮动比率|按央行利率加点|固定调整租金金额|保持不变","0|1|2|3"));
		        </script>
		        </select> 
		    	<span class="biTian">*</span>
			</td>
			<td scope="row" nowrap>利率调整值</td>
		    <td>
		    	<input name="rate_float_amt" type="text" value="<%=getDBStr(list.get(29))%>" onblur="alertChange()"
		    		dataType="Double" size="13" maxlength="10" maxB="10"  Require="true" />
		    	<span class="biTian">*</span>
			</td>
			<td colspan="2">
				<div id="div_rate"></div>
			</td>
			
			<td scope="row" nowrap>预计IRR</td>
		  	<td>
		  		<input name="market_irr" type="text" value="<%=formatNumberStr(getDBStr(list.get(31)),"#,##0.000000")%>"  
					size="13" maxlength="10" readonly="readonly" />%
			</td>
		  </tr>
		  
		  <tr>
		  	<td scope="row" nowrap>租前息</td>
		    <td>
		    	<input name="before_interest" type="text" value="<%=formatNumberDoubleTwo(getDBStr(list.get(16)))%>"  
		    		dataType="Money" size="13" maxlength="10" maxB="10"  Require="true"   />
		    	<span class="biTian">*</span>
			</td>
			<td scope="row" nowrap>利息补贴</td>
		  	<td>
		  		<input name="rate_subsidy" type="text" value="<%=formatNumberDoubleTwo(getDBStr(list.get(47)))%>"
					dataType="Money" size="13" maxlength="20" maxB="20"  Require=""  />
				<span class="biTian"></span>
			</td>
			<td scope="row" nowrap>贴现息</td>
		  	<td>
		  		<input name="discount_rate" type="text" value="<%=formatNumberDoubleTwo(getDBStr(list.get(42)))%>"  
					dataType="Money" size="13" maxlength="20" maxB="20"  Require=""  />
				<span class="biTian">*</span>
			</td>
			<td  scope="row" nowrap>预计起租日</td>
			<td>
				<input name="start_date" type="text" value="<%=getDBDateStr(list.get(20))%>"    
					dataType="Date" size="13" maxlength="20"  Require="true" readonly="readonly"/>
				<img  onClick="openCalendar(start_date);return false" style="cursor:pointer; " 
				 src="../../images/fdmo_63.gif" width="20" height="19" border="0" align="absmiddle">
				<span class="biTian">*</span>
			</td>
		  </tr>
		  
		  <tr>
				<td  scope="row" nowrap>每月偿付日</td>
				<td>
					<input name="income_day" style="width:100px;" type="text" value="<%=getDBStr(list.get(19)) %>">
					<span class="biTian">*</span>
				</td>
				
			<td  scope="row" nowrap>租金计算方法</td>
			<td><!-- 等额本金2  暂时隐藏掉 不规则0|手工调整3  2010-08-12  -->
		        <select name="measure_type"   style="width:100px;">
		        <script type="text/javascript">
			        	w(mSetOpt('<%=list.get(22)%>',
			        	"等额租金|等额租金后付(均息法)|不规则",
			        	"1|5|0"));
			       <%--
			       "等额租金|等差租金|等比租金|等额本金|等差本金|等比本金|等额租金后付(均息法)|不等额租金|不等额本金|不规则",
			        	"1|2|3|4|7|6|5|8|9|0"));
			        --%> 	
		        </script>
		        </select>
				<span class="biTian">*</span>
			</td> 
			<%-- 
		  	<td scope="row" nowrap>调息方式</td>
		    <td>
		    	<select name="adjust_style" style="width:100px;">
		        <script type="text/javascript">
			        	w(mSetOpt('<%=list.get(39)%>',"按次日|按次月|按次期|按次年","0|1|2|3"));
		        </script>
		        </select> 
		    	<span class="biTian">*</span>
			</td>
			--%>
			
			<td scope="row" nowrap>是否批量调息</td>
		    <td colspan="">
		    	<select name="into_batch" style="width:100px;">
			        <script type="text/javascript">
				        	w(mSetOpt('<%=list.get(41) %>',"是|否","是|否"));
			        </script>
		        </select>
			</td><td></td><td></td>
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
