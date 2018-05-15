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
<title>调息 - 央行基准利率新增</title>
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
</script>
</head>
<body>
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
		String user_id = (String)session.getAttribute("czyid");//取得登录人的ID 用于取得登录人的name
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");//格式化时间
		String nowDateTime = sdf.format(new Date());//当前格式化之后的时间
		String key_id = getStr(request.getParameter("key_id"));//央行基准利率基准表的主键
		ResultSet rs; 
		//根据登录ID查询登录用户名称
		String user_name = "";
		rs = db.executeQuery(" select name from base_user where id = '"+user_id+"' ");//
		if(rs.next()){
			user_name = getDBStr(rs.getString("name"));
		}
		List<String> list = new ArrayList<String>();
		int flag = 0;
		//String repeat_flag = "";
		//if(key_id.equals("") || key_id == null || model.equals("")){
		//	model = "add";
		//}
		System.out.println("model的值为==>"+model);
		//model不为添加时候所进行的操作
		if(!model.equals("add")){
			System.out.println("JOIN1==>                                              :"+key_id);
			if(model.equals("mod")){//修改前的查询
				String sqlstr = " select * from fund_standard_interest where id = "+key_id+" ";
				rs = db.executeQuery(sqlstr);
				int i = 1;
			 	while(rs.next()){
			 		//循环取值 取该表的前17列，下标从1开始取
			 		for(;i <= 17;i++){
				 		list.add(getDBStr(rs.getString(i)));
			 		}
			 	}
			}else{//删除操作
				System.out.println("JOIN2==>                                              :");
				//修改前查询表fund_adjust_interest_contract对应adjust_id是否存在数据，若存在则不能删除，同添加一样需要判断日期
				String query_faic_sql = " select * from fund_adjust_interest_contract where  adjust_id = '"+key_id+"' ";
				System.out.println("JOIN2==> query_faic_sql: "+query_faic_sql);
				rs = db.executeQuery(query_faic_sql);
				rs.last(); //移到最后一行
				int rowCount = rs.getRow(); //得到当前行号，也就是记录数
				rs.beforeFirst(); //还要用到记录集，就把指针再移到初始化的位置
				if(rowCount > 0){
					flag = 4;//该条调息记录已经关联项目不能删除
					System.out.println("JOIN3==> flag: "+flag);
				}else{
					String sqlstr = " select * from fund_standard_interest where id = "+key_id+" ";
					System.out.println("JOIN3==> sqlstr: "+sqlstr);
					rs = db.executeQuery(sqlstr);
					int i = 1;
				 	while(rs.next()){
				 		//循环取值 取该表的前17列，下标从1开始取
				 		for(;i <= 17;i++){
					 		list.add(getDBStr(rs.getString(i)));
				 		}
				 	}
					//String sql = "delete from fund_standard_interest where id = '"+key_id+"'";
					//flag = db.executeUpdate(sql);
				}
			}
		 	rs.close();
		 	db.close();
		}
%>

<form action="tx_fsi_save.jsp" method="post" target="" onSubmit="return Validator.Validate(this,3);">
<input type="hidden" name="model" id="model" value="<%=model%>">
<input type="hidden" name="key_id" id="key_id" value="<%=key_id%>">
  <!--标题开始-->
