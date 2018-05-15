<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*" %> 
<%@page import="com.tenwa.log.LogWriter"%>
<%@page import="com.tenwa.util.CurrencyUtil"%>
<%@page import="com.tenwa.culc.bean.ConditionBean"%>
<%@page import="com.tenwa.culc.bean.RentPlanBean"%>
<%@page import="com.tenwa.culc.bean.RentCashBean"%>
<%@page import="com.tenwa.culc.util.MathExtend"%>
<%@page import="com.tenwa.culc.util.OperationUtil"%>
<%@page import="com.tenwa.culc.util.ConvertUtil"%>
<%@page import="com.tenwa.culc.service.ConditionService"%>
<%@page import="com.tenwa.culc.service.RentPlanService"%>
<%@page import="com.tenwa.culc.service.RentCashService"%>
<%@page import="com.ReadExcel2003"%>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<jsp:useBean id="fileBean" scope="page" class="com.UploadBean" />
<%@ include file="../../func/common_simple.jsp"%>

<%
//当前登陆人
String czy = (String) session.getAttribute("czyid");
czy = "ANMSS-999";
//基础变量
String datestr=getSystemDate(0); 
int flag = 0;
String errMsg = "";
String sqlstr = "";
String uid = "";

//ConditionBean 交易结构Bean
ConditionBean conditionBean = new ConditionBean();
//List 的租金
List<RentPlanBean> rentPlanList = new ArrayList<RentPlanBean>();

//List 现金流
List<RentCashBean> rentCashList = new ArrayList<RentCashBean>();

//设定附件相对路径
String path = pageContext.getServletContext().getRealPath("/");
String allpath =path + "\\cond_excel\\"+datestr+"\\";
fileBean.setObjectPath( allpath );
//设定上传附件总体大小限制 
fileBean.setSize(8*1024*1024);

//设定上传附件文件类型
fileBean.setSuffix(".xls");

//设定上传用户ID
if ( ( czy != null ) && ( !czy.equals("") ) ) {
   uid=czy.substring(7);
}
fileBean.setUserid(uid);
fileBean.setSourceFile(request);
String [] saSourceFile = fileBean.getSourceFile();
String [] saObjectFile = fileBean.getObjectFileName();
String [] saDescription = fileBean.getDescription();
int iCount = fileBean.getCount();
String sObjectPath = fileBean.getObjectPath();

//表单非文件类型参数 - proj_id\doc_id
String proj_id = fileBean.getFieldValue("proj_id");
String doc_id = fileBean.getFieldValue("doc_id");
//上传文件的名称
String uploadFileName = fileBean.getFieldValue("uploadFileName");

conditionBean.setProj_id(proj_id);
conditionBean.setDoc_id(doc_id);
if(uploadFileName.indexOf("后付")>0){
	conditionBean.setPeriod_type("0");
}else{
	conditionBean.setPeriod_type("1");
}
conditionBean.setSettle_method( OperationUtil.getSettleMethod(uploadFileName) );
LogWriter.logDebug(request, "Excel上传成功，保存路径"+fileBean.getObjectPath());

LogWriter.logDebug(request, "saObjectFile====="+saObjectFile.length+"______"+allpath+saObjectFile[0] );
ReadExcel2003 execlBean = new ReadExcel2003();
//遍历sheet读取excel数据
execlBean.setExecl(allpath+saObjectFile[0]);
//LogWriter.logDebug(request, "saObjectFile====="+allpath+saObjectFile[0]);
//LogWriter.logDebug(request, "第一个sheet有："+execlBean.getObject().length+"行");

