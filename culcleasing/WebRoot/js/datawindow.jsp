<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ include file="common.jsp"%>
<html>
<head>
<!-- 08.04 -->
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>��ѡ������</title>
<link href="../css/global.css" rel="stylesheet" type="text/css">
<script>
window.onload=onWinLoad;
window.onresize=onWinResize;
function onWinLoad(){
	width=datalist.clientWidth+30;
	height=350;
	if (width>250){
	window.resizeTo(width,height);
	window.moveTo((screen.width - width)/2,(screen.height - height)/2);
	}
	fixCCH();
}
function onWinResize(){
	fixCCH();
}
function fixCCH(){
document.all.datalist.style.width="100%";
	if (document.body.clientHeight>80){
		document.all.cwMain.style.height=document.body.clientHeight-60;
		document.all.datalist.size=0;
		document.all.datalist.size=(document.all.cwMain.clientHeight-30)/15;
		document.body.scroll = "no";
	}else{
		document.body.scroll = "yes";
	}
}
</script>

<script language="javascript">
function ListSelect(dobj,vobj){
	if(window.opener.closed){alert("�������ѹرգ�");close();return;}
	var objSelect =document.getElementById("datalist");
	var i = objSelect.selectedIndex;
	if(i==-1){alert("����ѡ��");return;}
	var objSelected = objSelect.options[i];
	var thevobj=null;
	var arrvobj = vobj.split("|");
     
	var arrvalue = objSelected.value.split("|");
	if((objSelected.value=="") && (objSelected.text!="")){
		//do nothing
	}
        else
        {
	    for(j=0;j<arrvobj.length;j++)
            {
		thevobj = eval("window.opener."+arrvobj[j]);
		thevobj.value = (arrvalue[j]=="null")?"":arrvalue[j];
	    }
	}
	var thedobj = eval("window.opener."+dobj);
	thedobj.value=objSelected.innerHTML;
	window.close();
}
</script>


</head>

<body>
<%

String checkfld=getStr(request.getParameter("cf"));      //ǰ���ֶ���,��"|"�ָ�
String checktype=getStr(request.getParameter("ct"));      //ǰ���ֶ�����,��"|"�ָ�,ö��ֵ��string,number
String checkvalue=getStr(request.getParameter("cv"));    //ǰ���ֶε�ֵ,��"|"�ָ�
String selfldname=getStr(request.getParameter("sf"));    //�����ֶ���������,��"|"�ָ�
String tblname=getStr(request.getParameter("tn"));       //�������ݱ�������ͼ��
String listfld=getStr(request.getParameter("lf"));       //list��ʾ�ֶ�
String listvalue=getStr(request.getParameter("lv"));     //listʵ��ֵ�ֶ�,��"|"�ָ�
String filterfld=getStr(request.getParameter("ff"));     //ɸѡ�ֶ�
String orderfld=getStr(request.getParameter("of"));      //�����ֶ�,��"|"�ָ�
String ordertype=getStr(request.getParameter("ot"));     //����ʽ,�������,��"|"�ָ�
String dataobj=getStr(request.getParameter("do"));       //����������ʾ����
String valueobj=getStr(request.getParameter("vo"));      //��������ʵ��ֵ����+������������,��"|"�ָ�
String filtervalue=getStr(request.getParameter("fv"));   //ɸѡֵ
if ((filtervalue==null) || (filtervalue.equals("")))
{
  filtervalue="";
}
%>

<div id="cwMain">
<table width="100%" height="20"  border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td valign="top">
	
<form name="searchbar" action="datawindow.jsp" method="post">
<input type="hidden" name="cf" value="<%=checkfld%>">
<input type="hidden" name="ct" value="<%=checktype%>">
<input type="hidden" name="cv" value="<%=checkvalue%>">
<input type="hidden" name="sf" value="<%=selfldname%>">
<input type="hidden" name="tn" value="<%=tblname%>">
<input type="hidden" name="lf" value="<%=listfld%>">
<input type="hidden" name="lv" value="<%=listvalue%>">
<input type="hidden" name="ff" value="<%=filterfld%>">
<input type="hidden" name="of" value="<%=orderfld%>">
<input type="hidden" name="ot" value="<%=ordertype%>">
<input type="hidden" name="do" value="<%=dataobj%>">
<input type="hidden" name="vo" value="<%=valueobj%>">
<br>


