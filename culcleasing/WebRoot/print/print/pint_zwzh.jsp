<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@page import="com.tenwa.util.CurrencyUtil"%>
<%@page import="java.util.Date"%>
<%@ include file="../../public/simpleHeadImport.jsp"%>
<jsp:useBean id="db1" scope="page" class="dbconn.Conn" />
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<title>债务置换审批单</title>
</head>

<style type="text/css">
table{border-collapse:collapse;margin:0 10px;font-size:16px;color:black;background:#fff;font-family: "楷体_GB2312";}
table tr td{padding:0 10px;border:solid 1px black}
.autoNewLine{
 word-break: break-all;
 overflow: hidden; 
 text-overflow:ellipsis;
}
</style>

<%
      SimpleDateFormat formater=new SimpleDateFormat("yyyy年MM月dd日");
      String time=formater.format(new Date());
	  String DocId=  getStr(request.getParameter("DocId"));	
	  String EquipTypes=  getStr(request.getParameter("EquipTypes"));
	  String ProjectMoney=  getStr(request.getParameter("ProjectMoney"));
	  String Zllx=  getStr(request.getParameter("Zllx"));
	  String Contractid=  getStr(request.getParameter("Contractid"));
	  String ProjectNo=  getStr(request.getParameter("ProjectNo"));
	  String ProjectFromDept=  getStr(request.getParameter("ProjectFromDept"));
	  String Xmzb=  getStr(request.getParameter("Xmzb"));
	  String ProjectName=  getStr(request.getParameter("ProjectName"));
	  String ZHCorpusAllM=  getStr(request.getParameter("ZHCorpusAllM"));
	  String ZHInterestAllM=  getStr(request.getParameter("ZHInterestAllM"));
	  String ZH_Remark=  getStr(request.getParameter("ZH_Remark"));
	 String moneyzh="";
	 if(ZHCorpusAllM==null|| ZHCorpusAllM.equals("")){
	   moneyzh=ZHInterestAllM;
	 
	 }else{
	  moneyzh=ZHCorpusAllM;
	 }
	 
%>
<body>
<input type="button" value="打印" onclick="javascript:yincang();" name="printB2"/>
<input type="button" value="乱码转译" onclick="javascript:zy();" id="printB23"/>

      <!-- 项目信息 -->
	 
      <h3 align="center" style="font-family: 楷体_GB2312;font-size:20px;color:black;">债务置换审批单</h3>	  
      <table align="center" cellpadding="3" cellspacing="0" style="width:700px">
	  <tr height="40">
          <td colspan="4" bgcolor="#FFFFFF" align="right"  style="border-left: none;border-right: none;border-top: none;">
          日期：<%=time %></td>
        </tr>
         <tr height="50">
          <td bgcolor="#FFFFFF" width="20%" align="center">项目基本信息</td>
          <td colspan="3" bgcolor="#FFFFFF"></td>
        </tr>
        <tr height="50">
          <td bgcolor="#FFFFFF" width="20%" align="center">项目名称</td>
          <td colspan="3" bgcolor="#FFFFFF"><%=ProjectName%></td>
        </tr>
        <tr height="50">
          <td bgcolor="#FFFFFF" width="20%" align="center">项目编号</td>
          <td bgcolor="#FFFFFF" width="30%"><%=ProjectNo%></td>
          <td bgcolor="#FFFFFF" width="20%" align="center">项目所属板块</td>
          <td bgcolor="#FFFFFF" width="30%" ><%=EquipTypes%></td>
        </tr>
        <tr height="50">
          <td bgcolor="#FFFFFF" width="20%" align="center">出单部门</td>
          <td bgcolor="#FFFFFF" width="30%"><%=ProjectFromDept%></td>
          <td bgcolor="#FFFFFF" width="20%" align="center">项目经理</td>
          <td bgcolor="#FFFFFF" width="30%" ><%=Xmzb%></td>
        </tr>
         <tr height="50">
          <td bgcolor="#FFFFFF" width="20%" align="center">租赁类型</td>
          <td bgcolor="#FFFFFF" width="30%"><%=Zllx%></td>
          <td bgcolor="#FFFFFF" width="20%" align="center">项目金额</td>
          <td bgcolor="#FFFFFF" width="30%" ><%=ProjectMoney%>.00</td>
        </tr>  
        <tr height="50" >
          <td bgcolor="#FFFFFF" colspan="1" width="20%" align="center">本次置换金额</td>
          <td bgcolor="#FFFFFF" colspan="3" width="30%"><%=moneyzh%></td>                     
        </tr> 
		<tr height="50" >
          <td bgcolor="#FFFFFF" colspan="1" align="center">备注</td> 
		  <td bgcolor="#FFFFFF" colspan="3"  ">
          <%=ZH_Remark%>
          </td>
		  
        </tr> 
        <tr height="50">
          <td bgcolor="#FFFFFF" colspan="4" style="background-color: green;" align="center">领导审批意见</td>
        </tr>       
          <tr>
		
          <td bgcolor="#FFFFFF" height="400" colspan="4" style="padding-top: 100px; ">
          
          </td>
        </tr>

		</table>

		<p>&nbsp;</p>
<input type="button" value="打印" onclick="javascript:yincang();" name="printB1"/>
              						
</body>

<script type="text/javascript">
function yincang(){	
	document.getElementsByName("printB1")[0].style.display="none";
	document.getElementsByName("printB2")[0].style.display="none";
	document.getElementsByName("printB23")[0].style.display="none";
   //document.getElementsByName("upd")[0].style.display="none";
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