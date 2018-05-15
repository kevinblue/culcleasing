<%@ page contentType="text/html; charset=gbk" language="java" errorPage=""%>
<%@ page import="java.sql.*"%>
<%@ page import="dbconn.*"%>
<%@ page import="com.*"%>
<%@page import="com.tenwa.culc.calc.tx.Tx_Init"%>
<%@page import="com.tenwa.culc.calc.tx.Tx_Process_BGZ"%>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" />
<%@ include file="../../func/common.jsp"%>
<!-- 2010-08-05修改为：com.rent.calc.tx.TransRateNew 以前的值为：com.rent.calc.TransRate -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>不等额租金调息 - 执行调息</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script type="text/javascript" src="../../DatePicker/WdatePicker.js"></script>
</head>

<BODY>
<%
	String czyid = (String) session.getAttribute("czyid");
	String datestr = getSystemDate(0);
	//System.out.println("=============>"+request.getParameter("all_checkbos_value"));
	String all_checkbos_value = getStr(request.getParameter("all_checkbos_value"));//获取所有需要调息的项目编号 合同编号
	String begin_id_list = getStr(request.getParameter("begin_id_list"));//获取所有需要调息的起租编号
	String str_settle_method = getStr(request.getParameter("str_settle_method"));//获取所有需要调息的租金测算方式
	String str_adjust_style = getStr(request.getParameter("adjust_style"));//获取所有需要调息的调息方式（次日 ，次期，次年）
	//String all_checkbos_value = "001#002#003#004";
	
	String adjust_id = getStr(request.getParameter("txId")); //adjust_id 央行基准利率表主键 "56";//
	String save_type = getStr(request.getParameter("save_type"));//
	System.out.println("all_checkbos_value="+all_checkbos_value+"--begin_id_list="+begin_id_list);
	//System.out.println("======adjust_id>"+adjust_id);
	int flag = 0;
	ResultSet rs;
	String message = "";
	Tx_Process_BGZ  Process = new Tx_Process_BGZ();
	if("add".equals(save_type)){
	Tx_Init tx_init= new Tx_Init();
		flag += tx_init.Tx_Int_add(all_checkbos_value,begin_id_list,adjust_id,czyid,str_adjust_style);
			message= "分配"+flag+"个合同";
	}else if("process".equals(save_type)){//调息处理
			flag=Process.tx_ProcessInfo(all_checkbos_value,begin_id_list,str_settle_method,adjust_id,czyid,str_adjust_style);
			message = "调息处理"+flag+"个合同";
	}else if("del".equals(save_type)){//调息撤消
			String [] contract_list = all_checkbos_value.split("#");//合同编号数组
			String [] begin_list = begin_id_list.split("#");//合同编号数组
			int flag2=0;//标识符，记录是否撤销的合同有发生租金回笼状态
			for(int i=0;i<contract_list.length;i++){
			String sql = "select plan_status from fund_rent_plan where contract_id='"+contract_list[i]+"' and begin_id= '"+begin_list[i]+"' and ";
				   sql += " rent_list>(select rent_list_start from fund_adjust_interest_contract where ";
				   sql += "contract_id ='"+contract_list[i]+"' and begin_id= '"+begin_list[i]+"' and adjust_id='"+adjust_id+"') and plan_status<>'未回笼'";
			rs = db.executeQuery(sql);
			if(rs.next()){
				message += "合同"+contract_list[i]+"租金已回笼,撤销失败";
				flag2+=1;
				break;
				}
			rs.close();
			}
			
			if(flag>0){//不允许调息撤销
				flag=0;//调息失败
			}else{//进行调息撤销
				
				flag=Process.tx_CancleInfo(all_checkbos_value,begin_id_list,adjust_id,str_adjust_style);
				message = "调息撤消";
			}
	}
	//************************************************************************************************
	//先进性操作判断：当交易结构中交易结构中 利率浮动类型 为：‘固定调整租金金额’和‘保持不变’时，或者租金测算方法为：‘等额本金’时不进行调息现金流的添加
	 
	//第四步：计算调息后的现金流
	// 现金流
	//调用后台方法进行调息时的租金添加	
	//flag = cashFlow.addCashFlow(list_contr, adjust_id);
	//System.out.println("调息flag的值为==> :"+flag);
	//第五步：往2张his表 fund_contract_plan_his fund_contract_plan_mark_his插入数据 状态为（后），数据从fund_contract_plan,fund_contract_plan_mark中取  插入之前先删除
	//flag = tx_Init.insert_HisTable_End(list_contr,adjust_id);	
	
	//************************************************************************************************	
	
	db.close();
		if(flag > 0){
			String hrefStr="";
%>
		        <script>
					alert("<%=message%>成功!");
					opener.parent.location.reload();
					window.close();
				</script>
<%
		}else{
%>
	        <script>
				alert("<%=message%>失败!");
				opener.location.reload();
				this.close();
			</script>
<%	
		}
%>