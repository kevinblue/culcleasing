<%@ page contentType="text/html; charset=gbk" language="java"  %>
<%@ page import="dbconn.*" %> 
<%@ page import="java.sql.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ include file="../../func/common.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>������ - �������ѯ</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/validator.js"></script>
<script type="text/javascript">
function addText(proj_id,measure_type)
{
    //document.form1.textOne.value = proj_id;
    alert(proj_id);
} 
</script>
</head>
<%
	ResultSet rs;
	String sqlstr = "";
	String wherestr = " where 1=1";
	
	String proj_id = getStr(request.getParameter("proj_id"));//��Ŀ���
	String doc_id = getStr(request.getParameter("doc_id"));//�ĵ����
	String measure_type = getStr(request.getParameter("measure_type"));//�����㷽��
	String temp_type = getStr(request.getParameter("temp_type"));//�����ж��Ƿ���ֻ��ҳ�� zhiduPage
	if(temp_type.equals("") || temp_type == null){
		temp_type = "no_zhidu";
	}
	String equip_amt = "";//�豸��
	String caution_money = "";//��֤��
	String handling_charge = "";//������
	String start_date = "";//������
	String year_rate = "";//������
	String income_number = "";//����
	String lease_money = "";//���ޱ���
	String period_type = "";//��������
	String income_number_year = "";//���ⷽʽ
	String consulting_fee = "";//��ѯ��
	
	//������Ҫ��ֵ���ֶΡ��޸�ʱ��2010-06-29��
	String net_lease_money = "";//�����ʶ� 
	String nominalprice = "";//��ĩ��ֵ
	String income_day = "";//ÿ�³�����
	String other_expenditure = "";//����֧��
	String return_amt = "";//���̷���
	String other_income = "";//��������
	String first_payment = "";//�׸��� 
	
	String before_interest = "";//��ǰϢ��2010-07-23�޸ġ�
	
	String accountPrincipal = "";//��ƺ��㱾��2010-08-06�޸ġ�
	String rentScale = "";//Բ������2010-08-20������
	
	//String plan_status = "";//����״̬
	String creator = "";//
	String create_date = "";//
	String modificator = "";//
	String modify_date = "";//
	if(measure_type.equals("") && measure_type != null){
		StringBuffer sql = new StringBuffer();
		//��ѯ��Ŀ���׽ṹ��
		sql.append(" select *  from proj_condition_temp  ")
		   .append(" where proj_id = '"+proj_id+"' and measure_id = '"+doc_id+"' ");
		//System.out.println("^^^^^^^^^^^join^^^^^^^"+sql);
		rs = db.executeQuery(sql.toString());
		while(rs.next()){
			measure_type = getDBStr(rs.getString("measure_type"));
			equip_amt = getDBStr(rs.getString("equip_amt"));
			caution_money = getDBStr(rs.getString("caution_money"));
			handling_charge = getDBStr(rs.getString("handling_charge"));
			start_date = getDBStr(rs.getString("start_date"));
			year_rate = getDBStr(rs.getString("year_rate"));
			income_number = getDBStr(rs.getString("income_number"));
			lease_money = getDBStr(rs.getString("lease_money"));
			period_type = getDBStr(rs.getString("period_type"));
			income_number_year = getDBStr(rs.getString("income_number_year"));
			consulting_fee = getDBStr(rs.getString("consulting_fee"));
			//plan_status = getDBStr(rs.getString("plan_status"));
			creator = getDBStr(rs.getString("creator"));
			create_date = getDBStr(rs.getString("create_date"));
			modificator = getDBStr(rs.getString("modificator"));
			modify_date = getDBStr(rs.getString("modify_date"));
			//&&&&&&&&&&&&&&&&����ȡֵ���޸�ʱ��2010-06-29��
			net_lease_money = getDBStr(rs.getString("net_lease_money"));
			nominalprice = getDBStr(rs.getString("nominalprice"));
			income_day = getDBStr(rs.getString("income_day"));
			other_expenditure = getDBStr(rs.getString("other_expenditure"));
			return_amt = getDBStr(rs.getString("return_amt"));
			other_income = getDBStr(rs.getString("other_income"));
			first_payment = getDBStr(rs.getString("first_payment"));
			before_interest = getDBStr(rs.getString("before_interest"));
			accountPrincipal = getDBStr(rs.getString("accountPrincipal"));
			rentScale = getDBStr(rs.getString("rentScale"));
		}
		//System.out.println("measure_type��ֵΪ:^^^^^^^"+measure_type);
	}
	
	//�����ƻ�
	String rent_list="";
	String plan_date="";
	String rent="";
	String corpus="";
	String interest="";
	String rent_adjust="";
	String rent_overage="";
	String corpus_overage="";
	String plan_status="";
	List l_rent_list = new ArrayList();
	List l_plan_date = new ArrayList();
	List l_rent = new ArrayList();
	List l_corpus = new ArrayList();
	List l_interest = new ArrayList();
	List l_rent_overage = new ArrayList();//ʣ�����
	List l_corpus_overage = new ArrayList();//ʣ�౾��
	List l_plan_status = new ArrayList();//����״̬
	//List l_rent_adjust = new ArrayList();
	//contract_id='"+contract_id+"' ��ʱ����
	
	sqlstr = "select * from fund_rent_plan_proj_temp where   proj_id='"+proj_id+"' and measure_id='"+doc_id+"' order by rent_list";
