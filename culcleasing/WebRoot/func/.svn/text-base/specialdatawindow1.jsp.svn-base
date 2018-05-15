<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ include file="common.jsp"%>
<html>
<head>
<!-- 05.06.01 -->
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>请选择数据</title>
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
function ListSelect(dobj,vobj){//05.04.27
	if(window.opener.closed){alert("主窗口已关闭！");close();return;}
	var objSelect =document.getElementById("datalist");
	var i = objSelect.selectedIndex;
	if(i==-1){alert("请先选择！");return;}
	var objSelected = objSelect.options[i];
	var thevobj=null;
	var arrvobj = vobj.split("|");
	var arrvalue = objSelected.value.split("|");
	for(j=0;j<arrvobj.length;j++){
		thevobj = eval("window.opener."+arrvobj[j]);
		thevobj.value = (arrvalue[j]=="null")?"":arrvalue[j];
	}
	var thedobj = eval("window.opener."+dobj);
	thedobj.value=objSelected.innerHTML;
	window.close();
}
</script>


</head>

<body>
<%
String selfldname=getStr(request.getParameter("sf"));
String tblname=getStr(request.getParameter("tn"));
String listfld=getStr(request.getParameter("lf"));
String listvalue=getStr(request.getParameter("lv"));
String hiddenfield=getStr(request.getParameter("hf"));
String filterfld=getStr(request.getParameter("ff"));
String filtertype=getStr(request.getParameter("ft"));
String hiddenwhere=getStr(request.getParameter("hw"));
String orderfld=getStr(request.getParameter("of"));
String dataobj=getStr(request.getParameter("do"));
String valueobj=getStr(request.getParameter("vo"));
String filtervalue=getStr(request.getParameter("fv"));
if ((filtervalue==null) || (filtervalue.equals("")))
{
filtervalue="";
}
%>

<div id="cwMain">
<table width="100%" height="20"  border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td valign="top">
	
<form name="searchbar" action="specialdatawindow1.jsp">
<input type="hidden" name="sf" value="<%=selfldname%>">
<input type="hidden" name="tn" value="<%=tblname%>">
<input type="hidden" name="lf" value="<%=listfld%>">
<input type="hidden" name="lv" value="<%=listvalue%>">
<input type="hidden" name="hf" value="<%=hiddenfield%>">
<input type="hidden" name="ff" value="<%=filterfld%>">
<input type="hidden" name="ft" value="<%=filtertype%>">
<input type="hidden" name="hw" value="<%=hiddenwhere%>">
<input type="hidden" name="of" value="<%=orderfld%>">
<input type="hidden" name="do" value="<%=dataobj%>">
<input type="hidden" name="vo" value="<%=valueobj%>">
<br>


<table id="cwCellToolbar" border="0" cellspacing="5" cellpadding="0" >
      <tr>
        <td nowrap><%=selfldname%>: <input type="text" name="fv"   value="<%=filtervalue%>" style="width:90px"><input name="image" type="image" src="../images/tbtn_searh.gif" alt="查询" align="absmiddle" >
</td>
      </tr>
</table>

</form>
<%
String hiddenfldname="";
String fldname="";
Vector v = new Vector();
v = splitString("|",hiddenfield);
  for (int i = 0;i<v.size();i++)
      {
       hiddenfldname=hiddenfldname+","+v.get(i);
       } 

String valuestr="";
String hwstr="";
if (hiddenwhere!=null && !hiddenwhere.equals("")){ 
    hwstr=" where " + hiddenwhere ;}
else
   {hwstr=" where 1=1";}
String sqlstr = "select "+listfld+","+listvalue+hiddenfldname+" from "+tblname + hwstr;
ResultSet rs;
if ((filtertype.indexOf("stringfld")>=0) && (filtervalue.length()>0))
sqlstr = sqlstr+" and "+filterfld+" like '%"+filtervalue+"%'" ; 

if (orderfld.length()>0)
sqlstr = sqlstr +" order by "+ orderfld;

//out.print(sqlstr);
rs=db.executeQuery(sqlstr);

%>

<select name="datalist" size="30" ondblclick="ListSelect('<%=dataobj%>','<%=valueobj%>');" 

style="">
<option selected></option>
<%
while (rs.next())
{
valuestr=rs.getString(listvalue);
  for (int i = 0;i<v.size();i++)
      {
       fldname=""+v.get(i);
       valuestr=valuestr+"|"+rs.getString(fldname);
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
    <td align="center" height="30"><input class="btn" type="button" value="确定" onclick="ListSelect('<%=dataobj%>','<%=valueobj%>');">  <input class="btn" type="button" value="取消" onclick="window.close()"></td>
  </tr>
</table>
</div>
</body>
</html>
<%if(null != db){db.close();}%>