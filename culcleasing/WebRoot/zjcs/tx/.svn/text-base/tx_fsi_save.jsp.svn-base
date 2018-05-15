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
	StringBuffer sql = new StringBuffer();
	ResultSet rs = null;
	int flag = 0;
	String message = "";
		//接参
	    String start_date = getStr(request.getParameter("start_date")); //利率开始执行日期
//		String rate_half = "0";
	    String rate_half = getStr(request.getParameter("rate_half")); //利息调整幅度_六月
		String rate_one = getStr(request.getParameter("rate_one"));//利息调整幅度_1年
		String rate_three = getStr(request.getParameter("rate_three"));//利息调整幅度_3年
		String rate_five = getStr(request.getParameter("rate_five"));//利息调整幅度_5年
		String rate_abovefive = getStr(request.getParameter("rate_abovefive"));//利息调整幅度_5年以上
		
		String base_rate_half = getStr(request.getParameter("base_rate_half"));//利息央行基准_六月
//		String base_rate_half="0";
		String base_rate_one = getStr(request.getParameter("base_rate_one"));//利息央行基准_1年
		String base_rate_three = getStr(request.getParameter("base_rate_three"));//利息央行基准_3年
		String base_rate_five = getStr(request.getParameter("base_rate_five"));//利息央行基准_5
		
		String base_rate_abovefive = getStr(request.getParameter("base_rate_abovefive"));//利息央行基准_5年以上
		String creator = getStr(request.getParameter("creator"));//登记人
		String create_date = getStr(request.getParameter("create_date"));//登记时间
		String modificator = getStr(request.getParameter("modificator"));//更新人
		String modify_date = getStr(request.getParameter("modify_date"));//更新日期
		String adjust_flag = getStr(request.getParameter("adjust_flag"));//是否已完成调息 【2010-12-30新增字段】
		
	//SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//格式化时间
	//String nowTime=sdf.format(new Date());//当前格式化之后的时间
	String repeat_flag = "";
	/* 央行基准利率添加操作 */
	String query_startDate = " select * from  fund_standard_interest where start_date = '"+start_date+"'  or  adjust_flag = '否' ";
	if(savaType.equals("add")){
		//新增之前要判断fund_standard_interest表中是否存在和新增日期‘start_date’相同的数据，央行调息一天只有一条数据
		rs = db.executeQuery(query_startDate);
		rs.last(); //移到最后一行
		int rowCount = rs.getRow(); //得到当前行号，也就是记录数
		rs.beforeFirst(); //还要用到记录集，就把指针再移到初始化的位置
		if(rowCount > 0){
			repeat_flag = "1";//系统中还有没有处理完的调息或您添加的调息时间系统中已经存在
		}else{
			sql.append(" INSERT INTO fund_standard_interest ")
	           .append(" (start_date,rate_half,rate_one,rate_three,rate_five,rate_abovefive ")
	           .append(" ,base_rate_half,base_rate_one,base_rate_three,base_rate_five ")
	           .append(" ,base_rate_abovefive,creator,create_date,modificator,modify_date,adjust_flag) ")
	     	   .append(" VALUES ")
	           .append(" ('"+start_date+"','"+rate_half+"' ")
	           .append(" ,'"+rate_one+"','"+rate_three+"','"+rate_five+"' ")
	           .append(" ,'"+rate_abovefive+"','"+base_rate_half+"','"+base_rate_one+"' ")
	           .append(" ,'"+base_rate_three+"','"+base_rate_five+"','"+base_rate_abovefive+"' ")
	           .append(" ,'"+creator+"','"+create_date+"','"+modificator+"','"+modify_date+"','"+adjust_flag+"') ");
	//System.out.println("增加央行基准利增加SQL-->   "+sql.toString());
			//执行添加sql语句
			flag = db.executeUpdate(sql.toString());
			message="增加央行基准利率";
		}
		rs.close();
	} 
	/* 央行基准利率修改操作 */
	if(savaType.equals("mod")){//修改2次判断
		//修改前查询表fund_adjust_interest_contract对应adjust_id是否存在数据，若存在则不能修改，同添加一样需要判断日期
		//String query_faic_sql = " select * from fund_adjust_interest_contract where  adjust_id = '"+key_id+"' ";
		//System.out.println("query_faic_sql调息修改前判断SQL语句==》 "+query_faic_sql);
		//rs = db.executeQuery(query_faic_sql);
		//rs.last(); //移到最后一行
		//int rowCount = rs.getRow(); //得到当前行号，也就是记录数
		//rs.beforeFirst(); //还要用到记录集，就把指针再移到初始化的位置
		//if(rowCount > 0){
		//	repeat_flag = "3";//该条调息记录还关联未调息的项目，不能修改
		//}else{
		//	query_startDate = "";
			//该主键对应下的日期数据是可以修改的
		//	query_startDate = " select * from  fund_standard_interest where start_date = '"+start_date+"' and id <>  '"+key_id+"' ";
		//	rs = db.executeQuery(query_startDate);
		//	rs.last(); //移到最后一行
		//	rowCount = rs.getRow(); //得到当前行号，也就是记录数
		//	rs.beforeFirst(); //还要用到记录集，就把指针再移到初始化的位置
		//	if(rowCount > 0){
		//		repeat_flag = "2";//系统中还有没有处理完的调息或您添加的调息时间系统中已经存在
		//	}else{
			   //拼装修改SQL语句 主键是项目编号
			   sql.append(" UPDATE fund_standard_interest ")
			      .append(" SET modificator = '"+modificator+"' ")
			      .append(" ,modify_date = '"+modify_date+"' ")
			      .append(" ,adjust_flag = '"+adjust_flag+"' ")
			      .append(" WHERE id = '"+key_id+"' ");
				System.out.println("央行基准利率修改SQL-->   "+sql.toString());
				flag = db.executeUpdate(sql.toString());
				if(adjust_flag.equals("是")){
						String sqlstr="exec Culc_Tool_Upd_InterestDiff";
						flag += db.executeUpdate(sqlstr);
					}
				
	//		}
	//	}
		message = "修改央行基准利率";
	}
	if(savaType.equals("del")){//删除
		//删除时根据txid 查询dbo.fund_adjust_interest_contract 如果有记录就提醒不让他删除，如果没有，则删除
		String query_s = " select * from  fund_adjust_interest_contract where adjust_id = '"+key_id+"'";
		ResultSet rs1 = db.executeQuery(query_s);
		rs1.last(); //移到最后一行
		int rowCount = rs1.getRow(); //得到当前行号，也就是记录数
		rs1.beforeFirst(); //还要用到记录集，就把指针再移到初始化的位置
		if(rowCount > 0){
			repeat_flag = "33";//该条调息记录还关联未调息的项目，不能删除
		}else{
			String del_sql = "delete from fund_standard_interest where id = '"+key_id+"'";
			flag = db.executeUpdate(del_sql);
			message = "央行基准利率删除";
		}
		rs1.close();
	}
	db.close();

	//**********************************
	if(repeat_flag.equals("1")){
%>
	<script>
		alert("很抱歉不能添加,系统中还有没有处理完的调息或您添加的调息时间系统中已经存在!");
		opener.location.reload();
		window.close();
		//window.history.back(-1);
	</script>
<%
	}
	else if(repeat_flag.equals("2")){
%>
	<script>
		alert("很抱歉不能修改，“该条调息记录已经处理完” 或 “系统中已存在您需要修改调息时间”!");
		window.history.back(-1);
		window.close();
	</script>
<%
	}else if(repeat_flag.equals("3")){
%>
	<script>
		alert("该条调息记录还关联未调息的项目，不能修改!");
		opener.location.reload();
		window.close();
	</script>	
<%
	}else if(repeat_flag.equals("33")){
%>
	<script>
		alert("该条调息记录还关联未调息的项目，不能删除!");
		opener.location.reload();
		window.close();
	</script>	
<%
	}else{
		if(flag > 0){
			String hrefStr="";
			if(savaType.equals("del")){//删除成功
%>
		        <script>
					//opener.window.location.href = "frkh_list.jsp";
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