//	rs = db.executeQuery(sqlstr);
//	rs.last(); 
//	int rowCount = rs.getRow();//�ж���ʱ�����Ƿ���ֵ
//	rs.beforeFirst(); //��Ҫ�õ���¼�����Ͱ�ָ�����Ƶ���ʼ����λ��
//	if(rowCount <= 0){//��ʱ������ֵ���ѯ��ʽ����ʽ�����ֵ����ʽ���е����ݲ��뵽��Ӧ�������ʱ����
//		String query_sql =  "select * from fund_rent_plan_proj   where  proj_id = '"+proj_id+"' ";
//		rs = db.executeQuery(query_sql);
//		rs.last(); 
//		rowCount = rs.getRow();// 
//		rs.beforeFirst(); // 
//		if(rowCount > 0){
//			StringBuffer insert_sql = new StringBuffer();
//			insert_sql.append(" INSERT INTO fund_rent_plan_proj_temp( ")
//			          .append(" proj_id,rent_list,plan_status,plan_date,eptd_rent, ")
//			          .append(" rent,corpus,year_rate,interest,rent_overage,corpus_overage, ")
//			          .append(" interest_overage,penalty_overage,penalty,rent_type ")
//			          .append(" ,creator,create_date,modificator,modify_date ")
//			          .append(" ,measure_id ")//���ֶ���ʽ����û��
//			          .append(" ,corpus_market ")//�г����� �������ֶ� 2010-07-27��
//			          .append(" ,interest_market ")//�г���Ϣ �������ֶ� 2010-07-27��
//			          .append(" ,corpus_overage_market) ")//�г������������ֶ� 2010-07-27��
//			          .append(" select ")
//			          .append(" proj_id,rent_list,plan_status,plan_date,eptd_rent ")
//			          .append(" ,rent,corpus,year_rate,interest,rent_overage,corpus_overage ")
//			          .append(" ,interest_overage,penalty_overage,penalty,rent_type ")
//			          .append(" ,creator,create_date,modificator,modify_date ")
//			          .append(" ,'"+doc_id+"'")
//			          .append(" ,corpus_market,interest_market,corpus_overage_market") //�������ֶ� 2010-07-27��
//			          .append(" from fund_rent_plan_proj ")
//			          .append("  where  proj_id = '"+proj_id+"'  ");
//			 db.executeUpdate(insert_sql.toString());
//		 }
//	}
	 rs = db.executeQuery(sqlstr);
