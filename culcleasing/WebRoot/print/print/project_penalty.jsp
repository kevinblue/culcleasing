<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@page import="com.tenwa.util.CurrencyUtil"%>
<%@page import="java.util.Date"%>


<%@ include file="../../public/simpleHeadImport.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<title>罚息减免审批单</title>
</head>

<style type="text/css">
table{border-collapse:collapse;margin:0 10px;font-size:14px;color:black;background:#fff;font-family: "楷体_GB2312";}
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
//request.setCharacterEncoding("gbk");
String isEd=getStr(request.getParameter("isEd"));//是否可编辑
String docId=getStr(request.getParameter("DocID"));
String ProjectFromDept=getStr(request.getParameter("ProjectFromDept"));//出单部门
String Xmzb=getStr(request.getParameter("Xmzb"));//项目经理
String ProjectNo=getStr(request.getParameter("ProjectNo"));//项目编号
String ProjectName=getStr(request.getParameter("ProjectName"));//项目名称
String EquipTypeS=getStr(request.getParameter("EquipType"));//内部行业
String HRentList=getStr(request.getParameter("HRentList"));//逾期租金期次
String HRent=getStr(request.getParameter("HRent"));//逾期租金
String HDates=getStr(request.getParameter("HDates"));//逾期天数
String HPenaltyCut=getStr(request.getParameter("HPenaltyCut"));//申请减免罚息
 String [] vHRentList = {};
 String [] vHRent = {};
 String [] vHDates = {};
 String [] vHPenaltyCut = {};
		if(HRentList.contains(",")){
			vHRentList = HRentList.split(",");
			vHRent = HRent.split(",");
			vHDates = HDates.split(",");
			vHPenaltyCut = HPenaltyCut.split(",");
		}else if(HRentList.contains(";")){
			
			vHRentList = HRentList.split(";");
			vHRent = HRent.split(";");
			vHDates = HDates.split(";");
			vHPenaltyCut = HPenaltyCut.split(";");
		}else{
		  vHRentList = HRentList.split(",");
			vHRent = HRent.split(",");
			vHDates = HDates.split(",");
			vHPenaltyCut = HPenaltyCut.split(",");
		}
		
String url="docId="+docId+"&ProjectFromDept="+ProjectFromDept+"&Xmzb="+Xmzb+"&ProjectNo="+ProjectNo+"&Xmzb="+Xmzb+"&ProjectName="+ProjectName+"&EquipTypeS="+EquipTypeS;
url=url+"&HRentList="+HRentList+"&HRent="+HRent+"&HDates="+HDates+"&HDates="+HDates+"&HPenaltyCut="+HPenaltyCut;


String remark="";
String sqlstr="select print_remark from project_penalty_print where doc_id='"+docId+"'";

ResultSet rs=db.executeQuery(sqlstr);
if(rs.next()){
 remark=java.net.URLDecoder.decode(getDBStr(rs.getString("print_remark")));
}
if(rs!=null){rs.close();}
if(db!=null){db.close();}

%>
<body>
<%=vHRentList.length%>

<input type="button" value="打印" onclick="javascript:yincang();" name="printB2"/>
<input type="button" value="乱码转译" onclick="javascript:zy();" id="printB23"/>
<%if(!isEd.equals("0")){ %>
<input type="button" value="编辑" id="upd" name="upd" onclick="javascript:window.location.href='project_penalty_upd.jsp?<%=url%>'"/>
<%} %>


      <!-- 项目信息 -->
      <h3 align="center" style="font-family: 楷体_GB2312;">罚息减免审批</h3>
      <table align="center" cellpadding="3" cellspacing="0" style="width:700px">
        <tr height="40">
          <td colspan="4" bgcolor="#FFFFFF" align="right"  style="border-left: none;border-right: none;border-top: none;">
          日期：<%=time %></td>
        </tr>
        <tr height="60">
          <td bgcolor="#FFFFFF" width="20%" align="center">出单部门</td>
          <td bgcolor="#FFFFFF" width="30%"><%=ProjectFromDept %></td>
          <td bgcolor="#FFFFFF" width="20%" align="center">项目经理</td>
          <td bgcolor="#FFFFFF" width="30%" ><%=Xmzb %></td>
        </tr>
        <tr height="60">
          <td bgcolor="#FFFFFF" width="20%" align="center">项目编号</td>
          <td bgcolor="#FFFFFF" width="30%"><%=ProjectNo %></td>
          <td bgcolor="#FFFFFF" width="20%" align="center">项目所属板块</td>
          <td bgcolor="#FFFFFF" width="30%" ><%=EquipTypeS%></td>
        </tr>
        <tr height="60">
          <td bgcolor="#FFFFFF" width="20%" align="center">项目名称</td>
          <td colspan="3" bgcolor="#FFFFFF"><%=ProjectName %></td>
        </tr>
		<tr height="35">
          <td bgcolor="#FFFFFF" colspan="4"align="center">申请减免罚息明细</td>
        </tr>
         <tr height="35">
          <td colspan="4" style="margin:0px;padding:0px">
		           <table align="center" cellpadding="3" cellspacing="0" style="margin:0px;padding:0px;width:700px">
				        
                          <tr height="35">
							  <td bgcolor="#FFFFFF" width="20%">序号</td>
							  <td bgcolor="#FFFFFF" width="20%">逾期租金期次</td>
							  <td bgcolor="#FFFFFF" width="20%">逾期租金</td>
							  <td bgcolor="#FFFFFF" width="20%">逾期天数</td>
							  <td bgcolor="#FFFFFF" width="20%">申请减免罚息</td>							  
						 </tr>
                         <%
						 for(int i=0;i<vHRentList.length;i++)
						      
						 {%>
						 <tr height="35">
						      <td bgcolor="#FFFFFF" width="20%"><%=i+1%></td>
							  <td bgcolor="#FFFFFF" width="20%"><%=vHRentList[i]%></td>
							  <td bgcolor="#FFFFFF" width="20%"><%=vHRent[i]%></td>
							  <td bgcolor="#FFFFFF" width="20%"><%=vHDates[i]%></td>
							  <td bgcolor="#FFFFFF" width="20%"><%=vHPenaltyCut[i]%></td> 
                         </tr>
                         <%}%>
						 <tr height="35">
							  <td bgcolor="#FFFFFF" width="20%">小计</td>
							  <td bgcolor="#FFFFFF" width="20%"></td>
							  <td bgcolor="#FFFFFF" width="20%" id="allrent"></td>
							  <td bgcolor="#FFFFFF" width="20%"></td>
							  <td bgcolor="#FFFFFF" width="20%" id="allpenalty"></td>							  
						 </tr>
				   </table>
		  
		  
		  </td>
        </tr>
        <tr height="35">
          <td bgcolor="#FFFFFF" width="20%" align="left"  >备注</td>
          <td colspan="3" bgcolor="#FFFFFF"> <%=remark%></td>
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
    document.getElementsByName("upd")[0].style.display="none";
	window.print();
}

function zy(){
//alert(2);
	window.location.href = window.location.href+'&1=1';
	//alert(2);
	window.reload();
	//alert(1);
}
function initSum(){
    var tempRent="<%=HRent%>";
	var tempPenalty="<%=HPenaltyCut%>";
	var vRent=tempRent.split(",");
	var vPenalty=tempPenalty.split(",");
	var sum=0;
	for(var i=0;i<vRent.length;i++){
	   sum=parseFloat(sum)+parseFloat(vRent[i]);
	} 
    document.getElementById("allrent").innerText=sum.toFixed(2);
	sum=0
	for(var i=0;i<vPenalty.length;i++){
	   sum=parseFloat(sum)+parseFloat(vPenalty[i]); 
	} 
    document.getElementById("allpenalty").innerText=sum.toFixed(2);
}

initSum();
</script>
</html>