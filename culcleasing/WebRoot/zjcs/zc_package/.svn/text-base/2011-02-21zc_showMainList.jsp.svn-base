<%@ page contentType="text/html; charset=gbk" language="java"  %>
<%@ page import="dbconn.*" %>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" />
<%@ page import="java.sql.*" %>
<%@page import="com.condition.ZC_Package"%>
<%@ include file="../../func/common.jsp"%>
<jsp:useBean id="right" scope="page" class="com.filter.FilterCredit" />
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>资产打包 - 首页</title>
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
   // var siz = document.getElementsByName('key_id').length;
    //var len = form1.key_id.length;
  // alert(form1.key_id.length);

	    for (var i = 0; i < form1.key_id.length; i++)//form1.key_id.length
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
        alert("请先选择需要删除的数据行!");
        return false;
    }
    form1.action = "zc_executeDB.jsp?model=del&zc_num="+str_key_id;
    form1.target = "_blank";
    form1.method = "post";
    form1.submit();
	//window.open("tx_fsi_add.jsp?model=del&key_id="+str_key_id,'央行基准利率删除操作','height=400,width=800,top=200,left=200,toolbar=no,menubar=no,scrollbars=no,resizable=no,location=no,status=no'); 
}

</script>
</head>
<body>
<%
	//权限处理  取得登录人的ID
	String dqczy =  "ADMN-857CHJ";//(String) session.getAttribute("czyid");//ADMN-857CHJ  资产管理部   计划财务部 ADMN-857CH2
	
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
	
	//if ((dqczy == null) || (dqczy.equals("")))
	//{
	//  dqczy = "无认证";
	//  response.sendRedirect("../../noright.jsp");
	//}
	//int canedit=0;
	//if (right.CheckRight("zjcs-tx-list",dqczy) > 0) canedit=1;
	//if (canedit == 0) response.sendRedirect("../../noright.jsp");
%>

<%
	String str = "";
	ResultSet rs;
	String wherestr = " where 1=1 ";
	//资产包 表
	String sqlstr = " select * from fund_Assets_Package  order by caertor_date desc"; 
%>
<form name="form1" action="tx_showMainList.jsp"  onSubmit="return goPage()">

  <!--标题开始-->
  <table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
    <tr class="tree_title_txt">
      <td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
      	资产打包 &gt; 资产包列表
      </td>
    </tr>
  </table>
  <!--标题结束-->
  <!--副标题和操作区开始-->
  <table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:2px;">
   <!--     -->
    <tr class="maintab">
      <td align="center" colspan="2">
        <table width="100%" border="0" cellpadding="0" cellspacing="0" >
          <tr class="maintab">
            <td align="left">
            <!-- 权限控制 -->
            <% if(!qx_value.equals("2")){ %>
	              <a href="#" accesskey="n" onClick="dataHander('add','zc_list.jsp?model=add',form1.Zc_num);">
	              		<img src="../../images/sbtn_new.gif" alt="新增(Alt+N)" width="19" height="19" align="absmiddle">
	              </a>
	        <% } %>
            <%//if (right.CheckRight("zjcs-tx-mod",dqczy)>0){ %>
            <!-- 
            	<a href="#" accesskey="m" onClick="dataHander('mod','tx_fsi_add.jsp?model=mod&key_id=',form1.Zc_num);">
            		<img src="../../images/sbtn_mod.gif" alt="修改(Alt+M)" width="19" height="19" align="absmiddle" >
            	</a>
             -->
	        <% //}%>
            <%if(!qx_value.equals("2")){ %>
			   <a href="#" accesskey="d" onClick="newDel()">
				<img src="../../images/sbtn_del.gif" alt="删除(Alt+D)" width="19" height="19" align="absmiddle" >
				</a>
	        <% }%>
			</td>
          </tr>
        </table>
        </td>
    </tr>
 
    <tr class="maintab">
      <td align="center" width="1%">
        <table border="0" cellspacing="0" cellpadding="0" >
        </table>
	  </td>
      <td align="right" width="90%">
 <!--翻页控制开始-->
<% 
	int intPageSize = 15;   //一页显示的记录数
	int intRowCount = 0;   //记录总数
	int intPageCount = 1; //总页数
	int intPage;       //待显示页码
	String strPage = getStr(request.getParameter("page") );          //取得待显示页码
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
		var nf = document.form1;
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

<!--翻页控制结束 style="vertical-align:top;width:100%;overflow:auto;position: relative;" -->
  <div style="height=85%;vertical-align:top;width:100%;overflow:auto;position: relative;" id="mydiv";>
    <table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" cellspacing="1" width="100%" hight="100%" class="maintab_content_table" >
      <tr class="maintab_content_table_title">
	    <th>选择</th>
		<th>资产包编号</th>
		<th>承租人</th>
		<th>状态</th>
		<th>操作信息</th>
		<th>发票管理</th>
		<th>创建人</th>
		<th>创建日期</th>
		<input type="radio" name="key_id"   style="display:none">
      </tr>

