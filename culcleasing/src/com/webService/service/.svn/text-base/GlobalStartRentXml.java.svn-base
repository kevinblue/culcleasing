package com.webService.service;

import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

import com.webService.bean.GlobalStartRentBean;


public class GlobalStartRentXml {
	public static String getXmlStr(GlobalStartRentBean globalStartRentBean) throws Exception {
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String nowDate = df.format(new Date());
		String Odateold=globalStartRentBean.getOdate();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date d = sdf.parse(Odateold);
		String  Odate = df.format(d);
		System.out.println("nowDate:"+nowDate);
		DecimalFormat dfr=new DecimalFormat("0.##");
		String oldremark_2=globalStartRentBean.getRemark_2();
		if(oldremark_2==null||oldremark_2.equals("")){
			oldremark_2="0";
		}
		Double changerate=Double.parseDouble(oldremark_2);
		String newRemark_2=dfr.format(changerate);
		if(newRemark_2.equals("0")){
			newRemark_2="0.00";
		}
		StringBuffer sb=new StringBuffer();
		sb.append("<?xml version='1.0' encoding='gb2312'?>");
		sb.append("<ufinterface account='develop' billtype='F0' businessunitcode='' filename='' groupcode='001' isexchange='Y' replace='Y' roottag='' sender='ERP'>");
		sb.append("<bill>");
		sb.append("<billhead>");
		sb.append("<creater>ERP</creater>");//后补的		
		sb.append("<pk_group>001</pk_group>");
		sb.append("<pk_org>0101</pk_org>");
		sb.append("<officialprintuser>ERP</officialprintuser>");
		sb.append("<officialprintdate>"+nowDate+"</officialprintdate>");
		sb.append("<pk_billtype>F0</pk_billtype>");
		sb.append("<pk_tradetype>F0-Cxx-02</pk_tradetype>");
		sb.append("<confirmuser>ERP</confirmuser>");
		sb.append("<src_syscode>17</src_syscode>");
		sb.append("<syscode>0</syscode>");
		sb.append("<billstatus>1</billstatus>");
	//	sb.append("<billdate>2017-08-01 14:36:12</billdate>");
		sb.append("<billdate>"+nowDate+"</billdate>");//起租日期odate=====================================================起租日期odate
		sb.append("<billmaker>ERP</billmaker>");
		sb.append("<approver>ERP</approver>");
		sb.append("<approvedate>"+nowDate+"</approvedate>");
		sb.append("<rate>1</rate>");
		sb.append("<effectstatus>10</effectstatus>");
		sb.append("<pk_deptid>"+globalStartRentBean.getNcdeptno()+"</pk_deptid>");
		sb.append("<pk_psndoc>"+globalStartRentBean.getBcode()+"</pk_psndoc>");//9项目经理
		sb.append("<customer>"+globalStartRentBean.getCcodetrust()+"</customer>");
		sb.append("<pk_currtype>CNY</pk_currtype>");
		sb.append("<objtype>0</objtype>");
		sb.append("<scomment>"+globalStartRentBean.getPcode()+"</scomment>");
		sb.append("<def2>"+globalStartRentBean.getInvcode()+"</def2>");//6单据号
		sb.append("<def3>"+globalStartRentBean.getIndustry()+"</def3>");
		sb.append("<def7>"+globalStartRentBean.getPicode()+"</def7>");
		sb.append("<def8>"+globalStartRentBean.getPcode()+"</def8>");
		sb.append("<def9>"+globalStartRentBean.getLeas_type()+"</def9>");
		sb.append("<def4>"+globalStartRentBean.getChangesign()+"</def4>");
		        sb.append("<bodys>");
				sb.append("<item>");
				sb.append("<customer>"+globalStartRentBean.getCcodetrust()+"</customer>");
				sb.append("<postunit>");
				sb.append("</postunit>");			
				sb.append("<pausetransact>N</pausetransact>");
				sb.append("<pk_billtype>F0</pk_billtype>");
				sb.append("<billclass>ys</billclass>");
				sb.append("<pk_tradetype>F0-Cxx-02</pk_tradetype>");
				sb.append("<busidate>"+Odate+"</busidate>");
				sb.append("<objtype>0</objtype>");
				sb.append("<direction>1</direction>");
				sb.append("<buysellflag>1</buysellflag>");
				sb.append("<pk_currtype>CNY</pk_currtype>");
				sb.append("<rate>1</rate>");
				sb.append("<pk_deptid>"+globalStartRentBean.getNcdeptno()+"</pk_deptid>");
				sb.append("<pk_psndoc>"+globalStartRentBean.getBcode()+"</pk_psndoc>");//9项目经理
				sb.append("<money_de>"+globalStartRentBean.getRmb()+"</money_de>");
				sb.append("<local_money_de>"+globalStartRentBean.getRmb()+"</local_money_de>");
				sb.append("<notax_de>"+globalStartRentBean.getRmb()+"</notax_de>");
				sb.append("<local_notax_de>"+globalStartRentBean.getRmb()+"</local_notax_de>");
				sb.append("<taxrate>"+(newRemark_2==null?"0.00":newRemark_2)+"</taxrate>");
				sb.append("<def16>"+(globalStartRentBean.getRemark_o().equals("营业税")?"1":"2")+"</def16>");
				sb.append("<def7>"+globalStartRentBean.getInvtype()+"</def7>");
				sb.append("<contractno>"+globalStartRentBean.getOrdcode()+"</contractno>");
				sb.append("<def18>"+(newRemark_2==null?"0.00":newRemark_2)+"</def18>");
				sb.append("<def19>"+(newRemark_2==null?"0.00":newRemark_2)+"</def19>");
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
