<%@ page contentType="text/html; charset=gbk" language="java" %>
<html>
<head>
<title>项目立项信息</title>
<script language="JavaScript" type="text/javascript">
<!-- 
var vTagEquipment;
function getTable(vTag){
 var vParent=vTag.parentElement;
 while(vParent.tagName!="TABLE"){
   vParent=vParent.parentElement;
 } 
 return vParent;
}

function showSubTable(){
  var vTag=event.srcElement;  
  var vImg=vTag.tagName=="IMG"?vTag:(vTag.tagName=="TD"?vTag.children[0]:null);  
  var vImgPath=vImg.src.substring(0,vImg.src.lastIndexOf("/")+1);
  var sub_table=getTable(vTag).nextSibling;
  if (sub_table.style.display=="")
  {
    sub_table.style.display="none";
    vImg.src=vImgPath+"jt_a.gif"; 
  }
  else
  {
    sub_table.style.display="";
    vImg.src=vImgPath+"jt_b.gif";  
  }
}

function fn_reBack(vStr){      
   var vText=vStr;     
   while (vText.indexOf(",")!=-1) 
      vText=vText.replace(",","");  
   return vText     
}
// -->
</script>

<script language="JavaScript" type="text/javascript">
<!-- 
document._domino_target = "_self";
function _doClick(v, o, t, h) {
  var form = document._ProjectCreateForm;
  if (form.onsubmit) {
     var retVal = form.onsubmit();
     if (typeof retVal == "boolean" && retVal == false)
       return false;
  }
  var target = document._domino_target;
  if (o.href != null) {
    if (o.target != null)
       target = o.target;
  } else {
    if (t != null)
      target = t;
  }
  form.target = target;
  form.__Click.value = v;
  if (h != null)
    form.action += h;
  form.submit();
  return false;
}
// -->
</script>

<script language="JavaScript" type="text/javascript">
<!-- 
function fnSelectCustomerSingle0(vKey){
   window.open(root_path+"/DesignShare.nsf/Customer_SingleSelect?openform",vKey,fnGetWinStatus(500,380));  
}

// -->
</script>

<script language="JavaScript" type="text/javascript">
<!-- 
function isnumber(s){
var d=/^\d+$/;
 if(d.test(s)){
 return true;
}
else{
alert("请输入整数！")
return false;
}
}

// -->
</script>
</head>
<body text="#000000" bgcolor="#FFFFFF" topmargin=0 leftmargin=0 scrolling=no onload="public_onload();
">

<form method="post" action="/ELeasing/ProjectWF/ProjectCreateUser.nsf/0/cb56110229781c254825771a000d3193?EditDocument&amp;Seq=1" name="_ProjectCreateForm">
<input type="hidden" name="__Click" value="0">
<input type="hidden" name="%%ModDate" value="4825771B0031C234"><link rel="stylesheet" type="text/css" href="/WebOA/mainstyle.css">
<SCRIPT  Language="Javascript">
var wasAddress = "http://192.168.0.150:9080/tenwaleasing";
</SCRIPT>
<!--通用附件子表单-->
<SCRIPT  Language="Javascript"  SRC="/weboa/servletJS/flowAttachJs.js"></SCRIPT>
<script language="javascript">
 var userDBPath="/ELeasing/ProjectWF/ProjectAttach.nsf/"; //附件库路径
 var parent_WorkflowUnID="50DD96D68F789A334825771A000D3192"; //主控文档ID
 var parent_WFDBPath = "Eleasing/ProjectWF/ProjectCreate.nsf";
 if(parent.currentDBPath)parent_WFDBPath=parent.currentDBPath;//当前步骤号
 var parent_stepUnID="";
 if(parent.currentDocID) parent_stepUnID=parent.currentDocID; //当前步骤文档ID
 //上载附件
 function attachFile(vKey){
  var tag=null;
  if(vKey!=null){tag=$(vKey).all.attachArea;}getCurrentDiv(tag);
  if(dlg!=null){dlg.close();}
  var url=userDBPath+"FileVersion?openform&db=Eleasing/ProjectWF/ProjectCreate.nsf&parent=50DD96D68F789A334825771A000D3192&cat="+currentCategory; 
  if(parent.currentDocID!=null) url+="&stepunid="+parent.currentDocID;//当前的步骤文档ID  
  dlg=window.open(url,"",fnGetWinStatus(420,320));
   dlg.focus();
 }
 function fn_getFileEditionXML(vType){
  var xmlPath=userDBPath+"(XMLViewByWF-Cat)?readViewEntries&RestrictToCategory=50DD96D68F789A334825771A000D3192_"+currentCategory+"$&Count=1000";
  var xslPath="/WebOA/xsl/Doc_AttachList.xsl";
  var vList=new Array("IsEditor=Admin/chinaleasing","FormMode="+currentAttachDiv.editable,"Step=1","userLanguage=0","showMode=0");//showMode-显示模式(简略)
  var vHTML =fn_transXMLT(xmlPath,xslPath,vList); 
  currentAttachDiv.innerHTML=vHTML;
  if(vType!="0"){
   try{parent.fn_getFileEditionXML();}catch(e){}
  }
 }
 window.attachEvent("onload",fn_getAllAttach);
