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
<title>��Ϣ - ���л�׼��������</title>
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
</script>
</head>
<body>
<%
	String model = getStr(request.getParameter("model"));
	
	//Ȩ�޴��� 
//	String dqczy = (String) session.getAttribute("czyid");
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
		String user_id = (String)session.getAttribute("czyid");//ȡ�õ�¼�˵�ID ����ȡ�õ�¼�˵�name
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");//��ʽ��ʱ��
		String nowDateTime = sdf.format(new Date());//��ǰ��ʽ��֮���ʱ��
		String key_id = getStr(request.getParameter("key_id"));//���л�׼���ʻ�׼�������
		ResultSet rs; 
		//���ݵ�¼ID��ѯ��¼�û�����
		String user_name = "";
		rs = db.executeQuery(" select name from base_user where id = '"+user_id+"' ");//
		if(rs.next()){
			user_name = getDBStr(rs.getString("name"));
		}
		List<String> list = new ArrayList<String>();
		int flag = 0;
		//String repeat_flag = "";
		//if(key_id.equals("") || key_id == null || model.equals("")){
		//	model = "add";
		//}
		System.out.println("model��ֵΪ==>"+model);
		//model��Ϊ���ʱ�������еĲ���
		if(!model.equals("add")){
			System.out.println("JOIN1==>                                              :"+key_id);
			if(model.equals("mod")){//�޸�ǰ�Ĳ�ѯ
				String sqlstr = " select * from fund_standard_interest where id = "+key_id+" ";
				rs = db.executeQuery(sqlstr);
				int i = 1;
			 	while(rs.next()){
			 		//ѭ��ȡֵ ȡ�ñ��ǰ17�У��±��1��ʼȡ
			 		for(;i <= 17;i++){
				 		list.add(getDBStr(rs.getString(i)));
			 		}
			 	}
			}else{//ɾ������
				System.out.println("JOIN2==>                                              :");
				//�޸�ǰ��ѯ��fund_adjust_interest_contract��Ӧadjust_id�Ƿ�������ݣ�����������ɾ����ͬ���һ����Ҫ�ж�����
				String query_faic_sql = " select * from fund_adjust_interest_contract where  adjust_id = '"+key_id+"' ";
				System.out.println("JOIN2==> query_faic_sql: "+query_faic_sql);
				rs = db.executeQuery(query_faic_sql);
				rs.last(); //�Ƶ����һ��
				int rowCount = rs.getRow(); //�õ���ǰ�кţ�Ҳ���Ǽ�¼��
				rs.beforeFirst(); //��Ҫ�õ���¼�����Ͱ�ָ�����Ƶ���ʼ����λ��
				if(rowCount > 0){
					flag = 4;//������Ϣ��¼�Ѿ�������Ŀ����ɾ��
					System.out.println("JOIN3==> flag: "+flag);
				}else{
					String sqlstr = " select * from fund_standard_interest where id = "+key_id+" ";
					System.out.println("JOIN3==> sqlstr: "+sqlstr);
					rs = db.executeQuery(sqlstr);
					int i = 1;
				 	while(rs.next()){
				 		//ѭ��ȡֵ ȡ�ñ��ǰ17�У��±��1��ʼȡ
				 		for(;i <= 17;i++){
					 		list.add(getDBStr(rs.getString(i)));
				 		}
				 	}
					//String sql = "delete from fund_standard_interest where id = '"+key_id+"'";
					//flag = db.executeUpdate(sql);
				}
			}
		 	rs.close();
		 	db.close();
		}
%>

<form action="tx_fsi_save.jsp" method="post" target="" onSubmit="return Validator.Validate(this,3);">
<input type="hidden" name="model" id="model" value="<%=model%>">
<input type="hidden" name="key_id" id="key_id" value="<%=key_id%>">
  <!--���⿪ʼ-->