//System.out.println("�������ѯ��ҳ���ѯSQL����������������"+sqlstr);
	while(rs.next()){
		rent_list = getDBStr(rs.getString("rent_list"));
		plan_date = getDBDateStr(rs.getString("plan_date"));
		rent = formatNumberDoubleTwo(getDBStr(rs.getString("rent")));
		corpus = formatNumberDoubleTwo(getDBStr(rs.getString("corpus")));
		interest = formatNumberDoubleTwo(getDBStr(rs.getString("interest")));
		rent_overage = formatNumberDoubleTwo(getDBStr(rs.getString("rent_overage")));
		corpus_overage = formatNumberDoubleTwo(getDBStr(rs.getString("corpus_overage")));
		plan_status = getDBStr(getDBStr(rs.getString("plan_status")));
		//rent_adjust = formatNumberDoubleTwo(getDBStr(rs.getString("rent_adjust")));
		l_rent_list.add(rent_list);
		l_plan_date.add(plan_date);
		l_rent.add(rent);
		l_corpus.add(corpus);
		l_interest.add(interest);
		l_rent_overage.add(rent_overage);
		l_corpus_overage.add(corpus_overage);
		l_plan_status.add(plan_status);
		//l_rent_adjust.add(rent_adjust);
	}
	
	//��ѯ��𱾽���Ϣ�������ֱ���ܺ�
	String query_count = "select sum(rent) as count_rent,sum(corpus) as count_corpus,sum(interest) as count_interest from fund_rent_plan_proj_temp  where   proj_id='"+proj_id+"' and measure_id='"+doc_id+"'";
	rs = db.executeQuery(query_count);
	String  count_rent = "";
	String  count_corpus = "";
	String  count_interest = "";
	while(rs.next()){
		count_rent = formatNumberDoubleTwo(getDBStr(rs.getString("count_rent")));
		count_corpus = formatNumberDoubleTwo(getDBStr(rs.getString("count_corpus")));
		count_interest = formatNumberDoubleTwo(getDBStr(rs.getString("count_interest")));
	}

	rs.close();
	db.close();
	int countSize = l_rent_list.size();//��ȡ��������
	//System.out.println(getDateAdd("2009-01-31",1,"mm").substring(0,8)+"15");
 %>
<body style="overflow:auto;" >
<form name="form1" method="post" target="_black" action="rentplan_sc.jsp" ><!-- onSubmit="return checkdata(this);"  -->
<%
	//��� �����㷽�� ѡΪ ������ ���Ҳ�Ϊ �ֹ�����ʱ 
	if(measure_type.equals("00")  && !measure_type.equals("3")){
%>  
<table  class="title_top" width=100% align=center cellspacing=0 border="0" cellpadding="0">
	<tr valign="top">
		<td  align=center width=100%>
			<table align=center width=96%  border="0" cellspacing="0" cellpadding="0" style="margin-top:0px">
				<tr>
					<td>
						<table border="0" cellspacing="0" cellpadding="0">    
							<tr class="maintab_dh">
								<td nowrap >&nbsp;&nbsp; 
									<BUTTON class="btn_2" name="btnSave" value="������"  type="submit">
									<img src="../../images/save.gif" align="absmiddle" border="0">������</button>	
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<%
	}
%>
<!-- ������ֵ���ĵ���ţ���Ŀ��ţ������ܺ�  -->
<input type="hidden" name="doc_id" value="<%=doc_id%>">
<input type="hidden" name="proj_id" value="<%=proj_id %>">
<input type="hidden" name="countSize" value="<%=countSize%>">
<!-- �豸��,��֤��,������,������ -->
<input type="hidden" name="equip_amt" value="<%=equip_amt%>">
<input type="hidden" name="caution_money" value="<%=caution_money%>">
<input type="hidden" name="handling_charge" value="<%=handling_charge%>">
<input type="hidden" name="start_date" value="<%=start_date%>">
<!-- ������,����,���ޱ���,��������,���ⷽʽ,�����㷽��,��ѯ�� -->
<input type="hidden" name="year_rate" value="<%=year_rate%>">
<input type="hidden" name="income_number" value="<%=income_number%>">
<input type="hidden" name="lease_money" value="<%=lease_money%>">
<input type="hidden" name="period_type" value="<%=period_type%>">
<input type="hidden" name="income_number_year" value="<%=income_number_year%>">
<input type="hidden" name="measure_type" value="<%=measure_type%>">
<input type="hidden" name="consulting_fee" value="<%=consulting_fee%>">
<!-- �����ˣ��������ڣ��޸��ˣ��޸����� -->
<input type="hidden" name="creator" value="<%=creator%>">
<input type="hidden" name="create_date" value="<%=create_date%>">
<input type="hidden" name="modificator" value="<%=modificator%>">
<input type="hidden" name="modify_date" value="<%=modify_date%>">
<!-- �����ʶ��ĩ��ֵ��ÿ�³����գ�����֧�������̷������������룬�׸��� -->
<input type="hidden" name="net_lease_money" value="<%=net_lease_money%>">
<input type="hidden" name="nominalprice" value="<%=nominalprice%>">
<input type="hidden" name="income_day" value="<%=income_day%>">
<input type="hidden" name="other_expenditure" value="<%=other_expenditure%>">
<input type="hidden" name="return_amt" value="<%=return_amt%>">
<input type="hidden" name="other_income" value="<%=other_income%>">
<input type="hidden" name="first_payment" value="<%=first_payment%>">
<!-- ��ǰϢ��2010-07-23������ -->
<input type="hidden" name="before_interest" value="<%=before_interest%>">
<!-- ��ƺ��㱾��2010-08-06������ -->
<input type="hidden" name="accountPrincipal" value="<%=accountPrincipal%>">
<!-- Բ������2010-08-20������ -->
<input type="hidden" name="rentScale" value="<%=rentScale%>">