</script>
<!--实例调用函数
<div id="Attach_类别名称">
<table style="display:none" width="100%" border="0" cellspacing="0" cellpadding="0">
<tr valign="top"><td width="100%" valign="middle">
<input type="button" onclick="attachFile()" value="附件上传" class="com_button"></td></tr>

<tr valign="top"><td width="100%"><div name="attachArea" editable="yes" align=left></div></td></tr>
</table>
</div>
-->
<SCRIPT  Language="Javascript"  SRC="/weboa/servletJS/date_picker.js"></SCRIPT>
<SCRIPT  Language="Javascript"  SRC="/WEBOA/servletJS/public.js"></SCRIPT>
<SCRIPT  Language="Javascript"  SRC="/WEBOA/servletJS/publicEvent.js"></SCRIPT><SCRIPT  Language="Javascript"  SRC="/ELeasing\DesignShare.nsf/PublicJs/$FILE/MultiSelect.js"></SCRIPT>
<SCRIPT  Language="Javascript"  SRC="/WEBOA/servletJS/defined/validator.js"></SCRIPT><script language="javascript" src="/weboa/servletjs/js_dictionary.js"></script>
<script language="javascript" src="/weboa/servletjs/ajax_popupDict.js"></script>
<script language="javascript">
   var WpsRootPath="http://192.168.0.150:9080/dict";
   var TreeStartNode="";
   TreeType="";
   TreeKeyItem="";
   var preSelect = null;
</script>

<table style="display:none" width="100%" border="0" cellspacing="0" cellpadding="0">
<tr valign="top"><td width="100%">租赁物件</td></tr>

<tr valign="top"><td width="100%" valign="middle">
<input name="EquipNo" value=""></td></tr>

<tr valign="top"><td width="100%" valign="middle">
<input name="EquipName" value="牵引;挂车"></td></tr>

<tr valign="top"><td width="100%" valign="middle">
<input name="EquipSize" value="CA4250;HSD9373"></td></tr>

<tr valign="top"><td width="100%" valign="middle">
<input name="EquipVendor" value="一汽;好时代"></td></tr>

<tr valign="top"><td width="100%" valign="middle">
<input name="EquipNet" value="10000;5677788"></td></tr>

<tr valign="top"><td width="100%" valign="middle">
<input name="EquipOriginal" value="2999887;4546788"></td></tr>

<tr valign="top"><td width="100%" valign="middle">
<input name="EquipPrice" value="300000;91000"></td></tr>

<tr valign="top"><td width="100%" valign="middle">
<input name="EquipNum" value="1;1"></td></tr>

<tr valign="top"><td width="100%" valign="middle">
<input name="EquipTotalPrice" value="300000.00;91000.00"></td></tr>

<tr valign="top"><td width="100%" valign="middle">
<input name="EquipTech" value=".;."></td></tr>

<tr valign="top"><td id="td_EquipmentAddress" width="100%" valign="middle">
<input name="EquipRemark" value=".;."></td></tr>

<tr valign="top"><td width="100%" valign="middle">管理费收款</td></tr>

<tr valign="top"><td width="100%" valign="middle">
<input name="ChargeNo" value=""></td></tr>

<tr valign="top"><td width="100%" valign="middle">
<input name="ChargeDate" value=""></td></tr>

<tr valign="top"><td width="100%" valign="middle">
<input name="ChargeMoney" value=""></td></tr>

<tr valign="top"><td width="100%" valign="middle"><img width="1" height="1" src="/icons/ecblank.gif" border="0" alt=""></td></tr>
</table>
<script language="javascript">
  var baseLocalePath="domino.public.share,domino.project.publicForm,domino.project.create";
  var localeClass=new jsonLocale("2","all",false);
</script>

<table class="tab_table_title" style="margin-top:0px" width="100%" border="0" cellspacing="0" cellpadding="0">
<tr valign="top"><td style="display:none" width="100%">
<input type="button" value="" id="save" style="display:none" onclick="return _doClick('4825760800114541.576f581f8734d4c448257456000b6def/$Body/0.814', this, null)">
<input type="button" value="" id="ProjectCheck" style="display:none" onclick="return _doClick('4825760800114541.576f581f8734d4c448257456000b6def/$Body/0.8A8', this, null)">
<input type="button" onclick="document.all.ifwritestatus.value=&quot;0&quot;;

if (document.all.ProjectName.value==&quot;&quot;) {
  alert(&quot;请输入项目名称！&quot;);
 document.all.ifwritestatus.value=&quot;0&quot;;
  document.all.EquipMoney.focus();
  return false; } 

if (document.all.CustomerName.value==&quot;&quot;) {
  alert(&quot;请输入承租客户名称！&quot;);
  document.all.CustomerName.focus();
  document.all.ifwritestatus.value=&quot;0&quot;;
 return false
} 
   //设备款
if (document.all.EquipMoney.value==&quot;&quot;) {
        alert(&quot;请输入设备款！&quot;);
        document.all.EquipMoney.focus();
        return false; }     
 
 
       //生息金额

   if (document.all.LeaseCorpus.value==&quot;&quot;) {
        alert(&quot;请输入生息金额！&quot;);
        document.all.LeaseCorpus.focus();
        return false; }     
   
