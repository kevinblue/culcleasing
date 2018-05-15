<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@page import="com.tenwa.log.LogWriter"%>
<%@page import="com.tenwa.culc.bean.RentPlanBean"%>
<%@page import="com.tenwa.culc.util.MathExtend"%>
<%@page import="com.tenwa.culc.util.OperationUtil"%>
<%@page import="com.tenwa.culc.util.ConvertUtil"%>
<%@page import="com.tenwa.culc.service.RentPlanService"%>
<%@page import="com.ReadExcel2003"%>
<%@page import="com.tenwa.culc.bean.BeginInfoBean"%>
<%@page import="com.tenwa.culc.util.CommonTool"%>
<%@page import="com.tenwa.culc.service.BeginService"%>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<jsp:useBean id="fileBean" scope="page" class="com.UploadBean" />
<jsp:useBean id="execlBean" scope="page" class="com.ReadExcel2003" />
<%@ include file="../../func/common_simple.jsp"%>

<%
//��ǰ��½��
String czy = (String) session.getAttribute("czyid");
//��������
String datestr=getSystemDate(0); 
int flag = 0;
String errMsg = "";
String sqlstr = "";
String uid = "";

//ConditionBean ���׽ṹBean
BeginInfoBean beginInfoBean = new BeginInfoBean();
//List �����
List<RentPlanBean> rentPlanList = new ArrayList<RentPlanBean>();

//List �ֽ���
//List<RentCashBean> rentCashList = new ArrayList<RentCashBean>();

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

//�����ļ����Ͳ��� - proj_id\doc_id
String contract_id = fileBean.getFieldValue("contract_id");
String begin_id = fileBean.getFieldValue("begin_id");
String doc_id = fileBean.getFieldValue("doc_id");
String flowSysDate = fileBean.getFieldValue("flowSysDate");
//�ϴ��ļ�������
String uploadFileName = fileBean.getFieldValue("uploadFileName");
System.out.println("aaaaaaaaaaa"+uploadFileName);
beginInfoBean.setContract_id(contract_id);
beginInfoBean.setBegin_id(begin_id);
beginInfoBean.setDoc_id(doc_id);

if(uploadFileName.indexOf("��")>0){
	beginInfoBean.setPeriod_type("0");
}else{
	beginInfoBean.setPeriod_type("1");
}

if(uploadFileName.contains("��Ϣ��")){
	uploadFileName="�ȶ����󸶣���Ϣ����";
}
else if(uploadFileName.length()==7){
	uploadFileName=uploadFileName.substring(0,5);
	System.out.println("����======="+uploadFileName);
}
else if(uploadFileName.length()==6){
	uploadFileName=uploadFileName.substring(0,4);
}
else if(uploadFileName.length()==5)
{	
	uploadFileName=uploadFileName.substring(0,3);
}
beginInfoBean.setSettle_method( OperationUtil.getSettleMethod(uploadFileName) );
LogWriter.logDebug(request, "Excel�ϴ��ɹ�������·��"+fileBean.getObjectPath());

