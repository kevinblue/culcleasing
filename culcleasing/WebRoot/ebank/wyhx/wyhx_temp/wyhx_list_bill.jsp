<%@ page contentType="text/html; charset=gbk" language="java"  %>
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<jsp:useBean id="right" scope="page" class="com.filter.FilterCredit" /> 
<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common.jsp"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>资产管理 - 网银核销</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>


</head>


<%
String dqczy=(String) session.getAttribute("czyid");
if ((dqczy==null) || (dqczy.equals("")))
{
  dqczy="无认证";
  response.sendRedirect("../../noright.jsp");
}
int canedit=0;
if (right.CheckRight("fund_hx_first_wy",dqczy)>0) canedit=1;
if (canedit==0) response.sendRedirect("../../noright.jsp");
//out.print("canedit="+canedit);
%>


					 <%
//String dqczy=(String) session.getAttribute("czyid");
String start_date = getStr(request.getParameter("start_date"));
String end_date = getStr(request.getParameter("end_date"));
String proj_id = getStr(request.getParameter("proj_id"));
String contract_id = getStr(request.getParameter("contract_id"));
String prod_id = getStr(request.getParameter("prod_id"));
String dld_name = getStr(request.getParameter("dld_name"));
String cust_name = getStr(request.getParameter("cust_name"));
String bank = getStr(request.getParameter("bank"));

ResultSet rs = null;
String sqlstr = "";
//String wherestr=" where 1=1 and vi_cust_all_info.cust_id in(select cust_id from cust_ewlep_info)";
String wherestr=" where 1=1";
if(!start_date.equals("")){
	wherestr+=" and proj_info.create_date>='"+start_date+"'";
}
if(!end_date.equals("")){
	wherestr+=" and proj_info.create_date<='"+end_date+"'";
}
if(!proj_id.equals("")){
	wherestr+=" and a.proj_id like '%"+proj_id+"%'";
}
if(!prod_id.equals("")){
	wherestr+=" and proj_info.prod_id like '%"+prod_id+"%'";
}

if(!dld_name.equals("")){
	wherestr+=" and dl_mpxx.khmc like '%"+dld_name+"%'";
}
if(!cust_name.equals("")){
	wherestr+=" and vi_cust_all_info.cust_name like '%"+cust_name+"%'";
}
if(!bank.equals("")){
	wherestr+=" and proj_info.bank like '%"+bank+"%'";
}

//处理项目基本信息中产品类型为中文的选择
String prod_id_str="";
sqlstr="select * from ifelc_conf_dictionary where parentid='ProductType'";
rs=db.executeQuery(sqlstr);
while(rs.next()){
	prod_id_str=prod_id_str+"|"+getDBStr(rs.getString("title"));
}rs.close();
//选择银行
String bank_str="";
sqlstr="select distinct bank from proj_info order by bank";
rs=db.executeQuery(sqlstr);
while(rs.next()){
	bank_str=bank_str+"|"+getDBStr(rs.getString("bank"));
}rs.close();

sqlstr="select vi_cust_all_info.card_id,vi_cust_all_info.cust_name,proj_info.account,a.plan_money,a.proj_id as memo from ( 	select proj_id,sum(plan_money) as plan_money from fund_fund_charge_plan 	where item_method='网银' and isnull(status,'0')<>'1' and funds_mode='收款' group by proj_id )a left join proj_info on a.proj_id=proj_info.proj_id left join dl_mpxx on proj_info.agent_id=dl_mpxx.khbh left join vi_cust_all_info on proj_info.cust_id=vi_cust_all_info.cust_id";
wherestr+=" and proj_info.proj_id  in(select proj_id from fund_fund_charge_plan where isnull(export_flag,'')='1' and item_method='网银' and isnull(status,'0')<>'1' and funds_mode='收款' )";
sqlstr+=wherestr;
sqlstr =" select a.id,export_type, export_date,memo,b.xm from export_wyhx a left join jb_yhxx b on a.createor=b.id ";