//设备残值

   if (document.all.ScrapValue.value==&quot;&quot;) {
        alert(&quot;请输入设备残值！&quot;);
        document.all.ScrapValue.focus();
        return false; }     
  
//基准利率
 
   if (document.all.StandardRate.value==&quot;&quot;) {
        alert(&quot;请输入基准利率！&quot;);
        document.all.StandardRate.focus();
        return false; }     
    
       //利差
      
   if (document.all.DifferenceRate.value==&quot;&quot;) {
        alert(&quot;请输入利差！&quot;);
        document.all.DifferenceRate.focus();
        return false; }     
     
       
        //租赁利率
       
   if (document.all.LeaseRate.value==&quot;&quot;) {
        alert(&quot;请输入租赁利率！&quot;);
        document.all.LeaseRate.focus();
        return false; }     
   
       //付租方式 按年 按月
      var  ss=document.getElementById(&quot;RentPayForm&quot;).value;   
  

   if (ss==&quot;&quot;) {
        alert(&quot;请输入付租方式！&quot;);
        document.all.RentPayForm.focus();
        return false; }     
   
     //租赁期限
      
   if (document.all.LeaseTerm.value==&quot;&quot;) {
        alert(&quot;请输入租赁期限！&quot;);
        document.all.LeaseTerm.focus();
        return false; }     
  

//付租方式 等额
      var  ss=document.getElementById(&quot;RentPayType&quot;);   
var  sss=ss.options[ss.selectedIndex].value;
   if (sss==&quot;&quot;) {
        alert(&quot;请输入付租方式！&quot;);
        document.all.RentPayType.focus();
        return false; }     
     
      //付租方式 先付
       var  ss=document.getElementById(&quot;ChooiceType&quot;);   
var  sss=ss.options[ss.selectedIndex].value;
   if (sss==&quot;&quot;) {
        alert(&quot;请输入付租方式！&quot;);
        document.all.ChooiceType.focus();
        return false; }     
   

   //货币类型
      var  ss=document.getElementById(&quot;Coin&quot;);   
var  sss=ss.options[ss.selectedIndex].value;
   if (sss==&quot;&quot;) {
        alert(&quot;请输入货币类型！&quot;);
        document.all.Coin.focus();
        return false; }     
    //租赁类型
      var  ss=document.getElementById(&quot;Zllx&quot;);   
var  sss=ss.options[ss.selectedIndex].value;
   if (sss==&quot;&quot;) {
        alert(&quot;请输入租赁类型！&quot;);
        document.all.Zllx.focus();
        return false; }
         //租赁物分类
      var  ss=document.getElementById(&quot;EquipType&quot;);   
var  sss=ss.options[ss.selectedIndex].value;
   if (sss==&quot;&quot;) {
        alert(&quot;请输入租赁物分类！&quot;);
        document.all.EquipType.focus();
        return false; }
         //租赁形式
      var  ss=document.getElementById(&quot;Zlxs&quot;);   
var  sss=ss.options[ss.selectedIndex].value;
   if (sss==&quot;&quot;) {
        alert(&quot;请输入租赁形式！&quot;);
        document.all.Zlxs.focus();
        return false; }
       


document.all.ifwritestatus.value=&quot;1&quot;;
document.all.save.click();

" value="" id="ifWrite" style="display:none">
<input name="ifwritestatus" value="1" style="display:none">
<input name="DocID" value="CB56110229781C254825771A000D3193" style="display:none">
<input name="WorkflowUID" value=""> </td></tr>

<tr valign="top"><td width="100%">
<table style="margin-top:2px" width="100%" border="0" cellspacing="0" cellpadding="0">
<tr valign="top"><td class="bbs_th" style="text-align:left;cursor:hand" onclick="showSubTable()" width="100%" valign="middle">&nbsp<img src="/ELeasing/ProjectWF/ProjectCreateUser.nsf/jt_b.gif?OpenImageResource" width="12" height="12" class="icon"><font face="宋体">  项目基本信息</font></td></tr>
</table>

<table class="tab_table_title" width=100% align=center width="100%" border="0" cellspacing="0" cellpadding="0">

<tr valign="top"><td width="100%">
<table style="margin-top:2px" width="100%" border="0" cellspacing="0" cellpadding="0">
<tr valign="top"><td class="bbs_th" style="text-align:left;cursor:hand" onclick="showSubTable()" width="100%" valign="middle">&nbsp<img src="/ELeasing/ProjectWF/ProjectCreateUser.nsf/jt_b.gif?OpenImageResource" width="12" height="12" class="icon"><font face="宋体">  拟商务条件</font></td></tr>
</table>

<table class="tab_table_title" width=100% align=center width="100%" border="0" cellspacing="0" cellpadding="0">
<tr valign="top"><td width="16%" valign="middle">&nbsp货币类型：</td><td width="31%" valign="middle"><span >
<input name="%%Surrogate_Coin" type="hidden" value="1">
<select name="Coin" onchange="document.forms[0].save.click();" class="text"></select>
</span></td><td width="18%" valign="middle">&nbsp设备款</td><td width="34%" valign="middle"><span >
<input name="EquipMoney" value="391000" onchange="document.all.LeaseCorpus.value=document.all.EquipMoney.value-document.all.FirstRent.value;
document.all.ScrapValueScale.value=document.all.ScrapValue.value/document.all.EquipMoney.value*100;
document.all.ScrapValueScale.value=document.all.ScrapValue.value/document.all.EquipMoney.value*100;
if(isNaN(document.all.ScrapValueScale.value))
      document.all.ScrapValueScale.value=0;
