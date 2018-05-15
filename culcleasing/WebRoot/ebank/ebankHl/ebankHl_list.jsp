<%@ page contentType="text/html; charset=gbk" language="java"  %>
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<jsp:useBean id="db1" scope="page" class="dbconn.Conn" />
<jsp:useBean id="db2" scope="page" class="dbconn.Conn" />
<jsp:useBean id="right" scope="page" class="com.filter.FilterCredit" /> 
<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common.jsp"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>网银核销处理 - 网银核销列表</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
</head>

<body  onload="public_onload(0);">
<form action="ebankHl_list.jsp" name="searchbar" onSubmit="return goPage()">
<!--标题开始-->
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
			<tr class="tree_title_txt">
				<td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
				网银核销处理 &gt; 网银核销列表</td>
			</tr>
</table>
<!--标题结束-->

<!--副标题和操作区开始-->

<table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:2px;">
			<tr class="maintab">
				<td align="left" width="1%">
					 
					 <%
String dqczy=(String) session.getAttribute("czyid");
if ((dqczy==null) || (dqczy.equals("")))
{
  dqczy="无认证";
  response.sendRedirect("../../noright.jsp");
}

int canedit=0;
if (right.CheckRight("ebank-ebankHl-list",dqczy)>0) canedit=1;
if (canedit==0) response.sendRedirect("../../noright.jsp");

//----------以上为权限控制--------
String sqlstr;
ResultSet rs;
ResultSet rs1;
ResultSet rs2;
String wherestr = " where 1=1 and vi_ebank_remMoney.ebank_money>0 and fund_ebank_data.status='有效' and fund_ebank_data.business_flag='是'";

String searchFld = getStr( request.getParameter("searchFld") );
String searchKey = getStr( request.getParameter("searchKey") );
String fact_money_start=getStr( request.getParameter("fact_money_start") );
String fact_money_end=getStr( request.getParameter("fact_money_end") );

//domino前缀
String pre_url="http://leasing.utfinancing.com";

if ( !searchFld.equals("") && !searchKey.equals("") ) {
	wherestr = wherestr + " and " + searchFld + " like '%" + searchKey + "%'";
}
if (!fact_money_start.equals("")) {
	wherestr = wherestr + " and fund_ebank_data.fact_money>="+fact_money_start;
}
if (!fact_money_end.equals("")) {
	wherestr = wherestr + " and fund_ebank_data.fact_money<="+fact_money_end;
}

String contract_id="";	//合同编号
String contract_id_br="";	//合同编号
String contract_id_show="";	//提醒合同编号列表
String contract_id_sql="";	//in 合同编号集合
String contract_id_show_tmp="";	//提醒合同编号列表_tmp
String contract_id_sql_tmp="";	//in 合同编号集合_tmp
String client_name="";	//客户名称
String client_accnumber="";	//客户帐号
String arrive_date="";	//到帐日期
String fact_money="";	//到帐金额
String badRent="";	//逾期金额
String end_flag="";	//判断结束标志
String adjust_flag="";	//金额匹配是否成功标志
String process_info="";	//网银在执行流程描述
String proj_id="";	//起流程时定义参数名称
String cust_id="";	//起流程时定义参数名称
String cust_name="";	//起流程时定义参数名称
String flow_income="租金回笼流程";	//起流程时定义参数名称
sqlstr = "select isnull(vi_ebank_remMoney.ebank_money,0) as remEbankMoney,fund_ebank_data.ebdata_id, fund_ebank_data.contract_id, fund_ebank_data.order_number, fund_ebank_data.arrive_date, fund_ebank_data.account_bank, fund_ebank_data.acc_number, fund_ebank_data.client_name, fund_ebank_data.client_accnumber, isnull(fund_ebank_data.fact_money,0) as fact_money_show, isnull(dbo.bb_getRemEbankMoney(fund_ebank_data.ebdata_id),0) as fact_money, fund_ebank_data.summary, fund_ebank_data.sn, fund_ebank_data.status, fund_ebank_data.business_flag from fund_ebank_data left join vi_ebank_remMoney on fund_ebank_data.ebdata_id=vi_ebank_remMoney.ebank_id" + wherestr; 
System.out.println("sqlstr=================="+sqlstr);
%>



