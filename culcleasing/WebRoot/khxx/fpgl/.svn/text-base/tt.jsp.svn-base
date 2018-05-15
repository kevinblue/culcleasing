<%@ page contentType="text/html; charset=gbk" language="java" %>
<%@ page import="dbconn.*" %> 
<jsp:useBean id="right" scope="page" class="com.filter.FilterCredit" /> 
<%@ page import="java.sql.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<jsp:useBean id="db1" scope="page" class="dbconn.Conn" />

<%@ include file="../../func/common.jsp"%>
<html> 
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>新增 - 放款</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">

<script language="javascript" src="/dict/js/js_dictionary.js"></script>
<SCRIPT  Language="Javascript"  SRC="/tenwa/js/publicEvent.js"></SCRIPT>

<script src="../../js/comm.js"></script>
<script src="../../js/validator.js"></script>
<script src="../../js/calend.js"></script>

<script Language="Javascript" src="../../js/jquery.js"></script>
<script type="text/javascript" src="../../js/stleasing_tabledata.js"></script>
<link href="../../css/stleasing_tabledata.css" rel="stylesheet" type="text/css">

<style>
select{
width:150px;
}
</style>

<script type="text/javascript">
// 是否可以提交付款申请
function isSub(obj) {
	//if (document.getElementById("proj_number").value=='')
//	{
		//alert("没有可以申请的数据!");
		//	return false;
	//}
		//return true;

		//得到复选框的集合
 	var names=document.getElementsByName("list");
 	var statu=0;
 	//var flag_fp=0;
    for(i=0;i<names.length;i++){
	    if (names[i].checked){
				statu++;
				
				//判断发票号与发票日期
				//flag
				var flag_value=names[i].attributes["flag"].nodeValue;
				if (flag_value>0) {
					//flag_fp++;
					alert("项目"+names[i].attributes["xmNum"].nodeValue+"没有发票号或发票日期!");
					return false;
				}
		}
	}
	if (statu==0) {
			alert("请选择您要申请的项目!");
			return false;
	} else{
			document.search.action="save.jsp?savetype=add";
			
		 if (document.getElementById("pay_date").value.length==0) {
				alert("请选择应付日期!");
				return false;
			}
			return confirm("是否确认提交");
	}
	return false;
	
}


function search_proj() {
	document.search.action="t.jsp";
	document.search.submit();
}



</script>


</head>


<body onload="fun_winMax();" style="overflow:auto;">
<form name="search" method="post" action="t.jsp">
<input id="savetype" name="savetype" type="hidden" value="add">
<input id="plan_id" name="plan_id" type="hidden" >


<div id=bgDiv>
<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">

<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle">
新增 -放款
</td>
</tr>

<tr valign="top">
<td  align=center width=100% height=100% style="padding: 0px;">
<div style="margin-top: 0px;">
<table align=center width=96%  border="0" cellspacing="0" cellpadding="0" style="margin-top:0px">
<tr>
<td>
<!--操作按钮开始-->
<table border="0" cellspacing="0" cellpadding="0" height="30">
	  <tr>
	    <td>
	    	
<BUTTON class="btn_2" name="btnSave" value="保存"  type="submit"  onclick="return isSub(this);" >
<img src="../../images/save.gif" align="absmiddle" border="0">保存</button>

<BUTTON class="btn_2" name="btnExport" value="导出"  type="submit"  onclick="return isExport();" >
<img src="../../images/save.gif" align="absmiddle" border="0">导出</button>


<BUTTON class="btn_2" name="btnReset" value="取消" onclick="window.close();">
<img src="../../images/hg.gif" align="absmiddle" border="0">取消</button>

	    	</td>
	  </tr>