document.all.CleanFinancing.value=document.all.LeaseCorpus.value-document.all.CautionMoney.value;



" onblur="if(isNaN(document.all.EquipMoney.value)){
  alert('请正确输入数字');
  document.all.EquipMoney.focus(); 
}
document.all.LeaseCorpus.value=document.all.EquipMoney.value-document.all.FirstRent.value;
document.all.ScrapValueScale.value=document.all.ScrapValue.value/document.all.EquipMoney.value*100;
document.all.ScrapValueScale.value=document.all.ScrapValue.value/document.all.EquipMoney.value*100;
if(isNaN(document.all.ScrapValueScale.value))
      document.all.ScrapValueScale.value=0;
document.all.CleanFinancing.value=document.all.LeaseCorpus.value-document.all.CautionMoney.value;" onkeyup="document.all.LeaseCorpus.value=document.all.EquipMoney.value-document.all.FirstRent.value;
document.all.ScrapValueScale.value=document.all.ScrapValue.value/document.all.EquipMoney.value*100;
document.all.ScrapValueScale.value=document.all.ScrapValue.value/document.all.EquipMoney.value*100;
if(isNaN(document.all.ScrapValueScale.value))
      document.all.ScrapValueScale.value=0;
document.all.CleanFinancing.value=document.all.LeaseCorpus.value-document.all.CautionMoney.value;



" class="text" style="text-align:right;" maxlength="14"></span></td></tr>

<tr valign="top"><td width="16%" valign="middle">&nbsp生息金额</td><td width="31%" valign="middle"><span >
<input name="LeaseCorpus" value="184960" onblur="if(isNaN(document.all.LeaseCorpus.value)){
  alert('请正确输入数字');
  document.all.LeaseCorpus.focus(); 
}
document.all.CleanFinancing.value=document.all.LeaseCorpus.value-document.all.CautionMoney.value" onchange="document.all.CleanFinancing.value=document.all.LeaseCorpus.value-document.all.CautionMoney.value" class="readonly" style="text-align:right;" maxlength="20"></span></td><td width="18%" valign="middle">&nbsp零期租金</td><td width="34%" valign="middle"><span >
<input name="FirstRent" value="206040" onblur="if(isNaN(document.all.FirstRent.value)){
  alert('请正确输入数字');
  document.all.FirstRent.focus(); 
}
document.all.LeaseCorpus.value=document.all.EquipMoney.value-document.all.FirstRent.value

document.all.ScrapValueScale.value=document.all.ScrapValue.value/document.all.EquipMoney.value*100;
document.all.CleanFinancing.value=document.all.LeaseCorpus.value-document.all.CautionMoney.value;" class="text" style="text-align:right;" maxlength="14"></span></td></tr>

<tr valign="top"><td width="16%" valign="middle">&nbsp保证金</td><td width="31%" valign="middle"><span >
<input name="CautionMoney" value="23280" onblur="if(isNaN(document.all.CautionMoney.value)){
  alert('请正确输入数字');
  document.all.CautionMoney.focus(); 
}
document.all.CleanFinancing.value=document.all.LeaseCorpus.value-document.all.CautionMoney.value" onchange="document.all.CleanFinancing.value=document.all.LeaseCorpus.value-document.all.CautionMoney.value" class="text" style="text-align:right;" maxlength="20"></span></td><td width="18%" valign="middle">&nbsp净融资额</td><td width="34%" valign="middle"><span >
<input name="CleanFinancing" value="161680" onblur="if(isNaN(document.all.CleanFinancing.value)){
  alert('请正确输入数字');
  
  document.all.CleanFinancing.focus(); 
}
" class="readonly" style="text-align:right;" maxlength="20"></span></td></tr>

<tr valign="top"><td width="16%" valign="middle">&nbsp手续费</td><td width="31%" valign="middle"><span >
<input name="HandlingCharge" value="17460" onblur="if(isNaN(document.all.HandlingCharge.value)){
  alert('请正确输入数字');
  document.all.HandlingCharge.focus(); 
}" class="text" style="text-align:right;" maxlength="20"></span></td><td width="18%" valign="middle">&nbsp保证金利率</td><td width="34%" valign="middle"><span >
<input name="CautionRate" value="0" onchange="var Lease = document.forms[0].LeasegMoney.value
var Caution = document.forms[0].CautionRate.value
if (Lease == &quot;&quot;) 
Lease = 0;
if (Caution == &quot;&quot;) 
Caution = 0;

Lease=Lease.replace(&quot;,&quot;,&quot;&quot;);
Caution=Caution.replace(&quot;,&quot;,&quot;&quot;);
document.forms[0].CautionMoney.value = Lease * Caution / 100;" onblur="if(isNaN(document.all.CautionRate.value)){
  alert('请正确输入数字');
  document.all.CautionRate.focus(); 
}" class="text" style="text-align:right;" maxlength="20"></span>%</td></tr>