<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
	<tr valign="top" class="tree_title_txt">
		<td class="tree_title_txt"  height=26 valign="middle">
			调息 &gt; 央行基准利率调整
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
									<%
										if(!model.equals("del")){
									%>	
									<BUTTON class="btn_2" name="btnSave" value="提交"  type="submit" >
									<img src="../../images/save.gif" align="absmiddle" border="0">提交</button>
									<%
										} else{
									%>
									<BUTTON class="btn_2" name="btnSave" value="删除"  type="submit" >
										<img src="../../images/sbtn_del.gif" align="absmiddle" border="0">删除</button>
									<%
										} 
									%>
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
	if(model.equals("add")){
%>
      <tr>
	    <th>利率开始执行日期</th>
	    <td colspan="">
	    	<input type="text" name="start_date" size="20" dataType="Date" Require="true" value="<%=nowDateTime%>" readonly="readonly"/>
	    	<img  onClick="openCalendar(start_date);return false" style="cursor:pointer; " 
				 src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
			<span class="biTian">*</span>
	    </td>
	    <th>是否调息完成</th>
	    <td>
	    	<select name="adjust_flag" id="adjust_flag">
	    	<script>
					w(mSetOpt("否","否|是","否|是")); 
			</script>
			</select>
	    </td>
	  </tr>
	  <!-- 2012-4-23 Jaffe Open 融资需要半个月 -->
	  <tr>
	    <th>本次调整后央行基础利率6个月</th>
	    <td>
	    	<input type="text" name="base_rate_half" value="0"
	    		dataType="Money" size="20" maxlength="10" maxB="10"  Require="true" />%
			<span class="biTian">*</span>
	    </td>
		<th>本次利息调整幅度6个月</th>
	    <td>
	    	<input type="text" name="rate_half"  value="0"
	    		dataType="Money" size="20" maxlength="10" maxB="10"  Require="true" />%
			<span class="biTian">*</span>
	    </td>
	  </tr>
	   
      <tr>
      	<th>本次调整后央行基础利率1年</th>
	    <td>
	    	<input type="text" name="base_rate_one" value="0"
	    		dataType="Money" size="20" maxlength="10" maxB="10"  Require="true" />%
			<span class="biTian">*</span>
	    </td>
		<th>本次利息调整幅度1年</th>
	    <td>
	    	<input type="text" name="rate_one" value="0"
	    		dataType="Money" size="20" maxlength="10" maxB="10"  Require="true" />%
			<span class="biTian">*</span>
	    </td>
	  </tr>
	  <tr>
	    <th>本次调整后央行基础利率1至3年</th>
	    <td>
	    	<input type="text" name="base_rate_three" value="0"
	    		dataType="Money" size="20" maxlength="10" maxB="10"  Require="true" />%
			<span class="biTian">*</span>
	    </td>
		<th>本次利息调整幅度1至3年</th>
	    <td>
	    	<input type="text" name="rate_three" value="0"
	    		dataType="Money" size="20" maxlength="10" maxB="10"  Require="true" />%
			<span class="biTian">*</span>
	    </td>
	</tr>
    <tr>  
		<th>本次调整后央行基础利率3至5年</th>
	    <td>
	    	<input type="text" name="base_rate_five" value="0"
	    		dataType="Money" size="20" maxlength="10" maxB="10"  Require="true" />%
			<span class="biTian">*</span>
	    </td>
		<th>本次利息调整幅度3至5年</th>
	    <td>
	    	<input type="text" name="rate_five" value="0"
	    		dataType="Money" size="20" maxlength="10" maxB="10"  Require="true" />%
			<span class="biTian">*</span>
	    </td>
	</tr>
	<tr>
	    <th>本次调整后央行基础利率5年以上</th>
	    <td >
	    	<input type="text" name="base_rate_abovefive"  value="0"
	    		dataType="Money" size="20" maxlength="10" maxB="10"  Require="true" />%
			<span class="biTian">*</span>
	    </td>
		<th>本次利息调整幅度5年以上</th>
	    <td>
	    	<input type="text" name="rate_abovefive" value="0"
	    		dataType="Money" size="20" maxlength="10" maxB="10"  Require="true" />%
			<span class="biTian">*</span>
	    	<!-- 登记人  -->
	    	<input type="hidden" name="creator" value="<%=user_name%>" />
			<!-- 登记时间 -->
	    	<input type="hidden" name="create_date"  value="<%=nowDateTime%>" />
	    	<!-- 更新人 -->
	    	<input type="hidden" name="modificator"   value="" />
	    	<!-- 更新时间  -->
	    	<input type="hidden" name="modify_date" value=""/>
	    </td>
	 </tr>
<%
	}else if(model.equals("mod")){//注意修改时‘登记人’和‘登记时间’是不能修改的
%>
      <tr>
	    <th>利率开始执行日期</th>
	    <td colspan="">
	    	<input type="text" name="start_date" size="20" dataType="Date" Require="true" value="<%=getDBDateStr(list.get(1))%>" readonly="readonly"/>
	    	<!-- 
	    	<img  onClick="openCalendar(start_date);return false" style="cursor:pointer; " 
				 src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
	    	 -->
	    </td>
	    <th>是否调息完成</th>
	    <td>
	    	<select name="adjust_flag" id="adjust_flag">
	    	<script>
					w(mSetOpt("<%=list.get(12)%>","否|是","否|是")); 
			</script>
			</select>
	    </td>
	  </tr>
	  <!-- 
	  <tr>
	    <th>本次调整后央行基础利率6个月</th>
	    <td>
	    	<input type="text" name="base_rate_half" size="20" 
	    		   dataType="Money" Require="true" value="<%=formatNumberDoubleTwo(list.get(7))%>" readonly="readonly"/>%
	    </td>
		<th>本次利息调整幅度6个月</th>
	    <td>
	    	<input type="text" name="rate_half" size="20" 
	    		   dataType="Money" Require="true" value="<%=formatNumberDoubleTwo(list.get(2))%>" readonly="readonly"/>%
	    </td>
	  </tr>
	   -->
      <tr>
        <th>本次调整后央行基础利率1年</th>
	    <td>
	    	<input type="text" name="base_rate_one" size="20" 
	    		   dataType="Money" Require="true" value="<%=formatNumberDoubleTwo(list.get(8))%>" readonly="readonly"/>%
	    </td>
		<th>本次利息调整幅度1年</th>
	    <td>
	    	<input type="text" name="rate_one" size="20" 
	    		   dataType="Money" Require="true" value="<%=formatNumberDoubleTwo(list.get(3))%>" readonly="readonly"/>%
	    </td>
	 </tr>
	 <tr>
	    <th>本次调整后央行基础利率1至3年</th>
	    <td>
	    	<input type="text" name="base_rate_three" size="20"
	    		   dataType="Money" Require="true" value="<%=formatNumberDoubleTwo(list.get(9))%>" readonly="readonly"/>%
	    </td>
		<th>本次利息调整幅度1至3年</th>
	    <td>
	    	<input type="text" name="rate_three" size="20" 
	    		   dataType="Money" Require="true" value="<%=formatNumberDoubleTwo(list.get(4))%>" readonly="readonly"/>%
	    </td>
	</tr>
    <tr>
    	<th>本次调整后央行基础利率3至5年</th>
	    <td>
	    	<input type="text" name="base_rate_five" size="20" onkeyup="value=value.replace(/[^\u4E00-\u9FA5^a-z^A-Z^0-9]/g,'') 
	    		   dataType="Money" Require="true" value="<%=formatNumberDoubleTwo(list.get(10))%>" readonly="readonly"/>%
	    </td>  
		<th>本次利息调整幅度3至5年</th>
	    <td>
	    	<input type="text" name="rate_five" size="20" 
	    		   dataType="Money" Require="true" value="<%=formatNumberDoubleTwo(list.get(5))%>" readonly="readonly"/>%
	    </td>
	</tr>
	<tr>
	    <th>本次调整后央行基础利率5年以上</th>
	    <td >
	    	<input type="text" name="base_rate_abovefive" size="20"
	    		   dataType="Money" Require="true" value="<%=formatNumberDoubleTwo(list.get(11))%>" readonly="readonly"/>%
	    </td>
		<th>本次利息调整幅度5年以上</th>
	    <td>
	    	<input type="text" name="rate_abovefive" size="20" 
	    		   dataType="Money" Require="true" value="<%=formatNumberDoubleTwo(list.get(6))%>" readonly="readonly"/>%
	    	<!-- 登记人  -->
	    	<input type="hidden" name="creator" value="<%=getDBStr(list.get(13))%>" />
			<!-- 登记时间 -->
	    	<input type="hidden" name="create_date"  value="<%=getDBDateStr(list.get(14))%>" />
	    	<!-- 更新人 -->
	    	<input type="hidden" name="modificator"   value="<%=user_name%>" />
	    	<!-- 更新时间  -->
	    	<input type="hidden" name="modify_date" value="<%=nowDateTime%>"/>
	    </td>
	  </tr>    
<%
	}else{//删除处理
		String mesg = "";
			if(flag == 4){
				mesg = "该条调息记录已经关联项目不能删除!";
%>
					<script type="text/javascript">
						alert("<%=mesg%>");
						opener.location.reload();
						window.close();
					</script>
<%
			}else{
%>
	<tr>
	    <th>利率开始执行日期</th>
	    <td colspan=""> <%=getDBDateStr(list.get(1))%> </td>
	    <th>是否调息完成</th>
	    <td><%=getDBStr(list.get(16))%></td>
	</tr>
	<tr>
	    <th>本次调整后央行基础利率6个月</th>
	    <td> <%=formatNumberDoubleTwo(list.get(7))%>% </td>
		<th>本次利息调整幅度6个月</th>
	    <td> <%=formatNumberDoubleTwo(list.get(2))%>% </td>
	</tr>
    <tr>
      	<th>本次调整后央行基础利率1年</th>
	    <td> <%=formatNumberDoubleTwo(list.get(8))%>% </td>
		<th>本次利息调整幅度1年</th>
	    <td> <%=formatNumberDoubleTwo(list.get(3))%>% </td>
    </tr>
    <tr>
	    <th>本次调整后央行基础利率1至3年</th>
	    <td> <%=formatNumberDoubleTwo(list.get(9))%>% </td>
		<th>本次利息调整幅度1至3年</th>
	    <td> <%=formatNumberDoubleTwo(list.get(4))%>% </td>
	</tr>
    <tr>  
    	<th>本次调整后央行基础利率3至5年</th>
	    <td> <%=formatNumberDoubleTwo(list.get(10))%>% </td>
		<th>本次利息调整幅度3至5年</th>
	    <td> <%=formatNumberDoubleTwo(list.get(5))%>% </td>
	</tr>
    <tr>  
	    <th>本次调整后央行基础利率5年以上</th>
	    <td> <%=formatNumberDoubleTwo(list.get(11))%>% </td>
		<th>本次利息调整幅度5年以上</th>
	    <td> <%=formatNumberDoubleTwo(list.get(6))%>% </td>
	</tr>
<%		
	  }
	}
%>
    </table>
</div>
</div>
</td></tr></table>
</form>
</body>
</html>
