package com.webService.service;
import java.text.SimpleDateFormat;
import java.util.Date;

import com.webService.bean.GlobalBjjsBean;


//本金计税增值税（应收）
public class GlobalBjjsXml {
	public static String getXmlStr(GlobalBjjsBean globalBjjsBean) throws Exception {
		SimpleDateFormat df1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		SimpleDateFormat df2 = new SimpleDateFormat("yyyy-MM-dd");
		String nowDate = df1.format(new Date());
		String oldremark_2=globalBjjsBean.getRemark_2();
		Double changerate=Double.parseDouble(oldremark_2);
		String newRemark_2=changerate.toString();
		   //newRemark_2="0.00";//财务商定设置成0.00 
		StringBuffer sb=new StringBuffer();
		sb.append("<?xml version='1.0' encoding='gb2312'?>");
		sb.append("<ufinterface account='develop' billtype='F0' businessunitcode='' filename='' groupcode='001' isexchange='Y' replace='Y' roottag='' sender='ERP'>");
		sb.append("<bill>");
		sb.append("<billhead>");
		sb.append("<pk_group>001</pk_group>");
		sb.append("<pk_org>0101</pk_org>");
		sb.append("<creater>ERP</creater>");
		sb.append("<officialprintuser>ERP</officialprintuser>");
		sb.append("<officialprintdate>"+nowDate+"</officialprintdate>");
		sb.append("<pk_billtype>F0</pk_billtype>");
		sb.append("<pk_tradetype>F0-Cxx-03</pk_tradetype>");
		sb.append("<confirmuser>ERP</confirmuser>");
		sb.append("<src_syscode>17</src_syscode>");
		sb.append("<syscode>0</syscode>");
		sb.append("<billstatus>1</billstatus>");
		sb.append("<billdate>"+nowDate+"</billdate>");//odate
		sb.append("<billmaker>ERP</billmaker>");
		sb.append("<approver>ERP</approver>");
		sb.append("<approvedate>"+nowDate+"</approvedate>");	
		sb.append("<rate>1</rate>");
		sb.append("<effectstatus>10</effectstatus>");		
		sb.append("<pk_deptid>"+globalBjjsBean.getNcdeptno()+"</pk_deptid>");
		sb.append("<pk_psndoc>"+globalBjjsBean.getBcode()+"</pk_psndoc>");//业务员编码
		sb.append("<customer>"+globalBjjsBean.getNccode()+"</customer>");//客商
		sb.append("<pk_currtype>CNY</pk_currtype>");
		sb.append("<objtype>0</objtype>");
		sb.append("<scomment>"+globalBjjsBean.getPcode()+"</scomment>");
		//sb.append("<billperiod>"+globalinterestbean.getInvyear_month()+"</billperiod>");//和用友红雷商定废除
		sb.append("<def2>"+globalBjjsBean.getInvcode()+"</def2>");//单据号=================================标签确认
		sb.append("<def3>"+globalBjjsBean.getIndustry()+"</def3>");
		sb.append("<def7>"+globalBjjsBean.getPicode()+"</def7>");//项目编号
		sb.append("<def8>"+globalBjjsBean.getPcode()+"</def8>");//项目名称
		sb.append("<def9>"+globalBjjsBean.getLeas_type()+"</def9>");//租赁类型
		sb.append("<def4></def4>");
		     sb.append("<bodys>");	
		     sb.append("<item>");
				sb.append("<buysellflag>1</buysellflag>");
				sb.append("<pk_currtype>CNY</pk_currtype>");
				sb.append("<rate>1</rate>");
				sb.append("<objtype>0</objtype>");
				sb.append("<pk_deptid>"+globalBjjsBean.getNcdeptno()+"</pk_deptid>");//nc人员编码
				sb.append("<customer>"+globalBjjsBean.getNccode()+"</customer>");//客商
				sb.append("<pk_psndoc>"+globalBjjsBean.getBcode()+"</pk_psndoc>");//业务员编码
				sb.append("<money_de>"+globalBjjsBean.getRmb()+"</money_de>");
				sb.append("<local_money_de>"+globalBjjsBean.getRmb()+"</local_money_de>");
				sb.append("<quantity_de></quantity_de>");
				sb.append("<notax_de>"+globalBjjsBean.getRmb()+"</notax_de>");
				sb.append("<local_notax_de>"+globalBjjsBean.getRmb()+"</local_notax_de>");
				sb.append("<taxrate>"+newRemark_2+"</taxrate>");
				sb.append("<busidate>"+globalBjjsBean.getModifydate()+"</busidate>");
				sb.append("<def7>"+globalBjjsBean.getInvtype()+"</def7>");
				sb.append("<def11>"+globalBjjsBean.getInvyear()+"</def11>");//年
				sb.append("<def12>"+globalBjjsBean.getInvmonth()+"</def12>");//月			
				sb.append("<def16>"+(globalBjjsBean.getRemark_o().equals("营业税")?"1":"2")+"</def16>");
				sb.append("<def18>"+newRemark_2+"</def18>");
				sb.append("<def19>"+newRemark_2+"</def19>");
				sb.append("<contractno>"+globalBjjsBean.getOrdcode()+"</contractno>");
				sb.append("<scomment></scomment>");
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