<tr valign="top"><td width="16%" valign="middle">&nbsp名义货价</td><td width="31%" valign="middle"><span >
<input name="NominalPrice" value="0" onblur="if(isNaN(document.all.NominalPrice.value)){
  alert('请正确输入数字');
  document.all.NominalPrice.focus(); 
}" class="text" style="text-align:right;" maxlength="20"></span></td><td width="18%" valign="middle">&nbsp厂商返佣</td><td width="34%" valign="middle"><span >
<input name="return_commission" value="0" onblur="if(isNaN(document.all.return_commission.value)){
  alert('请正确输入数字');
  document.all.return_commission.focus(); 
}" class="text" style="text-align:right;" maxlength="20"></span></td></tr>

<tr valign="top"><td width="16%" valign="middle">&nbsp租赁期限</td><td width="31%" valign="middle"><span >
<input name="LeaseTerm" value="18" onblur="if(isNaN(document.all.LeaseTerm.value)){
  alert('请正确输入数字');
  document.all.LeaseTerm.focus(); 
}
isnumber(document.all.LeaseTerm.value);" class="text" style="text-align:right;" maxlength="5"></span>月</td><td width="18%" valign="middle">&nbsp宽限期以及支付方式</td><td width="34%" valign="middle"><span >
<input name="GraceTerm" value="0" onblur="if(isNaN(document.all.GraceTerm.value)){
  alert('请正确输入数字');
  document.all.GraceTerm.focus(); 
}
isnumber(document.all.GraceTerm.value);" class="text" style="text-align:right;" maxlength="5"></span>月&nbsp<span >
<input name="%%Surrogate_extend_pay_style" type="hidden" value="1">
<select name="extend_pay_style" class="text" style="text-align:right;" >
<option value="按月" selected>按月
<option value="每两个月">每两个月
<option value="按季">按季
<option value="每半年">每半年
<option value="按年">按年</select>
</span></td></tr>

<tr valign="top"><td width="16%" valign="middle">&nbsp付租方式</td><td width="84%" colspan="3" valign="middle"><span >
<input name="%%Surrogate_RentPayType" type="hidden" value="1">
<select name="RentPayType" class="text"></select>
</span><span >
<input name="%%Surrogate_RentPayForm" type="hidden" value="1">
<select name="RentPayForm" class="text"></select>
</span><span >
<input name="%%Surrogate_ChooiceType" type="hidden" value="1">
<select name="ChooiceType" class="text">
<option value="">
<option value="期初">期初
<option value="期末" selected>期末</select>
</span></td></tr>

<tr valign="top"><td width="16%" valign="middle">&nbsp租赁利率
</td><td width="31%" valign="middle"><span >
<input name="LeaseRate" value="12" onblur="if(isNaN(document.all.LeaseRate.value)){
  alert('请正确输入数字');
  document.all.LeaseRate.focus(); 
}" style="text-align:right;" maxlength="20"></span>%</td><td width="18%" valign="middle">&nbsp利率调整系数</td><td width="34%" valign="middle"><span >
<input name="%%Surrogate_AdjustQuotiety" type="hidden" value="1">
<input type="radio" name="AdjustQuotiety" value="360/360" checked>360/360
<input type="radio" name="AdjustQuotiety" value="365/360">365/360</span></td></tr>

<tr valign="top"><td width="16%">&nbsp基准利率(当前利率)</td><td width="31%"><span >
<input name="StandardRate" value="12" onblur="if(isNaN(document.all.StandardRate.value)){
  alert('请正确输入数字');
  document.all.StandardRate.focus(); 
}
document.all.LeaseRate.value=parseFloat(document.all.StandardRate.value)+parseFloat(document.all.DifferenceRate.value);
      if(document.all.LeaseRate.value==&quot;NaN&quot;)
      document.all.LeaseRate.value=0;" onchange="document.all.LeaseRate.value=document.all.StandardRate.value+document.all.DifferenceRate.value;
      if(document.all.LeaseRate.value==&quot;NaN&quot;)
      document.all.LeaseRate.value=0;" onkeyup="document.all.LeaseRate.value=parseFloat(document.all.StandardRate.value)+parseFloat(document.all.DifferenceRate.value);
      if(document.all.LeaseRate.value==&quot;NaN&quot;)
      document.all.LeaseRate.value=0;" class="text" style="text-align:right;" maxlength="20"></span>%</td><td width="18%">&nbsp利差</td><td width="34%"><span >
<input name="DifferenceRate" value="0" onblur="if(isNaN(document.all.DifferenceRate.value)){
  alert('请正确输入数字');
  document.all.DifferenceRate.focus(); 
}
document.all.LeaseRate.value=parseFloat(document.all.StandardRate.value)+parseFloat(document.all.DifferenceRate.value);
      if(document.all.LeaseRate.value==&quot;NaN&quot;)
      document.all.LeaseRate.value=0;
" onchange="document.all.LeaseRate.value=parseFloat(document.all.StandardRate.value)+parseFloat(document.all.DifferenceRate.value);
      if(document.all.LeaseRate.value==&quot;NaN&quot;)
      document.all.LeaseRate.value=0;" onkeyup="document.all.LeaseRate.value=parseFloat(document.all.StandardRate.value)+parseFloat(document.all.DifferenceRate.value);
      if(document.all.LeaseRate.value==&quot;NaN&quot;)
      document.all.LeaseRate.value=0;" class="text" style="text-align:right;" maxlength="20"></span>%</td></tr>

