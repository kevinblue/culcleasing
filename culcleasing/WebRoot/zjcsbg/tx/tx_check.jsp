<%@ page language="java" import="java.util.*" pageEncoding="gbk"%><%@ include file="../../func/common.jsp"%>
<%
String Nper = null;
String Pv = null;
String Fv = null;
String Type = null;
String Pmt = null;
String lease_term = null;
Nper = getStr(request.getParameter("Nper"));
Pv = getStr(request.getParameter("Pv"));
Fv = getStr(request.getParameter("Fv"));
Type = getStr(request.getParameter("Type"));
Pmt = getStr(request.getParameter("Pmt"));
lease_term = getStr(request.getParameter("lease_term"));
String rate = getPmtYearRate(Nper, "-"+Pv, Fv, Type, Pmt, lease_term);
 %>
<%=new BigDecimal(rate).setScale(6, BigDecimal.ROUND_HALF_UP)  %>