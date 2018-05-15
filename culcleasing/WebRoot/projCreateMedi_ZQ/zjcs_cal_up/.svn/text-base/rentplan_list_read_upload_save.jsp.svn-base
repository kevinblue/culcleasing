<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@page import="com.tenwa.log.LogWriter"%>
<%@page import="com.tenwa.culc.bean.RentPlanBean"%>
<%@page import="com.tenwa.culc.util.MathExtend"%>
<%@page import="com.tenwa.culc.util.ConvertUtil"%>
<%@page import="com.tenwa.culc.service.RentPlanService"%>
<%@page import="java.sql.ResultSet"%>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<jsp:useBean id="fileBean" scope="page" class="com.UploadBean" />
<jsp:useBean id="execlBean" scope="page" class="com.ReadExcel2003" />
<%@ include file="../../func/common_simple.jsp"%>

<%
//当前登陆人
String czy = (String) session.getAttribute("czyid");
//基础变量
String datestr=getSystemDate(0); 
int flag = 0;
String errMsg = "";
String sqlstr = "";
String uid = "";

//List 的租金
List<RentPlanBean> rentPlanList = new ArrayList<RentPlanBean>();

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
String planBankName = "";
String planBankNo = "";

//获取计划收款银行、账号
sqlstr = "SELECT plan_bank_name,plan_bank_no FROM proj_condition_medi_temp where proj_id='"+proj_id+"' and doc_id='"+doc_id+"' ";
ResultSet rs = null;
rs = db.executeQuery(sqlstr);
if(rs.next()){
	planBankName = rs.getString("plan_bank_name");
	planBankNo = rs.getString("plan_bank_no");
}
rs.close();

LogWriter.logDebug(request, "Excel上传成功，保存路径"+fileBean.getObjectPath());

if(saObjectFile!=null){
	for(int j=0;j<saObjectFile.length;j++){
	   if(saObjectFile[j]!=null&&!saObjectFile[j].equals("")){
		  execlBean.setExcel(allpath+saObjectFile[j]);
		  
		  if(execlBean.isFlag()){
				String [][]obj = execlBean.getObj(); //遍历1个sheet
				LogWriter.logDebug(request, "第一个sheet有："+obj.length+"行");
				
				//-========--2.定为封装租金计划数据-==============--
				RentPlanBean rentPlanBean = null;
				/**
				 * 从13行第2列 至  第（13+年还租次数*年份）6列
				**/
				//System.out.println("----"+(ConvertUtil.parseInt(MathExtend.getLeaseTerm(obj[6][4], obj[4][4]),12)+12) );
				for(int row=12;row<ConvertUtil.parseInt(MathExtend.getLeaseTerm(obj[6][4], obj[4][4]),12)+12;row++){//遍历多行
					String []objrow = obj[row]; 
					rentPlanBean = new RentPlanBean();
					//--1.封转租金计划数据
					System.out.println("row="+row+"日期"+objrow[0]+"\t期次"+objrow[1]);
					// 属性赋值
					rentPlanBean.setProj_id(proj_id);
					rentPlanBean.setDoc_id(doc_id);
					rentPlanBean.setMeasure_date(datestr);
					
					rentPlanBean.setRent_list( objrow[1] );
					rentPlanBean.setPlan_date( objrow[0] );
					rentPlanBean.setPlan_status("未回笼");
					
					rentPlanBean.setCurr_rent( objrow[2] );
					rentPlanBean.setRent(objrow[2]);
					rentPlanBean.setCurr_corpus(objrow[4]);
					rentPlanBean.setCorpus(objrow[4]);
					rentPlanBean.setYear_rate(obj[5][4]);
					rentPlanBean.setCurr_interest(objrow[3]);
					rentPlanBean.setInterest(objrow[3]);
					
					rentPlanBean.setPlan_bank_name(planBankName);
					rentPlanBean.setPlan_bank_no(planBankNo);
					rentPlanBean.setCorpus_overage(objrow[5]);
					rentPlanBean.setCreator(czy);
					rentPlanBean.setCreate_date(datestr);
					
					// 添加到list
					rentPlanList.add(rentPlanBean);
				} 
				//执行保存
				//2.保存租金计划List
				LogWriter.logDebug("开始保存租金计划"+rentPlanList.size());
			}else{
				errMsg +=saObjectFile[j]+";";
			}
		}
	}//for循环结束
}

//执行插入医疗管理租金计划
//1.0删除
sqlstr = "Delete from fund_rent_plan_proj_bd_medi_temp where proj_id='"+proj_id+"' and doc_id='"+doc_id+"'";
db.executeUpdate(sqlstr);
//2.0插入

String sqlStr = "";
for (int i = 0; i < rentPlanList.size(); i++) {
	RentPlanBean rentPlanBean = rentPlanList.get(i);
	sqlStr = "insert into fund_rent_plan_proj_bd_medi_temp(proj_id,doc_id,rent_list,plan_date,plan_status,";
	sqlStr += " curr_rent,rent,corpus,year_rate,interest,corpus_overage,plan_bank_name,plan_bank_no,create_date)";
	sqlStr += "values(";
	sqlStr += "'" + rentPlanBean.getProj_id() + "','"
			+ rentPlanBean.getDoc_id() + "','"
			+ rentPlanBean.getRent_list() + "','"
			+ rentPlanBean.getPlan_date() + "','"
			+ rentPlanBean.getPlan_status() + "','"
			+ rentPlanBean.getCurr_rent() + "','"
			+ rentPlanBean.getRent() + "','" + rentPlanBean.getCorpus()
			+ "','" + rentPlanBean.getYear_rate() + "','"
			+ rentPlanBean.getInterest() + "','"
			+ rentPlanBean.getCorpus_overage() + "','"
			+ rentPlanBean.getPlan_bank_name() + "','"
			+ rentPlanBean.getPlan_bank_no() + "','"
			+ rentPlanBean.getCreate_date() + "'";
	sqlStr += ")";
	flag += db.executeUpdate(sqlStr);
}

db.close();

if(flag>1){
%>
<script type="text/javascript">
	window.close();
	opener.alert("租金计划上传成功！");
	opener.parent.location.reload();
</script>
<%
}else{
%>
<script type="text/javascript">
	window.close();
	opener.alert("租金计划上传失败，请查看格式是否符合！");
	opener.parent.location.reload();
</script>
<%
}%>