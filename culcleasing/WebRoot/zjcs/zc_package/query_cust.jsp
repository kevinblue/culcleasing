<%@ page contentType="text/html; charset=gbk" language="java"  %>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ page import="dbconn.*" %> 
<%@page import="com.condition.ZC_Package"%> 
<jsp:useBean id="right" scope="page" class="com.filter.FilterCredit" />
<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common.jsp"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>�ʲ������� - �����˲�ѯ</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
</head>
<script type="text/javascript">
	function check_input(){
		var inputs = document.getElementsByTagName("input");
		for(var i = 0;i<inputs.length;i++){
			if(inputs[i].type=="text"){
				if(inputs[i].value.indexOf("\'")>=0){
					alert("\' �ǷǷ��ַ�");
					return false;
				}
			}
		}
	}
	//�Ƿ��ַ���֤
	function isValidStr(str,name,name_name){
	    if(str.indexOf("\\") != -1)
	    {
	       alert( name+ "�����벻�ܰ�����б��\���ţ�");
	       document.getElementById(name_name).value = "";
	       return false;
	    }
	    var ignoreStr="'\"����()<>#$%^&*+";
	    for(i=0;i<str.length;i++){
	         if(ignoreStr.indexOf(str.substring(i,i+1)) != -1)
	         {
	            alert( name+"�����벻�ܰ���'��\"��<>#$%^&*+���ŵȷ��ţ����������룡");
		        document.getElementById(name_name).value = "";
	            return false;
	          }
	     }
	    return true;
	} 
	
	//
	function check_date(){
		//searchbar
		var cust_name =  document.getElementById('cust_name').value;
		if(cust_name == null || cust_name == ""){
			alert("�����˲���Ϊ������д!");
			return false;
		}else{
			searchbar.submit();
		}
	}
	
	//ȷ��ѡ��Ŀͻ�
	function form_submit(){
		var str_key_id = '';
		var cust_name = '';
		var selectedIndex = -1;
	    var form1 = document.getElementById("searchbar");
	    var str = document.getElementsByName("key_id");
	    var i = 0;
	    for (i = 0; i < str.length; i++)
	    {
	        if (str[i].checked)
	        {
	            selectedIndex = i;
	            str_key_id = str[i].value ;
	            //ƴװ�����ֵ
	            cust_name = str[i].getAttribute('cust_name');
	        }
	    }
	    if (selectedIndex < 0 )
	    {
	        alert("����ѡ��ͻ�!");
	        return false;
	    }
    //alert(str_key_id);
    //alert(cust_name);
    var str = str_key_id + "#" + cust_name;
    window.parent.opener.addText(str);
   window.parent.close();
}
	
</script>
<form name="searchbar" action="query_cust.jsp">
<body onload="public_onload(0);" onkeydown="if(event.keyCode==13){event.keyCode=0;return false;}else{return true;}" >

					 
<%
	//���ݺ�̨�������ʲ����
	ZC_Package zc_Package = new ZC_Package();
	String zc_num = zc_Package.get_Id();
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");//��ʽ��ʱ��
	String nowDateTime = sdf.format(new Date());//��ǰ��ʽ��֮���ʱ��
	ResultSet rs = null;
	//�����˲�ѯ�� 
	String cust_name =  getStr( request.getParameter("cust_name"));// "�Ϻ���Դ������е�������޹�˾"
	
	StringBuffer sql = new StringBuffer();
	sql.append(" select    cust_id,cust_name  ") 
		 .append(" from vi_cust_all_info   ") 
		 .append(" where cust_name like '%"+cust_name+"%' ")
	     .append(" order by cust_id ");
	System.out.println("<><><><><><>====="+sql);
%>

<!--���⿪ʼ-->
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
			<tr class="tree_title_txt">
				<td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
					�ʲ������� &gt; ���  
				</td>
			</tr>
</table>
<!--�������-->
<!--������Ͳ�������ʼ-->

<table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:2px;">
			<tr class="maintab" >
				<td align="left" colspan="2" nowrap="nowrap">
					&nbsp;������&nbsp;
						<input type="text" name="cust_name" id="cust_name" size="26" value="<%=cust_name%>"  onblur="isValidStr(this.value,'������','cust_name')"/>
						<span class="biTian">*</span>
					<button class="btn_2" name="btnSave" value="��ѯ" onclick="check_date();" type="submit">
						<img src="../../images/tbtn_searh.gif" alt="��ѯ" align="absmiddle" border="0">
						<BUTTON class="btn_2" name="btnSave" value="�ύ"  onclick="form_submit()" >
									<img src="../../images/save.gif" align="absmiddle" border="0">�ύ</button>
					</button>
				</td>
			</tr>
			<tr class="maintab">
				<td align="left" width="1%">
				<!--������ť��ʼ-->
				<table border="0" cellspacing="0" cellpadding="0" >    
				    <tr class="maintab">
						<td nowrap>
						</td>
				    </tr>
				</table>
				<!--������ť����-->
			</td>
		
<td align="right" width="90%">
<!--��ҳ���ƿ�ʼ-->
<% 
	int intPageSize = 50;   //һҳ��ʾ�ļ�¼��
	int intRowCount = 0;   //��¼����
	int intPageCount = 1; //��ҳ��
	int intPage;       //����ʾҳ��
	String strPage = getStr( request.getParameter("page") );          //ȡ�ô���ʾҳ��
	if( strPage.equals("") ){                                         //������QueryString��û��page��һ����������ʱ��ʾ��һҳ����
	   intPage = 1;
	}else{
	   intPage = java.lang.Integer.parseInt(strPage);
	   if(intPage<1) intPage = 1;
	} 
	rs = db.executeQuery(sql.toString()); 
	rs.last();                                      //��ȡ��¼����
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
		var nf = document.searchbar;
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
<!--��ҳ���ƽ���-->
<!--����ʼ-->
<div style="vertical-align:top;width:100%;overflow:auto;position: relative; left: 0px; top: 0px"  id="mydiv";>
   <table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" cellspacing="1" width="100%" class="maintab_content_table" >
      <tr class="maintab_content_table_title">
		<th>ѡ��</th>
		<th>�����˱��</th>
		<th>������</th> 
      </tr> 
<%	  
if ( intRowCount!=0 ) {
	while( i < intPageSize && !rs.isAfterLast() ) {
%>
      <tr>
      	<td><input type="radio"  style="border:0" name="key_id" value="<%=getDBStr(rs.getString("cust_id"))%>" cust_name="<%=getDBStr(rs.getString("cust_name"))%>"/></td>
        <td nowrap align="center" width=""><%= getDBStr( rs.getString("cust_id") ) %></td>
		<td nowrap align="center" width=""><%= getDBStr( rs.getString("cust_name") ) %></td>
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
    </form>
</div>
<!--�������-->
</body>
</html>