</table>
<!--操作按钮结束-->
</td>
</tr>
<tr><td height="1" bgcolor="#DFDFDF"></td></tr>
<tr><td height="5"></td></tr>
<tr><td width="100%">
 <table border="0" cellspacing="0" cellpadding="0">
 <tr>
  <td id="Form_tab_0" class="Form_tab" width=70 align=center onclick="chgTabN()"  valign="middle">修改信息</td>
  <td id="Form_tab_1" class="Form_tab" width=0 align=center onclick="chgTabN()"  valign="middle"></td>
  <td id="Form_tab_2" class="Form_tab" width=0 align=center onclick="chgTabN()"  valign="middle"></td>
  
 </tr>
 </table></td></tr> 
<tr><td class="tab_subline" width="100%" height="2"></td></tr>
</table>
</div>

<div style="margin-top: 5px;">
<div id="divH" class="tabBody" style="background:#ffffff;width:96%;overflow:auto;margin: 0px;">
<div id="TD_tab_0">


<%
String sqlstr;
ResultSet rs;

//得到当前登陆的用户
String dqczy = (String) session.getAttribute("czyid");

String wherestr=" where 1=1 ";
//查询条件判断
String contract_id="";
String cust_name="";
String create_start_date="";
String create_end_date="";
//String create_start_date = getStr( request.getParameter("create_start_date") );
//String create_end_date = getStr( request.getParameter("create_end_date") );
if ( !contract_id.equals("") ) {
	wherestr = wherestr + " and  contract_id  like '%" + contract_id + "%'";
}

if ( !cust_name.equals("") ) {
	wherestr = wherestr + " and cust_name  like '%" + cust_name + "%'";
}
if(create_start_date!=null&&!create_start_date.equals("")){
	wherestr+=" and convert(varchar(10),create_date,21)>='"+create_start_date+"' ";
}
if(create_end_date!=null&&!create_end_date.equals("")){
	wherestr+=" and convert(varchar(10),create_date,21)<='"+create_end_date+"' ";
}
String where_str =wherestr;

String sql="select * from vi_invoice "+where_str;
rs=db.executeQuery(sql);
System.out.println("sql="+sql);

//根据当前登陆的用户查询出代理公司相关的信息
//sqlstr="select gs.bmmc as bmmc,yh.bm as bmid,dl.skyy,dl.skzh from jb_yhxx yh  ";
//sqlstr +=" left join jb_gsbm gs on gs.id = yh.bm left join dl_mpxx dl on dl.khbh=gs.bmbh where yh.id='"+dqczy+"' ";
sqlstr="select * from vi_invoice";

System.out.println("sqlstr="+sqlstr);
String id="";
rs=db.executeQuery(sqlstr); 
if (rs.next()) { 

	id=getDBStr(rs.getString("id"));
}
rs.close();


//处理项目基本信息中产品类型为中文的选择
String prod_id_str="";
sqlstr="select * from ifelc_conf_dictionary where name='EquipType'";
rs=db.executeQuery(sqlstr);
while(rs.next()){
	prod_id_str=prod_id_str+"|"+getDBStr(rs.getString("title"));
}rs.close();


%>


<input type="hidden" name="savetype" value="add">
<input type="hidden" name="id" value="<%=id%>" />

<input type="hidden" name="where_str" id="where_str" value="<%=where_str%>" />


<!--可折叠查询开始-->
<div style="width:100%;">
<fieldset style="width:100%;TEXT-ALIGN:center;margin:0px 5px 0px 5px;"> 
  <legend>&nbsp;查询条件
<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" style="cursor:hand" title="显示/隐藏内容">&nbsp;
</legend>
<table border="0" width="100%" cellspacing="5" cellpadding="0">

   <tr>
    <td scope="row">合同编号:</td>
    <td > 
    <input name="contract_id" type="text" size="12" value="<%=contract_id %>"    maxlength="10">
	</td>
	<tr>
	 <td scope="row">发票开据时间:</td>
    <td> 
   
    <input name=create_start_date type="text" size="12"   value="<%=create_start_date %>"   readonly maxlength="10" dataType="Date">
     <img  onClick="openCalendar(create_start_date);return false" style="cursor:pointer; " 
     src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
     -
    <input name="create_end_date" type="text" size="12"   value="<%=create_end_date %>"   readonly maxlength="10" dataType="Date">
     <img  onClick="openCalendar(create_end_date);return false" style="cursor:pointer; " 
     src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
     &nbsp;
	</td>
