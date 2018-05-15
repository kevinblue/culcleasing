package com.webService.service;

import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

import com.webService.bean.GlobalFundPlanBean;


public class FundPaymentPlanXml {
	
	public static String getXmlStr(GlobalFundPlanBean globalFundPlanBean) throws Exception {
		StringBuffer sb=new StringBuffer();
		String Odateold=globalFundPlanBean.getOdate();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date d = sdf.parse(Odateold);
		
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String  Odate = df.format(d);
		String nowDate = df.format(new Date());
		DecimalFormat dfr=new DecimalFormat("0.##");
		String oldremark_2=globalFundPlanBean.getRemark_2();
		if(oldremark_2==null||oldremark_2.equals("")){
			oldremark_2="0";
		}
		Double changerate=Double.parseDouble(oldremark_2);
		String newRemark_2=dfr.format(changerate);
		if(newRemark_2.equals("0")){
			newRemark_2="0.00";
		}
		sb.append("<?xml version='1.0' encoding='GB2312'?>");
		sb.append("<ufinterface account='develop' billtype='F3' businessunitcode='' filename='' groupcode='001' isexchange='Y' replace='Y' roottag='' sender='ERP'>");
		sb.append("<bill>");
			sb.append("<billhead>");
			    sb.append("<creater>ERP</creater>");
				sb.append("<pk_group>001</pk_group>");//
				sb.append("<pk_org>0101</pk_org>");//财务组织编码后面添加
				sb.append("<officialprintuser>ERP</officialprintuser>");//
				sb.append("<officialprintdate>"+nowDate+"</officialprintdate>");//
				sb.append("<pk_billtype>F3</pk_billtype>");
				sb.append("<pk_tradetype>F3-Cxx-02</pk_tradetype>");
				sb.append("<confirmuser>ERP</confirmuser>");
				sb.append("<billdate>"+nowDate+"</billdate>");//实际支付日期=========================================实际支付日期
				sb.append("<src_syscode>17</src_syscode>");
				sb.append("<syscode>0</syscode>");
				sb.append("<billstatus>1</billstatus>");
				sb.append("<billmaker>ERP</billmaker>");
				sb.append("<approver>ERP</approver>");//
			//	sb.append("<def5>"+globalFundPlanBean.getChangesign()+"</def5>");//15变更标识			    			
				sb.append("<customer>"+globalFundPlanBean.getCcodetrust()+"</customer>");//承租客户============================================承租客户
				sb.append("<approvedate>"+nowDate+"</approvedate>");//				
				sb.append("<effectstatus>10</effectstatus>");
				//sb.append("<effectdate>"+globalFundPlanBean.getOdate()+"</effectdate>");
				sb.append("<def2>"+globalFundPlanBean.getInvcode()+"</def2>");//6单据号
				sb.append("<scomment>"+globalFundPlanBean.getPcode()+"</scomment>");//
				sb.append("<rate>1</rate>");
				sb.append("<pk_deptid>"+globalFundPlanBean.getNcdeptno()+"</pk_deptid>");//
				sb.append("<pk_psndoc>"+globalFundPlanBean.getBcode()+"</pk_psndoc>");//业务员
				sb.append("<def6>"+globalFundPlanBean.getNccode()+"</def6>");//15客商编码	
				sb.append("<supplier>"+globalFundPlanBean.getCcode()+"</supplier>");//crm澧炲姞瀛楁锛宯c瀹㈠晢缂栫爜
				sb.append("<pk_currtype>CNY</pk_currtype>");
				sb.append("<def7>"+globalFundPlanBean.getPicode()+"</def7>");
				sb.append("<def8>"+globalFundPlanBean.getPcode()+"</def8>");
				sb.append("<def9>"+globalFundPlanBean.getTenancytype()+"</def9>");
				sb.append("<objtype>1</objtype>");
				sb.append("<def3>"+globalFundPlanBean.getIndustry()+"</def3>");
				sb.append("<bodys>");
					sb.append("<item>");
						sb.append("<contractno>"+globalFundPlanBean.getOrdcode()+"</contractno>");//13 合同号
						sb.append("<postpricenotax></postpricenotax>");//
						sb.append("<supplier>"+globalFundPlanBean.getCcode()+"</supplier>");//crm澧炲姞瀛楁锛宯c瀹㈠晢缂栫爜
						sb.append("<postprice></postprice>");//
						sb.append("<payaccount>"+(globalFundPlanBean.getAcode()==null||("").equals(globalFundPlanBean.getAcode())?"110060239018170024379":globalFundPlanBean.getAcode())+"</payaccount>");//
						sb.append("<pausetransact></pausetransact>");//
						sb.append("<pk_billtype>F3</pk_billtype>");
						sb.append("<billclass>FK</billclass>");
					//	sb.append("<def6>"+globalFundPlanBean.getRemark()+"</def6>");//14款项名称
						sb.append("<pk_tradetype>F3-Cxx-02</pk_tradetype>");
					//	sb.append("<busidate>2017-07-01 10:23:23</busidate>");//日期晚了
						sb.append("<busidate>"+globalFundPlanBean.getOdate()+"</busidate>");//日期晚了
						sb.append("<objtype>1</objtype>");
						sb.append("<direction>-1</direction>");
						sb.append("<pk_currtype>CNY</pk_currtype>");
						sb.append("<rate>1</rate>");
						sb.append("<pk_deptid>"+globalFundPlanBean.getNcdeptno()+"</pk_deptid>");//
						sb.append("<pk_psndoc>"+globalFundPlanBean.getBcode()+"</pk_psndoc>");//资金还没加
						sb.append("<quantity_de></quantity_de>");//
						sb.append("<local_money_de>"+globalFundPlanBean.getRmb()+"</local_money_de>");//
						sb.append("<money_de>"+globalFundPlanBean.getRmb()+"</money_de>");//
						sb.append("<notax_de>"+globalFundPlanBean.getRmb()+"</notax_de>");//
						sb.append("<prepay>0</prepay>");//				
						sb.append("<invoiceno></invoiceno>");//
						sb.append("<taxrate>"+newRemark_2+"</taxrate>");//
						sb.append("<def7>"+globalFundPlanBean.getInvtype()+"</def7>");						
						//sb.append("<def15>"+Odate+"</def15>");//16计划日期
						sb.append("<def16>"+(globalFundPlanBean.getRemark_o().equals("营业税")?"1":"2")+"</def16>");//16税种
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