if(saObjectFile!=null){
	for(int j=0;j<saObjectFile.length;j++){
	   if(saObjectFile[j]!=null&&!saObjectFile[j].equals("")){
		  execlBean.setExcel(allpath+saObjectFile[j]);
		  
		  if(execlBean.isFlag()){
				String [][]obj = execlBean.getObj(); //����1��sheet
				LogWriter.logDebug(request, "��һ��sheet�У�"+obj.length+"��");
				
				//----1.��Ϊ��ת���׽ṹ����---- 
				/**
				 * ��5�� - ��10��
				 * ��2�� - ��8��
				**/
				//1.1��Ŀ��� - ��5�е�3��
				beginInfoBean.setEquip_amt( obj[4][2] );
				//1.2����(��) - ��5�е�5��
				beginInfoBean.setLease_term( MathExtend.getLeaseTerm("12",obj[4][4]) );
				//1.3��ѯ��������� - ��5�е�7��
				//beginInfoBean.setConsulting_fee_in( obj[4][6] );
				//2.1�׸���  - ��6�е�3��
				//beginInfoBean.setFirst_payment( obj[5][2] );
				//2.2������  - ��6�е�5��
				beginInfoBean.setYear_rate( obj[5][4] );
				//2.3��Ϣ���� - ��6�е�7��
				//beginInfoBean.setRate_subsidy( obj[5][6] );
				
				//3.1��֤�� - ��7�е�3��
				//beginInfoBean.setCaution_money( obj[6][2] );
				//3.2�껹����� - ��7�е�5��
				beginInfoBean.setIncome_number( MathExtend.getLeaseTerm(obj[6][4], obj[4][4]));
				//3.2.1 ���ⷽʽ = ���ڣ��£�/�껹����� - ��̨����
				//3.3���������� - ��7�е�7��
				//beginInfoBean.setHandling_charge( obj[6][6] );
				//4.1�ʲ���ֵ - ��8�е�3��
				beginInfoBean.setAssets_value( obj[7][2] );
				//4.2ÿ����� - ��8�е�5�� -- �����ֶ�
				//4.3��������� - ��8�е�7��
				//beginInfoBean.setManagement_fee( obj[7][6] );
				
				//5.1���˵���
				//beginInfoBean.setAssess_adjust( obj[8][2] );
				//5.2��ǰϢ - ��9�е�5��
				//beginInfoBean.setBefore_interest( obj[8][4] );
				//5.3�������� - ��9�е�7��
				//beginInfoBean.setOther_income( obj[8][6] );
				//6.1����֧�� - ��10�е�3��
				//beginInfoBean.setOther_expenditure( obj[9][2] );
				//6.2���𹫱ȡ���𹫱ȡ����𹫲��𹫲�
				beginInfoBean.setRatio_param( obj[9][4] );
				//6.3��ֵ���� - ��10�е�7��
				//beginInfoBean.setNominalprice( obj[9][6] );
				
				//T.1������ - ��12�е�1��
				beginInfoBean.setRent_start_date( obj[11][0] );
				beginInfoBean.setIncome_day(CommonTool.datePart(beginInfoBean.getRent_start_date(), 3));
				beginInfoBean.setStart_date( obj[11][0] );
				//T.2������plan_irr - ��8�е�8��
				obj[7][7]  = "7.65";
				beginInfoBean.setPlan_irr( obj[7][7] );
				//--ʵ��Irr��ƻ�plan_irr����һ��
				beginInfoBean.setFact_irr(beginInfoBean.getPlan_irr());
				//T.3�����ʶ� - ��12�е�7��
				beginInfoBean.setActual_fund( ConvertUtil.parseInverseNumber( obj[11][6] ) );
				
				//--���������ֶ�---
				//O.2.1 ���ⷽʽ = ���ڣ��£�/�껹����� - ��̨����
				String iny = MathExtend.divide( "12", obj[6][4], 0 );
				beginInfoBean.setIncome_number_year(iny);
				//beginInfoBean.setIncome_number_year( iny.substring(0, iny.indexOf(".")) );
				//O.2.2 �׸������ = �׸���/�豸���
				//beginInfoBean.setFirst_payment_ratio( MathExtend.divide( beginInfoBean.getFirst_payment(), beginInfoBean.getEquip_amt(), 6 ) );
				//O.2.3 ��֤����� = ��֤��/�豸���
				//beginInfoBean.setCaution_money_ratio( MathExtend.divide( beginInfoBean.getCaution_money(),beginInfoBean.getEquip_amt(),6 ) );
				//0.2.4 �����ѱ��� = ������/�豸���
				//beginInfoBean.setHandling_charge_ratio( MathExtend.divide(beginInfoBean.getHandling_charge(),beginInfoBean.getEquip_amt(),6) );
				//0.2.5 ���̷�������
				//beginInfoBean.setReturn_ratio(MathExtend.divide(beginInfoBean.getReturn_amt(),beginInfoBean.getEquip_amt(),6));
				//0.2.6 �����ʶ����
				//beginInfoBean.setActual_fund_ratio(MathExtend.divide(beginInfoBean.getActual_fund(), beginInfoBean.getEquip_amt(),6));
				
				//==============================================================
				//excelȱʧ������ֶ�
				//System.out.println("��ʼ���");
				beginInfoBean.setCurrency("currency_type1");//����
				beginInfoBean.setLease_money(obj[11][5]);//���ޱ���
				beginInfoBean.setRate_float_type("0");//���ʸ�������
				beginInfoBean.setRate_float_amt("0.00");//����ֵ
				beginInfoBean.setAdjust_style("1");//��Ϣ��ʽ
				beginInfoBean.setFree_defa_inter_day("3");//��Ϣ��
				beginInfoBean.setInto_batch("��");//�Ƿ�������Ϣ
				beginInfoBean.setPena_rate("5");//��Ϣ������
				beginInfoBean.setIs_open("��");
				beginInfoBean.setPlan_bank_name("");
				beginInfoBean.setPlan_bank_no("");
				beginInfoBean.setCreator(czy);//������
				beginInfoBean.setCreate_date(datestr);//��������
				beginInfoBean.setCreate_date(flowSysDate);//��������
				beginInfoBean.setModificator(czy);
				beginInfoBean.setModify_date(datestr);
				
				//-========--2.��Ϊ��װ���ƻ�����-==============--
				RentPlanBean rentPlanBean = null;
				//RentCashBean rentCashBean = null;
				//��12�е��ֽ���
				//rentCashBean = new RentCashBean();
				//rentCashBean.setContract_id(contract_id);
				//rentCashBean.setDoc_id(doc_id);
				
				/**
				 * ��13�е�2�� ��  �ڣ�13+�껹�����*��ݣ�6��
				**/
				for(int row=12;row<ConvertUtil.parseInt(beginInfoBean.getIncome_number(),12)+12;row++){//��������
					String []objrow = obj[row]; 
					rentPlanBean = new RentPlanBean();
					//--1.��ת���ƻ�����
					System.out.println("row="+row+"����"+objrow[0]+"\t�ڴ�"+objrow[1]);
					// ���Ը�ֵ
					rentPlanBean.setContract_id(contract_id);
					rentPlanBean.setBegin_id(begin_id);
					rentPlanBean.setDoc_id(doc_id);
					rentPlanBean.setMeasure_date(datestr);
					
					rentPlanBean.setRent_list( objrow[1] );
					rentPlanBean.setPlan_date( objrow[0] );
					rentPlanBean.setPlan_status("δ����");
					
					rentPlanBean.setCurr_rent( objrow[2] );
					rentPlanBean.setRent(objrow[2]);
					rentPlanBean.setCurr_corpus(objrow[4]);
					rentPlanBean.setCorpus(objrow[4]);
					rentPlanBean.setYear_rate(beginInfoBean.getYear_rate());
					rentPlanBean.setCurr_interest(objrow[3]);
					rentPlanBean.setInterest(objrow[3]);
					
					rentPlanBean.setPlan_bank_name("");
					rentPlanBean.setPlan_bank_no("");
					rentPlanBean.setCorpus_overage(objrow[5]);
					rentPlanBean.setCreator(czy);
					rentPlanBean.setCreate_date(datestr);
					
					// ��ӵ�list
					rentPlanList.add(rentPlanBean);
					
					//--2.��Ϊ��ת�ֽ�������---
					//rentCashBean = new RentCashBean();
					// ���Ը�ֵ
					//rentCashBean.setContract_id(contract_id);
					//rentCashBean.setDoc_id(doc_id);
					//rentCashBean.setPlan_date( objrow[0] );
					//rentCashBean.setFollow_in( objrow[2] );
					//rentCashBean.setFollow_in_detail("���"+objrow[2]);
					//rentCashBean.setFollow_out("0");
					//rentCashBean.setFollow_out_detail("");
					//rentCashBean.setNet_follow(objrow[6]);
					//rentCashBean.setCreator(czy);
					//rentCashBean.setCreate_date(datestr);
					//��ӵ�List
					//rentCashList.add(rentCashBean);
				} 
				//ִ�б���
				//1.����beginInfoBean
				LogWriter.logDebug("��ʼ����BeginInfoBean");
				flag = BeginService.saveUploadBeginInfoBean(beginInfoBean);
				//2.�������ƻ�List
				LogWriter.logDebug("��ʼ�������ƻ�"+rentPlanList.size());
				flag += RentPlanService.saveUploadRentPlanBeginList(rentPlanList, contract_id,begin_id, doc_id);
				//3.�����ֽ���List
				//RentCashService.saveUploadRentCashBeginList(rentCashList, contract_id,begin_id, doc_id);
				LogWriter.logDebug(request, "ִ���ϴ�������Excel�ɹ�");
				
				//��־����
				String sqlLog = LogWriter.getSqlIntoDB(request, "����������", "���ݵ���", "�û��������������͡�"+uploadFileName+"������", sqlstr);
				db.executeUpdate(sqlLog);
			}else{
				errMsg +=saObjectFile[j]+";";
			}
		}
	}//forѭ������
   }

db.close();

if(flag>1){
%>
<script type="text/javascript">
	window.open("http://culc.eleasing.com.cn/eleasing/PMAgent.nsf/CreateQZNotice2?openagent&fileno=111&contractid=<%=contract_id %>&docid=<%=doc_id %>&beginid=<%=begin_id %>","","status=no,scrollbars=no,location=no,menubar=yes,resizable=yes");

	window.close();
	opener.alert("�ļ��ϴ��ɹ��������޸ı������ֶΣ�");
	opener.parent.location.reload();
</script>
<%
}else{
%>
<script type="text/javascript">
	window.close();
	opener.alert("�ļ��ϴ�ʧ�ܣ���鿴��ʽ�Ƿ���ϣ�");
	opener.parent.location.reload();
</script>
<%
}%>