</tr>
   <tr>
   
    <td  scope="row">客户名称:</td>
    <td> 
    <input name="cust_name" type="text" size="12"   value="<%=cust_name %>"   maxlength="10">
	</td>   
	
	
  </tr>
  <tr>
 
	<td colspan="2">
		<input name="" type="button" value="查询" onclick="search.submit();">&nbsp;&nbsp;&nbsp;&nbsp;
		<input name="ck_all" id="ck_all" type="checkbox" onclick="isSelectAll();">全选/反选
	</td>
  <tr>
</table>
</fieldset>
</div>
<!--可折叠查询结束-->

<table border="0" cellspacing="0" cellpadding="0" width="100%" align="center" class="tab_table_title">
<tr class="maintab">
	<td align="left" colspan="10"></td>
</tr>
 <tr>
     <td scope="row">发票开据日期:</td>
    <td> 
    <input name="pay_date" type="text"  width="50px;"   readonly maxlength="10" dataType="Date" Require="true">
	<span class="biTian">*</span>
	<img  onClick="openCalendar(pay_date);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
	</td>
	 <td  scope="row">发票金额:</td>
    <td > 
    <input name="pay_amt" id="pay_amt" type="text" width="50px;"    readonly maxlength="10">
	</td>
	 <td scope="row">发票号</td>
    <td>
  <input name="proj_number" id="proj_number" type="text" width="50px;"    readonly maxlength="10">
    </td>
    
  </tr>


</table>

<div style="vertical-align:top;width:100%;overflow:auto;position: relative;height:360px;"
				id="mydiv";>
				
<table border="0" style="border-collapse:collapse;" align="center"
						cellpadding="2" cellspacing="1" width="100%"
						class="maintab_content_table">
						<tr class="maintab_content_table_title">
						
							 <th width="1%"></th> 						
       						<th>序号</th>
	    <th>项目名称</th>
	    <th>合同额</th>
	    <th>合同编号</th>
	    <th>发票抬头</th>
	    <th>本期数</th>
	    <th>总期数</th>
	    <th>还款日期</th>
		<th>本金</th>
		<th>利息</th>
						</tr>
						<tbody id="data">
						<%
						String sqls="select * from vi_invoice";
						System.out.println("sqls"+sqls);
						rs=db.executeQuery(sql);
						int n=0;
						//复选框id
						String ckid="";
						String je="";
						String pro_id="";
						String plan_id="";
						int flag=0;
						while(rs.next()){
						ckid="ck_"+n;
						pro_id=getDBStr(rs.getString("proj_id"));
					  //  plan_id=getDBStr(rs.getString("plan_id"));
					
						 %>
						
						<tr>
							<td>
								<input  type="checkbox" name="list" value="" id="<%=ckid %>" onclick="makeValue();" je="<%=je %>" xmNum="<%=pro_id %>" plan_id=<%=plan_id %>  flag="<%=flag %>">
							</td>
	        				
	        				<td align="center"><%= getDBStr( rs.getString(("id") )) %></td>
		<td align="center"><%= getDBStr( rs.getString("project_name") ) %></td>
		<td align="center"><%= getDBStr( rs.getString(("rent") )) %></td>
	   <td align="center"><%= getDBStr( rs.getString("contract_id") ) %></td>
	   <td align="center"><%= getDBStr( rs.getString("cust_name") ) %></td>
	    <td align="center"><%= getDBStr( rs.getString("rent_list") ) %></td>
		<td align="center"><%= getDBStr( rs.getString("income_number") ) %></td>
		<td align="center"><%= getDBDateStr( rs.getString("plan_date") ) %></td>
		<td align="center"><%= getDBStr( rs.getString("corpus") ) %></td>
		<td align="center"><%= getDBStr( rs.getString("interest") ) %></td>
						</tr>
						
						<%
						n++;
						} %>
						
	</tbody>					
