<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*" %> 
<%@ page import="com.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ include file="../../func/common.jsp"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<link href="../../css/global.css" rel="stylesheet" type="text/css">
</head>

<body>

<object codebase="http://www.wave12.com/product/wsReport.ocx#version=4,6,0,1" classid="clsid:08D91289-1761-4006-8294-FDE48B9F29BD" width="100%" height="100%" id="obj"></object>
<script language="VBScript">
obj.Init
obj.PageSize = 3
obj.LeftMargin = 40
obj.TopMargin = 5
obj.LineInterval = 1

obj.SetFontSize 14
obj.SetFontStyle 0, 1, 0
obj.SetBKMode 1
obj.SetFont "����", 1
obj.SetBackGround ("c:/���֪ͨ��2.jpg") '����Ʊ�ݱ���

<%
for(int i=0;i<=10;i++){
%>
obj.DrawObject " ", "", 3, "", 5, "1,2,3,4", "30,47", "false,1"
obj.DrawObject "276000", "", 0, "", 5, "1,2,3,4", "32,116", "false,2"
obj.DrawObject "ɽ��ʡ ������", "", 0, "", 5, "1,2,3,4", "32,136", "false,2"
obj.DrawObject "���ʺӶ��⻷·", "", 0, "", 5, "1,2,3,4", "32,156", "false,2"
obj.DrawObject "������", "", 0, "", 5, "1,2,3,4", "32,176", "false,2"
obj.DrawObject "������", "", 0, "", 5, "1,2,3,4", "32,196", "false,2"
obj.DrawObject "�绰:0539-838881", "", 0, "", 5, "1,2,3,4", "32,216", "false,2"

obj.DrawObject "������:", "", 0, "", 5, "1,2,3,4", "40,365", "false,2"
obj.SetFontSize 12
obj.DrawObject "L06-A0411", "", 0, "", 5, "1,2,3,4", "274,400", "false,2"
obj.DrawObject "2009", "", 0, "", 5, "1,2,3,4", "524,400", "false,2"
obj.DrawObject "05", "", 0, "", 5, "1,2,3,4", "564,400", "false,2"
obj.DrawObject "10", "", 0, "", 5, "1,2,3,4", "590,400", "false,2"
obj.DrawObject "��39,627.00", "", 0, "", 5, "1,2,3,4", "340,418", "false,2"
obj.DrawObject "��28����� ���Ϊ��39,627.00", "", 0, "", 5, "1,2,3,4", "56,468", "false,2"
obj.SetFontSize 13
obj.DrawObject "��242,267.56", "", 0, "", 5, "1,2,3,4", "294,517", "false,2"
obj.SetFontSize 12
obj.SetFontStyle 0, 0, 0
obj.DrawObject "��27����� ���Ϊ��39,267.00", "", 0, "", 5, "1,2,3,4", "56,538", "false,2"
obj.DrawObject "", "", 0, "", 5, "1,2,3,4", "56,558", "false,2"
obj.DrawObject "��26����� ���Ϊ��39,267.00", "", 0, "", 5, "1,2,3,4", "56,580", "false,2"
obj.DrawObject "��26������20�죬�Ʒ�Ϣ���Ϊ ��237.76", "", 0, "", 5, "1,2,3,4", "56,602", "false,2"
obj.DrawObject "��25�ڼ�֮ǰ��� ���Ϊ��158,508.00", "", 0, "", 5, "1,2,3,4", "56,623", "false,2"
obj.DrawObject "��25�ڼ�֮ǰ���Ʒ�Ϣ���Ϊ ��4,627.80", "", 0, "", 5, "1,2,3,4", "56,645", "false,2"
obj.DrawObject "0.03%", "", 0, "", 5, "1,2,3,4", "335,698", "false,2"
obj.SetFontSize 16
obj.DrawObject "��������(�й�)���޹�˾", "", 0, "", 5, "1,2,3,4", "460,800", "false,2"
obj.SetFontSize 14
obj.SetFontStyle 0, 1, 0
obj.DrawObject "2009", "", 0, "", 5, "1,2,3,4", "502,827", "false,2"
obj.DrawObject "03", "", 0, "", 5, "1,2,3,4", "558,827", "false,2"
obj.DrawObject "30", "", 0, "", 5, "1,2,3,4", "598,827", "false,2"
obj.SetFontStyle 0, 0, 0
obj.DrawObject "��������(�й�)���޹�˾ �й����������Ϻ��н���֧���ʺ�: 1001199409016228465", "", 0, "", 5, "1,2,3,4", "74,908", "false,2"
obj.DrawObject "��39,627.00", "", 0, "", 5, "1,2,3,4", "116,940", "false,2"
obj.DrawObject "��242,267.56", "", 0, "", 5, "1,2,3,4", "292,940", "false,2"
obj.DrawObject "��281,894.56", "", 0, "", 5, "1,2,3,4", "445,940", "false,2"
obj.SetFontStyle 0, 1, 0
obj.DrawObject "L06-A0411", "", 0, "", 5, "1,2,3,4", "179,997", "false,2"
obj.DrawObject "", "", 0, "", 5, "", "300,200", "true,3"
<%
}
%>

obj.PrintPreview
</script>
</body>
</html>
<%db.close(); %>



