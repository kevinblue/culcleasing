<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@ page import="java.sql.*" %> 
<%@ page import="java.util.*" %>
<%@page import="java.util.regex.Pattern"%>
<%@page import="java.io.*"%>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<jsp:useBean id="execlBean" scope="page" class="com.UploadExecl2" />
<%@ include file="../../func/common_simple.jsp"%>

<%
String czy = (String) session.getAttribute("czyid");
//公共变量
String sqlstr="";
ResultSet rs = null;
int flag = 0;
String id = request.getParameter("prId");

//从数据库取出excel文件名称
sqlstr = "select file_name,hire_bank from fund_rent_cx where id="+id;
System.out.println("执行撤销的sql："+sqlstr);
rs = db.executeQuery(sqlstr);
rs.next();
String fileName = rs.getString("file_name");
String hire_bank = rs.getString("hire_bank");
rs.close();

String path = pageContext.getServletContext().getRealPath("/");
String filePath =path + "\\rent_cx_upload\\"+fileName;
//--标志字段
String memo = "";
String plan_id = "";

//判断是建设银行还是农业银行
if("中国建设银行".equals(hire_bank)){//建行的报盘文件
	//加载excel
	execlBean.setExecl(filePath);
	if(execlBean.getFlag()){
		String [][]obj = execlBean.getObject();
		for(int row=0;row<obj.length;row++){//从第五行开始
			String [] objrow = obj[row];	
			memo=objrow[4];//备注列
			System.out.println("========"+memo);
			if( memo==null ||  "".equals(memo) ){
				continue;
			}
			//得到plan_id
			if(memo.indexOf(".0")!=-1){//0.0的处理
				memo = memo.substring(0, memo.lastIndexOf(".0"));
			}	
			plan_id=memo.indexOf("_")>-1?memo.substring(0,memo.indexOf("_")):memo;	
			
			//判断plan_id是否是数字
			Pattern pattern = Pattern.compile("[0-9]*");  
			if(!pattern.matcher(plan_id).matches()){
				continue;
			} 
			//查看租金、违约金
			if (memo.indexOf("_")>-1) {//罚息时
				//删除租金实收表数据
				sqlstr = " delete from fund_rent_income where id in(";
				sqlstr += " select fri.id from fund_rent_plan frp left join fund_rent_income fri";
				sqlstr += " on fri.proj_id=frp.proj_id and fri.plan_list=frp.rent_list and fri.rent_type='违约金'";
				sqlstr += " where frp.id='"+plan_id+"')";
				System.out.println("========1"+sqlstr);
				//执行更新
				flag=db.executeUpdate(sqlstr);
			} else {//租金时
				//删除租金实收表数据
				sqlstr = " delete from fund_rent_income where id in(";
				sqlstr += " select fri.id from fund_rent_plan frp left join fund_rent_income fri";
				sqlstr += " on fri.proj_id=frp.proj_id and fri.plan_list=frp.rent_list and fri.rent_type='租金'";
				sqlstr += " where frp.id='"+plan_id+"')";
				//修改租金计划表的状态字段 status
				sqlstr += " update fund_rent_plan set plan_status=0,penalty_plan_date=null,penalty=null where id='"+plan_id+"'";
				//执行更新
				System.out.println("========2"+sqlstr);
				flag=db.executeUpdate(sqlstr);
			}
		}
	}
}else if("中国民生银行".equals(hire_bank)){
	List contentList = new ArrayList(0);
	File txtFile = new File(filePath);
	//读取
	BufferedReader br = null;
	String titleStr = "";
	try {
		br=new BufferedReader(new FileReader(txtFile));
		//文件头
		titleStr = br.readLine();
		//文件体一条条内容
		String contentStr = ""; 
		while((contentStr=br.readLine())!=null) {
			contentList.add(contentStr);
		}
	}catch(FileNotFoundException e){
	   e.printStackTrace();
	}finally{//关闭流
	   try {
			br.close();
	   } catch (IOException e) {
			e.printStackTrace();
	   }
	}
	//循环操作
	String contStr = "";
	plan_id="";
	for(int i=0;i<contentList.size();i++){
		plan_id="";
		contStr = contentList.get(i)+"";
		flag = 0;
		if( contStr!=null && !"".equals(contStr) ){
			String[] strSegment = contStr.trim().split("\\|");
			System.out.println(memo+"===habcTest======="+strSegment.length);
			//文件头不读
			if(strSegment.length<10){
				continue;
			}
			String tempMemo=strSegment[7];//标志值
			if(tempMemo.indexOf(":")==-1){
				continue;
			}
			memo = tempMemo.substring(tempMemo.indexOf(":")+1);
			//得到plan_id
			if(memo.indexOf(".0")!=-1){//0.0的处理
				memo = memo.substring(0, memo.lastIndexOf(".0"));
			}
			plan_id=memo.indexOf("_")>-1?memo.substring(0,memo.indexOf("_")):memo;			
			System.out.println("memo==================="+memo+"=="+plan_id);
			//判断plan_id是否是数字
			Pattern pattern = Pattern.compile("[0-9]*");  
			if(!pattern.matcher(plan_id).matches()){
				continue;
			}
			
			//查看是否息还是租金的核销
			if (memo.indexOf("_")>-1) {//罚息时
				//删除租金实收表数据
				sqlstr = " delete from fund_rent_income where id in(";
				sqlstr += " select fri.id from fund_rent_plan frp left join fund_rent_income fri";
				sqlstr += " on fri.proj_id=frp.proj_id and fri.plan_list=frp.rent_list and fri.rent_type='违约金'";
				sqlstr += " where frp.id='"+plan_id+"')";
				//执行更新
				flag=db.executeUpdate(sqlstr);
			} else {//租金时
				//删除租金实收表数据
				sqlstr = " delete from fund_rent_income where id in(";
				sqlstr += " select fri.id from fund_rent_plan frp left join fund_rent_income fri";
				sqlstr += " on fri.proj_id=frp.proj_id and fri.plan_list=frp.rent_list and fri.rent_type='租金'";
				sqlstr += " where frp.id='"+plan_id+"')";
				//修改租金计划表的状态字段 status
				sqlstr += " update fund_rent_plan set plan_status=0,penalty_plan_date=null,penalty=null where id='"+plan_id+"'";
				//执行更新
				flag=db.executeUpdate(sqlstr);
			}
		}
	}
}
	
if(flag>0){
	//更新该申请的状态
	sqlstr="update fund_rent_cx set cx_status=1,modifycator='"+czy+"',modify_date='"+getSystemDate(0)+"' where id="+id;
	System.out.println("租金撤销申请核销通过:"+sqlstr);
	db.executeUpdate(sqlstr);
%>
<script>
		window.close();
		opener.alert("租金撤销完成");
		opener.location.reload();
</script>
<%
}else{
%>
<script>
		window.close();
		opener.alert("租金撤销失败,请检查上传文件内容的格式是否合法");
		opener.location.reload();
</script>
<% } %>