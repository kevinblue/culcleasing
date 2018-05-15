<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3c.org/TR/1999/REC-html401-19991224/loose.dtd">
<HTML xmlns="http://www.w3.org/1999/xhtml"><HEAD id=Head1><TITLE>导航</TITLE>
<META http-equiv=Content-Type content="text/html; charset=utf-8">
<STYLE type=text/css>BODY {
	PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 0px; MARGIN: 0px; PADDING-TOP: 0px; BACKGROUND-COLOR: #2a8dc8
}
BODY {
	FONT-SIZE: 11px; COLOR: #003366; FONT-FAMILY: Verdana
}
TD {
	FONT-SIZE: 11px; COLOR: #003366; FONT-FAMILY: Verdana
}
DIV {
	FONT-SIZE: 11px; COLOR: #003366; FONT-FAMILY: Verdana
}
P {
	FONT-SIZE: 11px; COLOR: #003366; FONT-FAMILY: Verdana
}
.mainMenu {
	FONT-WEIGHT: bold; FONT-SIZE: 14px; CURSOR: hand; COLOR: #000000
}
A.style2:link {
	PADDING-LEFT: 4px; COLOR: #0055bb; TEXT-DECORATION: none
}
A.style2:visited {
	PADDING-LEFT: 4px; COLOR: #0055bb; TEXT-DECORATION: none
}
A.style2:hover {
	PADDING-LEFT: 4px; COLOR: #ff0000; TEXT-DECORATION: none
}
A.active {
	PADDING-LEFT: 4px; COLOR: #ff0000; TEXT-DECORATION: none
}
.span {
	COLOR: #ff0000
}
</STYLE>

<SCRIPT language=javascript>
		function MenuDisplay(obj)
		{
		    for(var i=1;i<=4;i++)
		    {
		        document.getElementById('table_'+i).style.display='none';
				document.getElementById('table_'+i+'Span').innerText='＋';
		    }
			if(document.getElementById(obj).style.display=='none')
			{
				document.getElementById(obj).style.display='block';
				document.getElementById(obj+'Span').innerText='－';
			}
			else
			{
				document.getElementById(obj).style.display='none';
				document.getElementById(obj+'Span').innerText='＋';
			}
		}
    </SCRIPT>

<META content="MSHTML 6.00.2900.3492" name=GENERATOR></HEAD>
<%
request.setCharacterEncoding("utf-8");
String cust_id = request.getParameter("cust_id");
String user_name = request.getParameter("user_name");
String password = request.getParameter("password");
int cust_person_id = Integer.parseInt(request.getParameter("cust_person_id"));

%>
<BODY>
<FORM id=form1 name=form1 action=YHMenu.aspx method=post>
<TABLE cellSpacing=0 cellPadding=0 width=210 align=center border=0>
  <TBODY>
  <TR>
    <TD width=15><IMG src="YHMenu.files/new_005.jpg" border=0></TD>
    <TD align=middle width=180 background=YHMenu.files/new_006.jpg 
      height=35><B>联系人访问平台 －功能菜单</B> </TD>
    <TD width=15><IMG src="YHMenu.files/new_007.jpg" 
border=0></TD></TR></TBODY></TABLE>


<TABLE cellSpacing=0 cellPadding=0 width=210 align=center border=0 height=200px>
  <TBODY>
  <TR>
    <TD width=15 background=YHMenu.files/new_008.jpg></TD>
    <TD vAlign=top width=180 bgColor=#ffffff>
      <TABLE cellSpacing=0 cellPadding=3 width=165 align=center border=0>
        <TBODY>
        <TR>
          <TD class=mainMenu onClick="MenuDisplay('table_1');"><SPAN 
            class=span id=table_1Span>＋</SPAN> 系统</TD></TR>
        <TR>
          <TD>
            <TABLE id=table_1 style="DISPLAY: none" cellSpacing=0 cellPadding=2 
            width=155 align=center border=0>
              <TBODY>
              <TR>
                <TD class=menuSmall><A class=style2 
                  href="welcome.jsp" 
                  target=dmMain>－ 欢迎页</A></TD></TR>
              <TR>
                <TD class=menuSmall><A class=style2 
                  href="#" 
                  target=dmMain>－ 概况</A></TD></TR>
            </TBODY></TABLE></TD></TR>
        <TR>

          <TD background=YHMenu.files/new_027.jpg height=1></TD></TR>
        <TR>
          <TD class=mainMenu onClick="MenuDisplay('table_2');"><SPAN 
            class=span id=table_2Span>＋</SPAN> 项目管理</TD></TR>
        <TR>
          <TD>
            <TABLE id=table_2 style="DISPLAY: none" cellSpacing=0 cellPadding=2 
            width=155 align=center border=0>
              <TBODY>
              <TR>
                <TD class=menuSmall>
				<%if(cust_person_id>0){%>
				<A class=style2 
                  href="personal_proj_list.jsp?cust_id=<%=cust_id%>&user_name=<%=user_name%>&password=<%=password%>&cust_person_id=<%=cust_person_id%>" 
                  target=dmMain>－ 项目情况</A>
				  <%}else{%>
				  <A class=style2 
                  href="personal_proj_list1.jsp?cust_id=<%=cust_id%>" 
                  target=dmMain>－ 项目情况</A>
				  <%}%>
				  </TD></TR>
              </TBODY></TABLE></TD></TR>
        <TR>

          <TD background=YHMenu.files/new_027.jpg height=1></TD></TR>
        
		<TR>
          <TD class=mainMenu onClick="MenuDisplay('table_3');"><SPAN 
            class=span id=table_3Span>＋</SPAN> 承租客户管理</TD></TR>
        <TR>
          <TD>
            <TABLE id=table_3 style="DISPLAY: none" cellSpacing=0 cellPadding=2 
            width=155 align=center border=0>
              <TBODY>
              <TR>
                <TD class=menuSmall><A class=style2 
                  href="#" 
                  target=dmMain>－ 承租客户</A></TD></TR>
              </TBODY></TABLE></TD></TR>

        <TR>
          <TD background=YHMenu.files/new_027.jpg height=1></TD></TR>


		  <TR>
          <TD class=mainMenu onClick="MenuDisplay('table_4');"><SPAN 
            class=span id=table_4Span>＋</SPAN> 租金管理</TD></TR>
        <TR>
          <TD>
            <TABLE id=table_4 style="DISPLAY: none" cellSpacing=0 cellPadding=2 
            width=155 align=center border=0>
              <TBODY>
			 <!-- <script>
			  alert(<%=cust_id%>+"=="+<%=user_name%>+"=="+<%=password%>);
			  </script>-->
              <TR>
                <TD class=menuSmall>
				<%if(cust_person_id>0){%>
				<A class=style2 
                  href="rentplan_list_read.jsp?cust_id=<%=cust_id%>&user_name=<%=user_name%>&password=<%=password%>&cust_person_id=<%=cust_person_id%>" 
                  target=dmMain>－ 租金情况</A>
				<%}else{%>
				<A class=style2 
                  href="rentplan_list_read1.jsp?cust_id='<%=cust_id%>'" 
                  target=dmMain>－ 租金情况</A>
				<%}%>
				  </TD></TR>
              </TBODY></TABLE></TD></TR>

        <TR>
          <TD background=YHMenu.files/new_027.jpg height=1></TD></TR>

             
		
	

</TBODY></TABLE></FORM></BODY></HTML>
