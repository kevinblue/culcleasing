<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@page import="com.tenwa.util.CurrencyUtil"%>
<%@page import="java.util.Date"%>


<%@ include file="../../public/simpleHeadImport.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<title>��ͬ�������뵥</title>
</head>

<style type="text/css">
table{border-collapse:collapse;margin:0 10px;font-size:14px;color:black;background:#fff;font-family: "����_GB2312";}
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
//request.setCharacterEncoding("gbk");
String isEd=getStr(request.getParameter("isEd"));//�Ƿ�ɱ༭
String docId=getStr(request.getParameter("DocID"));
String ProjectFromDept=getStr(request.getParameter("ProjectFromDept"));//��������
String Xmzb=getStr(request.getParameter("Xmzb"));//��Ŀ����
String ProjectNo=getStr(request.getParameter("ProjectNo"));//��Ŀ���
String ProjectName=getStr(request.getParameter("ProjectName"));//��Ŀ����
String EquipTypeS=getStr(request.getParameter("EquipType"));//�ڲ���ҵ
String HRentList=getStr(request.getParameter("HRentList"));//��������ڴ�
String HRent=getStr(request.getParameter("HRent"));//�������
String HDates=getStr(request.getParameter("HDates"));//��������
String HPenaltyCut=getStr(request.getParameter("HPenaltyCut"));//������ⷣϢ
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
<form action="project_penalty_save.jsp" method="post">
<input type="hidden" name="docId" value="<%=docId %>">
<input type="hidden" name="ProjectFromDept" value="<%=ProjectFromDept %>">
<input type="hidden" name="Xmzb" value="<%=Xmzb %>">
<input type="hidden" name="ProjectName" value="<%=ProjectName %>">
<input type="hidden" name="HRentList" value="<%=HRentList %>">
<input type="hidden" name="ProjectNo" value="<%=ProjectNo %>">
<input type="hidden" name="HRent" value="<%=HRent %>">
<input type="hidden" name="HDates" value="<%=HDates %>">
<input type="hidden" name="HPenaltyCut" value="<%=HPenaltyCut%>">
<input type="hidden" name="EquipTypeS" value="<%=EquipTypeS %>">
<input type="button" value="����ת��" onclick="javascript:zy();" id="printB23"/>
<input type="submit" value="����"/>


      <!-- ��Ŀ��Ϣ -->
      <h3 align="center" style="font-family: ����_GB2312;">��Ϣ��������</h3>
      <table align="center" cellpadding="3" cellspacing="0" style="width:700px">
        <tr height="40">
          <td colspan="4" bgcolor="#FFFFFF" align="right"  style="border-left: none;border-right: none;border-top: none;">
          ���ڣ�<%=time %></td>
        </tr>
        <tr height="60">
          <td bgcolor="#FFFFFF" width="20%" align="center">��������</td>
          <td bgcolor="#FFFFFF" width="30%"><%=ProjectFromDept %></td>
          <td bgcolor="#FFFFFF" width="20%" align="center">��Ŀ����</td>
          <td bgcolor="#FFFFFF" width="30%" ><%=Xmzb %></td>
        </tr>
        <tr height="60">
          <td bgcolor="#FFFFFF" width="20%" align="center">��Ŀ���</td>
          <td bgcolor="#FFFFFF" width="30%"><%=ProjectNo %></td>
          <td bgcolor="#FFFFFF" width="20%" align="center">��Ŀ�������</td>
          <td bgcolor="#FFFFFF" width="30%" ><%=EquipTypeS%></td>
        </tr>
        <tr height="60">
          <td bgcolor="#FFFFFF" width="20%" align="center">��Ŀ����</td>
          <td colspan="3" bgcolor="#FFFFFF"><%=ProjectName %></td>
        </tr>
		<tr height="35">
          <td bgcolor="#FFFFFF" colspan="4"align="center">������ⷣϢ��ϸ</td>
        </tr>
         <tr height="35">
          <td colspan="4" style="margin:0px;padding:0px">
		           <table align="center" cellpadding="3" cellspacing="0" style="margin:0px;padding:0px;width:700px">
				        
                          <tr height="35">
							  <td bgcolor="#FFFFFF" width="20%">���</td>
							  <td bgcolor="#FFFFFF" width="20%">��������ڴ�</td>
							  <td bgcolor="#FFFFFF" width="20%">�������</td>
							  <td bgcolor="#FFFFFF" width="20%">��������</td>
							  <td bgcolor="#FFFFFF" width="20%">������ⷣϢ</td>							  
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
							  <td bgcolor="#FFFFFF" width="20%">С��</td>
							  <td bgcolor="#FFFFFF" width="20%"></td>
							  <td bgcolor="#FFFFFF" width="20%" id="allrent"></td>
							  <td bgcolor="#FFFFFF" width="20%"></td>
							  <td bgcolor="#FFFFFF" width="20%" id="allpenalty"></td>							  
						 </tr>
				   </table>
		  
		  
		  </td>
        </tr>
        <tr height="35">
          <td bgcolor="#FFFFFF" width="20%" align="left"  >��ע</td>
          <td colspan="3" bgcolor="#FFFFFF">
          <textarea rows="3" cols="70" name="remark" ><%=remark %></textarea>
          </td>
        </tr>
        <tr height="35">
          <td bgcolor="#FFFFFF"  colspan="4" width="100%"  style="padding-left:10px" >ȷ����Ϣ</td>
        </tr>
		<tr height="50">
          <td bgcolor="#FFFFFF"  colspan="4" width="100%" style="padding-left:10px" >��ҵ��ȷ��</td>
        </tr>
		  <tr height="35">
          <td bgcolor="#FFFFFF" width="20%" align="center">�ʲ�����Ա</td>
          <td bgcolor="#FFFFFF"></td>
          <td bgcolor="#FFFFFF" width="20%" align="center">��ҵ��������</td>
          <td bgcolor="#FFFFFF"></td>
        </tr>
		<tr height="50">
          <td bgcolor="#FFFFFF" colspan="4" width="100%" style="padding-left:10px" >����ȷ��</td>
          
        </tr>
        <tr height="35">
          <td bgcolor="#FFFFFF" width="20%" align="center">��Ŀִ�й�����</td>
          <td bgcolor="#FFFFFF"></td>
          <td bgcolor="#FFFFFF" width="20%" align="center">���񲿸�����</td>
          <td bgcolor="#FFFFFF"></td>
        </tr>
        <tr height="50">
          <td bgcolor="#FFFFFF" colspan="4" width="100%"  style="padding-left:10px" >�ڿ����ʲ�����ȷ��</td>
        </tr>
         <tr height="50">
          <td bgcolor="#FFFFFF" width="20%" align="center">�ڿ����ʲ�����������</td>
          <td colspan="3" bgcolor="#FFFFFF"></td>
        </tr>
		 <tr height="50">
          <td bgcolor="#FFFFFF" width="20%" align="center">���ܲ����ܾ���</td>
          <td colspan="3" bgcolor="#FFFFFF"></td>
        </tr>
		 <tr height="50">
          <td bgcolor="#FFFFFF" width="20%" align="center">�ܾ���</td>
          <td colspan="3" bgcolor="#FFFFFF"></td>
        </tr>

<p>&nbsp;</p>
<input type="button" value="��ӡ" onclick="javascript:yincang();" name="printB1"/>
</form>
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