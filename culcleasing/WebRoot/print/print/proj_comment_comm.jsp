<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@page import="com.tenwa.util.CurrencyUtil"%>
<%@page import="java.util.Date"%>s
<%@ include file="../../public/simpleHeadImport.jsp"%>
<jsp:useBean id="db1" scope="page" class="dbconn.Conn" />
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<title>提前结清款审批单</title>
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

  
	  String DocId=  getStr(request.getParameter("DocId"));	
	  String EquipTypes=  getStr(request.getParameter("EquipTypes"));
	  String ProjectMoney=  getStr(request.getParameter("ProjectMoney"));
	  String Zllx=  getStr(request.getParameter("Zllx"));
	  String Contractid=  getStr(request.getParameter("Contractid"));
	  String ProjectNo=  getStr(request.getParameter("ProjectNo"));
	  String ProjectFromDept=  getStr(request.getParameter("ProjectFromDept"));
	  String Xmzb=  getStr(request.getParameter("Xmzb"));
	  String ProjectName=  getStr(request.getParameter("ProjectName"));
	  String custid=  getStr(request.getParameter("custid"));
      String BeginId=  getStr(request.getParameter("BeginId"));
	  String[] BeginIds= BeginId.split(",");
      String sumpenalty="";//罚息
      String sum_guarantee_money="";//保证金
      String sum_over_rent="";//剩余租金本金
      String sum_nominal_price="";  //残值收入   
      String sum_before_interest="";// 提前结清补偿利息
      String advance_date="";//提前结清支付日利息
     //拟提前结清日期
      Double rent=0.0;
	  Double sumagree_penalty=0.0;//商定罚息(罚息)
	  Double sumguarantee_money=0.0;//保证金
	  Double sumnominal_price=0.0;//残值收入
	  Double suminterest_income=0.0;//补偿利息收入
	  Double sumcur_interest=0.0;//支付日利息
	  Double sumtotal=0.0;//提前结清款
	  Double sumovercorpus=0.0;//剩余本金
	  String hlrent="";//已收回本金
	  String hlcorpus="";  //已经收回本金
      String beginid="";
      String sqlstr="";
	  String sqlstr1="";
	  ResultSet rs = null;
	
	  
      for(int i=0;i<BeginIds.length;i++){
    	  beginid= BeginIds[i];
    	   sqlstr="select * from contract_advance_temp where contract_id='"+Contractid+"' and begin_id='"+beginid+"' and doc_id='"+DocId+"'";
		  

    	 rs=  db1.executeQuery(sqlstr);
		%>
		<%=sqlstr%>
        <%
		if(rs.next()){
		String  over_rent=rs.getString("over_rent");
		rent=rent+Double.parseDouble(over_rent);//预期租金
		String over_corpus=rs.getString("over_corpus");
		sumovercorpus=sumovercorpus+Double.parseDouble(over_corpus);//剩余本金
		String  agree_penalty=rs.getString("agree_penalty");//商定罚息
		sumagree_penalty=sumagree_penalty+Double.parseDouble(agree_penalty);
		String  guarantee_money=rs.getString("guarantee_money");//保证金
		sumguarantee_money=sumagree_penalty+Double.parseDouble(guarantee_money);
		String  nominal_price=rs.getString("nominal_price");//残值收入
		sumnominal_price=sumagree_penalty+Double.parseDouble(nominal_price);
		String  interest_income=rs.getString("interest_income");//补偿利息收入
		suminterest_income=suminterest_income+Double.parseDouble(interest_income);
		String  cur_interest=rs.getString("cur_interest");//支付日利息
		sumcur_interest=sumcur_interest+Double.parseDouble(cur_interest);
		String  total=rs.getString("total");//提前结清款
		sumtotal=sumtotal+Double.parseDouble(total);
		advance_date=rs.getString("advance_date");//提前结清日期
		%>
		<%=sqlstr%>
		over_rent:<%=over_rent%>
		
		<%
			}
	//	rent=rent+ParseInt.(over_rent);
    //	rent=rent+Double.parseDouble(over_rent);
    	 
    	System.out.println("输出语句"+sqlstr);
      }	 
  rs.close();

   for(int i=0;i<BeginIds.length;i++){
    	  beginid= BeginIds[i];
    sqlstr="select sum(rent) as hlrent ,sum(corpus) as hlcorpus from fund_rent_plan_temp where  oth_remark='租金变更后' and contract_id='"+Contractid+"' and begin_id='"+beginid+"' and doc_id='"+DocId+"'";
   }
  rs= db1.executeQuery(sqlstr);

  if(rs.next()){
    hlrent= rs.getString("hlrent");
	hlcorpus=rs.getString("hlcorpus");
  }
  if(hlrent==null){
  hlrent="0.00";
  }
    if(hlcorpus==null){
  hlcorpus="0.00";
  }

      
