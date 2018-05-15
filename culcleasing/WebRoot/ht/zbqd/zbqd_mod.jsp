<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>合同正本清单修改 - 合同管理</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script><script src="../../js/validator.js"></script>
<SCRIPT  Language="Javascript"  SRC="/tenwa/js/public.js"></SCRIPT>
<SCRIPT  Language="Javascript"  SRC="/tenwa/js/publicEvent.js"></SCRIPT>
<script language="javascript" src="/dict/js/js_dictionary.js"></script>
<script language="javascript" src="/dict/js/ajax_popupDialog.js"></script>
</head>
<jsp:useBean id="right" scope="page" class="com.filter.FilterCredit" />
<%
String dqczy=(String) session.getAttribute("czyid");
if ((dqczy==null) || (dqczy.equals("")))
{
  dqczy="无认证";
  response.sendRedirect("../../noright.jsp");
}
int canedit=0;
if (right.CheckRight("contract-zbqd-mod",dqczy)>0) canedit=1;
if (canedit==0) response.sendRedirect("../../noright.jsp");
%>


<body onLoad="fun_winMax();">
<form name="form1" method="post" action="zbqd_save.jsp" onSubmit="return Validator.Validate(this,3);">
<div id=bgDiv>
<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle">
合同管理 &gt; 合同正本清单修改
</td>
</tr>
<tr valign="top">
<td  align=center width=100% height=100%>
<table align=center width=96%  border="0" cellspacing="0" cellpadding="0" style="margin-top:0px">
<tr>
<td>
<!--操作按钮开始-->
<table border="0" cellspacing="0" cellpadding="0" height="30">
	  <tr>
	    <td>
	    	
<BUTTON class="btn_2" name="btnSave" value="保存"  type="submit" >
<img src="../../images/save.gif" align="absmiddle" border="0">保存</button>
<BUTTON class="btn_2" name="btnReset" value="取消" onClick="window.close();">
<img src="../../images/hg.gif" align="absmiddle" border="0">取消</button>

	    	</td>
	  </tr>
</table>
<!--操作按钮结束-->
</td>
</tr>
<tr><td height="1" bgcolor="#DFDFDF"></td></tr>
<tr><td height="5"></td></tr>
<tr><td width="100%">
 <table border="0" cellspacing="0" cellpadding="0">
 <tr>
  <td id="Form_tab_0" class="Form_tab" width=70 align=center onClick="chgTabN()"  valign="middle">维护信息</td>
  
  <td id="Form_tab_1" class="Form_tab" width=0 align=center onClick="chgTabN()"  valign="middle"></td>
  <td id="Form_tab_2" class="Form_tab" width=0 align=center onClick="chgTabN()"  valign="middle"></td>
  
 </tr>
 </table></td></tr> 
<tr><td class="tab_subline" width="100%" height="2"></td></tr>
</table>
<center>

<div id="divH" class="tabBody" style="background:#ffffff;width:96%;height:500px;overflow:auto;">
<div id="TD_tab_0">

<%


	String czid = getStr( request.getParameter("czid") );
	String sqlstr = "select DISTINCT info.contract_id,dbo.getcustnamebycontractid(info.contract_id) as cust_name,DBO.GETMODELBYID(equip.DEVICE_TYPE) AS DEVICE_TYPE,equip.equip_sn,convert(varchar(10),start_date,120) as start_date,first_payment_ratio,lease_term,convert(varchar,(select top 1 rent from fund_rent_plan as plans where plans.contract_id=info.contract_id order by rent_list),1) as rent,dbo.fk_getname(info.proj_dept)as proj_dept ,base.province,convert(varchar(10),confirm_date,120)as confirm_date,convert(varchar(10),get_date,120) as get_date,dbo.getattach(info.contract_id) as attach_memo,convert(varchar(10),branch_expdate,120) as branchexpdate ,convert(varchar(10),csmd_receive_date,120)as csmdredate,convert(varchar(10),csmd_expdate,120)as csmdexpdate,convert(varchar(10),proj.offer_date,120) as offer_date,special_remark from contract_info as info left join contract_condition as con on (info.contract_id=con.contract_id) left join contract_equip as equip on (info.contract_id=equip.contract_id) left join downpayment_info as down on (info.contract_id=down.contract_id) left join insurance_info as ins on (info.contract_id=ins.contract_id) left join proj_info as proj on(info.proj_id=proj.proj_id) left join contract_time_info as timeinfo on(info.contract_id=timeinfo.contract_id) left join base_filiale_province as base on(info.proj_dept=base.filiale_id)  where  info.contract_id='"+czid+"'"; 
	System.out.println("======="+sqlstr);
	ResultSet rs = db.executeQuery(sqlstr); 
	String	cust_name = "";
	String	DEVICE_TYPE = "";
	String	equip_sn = "";
	String	start_date = "";
	String	first_payment_ratio = "";
	String	lease_term = "";
	String	rent = "";
	String	proj_dept = "";
	String	province = "";
    
	String	confirm_date = "";
	String	get_date = "";
	String	attach_memo = "";
    
    String	branchexpdate = "";
	String	csmdredate = "";
	String	csmdexpdate = "";
    String	offer_date = "";
	String	special_remark = "";
	if ( rs.next() ) {
       cust_name = getDBStr( rs.getString("cust_name") );
       DEVICE_TYPE = getDBStr( rs.getString("DEVICE_TYPE") );
      equip_sn  = getDBStr( rs.getString("equip_sn") );
       start_date = getDBDateStr( rs.getString("start_date") );
        first_payment_ratio= getDBStr( rs.getString("first_payment_ratio") );
       lease_term = getDBStr( rs.getString("lease_term") );
       rent = getDBStr( rs.getString("rent") );
       proj_dept = getDBStr( rs.getString("proj_dept") );
        province= getDBStr( rs.getString("province") );
		
        confirm_date= getDBDateStr( rs.getString("confirm_date") );
        get_date= getDBDateStr( rs.getString("get_date") );
       attach_memo = getDBStr( rs.getString("attach_memo") );
	   
	   branchexpdate= getDBDateStr( rs.getString("branchexpdate") );
        csmdredate= getDBDateStr( rs.getString("csmdredate") );
       csmdexpdate = getDBStr( rs.getString("csmdexpdate") );
	   csmdexpdate= getDBDateStr( rs.getString("csmdexpdate") );
        offer_date= getDBDateStr( rs.getString("offer_date") );
       special_remark = getDBStr( rs.getString("special_remark") );
	}
	rs.close(); 
	db.close();
