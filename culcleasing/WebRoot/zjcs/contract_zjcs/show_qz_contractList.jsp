<%@ page contentType="text/html; charset=gbk" language="java" %>
<%@ page import="dbconn.*" %>  
<%@ page import="java.sql.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ page import="java.util.ArrayList"%> 
<%@ page import="java.util.List"%> 
<%@ include file="../../func/common.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<!-- contract_condition_temp  项目交易结构-->
<title> 租金测算 - 起租合同交易结构展示页</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/validator.js"></script>
<SCRIPT  Language="Javascript"  SRC="/tenwa/js/public.js"></SCRIPT>
<SCRIPT  Language="Javascript"  SRC="/tenwa/js/publicEvent.js"></SCRIPT>
<script language="javascript" src="/dict/js/js_dictionary.js"></script>
<script language="javascript" src="/dict/js/ajax_popupDialog.js"></script>
<!-- 日期控件 -->
<script src="../../js/calend.js"></script>
<script language="javascript"> 

</script>

</head>
<body>
<%
 	ResultSet rs;
	//SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");//格式化时间
	//String nowDateTime = sdf.format(new Date());//当前格式化之后的时间
	String proj_id = getStr(request.getParameter("proj_id"));//接取主键‘合同编号’ 
	if(proj_id.equals("") || proj_id == null){
		proj_id = "项目编号为空";
	}
	String doc_id = getStr(request.getParameter("doc_id"));//文档编号 measure_id
	String contract_id = getStr(request.getParameter("contract_id"));//合同编号
	String model = getStr(request.getParameter("model"));//model
	List<String> list = new ArrayList<String>();
	//项目编号不为空
	StringBuffer querySql = new StringBuffer();
	//判断主键是否为空
	querySql.append("select contract_id,currency,equip_amt,first_payment,")//0-3
 		.append("lease_money,caution_money,net_lease_money,")//4-6
 		.append("handling_charge,income_number_year,lease_term,")//7-9
 		.append("income_number,nominalprice,period_type,return_amt,")//10-13
 		.append("year_rate,rate_float_type,before_interest,")//14-16
 		.append("rate_adjustment_modulus,pena_rate,income_day,start_date,")//17-20
 		.append("plan_irr,measure_type,other_income,other_expenditure,creator,")//21-25
 		.append("create_date,modify_date,modificator,rate_float_amt,consulting_fee, ")//26-30
 		.append(" market_irr,  ")//新增字段 市场irr 31
 		.append(" lease_money_proportion,  ")//【新增字段 2010-07-27】32 净融资额比例
 		.append(" accountPrincipal  ")//【新增字段 2010-08-06】33 会计核算本金
 		.append(",rentScale  ")//【新增字段 2010-08-20】34 圆整到
 		.append(",liugprice  ")//【新增字段 2010-09-21】35 留购价（原本的留购价改成残值
 		 .append(",delay")//【新增字段 2010-10-20】36 延迟期数
		.append(",grace")//【新增字段 2010-10-20】37 宽限期数
		.append(",management_fee  ")//【新增字段 2010-11-11】38 管理费 
		.append(",ajdustStyle  ")//【新增字段 2010-11-23】39 调息方式  
 		.append(" from contract_condition_temp ")
 		.append(" where contract_id = '"+contract_id+"' ")
 		.append(" and measure_id = '"+doc_id+"' ");
 		//.append(" and lease_money_proportion = ((net_lease_money/equip_amt)*100)"); 
	System.out.println("项目交易结构只读页查询SQL-->   "+querySql.toString());
 	rs = db.executeQuery(querySql.toString());//执行查询
 	//rs.last(); //移到最后一行
	//int rowCount = rs.getRow(); //得到当前行号，也就是记录数
	//rs.beforeFirst(); //还要用到记录集，就把指针再移到初始化的位置
 	int i = 1;
 	while(rs.next()){
 		//循环取值 取该表的前31列，下标从1开始取
 		for(;i <= 40;i++){
	 		list.add(getDBStr(rs.getString(i)));
 		}
 	}
 	rs.close();
