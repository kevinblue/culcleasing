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
			document.search.action="fk_apply_save.jsp?savetype=add";
			
		 if (document.getElementById("pay_date").value.length==0) {
				alert("请选择应付日期!");
				return false;
			}
			return confirm("是否确认提交");
	}
	return false;
	
}


function search_proj() {
	document.search.action="fk_apply_add.jsp";
	document.search.submit();
}



</script>


</head>


<body onload="fun_winMax();" style="overflow:auto;">
<form name="search" method="post" action="fk_apply_add.jsp">
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



//得到当前登陆的用户
String dqczy = (String) session.getAttribute("czyid");


System.out.println("1"+dqczy);
String searchFld = getStr( request.getParameter("searchFld") );
System.out.println("2"+searchFld);
String searchKey = getStr( request.getParameter("searchKey") );
System.out.println("3"+searchKey);
String create_start_date = getStr( request.getParameter("create_start_date") );
String create_end_date = getStr( request.getParameter("create_end_date") );
ResultSet rs;
String wherestr = " where 1=1";

String searchFld_tmp = "";
if( searchFld.equals("客户名称") ) {
	searchFld_tmp = "cust_name";
}else if( searchFld.equals("合同编号") ) {
	searchFld_tmp = "contract_id";
}else if( searchFld.equals("登记人") ) {
	searchFld_tmp = "dbo.GETUSERNAME(creator)";
}else{
	searchFld_tmp = "";
}

if ( !searchFld.equals("") && !searchKey.equals("") ) {

	wherestr = wherestr + " and " + searchFld_tmp + " like '%" + searchKey + "%'";
}
if(create_start_date!=null&&!create_start_date.equals("")){
	wherestr+=" and convert(varchar(10),create_date,21)>='"+create_start_date+"' ";
}
if(create_end_date!=null&&!create_end_date.equals("")){
	wherestr+=" and convert(varchar(10),create_date,21)<='"+create_end_date+"' ";
}
String sqlstr="select * from  vi_invoice" + wherestr +" order by create_date desc"; 
System.out.println("###"+sqlstr);

%>
<input type="hidden" name="savetype" value="add">

<!--可折叠查询开始-->
<div style="width:100%;">
<fieldset style="width:100%;TEXT-ALIGN:center;margin:0px 5px 0px 5px;"> 
  <legend>&nbsp;查询条件
<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" style="cursor:hand" title="显示/隐藏内容">&nbsp;
</legend>
<table border="0" cellspacing="0" cellpadding="0" width="98%" align="center" class="tab_table_title">
  <tr>
 
    <td>发票号</td>
    <td><input name="invoice_number" type="text" size="20" maxB="50" Require="ture">
  <span class="biTian">*</span></td>
  </tr>
  <tr>
  	<td>发票日期</td>
    <td><input name="invoice_date" type="text" size="20" readonly maxlength="10" dataType="Date" Require="ture">
     <img  onClick="openCalendar(invoice_date);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
	<span class="biTian">*</span></td>
	</tr>
	<tr>
    <td>发票金额</td>
    <td><input name="invoice_amt" type="text" size="20" maxB="100" dataType="Money">
  </td>
  </tr>
</table>
</fieldset>
</div>
<!--可折叠查询结束-->

<table border="0" cellspacing="0" cellpadding="0" width="100%" align="center" class="tab_table_title">
<tr class="maintab">
	<td align="left" colspan="10"></td>
</tr>
		<tr class="maintab">
				<td align="left" colspan="2">  
            
					&nbsp;按&nbsp;<select name="searchFld"><script>w(mSetOpt("<%= searchFld %>","|合同编号|客户名称|登记人"));</script></select>&nbsp;查询&nbsp;<input name="searchKey" accesskey="s" type="text" size="15" value="<%= searchKey %>">
		添加日期<input name="create_start_date" type="text" size="10" readonly maxlength="10" dataType="Date" value="<%=create_start_date %>"> <img  onClick="openCalendar(create_start_date);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
		-<input name="create_end_date" type="text" size="10" readonly maxlength="10" dataType="Date" value="<%=create_end_date %>"> <img  onClick="openCalendar(create_end_date);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
		<input name="image" type="image" src="../../images/tbtn_searh.gif" alt="查询" align="absmiddle"  onclick="searchbar.submit();">
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
							  <%--
							   <th>发票号</th>
      						  <th>发票日期</th>
							  --%>
						</tr>
						<tbody id="data">
						<%

System.out.println("dqczy:"+dqczy);
String s="select count(*) as c,jb_yhxx.bmbh from jb_yhxx where id='"+dqczy+"' and isnull(bmbh,'')<>'' group by jb_yhxx.bmbh";

//执行查询
rs = db.executeQuery(s);
int count=0;
String ssjxs="";
if (rs.next()){
	count = rs.getInt("c");
	ssjxs=rs.getString("bmbh");
} 
if (count==0) {//当是租赁公司时
	
	System.out.println("sqlstr==================0"+count);
}else {//当是经销商时
System.out.println("sqlstr==================1"+count);
//wherestr+="   and agent_id in (select jb_yhxx.bmbh from jb_yhxx where jb_yhxx.id='"+dqczy+"')";

}
%>


						
						<%
				
						ResultSet rs1=null;
						//sqlstr = "select * from vi_fk_sb   "+wherestr+" and status<>1 and  vi_fk_sb.plan_id not in( ";
						//sqlstr +=" select case when CHARINDEX('_',plan_id)>0 then substring(plan_id,0,CHARINDEX('_',plan_id)) else plan_id end ";
						//sqlstr +=" from dbo.apply_info_detail where apply_id in( select id from dbo.apply_info where pay_type='放款' ";
						//sqlstr +=" ))order by vi_fk_sb.dld asc "; 
						//System.out.println("sqlstr=================="+sqlstr);
						//rs1 = db1.executeQuery(sqlstr); 
						int i=0;
							//复选框id
							String ckid="";
							String je="";
							String pro_id="";
							//资金计划id
							String plan_id="";
							
							//用于判断是有没有发票号与发票日期
							int flag=0;
							
						while (rs1.next()){
							flag=0;
							ckid="ck_"+i;
							je=formatNumberDoubleTwo(rs1.getString("plan_money"));//放款金额
							pro_id=getDBStr(rs1.getString("proj_id"));
							plan_id=getDBStr(rs1.getString("plan_id"));
							
							if (getDBStr(rs1.getString("invoice_no")).trim().length()==0 || getDBStr(rs1.getString("invoice_date")).trim().length()==0 ) {
								flag++;
							}
						
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
							<%-- 
								<td align="center"><%=getDBStr(rs1.getString("invoice_no")) %></td>
	        				<td align="center"><%=getDBDateStr(rs1.getString("invoice_date")) %></td>
							--%>
						</tr>
						
						<%
						i++;
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
rs1.close(); 
db1.close();
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
		search.action="fk_apply_add.jsp";
	}
	return false;
}


 </script>
</form>


<!-- end cwMain -->
</body>
</html>
