<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@ page import="com.tenwa.util.CurrencyUtil"%>

<%@ include file="../../public/simpleHeadImport.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>�ʽ�ͷ�籨�� - �ʽ����޽ṹͳ�Ʊ�</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/calend.js"></script>

<script Language="Javascript" src="../../js/jquery.js"></script>
<script type="text/javascript" src="../../js/stleasing_tabledata_nonewline.js"></script>
<script type="text/javascript" src="../../js/stleasing_function.js"></script>
<link href="../../css/stleasing_tabledata.css" rel="stylesheet" type="text/css">
</head>

<!-- �������� -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- �������� -->

<body onload="public_onload(0);">
<form action="zjqxjg_report.jsp" name="dataNav">
<%
wherestr="";
String start_date = getStr(request.getParameter("start_date"));

%>

<!--���⿪ʼ-->
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
	<tr class="tree_title_txt">
		<td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
		 �ʽ�ͷ�籨��&gt; �ʽ����޽ṹͳ�Ʊ�
		</td>
	</tr>
</table><!--�������-->

<!--���۵���ѯ��ʼ-->
<div style="width:100%;" id="queryArea">
<fieldset style="width:100%;TEXT-ALIGN:center;margin:0px 5px 0px 5px;"> 
  <legend>&nbsp;��ѯ����
<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" style="cursor:hand" title="��ʾ/��������">&nbsp;
</legend>
<table border="0" width="100%" cellspacing="1" cellpadding="0">
<tr>


<td>ѡ��ʼ���ڣ�&nbsp;&nbsp;
<input name="start_date" type="text" size="15" value="<%=start_date %>" readonly dataType="Date">
<img  onClick="openCalendar(start_date);return false" style="cursor:pointer; " 
src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle"></td>

<td colspan="2">
<input type="button" onclick="dataNav.submit()" value="��ѯ">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<input type="button" onclick="clearQuery()" value="���"></td>
</tr>
</table>
</fieldset>
</div><!-- ��ѯ�������� -->

<!--������Ͳ�������ʼ-->
<table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:2px;">
	<tr class="maintab">
		<td align="left" width="1%">
		<!--������ť��ʼ-->
		<table border="0" cellspacing="0" cellpadding="0" >    
			<tr class="maintab">
				<td>
				<BUTTON class="btn_2"  type="button" onclick="exportData();">
				<img src="../../images/save.gif" align="absmiddle" border="0">&nbsp;����EXCEL</button>
				</td>
				<!-- 
				<td>
				<BUTTON class="btn_2"  type="button" onclick="return validata_data_exp();">
				<img src="../../images/save.gif" align="absmiddle" border="0">&nbsp;����PDF</button>
				</td>
				-->
				 <td>
				<img src="../../images/sbtn_split.gif" width="2" height="14">
				</td>
				<td nowrap>
				</td><!--������ť����-->
			</tr>
		</table><!--������ť����-->
		</td>
		<td align="right" width="90%">
		<!-- ��ҳ���ƿ�ʼ -->
		<!--��ҳ���ƽ���-->	
		</td>
	</tr>
</table>
 
<!--����ʼ-->
<div style="vertical-align:top;width:100%;overflow:auto;position: relative;" id="mydiv">
<table border="0" style="border-collapse:collapse;" align="center"
	cellpadding="2" cellspacing="1" width="100%" class="maintab_content_table">
	<tr class="maintab_content_table_title">
		<th colspan="2" style="font-weight: bold;">��Ŀ</th>
	    <th align="center" style="font-weight: bold;">1������</th>
	    <th align="center" style="font-weight: bold;">1-3����</th>
	    <th align="center" style="font-weight: bold;">3-6����</th>
	    <th align="center" style="font-weight: bold;">6-12����</th>
   	    <th align="center" style="font-weight: bold;">1-2��</th>
   	    <th align="center" style="font-weight: bold;">2-3��</th>	    
   	    <th align="center" style="font-weight: bold;">3��+</th>	      	    
	</tr>

<tbody id="data">
<%
//---------------
String partSql = "";
//������Ϣֵ
double x1I = 0f;//Ԫ��
double x2I = 0f;
double x3I = 0f;
double x4I = 0f;
double x5I = 0f;
double x6I = 0f;
double x7I = 0f;

double x1TS = 0f;//���� 
double x2TS = 0f;//���� 
double x3TS = 0f;//���� 
double x4TS = 0f;//���� 
double x5TS = 0f;//���� 
double x6TS = 0f;//���� 
double x7TS = 0f;//����

double x1TF = 0f;//֧��
double x2TF = 0f;
double x3TF = 0f;
double x4TF = 0f;
double x5TF = 0f;
double x6TF = 0f;
double x7TF = 0f;

