<%@page language="java" contentType="application/x-msdownload" pageEncoding="UTF-8"%>
<%@page import="java.net.URLEncoder" %>
<%@page import="java.io.*" %>
<%@page import="javax.servlet.*" %>
<%--
  ~ Copyright(c) 2005-2011  Oriental e-way Software Limited. All rights reserved.
  ~ http://www.oe-way.com.cn
  ~ Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
  ~ 1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
  ~ 2. Redistributions in binary form must reproduce the above copyright  notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
  ~ 3. Redistributions in any form must be accompanied by information on how to obtain complete source code for the Bizfocus software.
  --%>

<%
//关于文件下载时采用文件流输出的方式处理：
//加上response.reset()，并且所有的％>后面不要换行，包括最后一个；

String template_name = "电信设备供应商信息导入模板.xls";
OutputStream outp = null;
FileInputStream in = null;
//File filedownload = new File("D:\\IBM\\WebSphere\\AppServer\\profiles\\AppSrv01\\installedApps\\iulc-df68742221Node01Cell\\iulcleasing_war.ear\\iulcleasing.war\\upload\\电信设备供应商信息导入模板.xls");//这个里面 你要找到 你的文件的路径
ServletContext context = this.getServletConfig().getServletContext();
String path=context.getRealPath("/");
File filedownload = new File(path+"\\upload\\电信设备供应商信息导(自然人).xls");
try
{
outp = response.getOutputStream();
in = new FileInputStream(filedownload);

byte[] b = new byte[in.available()];

 in.read(b);
            response.reset();
            response.setContentType("application/vnd.ms-excel");
            response.setHeader("Content-disposition","attachment; filename=" + URLEncoder.encode(template_name,"UTF-8") );
             outp = response.getOutputStream();
            outp.write(b);
            outp.flush();
}catch(Exception e)
{
System.out.println("Error!");
e.printStackTrace();
}
finally
{
if(in != null)
{
in.close();
in = null;
}
if(outp != null)
{
outp.close();
outp = null;
}
}
%> 