</table>

</div>
</div>
</div>
<div id="TD_tab_1" style="display:none;"> 
  选择卡中的内容2
</div>
<div id="TD_tab_2" style="display:none;"> 
  选择卡中的内容3

选择卡中可能包含以下内容：

注意HTMLBody并不是选择卡中的内容，因此需要独立拿出来放在最后。

</div>
</div>

<div style="margin-top: 5px;">
<table width=96% align=center border="0" cellspacing="0" cellpadding="0">
<tr><td width="50%"></td>
<td width="50%" valign="middle" align="right">&nbsp;</td></tr>
</table>
</div>
</td>
</tr>
</table>  
</div>
<!--添加结束-->

<!--控制选择卡和内置iframe的高度适应窗口
<script language="javascript">
ShowTabN(0);
reinitIframe();
//外部div高度自适应
function reinitIframe(){
var divH = document.getElementById("divH");
var reinitIframe_resize=function(){
divH.style.height=window.document.body.clientHeight-100;
}
reinitIframe_resize();
window.onresize=reinitIframe_resize;
}
//内部Iframe高度自适应
//function autoResize()
//{
//	try
//	{
//		document.all["UserBody1"].style.height=UserBody1.document.body.scrollHeight
//	}
//	catch(e)
//	{}
//}
</script>
-->

<%
rs.close(); 
db.close();

 %>
 
 <script type="text/javascript">
 
 //用于数组的下标
 var icount=0;
 //总金额
 var total=0;
 //总项目数
 var xm_Number=0;
   //定义一个空数组,项目编号
var myArr=new Array();
   //得到项目数量input对象
var proj_number=document.getElementById("proj_number");
   //付款金额对象
var pay_amt=document.getElementById("pay_amt");
//资金计划id
var plan_id=document.getElementById("plan_id");
var sid="";
   
 function makeValue(){
 total=0;
 icount=0;
 sid="";
myArr=new Array();
 	//得到复选框的集合
 	var names=document.getElementsByName("list");
 	
 	//names[i].attributes["xmNum"].nodeValue;
 	
    for(i=0;i<names.length;i++){
    
    	
	    if (names[i].checked){
	    	var je=parseFloat(names[i].attributes["je"].nodeValue);
			var plan_id_1=names[i].attributes["plan_id"].nodeValue;
		   //得到付款金额
		    total=total+je;
		    myArr[icount]=names[i].attributes["xmNum"].nodeValue;;
		    icount++;
		    sid=sid+plan_id_1+",";
	    }
	    
  	}
  	//项目数量
  	proj_number.value=unique(myArr).length;
  	//付款金额
  	pay_amt.value=total;
  	plan_id.value=sid.substring(0,sid.length-1);
  	
 }

//去除数组中的重复元素
function unique(data){
    data = data || [];
    var a = {};
    for ( var i=0; i<data.length; i++) {
        var v = data[i];
        if (typeof(a[v]) == 'undefined'){
                               a[v] = 1;
                               }
    };
    data.length=0; 
      for (var i in a){
               data[data.length] = i;
         }
        return data;
}

function isSelectAll () {

	var names=document.getElementsByName("list");
	var isck_all = document.getElementById("ck_all").checked;
	for (var n=0;n<names.length;n++) {
		names[n].checked=isck_all;
	}
	makeValue();
}


//导出Excel
function isExport() {
	if (confirm("是否确认导出Excel!")) {
	
		search.action="export_save.jsp";
		document.getElementById("where_str").value="<%=wherestr%>";
  		search.submit();
		search.action="t.jsp";
	}
	return false;
}


 </script>
</form>


<!-- end cwMain -->
</body>
</html>
