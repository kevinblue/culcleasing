<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@page import="com.tenwa.util.CurrencyUtil"%>

<%@ include file="../../public/simpleHeadImport.jsp"%>
<%@page import="com.tenwa.culc.service.ProjMaterService"%>


<!-- 公共变量 -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- 公共变量 -->
<!-- 下拉值 -->
<%@ include file="../../public/selectData.jsp"%>
<!-- 下拉值 -->


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>租金发票信息维护 </title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/calend.js"></script>
<script src="../../js/delitem.js"></script>

<script Language="Javascript" src="../../js/jquery.js"></script>
<script type="text/javascript" src="../../js/stleasing_tabledata_nonewline.js"></script>
<script type="text/javascript" src="../../js/stleasing_function.js"></script>
<link href="../../css/stleasing_tabledata.css" rel="stylesheet" type="text/css">
</head>
<% 
 String  userId=(String)dqczy; 
System.out.println("租金发票信息维护中当前登录人："+dqczy);
%>
<script type="text/javascript">
	//提交保存资料状态
	function contractInvoiceItem(){	
			var id_list = '';
			var contract_id_list = '';
			var begin_id_list = '';
			var is_normal_list = '';
			var is_advance_list='';
			var creator_list='';
			var create_date_list='';
			var modificator_list='';
			var modify_date_list='';
			var statues_list='';
			
			var selectedIndex = -1;
			var dataNav = document.getElementById("dataNav");
			var str = document.getElementsByName("checkbos_list");
			var i = 0;
			for (i = 0; i < str.length; i++)
			{
				if (str[i].checked)
				{
					selectedIndex = i;
					id_list = id_list + str[i].value + "#";
					contract_id_list = contract_id_list + str[i].attributes["contract_id"].nodeValue+"#";
					begin_id_list = begin_id_list + str[i].attributes["begin_id"].nodeValue+"#";
					is_normal_list=is_normal_list + str[i].attributes["is_normal"].nodeValue+"#";
					is_advance_list = is_advance_list + str[i].attributes["is_advance"].nodeValue+"#";
					creator_list = creator_list + str[i].attributes["creator"].nodeValue+"#";
					create_date_list = create_date_list + str[i].attributes["create_date"].nodeValue+"#";
					modificator_list=modificator_list+str[i].attributes["modificator"].nodeValue+"#";
					modify_date_list=modify_date_list+str[i].attributes["modify_date"].nodeValue+"#";
					statues_list=statues_list+str[i].attributes["statues"].nodeValue+"#";
					if(str[i].attributes["begin_id"].nodeValue=='0'){
						alert("合同号为："+str[i].attributes["contract_id"].nodeValue+"的起租编号不能为空！");
						return  false;
					}
					
				}
			}
			if (selectedIndex < 0 )
			{
				alert("请先选择需要开票的数据行!");
				return false;
			}
			
		   id_list = id_list.substring(0,id_list.length-1);		   
		   contract_id_list = contract_id_list.substring(0,contract_id_list.length-1);
		   begin_id_list = begin_id_list.substring(0,begin_id_list.length-1);
		   is_normal_list = is_normal_list.substring(0,is_normal_list.length-1);
		   is_advance_list = is_advance_list.substring(0,is_advance_list.length-1);
		   creator_list = creator_list.substring(0,creator_list.length-1);
		   create_date_list = create_date_list.substring(0,create_date_list.length-1);
		   modificator_list = modificator_list.substring(0,modificator_list.length-1);
		   modify_date_list = modify_date_list.substring(0,modify_date_list.length-1);
		   statues_list = statues_list.substring(0,statues_list.length-1);
		   
			
		   document.getElementById('id_list').value = id_list;
		   document.getElementById('contract_id_list').value = contract_id_list;
		   document.getElementById('begin_id_list').value = begin_id_list;
		   document.getElementById('is_normal_list').value = is_normal_list;
		   document.getElementById('is_advance_list').value = is_advance_list;	
		   document.getElementById('creator_list').value = creator_list;
		   document.getElementById('create_date_list').value = create_date_list;
		   document.getElementById('modificator_list').value = modificator_list;
		   document.getElementById('modify_date_list').value = modify_date_list;
		     document.getElementById('statues_list').value = statues_list;
		///	  document.getElementById('czyid').value =aaa;
		   
			dataNav.action="contract_invoice_item_save.jsp";
			dataNav.target="_blank";
			dataNav.submit();
			dataNav.action="contract_invoice_item.jsp";
			dataNav.target="_self";
		  
	}
	//checkbos全选
	function isSelectAll() {
		var names = document.getElementsByName("checkbos_list");
		var isck_all = document.getElementById("ck_all").checked;
		for (var n=0;n<names.length;n++) {
			names[n].checked=isck_all;
		}
	}
	function allbool(va){
		var v=va;
		if(v=='是1'){
			$(":radio[id='invoice_is']").removeAttr("checked");
			$("input[id='invoice_is'][value='是']").attr("checked","checked");	
		
		}else if(v=='否1'){
		    $(":radio[id='invoice_is']").removeAttr("checked");
			$("input[id='invoice_is'][value='否']").attr("checked","checked");
		}
	}
	function piliang(beizhu){
		var bz='invoice_remark_'+beizhu;
		var vu = $("input[name='"+bz+"']").val();
		$("input[id='invoice_remark']").val(vu);
	}