<!--操作按钮开始-->
<table border="0" cellspacing="0" cellpadding="0" >    
    <tr class="maintab">
	    <td nowrap>&nbsp;按&nbsp;<select name="searchFld"><script>w(mSetOpt("<%= searchFld %>","|网银编号|到帐日期|上传日期|合同编号|到帐银行|付款客户|客户帐号","|fund_ebank_data.ebdata_id|convert(varchar(10),fund_ebank_data.arrive_date,121)|convert(varchar(10),fund_ebank_data.upload_date,121)|fund_ebank_data.contract_id|fund_ebank_data.account_bank|fund_ebank_data.client_name|fund_ebank_data.client_accnumber"));</script></select>&nbsp;查询&nbsp;<input name="searchKey" accesskey="s" type="text" size="15" value="<%= searchKey %>">
		金额：从<input name="fact_money_start" type="text" size="10" value="<%= fact_money_start%>">到<input name="fact_money_end" type="text" size="10" value="<%= fact_money_end%>">
    	<input name="image" type="image" src="../../images/tbtn_searh.gif" alt="查询" align="absmiddle"  onclick="searchbar.submit();">
		
		</td>
	</tr>
</table>
<!--操作按钮结束-->
</td>
					 <td align="right" width="90%">
					 	
					 	
<!--翻页控制开始-->


<% 
int intPageSize = 50;   //一页显示的记录数
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
		var nf = document.forms[0];
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
</form>
</table>

<!--翻页控制结束-->






<!--报表开始-->

<div style="vertical-align:top;width:100%;overflow:auto;position: relative;"  id="mydiv";>

   <table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" cellspacing="1" width="100%" class="maintab_content_table" >
      <tr class="maintab_content_table_title">
		<th>网银编号</th>
		<th>合同编号</th>
        <th>序号</th>
        <th>到帐时间</th>
        <th>到帐银行</th>
        <th>到帐帐号</th>
        <th>付款客户</th>
        <th>客户帐号</th>
        <th>金额</th>
        <th>摘要</th>
        <th>流水号</th>
        <th>可核销金额</th>
        <th>网银在执行流程</th>
        <th>合同编号</th>
        <th>启动回笼流程</th>
        <th>启动收款流程</th>
      </tr>
  

