<%@ page contentType="text/html; charset=gbk" language="java" %>
<%@ page import="dbconn.*" %>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" />
<jsp:useBean id="right" scope="page" class="com.filter.FilterCredit" />
<%@ page import="java.sql.*" %>
<%@ include file="../../func/common.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>保理维护</title>

<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/validator.js"></script>
<SCRIPT  Language="Javascript"  SRC="/tenwa/js/public.js"></SCRIPT>
<SCRIPT  Language="Javascript"  SRC="/tenwa/js/publicEvent.js"></SCRIPT>
<script language="javascript" src="/dict/js/js_dictionary.js"></script>
<script language="javascript" src="/dict/js/ajax_popupDialog.js"></script>
<script src="../../js/calend.js"></script>
<script>
function checkNumber(obj,objname)
{

   re=/^[A-Za-z0-9]+$/
   code=trim(obj.value);
   if (code!="")
   {
       r = code.match(re);   
       if (r == null) {
	   alert(objname+"应只包含字母和数字!");
           obj.select();
           return false;
       }
   }   
   return true;     
}

</script>
</head>
<body>

<form name="form1" method="post" action="factoring_save.jsp" onSubmit="return Validator.Validate(this,3);">
  <table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
    <tr valign="top" class="tree_title_txt">
      <td class="tree_title_txt"  height=26 valign="middle"> 保理维护 </td>
    </tr>
    <tr valign="top">
      <td  align=center width=100% height=100%><table align=center width=96%  border="0" cellspacing="0" cellpadding="0" style="margin-top:0px">
          <tr>
            <td><!--操作按钮开始-->
              <table border="0" cellspacing="0" cellpadding="0">
                <tr class="maintab_dh">
                  <td nowrap ><BUTTON class="btn_2" name="btnSave" value="保存"  type="submit" > <img src="../../images/save.gif" align="absmiddle" border="0">保存</button>
                    <BUTTON class="btn_2" name="btnReset" value="取消" onClick="window.close();"> <img src="../../images/btn_close.gif" align="absmiddle" border="0">关闭</button></td>
                </tr>
              </table>
              <!--操作按钮结束--></td>
          </tr>
          <tr>
            <td height="1" bgcolor="#DFDFDF"></td>
          </tr>
          <tr>
            <td height="5"></td>
          </tr>
          <tr>
            <td width="100%"><table border="0" cellspacing="0" cellpadding="0">
                <tr>
                  <td id="Form_tab_0" class="Form_tab" width=70 align=center onClick="chgTabN()"  valign="middle">修 改</td>
                  <td id="Form_tab_1" class="Form_tab" width=0 align=center onClick="chgTabN()"  valign="middle"></td>
                  <td id="Form_tab_2" class="Form_tab" width=0 align=center onClick="chgTabN()"  valign="middle"></td>
                </tr>
              </table>
 <script language="javascript">
ShowTabN(0);
</script>              
              </td>
          </tr>
          <tr>
            <td class="tab_subline" width="100%" height="2"></td>
          </tr>
        </table>
        <!-- end cwTop -->
        <!-- end cwCellTop -->
        <%
	String czid = getStr( request.getParameter("id") );
	System.out.println("ggggggggggggggggggggggg"+czid);
	//String id="";
	String cust_name="";
	String contract_id="";
	String rent_list="";
	String plan_date="";
	String rent="";
	String corpus="";
	String interest="";
	String corpus_overage="";
	String factoring="";
	String factoring_pringcipal="";
	String factoring_rantal="";
	

	ResultSet rs;
	
     String sqlstr="select * from vi_fund_rent_plan_factoring where id='"+czid+"'";
	rs = db.executeQuery(sqlstr); 
	if (rs.next()){
	//id=getDBStr(rs.getString("id"));
	cust_name=getDBStr(rs.getString("cust_name"));
	contract_id=getDBStr(rs.getString("contract_id"));
	rent_list=getDBStr(rs.getString("rent_list"));
	plan_date=getDBDateStr(rs.getString("plan_date"));
	rent=getDBStr(rs.getString("rent"));
	corpus=getDBStr(rs.getString("corpus"));
	interest=getDBStr(rs.getString("interest"));
	corpus_overage=getDBStr(rs.getString("corpus_overage"));
	factoring=getDBStr(rs.getString("factoring"));
	System.out.println("factoring@@@@@@@@@@@@@@@@@@@@@@@@@"+factoring);
	factoring_pringcipal=getDBStr(rs.getString("factoring_pringcipal"));
	factoring_rantal=getDBStr(rs.getString("factoring_rantal"));
		
	
	}
	rs.close();
	db.close();
