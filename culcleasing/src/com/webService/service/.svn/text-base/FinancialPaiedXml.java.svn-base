package com.webService.service;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

import com.webService.bean.GlobalPaiedBean;
//付款单
public class FinancialPaiedXml {
	
	public static String getXmlStr(GlobalPaiedBean globalPaiedBean) throws Exception {
		StringBuffer sb=new StringBuffer();
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String nowDate = df.format(new Date());
		String Odateold=globalPaiedBean.getRdate();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date d = sdf.parse(Odateold);
		String  Odate = df.format(d);
		DecimalFormat dfr=new DecimalFormat("0.##");
		String oldremark_2=globalPaiedBean.getRemark_2();
		if(oldremark_2==null||oldremark_2.equals("")){
			oldremark_2="0";
		}
		Double changerate=Double.parseDouble(oldremark_2);
		String newRemark_2=dfr.format(changerate);
		if(newRemark_2.equals("0")){
			newRemark_2="0.00";
		}
		sb.append("<?xml version='1.0' encoding='gb2312'?>");
		sb.append("<ufinterface account='develop' billtype='F3' businessunitcode='' filename='' groupcode='001'  isexchange='Y' replace='Y' roottag='' sender='ERP'>");
		sb.append("<bill>");
			sb.append("<billhead>");
			 sb.append("<creater>ERP</creater>");
				sb.append("<pk_group>001</pk_group>");//
				sb.append("<pk_org>0101</pk_org>");//
				sb.append("<officialprintuser>ERP</officialprintuser>");//
				sb.append("<officialprintdate>"+nowDate+"</officialprintdate>");//
				sb.append("<pk_billtype>F3</pk_billtype>");
				sb.append("<pk_tradetype>D3</pk_tradetype>");
				sb.append("<confirmuser>ERP</confirmuser>");
				sb.append("<billdate>"+nowDate+"</billdate>");
				sb.append("<src_syscode>17</src_syscode>");
				sb.append("<syscode>0</syscode>");
				sb.append("<billstatus>1</billstatus>");
				sb.append("<billmaker>ERP</billmaker>");
				sb.append("<approver>ERP</approver>");//
				sb.append("<approvedate>"+nowDate+"</approvedate>");//				
				sb.append("<effectstatus>10</effectstatus>");
				sb.append("<def2>"+globalPaiedBean.getInvcode()+"</def2>");
				sb.append("<scomment>"+globalPaiedBean.getPcode()+"</scomment>");//
				sb.append("<rate>1</rate>");
				sb.append("<pk_psndoc>"+globalPaiedBean.getBcode()+"</pk_psndoc>");//crm增加字段，nc人员编码
				sb.append("<def6>"+globalPaiedBean.getNccode()+"</def6>");//crm增加字段，nc客商编码 200602
				sb.append("<pk_currtype>CNY</pk_currtype>");
				sb.append("<objtype>1</objtype>");
				sb.append("<def3>"+globalPaiedBean.getIndustry()+"</def3>");
				sb.append("<supplier>"+globalPaiedBean.getCcode()+"</supplier>");//收款人
				sb.append("<def7>"+globalPaiedBean.getPicode()+"</def7>");
				sb.append("<def8>"+globalPaiedBean.getPcode()+"</def8>");
				sb.append("<def9>"+globalPaiedBean.getLeas_type()+"</def9>");
				sb.append("<operator>ERP</operator>");				
				sb.append("<bodys>");
					sb.append("<item>");
					    sb.append("<pk_group>001</pk_group>");//
					    sb.append("<pk_org>0101</pk_org>");//
					    sb.append("<supplier>"+globalPaiedBean.getCcode()+"</supplier>");//收款人
						sb.append("<pk_deptid>"+globalPaiedBean.getNcdeptno()+"</pk_deptid>");
						sb.append("<pk_billtype>F3</pk_billtype>");
						sb.append("<billclass>FK</billclass>");
						sb.append("<pk_tradetype>d3</pk_tradetype>");
						sb.append("<busidate>"+Odate+"</busidate>");
						sb.append("<paydate>"+globalPaiedBean.getRdate().substring(0, 10)+"</paydate>");
						sb.append("<objtype>1</objtype>");
						sb.append("<direction>-1</direction>");
						sb.append("<pk_currtype>CNY</pk_currtype>");
						sb.append("<rate>1</rate>");	
					    sb.append("<pk_psndoc>"+globalPaiedBean.getBcode()+"</pk_psndoc>");//crm增加字段，nc人员编码						//sb.append("<quantity_de></quantity_de>");//
						sb.append("<local_money_de>"+globalPaiedBean.getRmb()+"</local_money_de>");
						sb.append("<money_de>"+globalPaiedBean.getRmb()+"</money_de>");
						sb.append("<notax_de>"+globalPaiedBean.getRmb()+"</notax_de>");
						sb.append("<contractno>"+globalPaiedBean.getOrdcode()+"</contractno>");
						sb.append("<taxrate>"+(newRemark_2==null||newRemark_2.equals("")?"0.00":newRemark_2)+"</taxrate>");
						sb.append("<def7>"+globalPaiedBean.getInvtype()+"</def7>");
						sb.append("<def8>"+(globalPaiedBean.getPawnsign()=="0"?"N":"Y")+"</def8>");
						sb.append("<def9>"+globalPaiedBean.getPawnrmb()+"</def9>");						
						sb.append("<def16>"+(globalPaiedBean.getRemark_o().equals("营业税")?"1":"2")+"</def16>");
						sb.append("<def18>"+(newRemark_2==null||newRemark_2.equals("")?"0.00":newRemark_2)+"</def18>");
						sb.append("<def19>"+(newRemark_2==null||newRemark_2.equals("")?"0.00":newRemark_2)+"</def19>");
						sb.append("<payaccount>"+globalPaiedBean.getAcode()+"</payaccount>");//NC银行编码

					sb.append("</item>");
				sb.append("</bodys>");
			sb.append("</billhead>");
		sb.append("</bill>");
		sb.append("</ufinterface>");
		String xmlMassage = sb.toString();
		System.out.println(xmlMassage);
		
		return xmlMassage;
	  };
}
