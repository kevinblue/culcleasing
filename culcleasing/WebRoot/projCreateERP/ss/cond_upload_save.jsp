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
//��ǰ��½��
String czy = (String) session.getAttribute("czyid");
czy = "ANMSS-999";
//��������
String datestr=getSystemDate(0); 
int flag = 0;
String errMsg = "";
String sqlstr = "";
String uid = "";

//ConditionBean ���׽ṹBean
ConditionBean conditionBean = new ConditionBean();
//List �����
List<RentPlanBean> rentPlanList = new ArrayList<RentPlanBean>();

//List �ֽ���
List<RentCashBean> rentCashList = new ArrayList<RentCashBean>();

//�趨�������·��
String path = pageContext.getServletContext().getRealPath("/");
String allpath =path + "\\cond_excel\\"+datestr+"\\";
fileBean.setObjectPath( allpath );
//�趨�ϴ����������С���� 
fileBean.setSize(8*1024*1024);

//�趨�ϴ������ļ�����
fileBean.setSuffix(".xls");

//�趨�ϴ��û�ID
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

//�������ļ����Ͳ��� - proj_id\doc_id
String proj_id = fileBean.getFieldValue("proj_id");
String doc_id = fileBean.getFieldValue("doc_id");
//�ϴ��ļ�������
String uploadFileName = fileBean.getFieldValue("uploadFileName");

conditionBean.setProj_id(proj_id);
conditionBean.setDoc_id(doc_id);
if(uploadFileName.indexOf("��")>0){
	conditionBean.setPeriod_type("0");
}else{
	conditionBean.setPeriod_type("1");
}
conditionBean.setSettle_method( OperationUtil.getSettleMethod(uploadFileName) );
LogWriter.logDebug(request, "Excel�ϴ��ɹ�������·��"+fileBean.getObjectPath());

LogWriter.logDebug(request, "saObjectFile====="+saObjectFile.length+"______"+allpath+saObjectFile[0] );
ReadExcel2003 execlBean = new ReadExcel2003();
//����sheet��ȡexcel����
execlBean.setExecl(allpath+saObjectFile[0]);
//LogWriter.logDebug(request, "saObjectFile====="+allpath+saObjectFile[0]);
//LogWriter.logDebug(request, "��һ��sheet�У�"+execlBean.getObject().length+"��");

