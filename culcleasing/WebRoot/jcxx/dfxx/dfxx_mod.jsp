<%@ page contentType="text/html; charset=gbk" language="java" %>
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" />
<jsp:useBean id="db1" scope="page" class="dbconn.Conn" />
<jsp:useBean id="db2" scope="page" class="dbconn.Conn" />   
<jsp:useBean id="db3" scope="page" class="dbconn.Conn" /> 
<jsp:useBean id="db4" scope="page" class="dbconn.Conn" /> 
<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>基础信息管理 - 评分</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script><script src="../../js/validator.js"></script>
</head>


<%
String id = getStr( request.getParameter("czid") );
String target_id = getStr( request.getParameter("target_id") );
String doc_id = getStr( request.getParameter("doc_id") );
%>




<body onload="setDivHeight('divH',-55);fun_winMax();">


<form name="form1" method="post" action="dfxx_save.jsp" onSubmit="return Validator.Validate(this,3);">

<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle">
评分 &gt; 基础信息管理
</td>
</tr>
<tr valign="top">
<td  align=center width=100% height=100%>
<table align=center width=96%  border="0" cellspacing="0" cellpadding="0" style="margin-top:0px">
<tr>
<td>
<!--操作按钮开始-->
<table border="0" cellspacing="0" cellpadding="0">    
<tr class="maintab_dh"><td nowrap >	
<BUTTON class="btn_2" name="btnSave" value="保存"  type="submit" >
<img src="../../images/save.gif" align="absmiddle" border="0">保存</button>
<BUTTON class="btn_2" name="btnReset" value="取消" onclick="window.close();">
<img src="../../images/hg.gif" align="absmiddle" border="0">取消</button>

    	
<!--  	
    	<a href="" class="fontcolor" type="submit" name="btnSave"><img align="absmiddle" src="../../images/save.gif" border="0" alt="保存"> 评分</a>
    	<a href="" class="fontcolor" type="reset"><img align="absmiddle" src="../../images/hg.gif" border="0" alt="重置"> 重置</a>
    	
    	<input class="btn" name="btnSave" value="保存" type="submit">
    	<input class="btn" name="btnReset" value="重置" type="reset">
    	-->
    </td></tr>
</table>
<!--操作按钮结束-->
</td>
</tr>
<tr><td height="1" bgcolor="#DFDFDF"></td></tr>
<tr><td height="5"></td></tr>
<tr><td width="100%">
 <table border="0" cellspacing="0" cellpadding="0">
 <tr>
  <td id="Form_tab_0" class="Form_tab" width=70 align=center onclick="chgTabN()"  valign="middle">修 改</td>
  
  <td id="Form_tab_1" class="Form_tab" width=0 align=center onclick="chgTabN()"  valign="middle"></td>
  <td id="Form_tab_2" class="Form_tab" width=0 align=center onclick="chgTabN()"  valign="middle"></td>
  
 </tr>
 </table></td></tr> 
<tr><td class="tab_subline" width="100%" height="2"></td></tr>
</table>
<!-- end cwTop -->







<!-- end cwCellTop -->

<div id="divH" class="tabBody" style="background:#ffffff;width:96%;height:500px;overflow:auto;">
<div id="TD_tab_0">

