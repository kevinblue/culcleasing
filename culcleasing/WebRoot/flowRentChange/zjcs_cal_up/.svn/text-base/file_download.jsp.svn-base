<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@ page import="com.jspsmart.upload.SmartUpload"%>
<%@page import="com.tenwa.culc.util.OperationUtil"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="com.tenwa.log.LogWriter"%>
<%@ include file="../../func/common_simple.jsp"%>

<%--
String settle_method = getStr(request.getParameter("settle_method")); //测算类型
String period_type = getStr(request.getParameter("period_type"));//付租类型

System.out.println("租金测算方法："+settle_method+"__付租类型："+period_type);

//下载文件
SmartUpload su = new SmartUpload();
su.setContentDisposition(null);
su.initialize(pageContext);

String fileName = OperationUtil.getFileName(settle_method, period_type, "xls");

su.downloadFile(pageContext.getServletContext().getRealPath("/")+"/template/rent_calc_tmp/"+fileName);
//su.downloadFile(pageContext.getServletContext().getRealPath("/")+"/template/rent_calc_tmp/g.txt");

out.clear();
out = pageContext.pushBody();
--%>

<%
String settle_method = getStr(request.getParameter("settle_method")); //测算类型
String period_type = getStr(request.getParameter("period_type"));//付租类型

LogWriter.logDebug("租金测算方法："+settle_method+"__付租类型："+period_type);
String fileName = OperationUtil.getFileName(settle_method, period_type, "xls");

//下载
response.setContentType("application/x-download");//设置为下载application/x-download
String filedownload = "/template/rent_calc_tmp/"+fileName;//即将下载的文件的相对路径

String filedisplay = fileName;//下载文件时显示的文件保存名称
String filenamedisplay = URLEncoder.encode(filedisplay,"UTF-8");
response.addHeader("Content-Disposition","attachment;filename=" + filenamedisplay);

try
{
    RequestDispatcher dis = application.getRequestDispatcher(filedownload);
    if(dis!= null)
    {
        dis.forward(request,response);
    }
    response.flushBuffer();
}
catch(Exception e)
{
    e.printStackTrace();
}
finally
{
	LogWriter.logError(request, "租金测算下载文件找不到！");%>
<script type="text/javascript">
window.alert("租金测算Excel暂无，请通知管理员上传！");
</script>
<%
}
%>