<table id="" border="0" cellspacing="5" cellpadding="0" width="100%" >
      <tr>
        <td nowrap align="right"><%=selfldname%>: <input type="text" name="fv"   value="<%=filtervalue%>" style="width:90px"><input name="image" type="image" src="../images/tbtn_searh.gif" alt="��ѯ" align="absmiddle" >
</td>
      </tr>
</table>

</form>
<%
ResultSet rs;

String listvaluefldname="";   //�б��option value����Ӧ���ֶ����ַ���
String valuestr="";   //�б��option value�ַ���
String fldname="";    //�ֶ�����
Vector cfvector = new Vector();  //vector--checkfld
Vector ctvector = new Vector();  //vector--checktype
Vector cvvector = new Vector();  //vector--checkvalue
Vector lvvector = new Vector();  //vector--listvalue
Vector ofvector = new Vector();  //vector--orderfld
Vector otvector = new Vector();  //vector--ordertype
String checkstr="";   //sqlǰ���ֶ�ɸѡ�ַ���
String orderstr="";   //sql�����ַ���
int i=0;
lvvector = splitString("|",listvalue);
for (i = 0;i<lvvector.size();i++)
{
    listvaluefldname=listvaluefldname+","+lvvector.get(i);
} 


String sqlstr = "select "+listfld+listvaluefldname+" from "+tblname+" where (1=1)";
System.out.print("123"+sqlstr);
if (checkfld.length()>0)
{
    cfvector = splitString("|",checkfld);
    ctvector = splitString("|",checktype);
    cvvector = splitString("|",checkvalue);
    for (i = 0;i<cfvector.size();i++)
    {
        if (ctvector.get(i).equals("number"))
        {
            checkstr=checkstr+" and ("+cfvector.get(i)+"="+cvvector.get(i)+") ";
        }
        else
        {
            checkstr=checkstr+" and ("+cfvector.get(i)+"='"+cvvector.get(i)+"') ";
        }
    }
    sqlstr = sqlstr + checkstr;   
}

if (filtervalue.length()>0)
{
    sqlstr = sqlstr+" and ("+filterfld+" like '%"+filtervalue+"%')"; 
}
if (orderfld.length()>0)
{
    ofvector = splitString("|",orderfld);
    otvector = splitString("|",ordertype);
    for (i = 0;i<ofvector.size();i++)
    {
        orderstr=orderstr+","+ofvector.get(i)+" "+otvector.get(i);
    }
    orderstr=orderstr.substring(1,orderstr.length());  //ɾ����һ������
    sqlstr = sqlstr +" order by "+ orderstr;
}
System.out.println(sqlstr);
rs=db.executeQuery(sqlstr);
//out.print(sqlstr);
%>

<select name="datalist" size="30" ondblclick="ListSelect('<%=dataobj%>','<%=valueobj%>');" style="">
<option selected></option>
<%
while (rs.next())
{
    valuestr="";
    for (i = 0;i<lvvector.size();i++)
    {
       fldname=""+lvvector.get(i);
       valuestr=valuestr+"|"+rs.getString(fldname);
    }
    if(valuestr.length()>0){ 
       valuestr=valuestr.substring(1,valuestr.length());  //ɾ����һ��"|"
    }
%>

<option value="<%=valuestr%>"><%=rs.getString(listfld)%></option>
<%
}
%>
</select>

	</td>
  </tr>
  <tr>
    <td align="center" height="30"><input class="btn" type="button" value="ȷ��" onClick="ListSelect('<%=dataobj%>','<%=valueobj%>');">  <input class="btn" type="button" value="ȡ��" onClick="window.close()"></td>
  </tr>
</table>
</div>
</body>
</html>
<%if(null != db){db.close();}%>