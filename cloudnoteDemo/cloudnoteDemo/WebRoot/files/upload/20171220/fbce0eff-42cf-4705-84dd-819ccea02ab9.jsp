<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@page import="com.tenwa.util.CurrencyUtil"%>
<%@page import="java.util.Date"%>
<%@ include file="../../public/simpleHeadImport.jsp"%>
<jsp:useBean id="db1" scope="page" class="dbconn.Conn" />
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<title>��ǰ�����������</title>
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
	  String DocId=  getStr(request.getParameter("DocId"));	
	  String EquipTypes=  getStr(request.getParameter("EquipTypes"));
	  String ProjectMoney=  getStr(request.getParameter("ProjectMoney")).replaceAll(",","");
	  String Zllx=  getStr(request.getParameter("Zllx"));
	  String Contractid=  getStr(request.getParameter("Contractid"));
	  String ProjectNo=  getStr(request.getParameter("ProjectNo"));
	  String ProjectFromDept=  getStr(request.getParameter("ProjectFromDept"));
	  String Xmzb=  getStr(request.getParameter("Xmzb"));
	  String ProjectName=  getStr(request.getParameter("ProjectName"));
	  String custid=  getStr(request.getParameter("custid"));
      String BeginId=  getStr(request.getParameter("BeginId"));
	 		  
	  String [] BeginIds = {};
		if(BeginId.contains(",")){
			BeginIds=BeginId.split(",");
		}else if(BeginId.contains(";")){
			
			BeginIds=BeginId.split(";");
		}else{
		  BeginIds=BeginId.split(",");
		}
      String sumpenalty="";//��Ϣ
      String sum_guarantee_money="";//��֤��
      String sum_over_rent="";//ʣ����𱾽�
      String sum_nominal_price="";  //��ֵ����   
      String sum_before_interest="";// ��ǰ���岹����Ϣ
      String advance_date="";//��ǰ����֧������Ϣ
     //����ǰ��������
      Double rent=0.0;
	  Double sumagree_penalty=0.0;//�̶���Ϣ(��Ϣ)
	  Double sumguarantee_money=0.0;//��֤��
	  Double sumnominal_price=0.0;//��ֵ����
	  Double suminterest_income=0.0;//������Ϣ����
	  Double sumcur_interest=0.0;//֧������Ϣ
	  Double sumtotal=0.0;//��ǰ�����
	  Double sumovercorpus=0.0;//ʣ�౾��
	 String hlrent="";
	 String hlcorpus="";
	  Double sumghlrent=0.0;//���ջ����
	  Double sumghlcorpus=0.0;//���ջ����
      String beginid="";
      String sqlstr="";
	  String sqlstr1="";
	  ResultSet rs = null; 
      for(int i=0;i<BeginIds.length;i++){
    	  beginid= BeginIds[i];
    	   sqlstr="select * from contract_advance_temp where contract_id='"+Contractid+"' and begin_id='"+beginid+"' and doc_id='"+DocId+"'";		  
    	 rs=  db1.executeQuery(sqlstr);
		%>	
        <%
		if(rs.next()){
		String  over_rent=rs.getString("over_rent");
		rent=rent+Double.parseDouble(over_rent);//Ԥ�����		
		String over_corpus=rs.getString("over_corpus");
		sumovercorpus=sumovercorpus+Double.parseDouble(over_corpus);//ʣ�౾��
		
		String  agree_penalty=rs.getString("agree_penalty");//�̶���Ϣ
		sumagree_penalty=sumagree_penalty+Double.parseDouble(agree_penalty);
		String  guarantee_money=rs.getString("guarantee_money");//��֤��
		sumguarantee_money=sumguarantee_money+Double.parseDouble(guarantee_money);
		String  nominal_price=rs.getString("nominal_price");//��ֵ����
		sumnominal_price=sumnominal_price+Double.parseDouble(nominal_price);
		String  interest_income=rs.getString("interest_income");//������Ϣ����
		suminterest_income=suminterest_income+Double.parseDouble(interest_income);
		String  cur_interest=rs.getString("cur_interest");//֧������Ϣ
		sumcur_interest=sumcur_interest+Double.parseDouble(cur_interest);
		String  total=rs.getString("total");//��ǰ�����
		sumtotal=sumtotal+Double.parseDouble(total);
		advance_date=rs.getString("advance_date");//��ǰ��������
		
			}
 
    	System.out.println("������"+sqlstr);
      }	 
  rs.close();

   for(int i=0;i<BeginIds.length;i++){
    	  beginid= BeginIds[i];
    sqlstr="select sum(rent) as hlrent ,sum(corpus) as hlcorpus from fund_rent_plan_temp where  oth_remark='�����ǰ' and plan_status='�ѻ���' and contract_id='"+Contractid+"' and begin_id='"+beginid+"' and doc_id='"+DocId+"'";
   }
  rs= db1.executeQuery(sqlstr);

  if(rs.next()){
  hlrent= rs.getString("hlrent");
  sumghlrent=sumghlrent+Double.parseDouble(hlrent);
  hlcorpus=rs.getString("hlcorpus");
  sumghlcorpus=sumghlcorpus+Double.parseDouble(hlcorpus);
	rs.close();
  }
  if(sumghlrent==null){
  sumghlrent=0.00;
  }
  if(sumghlcorpus==null){
  sumghlcorpus=0.00;
  }
  BigDecimal big = new BigDecimal(sumghlrent); 
  BigDecimal small = new BigDecimal(sumghlcorpus);
  big=big.setScale(2,BigDecimal.ROUND_HALF_DOWN);
  small=small.setScale(2,BigDecimal.ROUND_HALF_DOWN);
  BigDecimal bagree_penalty = new BigDecimal(sumagree_penalty); 
  BigDecimal bsumguarantee_money = new BigDecimal(sumguarantee_money);
  BigDecimal bnominal_price = new BigDecimal(sumnominal_price); 
  BigDecimal bovercorpus = new BigDecimal(sumovercorpus);
  BigDecimal binterest_income = new BigDecimal(suminterest_income); 
  BigDecimal bcur_interest = new BigDecimal(sumcur_interest);
  BigDecimal bsumtotal = new BigDecimal(sumtotal);

  bagree_penalty=bagree_penalty.setScale(2,BigDecimal.ROUND_HALF_DOWN);
  bsumguarantee_money=bsumguarantee_money.setScale(2,BigDecimal.ROUND_HALF_DOWN);
  bnominal_price=bnominal_price.setScale(2,BigDecimal.ROUND_HALF_DOWN);
  bovercorpus=bovercorpus.setScale(2,BigDecimal.ROUND_HALF_DOWN);
  binterest_income=binterest_income.setScale(2,BigDecimal.ROUND_HALF_DOWN);
  bcur_interest=bcur_interest.setScale(2,BigDecimal.ROUND_HALF_DOWN);
   bsumtotal=bsumtotal.setScale(2,BigDecimal.ROUND_HALF_DOWN);