<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
	<tr valign="top" class="tree_title_txt">
		<td class="tree_title_txt"  height=26 valign="middle">
			��Ϣ &gt; ���л�׼���ʵ���
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
									<%
										if(!model.equals("del")){
									%>	
									<BUTTON class="btn_2" name="btnSave" value="�ύ"  type="submit" >
									<img src="../../images/save.gif" align="absmiddle" border="0">�ύ</button>
									<%
										} else{
									%>
									<BUTTON class="btn_2" name="btnSave" value="ɾ��"  type="submit" >
										<img src="../../images/sbtn_del.gif" align="absmiddle" border="0">ɾ��</button>
									<%
										} 
									%>
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
	    <th>���ʿ�ʼִ������</th>
	    <td colspan="">
	    	<input type="text" name="start_date" size="20" dataType="Date" Require="true" value="<%=nowDateTime%>" readonly="readonly"/>
	    	<img  onClick="openCalendar(start_date);return false" style="cursor:pointer; " 
				 src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
			<span class="biTian">*</span>
	    </td>
	    <th>�Ƿ��Ϣ���</th>
	    <td>
	    	<select name="adjust_flag" id="adjust_flag">
	    	<script>
					w(mSetOpt("��","��|��","��|��")); 
			</script>
			</select>
	    </td>
	  </tr>
	  <!-- 2012-4-23 Jaffe Open ������Ҫ����� -->
	  <tr>
	    <th>���ε��������л�������6����</th>
	    <td>
	    	<input type="text" name="base_rate_half" value="0"
	    		dataType="Money" size="20" maxlength="10" maxB="10"  Require="true" />%
			<span class="biTian">*</span>
	    </td>
		<th>������Ϣ��������6����</th>
	    <td>
	    	<input type="text" name="rate_half"  value="0"
	    		dataType="Money" size="20" maxlength="10" maxB="10"  Require="true" />%
			<span class="biTian">*</span>
	    </td>
	  </tr>
	   
      <tr>
      	<th>���ε��������л�������1��</th>
	    <td>
	    	<input type="text" name="base_rate_one" value="0"
	    		dataType="Money" size="20" maxlength="10" maxB="10"  Require="true" />%
			<span class="biTian">*</span>
	    </td>
		<th>������Ϣ��������1��</th>
	    <td>
	    	<input type="text" name="rate_one" value="0"
	    		dataType="Money" size="20" maxlength="10" maxB="10"  Require="true" />%
			<span class="biTian">*</span>
	    </td>
	  </tr>
	  <tr>
	    <th>���ε��������л�������1��3��</th>
	    <td>
	    	<input type="text" name="base_rate_three" value="0"
	    		dataType="Money" size="20" maxlength="10" maxB="10"  Require="true" />%
			<span class="biTian">*</span>
	    </td>
		<th>������Ϣ��������1��3��</th>
	    <td>
	    	<input type="text" name="rate_three" value="0"
	    		dataType="Money" size="20" maxlength="10" maxB="10"  Require="true" />%
			<span class="biTian">*</span>
	    </td>
	</tr>
    <tr>  
		<th>���ε��������л�������3��5��</th>
	    <td>
	    	<input type="text" name="base_rate_five" value="0"
	    		dataType="Money" size="20" maxlength="10" maxB="10"  Require="true" />%
			<span class="biTian">*</span>
	    </td>
		<th>������Ϣ��������3��5��</th>
	    <td>
	    	<input type="text" name="rate_five" value="0"
	    		dataType="Money" size="20" maxlength="10" maxB="10"  Require="true" />%
			<span class="biTian">*</span>
	    </td>
	</tr>
	<tr>
	    <th>���ε��������л�������5������</th>
	    <td >
	    	<input type="text" name="base_rate_abovefive"  value="0"
	    		dataType="Money" size="20" maxlength="10" maxB="10"  Require="true" />%
			<span class="biTian">*</span>
	    </td>
		<th>������Ϣ��������5������</th>
	    <td>
	    	<input type="text" name="rate_abovefive" value="0"
	    		dataType="Money" size="20" maxlength="10" maxB="10"  Require="true" />%
			<span class="biTian">*</span>
	    	<!-- �Ǽ���  -->
	    	<input type="hidden" name="creator" value="<%=user_name%>" />
			<!-- �Ǽ�ʱ�� -->
	    	<input type="hidden" name="create_date"  value="<%=nowDateTime%>" />
	    	<!-- ������ -->
	    	<input type="hidden" name="modificator"   value="" />
	    	<!-- ����ʱ��  -->
	    	<input type="hidden" name="modify_date" value=""/>
	    </td>
	 </tr>
