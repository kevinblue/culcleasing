<%@ page contentType="text/html; charset=gbk" language="java"  %>
<%@ page import="dbconn.*" %>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" />
<%@ page import="java.sql.*" %>
<%@page import="com.condition.ZC_Package"%>
<%@ include file="../../func/common.jsp"%>
<jsp:useBean id="right" scope="page" class="com.filter.FilterCredit" />
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>�ʲ���� - ��ҳ</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script type="text/javascript" src="../../DatePicker/WdatePicker.js"></script>
<script src="../../js/calend.js"></script>
<script type="text/javascript">
//��������
function newAdd(){
//alert("join");
//	var str = document.getElementsByName("name")[0].value;
	//�������ڽ�����������
	window.open('tx_fsi_add.jsp?model="add"','���л�׼������������','height=400,width=800,top=200,left=200,toolbar=no,menubar=no,scrollbars=no,resizable=no,location=no,status=no'); 
}
//�޸Ĳ���
function newMod(){
	var str_key_id;
	var selectedIndex = -1;
    var form1 = document.getElementById("form1");
    var i = 0;
    for (i = 0; i < form1.key_id.length; i++)
    {
        if (form1.key_id[i].checked)
        {
            selectedIndex = i;
            str_key_id = form1.key_id[i].value;
            break;
        }
    }
    if (selectedIndex < 0)
    {
        alert("����ѡ����Ҫ�޸ĵ�������!");
        return false;
    }
	window.open("tx_fsi_add.jsp?model=mod&key_id="+str_key_id,'���л�׼�����޸Ĳ���','height=400,width=800,top=200,left=200,toolbar=no,menubar=no,scrollbars=no,resizable=no,location=no,status=no'); 
}



//ɾ������
function newDel(){
	var str_key_id;
	var selectedIndex = -1;
    var form1 = document.getElementById("form1");
   // var siz = document.getElementsByName('key_id').length;
    //var len = form1.key_id.length;
  // alert(form1.key_id.length);

	    for (var i = 0; i < form1.key_id.length; i++)//form1.key_id.length
	    {
	    	 
	        if (form1.key_id[i].checked)
	        {
	            selectedIndex = i;
	            str_key_id = form1.key_id[i].value;
	            break;
	        }
	    }
    if (selectedIndex < 0)
    {
        alert("����ѡ����Ҫɾ����������!");
        return false;
    }
    form1.action = "zc_executeDB.jsp?model=del&zc_num="+str_key_id;
    form1.target = "_blank";
    form1.method = "post";
    form1.submit();
	//window.open("tx_fsi_add.jsp?model=del&key_id="+str_key_id,'���л�׼����ɾ������','height=400,width=800,top=200,left=200,toolbar=no,menubar=no,scrollbars=no,resizable=no,location=no,status=no'); 
}

</script>
</head>
<body>
<%
	//Ȩ�޴���  ȡ�õ�¼�˵�ID
	String dqczy =  "ADMN-857CHJ";//(String) session.getAttribute("czyid");//ADMN-857CHJ  �ʲ�����   �ƻ����� ADMN-857CH2
	
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
	
	//if ((dqczy == null) || (dqczy.equals("")))
	//{
	//  dqczy = "����֤";
	//  response.sendRedirect("../../noright.jsp");
	//}
	//int canedit=0;
	//if (right.CheckRight("zjcs-tx-list",dqczy) > 0) canedit=1;
	//if (canedit == 0) response.sendRedirect("../../noright.jsp");
%>

<%
	String str = "";
	ResultSet rs;
	String wherestr = " where 1=1 ";
	//�ʲ��� ��
	String sqlstr = " select * from fund_Assets_Package  order by caertor_date desc"; 
%>
<form name="form1" action="tx_showMainList.jsp"  onSubmit="return goPage()">

  <!--���⿪ʼ-->
  <table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
    <tr class="tree_title_txt">
      <td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
      	�ʲ���� &gt; �ʲ����б�
      </td>
    </tr>
  </table>
  <!--�������-->
  <!--������Ͳ�������ʼ-->
  <table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:2px;">
   <!--     -->
    <tr class="maintab">
      <td align="center" colspan="2">
        <table width="100%" border="0" cellpadding="0" cellspacing="0" >
          <tr class="maintab">
            <td align="left">
            <!-- Ȩ�޿��� -->
            <% if(!qx_value.equals("2")){ %>
	              <a href="#" accesskey="n" onClick="dataHander('add','zc_list.jsp?model=add',form1.Zc_num);">
	              		<img src="../../images/sbtn_new.gif" alt="����(Alt+N)" width="19" height="19" align="absmiddle">
	              </a>
	        <% } %>
            <%//if (right.CheckRight("zjcs-tx-mod",dqczy)>0){ %>
            <!-- 
            	<a href="#" accesskey="m" onClick="dataHander('mod','tx_fsi_add.jsp?model=mod&key_id=',form1.Zc_num);">
            		<img src="../../images/sbtn_mod.gif" alt="�޸�(Alt+M)" width="19" height="19" align="absmiddle" >
            	</a>
             -->
	        <% //}%>
            <%if(!qx_value.equals("2")){ %>
			   <a href="#" accesskey="d" onClick="newDel()">
				<img src="../../images/sbtn_del.gif" alt="ɾ��(Alt+D)" width="19" height="19" align="absmiddle" >
				</a>
	        <% }%>
			</td>
          </tr>
        </table>
        </td>
    </tr>
 
    <tr class="maintab">
      <td align="center" width="1%">
        <table border="0" cellspacing="0" cellpadding="0" >
        </table>
	  </td>
      <td align="right" width="90%">
 <!--��ҳ���ƿ�ʼ-->