</script>


<body onload="public_onload(0);">
<form action="contract_invoice_item.jsp" name="dataNav" onSubmit="return goPage()"  confirm="false" method="post">

<input type="hidden" name="type" value="updStatus">
<input type="hidden" name="itemStr">
<input type="hidden" name="itemIdStr">
<input type="hidden" name="id_list" id="id_list"/>
<input type="hidden" name="contract_id_list" id="contract_id_list"/>
<input type="hidden" name="begin_id_list" id="begin_id_list"/>
<input type="hidden" name="is_normal_list" id="is_normal_list"/>
<input type="hidden" name="is_advance_list" id="is_advance_list"/>
<input type="hidden" name="creator_list" id="creator_list"/>
<input type="hidden" name="create_date_list" id="create_date_list"/>
<input type="hidden" name="modificator_list" id="modificator_list"/>
<input type="hidden" name="modify_date_list" id="modify_date_list"/>
<input type="hidden" name="statues_list" id="statues_list"/>
<input type="hidden" name="czyid" id="czyid"/>



<!-- 资金计划数据 -->
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
	<tr class="tree_title_txt">
		<td nowrap width="100%" class="tree_title_txt" valign="middle">
		租金发票信息维护</td>
	</tr>
</table> 

<%
wherestr = "";

String proj_name = getStr( request.getParameter("proj_name") );
String proj_manage_name = getStr( request.getParameter("proj_manage_name") );
String pay_obj = getStr(request.getParameter("pay_obj"));
String parent_deptname=getStr(request.getParameter("parent_deptname"));
String dept_name=getStr(request.getParameter("dept_name"));
String is_normal=getStr(request.getParameter("is_normal"));
String is_advance=getStr(request.getParameter("is_advance"));
String contract_id = getStr( request.getParameter("contract_id") );
String begin_id = getStr( request.getParameter("begin_id") );


if ( proj_name!=null && !proj_name.equals("") ) {
	wherestr += " and project_name like '%" + proj_name + "%'";
}
if ( proj_manage_name!=null && !proj_manage_name.equals("") ) {
	wherestr += " and proj_manage_name like '%" + proj_manage_name + "%'";
}
if(parent_deptname!=null && !parent_deptname.equals("")){
	wherestr +=" and parent_deptname like '%" + parent_deptname + "%'";
}
if(dept_name!=null && !dept_name.equals("")){
	wherestr +=" and dept_name like '%" + dept_name + "%'";
}
if(pay_obj != null && !pay_obj.equals("")){
	wherestr +=" and pay_obj like '%" + pay_obj + "%'";
}
if(is_normal != null && !is_normal.equals("")){
	wherestr +=" and contract_is_normal like '%" + is_normal + "%'";
}
if(is_advance != null && !is_advance.equals("")){
	wherestr +=" and contract_is_advance like '%" + is_advance + "%'";
}
if ( contract_id!=null && !contract_id.equals("") ) {
	wherestr += " and contract_id like '%" + contract_id + "%'";
}
if ( begin_id!=null && !begin_id.equals("") ) {
	wherestr += " and begin_id like '%" + begin_id + "%'";
}

countSql = "select count(proj_id) as amount from vi_invoice_item where 1=1 "+wherestr;

//导出类型2--数据导出
String expsqlstr = "select proj_id 项目编号,contract_id 合同编号,project_name 项目名称,cust_name 客户名称,parent_deptname 部门名称, dept_name 大区名称,proj_manage_name 项目经理,contract_is_normal 是否正常,contract_is_advance 是否提前,creator 创建人, "+
"create_date  创建时间,modificator 最新更新人,modify_date 最新更新时间  from vi_invoice_item where 1=1 "+wherestr;
System.out.println("vvvvvvvvvvvvv"+expsqlstr);