<input type="hidden" name="savetype" value="mod">
<input type="hidden" name="czid" value="<%=id%>">
<input type="hidden" name="target_id" value="<%=target_id%>">
<input type="hidden" name="doc_id" value="<%=doc_id%>">
<table  border="0" cellspacing="0" cellpadding="0" width="98%" align="center" class="tab_table_title">
 	<tr class="maintab_content_table_title">
 		<th width="20%">评分项</th>
 		<th width="40%">评分标准</th>
 		<th width="20%">显示名称</th>
 		<th width="20%">分值</th>
 	</tr>
 <%	
 	ResultSet rscount = null;
 	ResultSet rs = null;
	ResultSet rsSt = null;
 	boolean flag = false;
 	String sqlstr = "";
 	sqlstr = "select base_evaluation_model.item_id as m_item_id,base_evaluation_model.item as m_item,base_evaluation_model.weighting as m_weighting,base_evaluation_model.order_number as m_order_number from base_evaluation_model where evaluation_type=" + id+"";
	System.out.println(sqlstr);
	rscount = db3.executeQuery(sqlstr); 
	double allscore = 0;
	boolean vote_flag = true;
	while (rscount.next()){
		String item_id = getDBStr(rscount.getString("m_item_id"));
		String item = getDBStr(rscount.getString("m_item"));
		String weighting = getDBStr(rscount.getString("m_weighting"));
		String orderNumber = getDBStr(rscount.getString("m_order_number"));
		
		sqlstr = "select base_evaluation_model.item_id as m_item_id,base_evaluation_model.item as m_item,base_evaluation_model.weighting as m_weighting,base_evaluation_model.order_number as m_order_number,base_evaluation_score.* from base_evaluation_model full outer join base_evaluation_score on base_evaluation_model.item_id = base_evaluation_score.item_id where his_flag='0'";
		sqlstr+=" and base_evaluation_model.evaluation_type=" + id+" and target_id='"+target_id+"' ";
		if(doc_id!=null&&!("").equals(doc_id)){
			sqlstr+=" and base_evaluation_score.doc_id='"+doc_id+"'";
		}
		sqlstr += " and base_evaluation_score.item_id="+item_id;
		sqlstr+=" order by order_number"; 
		System.out.println(sqlstr);
		rs = null;
		rs = db.executeQuery(sqlstr);
		String text = "";
		String value = "";
		String weighting_score = "";
		String selectValue = "";
		String vote = "";
		String weight = "";
		if (rs.next()){
			weighting_score = getDBStr(rs.getString("weighting_score"));
	    	selectValue = getDBStr(rs.getString("standard_id"))+","+getDBStr(rs.getString("value"))+","+getDBStr(rs.getString("veto_flag"));
	    	vote = getDBStr(rs.getString("veto_flag"));
	    	weight = getDBStr(rs.getString("weighting"));
	    	if(vote.equals("-1")){
	    		vote_flag =false;
	    	}
	    }
%>
  <tr>
  	
    <td align="center"><%=item%><input type="hidden" name="item_id" value="<%=item_id%>"><input type="hidden" name="<%=item_id%>_item_name" value="<%=item%>"><input type="hidden" name="<%=item_id%>_order_number" value="<%=orderNumber%>"><input type="hidden" name="<%=item_id%>_weighting" value="<%=weight%>">
	</td>
    <td>
    <table  border="0" cellspacing="0" cellpadding="0" width="100%" align="center" class="tab_table_title">
    	<%
    		
    		sqlstr="select * from base_evaluation_standard  where base_evaluation_standard.item_id="+item_id+" and base_evaluation_standard.his_flag='0'  order by base_evaluation_standard.order_number";
    		System.out.println(sqlstr);
    		rsSt = null;
    		rsSt = db1.executeQuery(sqlstr);
    		while(rsSt.next()){
	    		text+="|"+getDBStr(rsSt.getString("disp_name"));
	    		value+="|"+getDBStr(rsSt.getString("standard_id"))+","+getDBStr(rsSt.getString("value"))+","+getDBStr(rsSt.getString("veto_flag"));
    	%>
    	<tr>
    		<td><%=getDBStr(rsSt.getString("disp_name"))%>-<%=getDBStr(rsSt.getString("standard"))%>-<%=getDBStr(rsSt.getString("value"))%><%if(getDBStr(rsSt.getString("veto_flag")).equals("-1")){%>-一票否决<%}%></td>
    	</tr>
    	<%
    		}
    		
    	
    	%>
    </table>
    </td>
    <%	
//    	if(text!=null&&!text.equals("")){
//    		text = text.substring(1,text.length());
//    	}
//    	if(value!=null&&!value.equals("")){
//    		value = value.substring(1,value.length());
//    	}
    	if(weighting_score!=null&&!("").equals(weighting_score)){
    		allscore+=Double.parseDouble(weighting_score);
    	}
    %>
    
    <td  align="center"><select name="var_<%=item_id%>_standard" onPropertyChange="fun_weight(this.options[this.options.selectedIndex].value,'<%=weighting%>','var_<%=item_id%>_weighting_score','var_<%=item_id%>_weighting_score_hidden')" Require="true"><script>w(mSetOpt('<%=selectValue%>','<%=text%>','<%=value%>'));</script></select> <span class="biTian">*</span></td>
    <td align="center"><input type="text" name="var_<%=item_id%>_weighting_score" size="10" readonly value="<%=weighting_score%>">
    <input type="hidden" name="var_<%=item_id%>_weighting_score_hidden" size="10" readonly value="<%=vote%>">
    </td>
  </tr>
<%
}
if(rsSt!=null)
rsSt.close();
if(rs!=null)
rs.close();
if(rscount!=null)
rscount.close();
 %>