<tr valign="top"><td width="16%">&nbsp设备残值</td><td width="31%"><span >
<input name="ScrapValue" value="0" onblur="if(isNaN(document.all.ScrapValue.value)){
  alert('请正确输入数字');
  document.all.ScrapValue.focus(); 
}
document.all.ScrapValueScale.value=document.all.ScrapValue.value/document.all.EquipMoney.value*100;
if(isNaN(document.all.ScrapValueScale.value))
      document.all.ScrapValueScale.value=0;" onchange="document.all.ScrapValueScale.value=document.all.ScrapValue.value/document.all.EquipMoney.value*100;
if(isNaN(document.all.ScrapValueScale.value))
      document.all.ScrapValueScale.value=0;" onkeyup="document.all.ScrapValueScale.value=document.all.ScrapValue.value/document.all.EquipMoney.value*100;
if(isNaN(document.all.ScrapValueScale.value))
      document.all.ScrapValueScale.value=0;" class="text" style="text-align:right;" maxlength="14"></span></td><td width="18%">&nbsp残值比列</td><td width="34%"><span >
<input name="ScrapValueScale" value="0" class="readonly" style="text-align:right;" maxlength="20"></span>%</td></tr>

<tr valign="top"><td width="16%">&nbsp租赁物保险方案</td><td width="84%" colspan="3"><span >
<textarea name="LeaseAssurance" class="h60" rows="7" cols="50"></textarea>
</span></td></tr>

<tr valign="top"><td width="16%" valign="middle">&nbsp备注</td><td width="84%" colspan="3" valign="middle"><span >
<textarea name="Memo11" class="h60" rows="7" cols="50"></textarea>
</span></td></tr>
</table>
<script language="javascript">
 dict_list("Coin","currency_type","人民币","title");
 dict_list("RentPayType","rent_paytype","等额","title");
 dict_list("RentPayForm","rent_payform","按月","title");
</script>
<table class="tab_table_title" style="display:none" width=100% align=center width="100%" border="0" cellspacing="0" cellpadding="0">
<tr valign="top"><td width="100%" colspan="4">
<input name="Coinid" value="" style="display:none">
<input name="RentPayTypeid" value="rent_paytype1">
<input name="RentPayFormid" value="" style="display:none"></td></tr>
</table>
<div align="right"></div></td></tr>

<tr valign="top"><td width="100%">
<table style="margin-top:12px" width=100% align=center border=1 bordercolorlight="#A8BCD0"  bordercolordark="#ffffff" width="100%" border="0" cellspacing="0" cellpadding="0">
<tr valign="top"><td class="bbs_th" style="text-align:left;cursor:hand" onclick="showSubTable()" width="100%" valign="middle"><img src="/ELeasing/ProjectWF/ProjectCreateUser.nsf/sign-sub.gif?OpenImageResource" width="11" height="11" class="icon"><font face="宋体">  租金测算</font></td></tr>
</table>

<table class="tab_table_title" width=100% align=center width="100%" border="0" cellspacing="0" cellpadding="0">
<tr valign="top"><td width="100%" colspan="4" valign="middle">
<input type="button" onclick="var tmpValue=&quot;&quot;;

