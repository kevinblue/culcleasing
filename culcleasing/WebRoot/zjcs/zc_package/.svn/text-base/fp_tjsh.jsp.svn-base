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
<title>发票 - 提交审核</title>
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
<body onload="">
<%
	String model = getStr(request.getParameter("model"));
	
	//权限处理 
	String dqczy = (String) session.getAttribute("czyid");
	//根据登录人编号查询登录部门名称
	//String qx_value = "";//变量，控制权限的判断
	//String query_department = " select dept_name from base_department where id = ( ";
	//query_department = query_department +" select department from base_user where id = '"+dqczy+"')  ";
	//ResultSet rs_d = db.executeQuery(query_department);
	//String dept_name = "";
	//if(rs_d.next()){
	//	dept_name = getDBStr( rs_d.getString("dept_name") ) ;
	//}
	//if("".equals(dept_name) || dept_name == null){//未有部门
	//	qx_value = "0";
	//}else if ("资产管理部".equals(dept_name)){
	//	qx_value = "1";
	//}else if ("计划财务部".equals(dept_name)){
	//	qx_value = "2";
	//}
	//rs_d.close();
	
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

		//
		List<String> list = new ArrayList<String>();
		int flag = 0;
		System.out.println("model的值为==>"+model);

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
<input type="hidden" name="Zc_num" id="Zc_num" value="<%=Zc_num%>">
<input type="hidden" name="key_id" id="key_id" value="<%=key_id%>">
  <!--标题开始-->
<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
	<tr valign="top" class="tree_title_txt">
		<td class="tree_title_txt"  height=26 valign="middle">
			发票 &gt; 提交审核
		</td>
	</tr>
	<tr valign="top">
		<td  align=center width=100% height=100%>
<div id="mydiv" class="tabBody" style="background:#ffffff;width:96%;height:500px;overflow:auto;">
<div id="TD_tab_0">
<%
	 if("tjshenhe".equals(model)){
			if(flag > 0){
			String hrefStr="";
%>
		        <script>
					alert("提交审核成功!");
					opener.location.reload();
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
	  }
	   if ("shenheOk".equals(model)){
			if(flag > 0){
			String hrefStr="";
%>
		        <script>
					alert("审核完毕操作成功!");
					opener.location.reload();
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
		} 
		db.close();
%>
</div>
</div>
</form>
</body>
</html>
