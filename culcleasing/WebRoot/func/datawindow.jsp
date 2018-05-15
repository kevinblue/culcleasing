<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ include file="common.jsp"%>
<html>
<head>
<!-- 08.04 -->
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>请选择数据</title>
<link href="../css/mainstyle.css" rel="stylesheet" type="text/css">
<SCRIPT  Language="Javascript"  SRC="/tenwa/js/public.js"></SCRIPT>
<SCRIPT  Language="Javascript"  SRC="/tenwa/js/publicEvent.js"></SCRIPT>
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
	if(window.opener.closed){alert("主窗口已关闭！");close();return;}
	var objSelect =document.getElementById("datalist");
	var i = objSelect.selectedIndex;
	if(i==-1){alert("请先选择！");return;}
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


<body onload="public_onload(48);" class="linetype">
	<%

String checkfld=getStr(request.getParameter("cf"));      //前导字段名,以"|"分隔
String checktype=getStr(request.getParameter("ct"));      //前导字段类型,以"|"分隔,枚举值：string,number
String checkvalue=getStr(request.getParameter("cv"));    //前导字段的值,以"|"分隔
String selfldname=getStr(request.getParameter("sf"));    //检索字段中文名称,以"|"分隔
String tblname=getStr(request.getParameter("tn"));       //所查数据表名或视图名
String listfld=getStr(request.getParameter("lf"));       //list显示字段
String listvalue=getStr(request.getParameter("lv"));     //list实填值字段,以"|"分隔
String filterfld=getStr(request.getParameter("ff"));     //筛选字段
String orderfld=getStr(request.getParameter("of"));      //排序字段,以"|"分隔
String ordertype=getStr(request.getParameter("ot"));     //排序方式,升序或降序,以"|"分隔
String dataobj=getStr(request.getParameter("do"));       //返回数据显示对象
String valueobj=getStr(request.getParameter("vo"));      //返回数据实际值对象+其他需填充对象,以"|"分隔
String filtervalue=getStr(request.getParameter("fv"));   //筛选值
if ((filtervalue==null) || (filtervalue.equals("")))
{
  filtervalue="";
}
%>
<table  class="title_top" width="100%" align=center cellspacing="0" border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle" align="center">请选择</td>
</tr>
<tr>
<td align=center width=100% height=100% valign="top">

<div>
	
<div id="mydiv" class="linetype" style="margin:12px;padding:12px;">



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


<table id="" border="0" cellspacing="5" cellpadding="0" width="100%" >
      <tr>
        <td nowrap align="left"><%=selfldname%>: <input type="text" name="fv"   value="<%=filtervalue%>" style="width:90px"><input name="image" type="image" src="../images/tbtn_searh.gif" alt="查询" align="absmiddle" >
</td>
      </tr>
</table>

</form>
<%
ResultSet rs;

String listvaluefldname="";   //列表框option value所对应的字段名字符串
String valuestr="";   //列表框option value字符串
String fldname="";    //字段名称
Vector cfvector = new Vector();  //vector--checkfld
Vector ctvector = new Vector();  //vector--checktype
Vector cvvector = new Vector();  //vector--checkvalue
Vector lvvector = new Vector();  //vector--listvalue
Vector ofvector = new Vector();  //vector--orderfld
Vector otvector = new Vector();  //vector--ordertype
String checkstr="";   //sql前导字段筛选字符串
String orderstr="";   //sql排序字符串
int i=0;
lvvector = splitString("|",listvalue);
for (i = 0;i<lvvector.size();i++)
{
    listvaluefldname=listvaluefldname+","+lvvector.get(i);
} 


String sqlstr = "select "+listfld+listvaluefldname+" from "+tblname+" where (1=1)";

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
    orderstr=orderstr.substring(1,orderstr.length());  //删除第一个逗号
    sqlstr = sqlstr +" order by "+ orderstr;
}
System.out.println(sqlstr);
rs=db.executeQuery(sqlstr);
//out.print(sqlstr);
%>

<select name="datalist" style="height:260px;width:100%;" size="30" ondblclick="ListSelect('<%=dataobj%>','<%=valueobj%>');" style="">
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
       valuestr=valuestr.substring(1,valuestr.length());  //删除第一个"|"
    }
%>

<option value="<%=valuestr%>"><%=rs.getString(listfld)%></option>
<%
}
%>
</select>

	</td>
  </tr>

</table>









</div>
<div style="margin:12px;width:100%;">
<!--按钮案例：-->
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td align="right">
    	
    	<input class="com_button" type="button" value="确定" onClick="ListSelect('<%=dataobj%>','<%=valueobj%>');">
    	&nbsp;&nbsp;
    	<input class="com_button" type="button" value="取消" onClick="window.close()">
    	
    </td>
  </tr>
</table>
</div>

</div>

</td>
</tr>
<tr><td>
 
</td></tr>
</table>

</body>




















</html>
<%if(null != db){db.close();}%>