if (location.href.lastIndexOf(&quot;?EditDocument&quot;)==-1){  

   if (document.all.td_ProjectNo.innerText==&quot;&quot;) {        
       alert(&quot;项目编号为空！&quot;);
         return false; } 
    else
       tmpValue=trim(document.all.td_ProjectNo.innerText);}
 else  {
   if (document.all.ProjectNo.value==&quot;&quot;) {
        alert(&quot;项目编号为空！&quot;);
        document.all.ProjectNo.focus();
        return false; }     
   else      
       tmpValue=document.all.ProjectNo.value;
       
       //设备款
if (document.all.EquipMoney.value==&quot;&quot;) {
        alert(&quot;请输入设备款！&quot;);
        document.all.EquipMoney.focus();
        return false; }     
        
if (document.all.EquipMoney.value &lt;= 0) {
        alert(&quot;设备款必须大于0！&quot;);
        document.all.EquipMoney.focus();
        return false; }   

if (document.all.FirstRent.value != &quot;&quot;){
if (parseFloat(document.all.EquipMoney.value) &lt;= parseFloat(document.all.FirstRent.value)){
        alert(&quot;设备款必须大于零期租金！&quot;);
        document.all.EquipMoney.focus();
        return false;
}
}

 
       //生息金额

   if (document.all.LeaseCorpus.value==&quot;&quot;) {
        alert(&quot;请输入生息金额！&quot;);
        document.all.LeaseCorpus.focus();
        return false; }     
   
//设备残值

   if (document.all.ScrapValue.value==&quot;&quot;) {
        alert(&quot;请输入设备残值！&quot;);
        document.all.ScrapValue.focus();
        return false; }   
//生息金额必须大于设备残值  
if (parseFloat(document.all.LeaseCorpus.value) &lt;= parseFloat(document.all.ScrapValue.value)){
        alert(&quot;生息金额必须大于设备残值！&quot;);
        document.all.ScrapValue.focus();
        return false;
}
  
//基准利率
 
   if (document.all.StandardRate.value==&quot;&quot;) {
        alert(&quot;请输入基准利率！&quot;);
        document.all.StandardRate.focus();
        return false; }     
        //基准利率不得小于0
        if (document.all.StandardRate.value&lt;0) {
        alert(&quot;基准利率不得小于0！&quot;);
        document.all.StandardRate.focus();
        return false; }     
    
       //利差
      
   if (document.all.DifferenceRate.value==&quot;&quot;) {
        alert(&quot;请输入利差！&quot;);
        document.all.DifferenceRate.focus();
        return false; }     
     
       
        //租赁利率
       
   if (document.all.LeaseRate.value==&quot;&quot;) {
        alert(&quot;请输入租赁利率！&quot;);
        document.all.LeaseRate.focus();
        return false; }     
   
       //付租方式 按年 按月
      //var  ss=document.getElementById(&quot;RentPayForm&quot;);   
//var  sss=ss.options[ss.selectedIndex].value;
var  sss=document.getElementById(&quot;RentPayForm&quot;).value;
   if (sss==&quot;&quot;) {
        alert(&quot;请输入付租方式！&quot;);
        document.all.RentPayForm.focus();
        return false; }     
   
     //租赁期限
      
   if (document.all.LeaseTerm.value==&quot;&quot;) {
        alert(&quot;请输入租赁期限！&quot;);
        document.all.LeaseTerm.focus();
        return false; }     
   if (document.all.LeaseTerm.value&lt;=0) {
        alert(&quot;租赁期限必须大于0！&quot;);
        document.all.LeaseTerm.focus();
        return false; }  
        
   if (document.all.GraceTerm.value != &quot;&quot;) {
   if (parseInt(document.all.GraceTerm.value) &gt; parseInt(document.all.LeaseTerm.value)){   
        alert(&quot;租赁期限必须大于宽限期！&quot;);
        document.all.LeaseTerm.focus();
        return false; }    
}     
        

//付租方式 等额
    //  var  ss=document.getElementById(&quot;RentPayType&quot;);   
//var  sss=ss.options[ss.selectedIndex].value;
var  sss=document.getElementById(&quot;RentPayType&quot;).value;
   if (sss==&quot;&quot;) {
        alert(&quot;请输入付租方式！&quot;);
        document.all.RentPayType.focus();
        return false; }     
     
//间隔
     //var  ss=document.getElementById(&quot;RentPayForm&quot;);   
//var  sss=ss.options[ss.selectedIndex].value;
var sss=document.getElementById(&quot;RentPayForm&quot;).value
   if (sss==&quot;&quot;) {
        alert(&quot;请输入付租方式！&quot;);
        document.all.RentPayForm.focus();
        return false; }
        
   if (sss == &quot;按季&quot;){
   
       
   if (parseInt(document.all.GraceTerm.value)&gt;0) {
         if (parseInt(document.all.LeaseTerm.value-document.all.GraceTerm.value)%3!=0){
             alert(&quot;付租方式为按季时:租赁期限减宽限期不是3的整数倍！&quot;);
             document.all.GraceTerm.focus();
             return false;
       }
     }        
    }
    
    if (sss == &quot;每半年&quot;){

   
        if (parseInt(document.all.GraceTerm.value)&gt;0) {
         if (parseInt(document.all.LeaseTerm.value-document.all.GraceTerm.value)%6!=0){
             alert(&quot;付租方式为每半年时:租赁期限减宽限期不是6的整数倍！&quot;);
             document.all.GraceTerm.focus();
             return false;
       }
     }        
    }
    
    if (sss == &quot;按年&quot;){
     
       
       
        if (parseInt(document.all.GraceTerm.value)&gt;0) {
         if (parseInt(document.all.LeaseTerm.value-document.all.GraceTerm.value)%12!=0){
             alert(&quot;付租方式为每年时:租赁期限减宽限期不是12的整数倍！&quot;);
             document.all.GraceTerm.focus();
             return false;
       }
     }        
    }
      if (parseInt(document.all.GraceTerm.value)&gt;0) {
    if(document.getElementById(&quot;extend_pay_style&quot;).value==&quot;每两个月&quot;){
   if(document.getElementById(&quot;GraceTerm&quot;).value%2!=0){
    	alert(&quot;你选择的宽限期支付方式是每两个月,宽限期必须是2的整数倍&quot;);
		document.getElementById(&quot;GraceTerm&quot;).focus();
		return false;
   } 
 }
 
if(document.getElementById(&quot;extend_pay_style&quot;).value==&quot;按季&quot;){
   if(document.getElementById(&quot;GraceTerm&quot;).value%3!=0){
    	alert(&quot;你选择的宽限期支付方式是按季,宽限期必须是3的整数倍&quot;);
		document.getElementById(&quot;GraceTerm&quot;).focus();
		return false;
   } 
 }

 if(document.getElementById(&quot;extend_pay_style&quot;).value==&quot;每半年&quot;){
   if(document.getElementById(&quot;GraceTerm&quot;).value%6!=0){
    	alert(&quot;你选择的宽限期支付方式是每半年,宽限期必须是6的整数倍&quot;);
		document.getElementById(&quot;GraceTerm&quot;).focus();
		return false;
   } 
 }
  if(document.getElementById(&quot;extend_pay_style&quot;).value==&quot;按年&quot;){
   if(document.getElementById(&quot;GraceTerm&quot;).value%12!=0){
    	alert(&quot;你选择的宽限期支付方式是按年,宽限期必须是12的整数倍&quot;);
		document.getElementById(&quot;GraceTerm&quot;).focus();
		return false;
   } 
 }  
 }
     
     
      //付租方式 先付
       //var  ss=document.getElementById(&quot;ChooiceType&quot;);   
       //var  sss=ss.options[ss.selectedIndex].value;
       var  sss=document.getElementById(&quot;ChooiceType&quot;).value;
   if (sss==&quot;&quot;) {
        alert(&quot;请输入付租方式！&quot;);
        document.all.ChooiceType.focus();
        return false; }     
  

   //货币类型
    //  var  ss=document.getElementById(&quot;Coin&quot;);   
//var  sss=ss.options[ss.selectedIndex].value;
var  sss=document.getElementById(&quot;Coin&quot;).value;
   if (sss==&quot;&quot;) {
        alert(&quot;请输入货币类型！&quot;);
        document.all.Coin.focus();
        return false; }     
        var  sss=document.getElementById(&quot;GraceTerm&quot;).value;
   if (sss&lt;0) {
        alert(&quot;宽限期不能小于0&quot;);
        document.all.GraceTerm.focus();
        return false; }   
   
   }
  var opentmpurl=&quot;&quot;
  if (location.href.lastIndexOf(&quot;?EditDocument&quot;)==-1)
  opentmpurl=wasAddress+&quot;/khxx/tfqk/tfqk_list.jsp?proj_id=&quot;+tmpValue+&quot;&amp;type=0&quot;;
  
  else
  opentmpurl=wasAddress+&quot;/khxx/tfqk/tfqk_list.jsp?proj_id=&quot;+tmpValue+&quot;&amp;type=1&quot;;
 
    var str=document.forms[0].action;
     document.forms[0].action=opentmpurl;
	document.forms[0].target=&quot;_blank&quot;;
	document.forms[0].method=&quot;post&quot;;
	document.forms[0].submit();
	document.forms[0].action=str;
 