<tr>
<td></td>
<td></td>
<td>基本评分：</td>
<td><input type="text" name="all_score" readonly value="<%=formatNumberDoubleTwo(allscore) %>" size="10">&nbsp;&nbsp;<input type="text" name="adjust" readonly value="<%=vote_flag?"":"否决" %>" size="10"></td>
</tr>
</table>
<table border="0" cellspacing="0" cellpadding="0" width="98%" align="center" class="tab_table_title">
	<tr>
	<th width="25%">其他条件</th>
	<th width="50%">评论</th>
	<th width="25%">评分调整</th>
	</tr>
	<%
	boolean adflag = false;
	ResultSet rsAdcount = null;
	ResultSet rsAdjust = null;
	String  other_condition = "";
	String comment = "";
	String comment_value = "";
	String adjust_item_id = "";
	String score_adjust = "";
	sqlstr ="select * from base_evaluation_adjust where evaluation_type="+id;
	System.out.println(sqlstr);
	rsAdcount = db4.executeQuery(sqlstr);
	while (rsAdcount.next()){
		other_condition = "";
		comment = "";
		comment_value = "";
		adjust_item_id = "";
		other_condition = getDBStr(rsAdcount.getString("other_condition"));
		comment = getDBStr(rsAdcount.getString("comment"));
		adjust_item_id = getDBStr(rsAdcount.getString("adjust_item_id"));
		sqlstr = "select base_evaluation_adjust.adjust_item_id,base_evaluation_adjust.other_condition,base_evaluation_adjust.comment,base_evaluation_adjust_score.comment_value as comment_value,base_evaluation_adjust_score.score_adjust,base_evaluation_adjust.order_number from base_evaluation_adjust left outer join base_evaluation_adjust_score on base_evaluation_adjust.adjust_item_id = base_evaluation_adjust_score.adjust_item_id where  base_evaluation_adjust.his_flag='0'";
		sqlstr+=" and base_evaluation_adjust.evaluation_type="+id+" and base_evaluation_adjust_score.target_id='"+target_id+"'";
		if(doc_id!=null&&!("").equals(doc_id)){
			sqlstr+=" and base_evaluation_adjust_score.doc_id='"+doc_id+"'";
		}
		sqlstr+= " and base_evaluation_adjust_score.adjust_item_id="+adjust_item_id;
		sqlstr+=" order by base_evaluation_adjust.order_number"; 
		System.out.println(sqlstr);
		rsAdjust = db2.executeQuery(sqlstr);
		score_adjust = "";
		if (rsAdjust.next()){
			
			score_adjust = getDBStr(rsAdjust.getString("score_adjust"));
			comment_value = getDBStr(rsAdjust.getString("comment_value"));
			if(score_adjust!=null&&!("").equals(score_adjust)){
				allscore+=Double.parseDouble(score_adjust);
			}
		}
	%>
	<tr>
		<td align="center"><span title="<%=comment %>"><%=other_condition %></span></td>
		<td><input type="text" size="50" name="comment_<%=adjust_item_id %>_value" value="<%=comment_value %>"></td>
		<td><input type="hidden" name="adjust_item_id" value="<%=adjust_item_id %>"><input type="text" name="score_adjust_<%=adjust_item_id %>_value" value="<%=score_adjust!=null&&!score_adjust.equals("")?score_adjust:"0" %>"  onPropertyChange="fun_adjust()" Require="true"> <span class="biTian">*</span></td>
	</tr>
	<%
	}
	if(rsAdjust!=null)
	rsAdjust.close(); %>
	<tr>
	<td></td>
	<td>建议风险评分：</td>
	<td><input type="text" name="all_adjust_score" readonly value="<%=formatNumberDoubleTwo(allscore) %>" size="10">&nbsp;&nbsp;<input type="text" name="adjust_adjust" readonly value="<%=vote_flag?"":"否决" %>" size="10"></td>
	</tr>
