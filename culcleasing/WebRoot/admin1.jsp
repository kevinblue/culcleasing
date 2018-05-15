<%@ page contentType="text/html; charset=gb2312" language="java" import="java.sql.*" errorPage="" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>管理员模式</title>
<link rel="stylesheet" type="text/css" href="css/dtree.css">
<link rel="stylesheet" type="text/css" href="css/mainstyle.css">

<SCRIPT  Language="Javascript"  SRC="func/dtree.js"></SCRIPT>
<script src="js/menu.js"></script>

</head>
<body text="#000000" bgcolor="#FFFFFF" topmargin=0 leftmargin=0 class=menu style='border:1px solid #8DB2E3;margin:0px;'>
<table border="0" width="100%"  cellspacing="0" cellpadding="0" height="25" valign="top">
<tr class="tree_title_txt">
<td width="100%" class="tree_title_txt" valign="middle" id="frmTitle2" >
基础信息维护
</td>
</tr>			
</table>
<table border="0" width="100%" height="100%" cellspacing="0" cellpadding="0">
<tr><td id="frmTitle" valign="top">

    <!--<div id="menutit">&nbsp;<a href="login.jsp" target="_top">Login</a></div> -->
<div id="menu1" expmode=1> 
  <div id="menunode"> 
  	<div style="vertical-align:top;width:100%;overflow:auto;position: relative;padding:6px;" id="mydiv">
   <table border="0"  width="100%" align="center"  cellspacing="0" cellpadding="0">
<tr>
<td id="menuContent">


<script type="text/javascript">

var dd="d";

var d=new dTree(dd);

d.add(0,-1,"<label id='myjob'>基础信息</label>");
d.add(40,0,"基础信息管理");

d.add(41,40,"国家信息","/culcleasing/ywjcxx/gjxx/gjxx_list.jsp","","parent.right.href='ywjcxx/gjxx/gjxx_list.jsp'","","","","国家/地区信息");
d.add(41,40,"地区信息","/culcleasing/ywjcxx/qyxx/qyxx_list.jsp","","parent.right.href='ywjcxx/qyxx/qyxx_list.jsp'","","","","国家/地区信息");
d.add(42,40,"省/直辖市信息","/culcleasing/ywjcxx/sjxx/sjxx_list.jsp","","parent.right.href='ywjcxx/sjxx/sjxx_list.jsp'","","","","省/直辖市信息");
d.add(43,40,"城市信息","/culcleasing/ywjcxx/csxx/csxx_list.jsp","","parent.right.href='ywjcxx/csxx/csxx_list.jsp'","","","","城市信息");
d.add(44,40,"区县信息","/culcleasing/ywjcxx/qxxx/qxxx_list.jsp","","parent.right.href='ywjcxx/qxxx/qxxx_list.jsp'","","","","区县信息");
<%-- 
d.add(50,40,"节假日调整","/culcleasing/ywjcxx/jjr/jjr_list.jsp","","parent.right.href='ywjcxx/jjr/jjr_list.jsp'","","","","节假日调整");
d.add(48,40,"基础资料","/culcleasing/ywjcxx/jczl/jczl_list.jsp","","parent.right.href='ywjcxx/jczl/jczl_list.jsp'","","","","基础资料");
d.add(47,40,"提取比例","/culcleasing/ywjcxx/5jfl/five_list.jsp","","parent.right.href='ywjcxx/5jfl/five_list.jsp'","","","","提取比例");
--%>
d.add(45,40,"公司银行账户","/culcleasing/ywjcxx/gszh/gszh_list.jsp","","parent.right.href='ywjcxx/gszh/gszh_list.jsp'","","","","公司银行账户");
d.add(46,40,"登记注册类型","/culcleasing/ywjcxx/djzc/djzc_list.jsp","","parent.right.href='ywjcxx/djzc/djzc_list.jsp'","","","","登记注册类型");
d.add(49,40,"费用类型","/culcleasing/ywjcxx/fylx/fylx_list.jsp","","parent.right.href='ywjcxx/fylx/fylx_list.jsp'","","","","费用类型");
d.add(51,40,"支付方式","/culcleasing/ywjcxx/paytype/paytype_list.jsp","","parent.right.href='ywjcxx/paytype/paytype_list.jsp'","","","","支付方式");
d.add(52,40,"内部行业","/culcleasing/ywjcxx/basetrade/basetrade_list.jsp","","parent.right.href='ywjcxx/basetrade/basetrade_list.jsp'","","","","内部行业");