" value="租金测算模型" class="btn3_mouseout" style="width:100px"></td></tr>
</table>
</td></tr>

<tr valign="top"><td width="100%">
<table style="margin-top:2px" width="100%" border="0" cellspacing="0" cellpadding="0">
<tr valign="top"><td class="bbs_th" style="text-align:left;cursor:hand" onclick="showSubTable()" width="100%" valign="middle">&nbsp<img src="/ELeasing/ProjectWF/ProjectCreateUser.nsf/jt_b.gif?OpenImageResource" width="12" height="12"><font face="宋体">  担保单位和承租企业概况</font></td></tr>
</table>

<table class="tab_table_title" width=100% align=center width="100%" border="0" cellspacing="0" cellpadding="0">
<tr valign="top"><td width="50%" colspan="2" valign="middle">
<input type="button" onclick="var tmpValue=&quot;&quot;;
if (location.href.lastIndexOf(&quot;?EditDocument&quot;)==-1){  

   if (document.all.td_projectno.innerText==&quot;&quot;) {        
       alert(&quot;项目编号不能为空，请先保存立项信息！&quot;);
         return false; } 
    else
       tmpValue=trim(document.all.td_projectno.innerText);}
 else  {
   if (document.all.ProjectNo.value==&quot;&quot;) {
        alert(&quot;项目编号不能为空，请先保存立项信息！&quot;);
        return false; }     
   else      
       tmpValue=document.all.ProjectNo.value;}
tmpurl=wasAddress+&quot;/xmxx/dbdw/dbdw_list.jsp?proj_id=&quot;+tmpValue;
window.open(tmpurl,&quot;&quot;,&quot;&quot;);
//http://192.168.0.202:9080/tenwaleasing//xmxx/dbdw/dbdw_list.jsp
" value="担保单位" class="btn3_mouseout"></td><td width="50%" colspan="2" valign="middle">
<input type="button" onclick="var tmpValue=&quot;&quot;;
if (location.href.lastIndexOf(&quot;?EditDocument&quot;)==-1){  

   if (document.all.td_CustomerNo.innerText==&quot;&quot;) {        
       alert(&quot;客户编号不能为空，请先保存客户信息！&quot;);
         return false; } 
    else
       tmpValue=trim(document.all.td_CustomerNo.innerText);}
 else  {
   if (document.all.CustomerNumber.value==&quot;&quot;) {
        alert(&quot;客户编号不能为空，请先保存客户信息！&quot;);
        return false; }     
   else      
       tmpValue=document.all.CustomerNumber.value;}
       
     
tmpurl=wasAddress+&quot;/khxx/khqygk/khqygk.jsp?cust_id=&quot;+tmpValue;
window.open(tmpurl,&quot;&quot;,&quot;&quot;);
//http://192.168.0.202:9080/tenwaleasing/khxx/khqygk/khqygk.jsp?
" value="企业概况" class="btn3_mouseout"></td></tr>
</table>
</td></tr>
</table>
<script language="javascript">localeClass.getLang();</script>
<noscript></form>
</body>
</html>