//----------------
%>
<!-- �ֽ����� -->
	<%
	for ( int y=1;y<=12; y++ ){%>
		<% if(y==1){%>
		<tr>
			<td rowspan="5">�ֽ�����</td>
			<td align="center" nowrap="nowrap">������Ϣ</td>
		<%	}else if (y==2){ %>
		<tr>
			<td align="center" nowrap="nowrap">���ޱ���</td>
		<%	}else if (y==3){ %>
		<tr>
			<td align="center" nowrap="nowrap">��֤��</td>
		<%	}else if (y==4){ %>
		<tr>
			<td align="center" nowrap="nowrap">����</td>
		<%	}else if (y==5){ %>
		<tr style="background-color: #CCFFFF;font-weight: bold;">
			<td align="center" style="font-weight: bold;font-size: 16px;">����С��</td>
		<%	}else if (y==6){ %>
		<tr>
		<td rowspan="6">�ֽ�֧��</td>
			<td align="center" nowrap="nowrap">������Ϣ</td>
		<%	}else if (y==7){ %>
		<tr>
			<td align="center" nowrap="nowrap">���б���</td>
		<%	}else if (y==8){ %>
		<tr>
			<td align="center" nowrap="nowrap">��֤�𷵻�</td>
		<%	}else if (y==9){ %>
		<tr>
			<td align="center" nowrap="nowrap">�豸��</td>
		<%	}else if (y==10){ %>
		<tr>
			<td align="center" nowrap="nowrap">����</td>
		<%	}else if (y==11){ %>
		<tr style="background-color: #CCFFFF;font-weight: bold;">
			<td align="center" style="font-weight: bold;font-size: 16px;">֧��С��</td>
		<%	}else if (y==12){ %>
		<tr style="background-color: green;font-weight: bold;">
			<td colspan="2" align="center" style="font-weight: bold;font-size: 18px;">�ʽ�ȱ��</td>
		<% }%>
		
		<%
		if(y!=5 && y!=11 && y!=12){
			// ��1 �� 7 ������Ϣ
			partSql = "";
			for(int x=1;x<=7;x++){
				partSql += " dbo.Financ_BB_getDataT601('"+start_date+"',"+x+","+y+") as resVal"+x+",";
			}
			partSql = "Select "+partSql.substring(0, partSql.length()-1);
			System.out.println("partSql:"+partSql); 
			rs = db.executeQuery(partSql);
			if(rs.next()){
				x1I = rs.getDouble("resVal1");
				x2I = rs.getDouble("resVal2");
				x3I = rs.getDouble("resVal3");
				x4I = rs.getDouble("resVal4");
				x5I = rs.getDouble("resVal5");
				x6I = rs.getDouble("resVal6");
				x7I = rs.getDouble("resVal7");
				
				if(y<5){
					x1TS += x1I;
					x2TS += x2I;
					x3TS += x3I;
					x4TS += x4I;
					x5TS += x5I;
					x6TS += x6I;
					x7TS += x7I;
				}else if(y<11){
					x1TF += x1I;
					x2TF += x2I;
					x3TF += x3I;
					x4TF += x4I;
					x5TF += x5I;
					x6TF += x6I;
					x7TF += x7I;
				}
			} 
			rs.close();
		}
		%>
		
		<!-- ��ʾ��Ϣ -->
		<% if(y!=5 && y!=11 && y!=12) {%>
		<td align="right"><%=CurrencyUtil.convertFinance(x1I) %></td>
		<td align="right"><%=CurrencyUtil.convertFinance(x2I) %></td>
		<td align="right"><%=CurrencyUtil.convertFinance(x3I) %></td>
		<td align="right"><%=CurrencyUtil.convertFinance(x4I) %></td>
		<td align="right"><%=CurrencyUtil.convertFinance(x5I) %></td>
		<td align="right"><%=CurrencyUtil.convertFinance(x6I) %></td>
		<td align="right"><%=CurrencyUtil.convertFinance(x7I) %></td>
		<%}else if(y==5) {%>
		<td align="right"><%=CurrencyUtil.convertFinance(x1TS) %></td>
		<td align="right"><%=CurrencyUtil.convertFinance(x2TS) %></td>
		<td align="right"><%=CurrencyUtil.convertFinance(x3TS) %></td>
		<td align="right"><%=CurrencyUtil.convertFinance(x4TS) %></td>
		<td align="right"><%=CurrencyUtil.convertFinance(x5TS) %></td>
		<td align="right"><%=CurrencyUtil.convertFinance(x6TS) %></td>
		<td align="right"><%=CurrencyUtil.convertFinance(x7TS) %></td>
		<%}else if(y==11){%>
		<td align="right"><%=CurrencyUtil.convertFinance(x1TF) %></td>		
		<td align="right"><%=CurrencyUtil.convertFinance(x2TF) %></td>		
		<td align="right"><%=CurrencyUtil.convertFinance(x3TF) %></td>		
		<td align="right"><%=CurrencyUtil.convertFinance(x4TF) %></td>		
		<td align="right"><%=CurrencyUtil.convertFinance(x5TF) %></td>		
		<td align="right"><%=CurrencyUtil.convertFinance(x6TF) %></td>		
		<td align="right"><%=CurrencyUtil.convertFinance(x7TF) %></td>		
		<%}else if(y==12){ %>
		<td align="right"><%=CurrencyUtil.convertFinance(x1TS-x1TF) %></td>		
		<td align="right"><%=CurrencyUtil.convertFinance(x2TS-x2TF) %></td>		
		<td align="right"><%=CurrencyUtil.convertFinance(x3TS-x3TF) %></td>		
		<td align="right"><%=CurrencyUtil.convertFinance(x4TS-x4TF) %></td>		
		<td align="right"><%=CurrencyUtil.convertFinance(x5TS-x5TF) %></td>		
		<td align="right"><%=CurrencyUtil.convertFinance(x6TS-x6TF) %></td>		
		<td align="right"><%=CurrencyUtil.convertFinance(x7TS-x7TF) %></td>		
		<%} %>
		</tr>
	<%}
	db.close();
	%>
</tbody>	
</table>
</div><!--�������-->


</form>
</body>
<script type="text/javascript">
 function exportData(){
 	if(confirm("�Ƿ�ȷ������excel?")){
 		dataNav.action="zjqxjg_export_save.jsp";
 		dataNav.target="_black";
 		dataNav.submit();
 		dataNav.action="zjqxjg_report.jsp";
 		dataNav.target="_self";
 	}
 }
</script>
</html>