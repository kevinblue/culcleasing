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
<title>资产包 - 新增</title>
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
		String key_id = getStr(request.getParameter("key_id"));// 主键
		ResultSet rs; 
		//根据登录ID查询登录用户名称
		String user_name = "";
		rs = db.executeQuery(" select name from base_user where id = '"+user_id+"' ");//
		if(rs.next()){
			user_name = getDBStr(rs.getString("name"));
		}
		List<String> list = new ArrayList<String>();
		int flag = 0;
		System.out.println("model的值为==>"+model);
		
		rs.close();
		db.close();
%>

<body style="overflow:auto;"> 
<div style="vertical-align:top;width:100%;overflow:auto;position: relative; left: 0px; top: 0px"  id="mydiv";>
    	<div id="tabletit" class="tabtitexp">&nbsp; 
    		资产包所需租金计划 
    	</div>  
	    <div>
			<iframe frameborder="0" name="con" width="100%" height="430" 
				src="zjcs_proj_add.jsp?proj_id=<%=proj_id%>&model=<%=model%>&doc_id=<%=doc_id%>">
			</iframe>
		</div>
    	<div id="tabletit" class="tabtitexp">&nbsp; 
    		租金偿还计划 
    	</div>  
    	<div id="tablesub">
			<iframe frameborder="0" name="rentplan" width="100%" height="1000" 
			src="zics_div_list.jsp?proj_id=<%=proj_id%>&doc_id=<%=doc_id%>&plan_irr=<%=plan_irr%>&market_irr=<%=market_irr%>&measure_type=<%=measure_type %>">
			</iframe>
		</div>
</div>
</body>
</html>