<%	  if ( intRowCount>0 ) {
	  ZC_Package zc_Package = new ZC_Package();	
	while( i < intPageSize && !rs.isAfterLast() ) {
%>
      <tr>
      	<!-- 针对具体数据行进行修改删除操作  -->
      	<td><input type="radio"  style="border:0" name="key_id" id='key_id' value="<%=getDBStr(rs.getString("Zc_num"))%>"/></td>
		<td align="center" nowrap>
			<a href="zc_showAll.jsp?Zc_num=<%=getDBStr(rs.getString("Zc_num"))%>&UserName=<%=getDBStr(rs.getString("UserName"))%>&status=<%=getDBStr(rs.getString("status"))%>" target="_blank" >
				<%= getDBStr(rs.getString("Zc_num"))%>
			</a>
		</td>
		<td align="center" nowrap><%= getDBStr(rs.getString("UserName"))%></td>
		<td align="center" nowrap><%= getDBStr(rs.getString("status"))%></td>
		<td align="center" nowrap>
		<% 
			//根据资产编号统计对应资产编号的偿还计划的租金总和 以及 发票表中已开租金总额 
			//情况1：二者比较：相等，并且资产包表中的状态为：待提交 则显示‘提交审核’按钮，将资产包表中的状态改为‘待审核’
			//情况2：资产编号对应的发票表中的‘发票编号Fp_num’不为空 资产包不允许删除，并且资产包表中的状态为：待审核 则显示‘审核完毕’按钮 点击状态改为‘审核完毕‘
			String Zc_num = getDBStr(rs.getString("Zc_num"));
			List<String> list_rent_jx = zc_Package.querySumMoney(Zc_num);
			String sum_rent_jx = list_rent_jx.get(0);
			List<String> list_rent_fp = zc_Package.querySumMoney_Fp(Zc_num);
			String sum_rent_fp = list_rent_fp.get(0);
			double yk_Fp_rate = Double.valueOf(list_rent_fp.get(3));//已开的发票
			System.out.println(yk_Fp_rate < Double.valueOf("100"));
			
			String status = getDBStr(rs.getString("status"));//资产包状态
			boolean flag = zc_Package.queryFpNum(Zc_num);//发票编号是否存在
			//System.out.println("sum_rent_fp==>"+sum_rent_fp);
			//System.out.println("sum_rent_jx==>"+sum_rent_jx);
			System.out.println("status==>"+status);
			System.out.println("发票编号是否存在flag==>"+flag);
			//System.out.println("待提交.equals(status)==>"+"待提交".equals(status));
			System.out.println("qx_value==>"+qx_value);
			String status_tem = "";
			if("待提交".equals(status) && (sum_rent_jx.equals(sum_rent_fp)) && !qx_value.equals("2")){//资产包状态为‘待提交’并且发票金额相等 并且权限为‘资产管理部’才能进行审核操作
			   status_tem = "提交审核";
		%>
        	<a href="fp_add.jsp?Zc_num=<%=getDBStr(rs.getString("Zc_num"))%>&UserName=<%=getDBStr(rs.getString("UserName"))%>&model=tjshenhe" target="_blank">
        		提交审核
        	</a>
		<%  
			}
			else if(flag == true && "待审核".equals(status) && !qx_value.equals("2")){//发票号存在并且资产包状态为待审核 
			   status_tem = "审核";
			//审核完毕
		%>
        	<a href="fp_add.jsp?Zc_num=<%=getDBStr(rs.getString("Zc_num"))%>&UserName=<%=getDBStr(rs.getString("UserName"))%>&model=shenheOk" target="_blank">
        		审核
        	</a>
		<%  }else{ 
				if(!"待审核".equals(status) && !"审核完毕".equals(status) && yk_Fp_rate < Double.valueOf("100")){//资产包状态不为‘待审核’并且不为‘审核完毕’并且已开发票比例小于100
					   status_tem = "发票暂不完整";
		%>
			   		发票暂不完整请添加
		<%     }
				else if(flag == false && yk_Fp_rate == Double.valueOf("100")){//发票号不完整  
					   status_tem = "发票号不完整";
		%>
					发票号不完整请添加
		<%
				}
				else if("审核完毕".equals(status)){
					   status_tem = "审核完毕";
		%>
					发票审核完毕
		<%
				}
		    } 
		%>
		</td>
		<td align="center" nowrap>
        	<a href="fp_showMainList.jsp?Zc_num=<%=getDBStr(rs.getString("Zc_num"))%>&Fp_tt=<%=getDBStr(rs.getString("UserName"))%>&status_tem=<%=status_tem%>" target="_blank">
        		发票管理
        	</a>
        </td>	
        <td align="center" nowrap><%= getDBStr(rs.getString("caertor"))%></td>			
        <td align="center" nowrap><%= getDBDateStr(rs.getString("caertor_date"))%></td>			
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
  

</form>
</body>
</html>
