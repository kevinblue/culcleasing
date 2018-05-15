package com.webService.service;
import java.text.SimpleDateFormat;
import java.util.Date;
import com.webService.bean.GlobalInterestSubsidyBean;
//确认利息补贴（应收单)
public class GlobalInterestSubsidyXml {
	public static String getXmlStr(GlobalInterestSubsidyBean globalinterestsubsidybean) throws Exception {
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String nowDate = df.format(new Date());
		StringBuffer sb=new StringBuffer();
		sb.append("<?xml version='1.0' encoding='gb2312'?>");
		sb.append("<ufinterface account='develop' billtype='F0' businessunitcode='' filename='' groupcode='001' isexchange='Y' replace='Y' roottag='' sender='ERP'>");
		sb.append("<bill>");
		sb.append("<billhead>");
		sb.append("<pk_group>001</pk_group>");
		sb.append("<creater>ERP</creater>");
		sb.append("<billdate>"+nowDate+"</billdate>");//odate
		sb.append("<pk_org>0101</pk_org>");
		sb.append("<officialprintuser>ERP</officialprintuser>");
		sb.append("<officialprintdate>"+nowDate+"</officialprintdate>");
		sb.append("<pk_billtype>F0</pk_billtype>");
		sb.append("<pk_tradetype>F0-Cxx-04</pk_tradetype>");
		sb.append("<confirmuser>ERP</confirmuser>");
		sb.append("<src_syscode>17</src_syscode>");
		sb.append("<syscode>0</syscode>");
		sb.append("<billstatus>1</billstatus>");
		//sb.append("<billdate>"+globalinterestsubsidybean.getSub_date()+"</billdate>");
		sb.append("<billmaker>ERP</billmaker>");
		sb.append("<approver>ERP</approver>");
		sb.append("<approvedate>"+nowDate+"</approvedate>");
		sb.append("<rate>1</rate>");
		sb.append("<effectstatus>10</effectstatus>");
		sb.append("<effectdate>"+globalinterestsubsidybean.getSub_date().substring(0, 10)+"</effectdate>");
		sb.append("<pk_deptid>"+globalinterestsubsidybean.getNcdeptno()+"</pk_deptid>");
		sb.append("<pk_psndoc>"+globalinterestsubsidybean.getBcode()+"</pk_psndoc>");//业务员编码
		sb.append("<customer>"+globalinterestsubsidybean.getNccode()+"</customer>");//承租客户
		sb.append("<pk_currtype>CNY</pk_currtype>");
		sb.append("<objtype>0</objtype>");
		sb.append("<scomment>"+globalinterestsubsidybean.getPcode()+"</scomment>");
		sb.append("<def7>"+globalinterestsubsidybean.getPicode()+"</def7>");
		sb.append("<def8>"+globalinterestsubsidybean.getPcode()+"</def8>");
		sb.append("<def9>"+globalinterestsubsidybean.getLeas_type()+"</def9>");
		sb.append("<def2>"+globalinterestsubsidybean.getInvcode()+"</def2>");
		sb.append("<def3>"+globalinterestsubsidybean.getIndustry()+"</def3>");
		sb.append("<def4></def4>");
					sb.append("<bodys>");
					sb.append("<item>");
					sb.append("<customer>"+globalinterestsubsidybean.getNccode()+"</customer>");//承租客户													
					sb.append("<pk_billtype>F0</pk_billtype>");
					sb.append("<billclass>sk</billclass>");
					sb.append("<pk_tradetype>F0-Cxx-04</pk_tradetype>");
					sb.append("<busidate>"+globalinterestsubsidybean.getSub_date().substring(0, 10)+"</busidate>");
					sb.append("<objtype>0</objtype>");
					sb.append("<direction>1</direction>");
					sb.append("<buysellflag>1</buysellflag>");
					sb.append("<pk_currtype>CNY</pk_currtype>");
					sb.append("<rate>1</rate>");
					sb.append("<pk_deptid>"+globalinterestsubsidybean.getNcdeptno()+"</pk_deptid>");//部门nc编号
					sb.append("<pk_psndoc>"+globalinterestsubsidybean.getBcode()+"</pk_psndoc>");//nc人员编码
					sb.append("<money_de>"+globalinterestsubsidybean.getRmb()+"</money_de>");
					sb.append("<local_money_de>"+globalinterestsubsidybean.getRmb()+"</local_money_de>");
					sb.append("<quantity_de></quantity_de>");
					sb.append("<notax_de>"+globalinterestsubsidybean.getRmb()+"</notax_de>");
					sb.append("<local_notax_de>"+globalinterestsubsidybean.getRmb()+"</local_notax_de>");
					sb.append("<taxrate>"+(globalinterestsubsidybean.getRemark_2()==null?"0.00":globalinterestsubsidybean.getRemark_2())+"</taxrate>");
					sb.append("<def7>"+globalinterestsubsidybean.getInvtype()+"</def7>");	
					sb.append("<def16>"+(globalinterestsubsidybean.getRemark_o().equals("营业税")?"1":"2")+"</def16>");
					sb.append("<def18>"+(globalinterestsubsidybean.getRemark_2()==null?"0.00":globalinterestsubsidybean.getRemark_2())+"</def18>");					
					sb.append("<def19>"+(globalinterestsubsidybean.getRemark_2()==null?"0.00":globalinterestsubsidybean.getRemark_2())+"</def19>");					
					sb.append("<contractno>"+globalinterestsubsidybean.getOrdcode()+"</contractno>");
					sb.append("<scomment>"+globalinterestsubsidybean.getPcode()+"</scomment>");
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