%>
        <div id="divH" class="tabBody" style="background:#ffffff;width:96%;height:500px;overflow:auto;">
          <div id="TD_tab_0">
            <input type="hidden" name="savetype" value="mod">
            <input type="hidden" name="czid" value="<%=czid %>">
         
            <table  border="0" cellspacing="0" cellpadding="0" width="98%" align="center" class="tab_table_title">
              <tr>
                <td scope="row"  nowrap>承租人：</td>
                <td  nowrap><input class="text" name="cust_name" value="<%= cust_name %>" Require="true" readonly><span class="biTian">*</span></td>
                <td  nowrap>合同号：</td>
                <td  nowrap><input class="text" name="contract_id" value="<%= contract_id %>" readonly >
                  </td>
              </tr>
              <tr>
                <td scope="row"  nowrap>期次：</td>
                <td  nowrap><input class="text" name="rent_list" value="<%= rent_list %>" Require="true" readonly><span class="biTian">*</span></td>
                <td  nowrap>收取日：</td>
                <td  nowrap><input class="text" name="plan_date" value="<%= plan_date %>" readonly >
                  </td>
              </tr>
              <tr>
                <td scope="row"  nowrap>每期租金：</td>
                <td  nowrap><input class="text" name="rent" value="<%= rent %>" Require="true" readonly><span class="biTian">*</span></td>
                <td  nowrap>每期本金：</td>
                <td  nowrap><input class="text" name="corpus" value="<%= corpus %>" readonly >
                  </td>
              </tr>
              <tr>
                <td scope="row"  nowrap>每期租息：</td>
                <td  nowrap><input class="text" name="interest" value="<%=interest%>" type="text" dataType="Rate" readonly></td>
                <td  nowrap>剩余本金：</td>
                <td  nowrap><input class="text" name="corpus_overage" value="<%=corpus_overage%>" type="text" dataType="Rate" readonly></td>
              </tr>
              <tr>
                <td scope="row"  nowrap>保理：</td>
               
                   
	
      <td scope="row" nowrap>
	
	  <select class="text" id="sel" name="factoring" value="<%=factoring%>">
	   <option id="factoring_1" value="否">否</option>
	    <option id="factoring_2" value="是">是</option>
	   
	
	</select>
	
     
      
                <td  nowrap>保理本金：</td>
                <td  nowrap><input class="text" name="factoring_pringcipal" value="<%= factoring_pringcipal %>" type="text" dataType="Rate" onclick="isCh()"></td>
              </tr>
              <tr>
                <td scope="row"  nowrap>保理租息：</td>
                <td  nowrap><input class="text" name="factoring_rantal" value="<%= factoring_rantal %>" type="text" dataType="Rate"  ></td>
              </tr>
            
              
            </table>
          </div>
        </div></td>
    </tr>
  </table>
</form>
<script language="javascript">
function isCh(){
	

var dd=document.getElementById("sel").value;
//alert(dd);
if(dd=="是"){

var corpus=document.getElementsByName("corpus")[0].value;//每期租金
//alert("corpus");
var interest=document.getElementsByName("interest")[0].value;//每期租息
document.getElementsByName("factoring_pringcipal")[0].value=corpus;
document.getElementsByName("factoring_rantal")[0].value=interest;
}
else
				{
document.getElementsByName("factoring_pringcipal")[0].value=0.00;
document.getElementsByName("factoring_rantal")[0].value=0.00;
				}



}
</script>
</body>
</html>
