<%@ page contentType="text/html; charset=gbk" language="java" errorPage="/public/pageError.jsp"%>
<%@ include file="../../func/common_simple.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>�������� - ��ҽ�������ƶ�</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
</head>
<%
    //��Ŀ���׽ṹ��ʱ�� proj_condition_temp
	String proj_id = getStr(request.getParameter("proj_id"));//��ͬ���   "001";//
	String doc_id = getStr(request.getParameter("doc_id"));//�ĵ���� "001";// measure_id
	String proj_money = getStr(request.getParameter("proj_money"));//��Ŀ���
	//��������Id
	if(proj_id==null || "".equals(proj_id)){
		proj_id = "CULCTest02233";
		doc_id = "JS9999999000477";
		proj_money = "999999944";
	}
%>

<body style="overflow:auto;"> 
<div style="vertical-align:top;width:100%;overflow:auto;position: relative; left: 0px; top: 0px"  id="mydiv">
   
   <div id="tabletit" class="tabtitexp">&nbsp; 
   		��������&nbsp;
   		<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" 
   		style="cursor:hand" title="��ʾ/��������">				 
   	</div> 
   	<div>
   	<!-- ���������ƶ���ֱ���������+�ֽ��� -->
	<iframe frameborder="0" id="con" name="con" width="100%" height="430" 
		src="proj_cond_set.jsp?proj_id=<%=proj_id%>&doc_id=<%=doc_id%>&proj_money=<%=proj_money %>">
	</iframe>
   </div>
	
	<div id="tabletit" class="tabtitexp">&nbsp; 
   		�ֽ����б�&nbsp;
   		<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" 
   		style="cursor:hand" title="��ʾ/��������">				 
   	</div> 
   	<div id="tablesub"> 
		<iframe frameborder="0" name="rentplan" width="100%" height="600" 
		src="cash_show.jsp?proj_id=<%=proj_id%>&doc_id=<%=doc_id%>">
		</iframe>
	</div>
</div>
</body>
</html>
