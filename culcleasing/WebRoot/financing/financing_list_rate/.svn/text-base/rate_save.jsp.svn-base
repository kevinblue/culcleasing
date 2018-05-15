<%@ page contentType="text/html; charset=gbk" language="java" errorPage=""%>
<%@ page import="java.sql.*"%>
<%@ page import="dbconn.*"%>
<%@ page import="com.*"%>
<%@ page import="com.rent.*"%>
<%@page import="com.rent.calc.*"%>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" />
<%@ include file="../../func/common.jsp"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>调息 - 央行基准利率 - 数据操作页</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script type="text/javascript" src="../../DatePicker/WdatePicker.js"></script>
</head>

<!-- 表单字段及对应中文描述 以备修改使用 
start_date,rate_half,rate_one,rate_three,rate_five,rate_abovefive,
base_rate_half,base_rate_one,base_rate_three,base_rate_five,
base_rate_abovefive,creator,create_date,modificator,modify_date
利率开始执行日期,利息调整幅度_六月,利息调整幅度_1年,利息调整幅度_3年,利息调整幅度_5年,利息调整幅度_5年以上,
利息央行基准_六月,利息央行基准_1年,利息央行基准_3年,利息央行基准_5年,
利息央行基准_5年以上,登记人,登记时间,更新人,更新日期
 -->
<BODY>
<%
	String savaType = getStr(request.getParameter("model"));
	String key_id = getStr(request.getParameter("key_id"));//央行基准利率基准表的主键
	StringBuffer insertSql = new StringBuffer();
	StringBuffer updateSql = new StringBuffer();
	ResultSet rs = null;
	int flag = 0;
	String message = "";
		//接参
	    String Adjust_time = getStr(request.getParameter("Adjust_time")); //利率开始执行日期
		
		String baseRateOne = getStr(request.getParameter("base_rate_one"));//利息央行基准_1年
		String baseRatethree = getStr(request.getParameter("base_rate_three"));//利息央行基准_3年
		String baseRateFive = getStr(request.getParameter("base_rate_five"));//利息央行基准_5
		String baseRateAbovefiv = getStr(request.getParameter("base_rate_abovefiv"));//利息央行基准_5年以上
		String creator = getStr(request.getParameter("creator"));//登记人
		String create_date = getStr(request.getParameter("create_date"));//登记时间
		String modificator = getStr(request.getParameter("modificator"));//更新人
		String modify_date = getStr(request.getParameter("modify_date"));//更新日期
		
	String repeat_flag = "";
	/* 央行基准利率添加操作 */
	String query_startDate = " select * from  financing_list_rate where rate_start_date = '"+Adjust_time+"'";
	if(savaType.equals("add")){
		//新增之前要判断fund_standard_interest表中是否存在和新增日期‘start_date’相同的数据，央行调息一天只有一条数据
		rs = db.executeQuery(query_startDate);
		rs.last(); //移到最后一行
		int rowCount = rs.getRow(); //得到当前行号，也就是记录数
		rs.beforeFirst(); //还要用到记录集，就把指针再移到初始化的位置
		if(rowCount > 0){
			repeat_flag = "1";//系统中还有没有处理完的调息或您添加的调息时间系统中已经存在
		}else{
			BigDecimal bignum = new BigDecimal("100");
			BigDecimal base_rate_one=new BigDecimal(baseRateOne).divide(bignum).setScale(4, BigDecimal.ROUND_HALF_UP); 
			BigDecimal base_rate_three=new BigDecimal(baseRatethree).divide(bignum).setScale(4, BigDecimal.ROUND_HALF_UP);  
			BigDecimal base_rate_five=new BigDecimal(baseRateFive).divide(bignum).setScale(4, BigDecimal.ROUND_HALF_UP);  
			BigDecimal base_rate_abovefiv=new BigDecimal(baseRateAbovefiv).divide(bignum).setScale(4, BigDecimal.ROUND_HALF_UP); 
			
			insertSql.append(" INSERT INTO financing_list_rate ")
	           .append(" (Adjust_time,rate_start_date ")
	           .append(" ,base_rate_one,base_rate_three,base_rate_five , base_rate_abovefiv ")
	           .append(" ,Rate_flag,creator,create_date,modificator,modify_date) ")
	     	   .append(" VALUES ")
	           .append(" ('"+Adjust_time+"','"+Adjust_time+"' ")
	           .append(" ,"+base_rate_one+","+base_rate_three+","+base_rate_five+","+base_rate_abovefiv)
	           .append(" ,'1','"+creator+"','"+create_date+"','"+modificator+"','"+modify_date+"') ");
			System.out.println("央行汇率增加(1)insert："+insertSql.toString());
			flag = db.executeUpdate(insertSql.toString());
			
			updateSql.append("update financing_list_rate set Rate_flag = '0' , rate_end_date = ")
				.append("'"+Adjust_time+"'")
				.append(" where id = (select top(1) id from financing_list_rate where Rate_flag = '1' order  by id )");
			System.out.println("央行汇率增加(2)update:"+updateSql.toString());
			db.executeUpdate(updateSql.toString());
			message="增加央行基准利率";
		}
		rs.close();
	} 

	if(savaType.equals("del")){//删除
		String del_sql = "delete from financing_list_rate where id = '"+key_id+"'";
		System.out.println("央行汇率删除(1)delete:"+del_sql);
		flag = db.executeUpdate(del_sql);
		
		StringBuffer sb = new StringBuffer();
		sb.append("update financing_list_rate set Rate_flag = '1' , rate_end_date =null ");
		sb.append(" where id = ");
		sb.append(" (select top(1) id from financing_list_rate order by id desc )");
		System.out.println("央行汇率删除(2)update:"+sb.toString());
		db.executeUpdate(sb.toString());
		
		message = "央行基准利率删除";
	}
	db.close();

	//**********************************
	if(repeat_flag.equals("1")){
%>
	<script>
		alert("很抱歉不能添加,系统中添加的央行利率在系统中已经存在!");
		opener.location.reload();
		window.close();
		//window.history.back(-1);
	</script>

<%
	}else{
		if(flag > 0){
			String hrefStr="";
			if(savaType.equals("del")){//删除成功
%>
		        <script>
					alert("<%=message%>成功!");
					opener.location.reload();
					this.close();
				</script>
<%
			}else{//修改添加成功
%>
		        <script>
					alert("<%=message%>成功!");
					opener.location.reload();
					window.close();
				</script>
<%
			}	
		}else{
%>
	        <script>
				alert("<%=message%>失败!");
				opener.location.reload();
				this.close();
			</script>
<%	
		}
	}
	db.close();
%>