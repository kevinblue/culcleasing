<%@ page contentType="text/html; charset=gbk" language="java" errorPage="/public/pageError.jsp"%>
<%@page import="com.tenwa.culc.util.ConvertUtil"%>
<%@ include file="../../public/simpleHeadImport.jsp"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>保证金补贴保存</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
</head>
<BODY>
<%
	//0.基础参数
	String user_id = (String)session.getAttribute("czyid");//当前登陆人
	String sysDate = getSystemDate(0);
	String saveType = getStr(request.getParameter("savetype")); //操作类型、insert、update
	String sqlstr="";
	//================1.封装ConditionBean================
	//1.1==获取参数
    String contract_id = getStr(request.getParameter("contract_id")); //合同编号
    String begin_id = getStr(request.getParameter("begin_id")); //起租编号
    String flow_date = getStr(request.getParameter("flow_date")); //流程时间
    String interest_money = getStr(request.getParameter("interest_money"));//本次保证金贴现金额
    String interest_num = getStr(request.getParameter("interest_num"));//本次贴现期数
    String money_str = getStr(request.getParameter("money_str"));//金额字符串
    System.out.println("money_str=="+money_str);
	String [] money_list = 	money_str.split("#");
int flag = 0;
	if("add".equals(saveType)){//新增计算过的保证金补帖
		//增加基础表记录
		sqlstr = "delete from begin_caution_info where begin_id='"+begin_id+"'";
		sqlstr+="insert into begin_caution_info(begin_id,caution_money,caution_term,flow_date,create_date,creator) values ";
		sqlstr+="('"+begin_id+"','"+interest_money+"','"+interest_num+"','"+flow_date+"','"+sysDate+"','"+user_id+"')";
		flag=db.executeUpdate(sqlstr);
		//增加明细表记录
		String pre_money = String.valueOf(formatNumberDoubleTwo(Double.parseDouble(interest_money)/Integer.parseInt(interest_num)));
		//先删除旧的数据
		sqlstr = "delete from begin_caution_subsidy where begin_id='"+begin_id+"'";
		db.executeUpdate(sqlstr);
		sqlstr="";
		for(int i=1;i<=Integer.parseInt(interest_num);i++){
			sqlstr+=" insert into begin_caution_subsidy(begin_id,subsidy_money,subsidy_list,create_date,creator) values ";
			sqlstr+="('"+begin_id+"','"+pre_money+"','"+i+"','"+sysDate+"','"+user_id+"')";
		}
		System.out.println(sqlstr);
		flag+=db.executeUpdate(sqlstr);
	}else{
			//增加基础表记录
		sqlstr = "delete from begin_caution_info where begin_id='"+begin_id+"'";
		sqlstr+="insert into begin_caution_info(begin_id,caution_money,caution_term,flow_date,create_date,creator) values ";
		sqlstr+="('"+begin_id+"','"+interest_money+"','"+interest_num+"','"+flow_date+"','"+sysDate+"','"+user_id+"')";
		flag=db.executeUpdate(sqlstr);
		//增加明细表记录
		String pre_money = String.valueOf(formatNumberDoubleTwo(Double.parseDouble(interest_money)/Integer.parseInt(interest_num)));
		//先删除旧的数据
		sqlstr = "delete from begin_caution_subsidy where begin_id='"+begin_id+"'";
		db.executeUpdate(sqlstr);
		sqlstr="";
		for(int i=1;i<=Integer.parseInt(interest_num);i++){
			sqlstr+=" insert into begin_caution_subsidy(begin_id,subsidy_money,subsidy_list,create_date,creator) values ";
			sqlstr+="('"+begin_id+"','"+money_list[i-1]+"','"+i+"','"+sysDate+"','"+user_id+"')";
		System.out.println(sqlstr);
		}
		//System.out.println(sqlstr);
		flag+=db.executeUpdate(sqlstr);	
		
	}
db.close();
//所有操作成功后转向页面暂时未有明确需求未做 ***********************************************************
if(flag>0){
%>
    <script type="text/javascript">
		alert("保证金实补贴计算成功!");
		window.parent.location.reload();
	    window.close();
	</script>
<%
}else{
%>
    <script type="text/javascript">
		alert("保证金补贴计算失败!");
		window.parent.location.reload();
		this.close();
	</script>
<%	
}
%>
