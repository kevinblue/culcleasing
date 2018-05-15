<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ include file="../../func/common.jsp"%>
<!-- 05.002 -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>修改租赁物件 - 租赁物件</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script><script src="../../js/validator.js"></script>
</head>

<body>

<div id="cwMain" >
<form name="form1" method="post" action="zlwj_save.jsp" onSubmit="return Validator.Validate(this,3);">

<div id="cwTop">
<table id="cwTopTit" border="0" cellpadding="0" cellspacing="0" >
    <tr>
      <td id="cwTopTitLeft"></td>
      <td id="cwTopTitTxt">租赁物件</td>
      <td id="cwTopTitRight"></td>
    </tr>
</table>  
</div>
<!-- end cwTop -->



<div id="cwCell">
<%
String dqczy=(String) session.getAttribute("czyid");
int canmod=0;
%>




<div id="cwCellTop">

	<table id="cwCellTopTit" width="100%" border="0" cellpadding="0" cellspacing="0" >
      <tr>
        <td id="cwCellTopTitLeft"></td>
        <td id="cwCellTopTitTxt">修改租赁物件</td>
        <td id="cwCellTopTitRight"></td>
      </tr>
    </table>
	
<table id="cwCellToolbar" border="0" cellspacing="5" cellpadding="0" >
      <tr>
        <td>&nbsp;</td>
      </tr>
</table>
	
</div>
<!-- end cwCellTop -->



<div id="cwCellContent" >
<%
String sqlstr;
String czid;
String wjmc;
String wjlb;
String wjlx;
String jjdw;
String ckj;
String wjgg;
String zzs;
String cd;
String kd;
String gd;
String nbcpbm;
String zt;
String xgrq;
String djr;
ResultSet rs;


sqlstr="select bmbh from v_yhxx where id='"+dqczy+"'";
String bmbh="";
rs=db.executeQuery(sqlstr); 
if (rs.next())
{
	bmbh=rs.getString("bmbh");
        if ((bmbh==null) || (bmbh.equals("")))
        {
           bmbh="0";
        }
}
else
{
     bmbh="0";      
}






