<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>

<%@ include file="../../public/simpleHeadImport.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>主要股东 - 客户信息管理</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
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

<%
	String cust_id = getStr( request.getParameter("cust_id") );
%>
<body>
<form name="form1" method="post" action="frkhzygd_save.jsp" onSubmit="return Validator.Validate(this,3);">
  <table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
  <tr valign="top" class="tree_title_txt">
    <td class="tree_title_txt"  height=26 valign="middle"> 客户信息管理 &gt; 主要股东 </td>
  </tr>
  <tr valign="top">
    <td  align=center width=100% height=100%><table align=center width=96%  border="0" cellspacing="0" cellpadding="0" style="margin-top:0px">
        <tr>
          <td><!--操作按钮开始-->
            <table border="0" cellspacing="0" cellpadding="0">
              <tr class="maintab_dh">
                <td nowrap ><BUTTON class="btn_2" name="btnSave" value="保存"  type="submit" > <img src="../../images/save.gif" align="absmiddle" border="0">保存</button>
                  <BUTTON class="btn_2" name="btnReset" value="取消" onClick="window.close();"> <img src="../../images/btn_close.gif" align="absmiddle" border="0">关闭</button>
                  <!--  	
    	<a href="" class="fontcolor" type="submit" name="btnSave"><img align="absmiddle" src="../../images/save.gif" border="0" alt="保存"> 保存</a>
    	<a href="" class="fontcolor" type="reset"><img align="absmiddle" src="../../images/hg.gif" border="0" alt="重置"> 重置</a>
    	
    	<input class="btn" name="btnSave" value="保存" type="submit">
    	<input class="btn" name="btnReset" value="重置" type="reset">
    	--></td>
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
                <td id="Form_tab_0" class="Form_tab" width=70 align=center onClick="chgTabN()"  valign="middle">新 增</td>
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

      <div id="divH" class="tabBody" style="background:#ffffff;width:96%;height:500px;overflow:auto;">
        <div id="TD_tab_0">
<!--
<div class="linetype" id="mydiv" style="padding:12px vertical-align:top;margin:0px 12px 12px 12px;overflow:auto;height:300px">
-->

          <input type="hidden" name="savetype" value="add">
          <input name="cust_id" type="hidden" value="<%= cust_id %>">
          <table  border="0" cellspacing="0" cellpadding="0" width="98%" align="center" class="tab_table_title">
            <tr>
              <td scope="row" nowrap>主要股东名称：</td>
              <td nowrap><input class="text" name="stockholder_name" Require="true" maxB="50">
                <span class="biTian">*</span></td>
              <td nowrap>实际投资名称：</td>
              <td nowrap><input class="text"  name="actual_invest"  maxB="50">
                </td>
            </tr>
            <tr>
              <td scope="row" nowrap>占实收资本比例：</td>
              <td nowrap><input class="text"  name="capital_ratio" type="text" maxB="50" dataType="Rate" >%</td>
              <td nowrap>主营业务比例：</td>
              <td nowrap><input class="text" name="primary_ratio" type="text" maxB="50" dataType="Rate" >%</td>
            </tr>
           
             <tr>
              <td nowrap>备注：</td>
<td>
             <textarea class="text" name="memo" maxB="200"></textarea></td>
             
            </tr>
          </table>
        </div>
      </div></td></tr></table>
</form>
</body>
</html>