%>
<body>

<input type="button" value="��ӡ" onclick="javascript:yincang();" name="printB2"/>
<input type="button" value="����ת��" onclick="javascript:zy();" id="printB23"/>

      <!-- ��Ŀ��Ϣ -->
	   &nbsp<br/>
	   &nbsp<br/>
      <h3 align="center" style="font-family: ����_GB2312;font-size:20px;color:black;">��Ŀ��ǰ��ֹ������</h3>	  
      <table align="center" cellpadding="3" cellspacing="0" style="width:650px">
	  <tr height="40">
          <td colspan="4" bgcolor="#FFFFFF" align="right"  style="border-left: none;border-right: none;border-top: none;">
          ���ڣ�<%=time %></td>
        </tr>
         <tr height="50">
          <td bgcolor="#FFFFFF" width="20%" align="left">��Ŀ����</td>
          <td colspan="3" bgcolor="#FFFFFF"><%=ProjectName%></td>
        </tr>
        <tr height="50">
          <td bgcolor="#FFFFFF" width="20%" align="left">��Ŀ���</td>
          <td bgcolor="#FFFFFF" width="30%"><%=ProjectNo%></td>
          <td bgcolor="#FFFFFF" width="20%" align="left">��Ŀ�������</td>
          <td bgcolor="#FFFFFF" width="30%" ><%=EquipTypes%></td>
        </tr>
        <tr height="50">
          <td bgcolor="#FFFFFF" width="20%" align="left">��������</td>
          <td bgcolor="#FFFFFF" width="30%"><%=ProjectFromDept%></td>
          <td bgcolor="#FFFFFF" width="20%" align="left">��Ŀ����</td>
          <td bgcolor="#FFFFFF" width="30%" ><%=Xmzb%></td>
        </tr>
         <tr height="50">
          <td bgcolor="#FFFFFF" width="20%" align="left">��������</td>
          <td bgcolor="#FFFFFF" width="30%"><%=Zllx%></td>
          <td bgcolor="#FFFFFF" width="20%" align="left">��Ŀ���</td>
          <td bgcolor="#FFFFFF" width="30%" ><%=CurrencyUtil.convertFinance(ProjectMoney)%></td>
        </tr>  
        <tr height="50">
          <td bgcolor="#FFFFFF" width="20%" align="left">�ѳ������</td>
          <td bgcolor="#FFFFFF" width="30%"><%=CurrencyUtil.convertFinance(String.valueOf(big))%></td>
          <td bgcolor="#FFFFFF" width="20%" align="left">�ѳ�����𱾽�</td>
          <td bgcolor="#FFFFFF" width="30%" ><%=CurrencyUtil.convertFinance(String.valueOf(small))%></td>
        </tr>
         <tr height="50">
          <td bgcolor="#FFFFFF" width="20%" align="left">��Ϣ</td>
          <td bgcolor="#FFFFFF" width="30%"><%=CurrencyUtil.convertFinance(String.valueOf(bagree_penalty))%></td>
          <td bgcolor="#FFFFFF" width="20%" align="left">��֤��</td>
          <td bgcolor="#FFFFFF" width="30%" ><%=CurrencyUtil.convertFinance(String.valueOf(bsumguarantee_money))%></td>
        </tr>   
         <tr height="50">
          <td bgcolor="#FFFFFF" width="20%" align="left">��ֵ����</td>
          <td bgcolor="#FFFFFF" width="30%"><%=CurrencyUtil.convertFinance(String.valueOf(bnominal_price))%></td>
          <td bgcolor="#FFFFFF" width="20%" align="left">ʣ����𱾽�</td>
          <td bgcolor="#FFFFFF" width="30%" ><%=CurrencyUtil.convertFinance(String.valueOf(bovercorpus))%></td>
        </tr>
         <tr height="50">
          <td bgcolor="#FFFFFF" width="20%" align="left">������Ϣ����</td>
          <td bgcolor="#FFFFFF" width="30%"><%=CurrencyUtil.convertFinance(String.valueOf(binterest_income))%></td>
          <td bgcolor="#FFFFFF" width="20%" align="left">֧������Ϣ</td>
          <td bgcolor="#FFFFFF" width="30%" ><%=CurrencyUtil.convertFinance(String.valueOf(bcur_interest))%></td>
        </tr>  
         <tr height="50">
          <td bgcolor="#FFFFFF" width="20%" align="left">��ǰ�������</td>
          <td bgcolor="#FFFFFF" width="30%"><%=CurrencyUtil.convertFinance(String.valueOf(bsumtotal))%></td>
          <td bgcolor="#FFFFFF" width="20%" align="left">����ǰ��������</td>
          <td bgcolor="#FFFFFF" width="30%" ><%=advance_date%></td>
        </tr>
		
        <tr height="50">
          <td bgcolor="#FFFFFF" colspan="4" style="background-color: green;" align="center">�쵼�������</td>
        </tr>       
          <tr>
		
          <td bgcolor="#FFFFFF" height="400" colspan="4" style="padding-top: 100px; ">
          
          </td>
        </tr>

		</table>

		<p>&nbsp;</p>
<input type="button" value="��ӡ" onclick="javascript:yincang();" name="printB1"/>
              						
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
<%if(null != db1){db1.close();}%>