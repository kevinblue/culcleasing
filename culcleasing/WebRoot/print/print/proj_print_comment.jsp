<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@page import="com.tenwa.util.CurrencyUtil"%>
<%@page import="java.util.Date"%>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>



<%@ include file="../../public/simpleHeadImport.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<title></title>
</head>

<style type="text/css">
table{border-collapse:collapse;margin:0 10px;font-size:16px;color:black;background:#fff;font-family: "����_GB2312";}
table tr td{padding:0 10px;border:solid 1px black}
.autoNewLine{
 word-break: break-all;
 overflow: hidden; 
 text-overflow:ellipsis;
}
</style>

<%
SimpleDateFormat formater=new SimpleDateFormat("yyyy��MM��dd��");
String time=formater.format(new Date());
//String pa=getStr(request.getParameter("pa"));
String pa=new String(request.getParameter("pa").getBytes("ISO-8859-1"),"utf-8");
JSONArray json = JSONArray.fromObject(pa); // ���Ȱ��ַ���ת�� JSONArray  ����
%>
<body>
<input type="button" value="��ӡ" onclick="javascript:yincang();" name="printB2"/>
<input type="button" value="����ת��" onclick="javascript:zy();" id="printB23"/>

      <!-- ��Ŀ��Ϣ -->
      <h3 align="center" style="font-family: ����_GB2312;">�������һ��</h3>
      <table align="center" cellpadding="3" cellspacing="0">
        <tr height="40">
          <td colspan="4" bgcolor="#FFFFFF" align="right"  style="border-left: none;border-right: none;border-top: none;">
          ���ڣ�<%=time %></td>
        </tr>
		<tr height="35">
          <td bgcolor="#FFFFFF" style="background-color: green;"  width="20%" align="center">����</td>
          <td bgcolor="#FFFFFF" style="background-color: green;" width="15%" align="center">��Ա</td> 
		   <td bgcolor="#FFFFFF" style="background-color: green;" width="15%" align="center">ʱ��</td> 
		   <td bgcolor="#FFFFFF" style="background-color: green;" width="50%" align="center">���</td>
        </tr>       
		<%
		if(json.size()>0){
			   for(int i=0;i<json.size();i++){
			     JSONObject job = json.getJSONObject(i);  // ���� jsonarray ���飬��ÿһ������ת�� json ����
			      // �õ� ÿ�������е�����ֵ
			   String agree=job.get("Comment").toString().replaceAll("�ٷֱ�","%");
				
		%>
        <tr height="50">
          <td bgcolor="#FFFFFF" width="20%"><%=job.get("UserDept") %></td>
          <td bgcolor="#FFFFFF" width="15%" ><%=job.get("UserName")  %></td>
		  <td bgcolor="#FFFFFF" width="15%"><%=job.get("StepEndDate")%></td>
		  <td bgcolor="#FFFFFF" width="50%"><%=agree%></td>	  
        </tr>
		<%
		 }
		 }
		%>
		
      </table>
      <!-- ������ϸ��Ϣ���� -->
<p>&nbsp;</p>
<input type="button" value="��ӡ" onclick="javascript:yincang();" name="printB1"/>
</body>
<script type="text/javascript">
function yincang(){
	document.getElementsByName("printB1")[0].style.display="none";
	document.getElementsByName("printB2")[0].style.display="none";
	document.getElementsByName("printB23")[0].style.display="none";
	 
 
	window.print();
}

function zy(){
//alert(2);
	window.location.href = window.location.href+'&1=1';
	//alert(2);
	window.reload();
	//alert(1);
}
</script>
</html>