<div style="vertical-align:top;width:100%; overflow:auto;position: relative; left: 0px; top: 0px"  id="mydiv">
<div id="TD_tab_0">

    <table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" height="100%" cellspacing="1" width="100%" class="maintab_content_table">
      <tr class="maintab_content_table_title">
		<th>����</th>
		<th>Ӧ������</th>
        <th>���</th>
        <th>����</th>
        <th>��Ϣ</th>
        <!-- 
        <th>������</th>
         -->
        <th>�������</th>
<%
	//
	if(measure_type.equals("00") && !measure_type.equals("3")){
%>        
        <th>�������</th>
<%
	}
%>        
      </tr>
<%	  
	for ( int i=0;i<l_rent_list.size();i++){
	String num = String.valueOf(i);
	String nameValue = "zjtz"+num;//ƴװ�����ġ�name����id������
	String rent_list_nameValue = "rent_list"+num;//����
	String plan_date_nameValue = "plan_date"+num;//Ӧ������
	String rent_nameValue = "rent"+num;//���
	String corpus_nameValue = "corpus"+num;//����
	String interest_nameValue = "interest"+num;//��Ϣ
%>
      <tr class="maintab_content_table_title">
		<td>
			<%= l_rent_list.get(i) %>
			<input type="hidden" value="<%=l_rent_list.get(i)%>" name="<%=rent_list_nameValue%>" />
		</td> 
		<td>
			<%= l_plan_date.get(i) %>
			<input type="hidden" value="<%=l_plan_date.get(i)%>" name="<%=plan_date_nameValue%>" />
		</td> 
		<td>
			<%=formatNumberStr(l_rent.get(i).toString(),"#,##0.00") %>
			<input type="hidden" value="<%=l_rent.get(i).toString()%>" name="<%=rent_nameValue%>" />
		</td> 
		<td>
			<%=formatNumberStr( l_corpus.get(i).toString(),"#,##0.00") %>
			<input type="hidden" value="<%=l_corpus.get(i).toString()%>" name="<%=corpus_nameValue%>" />
		</td> 
		<td>
			<%=formatNumberStr( l_interest.get(i).toString(),"#,##0.00") %>
			<input type="hidden" value="<%=l_interest.get(i).toString()%>" name="<%=interest_nameValue%>" />
		</td>
		<td>
			<%=formatNumberStr( l_corpus_overage.get(i).toString(),"#,##0.00") %>
		</td>
<%
	// 
	if(measure_type.equals("00") && !measure_type.equals("3") ){
		
%>        
		<td>
			<input type="text" name="<%=nameValue%>" id="<%=nameValue%>"
			 dataType="Money" size="20" maxlength="10" maxB="10"/>
		</td>
<%
	}
%> 
      </tr>
<%
	}
%>
		<tr class="maintab_content_table_title" > 
			<td colspan="">&nbsp;</td>
			<td colspan="">&nbsp;</td>
			<td colspan="">�ϼ�:<%=formatNumberStr( count_rent,"#,##0.00") %></td>
			<td colspan="">�ϼ�:<%=formatNumberStr( count_corpus,"#,##0.00") %></td>
			<td colspan="">�ϼ�:<%=formatNumberStr( count_interest,"#,##0.00") %></td>
			<td colspan="">&nbsp;</td>
	<%
		//
		if(measure_type.equals("00") && !measure_type.equals("3") ){
			
	%>        
		  <td colspan="">&nbsp;</td>
	<%
		}
	%> 
		</tr>
    </table>
</div>
</div>
</form>
</body>
</html>
<script language="javascript">
function checkdata(obj){
	if(Validator.Validate(obj,3)){
		var arr=document.form1.input;
		var flag="";
		for (var i=0;i<arr.length;i++){
			if(arr[i].value!=""){
				flag="1";
				break;
			}
		}
		if(flag==""){
			alert("����ֵ����ȫΪ��!");
			return false;
		}else{
			return true;
		}
	}else{
		return false;
	}
}
</script>