<%	  
rs.previous();
if ( rs.next() ) {
	while( i < intPageSize && !rs.isAfterLast() ) {
	end_flag="0";
	contract_id=getDBStr( rs.getString("contract_id") );
	client_accnumber=getDBStr( rs.getString("client_accnumber") );
	client_name=getDBStr( rs.getString("client_name") );
	arrive_date=getDBDateStr( rs.getString("arrive_date") );
	fact_money=getDBStr( rs.getString("fact_money") );
	contract_id_show="";
	contract_id_sql="";
	contract_id_show_tmp="";
	contract_id_sql_tmp="";
	process_info="";
	sqlstr="select contract_id,process_name,start_date,isnull(process_amount,0) as process_amount from fund_ebank_process where ebdata_id='"+getDBStr( rs.getString("ebdata_id") )+"'";
	rs1=db1.executeQuery(sqlstr);
	while(rs1.next()){
		process_info+=getDBStr( rs1.getString("contract_id") );
		process_info+=" 流程："+getDBStr( rs1.getString("process_name") );
		process_info+=" 开始日期："+getDBDateStr( rs1.getString("start_date") );
		process_info+=" 金额："+formatNumberStr(getDBStr( rs1.getString("process_amount") ),"#,##0.00");
		process_info+="<br>";
	}rs1.close();
	
	if(!contract_id.equals("")){	//合同编号匹配
		end_flag="1";
		contract_id_show=contract_id;
		contract_id_sql="('"+contract_id+"')";
	}
	if(end_flag.equals("0")){	//客户帐号匹配
		if(!client_accnumber.equals("")){
			sqlstr="select contract_id from ebank_pp where create_date='"+arrive_date+"' and acc_number like '%"+client_accnumber+"%'";
			System.out.println("sqlstr000==================================="+sqlstr);
			rs1=db1.executeQuery(sqlstr);
			while(rs1.next()){
				end_flag="1";
				contract_id=getDBStr( rs1.getString("contract_id") );
				contract_id_show_tmp+=contract_id+",";
				contract_id_sql_tmp+="'"+contract_id+"',";
				sqlstr="select * from ebank_pp where create_date='"+arrive_date+"' and contract_id='"+contract_id+"' and ebank_money="+fact_money;
				rs2=db2.executeQuery(sqlstr);
				if(rs2.next()){
						contract_id_show+=contract_id+",";
						contract_id_sql+="'"+contract_id+"',";
				}rs2.close();
			}rs1.close();
			if(contract_id_show.equals("")){
				contract_id_show=contract_id_show_tmp;
				contract_id_sql=contract_id_sql_tmp;
			}
			if(contract_id_show.length()>0){
				contract_id_show=contract_id_show.substring(0,contract_id_show.length()-1);
				contract_id_sql="("+contract_id_sql.substring(0,contract_id_sql.length()-1)+")";
			}
		}
	}
	
	if(end_flag.equals("0")){	//客户名称匹配
		if(!client_name.equals("")){
			sqlstr="select contract_id from ebank_pp where create_date='"+arrive_date+"' and cust_name like '%"+client_name+"%'";
			System.out.println("sqlstr001==================================="+sqlstr);
			rs1=db1.executeQuery(sqlstr);
			while(rs1.next()){
				end_flag="1";
				contract_id=getDBStr( rs1.getString("contract_id") );
				contract_id_show_tmp+=contract_id+",";
				contract_id_sql_tmp+="'"+contract_id+"',";
				sqlstr="select * from ebank_pp where create_date='"+arrive_date+"' and contract_id='"+contract_id+"' and ebank_money="+fact_money;
				rs2=db2.executeQuery(sqlstr);
				if(rs2.next()){
						contract_id_show+=contract_id+",";
						contract_id_sql+="'"+contract_id+"',";
				}rs2.close();
			}rs1.close();
			if(contract_id_show.equals("")){
				contract_id_show=contract_id_show_tmp;
				contract_id_sql=contract_id_sql_tmp;
			}
			if(contract_id_show.length()>0){
				contract_id_show=contract_id_show.substring(0,contract_id_show.length()-1);
				contract_id_sql="("+contract_id_sql.substring(0,contract_id_sql.length()-1)+")";
			}
		}
	}
	
	if(end_flag.equals("0")){	//金额匹配
		
		sqlstr="select contract_id from ebank_pp where create_date='"+arrive_date+"' and ebank_money="+fact_money;
		System.out.println("sqlstr002==================================="+sqlstr);
		rs1=db1.executeQuery(sqlstr);
		while(rs1.next()){
			end_flag="1";
			contract_id=getDBStr( rs1.getString("contract_id") );
			contract_id_show+=contract_id+",";
			contract_id_sql+="'"+contract_id+"',";
		}rs1.close();
		if(contract_id_show.length()>0){
			contract_id_show=contract_id_show.substring(0,contract_id_show.length()-1);
			contract_id_sql="("+contract_id_sql.substring(0,contract_id_sql.length()-1)+")";
		}else{
			contract_id_sql="('')";
		}
	}
	contract_id_br=contract_id_show.replaceAll(",","<br>");
%>

      <tr>
        <td><%= getDBStr(rs.getString("ebdata_id") ) %></td> 	
        <td><%= getDBStr( rs.getString("contract_id") ) %></td> 
		<td><%= getDBStr( rs.getString("order_number") ) %></td>
		<td><%= getDBDateStr( rs.getString("arrive_date") ) %></td> 	 	
		<td><%= getDBStr( rs.getString("account_bank") ) %></td>
		<td><%= getDBStr( rs.getString("acc_number") ) %></td> 	 	
		<td><%= getDBStr( rs.getString("client_name") ) %></td>
		<td><%= getDBStr( rs.getString("client_accnumber") ) %></td> 	
		<td align="right"><%= formatNumberStr(getDBStr( rs.getString("fact_money_show") ),"#,##0.00") %></td>
		<td><%= getDBStr( rs.getString("summary") ) %></td> 
		<td><%= getDBStr( rs.getString("sn") ) %></td>
		<td align="right"><%= formatNumberStr(getDBStr( rs.getString("remEbankMoney") ),"#,##0.00") %></td>
		<td><%= process_info %></td>
		<td><a href="ebankHl.jsp?arrive_date=<%= arrive_date %>&contract_id_show=<%= contract_id_show %>" target="_blank"><%= contract_id_br %></a></td> 
		<%
			if(contract_id_show.indexOf(",")>0 || contract_id_show.length()==0){
		 %>
		<td><a href="<%=pre_url%>/ELeasing/ProjectWF/ProjectEHire.nsf/NWorkFlowNewSelect5?OpenForm&ebdataid=<%= getDBStr(rs.getString("ebdata_id") ) %>&contractid=&projectNo=&custid=&cust_name=&flow=<%= flow_income %>" target="_blank">回笼流程</a></td> 	 	 	
		<td><select name="flow_income<%=i %>"><script>w(mSetOpt("",'收款流程|解约收款流程|提前还款收款流程|回购收款流程|总对总客户收款流程'));</script></select>
		<BUTTON class="btn_2" name="btnSave" value="启动"  type="button" name="button<%=i %>" onclick="fun_save(<%=i %>)">
		<img src="../../images/save.gif" align="absmiddle" border="0" >启动</button>
		<input name="hidden<%=i %>" type="hidden" value="ebdataid=<%= getDBStr(rs.getString("ebdata_id") ) %>&contractid=&projectNo=&custid=&cust_name=">
		</td> 	 	 		 	 	
		<%
			}else{
			proj_id="";
			cust_id="";
			cust_name="";
			sqlstr="select proj_id,cust_id,cust_name from vi_contract_info where contract_id='"+contract_id_show+"'";
			rs1=db1.executeQuery(sqlstr);
			if(rs1.next()){
				proj_id=getDBStr(rs1.getString("proj_id") );
				cust_id=getDBStr(rs1.getString("cust_id") );
				cust_name=getDBStr(rs1.getString("cust_name") );
			}rs1.close();
		 %>
		<td><a href="<%=pre_url%>/ELeasing/ProjectWF/ProjectEHire.nsf/NWorkFlowNewSelect5?OpenForm&ebdataid=<%= getDBStr(rs.getString("ebdata_id") ) %>&contractid=<%=contract_id_show %>&projectNo=<%=proj_id %>&custid=<%=cust_id %>&cust_name=<%=cust_name %>&flow=<%= flow_income %>" target="_blank">回笼流程</a></td> 	 	 	
		<td><select name="flow_income<%=i %>"><script>w(mSetOpt("",'收款流程|解约收款流程|提前还款收款流程|回购收款流程|总对总客户收款流程'));</script></select>
		<BUTTON class="btn_2" name="btnSave" value="启动"  type="button" name="button<%=i %>" onclick="fun_save(<%=i %>)">
		<img src="../../images/save.gif" align="absmiddle" border="0" >启动</button>
		<input name="hidden<%=i %>" type="hidden" value="ebdataid=<%= getDBStr(rs.getString("ebdata_id") ) %>&contractid=<%=contract_id_show %>&projectNo=<%=proj_id %>&custid=<%=cust_id %>&cust_name=<%=cust_name %>">
		</td> 	 	
		<%
			}
		 %>
      </tr>
<%
		rs.next();
		i++;
	}
}
rs.close(); 
db.close();
db1.close();
db2.close();
%>
    </table>
