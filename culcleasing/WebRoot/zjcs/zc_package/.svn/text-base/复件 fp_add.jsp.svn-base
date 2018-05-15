<%@ page contentType="text/html; charset=gbk" language="java" %>
<%@ page import="dbconn.*" %>  
<%@ page import="java.sql.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ page import="java.util.ArrayList"%> 
<%@ page import="java.util.List"%> 
<%@ include file="../../func/common.jsp"%>
<jsp:useBean id="right" scope="page" class="com.filter.FilterCredit" />
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>发票 - 电信发票新增</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/validator.js"></script>
<SCRIPT  Language="Javascript"  SRC="/tenwa/js/public.js"></SCRIPT>
<SCRIPT  Language="Javascript"  SRC="/tenwa/js/publicEvent.js"></SCRIPT>
<script language="javascript" src="/dict/js/js_dictionary.js"></script>
<script language="javascript" src="/dict/js/ajax_popupDialog.js"></script>
<!-- 日期控件 -->
<script src="../../js/calend.js"></script>
<script type="text/javascript">
	function closeWin(){
		opener.parent.location.reload();
		window.close();
	}
	function form_submit(){
		
		if(change_ci()){
			form1.submit();
		}else{
			window.close();
			opener.location.reload();
		}
	}
	
	//根据发票比例计算发票金额利息本金的值
	function change_ci(){
		//获取已开的发票比例 
		var Fp_rate_t = document.getElementById('Fp_rate_t').value;
		//填写的未开的发票比例
		var Fp_rate = document.getElementById('Fp_rate').value;
		//alert(parseFloat("10.000000").toFixed(2) > parseFloat("1.000000").toFixed(2));
		
		if(chack_rate(Fp_rate)){
			if(Fp_rate != 0 && Fp_rate != '0'){
				var tem =  parseFloat(Fp_rate).toFixed(2);//未开票比例
				//alert("未开:"+tem);
				var bl_t = parseFloat(Fp_rate_t).toFixed(2);//已开票比例
				//alert("已开:"+bl_t);
				var tb =  FloatAdd(tem,bl_t).toFixed(2);
				//alert("未开加已开:"+tb);
				var man = parseFloat("100.00").toFixed(2);
				//三个总的金额，每次乘以比例就是所开发票得到金额数
				var Fp_countMoney = document.getElementById('sum_rent').value;
				var Fp_corpus = document.getElementById('sum_corpus').value;
				var Fp_interest = document.getElementById('sum_interest').value;
				if(parseFloat(tb) > parseFloat(man)){//未开加已开票 大于100
					alert("发票比例加上已开票比例超过100%,无法新增发票!");
					//document.getElementById("Fp_rate").readonly = true; 
					return false;
				}else if(parseFloat(tb) < parseFloat(man)){////未开加已开票 小于100
					//计算总额，本金，利息的值
					var rate = Fp_rate/100;//比例除以100
					//赋值  
					document.getElementById('Fp_countMoney').value = round(rate*Fp_countMoney,2);//Fp_countMoney = 租金总额*金额比例
					document.getElementById('Fp_corpus').value = round(rate*Fp_corpus,2);//Fp_corpus = 本金总额*金额比例
					document.getElementById('Fp_interest').value = round(rate*Fp_interest,2);//Fp_interest = 利息总额*金额比例
					//alert("多次");
					return true;
				}else{//最后一次开票将差额补全 //未开加已开票 == 100
					//alert("最后一次");
					//获取已开的金额
					var yk_Fp_countMoney = document.getElementById('yk_Fp_countMoney').value;
					var yk_Fp_corpus = document.getElementById('yk_Fp_corpus').value;
					var yk_Fp_interest = document.getElementById('yk_Fp_interest').value;
					//赋值  
					document.getElementById('Fp_countMoney').value = round(Fp_countMoney - yk_Fp_countMoney,2);
					document.getElementById('Fp_corpus').value = round(Fp_corpus - yk_Fp_corpus,2);
					document.getElementById('Fp_interest').value = round(Fp_interest - yk_Fp_interest,2);
					return true;
				}
			}else{
				//document.getElementById("Fp_rate").disable = true;
				alert("该资产包的发票比例已有100%,无法新增发票!");
				return false;
			}
		}
	}
	/**保留2位小数 并且四舍五入 
		参数里的： 
		v表示要转换的值 
		e表示要保留的位数 
		函数里的两个for，这个是重点了，
		第一个for针对小数点右边的情况，也就是保留小数点右边多少位；
		第二个for针对小数点左边的情况，也就是保留小数点左边多少位。 
		for的作用，就是计算t的值，也就是v应该放大或者缩小多少倍的倍数（倍数=t）。
		for这里利用到了for里的两个特性，条件判断和计数器累计（循环），
		当e满足条件时for继续，并且e每次累加（e的每次累加，就是给for制造不满足循环的条件）的同时，也计算t的值。 
		最后利用了原生的round方法来计算被放大/缩小后的v的结果，然后把结果放大/缩小到正确的倍数 
	*/
	function round(v,e){ 
		var t=1; 
		for(;e>0;t*=10,e--); 
		for(;e<0;t/=10,e++); 
		//alert(Math.round(v*t)/t);
		return Math.round(v*t)/t; 
	}
	//乱码验证
	function check_lm(text_value){
		 text_value = trim(text_value);//除去空格
		 //非法字符的验证 				
		 var reg_ff = /\/{2}|\/\*|-{2}|[';\"%<>]+/;
          if(text_value.match(reg_ff)){ 
              str = "所填的名称不能包含特殊字符。-- /* ';\"% < > // \"等" ;
               alert(str);
              return false;
           }else{
           	  return true;
           }
	}
	
	function chack_rate(text_value){
		if(check_lm(text_value)){
			//利率格式: /^\d+(\.[0-9]{1,8})?$/,
			var reg_Rate =  /^\d+(\.[0-9]{1,8})?$/;
			//alert("reg_Rate验证->"+list[i].name+"="+text_value+"----"+list[i].dataType+"--结果是："+reg_Rate.test(text_value));
			if(reg_Rate.test(text_value) == false){
				str = "必须为正实数并且小数在八位以内";
				alert(str);
				return false;			
			}else{
				return true;			
			}
		}
	}
	/*
    方法描述： 去除多余空格函数
    	return: s 2边的多余的空格已经去除掉
    	author:  sea
    	date: 2010-04-13
	*/
	function trim(s){  
  		return s.replace(/(^\s*)|(\s*$)/g,"");      
	}
	//浮点数加法运算   
 function FloatAdd(arg1,arg2){   
   var r1,r2,m;   
   try{r1=arg1.toString().split(".")[1].length}catch(e){r1=0}   
   try{r2=arg2.toString().split(".")[1].length}catch(e){r2=0}   
   m=Math.pow(10,Math.max(r1,r2))   
   return (arg1*m+arg2*m)/m   
  } 
 //浮点数减法运算   
 function FloatSub(arg1,arg2){   
	 var r1,r2,m,n;   
	 try{
	 		r1 = arg1.toString().split(".")[1].length
	 	}catch(e){
	 		r1=0
	 	}   
	 try{
	 		r2=arg2.toString().split(".")[1].length
	 	}catch(e){
	 		r2=0
	 	}   
	 m = Math.pow(10,Math.max(r1,r2));   
	 //动态控制精度长度   
	 n = (r1>=r2)?r1:r2;   
	 return ((arg1*m-arg2*m)/m).toFixed(n);   
 }
</script>
</head>
<body onload="change_ci()">
<%
	String model = getStr(request.getParameter("model"));
	
	//权限处理 
	String dqczy = (String) session.getAttribute("czyid");
	//根据登录人编号查询登录部门名称
	String qx_value = "";//变量，控制权限的判断
	String query_department = " select dept_name from base_department where id = ( ";
	query_department = query_department +" select department from base_user where id = '"+dqczy+"')  ";
	ResultSet rs_d = db.executeQuery(query_department);
	String dept_name = "";
	if(rs_d.next()){
		dept_name = getDBStr( rs_d.getString("dept_name") ) ;
	}
	if("".equals(dept_name) || dept_name == null){//未有部门
		qx_value = "0";
	}else if ("资产管理部".equals(dept_name)){
		qx_value = "1";
	}else if ("计划财务部".equals(dept_name)){
		qx_value = "2";
	}
	rs_d.close();
	
//	if ((dqczy == null) || (dqczy.equals("")))
//	{
//	  dqczy = "无认证";
//	  response.sendRedirect("../../noright.jsp");
//	}
//	int canedit = 0;
	//添加
//	if(model == null || model.equals("")){
//		if (right.CheckRight("zjcs-tx-add",dqczy) > 0) canedit=1;
//	}else if(model.equals("mod")){
//		if (right.CheckRight("zjcs-tx-mod",dqczy) > 0) canedit=1;
//	}else{
//		if (right.CheckRight("zjcs-tx-del",dqczy) > 0) canedit=1;
//	}
//	if (canedit == 0) response.sendRedirect("../../noright.jsp"v);
%>

<%
		String readonly = "true";
		String user_id = (String)session.getAttribute("czyid");//取得登录人的ID 用于取得登录人的name
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");//格式化时间
		String nowDateTime = sdf.format(new Date());//当前格式化之后的时间
		String Zc_num = getStr(request.getParameter("Zc_num"));//Zc_num
		String UserName = getStr(request.getParameter("UserName"));//承租人
		String key_id = getStr(request.getParameter("key_id"));//发票表主键
		System.out.println("key_id--->"+key_id);
		ResultSet rs; 
		//根据登录ID查询登录用户名称
		String user_name = "";
		rs = db.executeQuery(" select name from base_user where id = '"+user_id+"' ");//
		if(rs.next()){
			user_name = getDBStr(rs.getString("name"));
		}
		//根据资产包编号查询 已开了多少发票比例 以及多少金额
		String q_s = " select isnull(sum(Fp_rate),'0') as Fp_rate ,ISNULL(SUM(Fp_countMoney),'0') as Fp_countMoney, ";
		q_s = q_s + " ISNULL(SUM(Fp_corpus),'0') as Fp_corpus, ";
		q_s = q_s + " ISNULL(SUM(Fp_interest),'0') as Fp_interest  from  fund_Assets_Invoice "; 
		q_s = q_s + " where id  in ( ";
		q_s = q_s + " 	select Fp_id from fund_Assets_Invoice_Corresponding where Zc_num = '"+Zc_num+"' ";
		q_s = q_s + " ) ";
		System.out.println("已开了多少发票比例 以及多少金额==>"+q_s);
		rs = db.executeQuery(q_s);
		String yk_Fp_rate = "";
		String yk_Fp_countMoney = "";
		String yk_Fp_corpus = "";
		String yk_Fp_interest = "";
		while(rs.next()){
			yk_Fp_rate = getDBStr(rs.getString("Fp_rate"));
			yk_Fp_countMoney = getDBStr(rs.getString("Fp_countMoney"));
			yk_Fp_corpus = getDBStr(rs.getString("Fp_corpus"));
			yk_Fp_interest = getDBStr(rs.getString("Fp_interest"));
		}
		Double bl = Double.valueOf(yk_Fp_rate);
		System.out.println("bl==>"+bl);
		System.out.println("Double.valueOf(100)==>"+Double.valueOf(100));
		System.out.println(bl <= Double.valueOf(100));
		String Fp_rate = "0";//未开比例
		if(bl <= Double.valueOf(100)){//计算还剩下多少比例未开完
			Double bl_temp = 100 - bl;
			Fp_rate = String.valueOf(bl_temp);
		}
		//
		List<String> list = new ArrayList<String>();
		int flag = 0;
		System.out.println("model的值为==>"+model);
		//model不为添加时候所进行的操作
		//总的money数目
		String sum_rent = "";
		String sum_corpus = "";
		String sum_interest = "";
		if(model.equals("add")){
			//System.out.println("JOIN1==>                                              :");
			//第一步：根据资产包编号查询租金偿还计划表所有为该资产包编号的sum（租金）
			String q_sum_rent = " select isnull(SUM(rent),'0') as rent,ISNULL(SUM(corpus),'0') as corpus,ISNULL(SUM(interest),'0') as interest from fund_rent_plan ";
					q_sum_rent = q_sum_rent +" where id  in ( ";
					q_sum_rent = q_sum_rent +" select Chjx_id from fund_Assets_rent_Corresponding where Zc_num = '"+Zc_num+"' ";
					q_sum_rent = q_sum_rent +" ) ";
			System.out.println("总共有多少租金本金利息需要开发票==>"+q_sum_rent);
			rs = db.executeQuery(q_sum_rent);		
			while(rs.next()){
				sum_rent = getDBStr(rs.getString("rent"));
				sum_corpus = getDBStr(rs.getString("corpus"));
				sum_interest = getDBStr(rs.getString("interest"));
			}
		 	rs.close();
		}
		if(model.equals("del")){//发票删除
			String del_sql1 = " delete from fund_Assets_Invoice_Corresponding where fp_id = '"+key_id+"' ";
			String del_sql2 = " delete from fund_Assets_Invoice where id = '"+key_id+"' ";
			System.out.println("发票删除1==>"+del_sql1);
			System.out.println("发票删除2==>"+del_sql2);
			flag = db.executeUpdate(del_sql1);
			flag = db.executeUpdate(del_sql2);
		}
		//根据资产编号统计对应资产编号的偿还计划的租金总和 以及 发票表中已开租金总额 
		//情况1：二者比较：相等，并且资产包表中的状态为：待提交 则显示‘提交审核’按钮，将资产包表中的状态改为‘待审核’
		//情况2：资产编号对应的发票表中的‘发票编号Fp_num’不为空 资产包不允许删除，并且资产包表中的状态为：待审核 则显示‘审核完毕’按钮 点击状态改为‘审核完毕‘
		if("tjshenhe".equals(model)){//提交审核
			String u_s = " update fund_Assets_Package set status = '待审核'  where  Zc_num = '"+Zc_num+"'  ";
			flag = db.executeUpdate(u_s);
		}
		if("shenheOk".equals(model)){//审核完毕
			String u_s = " update fund_Assets_Package set status = '审核完毕'  where  Zc_num = '"+Zc_num+"'  ";
			flag = db.executeUpdate(u_s);
		}
		//if("mod".equals(model)){//修改处理-
		//}
	 	
%>

<form name="form1" action="fp_save.jsp" method="post" target="" onSubmit="return Validator.Validate(this,3);">
<input type="hidden" name="model" id="model" value="<%=model%>">
<input type="hidden" name="Fp_rate_t" id="Fp_rate_t" value="<%=yk_Fp_rate%>">
<input type="hidden" name="yk_Fp_countMoney" id="yk_Fp_countMoney" value="<%=yk_Fp_countMoney%>">
<input type="hidden" name="yk_Fp_corpus" id="yk_Fp_corpus" value="<%=yk_Fp_corpus%>">
<input type="hidden" name="yk_Fp_interest" id="yk_Fp_interest" value="<%=yk_Fp_interest%>">
<input type="hidden" name="sum_rent" id="sum_rent" value="<%=sum_rent%>">
<input type="hidden" name="sum_corpus" id="sum_corpus" value="<%=sum_corpus%>">
<input type="hidden" name="sum_interest" id="sum_interest" value="<%=sum_interest%>">
<input type="hidden" name="Zc_num" id="Zc_num" value="<%=Zc_num%>">
<input type="hidden" name="key_id" id="key_id" value="<%=key_id%>">
  <!--标题开始-->
<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
	<tr valign="top" class="tree_title_txt">
		<td class="tree_title_txt"  height=26 valign="middle">
			发票 &gt; 电信发票新增 
		</td>
	</tr>
	<tr valign="top">
		<td  align=center width=100% height=100%>
			<table align=center width=96%  border="0" cellspacing="0" cellpadding="0" style="margin-top:0px">
				<tr>
					<td>
					  <!--标题结束-->
					  <!--副标题和操作区开始-->
  						<table border="0" width="100%" id="table8" align="center" cellspacing="0" cellpadding="0" style="margin-top:2px;">
   						<!--     -->
    					<tr class="maintab_dh">
      						<td align="left" colspan="2">
      							<table border="0" cellspacing="0" cellpadding="0">    
									<tr class="maintab_dh"><td nowrap >
									<BUTTON class="btn_2" name="btnSave" value="提交"  onclick="form_submit()" >
									<img src="../../images/save.gif" align="absmiddle" border="0">提交</button>
									<BUTTON class="btn_2" name="btnReset" value="取消" onClick="window.close();">
									<img src="../../images/hg.gif" align="absmiddle" border="0">取消</button>
									    </td></tr>
								</table>
        					</td>
   						 </tr>
						<tr><td height="1" bgcolor="#DFDFDF"></td></tr>
						<tr><td height="5"></td></tr>
						<tr><td width="100%">
							 <table border="0" cellspacing="0" cellpadding="0">
							 <tr>
							 <%if(model.equals("add")){%>
							  <td id="Form_tab_0" class="Form_tab" width=70 align=center onClick="chgTabN()"  valign="middle">&nbsp; 新增 &nbsp;</td>
							 <%}else if(model.equals("mod")){%> 
							  <td id="Form_tab_1" class="Form_tab" width=0 align=center onClick="chgTabN()"  valign="middle">&nbsp; 修改 &nbsp;</td>
							  <%}else{ %>
							  <td id="Form_tab_0" class="Form_tab" width=0 align=center onClick="chgTabN()"  valign="middle">&nbsp; 明细 &nbsp;</td>
							  <%} %>
							 </tr>
							 </table></td></tr> 
						<tr><td class="tab_subline" width="100%" height="2"></td></tr>
				</table>
			</td>
		</tr>
	</table>	

<div id="mydiv" class="tabBody" style="background:#ffffff;width:96%;height:500px;overflow:auto;">
<div id="TD_tab_0">
    <table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" cellspacing="1" width="100%" hight="95%" class="tab_table_title" >
<%
	if(model.equals("add")){
%>
	
	  <tr>
	    <th>发票抬头</th>
	    <td colspan="2">
	    	<input type="text" name="Fp_tt" value="<%=UserName%>"  
	    		dataType="Money" size="40" maxlength="10" maxB="10"  Require="true" /> 
			<span class="biTian">*</span>
	    </td>
		
	  </tr>
	  <tr>
	    <th>金额比例</th>
	    <td><!-- onPropertyChange -->
	    	<input type="text" name="Fp_rate" value="<%=Fp_rate%>" onPropertyChange="change_ci()" 
	    		dataType="Rate" size="20" maxlength="10" maxB="10"  Require="true" /> %
			<span class="biTian">*</span>
	    </td>
		<th>发票金额</th>
	    <td>
	    	<input type="text" name="Fp_countMoney" value="<%=sum_rent %>" readonly="readonly"
	    		dataType="Money" size="20" maxlength="10" maxB="10"  Require="true" /> 
			<span class="biTian">*</span>
	    </td>
	  </tr>
	  <tr>
	    <th>本金</th>
	    <td>
	    	<input type="text" name="Fp_corpus" value="<%=sum_corpus%>"  readonly="readonly"
	    		dataType="Rate" size="20" maxlength="10" maxB="10"  Require="true" /> 
			<span class="biTian">*</span>
	    </td>
		<th>利息</th>
	    <td>
	    	<input type="text" name="Fp_interest" value="<%=sum_interest%>"  readonly="readonly"
	    		dataType="Money" size="20" maxlength="10" maxB="10"  Require="true" /> 
			<span class="biTian">*</span>
	    </td>
	  </tr>
	  
      <tr>
	    <th>开票时间</th>
	    <td colspan="">
	    	<input type="text" name="Kp_date" size="20" dataType="Date" Require="true" value="<%=nowDateTime%>" readonly="readonly"/>
	    	<img  onClick="openCalendar(Kp_date);return false" style="cursor:pointer; " 
				 src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
			<span class="biTian">*</span>
	    </td>
	    <th>发票编号</th>
	    <td>
	    <%if("2".equals(qx_value)){%>	
	    	<input type="text" name="Fp_num"  value=""   Require="true"/>
	    <% }else{%>	
	    	 该项为'计划财务部'填写 
	    <% }%>	
	    </td>
	  </tr>
<%
	} else if("tjshenhe".equals(model)){
			if(flag > 0){
			String hrefStr="";
%>
		        <script>
					alert("提交审核成功!");
					opener.parent.location.reload();
					window.close();
				</script>
<%
			}else{
%>
		        <script>
					alert("提交审核失败!");
					opener.location.reload();
					this.close();
				</script>
<%	
			}
	  }else if ("shenheOk".equals(model)){
			if(flag > 0){
			String hrefStr="";
%>
		        <script>
					alert("审核完毕操作成功!");
					opener.parent.location.reload();
					window.close();
				</script>
<%
			}else{
%>
		        <script>
					alert("审核完毕操作失败!");
					opener.location.reload();
					this.close();
				</script>
<%	
			}
		}else{//发票删除
			if(flag > 0){
			String hrefStr="";
%>
		        <script>
					alert("发票删除成功!");
					opener.parent.location.reload();
					window.close();
				</script>
<%
			}else{
%>
		        <script>
					alert("发票删除失败!");
					opener.location.reload();
					this.close();
				</script>
<%	
			}	
		}
		db.close();
%>

    </table>
	    <div>
			<iframe frameborder="0" name="con" width="100%" height="400" 
				src="fp_yDB_List.jsp?Zc_num=<%=Zc_num%>&UserName=<%=UserName%>">
			</iframe>
		</div>
</div>
</div>
</form>
</body>
</html>
