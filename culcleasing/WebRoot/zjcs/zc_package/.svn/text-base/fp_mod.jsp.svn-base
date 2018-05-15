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
		var Fp_num = document.getElementById('Fp_num').value;
		if(check_lm(Fp_num)){
			if(Fp_num == null || Fp_num == ""){
				alert("发票编号不能为空!");
				return false;
			}else{
				form1.submit();
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
              str = "所填的发票编号不能包含特殊字符。-- /* ';\"% < > // \"等" ;
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
<body onload="">
<%
	String model = getStr(request.getParameter("model"));
	
	//权限处理 
//	String dqczy = (String) session.getAttribute("czyid");
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
		
		//if("mod".equals(model)){//修改处理-
		//}
	 	
%>

<form name="form1" action="fp_save.jsp" method="post" target="" onSubmit="return Validator.Validate(this,3);">
<input type="hidden" name="model" id="model" value="<%=model%>">
<input type="hidden" name="Zc_num" id="Zc_num" value="<%=Zc_num%>">
<input type="hidden" name="key_id" id="key_id" value="<%=key_id%>">
  <!--标题开始-->
<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
	<tr valign="top" class="tree_title_txt">
		<td class="tree_title_txt"  height=26 valign="middle">
			发票 &gt; 电信发票修改 
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
	 if("mod".equals(model)){
			String mod_s = " select * from  fund_Assets_Invoice where id = '"+key_id+"'";
			ResultSet rs_m = db.executeQuery(mod_s);
			while(rs_m.next()){
%>
	
	  <tr>
	    <th>ID</th>
	    <td colspan=""> <%=getDBStr(rs_m.getString("id"))%>  </td>
	    <th>发票抬头</th>
	    <td colspan=""> <%=getDBStr(rs_m.getString("Fp_tt"))%> </td>
	  </tr>
	  <tr>
	    <th>金额比例</th>
	    <td> <%=getDBStr(rs_m.getString("Fp_rate"))%> </td>
		<th>发票金额</th>
	    <td> <%=getDBStr(rs_m.getString("Fp_countMoney")) %> </td>
	  </tr>
	  <tr>
	    <th>本金</th>
	    <td> <%=getDBStr(rs_m.getString("Fp_corpus"))%> </td>
		<th>利息</th>
	    <td> <%=getDBStr(rs_m.getString("Fp_interest"))%> </td>
	  </tr>
      <tr>
	    <th>开票时间</th>
	    <td colspan="">
	    	<input type="text" name="Kp_date" size="20" dataType="Date" Require="true" value="<%=getDBDateStr(rs_m.getString("Kp_date"))%>" readonly="readonly"/>
	    	<img  onClick="openCalendar(Kp_date);return false" style="cursor:pointer; " 
				 src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
			<span class="biTian">*</span>
	    </td>
	    <th>发票编号</th>
	    <td>
	    	<input type="text" name="Fp_num"  value="<%=getDBStr(rs_m.getString("Fp_num"))%>"   Require="true"/>
	    	<span class="biTian">*</span>
	    </td>
	  </tr>
<%
			}
			rs_m.close();
		} 		       
		db.close();
%>
    </table>
</div>
</div>
</div>
</form>
</body>
</html>