d.add(60,0,"客户信息维护");
d.add(61,60,"行业门类","/culcleasing/ywjcxx/khhy/khhyml_list.jsp","","parent.right.href='ywjcxx/khhy/khhyml_list.jsp'","","","","行业门类");
d.add(62,60,"行业大类","/culcleasing/ywjcxx/khhy/khhydl_list.jsp","","parent.right.href='ywjcxx/khhy/khhydl_list.jsp'","","","","行业大类");
d.add(63,60,"行业中类","/culcleasing/ywjcxx/khhy/khhyzl_list.jsp","","parent.right.href='ywjcxx/khhy/khhyzl_list.jsp'","","","","行业中类");
d.add(64,60,"行业小类","/culcleasing/ywjcxx/khhy/khhyxl_list.jsp","","parent.right.href='ywjcxx/khhy/khhyxl_list.jsp'","","","","行业小类");
d.add(65,60,"类别大类","/culcleasing/khxx/khlbdl/khlbdl_list.jsp","","parent.right.href='khxx/khlbdl/khlbdl_list.jsp'","","","","类别大类");
d.add(66,60,"类别小类","/culcleasing/khxx/khlbxl/khlbxl_list.jsp","","parent.right.href='khxx/khlbxl/khlbxl_list.jsp'","","","","类别小类");
d.add(67,60,"用户区域维护","/culcleasing/newcity/xiu/gjxx_list.jsp","","parent.right.href='newcity/xiu/gjxx_list.jsp'","","","","用户区域维护");

d.add(68,60,"用户CRM维护 ","/culcleasing/usersynchronism/synchronism/synchronism_list.jsp","","parent.right.href='usersynchronism/synchronism/synchronism_list.jsp'","","","","用户CRM维护");
d.add(69,60,"保险公司 ","/culcleasing/insurance/info/insurance_company.jsp","","parent.right.href='/culcleasing/insurance/info/insurance_company.jsp'","","","","保险公司");

d.add(70,0,"权限维护");
d.add(71,70,"权限模块","/culcleasing/baseinfo/operate/operate_list.jsp","","parent.right.href='baseinfo/operate/operate_list.jsp'","","","","权限模块");
d.add(72,70,"权限操作","/culcleasing/baseinfo/module/module_list.jsp","","parent.right.href='baseinfo/module/module_list.jsp'","","","","权限操作");
d.add(73,70,"操作权限认证方式","/culcleasing/baseinfo/operatecredit/operatecredit_list.jsp","","parent.right.href='baseinfo/operatecredit/operatecredit_list.jsp'","","","","操作权限认证方式");
d.add(74,70,"权限认证方式","/culcleasing/baseinfo/rightcredit/rightcredit_list.jsp","","parent.right.href='baseinfo/rightcredit/rightcredit_list.jsp'","","","","权限认证方式");


d.add(80,0,"其他基础信息");
d.add(81,80,"授信额度","/culcleasing/otherinfo/credit/credit_list.jsp","","parent.right.href='otherinfo/credit/credit_list.jsp'","","","","其他基础信息");
d.add(82,80,"罚息额度","/culcleasing/otherinfo/penaltyLimit/penalty_limit_list.jsp","","parent.right.href='otherinfo/penaltyLimit/penalty_limit_list.jsp'","","","","其他基础信息");

document.write(d);
//alert(d);

 //设置菜单名称数组
 var cateInfo=[];	

 function setCateInfo(){
   var tree=d.aNodes;//当前xml目录路径
   for(var i=0;i<tree.length;i++){
     if(tree[i].url && tree[i].url.toLowerCase().indexOf("xmlview")!=-1){
	 var key=tree[i].url.strright("&view=");
	 key=key.indexOf("&")!=-1?key.strleft("&"):key;
        var label=tree[i].name;
	 if(label.indexOf("<label")!=-1){
          var id=label.strright("id='").strleft("'");
          label=lan.$(id,label);
        }
	 cateInfo[key]=label;
     }   	
   }
 }
/**/
</script>
</td></tr>

</table>
</div></div></div>
  </tr>
</table>

<script>
//initMenu(menu1,0);

</script>
</body>
</html>
