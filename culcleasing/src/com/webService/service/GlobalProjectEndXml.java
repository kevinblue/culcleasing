package com.webService.service;

import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

import com.webService.bean.GlobalProjectEndBean;


public class GlobalProjectEndXml {
	public static String getXmlStr(GlobalProjectEndBean globalProjectEndBean) throws Exception {
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String nowDate = df.format(new Date());
		String Odateold=globalProjectEndBean.getOdate();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date d = sdf.parse(Odateold);
		String  Odate = df.format(d);
		DecimalFormat dfr=new DecimalFormat("0.##");
		String oldremark_2=globalProjectEndBean.getRemark_2();
		if(oldremark_2==null||oldremark_2.equals("")){
			oldremark_2="0";
		}
		Double changerate=Double.parseDouble(oldremark_2);
		String newRemark_2=dfr.format(changerate);
		if(newRemark_2.equals("0")){
			newRemark_2="0.00";
		}
		System.out.println(newRemark_2);
		StringBuffer sb=new StringBuffer();
		sb.append("<?xml version='1.0' encoding='gb2312'?>");
		sb.append("<ufinterface account='develop' billtype='F2' businessunitcode='' filename='' groupcode='001' isexchange='Y' replace='Y' roottag='' sender='ERP'>");
		sb.append("<bill>");
			sb.append("<billhead>");
			    sb.append("<creater>ERP</creater>");
				sb.append("<pk_group>001</pk_group>");//
				sb.append("<billdate>"+nowDate+"</billdate>");//25ʵ�ʵ�������=======================================ʵ�ʵ�������
				sb.append("<pk_org>0101</pk_org>");
				sb.append("<officialprintuser>ERP</officialprintuser>");
				sb.append("<officialprintdate>"+nowDate+"</officialprintdate>");
				sb.append("<confirmuser>ERP</confirmuser>");
				sb.append("<src_syscode>17</src_syscode>");
				sb.append("<syscode>0</syscode>");
				sb.append("<billstatus>1</billstatus>");
				sb.append("<billmaker>ERP</billmaker>");
				//sb.append("<recaccount>35180188000123904</recaccount>");//9�տ��˻�
				//sb.append("<recaccount>"+globalProjectEndBean.getAcode()+"</recaccount>");//9�տ��˻�============================================�տ��˻�
				sb.append("<approver>ERP</approver>");
				sb.append("<approvedate>"+nowDate+"</approvedate>");				
				sb.append("<rate>1</rate>");
				sb.append("<pk_billtype>F2</pk_billtype>");
				sb.append("<pk_tradetype>F2-Cxx-02</pk_tradetype>");
				sb.append("<def2>"+globalProjectEndBean.getInvcode()+"</def2>");//6���ݺ�
				sb.append("<def3>"+globalProjectEndBean.getIndustry()+"</def3>");//6�ڲ���ҵ
				//sb.append("<customer>200322</customer>");//��Ӧ��
				sb.append("<customer>"+globalProjectEndBean.getNcode()+"</customer>");//��Ӧ��//����ͻ�===========================================nccode
				sb.append("<pk_currtype>CNY</pk_currtype>");
				sb.append("<def7>"+globalProjectEndBean.getPicode()+"</def7>");//17��Ŀ���
				sb.append("<def8>"+globalProjectEndBean.getPcode()+"</def8>");//18��Ŀ����
				sb.append("<def9>"+globalProjectEndBean.getLeas_type()+"</def9>");//23��������
				sb.append("<scomment>"+globalProjectEndBean.getPcode()+"</scomment>");//18��Ŀ����
				sb.append("<effectstatus>10</effectstatus>");
				sb.append("<bodys>");
					sb.append("<item>");
						sb.append("<customer>"+globalProjectEndBean.getNcode()+"</customer>");//����ͻ�===========================================nccode
						sb.append("<pk_billtype>F2</pk_billtype>");
						sb.append("<billclass>sk</billclass>");
						sb.append("<pk_tradetype>F2-Cxx-02</pk_tradetype>");
						sb.append("<busidate>"+Odate+"</busidate>");//ʵ�ʵ�������
						sb.append("<objtype>0</objtype>");
						sb.append("<direction>1</direction>");
						sb.append("<scomment></scomment>");
						sb.append("<pk_currtype>CNY</pk_currtype>");
						sb.append("<rate>1</rate>");
						sb.append("<recaccount>"+globalProjectEndBean.getAcode()+"</recaccount>");
						sb.append("<taxrate>"+newRemark_2+"</taxrate>");//24˰��
						sb.append("<contractno>"+globalProjectEndBean.getOrdcode()+"</contractno>");//16��ͬ��
					//	sb.append("<def5>"+Odate+"</def5>");//10ʵ�ʵ�������
						sb.append("<def13>"+globalProjectEndBean.getRemark()+"</def13>");//12��������
						sb.append("<def7>"+globalProjectEndBean.getInvtype()+"</def7>");//15��������						
						sb.append("<def16>"+(globalProjectEndBean.getRemark_o().equals("Ӫҵ˰")?"1":"2")+"</def16>");//20˰��
						sb.append("<def18>"+(newRemark_2==null || newRemark_2.equals("")?"0.00":newRemark_2)+"</def18>");						
						sb.append("<def19>"+(newRemark_2==null || newRemark_2.equals("")?"0.00":newRemark_2)+"</def19>");						
						sb.append("<pk_deptid>"+globalProjectEndBean.getNcdeptno()+"</pk_deptid>");//====================����ID
						sb.append("<pk_psndoc>"+globalProjectEndBean.getBcode()+"</pk_psndoc>");//ҵ��Ա========================ҵ��Ա(����ͬ�����Գɹ�)
						sb.append("<prepay>0</prepay>");
						sb.append("<money_cr>"+globalProjectEndBean.getRmb()+"</money_cr>");
						sb.append("<local_money_cr>"+globalProjectEndBean.getRmb()+"</local_money_cr>");
						sb.append("<notax_cr>"+globalProjectEndBean.getRmb()+"</notax_cr>");
						sb.append("<local_notax_cr>"+globalProjectEndBean.getRmb()+"</local_notax_cr>");
						sb.append("<quantity_cr>1</quantity_cr>");
					sb.append(" </item>");
				sb.append("</bodys>");
			sb.append("</billhead>");
		sb.append("</bill>");
		sb.append("</ufinterface>");
		String xmlMassage = sb.toString();
		System.out.println(xmlMassage);
		return xmlMassage;
	  };
}