<% 
	int intPageSize = 15;   //һҳ��ʾ�ļ�¼��
	int intRowCount = 0;   //��¼����
	int intPageCount = 1; //��ҳ��
	int intPage;       //����ʾҳ��
	String strPage = getStr(request.getParameter("page") );          //ȡ�ô���ʾҳ��
	if( strPage.equals("") ){                                         //������QueryString��û��page��һ����������ʱ��ʾ��һҳ����
	   intPage = 1;
	}else{
	   intPage = java.lang.Integer.parseInt(strPage);
	   if(intPage<1) intPage = 1;
	} 
	rs = db.executeQuery(sqlstr);

	rs.last();                                                  //��ȡ��¼����
	intRowCount = rs.getRow();
	intPageCount = ( intRowCount + intPageSize - 1) / intPageSize;   //������ҳ��
	if( intPage > intPageCount ) intPage = intPageCount;            //��������ʾ��ҳ��
	if( intPageCount > 0 )
	   rs.absolute( ( intPage-1 ) * intPageSize + 1 );              //����¼ָ�붨λ������ʾҳ�ĵ�һ����¼��
	int i = 0;
%>


<table border="0" cellspacing="0" cellpadding="0">
  <tr class="maintab">
	<script>
		var cp = <%= intPage %>;
		var lp = <%= intPageCount %>;
		var nf = document.form1;
	</script>
    <td nowrap>�� <%=intRowCount%> �� / <%=intPageCount%> ҳ 
	<%if(intPage>1){%>	<img align="absmiddle" style="cursor:pointer; " onClick="goPage('first')" src="../../images/ico_first.gif" alt="��һҳ" border="0"><img align="absmiddle" style="cursor:pointer; " onClick="goPage('prev')" src="../../images/ico_prev.gif" alt="��һҳ"    border="0">
	<%}else{%><img align="absmiddle" style="filter:Gray;" src="../../images/ico_first.gif" alt="��һҳ"  border="0"><img align="absmiddle" style="filter:Gray;" src="../../images/ico_prev.gif" alt="��һҳ" border="0"><% } %>
	�� <font color="red"><%=intPage%></font> ҳ	
	<%if(intPage<intPageCount){%> <img align="absmiddle" style="cursor:pointer; " onClick="goPage('next')" src="../../images/ico_next.gif" alt="��һҳ" border="0"><img align="absmiddle" style="cursor:pointer; " onClick="goPage('last')" src="../../images/ico_last.gif" alt="���ҳ" border="0">
	<%}else{%><img align="absmiddle" style="filter:Gray;" src="../../images/ico_next.gif" alt="��һҳ" border="0"><img align="absmiddle" style="filter:Gray;" src="../../images/ico_last.gif" alt="���ҳ" border="0"><% } %></td>
	
    <td nowrap><img align="absmiddle" src="../../images/sbtn_split.gif"></td>
    
    <td nowrap>ת�� <input name="page" type="text" size="2" value="1"> ҳ <img align="absmiddle" style="cursor:pointer; " onClick="goPage('jump')" src="../../images/goto.gif" alt="ִ��" border="0" align="absmiddle"></td>
 </tr>
</table>

</td>
</tr>

</table>

<!--��ҳ���ƽ��� style="vertical-align:top;width:100%;overflow:auto;position: relative;" -->
  <div style="height=85%;vertical-align:top;width:100%;overflow:auto;position: relative;" id="mydiv";>
    <table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" cellspacing="1" width="100%" hight="100%" class="maintab_content_table" >
      <tr class="maintab_content_table_title">
	    <th>ѡ��</th>
		<th>�ʲ������</th>
		<th>������</th>
		<th>״̬</th>
		<th>������Ϣ</th>
		<th>��Ʊ����</th>
		<th>������</th>
		<th>��������</th>
		<input type="radio" name="key_id"   style="display:none">
      </tr>