</table>
<%	
	if(rsAdcount!=null)	
	rsAdcount.close();
	
	if(db1!=null)
	db1.close();
	if(db!=null)
	db.close();
	if(db2!=null)
	db2.close();
	if(db3!=null)
	db3.close();
	if(db4!=null)
	db4.close();
%>
</div>
</div>
</form>
</body>
</html>
<script language="javascript">
function fun_weight(dispNameValue,weighting,varscore,varscorehidden){
var allScore = 0;
var flag = true;
var score = dispNameValue.split(",");
	eval("document.forms[0]."+varscore+".value="+ForDight(score[1]*weighting/100,2));
	eval("document.forms[0]."+varscorehidden+".value="+score[2]);
	var varItem = document.forms[0].item_id;
	if(varItem.length>1){
	for(var i=0;i<varItem.length;i++){
		if(eval("document.forms[0].var_"+varItem[i].value+"_weighting_score.value")!='')
		allScore+=parseFloat(eval("document.forms[0].var_"+varItem[i].value+"_weighting_score.value"));
		if(eval("document.forms[0].var_"+varItem[i].value+"_weighting_score_hidden.value")!=''){
			if(eval("document.forms[0].var_"+varItem[i].value+"_weighting_score_hidden.value")=='-1'){
				flag = false;
			}
		}
	}
	}else{
		if(eval("document.forms[0].var_"+varItem.value+"_weighting_score.value")!='')
		allScore+=parseFloat(eval("document.forms[0].var_"+varItem.value+"_weighting_score.value"));
		if(eval("document.forms[0].var_"+varItem.value+"_weighting_score_hidden.value")!=''){
			if(eval("document.forms[0].var_"+varItem.value+"_weighting_score_hidden.value")=='-1'){
				flag = false;
			}
		}
	}
	document.forms[0].all_score.value=ForDight(allScore,2);
	document.forms[0].adjust.value=flag?"":"否决";
	document.forms[0].adjust_adjust.value=document.forms[0].adjust.value;
	var varItem = document.forms[0].adjust_item_id;
	if(varItem.length>1){
	for(var i=0;i<varItem.length;i++){
		if(eval("document.forms[0].score_adjust_"+varItem[i].value+"_value.value")!='')
			allScore+=parseFloat(eval("document.forms[0].score_adjust_"+varItem[i].value+"_value.value"));
	}
	}else{
		if(eval("document.forms[0].score_adjust_"+varItem.value+"_value.value")!='')
			allScore+=parseFloat(eval("document.forms[0].score_adjust_"+varItem.value+"_value.value"));
	}
	document.forms[0].all_adjust_score.value=ForDight(allScore,2);
}
function fun_adjust(){
	var allScore = 0;
	allScore = parseInt(document.forms[0].all_score.value);

	var varItem = document.forms[0].adjust_item_id;
	if(varItem.length>1){
	for(var i=0;i<varItem.length;i++){
		if(eval("document.forms[0].score_adjust_"+varItem[i].value+"_value.value")!='')
			allScore+=parseFloat(eval("document.forms[0].score_adjust_"+varItem[i].value+"_value.value"));
	}
	}else{
		if(eval("document.forms[0].score_adjust_"+varItem.value+"_value.value")!='')
			allScore+=parseFloat(eval("document.forms[0].score_adjust_"+varItem.value+"_value.value"));
	}
	document.forms[0].all_adjust_score.value=ForDight(allScore,2);
}
function ForDight(Dight,How){       
	Dight = Math.round(Dight*Math.pow(10,How))/Math.pow(10,How);
	return Dight;       
}
</script>