</div>

<!--报表结束-->

</body>
</html>
<script language="javascript">
function fun_save(obj){
	var url;
	var flow_income;
	var hidden;
	flow_income=document.getElementById("flow_income"+obj).value;
	hidden=document.getElementById("hidden"+obj).value;
	if(flow_income=="总对总客户收款流程"){
		url="<%=pre_url%>/ELeasing/ProjectWF/ProjectDFund.nsf/NWorkFlowNewSelect6?openform&flow=总对总客户收款流程&"+hidden;
	}else if(flow_income=="收款流程"){
		url="<%=pre_url%>/ELeasing/ProjectWF/ProjectDFund.nsf/NWorkFlowNewSelect5?openform&flow=收款流程&"+hidden;
	}else if(flow_income=="解约收款流程"){
		url="<%=pre_url%>/ELeasing/ProjectWF/ProjectDFund.nsf/NWorkFlowNewSelect5?openform&flow=解约收款流程&"+hidden;
	}else if(flow_income=="提前还款收款流程"){
		url="<%=pre_url%>/ELeasing/ProjectWF/ProjectDFund.nsf/NWorkFlowNewSelect5?openform&flow=提前还款收款流程&"+hidden;
	}else if(flow_income=="回购收款流程"){
		url="<%=pre_url%>/ELeasing/ProjectWF/ProjectDFund.nsf/NWorkFlowNewSelect5?openform&flow=回购收款流程&"+hidden;
	}else{}
	//alert(url);
	open(url,'','toolbar=no,location=no,directories=no,status=yes,menub ar=no,scrollbar=no,resizable=yes,copyhistory=no');
}
</script>