System.out.println("sqlstr000=================================="+sqlstr);
%>
<body onload="public_onload(0);">
<form action="wyhx_list.jsp" name="dataNav" onSubmit="return goPage()">
<!--标题开始-->
<input name="sqlstr" value="<%=sqlstr %>" type="hidden">
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
			<tr class="tree_title_txt">
				<td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
				资产管理 &gt; 网银核销</td>
			</tr>
</table>
<!--标题结束-->


<table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:2px;">
			<tr class="maintab">
				<td align="left" width="1%">

<!--操作按钮开始-->
<table border="0" cellspacing="0" cellpadding="0" >    
    <tr class="maintab">
    	<td nowrap>
		<a href="#" accesskey="n" onclick="xx_submit('核销')"><img align="absmiddle"  src="../../images/sbtn_new.gif" alt="上传扣款回执" align="absmiddle">上传扣款回执</a>
		<BUTTON class="btn_2" name="btnModify" value="重置"  type="button" onclick=" updateState(); ">
		<img src="../../images/sbtn_mod.gif" align="absmiddle" border="0">重置</button>
		</td>
		
    </tr>
</table>
<!--操作按钮结束-->
</td>
					 <td align="right" width="90%">
					 	
					 	
<!--翻页控制开始-->


<% 
	int intPageSize = 15;   //一页显示的记录数
	int intRowCount = 0;   //记录总数
	int intPageCount = 1; //总页数
	int intPage;       //待显示页码
	String strPage = getStr( request.getParameter("page") );          //取得待显示页码
	if( strPage.equals("") ){                                         //表明在QueryString中没有page这一个参数，此时显示第一页数据
	   intPage = 1;
	}else{
	   intPage = java.lang.Integer.parseInt(strPage);
	   if(intPage<1) intPage = 1;
	} 


rs = db.executeQuery(sqlstr); 


	rs.last();                                                  //获取记录总数
	intRowCount = rs.getRow();
	intPageCount = ( intRowCount + intPageSize - 1) / intPageSize;   //记算总页数
	if( intPage > intPageCount ) intPage = intPageCount;            //调整待显示的页码
	if( intPageCount > 0 )
	   rs.absolute( ( intPage-1 ) * intPageSize + 1 );              //将记录指针定位到待显示页的第一条记录上
	int i = 0;
	
%>


<table border="0" cellspacing="0" cellpadding="0">
  <tr class="maintab">
	<script>
		var cp = <%= intPage %>;
		var lp = <%= intPageCount %>;
		var nf = document.dataNav;
	</script>
    <td nowrap>共 <%=intRowCount%> 条 / <%=intPageCount%> 页 
	<%if(intPage>1){%>	<img align="absmiddle" style="cursor:pointer; " onClick="goPage('first')" src="../../images/ico_first.gif" alt="第一页" border="0"><img align="absmiddle" style="cursor:pointer; " onClick="goPage('prev')" src="../../images/ico_prev.gif" alt="上一页"    border="0">
	<%}else{%><img align="absmiddle" style="filter:Gray;" src="../../images/ico_first.gif" alt="第一页"  border="0"><img align="absmiddle" style="filter:Gray;" src="../../images/ico_prev.gif" alt="上一页" border="0"><% } %>
	第 <font color="red"><%=intPage%></font> 页	
	<%if(intPage<intPageCount){%> <img align="absmiddle" style="cursor:pointer; " onClick="goPage('next')" src="../../images/ico_next.gif" alt="下一页" border="0"><img align="absmiddle" style="cursor:pointer; " onClick="goPage('last')" src="../../images/ico_last.gif" alt="最后页" border="0">
	<%}else{%><img align="absmiddle" style="filter:Gray;" src="../../images/ico_next.gif" alt="下一页" border="0"><img align="absmiddle" style="filter:Gray;" src="../../images/ico_last.gif" alt="最后页" border="0"><% } %></td>
	
    <td nowrap><img align="absmiddle" src="../../images/sbtn_split.gif"></td>
    
    <td nowrap>转到 <input name="page" type="text" size="2" value="1"> 页 <img align="absmiddle" style="cursor:pointer; " onClick="goPage('jump')" src="../../images/goto.gif" alt="执行" border="0" align="absmiddle"></td>
 </tr>