if(saObjectFile!=null){
	for(int j=0;j<saObjectFile.length;j++){
	   if(saObjectFile[j]!=null&&!saObjectFile[j].equals("")){
		  execlBean.setExecl(allpath+saObjectFile[j]);
		  //LogWriter.logDebug(request, "第一个sheet有："+execlBean.getFlag());
		  if(execlBean.getFlag()){
				String [][]obj = execlBean.getObj(); //遍历1个sheet
				//LogWriter.logDebug(request, "第一个sheet有："+obj.length+"行");
				
				//----1.定为封转交易结构数据---- 
				/**
				 * 第5行 - 第10行
				 * 第2列 - 第8列
				**/
				//1.1项目金额 - 第5行第3列
				conditionBean.setEquip_amt( obj[4][2] );
				//1.2租期(年) - 第5行第5列
				conditionBean.setLease_term( MathExtend.multiply("12", obj[4][4]) );
				//1.3咨询服务费收入 - 第5行第7列
				conditionBean.setConsulting_fee_in( obj[4][6] );
				//2.1首付款  - 第6行第3列
				conditionBean.setFirst_payment( obj[5][2] );
				//2.2年利率  - 第6行第5列
				conditionBean.setYear_rate( obj[5][4] );
				//2.3利息补贴 - 第6行第7列
				conditionBean.setRate_subsidy( obj[5][6] );
				
				//3.1保证金 - 第7行第3列
				conditionBean.setCaution_money( obj[6][2] );
				//3.2年还租次数 - 第7行第5列
				conditionBean.setIncome_number( obj[6][4] );
				//3.2.1 付租方式 = 租期（月）/年还租次数 - 后台计算
				//3.3手续费收入 - 第7行第7列
				conditionBean.setHandling_charge( obj[6][6] );
				//4.1资产余值 - 第8行第3列
				conditionBean.setAssets_value( obj[7][2] );
				//4.2每期租金 - 第8行第5列 -- 无用字段
				//4.3管理费收入 - 第8行第7列
				conditionBean.setManagement_fee( obj[7][6] );
				
				//5.1考核调整
				conditionBean.setAssess_adjust( obj[8][2] );
				//5.2租前息 - 第9行第5列
				conditionBean.setBefore_interest( obj[8][4] );
				//5.3其他收入 - 第9行第7列
				conditionBean.setOther_income( obj[8][6] );
				//6.1其他支出 - 第10行第3列
				conditionBean.setOther_expenditure( obj[9][2] );
				//6.2本金公比、租金公比、本金公差、租金公差
				conditionBean.setRatio_param( obj[9][4] );
				//6.3残值收入 - 第10行第7列
				conditionBean.setNominalprice( obj[9][6] );
				
				//T.1起租日 - 第12行第1列
				conditionBean.setStart_date( obj[11][0] );
				//T.2收益率plan_irr - 第8行第8列
				conditionBean.setPlan_irr( obj[7][7] );
				//T.3净融资额 - 第12行第7列
				conditionBean.setActual_fund( ConvertUtil.parseInverseNumber( obj[11][6] ) );
				
				//--其他计算字段---
				//O.2.1 付租方式 = 租期（月）/年还租次数 - 后台计算
				conditionBean.setIncome_number_year( MathExtend.divide( conditionBean.getLease_term(), conditionBean.getIncome_number() ) );
				//O.2.2 首付款比例 = 首付款/设备金额
				conditionBean.setFirst_payment_ratio( MathExtend.divide( conditionBean.getFirst_payment(), conditionBean.getEquip_amt(), 6 ) );
				//O.2.3 保证金比例 = 保证金/设备金额
				conditionBean.setCaution_money_ratio( MathExtend.divide( conditionBean.getCaution_money(),conditionBean.getEquip_amt(),6 ) );
				//0.2.4 手续费比例 = 手续费/设备金额
				conditionBean.setHandling_charge_ratio( MathExtend.divide(conditionBean.getHandling_charge(),conditionBean.getEquip_amt(),6) );
				//0.2.5 厂商返利比率
				conditionBean.setReturn_ratio(MathExtend.divide(conditionBean.getReturn_amt(),conditionBean.getEquip_amt(),6));
				//0.2.6 净融资额比例
				conditionBean.setActual_fund_ratio(MathExtend.divide(conditionBean.getActual_fund(), conditionBean.getEquip_amt(),6));
				
				//-========--2.定为封装租金计划数据-==============--
				RentPlanBean rentPlanBean = null;
				RentCashBean rentCashBean = null;
				//第12行的现金流
				rentCashBean = new RentCashBean();
				rentCashBean.setProj_id(proj_id);
				rentCashBean.setDoc_id(doc_id);
				
				/**
				 * 从13行第2列 至  第（13+年还租次数*年份）6列
				**/
				
				for(int row=13;row<ConvertUtil.parseInt(conditionBean.getLease_term(), 12);row++){//遍历多行
					String []objrow = obj[row]; 
					rentPlanBean = new RentPlanBean();
					//--1.封转租金计划数据
					// 属性赋值
					rentPlanBean.setProj_id(proj_id);
					rentPlanBean.setDoc_id(doc_id);
					rentPlanBean.setRent_list( objrow[1] );
					rentPlanBean.setPlan_date( objrow[0] );
					rentPlanBean.setPlan_status("未回笼");
					rentPlanBean.setCurr_rent( objrow[2] );
					rentPlanBean.setRent(objrow[2]);
					rentPlanBean.setCorpus(objrow[4]);
					rentPlanBean.setYear_rate(conditionBean.getYear_rate());
					rentPlanBean.setInterest(objrow[3]);
					rentPlanBean.setCorpus_overage(objrow[5]);
					rentPlanBean.setCreate_date(getSystemDate(0));
					rentPlanBean.setCreator(czy);
					rentPlanBean.setCreate_date(datestr);
					// 添加到list
					rentPlanList.add(rentPlanBean);
					
					
					//--2.定为封转现金流数据---
					rentCashBean = new RentCashBean();
					// 属性赋值
					rentCashBean.setProj_id(proj_id);
					rentCashBean.setDoc_id(doc_id);
					rentCashBean.setPlan_date( objrow[0] );
					rentCashBean.setFollow_in( objrow[2] );
					rentCashBean.setFollow_in_detail("租金："+objrow[2]);
					rentCashBean.setFollow_out("0");
					rentCashBean.setFollow_out_detail("");
					rentCashBean.setNet_follow(objrow[6]);
					rentCashBean.setCreator(czy);
					rentCashBean.setCreate_date(datestr);
					//添加到List
					rentCashList.add(rentCashBean);
				} 
				//执行保存
				//1.保存conditionBean
				ConditionService.saveUploadConditionBean(conditionBean);
				//2.保存租金计划List
				RentPlanService.saveUploadRentPlanList(rentPlanList, proj_id, doc_id);
				//3.保存现金流List
				RentCashService.saveUploadRentCashList(rentCashList, proj_id, doc_id);
				LogWriter.logDebug(request, "执行上传租金测算Excel成功");
				
				//日志操作
				String sqlLog = LogWriter.getSqlIntoDB(request, "租金测算", "数据导入", "用户导入租金测算类型【"+uploadFileName+"】测算", sqlstr);
				db.executeUpdate(sqlLog);
			}else{
				errMsg +=saObjectFile[j]+execlBean.getErrMsg()+";";
				execlBean.deleteFile(allpath+saObjectFile[j]);
			}
		}
	}//for循环结束
   }

db.close();

if(flag>1){
%>
<script type="text/javascript">
	window.close();
	opener.alert("文件上传成功，可以修改表单部分字段！");
	opener.location.reload();
</script>
<%
}else{
%>
<script type="text/javascript">
	window.close();
	opener.alert("文件上传失败，请查看格式是否符合！");
	opener.location.reload();
</script>
<%
}%>