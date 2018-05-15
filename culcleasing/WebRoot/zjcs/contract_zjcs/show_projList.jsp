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
<title> 租金测算 - 项目交易结构展示页</title>
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
	String doc_id = getStr(request.getParameter("doc_id"));//文档编号 measure_id
	List<String> list = new ArrayList<String>();
	//项目编号不为空
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
	 		.append(" market_irr  ")//新增字段 市场irr 31
	 		.append(" from proj_condition_temp ")
	 	    .append(" where proj_id = '"+proj_id+"'")//合同编号
	 	    .append(" and measure_id = '"+doc_id+"' ");//文档编号
	System.out.println("项目交易结构只读页查询SQL-->   "+querySql.toString());
 	rs = db.executeQuery(querySql.toString());//执行查询
 	//rs.last(); //移到最后一行
	//int rowCount = rs.getRow(); //得到当前行号，也就是记录数
	//rs.beforeFirst(); //还要用到记录集，就把指针再移到初始化的位置
 	int i = 1;
 	while(rs.next()){
 		//循环取值 取该表的前31列，下标从1开始取
 		for(;i <= 32;i++){
	 		list.add(getDBStr(rs.getString(i)));
 		}
 	}
	rs.close();
	db.close();
%> 
<form name="form1" method="post" target="_black" action="show_projList.jsp" onSubmit="return Validator.Validate(this,3);">
<table  class="title_top" width=100% hight="80%" align=center cellspacing=0 border="0" cellpadding="0">
<!-- 隐藏域传值  -->
<input type="hidden" name="doc_id" id="doc_id" value="<%=doc_id%>"/>
<tr valign="top">
	<td  align=center width=100% height=100%>
	<table align=center width=100%  border="0" cellspacing="0" cellpadding="0" style="margin-top:0px">
		<tr>
			<td height="5">
				<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
				    <tr class="tree_title_txt">
				      <td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
				      	租金测算 &gt;项目交易明细查看
				      </td>
				    </tr>
				 </table>
			</td>
		</tr>
		<tr>
			<td width="100%">
 			<table border="0" cellspacing="0" cellpadding="0">
			 	<tr>
  					<td id="Form_tab_0" class="Form_tab" width=88 
  						align=center onClick="chgTabN()"  valign="middle">&nbsp;详细信息&nbsp;
				</tr>
 			</table>
			</td>
		</tr> 
		<tr>
			<td class="tab_subline" width="100%" height="2">&nbsp;</td>
		</tr>
	</table>

	<div id="divH" class="tabBody" style="background:#ffffff;width:100%;height:350px;overflow:auto;">
	<div id="TD_tab_0">
		<table  border="0" cellspacing="0" cellpadding="0" width="100%" hight=100%" align="center" class="tab_table_title">
		<%
			if(list.size() > 0){
		%>
 			 <tr>
  				<td scope="row" nowrap>项目编号</td>
    			<td> <%=list.get(0)%> </td>
	 			<td scope="row" nowrap>货币类型</td>
    		    <td>
					<select name="currency" id="currency" disabled="disabled">
					<script>
						var currencyValue = <%=list.get(1)%>;
						if(currencyValue != null && currencyValue != ''){
							w(mSetOpt("<%=list.get(1)%>","人民币|美元|日元|法国法郎|德国马克|港币|加拿大元|荷兰盾|瑞士法郎|比利时法郎|欧元","0|1|2|3|4|5|6|7|8|9|10")); 
						}else{
							w(mSetOpt("0","人民币|美元|日元|法国法郎|德国马克|港币|加拿大元|荷兰盾|瑞士法郎|比利时法郎|欧元","0|1|2|3|4|5|6|7|8|9|10")); 
						}
					</script>
					</select>
				</td>
    			<td scope="row" nowrap>设备金额</td>
    				<td> <%=formatNumberStr(list.get(2),"#,##0.00")%> </td>
  			</tr> 	
  			<tr>
      			<td scope="row" nowrap>首付款</td>
      			<td> <%=formatNumberStr(getDBStr(list.get(3)),"#,##0.00")%> </td> 
 				<!--  租赁本金 = 设备金额 - 首付款   -->
   				<td scope="row" nowrap>租赁本金</td>
    			 <td> <%=formatNumberStr(getDBStr(list.get(4)),"#,##0.00")%> </td>
				<td  scope="row" nowrap>租赁保证金</td>
				<td> <%=formatNumberStr(getDBStr(list.get(5)),"#,##0.00")%> </td>
  			</tr>
   			<tr>
  				<td scope="row" nowrap>净融资额</td>
   	 			<td> <%=formatNumberStr(getDBStr(list.get(6)),"#,##0.00")%> </td>
				<td  scope="row" nowrap>手续费</td>
				<td> <%=formatNumberStr(getDBStr(list.get(7)),"#,##0.00")%> </td>
  				<td scope="row" nowrap>付租方式</td>
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
  			</tr>	

		  <tr> 
			<td scope="row" nowrap>付租类型</td>
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
		    <!-- 还租次数=租赁期限/年还租次数 -->
		  	<td scope="row" nowrap>还租次数</td>
		    <td> <%=list.get(10)%></td>
			<!-- 根据付租方式判断 -->
			<td scope="row" nowrap>租赁期限(月)</td>
		    <td> <%=list.get(9)%></td>
		  </tr>
		  <tr>
			<td  scope="row" nowrap>名义留购价</td>
			<td> <%=formatNumberStr(getDBStr(list.get(11)),"#,##0.00")%> </td>
		    <td  scope="row" nowrap>厂商返利</td>
			<td> <%=formatNumberStr(getDBStr(list.get(13)),"#,##0.00")%> </td>
			<td  scope="row" nowrap>租赁年利率</td>
			<td> <%=formatNumberDoubleTwo(getDBStr(list.get(14)))%> </td>  
		  </tr>	
		  <tr>
		  	<td scope="row" nowrap>利率浮动类型</td>
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
			<td scope="row" nowrap>利率调整值</td>
		    <td> <%=getDBStr(list.get(29))%> </td>
			<td scope="row" nowrap>租前息</td>
		    <td> <%=formatNumberDoubleTwo(getDBStr(list.get(16)))%> </td>
		  </tr>
		  <tr>
		  	<td scope="row" nowrap>利率调整系数</td>
		    <td> 
		    	<!-- 关于利率调整系数radio的默认初始化 -->
		    	<%
		    		String ramValue = getDBStr(list.get(17));
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
		  	<td scope="row" nowrap>罚息利率</td>
		    <td colspan=""> <%=formatNumberDoubleTwo(getDBStr(list.get(18)))%> </td>  
			<td  scope="row" nowrap>每月偿付日</td>
			<td> <%=getDBStr(list.get(19))%> </td>
		  </tr>
		  <tr>
			<td  scope="row" nowrap>起租日</td>
			<td> <%=getDBDateStr(list.get(20))%> </td>
			<!-- 更改名称为财务IRR 原名称为内部收益率(IRR) -->
			<td  scope="row" nowrap>财务IRR</td>
			<td> <%=formatNumberDoubleTwo(getDBStr(list.get(21)))%>% </td> 
			<td  scope="row" nowrap>租金计算方法</td>
			<td>
				<select name="measure_type" disabled="disabled">
		        <script>
		        	var measureValue = <%=list.get(22)%>;
		        	if(measureValue != null){
			        	w(mSetOpt('<%=list.get(22)%>',"等额租金|等额本金|不规则","1|2|0"));
		        	}else{
		        		//alert('join');
			        	w(mSetOpt('1',"等额租金|等额本金|不规则","1|2|0"));
		        	}
		        </script>
		        </select>
			</td> 
		  </tr>
		  <tr>  
			<td  scope="row" nowrap>其他收入</td>
			<td> <%=formatNumberStr(getDBStr(list.get(23)),"#,##0.00")%> </td>
			<td scope="row" nowrap>其他支出</td>
		    <td colspan=""> <%=formatNumberStr(getDBStr(list.get(24)),"#,##0.00")%> </td>
		  	<td scope="row" nowrap>咨询费</td>
		  	<td colspan=""> <%=formatNumberDoubleTwo(getDBStr(list.get(30)))%> </td>
		  </tr>
		  <tr>
			<td scope="row" nowrap>登记人</td>
			<td><%=getDBStr(list.get(25))%></td>
			<td scope="row" nowrap>登记时间</td>
			<td><%=getDBDateStr(list.get(26))%></td>
			<td scope="row" nowrap>更新人</td>
			<td><%=getDBStr(list.get(28))%></td>
		  </tr>
		  <tr>
			<td scope="row" nowrap>更新日期</td>
			<td ><%=getDBDateStr(list.get(27))%></td>
			<td scope="row" nowrap>市场IRR</td>
			<td colspan="3"><%=formatNumberDoubleTwo(getDBStr(list.get(31)))%></td>
		  </tr>
		<% 		
		}else{
		%>
		  <tr>
			<td scope="row" nowrap>没有该项目交易结构的详细数据!</td>
		  </tr>
			
		<% 		
		}
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