String updSql="select contract_id,fee_name,fee_num,id from vi_invoice_item where 1=1 "+wherestr;
%>
<!--可折叠查询开始-->
<div style="width:100%;" id="queryArea">
<fieldset style="width:100%;TEXT-ALIGN:center;margin:0px 5px 0px 5px;"> 
  <legend>&nbsp;查询条件
<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" style="cursor:hand" title="显示/隐藏内容">&nbsp;
</legend>
<table border="0" width="100%" cellspacing="5" cellpadding="0">
<tr>
<td>项目名称:&nbsp;<input name="proj_name"  type="text" size="15" value="<%=proj_name %>"></td>
<td>项目经理:&nbsp;<input name="proj_manage_name"  type="text" size="15" value="<%=proj_manage_name %>">
<img src="../../images/sbtn_more.gif" alt="选" width="19" height="19" align="absmiddle"  style="cursor:pointer" 
onclick="OpenDataWindow('','','','',' 项目经理','(select distinct proj_manage_name as proj_manage_name from vi_contract_info) a ','proj_manage_name','','proj_manage_name','proj_manage_name','asc','dataNav.proj_manage_name','');">
</td>
<td>部&nbsp;&nbsp;&nbsp;&nbsp;门:&nbsp;<input  name="parent_deptname" id="parent_deptname" size="15"  type="text" value="<%=parent_deptname%>">
<img src="../../images/sbtn_more.gif" alt="选" width="19" height="19" align="absmiddle"  style="cursor:pointer" 
onclick="OpenDataWindow('','','','',' 部门','(select distinct parent_deptname as parent_deptname from v_select_base_department ) a ','parent_deptname','','parent_deptname','parent_deptname','asc','dataNav.parent_deptname','');">
</td>
</tr>
<tr>
<td>大&nbsp;&nbsp;&nbsp;&nbsp;区:
 <input style="width:116px;" name="dept_name" id="dept_name" type="text" value="<%=dept_name%>">
  <img src="../../images/sbtn_more.gif" alt="选" width="19" height="19" align="absmiddle"  style="cursor:pointer" 
onclick="OpenDataWindow('','','','',' 大区','(select distinct dept_name as dept_name,order_field from v_select_base_department ) a ','dept_name','','dept_name','order_field','asc','dataNav.dept_name','');">
</td>
<td>是否正常:
		<select name="is_normal" style="width:105">
	<script type="text/javascript">
	w(mSetOpt('<%=is_normal %>',"|是|否","|是|否"));
	</script>
	</select>
</td>
<td>是否提前:
	 <select name="is_advance" style="width:105">
		<script type="text/javascript">
			w(mSetOpt('<%=is_advance %>',"|是|否","|是|否"));
		</script>
	 </select>
</td>

</tr>
<td>合同编号:&nbsp;<input name="contract_id"  type="text" size="15" value="<%=contract_id %>"></td>
<td>起租编号:&nbsp;<input name="begin_id"  type="text" size="15" value="<%=begin_id %>"></td>
<td ><input type="button" value="清空" onclick="clearQuery();" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<input type="button" value="查询" onclick="dataNav.submit();"></td>
</tr>
</table>
</fieldset>
</div>
<!--可折叠查询结束-->

<!-- end cwTop -->
<!--副标题和操作区开始-->
<table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:2px;">
<tr class="maintab">
		<td  width="10%">
		    <img src="../../images/sbtn_new.gif" align="absmiddle" border="0" alt="合同额外条件维护(Alt+N)">&nbsp;&nbsp;
			<input  class="btn_2" type="button"  value="提交"  onclick="contractInvoiceItem();">&nbsp;&nbsp;
		</td >
		<td>是否正常:
				<select id="invoice_is_normal" name="invoice_is_normal" style="width: 60">
			<script type="text/javascript">
			w(mSetOpt('是',"|是|否","|是|否"));
			</script>
			</select>
		</td>
		<td>是否提前:
			 <select id="invoice_is_advance" name="invoice_is_advance" style="width:60">
				<script type="text/javascript">
					w(mSetOpt('否',"|是|否","|是|否"));
				</script>
			 </select>
		</td>
		<td align="left">
		<!--操作按钮开始-->
		<input name="expsqlstr" type="hidden" value="<%=expsqlstr %>">
		<input name="updsql" type="hidden" value="<%=updSql %>">
		<!--<input name="excel_name" type="hidden" value="ContractInvoiceItem">
		<BUTTON class="btn_2"  type="button" onclick="return validata_data_report('../../func/exp_report.jsp','contract_invoice_item.jsp');">
		<img src="../../images/save.gif" align="absmiddle" border="0">&nbsp;导出EXCEL</button>-->
	    <!--操作按钮结束-->
	    </td>

		<!-- 翻页控制 -->
		<td align="right"><!--翻页控制开始-->
		<!-- 翻页控制开始 -->
		<%@ include file="../../public/pageSplit.jsp"%>
		<!--翻页控制结束-->
		</td><!-- 翻页结束 -->
	</tr>