czid=getStr(request.getParameter("czid"));
sqlstr = "SELECT V_yhxx.xm AS xm, jb_zlwjlb.lxmc AS lbmc, jb_zlwjlx.lxmc AS lxmc,jb_zlwjzzs.zzsmc AS zzsmc, jb_zlwjxx.*,jb_zlwjcptx.lxmc AS cptxmc FROM jb_zlwjxx LEFT OUTER JOIN jb_zlwjcptx ON jb_zlwjxx.cptx = jb_zlwjcptx.id LEFT OUTER JOIN jb_zlwjzzs ON jb_zlwjxx.zzs = jb_zlwjzzs.id LEFT OUTER JOIN jb_zlwjlx ON jb_zlwjxx.wjlx = jb_zlwjlx.id LEFT OUTER JOIN jb_zlwjlb ON jb_zlwjxx.wjlb = jb_zlwjlb.id LEFT OUTER JOIN V_yhxx ON jb_zlwjxx.czy = V_yhxx.id  where jb_zlwjxx.id='"+czid+"'"; 
rs=db.executeQuery(sqlstr); 
if (rs.next()) 
{ 
wjmc=getDBStr(rs.getString("wjmc"));
wjlb=getDBStr(rs.getString("wjlb"));
wjlx=getDBStr(rs.getString("wjlx"));
jjdw=getDBStr(rs.getString("jjdw"));
ckj=getDBStr(rs.getString("ckj"));
wjgg=getDBStr(rs.getString("wjgg"));
zzs=getDBStr(rs.getString("zzs"));
cd=getDBStr(rs.getString("cd"));
kd=getDBStr(rs.getString("kd"));
gd=getDBStr(rs.getString("gd"));
nbcpbm=getDBStr(rs.getString("nbcpbm"));
zt=getDBStr(rs.getString("zt"));
xgrq=getDBStr(rs.getString("gxrq"));
djr=getDBStr(rs.getString("xm"));




	String czy=getDBStr(rs.getString("czy"));
	if ((dqczy==null) || (dqczy.equals("")))
	{
	  dqczy="无认证";
	}
	if ((czy==null) || (czy.equals("")))
	{
	  czy="无记录";
	}
		
    	canmod=1;
%>

<script>
if (<%=canmod%>==0){
	window.close();
	opener.alert("您没有修改权限！");
}
</script>
<input type="hidden" name="savetype" value="mod"><input type="hidden" name="kid" value="<%=getDBStr(rs.getString("id"))%>">
  <table class="cwDataInput"  border="0" cellspacing="5" cellpadding="2">
    <tr>
    <th class="cwDDLabel" width="20%">租赁物件编号</th>
    <td class="cwDDValue" width="80%"><%=getDBStr(rs.getString("id"))%></td>
  </tr>
  <tr>
    <th class="cwDDLabel" width="20%">租赁物件名称</th>
    <td class="cwDDValue" width="80%"><%=getDBStr(rs.getString("wjmc"))%></td>
  </tr>
  <tr>
    <th class="cwDDLabel" scope="row">总类</th>
    <td class="cwDDValue"><%=getDBStr(rs.getString("lbmc"))%></td>
  </tr>
  <tr>
    <th class="cwDDLabel" scope="row">产品名称</th>
    <td class="cwDDValue"><%=getDBStr(rs.getString("lxmc"))%></td>
  </tr>
  <tr>
    <th class="cwDDLabel" scope="row">产品特性</th>
    <td class="cwDDValue"><%=getDBStr(rs.getString("cptxmc"))%></td>
  </tr>
  <tr>
      <th scope="row">计件单位名称</th>
      <td><input name="jjdw" type="text" size="20" maxlength="20" maxB="20" value="<%=jjdw%>"></td>
    </tr>
    <tr>
      <th scope="row">参考价</th>
      <td><input name="ckj" type="text" size="9" maxlength="9"  dataType="Money" value="<%=ckj%>"></td>
    </tr>
    <tr>
      <th scope="row">规格</th>
      <td><textarea name="wjgg" maxB="500"><%=wjgg%></textarea>
	  </td>
    </tr>
    <tr>
      <th scope="row">制造商</th>
      <td>
<input name="zzsdata" type="text" size="50" readonly value="<%=getDBStr(rs.getString("zzsmc"))%>"><input name="zzs" type="hidden" value="<%=zzs%>"><img src="../../images/sbtn_more.gif" alt="选" width="19" height="19" align="absmiddle" style="cursor:pointer" onclick="SpecialDataWindow('制造商','jb_zlwjzzs','zzsmc','id','zzsmc','stringfld','id','form1.zzsdata','form1.zzs');">
</td>
    </tr>
    <tr>
      <th scope="row">物件长度</th>
      <td><input name="cd" type="text" size="9" maxlength="9" dataType="Double" value="<%=cd%>"> 
      厘米</td>
    </tr>
    <tr>
      <th scope="row">物件宽度</th>
      <td><input name="kd" type="text" size="9" maxlength="9" dataType="Double" value="<%=kd%>"> 
      厘米</td>
    </tr>
    <tr>
      <th scope="row">物件高度</th>
      <td><input name="gd" type="text" size="9" maxlength="9" dataType="Double" value="<%=gd%>"> 
      厘米</td>
    </tr>
    <tr>
      <th scope="row">物件内部产品编码</th>
      <td><input name="nbcpbm" type="text" size="20" maxlength="20" maxB="20" value="<%=nbcpbm%>"></td>
    </tr>
    <tr>
      <th scope="row">注册证到期日</th>
      <td><input name="wjdqr" accesskey="r" type="text" size="9" dataType="Date" value="<%=getDBDateStr(rs.getString("wjdqr"))%>"><img  onClick="openCalendar(wjdqr);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle"></td>
    </tr>
    <tr>
      <th scope="row">物件产地</th>
      <td><input name="wjcd" type="text" size="30" maxlength="100" maxB="200" value="<%=getDBStr(rs.getString("wjcd"))%>"></td>
    </tr>
    <tr>
      <th scope="row">生产商所属厂商系</th>
      <td><input name="scssscsx" type="text" size="30" maxlength="100" maxB="200" value="<%=getDBStr(rs.getString("scssscsx"))%>"></td>
    </tr>	
    <tr> 
      <th scope="row">信息状态</th>
      <td> 
	  <select name=zt>
<script>w(mSetOpt("<%=zt%>",""))</script>
      </select>
	  </td>
	</tr> 
    <tr>
      <th scope="row">最后更新日期</th>
      <td><%=xgrq%></td>
    </tr>
    <tr>
      <th scope="row"> 操作员</th>
      <td><%=djr%></td>
    </tr>
  </table>


<!-- end cwDataNav -->




</div>
<!-- end cwCellContent -->




</div>
<!-- end cwCell -->





<div id="cwToolbar" >

<%
if (canmod==1)
{
%>
<input class="btn" name="submit" value="保存" type="submit">
<%
}
%>
<input class="btn" name="btnClose" value="取消" type="button" onClick="cfClose()"><input class="btn" name="btnOk" value="重置" type="reset">
</div>
<!-- end cwToolbar -->
    </form>
    <%
}
else
{
   out.print("</center>该条记录不存在!</center>");
}
rs.close(); 
db.close();
%>
</div>
<!-- end cwMain -->
</body>
</html>