<%	  if ( intRowCount>0 ) {
	  ZC_Package zc_Package = new ZC_Package();	
	while( i < intPageSize && !rs.isAfterLast() ) {
%>
      <tr>
      	<!-- ��Ծ��������н����޸�ɾ������  -->
      	<td><input type="radio"  style="border:0" name="key_id" id='key_id' value="<%=getDBStr(rs.getString("Zc_num"))%>"/></td>
		<td align="center" nowrap>
			<a href="zc_showAll.jsp?Zc_num=<%=getDBStr(rs.getString("Zc_num"))%>&UserName=<%=getDBStr(rs.getString("UserName"))%>&status=<%=getDBStr(rs.getString("status"))%>" target="_blank" >
				<%= getDBStr(rs.getString("Zc_num"))%>
			</a>
		</td>
		<td align="center" nowrap><%= getDBStr(rs.getString("UserName"))%></td>
		<td align="center" nowrap><%= getDBStr(rs.getString("status"))%></td>
		<td align="center" nowrap>
		<% 
			//�����ʲ����ͳ�ƶ�Ӧ�ʲ���ŵĳ����ƻ�������ܺ� �Լ� ��Ʊ�����ѿ�����ܶ� 
			//���1�����߱Ƚϣ���ȣ������ʲ������е�״̬Ϊ�����ύ ����ʾ���ύ��ˡ���ť�����ʲ������е�״̬��Ϊ������ˡ�
			//���2���ʲ���Ŷ�Ӧ�ķ�Ʊ���еġ���Ʊ���Fp_num����Ϊ�� �ʲ���������ɾ���������ʲ������е�״̬Ϊ������� ����ʾ�������ϡ���ť ���״̬��Ϊ�������ϡ�
			String Zc_num = getDBStr(rs.getString("Zc_num"));
			List<String> list_rent_jx = zc_Package.querySumMoney(Zc_num);
			String sum_rent_jx = list_rent_jx.get(0);
			List<String> list_rent_fp = zc_Package.querySumMoney_Fp(Zc_num);
			String sum_rent_fp = list_rent_fp.get(0);
			double yk_Fp_rate = Double.valueOf(list_rent_fp.get(3));//�ѿ��ķ�Ʊ
			System.out.println(yk_Fp_rate < Double.valueOf("100"));
			
			String status = getDBStr(rs.getString("status"));//�ʲ���״̬
			boolean flag = zc_Package.queryFpNum(Zc_num);//��Ʊ����Ƿ����
			//System.out.println("sum_rent_fp==>"+sum_rent_fp);
			//System.out.println("sum_rent_jx==>"+sum_rent_jx);
			System.out.println("status==>"+status);
			System.out.println("��Ʊ����Ƿ����flag==>"+flag);
			//System.out.println("���ύ.equals(status)==>"+"���ύ".equals(status));
			System.out.println("qx_value==>"+qx_value);
			String status_tem = "";
			if("���ύ".equals(status) && (sum_rent_jx.equals(sum_rent_fp)) && !qx_value.equals("2")){//�ʲ���״̬Ϊ�����ύ�����ҷ�Ʊ������ ����Ȩ��Ϊ���ʲ����������ܽ�����˲���
			   status_tem = "�ύ���";
		%>
        	<a href="fp_add.jsp?Zc_num=<%=getDBStr(rs.getString("Zc_num"))%>&UserName=<%=getDBStr(rs.getString("UserName"))%>&model=tjshenhe" target="_blank">
        		�ύ���
        	</a>
		<%  
			}
			else if(flag == true && "�����".equals(status) && !qx_value.equals("2")){//��Ʊ�Ŵ��ڲ����ʲ���״̬Ϊ����� 
			   status_tem = "���";
			//������
		%>
        	<a href="fp_add.jsp?Zc_num=<%=getDBStr(rs.getString("Zc_num"))%>&UserName=<%=getDBStr(rs.getString("UserName"))%>&model=shenheOk" target="_blank">
        		���
        	</a>
		<%  }else{ 
				if(!"�����".equals(status) && !"������".equals(status) && yk_Fp_rate < Double.valueOf("100")){//�ʲ���״̬��Ϊ������ˡ����Ҳ�Ϊ�������ϡ������ѿ���Ʊ����С��100
					   status_tem = "��Ʊ�ݲ�����";
		%>
			   		��Ʊ�ݲ����������
		<%     }
				else if(flag == false && yk_Fp_rate == Double.valueOf("100")){//��Ʊ�Ų�����  
					   status_tem = "��Ʊ�Ų�����";
		%>
					��Ʊ�Ų����������
		<%
				}
				else if("������".equals(status)){
					   status_tem = "������";
		%>
					��Ʊ������
		<%
				}
		    } 
		%>
		</td>
		<td align="center" nowrap>
        	<a href="fp_showMainList.jsp?Zc_num=<%=getDBStr(rs.getString("Zc_num"))%>&Fp_tt=<%=getDBStr(rs.getString("UserName"))%>&status_tem=<%=status_tem%>" target="_blank">
        		��Ʊ����
        	</a>
        </td>	
        <td align="center" nowrap><%= getDBStr(rs.getString("caertor"))%></td>			
        <td align="center" nowrap><%= getDBDateStr(rs.getString("caertor_date"))%></td>			
      </tr>
<%
		rs.next();
		i++;
	}
}
rs.close(); 
db.close();
%>
    </table>
  </div>
  

</form>
</body>
</html>