</table>

</td>
</tr>
</table>

<!--翻页控制结束-->


<!--报表开始-->

<div style="vertical-align:top;width:100%;overflow:auto;position: relative;"  id="mydiv";>

   <table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" cellspacing="1" width="100%" class="maintab_content_table" >
      <tr class="maintab_content_table_title">
		<th width="1%"></th>
		<th>编号</th>
		<th>导出人</th>
		<th>导出日期</th>
		<th>备注</th>
      </tr>
  

<%	  
rs.previous();
if ( rs.next() ) {
	while( i < intPageSize && !rs.isAfterLast() ) {
%>

      <tr>
      	<td><input type="checkbox" name="list" value="<%=getDBStr(rs.getString("id"))%>"></td>
        <td><%= getDBStr( rs.getString("id") ) %></td>
        <td><%= getDBStr( rs.getString("xm") ) %></td>
        <td><%= getDBDateStr( rs.getString("createor") ) %></td>
        <td><%= getDBStr( rs.getString("memo") ) %></td>
      </tr>
<%
		rs.next();
		i++;
	}
}
rs.close(); 
db.close();
%>
    </table>
</div>

<!--报表结束-->
</form>
</body>
</html>
<script language="javascript">
function xx_submit(str){
  	if(str=="导出"){
  		
  		dataNav.action="export_save.jsp";
  		dataNav.target="_black";
  		dataNav.submit();
  	}if(str=="核销"){
  		dataNav.action="wyhx_upload.jsp";
  		dataNav.target="_black";
  		dataNav.submit();
  	}else{
  		dataNav.action="wyhx_list.jsp";
  		dataNav.target="";
  		dataNav.submit();
  	}
}
</script>

  <script type="text/javascript">

String.prototype.trim = function()
{
    return this.replace(/(^\s*)|(\s*$)/g, "");
};
 
 
var xmlHttp;
function GetXmlHttpObject(){
	var objXMLHttp = null;
	if(window.XMLHttpRequest)	{
		objXMLHttp = new XMLHttpRequest();
	}else if(window.ActiveXObject)	{
		objXMLHttp = new ActiveXObject("Microsoft.XMLHTTP");
	}
	return objXMLHttp;
}
function stateChanged(){	

	if(xmlHttp.readyState == 4)	{

		var returnvalue=xmlHttp.responseText ;
			//alert("test"+returnvalue);
		if(returnvalue!=""){
			if (returnvalue.trim()=="-1") {
				alert("修改状态成功!");
				window.location.reload(true);
				
			} else {
				alert("修改状态失败!");
			}
			
		}
		
	}	
}

var sql_bh_ids="";

function updateState(){
  	xmlHttp = GetXmlHttpObject();

if (validate_sel()){ 
	if (confirm("慎重:确认后会将历史记录修改!")){
			var url = "state_check.jsp?sql_bh_ids="+sql_bh_ids;
		  	xmlHttp.onreadystatechange = stateChanged;	
		  	xmlHttp.open("POST",url,false);
		  	xmlHttp.send(null);
	} 
}	
}
</script>

<script type="text/javascript">

		function validate_sel() {
		
		
		//是否有选中的付款单号
		var names=document.getElementsByName("list");
	 	var flag_bh=0;
	 	var str_bh="";//保存所要删除的付款单号
	 	 sql_bh_ids="";
	    for(i=0;i<names.length;i++){
		    if (names[i].checked){
		    	flag_bh++;
		    	var fid= names[i].value;
		    	str_bh+=fid+",";
		    	sql_bh_ids+="'"+fid+"',";
		    }
		
		}
		
		
		str_bh=str_bh.substring(0,str_bh.length-1);
		sql_bh_ids=sql_bh_ids.substring(0,sql_bh_ids.length-1);
		//alert(sql_bh_ids);
		if (flag_bh==0) {
			alert("请选择您要重置的项目!");
			return false;
		}else {
			return true;
		}
		
		}
		
		
		</script>
		
		