%>
sqlstr<%=sqlstr%>
rent:<%=rent%>
DocId:<%=DocId%>
Contractid:<%=Contractid%>
EquipTypes:<%=EquipTypes%>
ProjectMoney:<%=ProjectMoney%>
<br>
Zllx:<%=Zllx%>
ProjectNo:<%=ProjectNo%>
ProjectFromDept:<%=ProjectFromDept%>
Xmzb:<%=Xmzb%>
ProjectName:<%=ProjectName%>
custid:<%=custid%>
BeginId:<%=BeginId%>
<br>
rent:<%=rent%>
罚息：sumagree_penalty:<%=sumagree_penalty%>
保证金：sumguarantee_money:<%=sumguarantee_money%>
残值收入:sumnominal_price<%=sumnominal_price%>
<br>
补偿利息收入：suminterest_income:<%=suminterest_income%>
支付日利息:sumcur_interest:<%=sumcur_interest%>
提前结清款:sumtotal:<%=sumtotal%>
提前结清日期:advance_date:<%=advance_date%>

hlrent:<%=hlrent%>
hlcorpus:<%=hlcorpus%>
<body>

<input type="button" value="打印" onclick="javascript:yincang();" name="printB2"/>
<input type="button" value="乱码转译" onclick="javascript:zy();" id="printB23"/>

      <!-- 项目信息 -->
      <h3 align="center" style="font-family: 楷体_GB2312;">提前结清款构成</h3>
      <table align="center" cellpadding="3" cellspacing="0" style="width:800px">
         <tr height="35">
          <td bgcolor="#FFFFFF" width="20%" align="center">项目名称</td>
          <td colspan="3" bgcolor="#FFFFFF"><%=ProjectName%></td>
        </tr>
        <tr height="35">
          <td bgcolor="#FFFFFF" width="20%" align="center">项目编号</td>
          <td bgcolor="#FFFFFF" width="30%"><%=ProjectNo%></td>
          <td bgcolor="#FFFFFF" width="20%" align="center">项目所属板块</td>
          <td bgcolor="#FFFFFF" width="30%" ><%=ProjectFromDept%></td>
        </tr>
        <tr height="35">
          <td bgcolor="#FFFFFF" width="20%" align="center">出单部门</td>
          <td bgcolor="#FFFFFF" width="30%"><%=EquipTypes%></td>
          <td bgcolor="#FFFFFF" width="20%" align="center">项目经理</td>
          <td bgcolor="#FFFFFF" width="30%" ><%=Xmzb%></td>
        </tr>
         <tr height="35">
          <td bgcolor="#FFFFFF" width="20%" align="center">租赁类型</td>
          <td bgcolor="#FFFFFF" width="30%"><%=Zllx%></td>
          <td bgcolor="#FFFFFF" width="20%" align="center">项目金额</td>
          <td bgcolor="#FFFFFF" width="30%" ><%=ProjectMoney%></td>
        </tr>  
        <tr height="35">
          <td bgcolor="#FFFFFF" width="20%" align="center">已偿还租金</td>
          <td bgcolor="#FFFFFF" width="30%"><%=hlrent%></td>
          <td bgcolor="#FFFFFF" width="20%" align="center">已偿还租金本金</td>
          <td bgcolor="#FFFFFF" width="30%" ><%=hlcorpus%></td>
        </tr>
         <tr height="35">
          <td bgcolor="#FFFFFF" width="20%" align="center">罚息</td>
          <td bgcolor="#FFFFFF" width="30%"><%=sumagree_penalty%></td>
          <td bgcolor="#FFFFFF" width="20%" align="center">保证金</td>
          <td bgcolor="#FFFFFF" width="30%" ><%=sumguarantee_money%></td>
        </tr>   
         <tr height="35">
          <td bgcolor="#FFFFFF" width="20%" align="center">残值收入</td>
          <td bgcolor="#FFFFFF" width="30%"><%=sumnominal_price%></td>
          <td bgcolor="#FFFFFF" width="20%" align="center">剩余租金本金</td>
          <td bgcolor="#FFFFFF" width="30%" ><%=sumovercorpus%></td>
        </tr>
         <tr height="35">
          <td bgcolor="#FFFFFF" width="20%" align="center">补偿利息收入</td>
          <td bgcolor="#FFFFFF" width="30%"><%=sumnominal_price%></td>
          <td bgcolor="#FFFFFF" width="20%" align="center">支付日利息</td>
          <td bgcolor="#FFFFFF" width="30%" ><%=sumcur_interest%></td>
        </tr>  
         <tr height="35">
          <td bgcolor="#FFFFFF" width="20%" align="center">提前结清款金额</td>
          <td bgcolor="#FFFFFF" width="30%"><%=sumtotal%></td>
          <td bgcolor="#FFFFFF" width="20%" align="center">拟提前结清日期</td>
          <td bgcolor="#FFFFFF" width="30%" ><%=advance_date%></td>
        </tr>  
        <tr height="25">
          <td bgcolor="#FFFFFF" colspan="4" style="background-color: green;" align="center">领导审批意见</td>
        </tr>       
          <tr>
		
          <td bgcolor="#FFFFFF" height="100" colspan="4" style="padding-top: 50px;border-left:none; ">
          
          </td>
        </tr>
         </table>     
						
	
<p>&nbsp;</p>
<input type="button" value="打印" onclick="javascript:yincang();" name="printB1"/>
</body>
<script type="text/javascript"><!--
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