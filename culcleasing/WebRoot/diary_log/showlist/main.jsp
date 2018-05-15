<%@ page contentType="text/html; charset=gbk" language="java" errorPage="/public/pageError.jsp"%>
<%@ include file="../../func/common_simple.jsp"%>
<%@page import="com.tenwa.log.LogWriter"%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>每天日进报表</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
</head>
<%
	String loadtime=getStr(request.getParameter("loadtime"));
	//模拟赋值
	if("".equals(loadtime)){
		Calendar date = Calendar.getInstance();
		String month="";
		String day="";
		int ri = date.get(Calendar.DAY_OF_MONTH);
		int yue = date.get(Calendar.MONTH) + 1;
		int year = date.get(Calendar.YEAR); 
		if(yue<10){month ="0"+yue;}else{month =""+yue;}
		if(ri<10){day ="0"+ri;}else{day =""+ri;}
		loadtime=""+year+"-"+month+"-"+day+"";
		LogWriter.logDebug(request,"我需要的loadtime:"+loadtime);
	}
	
 %>
<body style="overflow:auto;"> 
<div style="vertical-align:top;width:100%;overflow:auto;position: relative; left: 0px; top: 0px"  id="mydiv">
   
   <div id="tabletit" class="tabtitexp">&nbsp; 
   		项目立项管理&nbsp;
   		<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" 
   		style="cursor:hand" title="显示/隐藏内容">				 
   	</div> 
   	<div style="overflow:auto ">
	<iframe frameborder="0" name="con" width="100%" height="300" scrolling="auto"
		src="log_detail.jsp?logType=xmlxgl&loadtime=<%=loadtime %>">
	</iframe>
   </div>
   
	<div id="tabletit" class="tabtitexp">&nbsp; 
   		项目审批&nbsp;
   		<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" 
   		style="cursor:hand" title="显示/隐藏内容">				 
   	</div> 
   	<div id="tablesub"> 
		<iframe frameborder="0" name="rentplan" width="100%" height="300" scrolling="auto"
		src="log_detail.jsp?logType=xmsp&loadtime=<%=loadtime %>">
		</iframe>
	</div>
	
	<div id="tabletit" class="tabtitexp">&nbsp; 
   		合同审批&nbsp;
   		<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" 
   		style="cursor:hand" title="显示/隐藏内容">				 
   	</div> 
   	<div id="tablesub"> 
		<iframe frameborder="0" name="rentplan" width="100%" height="300"  scrolling="auto"
		src="log_detail.jsp?logType=htsp&loadtime=<%=loadtime %>">
		</iframe>
	</div>
	
	<div id="tabletit" class="tabtitexp">&nbsp; 
   		CD交接管理&nbsp;
   		<img name="Changeicon" border="0" src="../../images/jt_b.gif"  onclick="javascript:fieldsetHidden();" 
   		style="cursor:hand" title="显示/隐藏内容">				 
   	</div> 
   	<div id="tablesub"> 
		<iframe frameborder="0" name="rentplan" width="100%" height="300" scrolling="auto"
		src="log_detail.jsp?logType=cdgl&loadtime=<%=loadtime %>">
		</iframe>
	</div>
	
	<div id="tabletit" class="tabtitexp">&nbsp; 
   		资金投放管理&nbsp;
   		<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" 
   		style="cursor:hand" title="显示/隐藏内容">				 
   	</div> 
   	<div id="tablesub"> 
		<iframe frameborder="0" name="rentplan" width="100%" height="300" scrolling="auto"
		src="log_detail.jsp?logType=xjtf&loadtime=<%=loadtime %>">
		</iframe>
	</div>
	<div id="tabletit" class="tabtitexp">&nbsp; 
   		租金管理&nbsp;
   		<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" 
   		style="cursor:hand" title="显示/隐藏内容">				 
   	</div> 
   	<div id="tablesub"> 
		<iframe frameborder="0" name="rentplan" width="100%" height="300" scrolling="auto" 
		src="log_detail.jsp?logType=zjgl&loadtime=<%=loadtime %>">
		</iframe>
	</div>
	<div id="tabletit" class="tabtitexp">&nbsp; 
   		租后变更管理&nbsp;
   		<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" 
   		style="cursor:hand" title="显示/隐藏内容">				 
   	</div> 
   	<div id="tablesub"> 
		<iframe frameborder="0" name="rentplan" width="100%" height="300" scrolling="auto" 
		src="log_detail.jsp?logType=zhbg&loadtime=<%=loadtime %>">
		</iframe>
	</div>
	<div id="tabletit" class="tabtitexp">&nbsp; 
   		融资管理&nbsp;
   		<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" 
   		style="cursor:hand" title="显示/隐藏内容">				 
   	</div> 
   	<div id="tablesub"> 
		<iframe frameborder="0" name="rentplan" width="100%" height="300"  scrolling="auto"
		src="log_detail.jsp?logType=rzgl&loadtime=<%=loadtime %>">
		</iframe>
	</div>
	<div id="tabletit" class="tabtitexp">&nbsp; 
   		保险管理&nbsp;
   		<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" 
   		style="cursor:hand" title="显示/隐藏内容">				 
   	</div> 
   	<div id="tablesub"> 
		<iframe frameborder="0" name="rentplan" width="100%" height="300" scrolling="auto" 
		src="log_detail.jsp?logType=bxgl&loadtime=<%=loadtime %>">
		</iframe>
	</div>
	<div id="tabletit" class="tabtitexp">&nbsp; 
   		 租后管理&nbsp;
   		<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" 
   		style="cursor:hand" title="显示/隐藏内容">				 
   	</div> 
   	<div id="tablesub"> 
		<iframe frameborder="0" name="rentplan" width="100%" height="300"  scrolling="auto" 
		src="log_detail.jsp?logType=zhgl&loadtime=<%=loadtime %>">
		</iframe>
	</div>
	<div id="tabletit" class="tabtitexp">&nbsp; 
   		 合同结清&nbsp;
   		<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" 
   		style="cursor:hand" title="显示/隐藏内容">				 
   	</div> 
   	<div id="tablesub"> 
		<iframe frameborder="0" name="rentplan" width="100%" height="300"  scrolling="auto" 
		src="log_detail.jsp?logType=htjq&loadtime=<%=loadtime %>">
		</iframe>
	</div>
	<div id="tabletit" class="tabtitexp">&nbsp; 
   		 合同结束&nbsp;
   		<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" 
   		style="cursor:hand" title="显示/隐藏内容">				 
   	</div> 
   	<div id="tablesub"> 
		<iframe frameborder="0" name="rentplan" width="100%" height="300"  scrolling="auto" 
		src="log_detail.jsp?logType=htjs&loadtime=<%=loadtime %>">
		</iframe>
	</div>
</div>
</body>
</html>
