<%@ page contentType="text/html; charset=gbk" language="java"  %>
<%@ page import="dbconn.*" %>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" />
<%@ page import="java.sql.*" %>
<%@ include file="../../func/common.jsp"%>
<jsp:useBean id="right" scope="page" class="com.filter.FilterCredit" />
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>费率维护</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script type="text/javascript" src="../../DatePicker/WdatePicker.js"></script>
<script src="../../js/calend.js"></script>
<script type="text/javascript">
//新增操作
function newAdd(){
//alert("join");
//	var str = document.getElementsByName("name")[0].value;
	//弹出窗口进行新增操作
	window.open('tx_fsi_add.jsp?model="add"','央行基准利率新增操作','height=400,width=800,top=200,left=200,toolbar=no,menubar=no,scrollbars=no,resizable=no,location=no,status=no'); 
}
//修改操作
function newMod(){
	var str_key_id;
	var selectedIndex = -1;
    var form1 = document.getElementById("form1");
    var i = 0;
    for (i = 0; i < form1.key_id.length; i++)
    {
        if (form1.key_id[i].checked)
        {
            selectedIndex = i;
            str_key_id = form1.key_id[i].value;
            break;
        }
    }
    if (selectedIndex < 0)
    {
        alert("请先选择需要修改的数据行!");
        return false;
    }
	window.open("tx_fsi_add.jsp?model=mod&key_id="+str_key_id,'央行基准利率修改操作','height=400,width=800,top=200,left=200,toolbar=no,menubar=no,scrollbars=no,resizable=no,location=no,status=no'); 
}



//删除操作
function newDel(){
	var str_key_id;
	var selectedIndex = -1;
    var form1 = document.getElementById("form1");
    var i = 0;
    for (i = 0; i < form1.key_id.length; i++)
    {
        if (form1.key_id[i].checked)
        {
            selectedIndex = i;
            str_key_id = form1.key_id[i].value;
            break;
        }
    }
    alert(str_key_id);
    if (selectedIndex < 0)
    {
        alert("请先选择需要删除的数据行!");
        return false;
    }
	window.open("tx_fsi_add.jsp?model=del&key_id="+str_key_id,'央行基准利率删除操作','height=400,width=800,top=200,left=200,toolbar=no,menubar=no,scrollbars=no,resizable=no,location=no,status=no'); 
}

</script>
</head>
<!-- 公共变量 -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- 公共变量 -->
<body>

<form name="form1" action="insur_rate_list.jsp"  onSubmit="return goPage()">
<input type="hidden" name="na" id="na" >
  <!--标题开始-->
  <table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
    <tr class="tree_title_txt">
      <td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
      	费率维护
      </td>
    </tr>
  </table>
 <%
countSql = "select count(id) as amount from base_insur_rate";
%>
  <!--标题结束-->
  <!--副标题和操作区开始-->
  <table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:2px;">
   <!--     -->
    <tr class="maintab">
      <td align="center" colspan="3">
        <table width="100%" border="0" cellpadding="0" cellspacing="0" >
          <tr class="maintab">
            <td align="left">
           
	              <a href="#" accesskey="n" onClick="dataHander('add','insur_rate_add.jsp?model=add',form1.key_id);">
	              		<img src="../../images/sbtn_new.gif" alt="新增(Alt+N)" width="19" height="19" align="absmiddle">
	              </a>
	      
            	<a href="#" accesskey="m" onClick="dataHander('mod','insur_rate_upd.jsp?model=mod&key_id=',form1.key_id);">
            		<img src="../../images/sbtn_mod.gif" alt="修改(Alt+M)" width="19" height="19" align="absmiddle" >
            	</a>
	      
			   <a href="#" accesskey="d" onClick="dataHander('del','insur_rate_save.jsp?model=del&key_id=',form1.key_id);">
				<img src="../../images/sbtn_del.gif" alt="删除(Alt+D)" width="19" height="19" align="absmiddle" >
				</a>
	        
			</td>
          </tr>
        </table>
        </td>
    </tr>
 
    <tr class="maintab">
      
      <td align="right" width="90%">
	<!-- 翻页控制开始 -->
	<%@ include file="../../public/pageSplit.jsp"%>
	<!--翻页控制结束-->
	  </td>
    </tr>

</table>

  <div style="height=85%;vertical-align:top;width:100%;overflow:auto;position: relative;" id="mydiv";>
    <table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" cellspacing="1" width="100%" hight="100%" class="maintab_content_table" >
      <tr class="maintab_content_table_title">
    
	    <th>操作</th>
	    <th>保险公司</th>
		<th>险种</th>
		<th>1个月</th>
		<th>2个月</th>
		<th>3个月</th>
		<th>4个月</th>
		<th>5个月</th>
		<th>6个月</th>
		<th>7个月</th>
		<th>8个月</th>
		<th>9个月</th>
		<th>10个月</th>
		<th>11个月</th>
		<th>12个月</th>
		<th>年基准费率</th>

      </tr>
<%
	sqlstr="select bir.*,ci.cust_name,icd.title from base_insur_rate bir left join cust_info ci on ci.cust_id=bir.cust_id left join ifelc_conf_dictionary icd on icd.name=bir.insur_type";
	rs=db.executeQuery(sqlstr);
	while(rs.next()){
%>
     <tr>
      	<!-- 针对具体数据行进行修改删除操作  -->
      	<td><input type="radio"  style="border:0" name="key_id" value="<%=getDBStr(rs.getString("id"))%>"/></td>
        <td align="center" nowrap><%= getDBStr(rs.getString("cust_name"))%></td>
		<td align="center" nowrap><%= getDBStr(rs.getString("title"))%></td>
	    <td align="center" nowrap><%= getDBStr(rs.getString("month_1"))%></td>
		<td align="center" nowrap><%= getDBStr(rs.getString("month_2"))%></td>
		<td align="center" nowrap><%= getDBStr(rs.getString("month_3"))%></td>
		<td align="center" nowrap><%= getDBStr(rs.getString("month_4"))%></td>	 	
		<td align="center" nowrap><%= getDBStr(rs.getString("month_5"))%></td>
		<td align="center" nowrap><%= getDBStr(rs.getString("month_6"))%></td>
		<td align="center" nowrap><%= getDBStr(rs.getString("month_7"))%></td>
		<td align="center" nowrap><%= getDBStr(rs.getString("month_8"))%></td>
		<td align="center" nowrap><%= getDBStr(rs.getString("month_9"))%></td>
		<td align="center" nowrap><%= getDBStr(rs.getString("month_10"))%></td>	 	
		<td align="center" nowrap><%= getDBStr(rs.getString("month_11"))%></td>
		<td align="center" nowrap><%= getDBStr(rs.getString("month_12"))%></td>
		<td align="center" nowrap><%= getDBStr(rs.getString("base_year_rate"))%></td>
			
      </tr>
<%		
}
rs.close(); 
db.close();
%>
 </table>
 </div>
  

</form>
</body>
</html>
