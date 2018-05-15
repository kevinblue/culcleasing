<%@ page contentType="text/html; charset=gbk" language="java" import="java.sql.*" errorPage="/public/pageError.jsp" %>

<%@ page import="dbconn.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="com.tenwa.log.LogWriter"%>

<%@ include file="/func/common_simple.jsp"%>

<jsp:useBean id="db" scope="page" class="dbconn.Conn" />
<jsp:useBean id="db1" scope="page" class="dbconn.Conn" />
<jsp:useBean id="db2" scope="page" class="dbconn.Conn" />

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>֪ͨ�� - <%=getStr(request.getParameter("inform_type")) %></title>
<link rel="stylesheet" type="text/css" href="../css/dtree.css">
<link rel="stylesheet" type="text/css" href="../css/mainstyle.css">

<SCRIPT  Language="Javascript"  SRC="/func/dtree.js"></SCRIPT>
<script src="/js/menu.js"></script>

</head>

<!-- �������� -->
<%@ include file="/public/commonVariable.jsp"%>
<!-- �������� -->

<%
//�������� - ֪ͨ������| ���֧��|��Ϣ����|�����
String inform_type = getStr(request.getParameter("inform_type"));

%>

<body text="#000000" bgcolor="#FFFFFF" topmargin=0 leftmargin=0 class=menu style='border:1px solid #8DB2E3;margin:0px;'>
<table border="0" width="100%"  cellspacing="0" cellpadding="0" height="25" valign="top">
<tr class="tree_title_txt">
<td width="100%" class="tree_title_txt" valign="middle" id="frmTitle2" >
֪ͨ��  -  <%=inform_type %>
</td>
</tr>			
</table>
<table border="0" width="100%" height="100%" cellspacing="0" cellpadding="0">
<tr><td id="frmTitle" valign="top">

    <!--<div id="menutit">&nbsp;<a href="login.jsp" target="_top">Login</a></div> -->
<div id="menu1" expmode=1> 
  <div id="menunode"> 
  	<div style="vertical-align:top;width:100%;overflow:auto;position: relative;padding:6px;" id="mydiv">
   <table border="0"  width="100%" align="center"  cellspacing="0" cellpadding="0">
<tr>
<td id="menuContent">

<script type="text/javascript">

var dd="d";

var d=new dTree(dd);

d.add(0,-1,"<label id='myjob'>��Ϣ�鿴</label>");

<%
//ѭ�����Žṹ
int i = 4;
int j = 1;
String partSql = "";
String partSql2 = "";
ResultSet rs1 = null;
ResultSet rs2 = null;

String partName = "";
String partTitle = "";
//��ѯ���ϴ���
sqlstr = "Select id,dept_name from base_department where superior_dept='root' order by dept_name";

rs = db.executeQuery(sqlstr);
String name = "";
String title = "";
while(rs.next()){
	i++;
	name = getDBStr(rs.getString("id"));
	title = getDBStr(rs.getString("dept_name"));
%>
d.add(<%=i*10 %>,0,"<%=title %>");

	<%
	//��ѯ�Ӳ���	
	partSql = "Select id,dept_name from base_department where superior_dept='"+name+"' order by dept_name";
	rs1 = db1.executeQuery(partSql);
	
	//�ж��Ƿ����Ӳ���
	if(!rs1.next()){//û���Ӳ���-ֱ�Ӹ��Ƹ�����
		%>
		
		d.add(<%=i*10 + j %>,<%=i*10 %>,"<%=title %>",
				"/Culcleasing/funcWord/funcWordInform.jsp?deptName=<%=title%>&deptId=<%=name %>&inform_type=<%=inform_type%>",
				"","parent.right.href='funcWord/funcWordInform.jsp?deptName=<%=title%>&deptId=<%=name %>&inform_type=<%=inform_type%>'",
				"","","","<%=title %>");
				
		<%
	}else{//���Ӳ���
		rs1.beforeFirst();
		//��������Ӳ��� - ѭ��
		while(rs1.next()){
			j++;
			partName = getDBStr(rs1.getString("id"));
			partTitle = getDBStr(rs1.getString("dept_name"));
	%>

		d.add(<%=i*10 + j %>,<%=i*10 %>,"<%=partTitle %>",
		"/Culcleasing/funcWord/funcWordInform.jsp?deptName=<%=partTitle%>&deptId=<%=partName %>&inform_type=<%=inform_type%>",
		"","parent.right.href='funcWord/funcWordInform.jsp?deptName=<%=partTitle%>&deptId=<%=partName %>&inform_type=<%=inform_type%>'",
		"","","","<%=title %>");
	
	<%}}%>
	
	
<%}
db1.close();
db2.close();
%>

document.write(d);
//alert(d);

 //���ò˵���������
 var cateInfo=[];	

 function setCateInfo(){
   var tree=d.aNodes;//��ǰxmlĿ¼·��
   for(var i=0;i<tree.length;i++){
     if(tree[i].url && tree[i].url.toLowerCase().indexOf("xmlview")!=-1){
	 var key=tree[i].url.strright("&view=");
	 key=key.indexOf("&")!=-1?key.strleft("&"):key;
        var label=tree[i].name;
	 if(label.indexOf("<label")!=-1){
          var id=label.strright("id='").strleft("'");
          label=lan.$(id,label);
        }
	 cateInfo[key]=label;
     }   	
   }
 }
/**/
</script>
</td></tr>

</table>
</div></div></div>
  </tr>
</table>

<script>
//initMenu(menu1,0);

</script>
</body>
</html>
<%if(null != db){db.close();}%>