</table>

<!--报表开始-->
<div style="vertical-align:top;width:100%;overflow:auto;position: relative; left: 0px; top: 0px"  id="mydiv";>
   <table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" cellspacing="1" width="100%" 
   class="maintab_content_table"  >
      <tr class="maintab_content_table_title">
	   <th width="1%">
	    	 <input name="ck_all" id="ck_all" type="checkbox" onclick="isSelectAll();">全选
	    </th>
		<th>项目名称</th>	  
		<th>合同编号</th>
		<th>起租编号</th>
		<th>是否正常</th>
		<th>是否提前</th>
		<th>税种</th>
		<th>增值税开票类型</th>		
	    <th>客户名称</th>
		<th>部门名称</th>
	    <th>大区名称</th>
     	<th>项目经理</th>
	
		<th>创建人</th>
		<th>创建时间</th>
		<th>最新更新人</th>
		<th>最新更新时间</th>
		<th>是否维护</th>
      </tr>
   <tbody id="data">
<%
String col_str="*";

sqlstr = "select top "+ intPageSize +" * from vi_invoice_item where id not in( ";
sqlstr += " select top "+ (intPage-1)*intPageSize +" id from vi_invoice_item where 1=1 "+wherestr+" order  by  proj_id,contract_id,begin_id ) "+wherestr ;
sqlstr +=" order  by  proj_id,contract_id,begin_id";

rs = db.executeQuery(sqlstr);
int index_no = 0;
while ( rs.next() ) {
index_no++;
%>   
	
     <tr class="materTr_<%=index_no %>" id="materTr_<%=index_no %>">
		<td align="center"><input type="checkbox" name="checkbos_list" value="<%=getDBStr(rs.getString("id")) %>" 
		contract_id="<%=getDBStr(rs.getString("contract_id"))%>"
		begin_id="<%=getDBStr(rs.getString("begin_id"))%>"
		is_normal="<%=getDBStr(rs.getString("contract_is_normal"))%>"
		is_advance="<%=getDBStr(rs.getString("contract_is_advance"))%>"
		creator="<%=getDBStr(rs.getString("creator"))%>"
		create_date="<%=getDBDateStr(rs.getString("create_date"))%>"
		modificator="<%=getDBStr(rs.getString("modificator"))%>"
		modify_date="<%=getDBDateStr(rs.getString("modify_date"))%>"
		statues="<%=getDBStr(rs.getString("statues"))%>"
		/></td>
		<td align="left"><%=getDBStr(rs.getString("project_name"))%></td>
		<td align="left"><%=getDBStr(rs.getString("contract_id"))%></td>
		<td align="left"><%=getDBStr(rs.getString("begin_id"))%></td>      
		<td align="left"><%=getDBStr(rs.getString("contract_is_normal"))%></td>
		<td align="left"><%=getDBStr(rs.getString("contract_is_advance"))%></td>
		<td align="left"><%=getDBStr(rs.getString("tax_type"))%></td>
		<td align="left"><%=getDBStr(rs.getString("tax_type_invoice"))%></td>
		<td align="left"><%=getDBStr(rs.getString("cust_name"))%></td>
		<td align="left"><%=getDBStr(rs.getString("parent_deptname"))%></td>
        <td align="left"><%=getDBStr(rs.getString("dept_name"))%></td>
        <td align="left"><%=getDBStr(rs.getString("proj_manage_name"))%></td>
		<td align="left"><%=getDBStr(rs.getString("creator"))%></td>
		<td align="left"><%=getDBDateStr(rs.getString("create_date"))%></td>
		<td align="left"><%=getDBStr(rs.getString("modificator"))%></td>
		<td align="left"><%=getDBDateStr(rs.getString("modify_date"))%></td>
		<td align="left"><%=getDBStr(rs.getString("statues"))%></td>
      </tr>
<%}
rs.close();
db.close();
%>     
     </tbody>
</table>
</div>
</form>

</body>
</html>