if(saObjectFile!=null){
	for(int j=0;j<saObjectFile.length;j++){
	   if(saObjectFile[j]!=null&&!saObjectFile[j].equals("")){
		  execlBean.setExecl(allpath+saObjectFile[j]);
		  //LogWriter.logDebug(request, "��һ��sheet�У�"+execlBean.getFlag());
		  if(execlBean.getFlag()){
				String [][]obj = execlBean.getObj(); //����1��sheet
				//LogWriter.logDebug(request, "��һ��sheet�У�"+obj.length+"��");
				
				//----1.��Ϊ��ת���׽ṹ����---- 
				/**
				 * ��5�� - ��10��
				 * ��2�� - ��8��
				**/
				//1.1��Ŀ��� - ��5�е�3��
				conditionBean.setEquip_amt( obj[4][2] );
				//1.2����(��) - ��5�е�5��
				conditionBean.setLease_term( MathExtend.multiply("12", obj[4][4]) );
				//1.3��ѯ��������� - ��5�е�7��
				conditionBean.setConsulting_fee_in( obj[4][6] );
				//2.1�׸���  - ��6�е�3��
				conditionBean.setFirst_payment( obj[5][2] );
				//2.2������  - ��6�е�5��
				conditionBean.setYear_rate( obj[5][4] );
				//2.3��Ϣ���� - ��6�е�7��
				conditionBean.setRate_subsidy( obj[5][6] );
				
				//3.1��֤�� - ��7�е�3��
				conditionBean.setCaution_money( obj[6][2] );
				//3.2�껹����� - ��7�е�5��
				conditionBean.setIncome_number( obj[6][4] );
				//3.2.1 ���ⷽʽ = ���ڣ��£�/�껹����� - ��̨����
				//3.3���������� - ��7�е�7��
				conditionBean.setHandling_charge( obj[6][6] );
				//4.1�ʲ���ֵ - ��8�е�3��
				conditionBean.setAssets_value( obj[7][2] );
				//4.2ÿ����� - ��8�е�5�� -- �����ֶ�
				//4.3���������� - ��8�е�7��
				conditionBean.setManagement_fee( obj[7][6] );
				
				//5.1���˵���
				conditionBean.setAssess_adjust( obj[8][2] );
				//5.2��ǰϢ - ��9�е�5��
				conditionBean.setBefore_interest( obj[8][4] );
				//5.3�������� - ��9�е�7��
				conditionBean.setOther_income( obj[8][6] );
				//6.1����֧�� - ��10�е�3��
				conditionBean.setOther_expenditure( obj[9][2] );
				//6.2���𹫱ȡ���𹫱ȡ����𹫲��𹫲�
				conditionBean.setRatio_param( obj[9][4] );
				//6.3��ֵ���� - ��10�е�7��
				conditionBean.setNominalprice( obj[9][6] );
				
				//T.1������ - ��12�е�1��
				conditionBean.setStart_date( obj[11][0] );
				//T.2������plan_irr - ��8�е�8��
				conditionBean.setPlan_irr( obj[7][7] );
				//T.3�����ʶ� - ��12�е�7��
				conditionBean.setActual_fund( ConvertUtil.parseInverseNumber( obj[11][6] ) );
				
				//--���������ֶ�---
				//O.2.1 ���ⷽʽ = ���ڣ��£�/�껹����� - ��̨����
				conditionBean.setIncome_number_year( MathExtend.divide( conditionBean.getLease_term(), conditionBean.getIncome_number() ) );
				//O.2.2 �׸������ = �׸���/�豸���
				conditionBean.setFirst_payment_ratio( MathExtend.divide( conditionBean.getFirst_payment(), conditionBean.getEquip_amt(), 6 ) );
				//O.2.3 ��֤����� = ��֤��/�豸���
				conditionBean.setCaution_money_ratio( MathExtend.divide( conditionBean.getCaution_money(),conditionBean.getEquip_amt(),6 ) );
				//0.2.4 �����ѱ��� = ������/�豸���
				conditionBean.setHandling_charge_ratio( MathExtend.divide(conditionBean.getHandling_charge(),conditionBean.getEquip_amt(),6) );
				//0.2.5 ���̷�������
				conditionBean.setReturn_ratio(MathExtend.divide(conditionBean.getReturn_amt(),conditionBean.getEquip_amt(),6));
				//0.2.6 �����ʶ����
				conditionBean.setActual_fund_ratio(MathExtend.divide(conditionBean.getActual_fund(), conditionBean.getEquip_amt(),6));
				
				//-========--2.��Ϊ��װ���ƻ�����-==============--
				RentPlanBean rentPlanBean = null;
				RentCashBean rentCashBean = null;
				//��12�е��ֽ���
				rentCashBean = new RentCashBean();
				rentCashBean.setProj_id(proj_id);
				rentCashBean.setDoc_id(doc_id);
				
				/**
				 * ��13�е�2�� ��  �ڣ�13+�껹�����*��ݣ�6��
				**/
				
				for(int row=13;row<ConvertUtil.parseInt(conditionBean.getLease_term(), 12);row++){//��������
					String []objrow = obj[row]; 
					rentPlanBean = new RentPlanBean();
					//--1.��ת���ƻ�����
					// ���Ը�ֵ
					rentPlanBean.setProj_id(proj_id);
					rentPlanBean.setDoc_id(doc_id);
					rentPlanBean.setRent_list( objrow[1] );
					rentPlanBean.setPlan_date( objrow[0] );
					rentPlanBean.setPlan_status("δ����");
					rentPlanBean.setCurr_rent( objrow[2] );
					rentPlanBean.setRent(objrow[2]);
					rentPlanBean.setCorpus(objrow[4]);
					rentPlanBean.setYear_rate(conditionBean.getYear_rate());
					rentPlanBean.setInterest(objrow[3]);
					rentPlanBean.setCorpus_overage(objrow[5]);
					rentPlanBean.setCreate_date(getSystemDate(0));
					rentPlanBean.setCreator(czy);
					rentPlanBean.setCreate_date(datestr);
					// ���ӵ�list
					rentPlanList.add(rentPlanBean);
					
					
					//--2.��Ϊ��ת�ֽ�������---
					rentCashBean = new RentCashBean();
					// ���Ը�ֵ
					rentCashBean.setProj_id(proj_id);
					rentCashBean.setDoc_id(doc_id);
					rentCashBean.setPlan_date( objrow[0] );
					rentCashBean.setFollow_in( objrow[2] );
					rentCashBean.setFollow_in_detail("���"+objrow[2]);
					rentCashBean.setFollow_out("0");
					rentCashBean.setFollow_out_detail("");
					rentCashBean.setNet_follow(objrow[6]);
					rentCashBean.setCreator(czy);
					rentCashBean.setCreate_date(datestr);
					//���ӵ�List
					rentCashList.add(rentCashBean);
				} 
				//ִ�б���
				//1.����conditionBean
				ConditionService.saveUploadConditionBean(conditionBean);
				//2.�������ƻ�List
				RentPlanService.saveUploadRentPlanList(rentPlanList, proj_id, doc_id);
				//3.�����ֽ���List
				RentCashService.saveUploadRentCashList(rentCashList, proj_id, doc_id);
				LogWriter.logDebug(request, "ִ���ϴ�������Excel�ɹ�");
				
				//��־����
				String sqlLog = LogWriter.getSqlIntoDB(request, "������", "���ݵ���", "�û��������������͡�"+uploadFileName+"������", sqlstr);
				db.executeUpdate(sqlLog);
			}else{
				errMsg +=saObjectFile[j]+execlBean.getErrMsg()+";";
				execlBean.deleteFile(allpath+saObjectFile[j]);
			}
		}
	}//forѭ������
   }

db.close();

if(flag>1){
%>
<script type="text/javascript">
	window.close();
	opener.alert("�ļ��ϴ��ɹ��������޸ı��������ֶΣ�");
	opener.location.reload();
</script>
<%
}else{
%>
<script type="text/javascript">
	window.close();
	opener.alert("�ļ��ϴ�ʧ�ܣ���鿴��ʽ�Ƿ���ϣ�");
	opener.location.reload();
</script>
<%
}%>