%> 
<form name="form1" method="post" target="_blank" action="zjcs_qz_contractSave.jsp" onSubmit="return Validator.Validate(this,3);">
<table  class="title_top" width=100% hight="80%" align=center cellspacing=0 border="0" cellpadding="0">
<!-- 隐藏域传值  -->
<input type="hidden" name="doc_id" id="doc_id" value="<%=doc_id%>"/>
<input type="hidden" name="proj_id" id="proj_id" value="<%=proj_id%>"/>
<input type="hidden" name="contract_id" id="contract_id" value="<%=contract_id%>"/>
<input type="hidden" name="savaType" id="savaType" value="<%=model%>"/>
<tr valign="top">
	<td  align=center width=100% height=100%>
	<table align=center width=100%  border="0" cellspacing="0" cellpadding="0" style="margin-top:0px">
		<tr>
			<td height="5">
				<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
				    <tr class="tree_title_txt">
				      <td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
				      	租金测算 &gt;合同交易明细查看
				      </td>
				    </tr>
				 </table>
			</td>
		</tr>
	</table>

	<div id="divH" class="tabBody" style="background:#ffffff;width:100%;height:380px;overflow:auto;">
	<div id="TD_tab_0">
		<table  border="0" cellspacing="0" cellpadding="0" width="100%" hight=100%" align="center" class="tab_table_title">
		<%
			if(list.size() > 0){
		%>
 			 <tr>
  				<td scope="row" nowrap >项目编号</td>
    			<td> <%=proj_id%> </td>
  				<td scope="row" nowrap >合同编号</td>
    			<td> <%=list.get(0)%> </td>
	 			<td scope="row" nowrap >货币类型</td>
    		    <td> 
					<select name="currency" id="currency" disabled="disabled">
					<script>
						var currencyValue = <%=list.get(1)%>;
						if(currencyValue != null && currencyValue != '' && currencyValue != 'undefined'){
							w(mSetOpt("<%=list.get(1)%>","人民币|美元|日元|法国法郎|德国马克|港币|加拿大元|荷兰盾|瑞士法郎|比利时法郎|欧元","0|1|2|3|4|5|6|7|8|9|10")); 
						}else{
							w(mSetOpt("0","人民币|美元|日元|法国法郎|德国马克|港币|加拿大元|荷兰盾|瑞士法郎|比利时法郎|欧元","0|1|2|3|4|5|6|7|8|9|10")); 
						}
					</script>
					</select>
				</td>
    			<td scope="row" nowrap >设备金额</td>
    			<td> <%=formatNumberStr(getDBStr(list.get(2)),"#,##0.00")%> </td>
  			</tr> 	
  			<tr> 
      			<td scope="row" nowrap >首付款</td>
      			<td> <%=formatNumberStr(getDBStr(list.get(3)),"#,##0.00")%> </td> 
 				<!--  租赁本金 = 设备金额 - 首付款   -->
   				<td scope="row" nowrap >租赁本金</td>
    			 <td> <%=formatNumberStr(getDBStr(list.get(4)),"#,##0.00")%> </td>
				<td  scope="row" nowrap >租赁保证金</td>
				<td> <%=formatNumberStr(getDBStr(list.get(5)),"#,##0.00")%> </td>
				<td scope="row" nowrap >租赁手续费</td>
				<td> <%=formatNumberStr(getDBStr(list.get(7)),"#,##0.00")%> </td>
  			</tr>

   			<tr>
   				<td scope="row" nowrap>管理费</td>
			    <td colspan=""> <%=getDBStr(list.get(38))%> </td>
  				<td scope="row" nowrap >净融资额</td>
   	 			<td> 
   	 				<%=formatNumberStr(getDBStr(list.get(6)),"#,##0.00")%> 
   	 				&nbsp;&nbsp;&nbsp;净融资额比例 <%=formatNumberStr(getDBStr(list.get(32)),"#,##0.00")%>&nbsp;% </td>
   	 			</td>
   	 			<td scope="row" nowrap >付租方式</td>
	   			<td>
	   	 			<select name="income_number_year" id="income_number_year" disabled>
					<script>
						var inyValue = "<%=list.get(8)%>";
						if(inyValue != null && inyValue != ''){
							w(mSetOpt("<%=list.get(8)%>","-请选择-|月付|双月付|季付|半年付|年付","|1|2|3|6|12")); 
						}else{
							w(mSetOpt("","-请选择-|月付|双月付|季付|半年付|年付","|1|2|3|6|12")); 
						} 
					</script>
					</select>
				</td>
				<td scope="row" nowrap >付租类型</td>
			    <td>
			    <select name="period_type" disabled>
			        <script>
			        	var perTypeValue = <%=list.get(12)%>;
			        	if(perTypeValue != null && perTypeValue != ''){
				        	w(mSetOpt('<%=list.get(12)%>;',"期初|期末","1|0"));
			        	}else{
				        	w(mSetOpt('0',"期初|期末","1|0"));
			        	}
			        </script>
			     </select>
				</td> 
  			</tr>	

		  <tr> 
 			
		    <!-- 还租次数=租赁期限/年还租次数 -->
		  	<td scope="row" nowrap >还租次数</td>
		    <td> <%=list.get(10)%> </td>
			<!-- 根据付租方式判断 -->
			<td scope="row" nowrap >租赁期限(月)</td>
		    <td> <%=list.get(9)%> </td>
			<td  scope="row" nowrap >资产余值</td>
			<td> <%=formatNumberStr(getDBStr(list.get(11)),"#,##0.00")%> </td>
		    <td  scope="row" nowrap >厂商返利</td>
			<td> <%=formatNumberStr(getDBStr(list.get(13)),"#,##0.00")%> </td>
		  </tr>	
		  
		  <tr>
		  	<td scope="row" nowrap >利率浮动类型</td>
		    <td>
		        <select name="rate_float_type" disabled>
		        <script>
		        	var rateTypeValue = <%=list.get(15)%>;
		        	if(rateTypeValue != null && rateTypeValue != ''){
			        	w(mSetOpt('<%=list.get(15)%>',"按央行利率浮动比率|按央行利率加点|固定调整租金金额|保持不变","0|1|2|3"));
		        	}else{
			        	w(mSetOpt('0',"按央行利率浮动比率|按央行利率加点|固定调整租金金额|保持不变","0|1|2|3"));
		        	}
		        </script>
		        </select> 
			</td>
			<td scope="row" nowrap >利率调整值</td>
		    <td> <%=getDBStr(list.get(29))%> </td>
			<td scope="row" nowrap >租前息</td>
		    <td> <%=formatNumberStr(getDBStr(list.get(16)),"#,##0.00")%> </td>
		  	<td  scope="row" nowrap >租赁年利率</td>
			<td>
				<%
					//2011-05-06  规则的时候 开放年利率的修改 不规则的时候不允许
					String measure_type =  list.get(22);//等额租金|等额本金|不规则","1|2|0"
					if(!"0".equals(measure_type)){
				%>
				<input name="year_rate" id="year_rate" type="text" value="<%=formatNumberStr(getDBStr(list.get(14)),"#,##0.000000")%>"  
					dataType="Rate" size="10" maxlength="10" maxB="10"  Require="true"/>%
				<span class="biTian">*</span> 
				<% }else{%>
				<input name="year_rate" id="year_rate" type="text" value="<%=formatNumberStr(getDBStr(list.get(14)),"#,##0.000000")%>"  
					readonly="readonly"/>%
				<% }%>
			</td>  
		 </tr>
		 
		 <tr>
		  	<td scope="row" nowrap >利率调整系数</td>
		    <td> 
		    	<%
		    		String ramValue = list.get(17);
		    		if(ramValue.equals("365/360")){
		    	%>	
					<input type="radio" name="rate_adjustment_modulus" value="365/360" checked style="border:none;">365/360
		    	<%	
		    		}else{ 
		    	%>
		    		<input type="radio" name="rate_adjustment_modulus" value="360/360" checked style="border:none;">360/360
		    	<%
		    		}
		    	%>	
			</td>
			<td scope="row" nowrap >罚息日利率</td>
			<td colspan=""> <%=formatNumberStr(getDBStr(list.get(18)),"#,##0.00")%>&nbsp;%%</td>  
			<td  scope="row" nowrap >每月偿付日</td>
			<td>
				<select name="income_day">
					<% 
						for(int j = 1;j <= 31;j++){
							int num_temp = Integer.parseInt(getDBStr(list.get(19)));
							if(num_temp == j){
					%>
						<option value="<%=getDBStr(list.get(19))%>" selected><%=getDBStr(list.get(19))%></option>
					<% 
							}else{
					%>
						<option value="<%=j%>"><%=j%></option>	
					<% 
							}
						}
					%>
				</select>	
				<span class="biTian">*</span>
			</td>
			<td  scope="row" nowrap >起租日</td>
			<td>
				<input name="start_date" type="text" value="<%=getDBDateStr(list.get(20))%>"  
						 size="13" maxlength="20"  Require="true" readonly="readonly"/>
				<img  onClick="openCalendar(start_date);return false" style="cursor:pointer; " 
					 src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
				<span class="biTian">*</span>
			</td>
		  </tr>
		  
		  <tr>
			<td  scope="row" nowrap >租金计算方法</td>
			<td>
				<select name="measure_type" disabled>
		        <script>
		        	var measureValue = <%=list.get(22)%>;
		        	if(measureValue != null){
			        	w(mSetOpt('<%=list.get(22)%>',"等额租金|等额本金|不规则","1|2|0"));
		        	}else{
			        	w(mSetOpt('2',"等额租金|等额本金|不规则","1|2|0"));
		        	}
		        </script>
		        </select>
			</td> 
			<td  scope="row" nowrap >财务IRR</td>
			<td> <%=formatNumberStr(getDBStr(list.get(21)),"#,##0.000000")%>&nbsp;%</td> 
		    <td scope="row" nowrap>市场IRR</td>
			<td><%=formatNumberStr(getDBStr(list.get(31)),"#,##0.000000")%>&nbsp;%</td>
			<td  scope="row" nowrap >其他收入</td>
			<td> <%=formatNumberStr(getDBStr(list.get(23)),"#,##0.00")%> </td>
		</tr>
		<tr>
			<td scope="row" nowrap >其他支出</td>
		    <td> <%=formatNumberStr(getDBStr(list.get(24)),"#,##0.00")%> </td>
		  	<td scope="row" nowrap >咨询费</td>
		  	<td > <%=formatNumberStr(getDBStr(list.get(30)),"#,##0.00")%> </td>
		  	<!-- 新添加的会计核算本金 = 净融资额+保证金  2010-08-06 -->
		  	<td scope="row" nowrap>会计核算本金</td>
		  	<td> <%=formatNumberStr(getDBStr(list.get(33)),"#,##0.00")%> 
			</td>
		  	<!-- 
		  	<td scope="row" nowrap >登记人</td>
			<td><%=getDBStr(list.get(25))%></td>
		  	<td scope="row" nowrap >登记时间</td>
			<td><%=getDBDateStr(list.get(26))%></td>
			 -->
			<!-- 新增字段 2010-09-21 原本的留购价改成残值--->
			<td scope="row" nowrap>留购价款</td>
		  	<td> <%=formatNumberStr(getDBStr(list.get(35)),"#,##0.00")%> </td>
		</tr>
		<!-- 
		<tr>
		  	<td scope="row" nowrap >更新人</td>
			<td><%=getDBStr(list.get(28))%></td>
		  	<td scope="row" nowrap >更新日期</td>
			<td colspan=""><%=getDBDateStr(list.get(27))%></td>
			 
		</tr>
		 -->
		<tr>
			<!-- 新增字段  2010-08-20 -->
		  	<td scope="row" nowrap>圆整到</td>
		  	<td colspan="">
		  		<select name="rentScale" disabled="disabled">
			        <script>
			        	var rentScaleValue = '<%=list.get(34)%>';
			        	//alert(rentScaleValue);
			        	if(rentScaleValue != null && rentScaleValue != ''){
				        	w(mSetOpt('<%=list.get(34)%>',"元|角|分","0|1|2"));
			        	}else{
				        	w(mSetOpt('0',"元|角|分","0|1|2"));
			        	}
			        </script>
		        </select> 
			</td>
			<td  scope="row" nowrap>延迟期数</td>
			<td> <%=getDBStr(list.get(36))%>  </td>
		 	<td scope="row" nowrap>宽限期数</td>
		    <td colspan=""> <%=getDBStr(list.get(37))%> </td>
		    <td scope="row" nowrap>调息方式</td>
		    <td colspan="">
		    	<select name="ajdustStyle" disabled="disabled">
		        <script>
		        	var ajdustStyle = <%=list.get(39)%>;//按次日,按次月,按次期,按次年,平息法
		        	if(ajdustStyle != null && ajdustStyle != ''){
			        	w(mSetOpt('<%=list.get(39)%>',"按次日|按次月|按次期|按次年|平息法","0|1|2|3|4"));
		        	}else{
			        	w(mSetOpt('0',"按次日|按次月|按次期|按次年|平息法","0|1|2|3|4"));
		        	}
		        </script>
		        </select> 
			</td>
		</tr>
		<% 
			//【2011-04-13需求变更：不规则时候可以修改偿还日期】
			//不规则起租的时候不做租金测算 2011-03-02
			//String measure_type = list.get(22);
			//if(!"0".equals(measure_type)){
		%>		
		<tr>
			<td colspan="8" align="right" nowrap>
				<BUTTON class="btn_2" name="btnSave" value="租金测算" type="submit">
				<img src="../../images/save.gif" align="absmiddle" border="0">租金测算</button>
			 </td>
			 
		  </tr>
		<% 
			//}
		%>		
		<% 		
		}else{
		%>
		  <tr>
			<td scope="row" nowrap >没有该合同交易结构的详细数据!</td>
		  </tr>
			
		<% 		
		}
		db.close();
		%>
		</table>
		</div>
		</div>
	</td>
	</tr>
</table>
</form>
</body>
</html>
