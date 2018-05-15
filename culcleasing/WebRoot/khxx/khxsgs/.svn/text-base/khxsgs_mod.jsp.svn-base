<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>

<%@ include file="../../public/simpleHeadImport.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>下属公司 - 客户信息管理</title>

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

<form name="form1" method="post" action="khxsgs_save.jsp" onSubmit="return Validator.Validate(this,3);">
  <table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
    <tr valign="top" class="tree_title_txt">
      <td class="tree_title_txt"  height=26 valign="middle"> 客户信息管理 &gt; 下属公司 </td>
    </tr>
    <tr valign="top">
      <td  align=center width=100% height=100%><table align=center width=96%  border="0" cellspacing="0" cellpadding="0" style="margin-top:0px">
          <tr>
            <td nowrap><!--操作按钮开始-->
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
	String id = getStr( request.getParameter("czid") );
	String rank = "";
	String cust_id = "";	
	String create_date = "";
	String memo = "";
	String creator = "";	
	String modificator = "";
	String modify_date = "";
	String reg_number = "";
	String profit_year = "";
	String biz_scope_primary= "";
	String stake = "";
	String asset_liability="";
	String asset_size="";
	ResultSet rs;
	String sqlstr = "select *,dengjiren=dbo.GETUSERNAME(creator),xiugairen=dbo.GETUSERNAME(modificator) from vi_cust_member_company where id='" + id + "'"; 

	rs = db.executeQuery(sqlstr); 
	if (rs.next()){
	asset_size=getDBStr(rs.getString("asset_size"));
	profit_year=getDBStr(rs.getString("profit_year"));
		rank = getDBStr( rs.getString("rank") );
		cust_id = getDBStr( rs.getString("cust_id") );		
		create_date = getDBDateStr( rs.getString("create_date") );
		memo = getDBStr( rs.getString("memo") );
		creator = getDBStr( rs.getString("dengjiren") );		
		modificator = getDBStr( rs.getString("modificator") );
		modify_date = getDBDateStr( rs.getString("modify_date") );
		reg_number = getDBStr( rs.getString("reg_number") );
		profit_year = getDBStr( rs.getString("profit_year") );
		biz_scope_primary = getDBStr( rs.getString("biz_scope_primary") );
		stake = getDBStr( rs.getString("stake") );
		asset_liability = getDBStr( rs.getString("asset_liability") );
	}
	rs.close();
	db.close();
%>
        <div id="divH" class="tabBody" style="background:#ffffff;width:96%;height:500px;overflow:auto;">
          <div id="TD_tab_0">
            <input type="hidden" name="savetype" value="mod">
            <input type="hidden" name="czid" value="<%=id %>">
            <input class="text" name="cust_id" type="hidden" value="<%= cust_id %>">
            <table  border="0" cellspacing="0" cellpadding="0" width="98%" align="center" class="tab_table_title">
               <tr>
                <td scope="row" nowrap>公司名称：</td>
                <td nowrap><input class="text" name="rank" value="<%= rank %>" Require="true"><span class="biTian">*</span></td>
                <td nowrap>注册资本：</td>
                <td nowrap><input class="text" name="reg_number" value="<%=reg_number %>" Require="true" dataType="Money">
                  <span class="biTian">*</span></td>
              </tr>
              <tr>
                <td scope="row" nowrap>持股比例：</td>
                <td nowrap><input class="text" name="stake" value="<%= stake %>" type="text" dataType="Number">%</td>
                <td nowrap>主营业务：</td>
                <td nowrap><input class="text" name="biz_scope_primary" value="<%= biz_scope_primary %>" type="text"  ></td>
              </tr>
              <tr>
                <td scope="row" nowrap>资产规模：</td>
                <td nowrap><input class="text" name="asset_size" value="<%= asset_size %>" Require="true"><span class="biTian">*</span></td>
                <td nowrap>资产负债率：</td>
                <td nowrap><input class="text" name="asset_liability" value="<%= asset_liability %>" Require="true" dataType="Number">
                  %<span class="biTian">*</span></td>
              </tr>
              
          <tr>
          <td scope="row" nowrap>本年净利润：</td>
                <td nowrap><input class="text" name="profit_year" value="<%= profit_year %>" type="text" dataType="Number"><span class="biTian">*</span></td>
          <td nowrap></td><td nowrap></td>
          </tr>
              <tr>
                <td nowrap>备注：</td>
                <td nowrap><textarea class="text" name="memo" rows="4" maxB="200"><%= memo %></textarea></td>
              </tr>
            </table>
          </div>
        </div></td>
    </tr>
  </table>
</form>
<script language="javascript">
 dict_list("credit_rank","CredDegree","","name");
</script>
</body>
</html>