%>


<input type="hidden" name="savetype" value="mod">
<input type="hidden" name="czid" value="<%= czid %>">
<table border="0" cellspacing="0" cellpadding="0" width="98%" align="center" class="tab_table_title">
  <tr>
    <td>客户名称</td>
    <td><input name="cust_name" type="text" value="<%= cust_name %>"  readonly ></td>
    <td>设备型号</td>
    <td><input name="DEVICE_TYPE" type="text" value="<%= DEVICE_TYPE %>"  readonly></td>
     </tr>
     <tr>
    <td>机编号</td>
    <td><input name="equip_sn" type="text" value="<%= equip_sn %>"   readonly></td>
    <td>起租日</td>
    <td><input name="start_date" type="text"  value="<%= start_date %>" readonly></td>
     </tr>
    <tr>
    <td>首付比例</td>
    <td><input name="first_payment_ratio" type="text"  value="<%= first_payment_ratio %>"  readonly></td>
    <td>租赁期限</td>
    <td><input name="lease_term" type="text" value="<%= lease_term %>"  readonly ></td>
    </tr>
    <tr>
    <td>每期租金</td>
    <td><input name="rent" type="text" value="<%= rent %>"  readonly></td>
    <td>分公司</td>
    <td><input name="proj_dept" type="text" value="<%= proj_dept %>"  readonly></td>
  </tr>
  <td>省份</td>
    <td><input name="province" type="text" value="<%= province %>"   readonly></td>
    <td>资料所在地</td>
    <td><input name="111" type="text"  value="" readonly></td>
     </tr>
    <tr>
    <td>首付确认日期</td>
    <td><input name="confirm_date" type="text"  value="<%= confirm_date %>"  readonly></td>
    <td>收保单日期</td>
    <td><input name="get_date" type="text" value="<%= get_date %>"  readonly ></td>
    </tr>
    <tr>
    <td>文件备注</td>
    <td><input name="attach_memo" type="text" value="<%= attach_memo %>"  readonly></td>
    <td>发票开具日</td>
    <td><input name="222" type="text" value=""  readonly></td>
  </tr>
   <tr>
   <td>分公司寄件日</td>
    <td><input name="branchexpdate" type="text" value="<%= branchexpdate %>"  readonly></td>
    <td>CSMD收件日</td>
    <td><input name="csmdredate" type="text" value="<%= csmdredate %>"  readonly></td>
  </tr>
   <tr>
     <td>CSMD寄件日</td>
    <td><input name="csmdexpdate" type="text" value="<%= csmdexpdate %>"  readonly></td>
    <td>报价通过日期</td>
    <td><input name="offer_date" type="text" value="<%= offer_date %>"  readonly></td>
  </tr>
     <tr>
    <td>特别备注</td>
    <td><textarea name="special_remark"><%= special_remark %></textarea></td>
    <td></td>
    <td></td>
  </tr>
</table>
</div>
</div>

<div id="TD_tab_1" style="display:none;"> 
  选择卡中的内容2
</div>
<div id="TD_tab_2" style="display:none;"> 
  选择卡中的内容3

选择卡中可能包含以下内容：

注意HTMLBody并不是选择卡中的内容，因此需要独立拿出来放在最后。

</div>

</center>
<table width=96% align=center border="0" cellspacing="0" cellpadding="0">
<tr><td width="50%"></td>
<td width="50%" valign="middle" align="right">&nbsp;</td></tr>
</table>
</td>
</tr>
</table>  
</div>
<!--添加结束-->

<!--控制选择卡和内置iframe的高度适应窗口-->
<script language="javascript">

</script>
</form>








<!-- end cwMain -->
</body>
</html>
