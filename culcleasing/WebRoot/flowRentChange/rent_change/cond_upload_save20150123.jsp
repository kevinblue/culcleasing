<%@ page contentType="text/html; charset=gbk" language="java"
	errorPage="/public/pageError.jsp"%>
<%@page import="com.tenwa.log.LogWriter"%>
<%@page import="com.tenwa.culc.bean.RentPlanBean"%>
<%@page import="com.tenwa.culc.util.MathExtend"%>
<%@page import="com.tenwa.culc.util.ConvertUtil"%>
<%@page import="com.tenwa.culc.service.RentPlanService"%>
<%@page import="java.sql.ResultSet"%>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" />
<jsp:useBean id="db1" scope="page" class="dbconn.Conn" />
<jsp:useBean id="fileBean" scope="page" class="com.UploadBean" />
<jsp:useBean id="execlBean" scope="page" class="com.ReadExcel2003" />
<%@ include file="../../func/common_simple.jsp"%>

<%
	//当前登陆人
	String czy = (String) session.getAttribute("czyid");
	//基础变量
	String datestr = getSystemDate(0);
	int flag = 0;
	String errMsg = "";
	String sqlstr = "";
	String uid = "";

	//List 的租金
	List<RentPlanBean> rentPlanList = new ArrayList<RentPlanBean>();

	//设定附件相对路径
	String path = pageContext.getServletContext().getRealPath("/");
	String allpath = path + "\\cond_excel\\" + datestr + "\\";
	fileBean.setObjectPath(allpath);
	//设定上传附件总体大小限制 
	fileBean.setSize(8 * 1024 * 1024);

	//设定上传附件文件类型
	fileBean.setSuffix(".xls");

	//设定上传用户ID
	if ((czy != null) && (!czy.equals(""))) {
		uid = czy.substring(7);
	}
	fileBean.setUserid(uid);
	fileBean.setSourceFile(request);
	String[] saSourceFile = fileBean.getSourceFile();
	String[] saObjectFile = fileBean.getObjectFileName();
	String[] saDescription = fileBean.getDescription();
	int iCount = fileBean.getCount();
	String sObjectPath = fileBean.getObjectPath();

	//表单非文件类型参数 - proj_id\doc_id
	String contract_id = fileBean.getFieldValue("contract_id");
	String begin_id = fileBean.getFieldValue("begin_id");
	String doc_id = fileBean.getFieldValue("doc_id");
	String val = fileBean.getFieldValue("isYHTX");
	String before = fileBean.getFieldValue("beforeRate");
	String after = fileBean.getFieldValue("afterRate");
	int id = 0;
	String startDateS = "";
	ResultSet rs1 = null;
	if (val.equals("是")) {
		String sqlstr2 = "select id,start_date from fund_standard_interest where id in(select max(id) from fund_standard_interest)";
		rs1 = db1.executeQuery(sqlstr2);
		
		if (rs1.next()) {
			id = rs1.getInt("id");
			startDateS = rs1.getString("start_date");
		}
		rs1.close();
		String sqlstr1 = "";
		sqlstr1 = "Delete from fund_adjust_interest_contract_bgz where doc_id='"+doc_id+"'";
		db.executeUpdate(sqlstr1);


		sqlstr1 = "select case when min(rent_list)=( Select min(rent_list) from fund_rent_plan where begin_id='"+begin_id+"' and ";
		sqlstr1 += " plan_date>='"+startDateS+"') then min(rent_list) else min(rent_list)-1 end as ";
		sqlstr1 += " rent_list_start from fund_rent_plan frp  where begin_id='"+begin_id+"' and  plan_date>='"+startDateS+"'";
		sqlstr1 += " and plan_status<>'已回笼'";
		int rent_list_start = 0;
		rs1 = db1.executeQuery(sqlstr1);
		if (rs1.next()) {
			rent_list_start = rs1.getInt("rent_list_start");
		}
		rs1.close();

		 sqlstr1 = "insert into fund_adjust_interest_contract_bgz (contract_id,doc_id,begin_id,adjust_id,before_rate,after_rate,creator,create_date,modificator,modify_date,rent_list_start) values ('"
				+ contract_id + "','"+doc_id+"','" + begin_id + "'," + id + ",'"+before+"','"+after+"','"+czy+"','"+datestr+"','"+czy+"','"+datestr+"','"+rent_list_start+"')";
				db.executeUpdate(sqlstr1);
	}else{
		String sqlstr4 = "Delete from fund_adjust_interest_contract_bgz where doc_id='"+doc_id+"'";
		db.executeUpdate(sqlstr4);
	}

	LogWriter.logDebug(request, "Excel上传成功，保存路径"
			+ fileBean.getObjectPath());

	if (saObjectFile != null) {
		for (int j = 0; j < saObjectFile.length; j++) {
			if (saObjectFile[j] != null && !saObjectFile[j].equals("")) {
				execlBean.setExcel(allpath + saObjectFile[j]);

				if (execlBean.isFlag()) {
					String[][] obj = execlBean.getObj(); //遍历1个sheet
					LogWriter.logDebug(request, "第一个sheet有："
							+ obj.length + "行");

					/**
					 * 从13行第2列 至  第（13+年还租次数*年份）6列
					 **/
					RentPlanBean rentPlanBean = null;
					for (int row = 12; row < ConvertUtil.parseInt(
							MathExtend.getLeaseTerm(obj[6][4],
									obj[4][4]), 12) + 12; row++) {//遍历多行
						String[] objrow = obj[row];
						rentPlanBean = new RentPlanBean();
						//--1.封转租金计划数据
						System.out.println("row=" + row + "日期"
								+ objrow[0] + "\t期次" + objrow[1]);
						// 属性赋值
						rentPlanBean.setContract_id(contract_id);
						rentPlanBean.setBegin_id(begin_id);
						rentPlanBean.setDoc_id(doc_id);
						rentPlanBean.setMeasure_date(datestr);

						rentPlanBean.setRent_list(objrow[1]);
						rentPlanBean.setPlan_date(objrow[0]);
						rentPlanBean.setPlan_status("未回笼");

						rentPlanBean.setCurr_rent(objrow[2]);
						rentPlanBean.setRent(objrow[2]);
						rentPlanBean.setCurr_corpus(objrow[4]);
						rentPlanBean.setCorpus(objrow[4]);
						rentPlanBean.setYear_rate(obj[5][4]);
						rentPlanBean.setCurr_interest(objrow[3]);
						rentPlanBean.setInterest(objrow[3]);

						rentPlanBean.setPlan_bank_name("");
						rentPlanBean.setPlan_bank_no("");
						rentPlanBean.setCorpus_overage(objrow[5]);
						rentPlanBean.setCreator(czy);
						rentPlanBean.setCreate_date(datestr);

						// 添加到list
						rentPlanList.add(rentPlanBean);
					}
					//2.保存租金计划List
					LogWriter
							.logDebug("开始保存租金计划" + rentPlanList.size());
					flag += RentPlanService
							.saveUploadRentChangePlanBeginList(
									rentPlanList, contract_id,
									begin_id, doc_id);

					LogWriter.logDebug(request, "执行上传租金测算Excel成功");
				} else {
					errMsg += saObjectFile[j] + ";";
				}
			}
		}//for循环结束
	}

	db.close();

	if (flag > 1) {
	if(val.equals("否")){
%>
<script type="text/javascript">
	window.open("http://culc.eleasing.com.cn/eleasing/PMAgent.nsf/CreateRentChangeNotice22?openagent&fileno=11210&contractid=<%=contract_id%>&docid=<%=doc_id%>&begin_id=<%=begin_id%>","","status=no,scrollbars=no,location=no,menubar=yes,resizable=yes");

	//window.close();
	opener.alert("租金文件上传成功！");
	opener.location.reload();

	if(window.opener){
		window.opener=null;window.open('','_self');
		window.close();} 
	 else{history.back()}
</script>
<%}else if(val.equals("是")){
		%>
		<script type="text/javascript">
	window.open("http://culc.eleasing.com.cn/eleasing/PMAgent.nsf/CreateRentChangeNoticeYH?openagent&docId=<%=doc_id%>&contractId=<%=contract_id%>&adjustId=<%=id%>&beginId=<%=begin_id%>","","status=no,scrollbars=no,location=no,menubar=yes,resizable=yes");

	//window.close();
	opener.alert("租金文件上传成功！");
	opener.location.reload();

	if(window.opener){
		window.opener=null;window.open('','_self');
		window.close();} 
	 else{history.back()}
</script>
		<% 
}
	} else {
%>
<script type="text/javascript">
	//window.close();
	opener.alert("租金文件上传失败！");
	opener.location.reload();

	if(window.opener){
		window.opener=null;window.open('','_self');
		window.close();} 
	 else{history.back()}
//	opener.parent.location.reload();
</script>
<%
	}
%>
<%if(null != db1){db1.close();}%>