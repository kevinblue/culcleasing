package com.webService.service;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

import com.webService.bean.GlobalReceiveBean;
//国内收款单
public class GlobalReceiveXml {
	public static String getXmlStr(GlobalReceiveBean globalReceiveBean) throws Exception {
		SimpleDateFormat df1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		SimpleDateFormat df2 = new SimpleDateFormat("yyyy-MM-dd");
		String Odateold=globalReceiveBean.getOdate();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date d = sdf.parse(Odateold);
		String  Odate = df1.format(d);
		String nowDate = df1.format(new Date());
		DecimalFormat dfr=new DecimalFormat("0.##");
		String oldremark_2=globalReceiveBean.getRemark_2();
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
		sb.append("<ufinterface account='develop' billtype='F2' businessunitcode='' filename='' groupcode='001' isexchange='Y' replace='Y' roottag='' sender='ERP'>");
		sb.append("<bill>");
			sb.append("<billhead>");						  
			  sb.append("<creater>ERP</creater>");
			    sb.append("<pk_group>001</pk_group>");			
				sb.append("<billdate>"+nowDate+"</billdate>");//effectdate实际到帐日期==============================================================实际到帐日期
				sb.append("<pk_org>010101</pk_org>");							
			//	sb.append("<recaccount>"+globalReceiveBean.getAcode()+"</recaccount>");//8收款账户 
				sb.append("<officialprintuser>ERP</officialprintuser>");
				sb.append("<officialprintdate>"+nowDate+"</officialprintdate>");
				sb.append("<confirmuser>ERP</confirmuser>");
				sb.append("<src_syscode>17</src_syscode>");
				sb.append("<syscode>0</syscode>");
				sb.append("<billstatus>1</billstatus>");			
				sb.append("<billmaker>ERP</billmaker>");
				sb.append("<approver>ERP</approver>");
				sb.append("<approvedate>"+nowDate+"</approvedate>");			
				sb.append("<rate>1</rate>");			
				sb.append("<pk_billtype>F2</pk_billtype>");
				sb.append("<pk_tradetype>F2-Cxx-01</pk_tradetype>");
				sb.append("<def2>"+globalReceiveBean.getInvcode()+"</def2>");//6单据号		
				sb.append("<customer>"+globalReceiveBean.getNccode()+"</customer>");//客商编码客商编码200589===========================================================================//客商编码
				sb.append("<pk_currtype>CNY</pk_currtype>");
				sb.append("<pk_psndoc>"+globalReceiveBean.getBcode()+"</pk_psndoc>");
				sb.append("<def3>"+globalReceiveBean.getIndustry()+"</def3>");//内部行业
				sb.append("<def7>"+globalReceiveBean.getPicode()+"</def7>");//项目编号
				sb.append("<def8>"+globalReceiveBean.getPcode()+"</def8>");//项目名称
				sb.append("<def9>"+globalReceiveBean.getLeas_type()+"</def9>");//租赁类型
				sb.append("<scomment>"+globalReceiveBean.getPcode()+"</scomment>");//18项目名称
				sb.append("<effectstatus>10</effectstatus>");
				sb.append("<bodys>");
					sb.append("<item>");
						sb.append("<notax_cr>"+globalReceiveBean.getRmb()+"</notax_cr>");//					
						sb.append("<customer>"+globalReceiveBean.getNccode()+"</customer>");//客商编码客商编码=================================================//客商编码（客商编码为null）
						sb.append("<pk_billtype>F2</pk_billtype>");
						sb.append("<billclass>sk</billclass>");
					//	sb.append("<pk_billtype >F2-Cxx-01</pk_billtype>");
						sb.append("<busidate>"+Odate+"</busidate>");//实际到账时间
						sb.append("<objtype>0</objtype>");
						sb.append("<direction>1</direction>");
						sb.append("<scomment></scomment>");
						sb.append("<pk_currtype>CNY</pk_currtype>");					
						sb.append("<recaccount>"+globalReceiveBean.getAcode()+"</recaccount>");//8收款账户 05010126360000834						
						sb.append("<rate>1</rate>");
						sb.append("<pk_deptid>"+globalReceiveBean.getNcdeptno()+"</pk_deptid>");
						sb.append("<pk_psndoc>"+globalReceiveBean.getBcode()+"</pk_psndoc>");//业务员===================================================================业务员,业务员,业务员(业务员)(没改)
						sb.append("<money_cr>"+globalReceiveBean.getRmb()+"</money_cr>");//人名币金额
						sb.append("<local_money_cr>"+globalReceiveBean.getRmb()+"</local_money_cr>");						
						sb.append("<contractno>"+globalReceiveBean.getOrdcode()+"</contractno>");//合同号（租赁合同）
						sb.append("<def13>"+globalReceiveBean.getRemark()+"</def13>");//款项名称
						sb.append("<def14>"+globalReceiveBean.getSparecolumn_a()+"</def14>");//备用字段1
						sb.append("<def15>"+globalReceiveBean.getSparecolumn_b()+"</def15>");//备用字段2
						sb.append("<def7>"+globalReceiveBean.getInvtype()+"</def7>");//款项内容
						sb.append("<def8>"+(globalReceiveBean.getPawnsign().equals("0")?"N":"Y")+"</def8>");//坐扣标志
						sb.append("<def9>"+globalReceiveBean.getPawnrmb()+"</def9>");//坐扣后金额
						sb.append("<def10>"+globalReceiveBean.getPawncode()+"</def10>");//付款单据号						
						sb.append("<def16>"+(globalReceiveBean.getRemark_o().equals("营业税")?"1":"2")+"</def16>");//税种
						sb.append("<def18>"+(newRemark_2==null || newRemark_2.equals("")?"0.00":newRemark_2)+"</def18>");						
						sb.append("<def19>"+(newRemark_2==null || newRemark_2.equals("")?"0.00":newRemark_2)+"</def19>");											
						sb.append("<isdiscount>"+(globalReceiveBean.getOffset()=="0"?"N":"Y")+"</isdiscount>");//14是否保证金抵扣
						sb.append("<local_notax_cr>"+globalReceiveBean.getRmb()+"</local_notax_cr>");
						sb.append("<quantity_cr></quantity_cr>");
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