<%
	}else if(model.equals("mod")){//ע���޸�ʱ���Ǽ��ˡ��͡��Ǽ�ʱ�䡯�ǲ����޸ĵ�
%>
      <tr>
	    <th>���ʿ�ʼִ������</th>
	    <td colspan="">
	    	<input type="text" name="start_date" size="20" dataType="Date" Require="true" value="<%=getDBDateStr(list.get(1))%>" readonly="readonly"/>
	    	<!-- 
	    	<img  onClick="openCalendar(start_date);return false" style="cursor:pointer; " 
				 src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
	    	 -->
	    </td>
	    <th>�Ƿ��Ϣ���</th>
	    <td>
	    	<select name="adjust_flag" id="adjust_flag">
	    	<script>
					w(mSetOpt("<%=list.get(12)%>","��|��","��|��")); 
			</script>
			</select>
	    </td>
	  </tr>
	  <!-- 
	  <tr>
	    <th>���ε��������л�������6����</th>
	    <td>
	    	<input type="text" name="base_rate_half" size="20" 
	    		   dataType="Money" Require="true" value="<%=formatNumberDoubleTwo(list.get(7))%>" readonly="readonly"/>%
	    </td>
		<th>������Ϣ��������6����</th>
	    <td>
	    	<input type="text" name="rate_half" size="20" 
	    		   dataType="Money" Require="true" value="<%=formatNumberDoubleTwo(list.get(2))%>" readonly="readonly"/>%
	    </td>
	  </tr>
	   -->
      <tr>
        <th>���ε��������л�������1��</th>
	    <td>
	    	<input type="text" name="base_rate_one" size="20" 
	    		   dataType="Money" Require="true" value="<%=formatNumberDoubleTwo(list.get(8))%>" readonly="readonly"/>%
	    </td>
		<th>������Ϣ��������1��</th>
	    <td>
	    	<input type="text" name="rate_one" size="20" 
	    		   dataType="Money" Require="true" value="<%=formatNumberDoubleTwo(list.get(3))%>" readonly="readonly"/>%
	    </td>
	 </tr>
	 <tr>
	    <th>���ε��������л�������1��3��</th>
	    <td>
	    	<input type="text" name="base_rate_three" size="20"
	    		   dataType="Money" Require="true" value="<%=formatNumberDoubleTwo(list.get(9))%>" readonly="readonly"/>%
	    </td>
		<th>������Ϣ��������1��3��</th>
	    <td>
	    	<input type="text" name="rate_three" size="20" 
	    		   dataType="Money" Require="true" value="<%=formatNumberDoubleTwo(list.get(4))%>" readonly="readonly"/>%
	    </td>
	</tr>
    <tr>
    	<th>���ε��������л�������3��5��</th>
	    <td>
	    	<input type="text" name="base_rate_five" size="20" onkeyup="value=value.replace(/[^\u4E00-\u9FA5^a-z^A-Z^0-9]/g,'') 
	    		   dataType="Money" Require="true" value="<%=formatNumberDoubleTwo(list.get(10))%>" readonly="readonly"/>%
	    </td>  
		<th>������Ϣ��������3��5��</th>
	    <td>
	    	<input type="text" name="rate_five" size="20" 
	    		   dataType="Money" Require="true" value="<%=formatNumberDoubleTwo(list.get(5))%>" readonly="readonly"/>%
	    </td>
	</tr>
	<tr>
	    <th>���ε��������л�������5������</th>
	    <td >
	    	<input type="text" name="base_rate_abovefive" size="20"
	    		   dataType="Money" Require="true" value="<%=formatNumberDoubleTwo(list.get(11))%>" readonly="readonly"/>%
	    </td>
		<th>������Ϣ��������5������</th>
	    <td>
	    	<input type="text" name="rate_abovefive" size="20" 
	    		   dataType="Money" Require="true" value="<%=formatNumberDoubleTwo(list.get(6))%>" readonly="readonly"/>%
	    	<!-- �Ǽ���  -->
	    	<input type="hidden" name="creator" value="<%=getDBStr(list.get(13))%>" />
			<!-- �Ǽ�ʱ�� -->
	    	<input type="hidden" name="create_date"  value="<%=getDBDateStr(list.get(14))%>" />
	    	<!-- ������ -->
	    	<input type="hidden" name="modificator"   value="<%=user_name%>" />
	    	<!-- ����ʱ��  -->
	    	<input type="hidden" name="modify_date" value="<%=nowDateTime%>"/>
	    </td>
	  </tr>    
<%
	}else{//ɾ������
		String mesg = "";
			if(flag == 4){
				mesg = "������Ϣ��¼�Ѿ�������Ŀ����ɾ��!";
%>
					<script type="text/javascript">
						alert("<%=mesg%>");
						opener.location.reload();
						window.close();
					</script>
<%
			}else{
%>
	<tr>
	    <th>���ʿ�ʼִ������</th>
	    <td colspan=""> <%=getDBDateStr(list.get(1))%> </td>
	    <th>�Ƿ��Ϣ���</th>
	    <td><%=getDBStr(list.get(16))%></td>
	</tr>
	<tr>
	    <th>���ε��������л�������6����</th>
	    <td> <%=formatNumberDoubleTwo(list.get(7))%>% </td>
		<th>������Ϣ��������6����</th>
	    <td> <%=formatNumberDoubleTwo(list.get(2))%>% </td>
	</tr>
    <tr>
      	<th>���ε��������л�������1��</th>
	    <td> <%=formatNumberDoubleTwo(list.get(8))%>% </td>
		<th>������Ϣ��������1��</th>
	    <td> <%=formatNumberDoubleTwo(list.get(3))%>% </td>
    </tr>
    <tr>
	    <th>���ε��������л�������1��3��</th>
	    <td> <%=formatNumberDoubleTwo(list.get(9))%>% </td>
		<th>������Ϣ��������1��3��</th>
	    <td> <%=formatNumberDoubleTwo(list.get(4))%>% </td>
	</tr>
    <tr>  
    	<th>���ε��������л�������3��5��</th>
	    <td> <%=formatNumberDoubleTwo(list.get(10))%>% </td>
		<th>������Ϣ��������3��5��</th>
	    <td> <%=formatNumberDoubleTwo(list.get(5))%>% </td>
	</tr>
    <tr>  
	    <th>���ε��������л�������5������</th>
	    <td> <%=formatNumberDoubleTwo(list.get(11))%>% </td>
		<th>������Ϣ��������5������</th>
	    <td> <%=formatNumberDoubleTwo(list.get(6))%>% </td>
	</tr>
<%		
	  }
	}
%>
    </table>
</div>
</div>
</td></tr></table>
</form>
</body>
</html>
