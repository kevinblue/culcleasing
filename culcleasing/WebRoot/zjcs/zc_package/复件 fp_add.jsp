<%@ page contentType="text/html; charset=gbk" language="java" %>
<%@ page import="dbconn.*" %>  
<%@ page import="java.sql.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ page import="java.util.ArrayList"%> 
<%@ page import="java.util.List"%> 
<%@ include file="../../func/common.jsp"%>
<jsp:useBean id="right" scope="page" class="com.filter.FilterCredit" />
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>��Ʊ - ���ŷ�Ʊ����</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/validator.js"></script>
<SCRIPT  Language="Javascript"  SRC="/tenwa/js/public.js"></SCRIPT>
<SCRIPT  Language="Javascript"  SRC="/tenwa/js/publicEvent.js"></SCRIPT>
<script language="javascript" src="/dict/js/js_dictionary.js"></script>
<script language="javascript" src="/dict/js/ajax_popupDialog.js"></script>
<!-- ���ڿؼ� -->
<script src="../../js/calend.js"></script>
<script type="text/javascript">
	function closeWin(){
		opener.parent.location.reload();
		window.close();
	}
	function form_submit(){
		
		if(change_ci()){
			form1.submit();
		}else{
			window.close();
			opener.location.reload();
		}
	}
	
	//���ݷ�Ʊ�������㷢Ʊ�����Ϣ�����ֵ
	function change_ci(){
		//��ȡ�ѿ��ķ�Ʊ���� 
		var Fp_rate_t = document.getElementById('Fp_rate_t').value;
		//��д��δ���ķ�Ʊ����
		var Fp_rate = document.getElementById('Fp_rate').value;
		//alert(parseFloat("10.000000").toFixed(2) > parseFloat("1.000000").toFixed(2));
		
		if(chack_rate(Fp_rate)){
			if(Fp_rate != 0 && Fp_rate != '0'){
				var tem =  parseFloat(Fp_rate).toFixed(2);//δ��Ʊ����
				//alert("δ��:"+tem);
				var bl_t = parseFloat(Fp_rate_t).toFixed(2);//�ѿ�Ʊ����
				//alert("�ѿ�:"+bl_t);
				var tb =  FloatAdd(tem,bl_t).toFixed(2);
				//alert("δ�����ѿ�:"+tb);
				var man = parseFloat("100.00").toFixed(2);
				//�����ܵĽ�ÿ�γ��Ա�������������Ʊ�õ������
				var Fp_countMoney = document.getElementById('sum_rent').value;
				var Fp_corpus = document.getElementById('sum_corpus').value;
				var Fp_interest = document.getElementById('sum_interest').value;
				if(parseFloat(tb) > parseFloat(man)){//δ�����ѿ�Ʊ ����100
					alert("��Ʊ���������ѿ�Ʊ��������100%,�޷�������Ʊ!");
					//document.getElementById("Fp_rate").readonly = true; 
					return false;
				}else if(parseFloat(tb) < parseFloat(man)){////δ�����ѿ�Ʊ С��100
					//�����ܶ������Ϣ��ֵ
					var rate = Fp_rate/100;//��������100
					//��ֵ  
					document.getElementById('Fp_countMoney').value = round(rate*Fp_countMoney,2);//Fp_countMoney = ����ܶ�*������
					document.getElementById('Fp_corpus').value = round(rate*Fp_corpus,2);//Fp_corpus = �����ܶ�*������
					document.getElementById('Fp_interest').value = round(rate*Fp_interest,2);//Fp_interest = ��Ϣ�ܶ�*������
					//alert("���");
					return true;
				}else{//���һ�ο�Ʊ����ȫ //δ�����ѿ�Ʊ == 100
					//alert("���һ��");
					//��ȡ�ѿ��Ľ��
					var yk_Fp_countMoney = document.getElementById('yk_Fp_countMoney').value;
					var yk_Fp_corpus = document.getElementById('yk_Fp_corpus').value;
					var yk_Fp_interest = document.getElementById('yk_Fp_interest').value;
					//��ֵ  
					document.getElementById('Fp_countMoney').value = round(Fp_countMoney - yk_Fp_countMoney,2);
					document.getElementById('Fp_corpus').value = round(Fp_corpus - yk_Fp_corpus,2);
					document.getElementById('Fp_interest').value = round(Fp_interest - yk_Fp_interest,2);
					return true;
				}
			}else{
				//document.getElementById("Fp_rate").disable = true;
				alert("���ʲ����ķ�Ʊ��������100%,�޷�������Ʊ!");
				return false;
			}
		}
	}
	/**����2λС�� ������������ 
		������ģ� 
		v��ʾҪת����ֵ 
		e��ʾҪ������λ�� 
		�����������for��������ص��ˣ�
		��һ��for���С�����ұߵ������Ҳ���Ǳ���С�����ұ߶���λ��
		�ڶ���for���С������ߵ������Ҳ���Ǳ���С������߶���λ�� 
		for�����ã����Ǽ���t��ֵ��Ҳ����vӦ�÷Ŵ������С���ٱ��ı���������=t����
		for�������õ���for����������ԣ������жϺͼ������ۼƣ�ѭ������
		��e��������ʱfor����������eÿ���ۼӣ�e��ÿ���ۼӣ����Ǹ�for���첻����ѭ������������ͬʱ��Ҳ����t��ֵ�� 
		���������ԭ����round���������㱻�Ŵ�/��С���v�Ľ����Ȼ��ѽ���Ŵ�/��С����ȷ�ı��� 
	*/
	function round(v,e){ 
		var t=1; 
		for(;e>0;t*=10,e--); 
		for(;e<0;t/=10,e++); 
		//alert(Math.round(v*t)/t);
		return Math.round(v*t)/t; 
	}
	//������֤
	function check_lm(text_value){
		 text_value = trim(text_value);//��ȥ�ո�
		 //�Ƿ��ַ�����֤ 				
		 var reg_ff = /\/{2}|\/\*|-{2}|[';\"%<>]+/;
          if(text_value.match(reg_ff)){ 
              str = "��������Ʋ��ܰ��������ַ���-- /* ';\"% < > // \"��" ;
               alert(str);
              return false;
           }else{
           	  return true;
           }
	}
	
	function chack_rate(text_value){
		if(check_lm(text_value)){
			//���ʸ�ʽ: /^\d+(\.[0-9]{1,8})?$/,
			var reg_Rate =  /^\d+(\.[0-9]{1,8})?$/;
			//alert("reg_Rate��֤->"+list[i].name+"="+text_value+"----"+list[i].dataType+"--����ǣ�"+reg_Rate.test(text_value));
			if(reg_Rate.test(text_value) == false){
				str = "����Ϊ��ʵ������С���ڰ�λ����";
				alert(str);
				return false;			
			}else{
				return true;			
			}
		}
	}
	/*
    ���������� ȥ������ո���
    	return: s 2�ߵĶ���Ŀո��Ѿ�ȥ����
    	author:  sea
    	date: 2010-04-13
	*/
	function trim(s){  
  		return s.replace(/(^\s*)|(\s*$)/g,"");      
	}
	//�������ӷ�����   
 function FloatAdd(arg1,arg2){   
   var r1,r2,m;   
   try{r1=arg1.toString().split(".")[1].length}catch(e){r1=0}   
   try{r2=arg2.toString().split(".")[1].length}catch(e){r2=0}   
   m=Math.pow(10,Math.max(r1,r2))   
   return (arg1*m+arg2*m)/m   
  } 
 //��������������   
 function FloatSub(arg1,arg2){   
	 var r1,r2,m,n;   
	 try{
	 		r1 = arg1.toString().split(".")[1].length
	 	}catch(e){
	 		r1=0
	 	}   
	 try{
	 		r2=arg2.toString().split(".")[1].length
	 	}catch(e){
	 		r2=0
	 	}   
	 m = Math.pow(10,Math.max(r1,r2));   
	 //��̬���ƾ��ȳ���   
	 n = (r1>=r2)?r1:r2;   
	 return ((arg1*m-arg2*m)/m).toFixed(n);   
 }
</script>
</head>
<body onload="change_ci()">
<%
	String model = getStr(request.getParameter("model"));
	
	//Ȩ�޴��� 
	String dqczy = (String) session.getAttribute("czyid");
	//���ݵ�¼�˱�Ų�ѯ��¼��������
	String qx_value = "";//����������Ȩ�޵��ж�
	String query_department = " select dept_name from base_department where id = ( ";
	query_department = query_department +" select department from base_user where id = '"+dqczy+"')  ";
	ResultSet rs_d = db.executeQuery(query_department);
	String dept_name = "";
	if(rs_d.next()){
		dept_name = getDBStr( rs_d.getString("dept_name") ) ;
	}
	if("".equals(dept_name) || dept_name == null){//δ�в���
		qx_value = "0";
	}else if ("�ʲ�����".equals(dept_name)){
		qx_value = "1";
	}else if ("�ƻ�����".equals(dept_name)){
		qx_value = "2";
	}
	rs_d.close();
	
//	if ((dqczy == null) || (dqczy.equals("")))
//	{
//	  dqczy = "����֤";
//	  response.sendRedirect("../../noright.jsp");
//	}
//	int canedit = 0;
	//���
//	if(model == null || model.equals("")){
//		if (right.CheckRight("zjcs-tx-add",dqczy) > 0) canedit=1;
//	}else if(model.equals("mod")){
//		if (right.CheckRight("zjcs-tx-mod",dqczy) > 0) canedit=1;
//	}else{
//		if (right.CheckRight("zjcs-tx-del",dqczy) > 0) canedit=1;
//	}
//	if (canedit == 0) response.sendRedirect("../../noright.jsp"v);
%>

<%
		String readonly = "true";
		String user_id = (String)session.getAttribute("czyid");//ȡ�õ�¼�˵�ID ����ȡ�õ�¼�˵�name
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");//��ʽ��ʱ��
		String nowDateTime = sdf.format(new Date());//��ǰ��ʽ��֮���ʱ��
		String Zc_num = getStr(request.getParameter("Zc_num"));//Zc_num
		String UserName = getStr(request.getParameter("UserName"));//������
		String key_id = getStr(request.getParameter("key_id"));//��Ʊ������
		System.out.println("key_id--->"+key_id);
		ResultSet rs; 
		//���ݵ�¼ID��ѯ��¼�û�����
		String user_name = "";
		rs = db.executeQuery(" select name from base_user where id = '"+user_id+"' ");//
		if(rs.next()){
			user_name = getDBStr(rs.getString("name"));
		}
		//�����ʲ�����Ų�ѯ �ѿ��˶��ٷ�Ʊ���� �Լ����ٽ��
		String q_s = " select isnull(sum(Fp_rate),'0') as Fp_rate ,ISNULL(SUM(Fp_countMoney),'0') as Fp_countMoney, ";
		q_s = q_s + " ISNULL(SUM(Fp_corpus),'0') as Fp_corpus, ";
		q_s = q_s + " ISNULL(SUM(Fp_interest),'0') as Fp_interest  from  fund_Assets_Invoice "; 
		q_s = q_s + " where id  in ( ";
		q_s = q_s + " 	select Fp_id from fund_Assets_Invoice_Corresponding where Zc_num = '"+Zc_num+"' ";
		q_s = q_s + " ) ";
		System.out.println("�ѿ��˶��ٷ�Ʊ���� �Լ����ٽ��==>"+q_s);
		rs = db.executeQuery(q_s);
		String yk_Fp_rate = "";
		String yk_Fp_countMoney = "";
		String yk_Fp_corpus = "";
		String yk_Fp_interest = "";
		while(rs.next()){
			yk_Fp_rate = getDBStr(rs.getString("Fp_rate"));
			yk_Fp_countMoney = getDBStr(rs.getString("Fp_countMoney"));
			yk_Fp_corpus = getDBStr(rs.getString("Fp_corpus"));
			yk_Fp_interest = getDBStr(rs.getString("Fp_interest"));
		}
		Double bl = Double.valueOf(yk_Fp_rate);
		System.out.println("bl==>"+bl);
		System.out.println("Double.valueOf(100)==>"+Double.valueOf(100));
		System.out.println(bl <= Double.valueOf(100));
		String Fp_rate = "0";//δ������
		if(bl <= Double.valueOf(100)){//���㻹ʣ�¶��ٱ���δ����
			Double bl_temp = 100 - bl;
			Fp_rate = String.valueOf(bl_temp);
		}
		//
		List<String> list = new ArrayList<String>();
		int flag = 0;
		System.out.println("model��ֵΪ==>"+model);
		//model��Ϊ���ʱ�������еĲ���
		//�ܵ�money��Ŀ
		String sum_rent = "";
		String sum_corpus = "";
		String sum_interest = "";
		if(model.equals("add")){
			//System.out.println("JOIN1==>                                              :");
			//��һ���������ʲ�����Ų�ѯ��𳥻��ƻ�������Ϊ���ʲ�����ŵ�sum�����
			String q_sum_rent = " select isnull(SUM(rent),'0') as rent,ISNULL(SUM(corpus),'0') as corpus,ISNULL(SUM(interest),'0') as interest from fund_rent_plan ";
					q_sum_rent = q_sum_rent +" where id  in ( ";
					q_sum_rent = q_sum_rent +" select Chjx_id from fund_Assets_rent_Corresponding where Zc_num = '"+Zc_num+"' ";
					q_sum_rent = q_sum_rent +" ) ";
			System.out.println("�ܹ��ж�����𱾽���Ϣ��Ҫ����Ʊ==>"+q_sum_rent);
			rs = db.executeQuery(q_sum_rent);		
			while(rs.next()){
				sum_rent = getDBStr(rs.getString("rent"));
				sum_corpus = getDBStr(rs.getString("corpus"));
				sum_interest = getDBStr(rs.getString("interest"));
			}
		 	rs.close();
		}
		if(model.equals("del")){//��Ʊɾ��
			String del_sql1 = " delete from fund_Assets_Invoice_Corresponding where fp_id = '"+key_id+"' ";
			String del_sql2 = " delete from fund_Assets_Invoice where id = '"+key_id+"' ";
			System.out.println("��Ʊɾ��1==>"+del_sql1);
			System.out.println("��Ʊɾ��2==>"+del_sql2);
			flag = db.executeUpdate(del_sql1);
			flag = db.executeUpdate(del_sql2);
		}
		//�����ʲ����ͳ�ƶ�Ӧ�ʲ���ŵĳ����ƻ�������ܺ� �Լ� ��Ʊ�����ѿ�����ܶ� 
		//���1�����߱Ƚϣ���ȣ������ʲ������е�״̬Ϊ�����ύ ����ʾ���ύ��ˡ���ť�����ʲ������е�״̬��Ϊ������ˡ�
		//���2���ʲ���Ŷ�Ӧ�ķ�Ʊ���еġ���Ʊ���Fp_num����Ϊ�� �ʲ���������ɾ���������ʲ������е�״̬Ϊ������� ����ʾ�������ϡ���ť ���״̬��Ϊ�������ϡ�
		if("tjshenhe".equals(model)){//�ύ���
			String u_s = " update fund_Assets_Package set status = '�����'  where  Zc_num = '"+Zc_num+"'  ";
			flag = db.executeUpdate(u_s);
		}
		if("shenheOk".equals(model)){//������
			String u_s = " update fund_Assets_Package set status = '������'  where  Zc_num = '"+Zc_num+"'  ";
			flag = db.executeUpdate(u_s);
		}
		//if("mod".equals(model)){//�޸Ĵ���-
		//}
	 	
%>

<form name="form1" action="fp_save.jsp" method="post" target="" onSubmit="return Validator.Validate(this,3);">
<input type="hidden" name="model" id="model" value="<%=model%>">
<input type="hidden" name="Fp_rate_t" id="Fp_rate_t" value="<%=yk_Fp_rate%>">
<input type="hidden" name="yk_Fp_countMoney" id="yk_Fp_countMoney" value="<%=yk_Fp_countMoney%>">
<input type="hidden" name="yk_Fp_corpus" id="yk_Fp_corpus" value="<%=yk_Fp_corpus%>">
<input type="hidden" name="yk_Fp_interest" id="yk_Fp_interest" value="<%=yk_Fp_interest%>">
<input type="hidden" name="sum_rent" id="sum_rent" value="<%=sum_rent%>">
<input type="hidden" name="sum_corpus" id="sum_corpus" value="<%=sum_corpus%>">
<input type="hidden" name="sum_interest" id="sum_interest" value="<%=sum_interest%>">
<input type="hidden" name="Zc_num" id="Zc_num" value="<%=Zc_num%>">
<input type="hidden" name="key_id" id="key_id" value="<%=key_id%>">
  <!--���⿪ʼ-->
<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
	<tr valign="top" class="tree_title_txt">
		<td class="tree_title_txt"  height=26 valign="middle">
			��Ʊ &gt; ���ŷ�Ʊ���� 
		</td>
	</tr>
	<tr valign="top">
		<td  align=center width=100% height=100%>
			<table align=center width=96%  border="0" cellspacing="0" cellpadding="0" style="margin-top:0px">
				<tr>
					<td>
					  <!--�������-->
					  <!--������Ͳ�������ʼ-->
  						<table border="0" width="100%" id="table8" align="center" cellspacing="0" cellpadding="0" style="margin-top:2px;">
   						<!--     -->
    					<tr class="maintab_dh">
      						<td align="left" colspan="2">
      							<table border="0" cellspacing="0" cellpadding="0">    
									<tr class="maintab_dh"><td nowrap >
									<BUTTON class="btn_2" name="btnSave" value="�ύ"  onclick="form_submit()" >
									<img src="../../images/save.gif" align="absmiddle" border="0">�ύ</button>
									<BUTTON class="btn_2" name="btnReset" value="ȡ��" onClick="window.close();">
									<img src="../../images/hg.gif" align="absmiddle" border="0">ȡ��</button>
									    </td></tr>
								</table>
        					</td>
   						 </tr>
						<tr><td height="1" bgcolor="#DFDFDF"></td></tr>
						<tr><td height="5"></td></tr>
						<tr><td width="100%">
							 <table border="0" cellspacing="0" cellpadding="0">
							 <tr>
							 <%if(model.equals("add")){%>
							  <td id="Form_tab_0" class="Form_tab" width=70 align=center onClick="chgTabN()"  valign="middle">&nbsp; ���� &nbsp;</td>
							 <%}else if(model.equals("mod")){%> 
							  <td id="Form_tab_1" class="Form_tab" width=0 align=center onClick="chgTabN()"  valign="middle">&nbsp; �޸� &nbsp;</td>
							  <%}else{ %>
							  <td id="Form_tab_0" class="Form_tab" width=0 align=center onClick="chgTabN()"  valign="middle">&nbsp; ��ϸ &nbsp;</td>
							  <%} %>
							 </tr>
							 </table></td></tr> 
						<tr><td class="tab_subline" width="100%" height="2"></td></tr>
				</table>
			</td>
		</tr>
	</table>	

<div id="mydiv" class="tabBody" style="background:#ffffff;width:96%;height:500px;overflow:auto;">
<div id="TD_tab_0">
    <table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" cellspacing="1" width="100%" hight="95%" class="tab_table_title" >
<%
	if(model.equals("add")){
%>
	
	  <tr>
	    <th>��Ʊ̧ͷ</th>
	    <td colspan="2">
	    	<input type="text" name="Fp_tt" value="<%=UserName%>"  
	    		dataType="Money" size="40" maxlength="10" maxB="10"  Require="true" /> 
			<span class="biTian">*</span>
	    </td>
		
	  </tr>
	  <tr>
	    <th>������</th>
	    <td><!-- onPropertyChange -->
	    	<input type="text" name="Fp_rate" value="<%=Fp_rate%>" onPropertyChange="change_ci()" 
	    		dataType="Rate" size="20" maxlength="10" maxB="10"  Require="true" /> %
			<span class="biTian">*</span>
	    </td>
		<th>��Ʊ���</th>
	    <td>
	    	<input type="text" name="Fp_countMoney" value="<%=sum_rent %>" readonly="readonly"
	    		dataType="Money" size="20" maxlength="10" maxB="10"  Require="true" /> 
			<span class="biTian">*</span>
	    </td>
	  </tr>
	  <tr>
	    <th>����</th>
	    <td>
	    	<input type="text" name="Fp_corpus" value="<%=sum_corpus%>"  readonly="readonly"
	    		dataType="Rate" size="20" maxlength="10" maxB="10"  Require="true" /> 
			<span class="biTian">*</span>
	    </td>
		<th>��Ϣ</th>
	    <td>
	    	<input type="text" name="Fp_interest" value="<%=sum_interest%>"  readonly="readonly"
	    		dataType="Money" size="20" maxlength="10" maxB="10"  Require="true" /> 
			<span class="biTian">*</span>
	    </td>
	  </tr>
	  
      <tr>
	    <th>��Ʊʱ��</th>
	    <td colspan="">
	    	<input type="text" name="Kp_date" size="20" dataType="Date" Require="true" value="<%=nowDateTime%>" readonly="readonly"/>
	    	<img  onClick="openCalendar(Kp_date);return false" style="cursor:pointer; " 
				 src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
			<span class="biTian">*</span>
	    </td>
	    <th>��Ʊ���</th>
	    <td>
	    <%if("2".equals(qx_value)){%>	
	    	<input type="text" name="Fp_num"  value=""   Require="true"/>
	    <% }else{%>	
	    	 ����Ϊ'�ƻ�����'��д 
	    <% }%>	
	    </td>
	  </tr>
<%
	} else if("tjshenhe".equals(model)){
			if(flag > 0){
			String hrefStr="";
%>
		        <script>
					alert("�ύ��˳ɹ�!");
					opener.parent.location.reload();
					window.close();
				</script>
<%
			}else{
%>
		        <script>
					alert("�ύ���ʧ��!");
					opener.location.reload();
					this.close();
				</script>
<%	
			}
	  }else if ("shenheOk".equals(model)){
			if(flag > 0){
			String hrefStr="";
%>
		        <script>
					alert("�����ϲ����ɹ�!");
					opener.parent.location.reload();
					window.close();
				</script>
<%
			}else{
%>
		        <script>
					alert("�����ϲ���ʧ��!");
					opener.location.reload();
					this.close();
				</script>
<%	
			}
		}else{//��Ʊɾ��
			if(flag > 0){
			String hrefStr="";
%>
		        <script>
					alert("��Ʊɾ���ɹ�!");
					opener.parent.location.reload();
					window.close();
				</script>
<%
			}else{
%>
		        <script>
					alert("��Ʊɾ��ʧ��!");
					opener.location.reload();
					this.close();
				</script>
<%	
			}	
		}
		db.close();
%>

    </table>
	    <div>
			<iframe frameborder="0" name="con" width="100%" height="400" 
				src="fp_yDB_List.jsp?Zc_num=<%=Zc_num%>&UserName=<%=UserName%>">
			</iframe>
		</div>
</div>
</div>
</form>
</body>
</html>
