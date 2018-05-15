package com.webService.service;

import java.text.SimpleDateFormat;
import java.util.Date;

import com.webService.bean.GlobalBeforeConfirmBean;


public class GlobalBeforeComfirmXml {
	public static String getXmlStr(GlobalBeforeConfirmBean globalBeforeConfirmBean) throws Exception {
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String nowDate = df.format(new Date());
		String Odateold=globalBeforeConfirmBean.getAction_date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date d = sdf.parse(Odateold);
		String  Odate = df.format(d);
		String rentdiff=null;
		if(globalBeforeConfirmBean.getRent_diff().equals("0.00")){
			rentdiff="0";
		}	    
	    Integer dsrent=  Integer.parseInt(rentdiff);
		StringBuffer sb=new StringBuffer();
		sb.append("<?xml version='1.0' encoding='gb2312'?>");
		sb.append("<ufinterface account='develop' billtype='F2' businessunitcode='' filename='' groupcode='001' isexchange='Y' replace='Y' roottag='' sender='ERP'>");
		sb.append("<bill>");
			sb.append("<billhead>");
			    sb.append("<creater>ERP</creater>");
				sb.append("<pk_group>001</pk_group>");//
				sb.append("<billdate>"+nowDate+"</billdate>");//25实际到帐日期=======================================实际到帐日期
				sb.append("<pk_org>0101</pk_org>");
				sb.append("<officialprintuser>ERP</officialprintuser>");
				sb.append("<officialprintdate>"+nowDate+"</officialprintdate>");
				sb.append("<confirmuser>ERP</confirmuser>");
				sb.append("<effectdate>"+globalBeforeConfirmBean.getAction_date().substring(0, 10)+"</effectdate>");//33生效日期
				sb.append("<src_syscode>17</src_syscode>");
				sb.append("<syscode>0</syscode>");
				sb.append("<billstatus>1</billstatus>");
				sb.append("<billmaker>ERP</billmaker>");			
				sb.append("<recaccount>"+globalBeforeConfirmBean.getReceive_account()+"</recaccount>");//9收款账户============================================收款账户
				sb.append("<approver>ERP</approver>");
				sb.append("<approvedate>"+nowDate+"</approvedate>");		
				sb.append("<rate>1</rate>");		
				sb.append("<pk_billtype>F2</pk_billtype>");
				sb.append("<pk_tradetype>F2-Cxx-03</pk_tradetype>");
				sb.append("<def2>"+globalBeforeConfirmBean.getInvcode()+"</def2>");//6单据号
				sb.append("<def3>"+globalBeforeConfirmBean.getIndustry()+"</def3>");//6内部行业
				sb.append("<customer>"+globalBeforeConfirmBean.getCcodetrust()+"</customer>");//供应商//承租客户===========================================nccode
				sb.append("<pk_currtype>CNY</pk_currtype>");
				sb.append("<def7>"+globalBeforeConfirmBean.getProj_code()+"</def7>");//17项目编号
				sb.append("<def8>"+globalBeforeConfirmBean.getProj_name()+"</def8>");//18项目名称
				sb.append("<def9>"+globalBeforeConfirmBean.getLeas_type()+"</def9>");//23租赁类型
				sb.append("<scomment>"+globalBeforeConfirmBean.getProj_name()+"</scomment>");//18项目名称
				sb.append("<effectstatus>10</effectstatus>");
				sb.append("<bodys>");				
				//1租金
					sb.append("<item>");
						sb.append("<customer>"+globalBeforeConfirmBean.getCcodetrust()+"</customer>");
						sb.append("<pk_billtype>F2</pk_billtype>");
						sb.append("<billclass>sk</billclass>");
						sb.append("<pk_tradetype>F2-Cxx-03</pk_tradetype>");
						sb.append("<busidate>"+Odateold+"</busidate>");//实际到帐日期
						sb.append("<objtype>0</objtype>");
						sb.append("<direction>1</direction>");
						sb.append("<scomment></scomment>");
						sb.append("<pk_currtype>CNY</pk_currtype>");
						sb.append("<rate>1</rate>");
						sb.append("<recaccount>"+globalBeforeConfirmBean.getReceive_account()+"</recaccount>");
						sb.append("<taxrate>0.00</taxrate>");//24税率
						sb.append("<def18>0.00</def18>");//24税率
						sb.append("<contractno>"+globalBeforeConfirmBean.getContract_id()+"</contractno>");//16合同号
						sb.append("<def5>"+Odate+"</def5>");//10实际到账日期											
				        sb.append("<def16>"+(globalBeforeConfirmBean.getRemark_o().equals("营业税")?"1":"2")+"</def16>");//20税种
						sb.append("<pk_deptid>"+globalBeforeConfirmBean.getNcdeptno()+"</pk_deptid>");//====================部门ID
						sb.append("<pk_psndoc>"+globalBeforeConfirmBean.getBcode()+"</pk_psndoc>");//业务员========================业务员(数据同步测试成功)
						sb.append("<prepay>0</prepay>");
                        sb.append("<def6>租金</def6>");//12款项名称
						sb.append("<def7>886</def7>");//15款项内容
						sb.append("<money_cr>"+globalBeforeConfirmBean.getRent()+"</money_cr>");
						sb.append("<local_money_cr>"+globalBeforeConfirmBean.getRent()+"</local_money_cr>");
						sb.append("<notax_cr>"+globalBeforeConfirmBean.getRent()+"</notax_cr>");
						sb.append("<local_notax_cr>"+globalBeforeConfirmBean.getRent()+"</local_notax_cr>");
						sb.append("<quantity_cr>1</quantity_cr>");
					sb.append(" </item>");
					if(globalBeforeConfirmBean.getPenalty().equals("0.00")||globalBeforeConfirmBean.getPenalty().equals("0")){
						
					}else{
						//2罚息	(要税率)
						sb.append("<item>");
							sb.append("<customer>"+globalBeforeConfirmBean.getCcodetrust()+"</customer>");
							sb.append("<pk_billtype>F2</pk_billtype>");
							sb.append("<billclass>sk</billclass>");
							sb.append("<pk_tradetype>F2-Cxx-03</pk_tradetype>");
							sb.append("<busidate>"+Odateold+"</busidate>");//实际到帐日期
							sb.append("<objtype>0</objtype>");
							sb.append("<direction>1</direction>");
							sb.append("<scomment></scomment>");
							sb.append("<pk_currtype>CNY</pk_currtype>");
							sb.append("<rate>1</rate>");
							sb.append("<recaccount>"+globalBeforeConfirmBean.getReceive_account()+"</recaccount>");
							sb.append("<taxrate>"+globalBeforeConfirmBean.getRemark_2()+"</taxrate>");//24税率
							sb.append("<def18>"+globalBeforeConfirmBean.getRemark_2()+"</def18>");//24税率
							sb.append("<contractno>"+globalBeforeConfirmBean.getContract_id()+"</contractno>");//16合同号
							sb.append("<def5>"+Odate+"</def5>");//10实际到账日期					
							sb.append("<def16>"+(globalBeforeConfirmBean.getRemark_o().equals("营业税")?"1":"2")+"</def16>");//20税种				
							sb.append("<pk_deptid>"+globalBeforeConfirmBean.getNcdeptno()+"</pk_deptid>");//====================部门ID
							sb.append("<pk_psndoc>"+globalBeforeConfirmBean.getBcode()+"</pk_psndoc>");//业务员========================业务员(数据同步测试成功)
							sb.append("<prepay>0</prepay>");
		                    sb.append("<def6>罚息</def6>");//12款项名称
							sb.append("<def7>878</def7>");//15款项内容
							sb.append("<money_cr>"+globalBeforeConfirmBean.getPenalty()+"</money_cr>");
							sb.append("<local_money_cr>"+globalBeforeConfirmBean.getPenalty()+"</local_money_cr>");
							sb.append("<notax_cr>"+globalBeforeConfirmBean.getPenalty()+"</notax_cr>");
							sb.append("<local_notax_cr>"+globalBeforeConfirmBean.getPenalty()+"</local_notax_cr>");
							sb.append("<quantity_cr>1</quantity_cr>");
						sb.append(" </item>");
					}
	       if(globalBeforeConfirmBean.getGuarantee_money().equals("0.00")||globalBeforeConfirmBean.getGuarantee_money().equals("0")){
						
					}else{				
					//3保证金	
					sb.append("<item>");
						sb.append("<customer>"+globalBeforeConfirmBean.getCcodetrust()+"</customer>");
						sb.append("<pk_billtype>F2</pk_billtype>");
						sb.append("<billclass>sk</billclass>");
						sb.append("<pk_tradetype>F2-Cxx-03</pk_tradetype>");
						sb.append("<busidate>"+Odateold+"</busidate>");//实际到帐日期
						sb.append("<objtype>0</objtype>");
						sb.append("<direction>1</direction>");
						sb.append("<scomment></scomment>");
						sb.append("<pk_currtype>CNY</pk_currtype>");
						sb.append("<rate>1</rate>");
						sb.append("<recaccount>"+globalBeforeConfirmBean.getReceive_account()+"</recaccount>");
						sb.append("<taxrate>0.00</taxrate>");//24税率
						sb.append("<def18>0.00</def18>");//24税率
						sb.append("<contractno>"+globalBeforeConfirmBean.getContract_id()+"</contractno>");//16合同号
						sb.append("<def5>"+Odate+"</def5>");//10实际到账日期					
						sb.append("<def16>"+(globalBeforeConfirmBean.getRemark_o().equals("营业税")?"1":"2")+"</def16>");//20税种
						sb.append("<pk_deptid>"+globalBeforeConfirmBean.getNcdeptno()+"</pk_deptid>");//====================部门ID
						sb.append("<pk_psndoc>"+globalBeforeConfirmBean.getBcode()+"</pk_psndoc>");//业务员========================业务员(数据同步测试成功)
						sb.append("<prepay>0</prepay>");
		                sb.append("<def6>保证金</def6>");//12款项名称
						sb.append("<def7>870</def7>");//15款项内容
						sb.append("<money_cr>"+globalBeforeConfirmBean.getGuarantee_money()+"</money_cr>");
						sb.append("<local_money_cr>"+globalBeforeConfirmBean.getGuarantee_money()+"</local_money_cr>");
						sb.append("<notax_cr>"+globalBeforeConfirmBean.getGuarantee_money()+"</notax_cr>");
						sb.append("<local_notax_cr>"+globalBeforeConfirmBean.getGuarantee_money()+"</local_notax_cr>");
						sb.append("<quantity_cr>1</quantity_cr>");
					sb.append(" </item>");					
					}
	       if(dsrent>0){
	    	   //1多到租金
				sb.append("<item>");
					sb.append("<customer>"+globalBeforeConfirmBean.getCcodetrust()+"</customer>");
					sb.append("<pk_billtype>F2</pk_billtype>");
					sb.append("<billclass>sk</billclass>");
					sb.append("<pk_tradetype>F2-Cxx-03</pk_tradetype>");
					sb.append("<busidate>"+Odateold+"</busidate>");//实际到帐日期
					sb.append("<objtype>0</objtype>");
					sb.append("<direction>1</direction>");
					sb.append("<scomment></scomment>");
					sb.append("<pk_currtype>CNY</pk_currtype>");
					sb.append("<rate>1</rate>");
					sb.append("<recaccount>"+globalBeforeConfirmBean.getReceive_account()+"</recaccount>");
					sb.append("<taxrate>0.00</taxrate>");//24税率
					sb.append("<def18>0.00</def18>");//24税率
					sb.append("<contractno>"+globalBeforeConfirmBean.getContract_id()+"</contractno>");//16合同号
					sb.append("<def5>"+Odate+"</def5>");//10实际到账日期					
					sb.append("<def16>"+(globalBeforeConfirmBean.getRemark_o().equals("营业税")?"1":"2")+"</def16>");//20税种
					sb.append("<pk_deptid>"+globalBeforeConfirmBean.getNcdeptno()+"</pk_deptid>");//====================部门ID
					sb.append("<pk_psndoc>"+globalBeforeConfirmBean.getBcode()+"</pk_psndoc>");//业务员========================业务员(数据同步测试成功)
					sb.append("<prepay>0</prepay>");
	               sb.append("<def6>多到租金</def6>");//12款项名称
					sb.append("<def7>887</def7>");//15款项内容
					sb.append("<money_cr>"+globalBeforeConfirmBean.getRent_diff()+"</money_cr>");
					sb.append("<local_money_cr>"+globalBeforeConfirmBean.getRent_diff()+"</local_money_cr>");
					sb.append("<notax_cr>"+globalBeforeConfirmBean.getRent_diff()+"</notax_cr>");
					sb.append("<local_notax_cr>"+globalBeforeConfirmBean.getRent_diff()+"</local_notax_cr>");
					sb.append("<quantity_cr>1</quantity_cr>");
				sb.append(" </item>");
	       }else if(dsrent<0){
	    	   //1少到租金
				sb.append("<item>");
					sb.append("<customer>"+globalBeforeConfirmBean.getCcodetrust()+"</customer>");
					sb.append("<pk_billtype>F2</pk_billtype>");
					sb.append("<billclass>sk</billclass>");
					sb.append("<pk_tradetype>F2-Cxx-03</pk_tradetype>");
					sb.append("<busidate>"+Odateold+"</busidate>");//实际到帐日期
					sb.append("<objtype>0</objtype>");
					sb.append("<direction>1</direction>");
					sb.append("<scomment></scomment>");
					sb.append("<pk_currtype>CNY</pk_currtype>");
					sb.append("<rate>1</rate>");
					sb.append("<recaccount>"+globalBeforeConfirmBean.getReceive_account()+"</recaccount>");
					sb.append("<taxrate>0.00</taxrate>");//24税率
					sb.append("<def18>0.00</def18>");//24税率
					sb.append("<contractno>"+globalBeforeConfirmBean.getContract_id()+"</contractno>");//16合同号
					sb.append("<def5>"+Odate+"</def5>");//10实际到账日期					
					sb.append("<def16>"+(globalBeforeConfirmBean.getRemark_o().equals("营业税")?"1":"2")+"</def16>");//20税种	
					sb.append("<pk_deptid>"+globalBeforeConfirmBean.getNcdeptno()+"</pk_deptid>");//====================部门ID
					sb.append("<pk_psndoc>"+globalBeforeConfirmBean.getBcode()+"</pk_psndoc>");//业务员========================业务员(数据同步测试成功)
					sb.append("<prepay>0</prepay>");
	               sb.append("<def6>少到租金</def6>");//12款项名称
					sb.append("<def7>888</def7>");//15款项内容
					sb.append("<money_cr>"+globalBeforeConfirmBean.getRent_diff()+"</money_cr>");
					sb.append("<local_money_cr>"+globalBeforeConfirmBean.getRent_diff()+"</local_money_cr>");
					sb.append("<notax_cr>"+globalBeforeConfirmBean.getRent_diff()+"</notax_cr>");
					sb.append("<local_notax_cr>"+globalBeforeConfirmBean.getRent_diff()+"</local_notax_cr>");
					sb.append("<quantity_cr>1</quantity_cr>");
				sb.append(" </item>");
	       }
	    
	       if(globalBeforeConfirmBean.getNormal_money().equals("0.00")||globalBeforeConfirmBean.getNormal_money().equals("0")){	       	       
	       
	       }else{	    	   	       	     
						//4留购价（残值收入）(要税率)
						sb.append("<item>");
						sb.append("<customer>"+globalBeforeConfirmBean.getCcodetrust()+"</customer>");
						sb.append("<pk_billtype>F2</pk_billtype>");
						sb.append("<billclass>sk</billclass>");
						sb.append("<pk_tradetype>F2-Cxx-03</pk_tradetype>");
						sb.append("<busidate>"+Odateold+"</busidate>");//实际到帐日期
						sb.append("<objtype>0</objtype>");
						sb.append("<direction>1</direction>");
						sb.append("<scomment></scomment>");
						sb.append("<pk_currtype>CNY</pk_currtype>");
						sb.append("<rate>1</rate>");
						sb.append("<recaccount>"+globalBeforeConfirmBean.getReceive_account()+"</recaccount>");
						sb.append("<taxrate>"+globalBeforeConfirmBean.getRemark_2()+"</taxrate>");//24税率
						sb.append("<def18>"+globalBeforeConfirmBean.getRemark_2()+"</def18>");//24税率
						sb.append("<contractno>"+globalBeforeConfirmBean.getContract_id()+"</contractno>");//16合同号
						sb.append("<def5>"+Odate+"</def5>");//10实际到账日期					
						sb.append("<def16>"+(globalBeforeConfirmBean.getRemark_o().equals("营业税")?"1":"2")+"</def16>");//20税种			
						sb.append("<pk_deptid>"+globalBeforeConfirmBean.getNcdeptno()+"</pk_deptid>");//====================部门ID
						sb.append("<pk_psndoc>"+globalBeforeConfirmBean.getBcode()+"</pk_psndoc>");//业务员========================业务员(数据同步测试成功)
						sb.append("<prepay>0</prepay>");
			            sb.append("<def6>残值收入</def6>");//12款项名称
						sb.append("<def7>890</def7>");//15款项内容
						sb.append("<money_cr>"+globalBeforeConfirmBean.getNormal_money()+"</money_cr>");
						sb.append("<local_money_cr>"+globalBeforeConfirmBean.getNormal_money()+"</local_money_cr>");
						sb.append("<notax_cr>"+globalBeforeConfirmBean.getNormal_money()+"</notax_cr>");
						sb.append("<local_notax_cr>"+globalBeforeConfirmBean.getNormal_money()+"</local_notax_cr>");
						sb.append("<quantity_cr>1</quantity_cr>");
					sb.append(" </item>");					
	       }
				/*//5项目结清款
							sb.append("<item>");
							sb.append("<pk_financeorgid>0101</pk_financeorgid>");//
							sb.append("<customer>"+globalBeforeConfirmBean.getCcodetrust()+"</customer>");
							sb.append("<pausetransact></pausetransact>");
							sb.append("<pk_billtype>F2</pk_billtype>");
							sb.append("<billclass>sk</billclass>");
							sb.append("<pk_tradetype>F2-Cxx-03</pk_tradetype>");
							sb.append("<busidate>"+Odateold+"</busidate>");//实际到帐日期
							sb.append("<objtype>0</objtype>");
							sb.append("<direction>1</direction>");
							sb.append("<scomment></scomment>");
							sb.append("<pk_currtype>CNY</pk_currtype>");
							sb.append("<rate>1</rate>");
							sb.append("<recaccount>"+globalBeforeConfirmBean.getReceive_account()+"</recaccount>");
							sb.append("<taxrate>0</taxrate>");//24税率
							sb.append("<def18>0</def18>");//24税率
							sb.append("<contractno>"+globalBeforeConfirmBean.getContract_id()+"</contractno>");//16合同号
							sb.append("<def5>"+Odate+"</def5>");//10实际到账日期					
							sb.append("<def11>"+globalBeforeConfirmBean.getProj_code()+"</def11>");//17项目编号
							sb.append("<def12>"+globalBeforeConfirmBean.getProj_name()+"</def12>");//18项目名称
							sb.append("<def13>"+globalBeforeConfirmBean.getLeas_type()+"</def13>");//23租赁类型
					//		sb.append("<def16>"+globalBeforeConfirmBean.getRemark_o()+"</def16>");//20税种
							sb.append("<pk_deptid>"+globalBeforeConfirmBean.getNcdeptno()+"</pk_deptid>");//====================部门ID
							sb.append("<pk_psndoc>"+globalBeforeConfirmBean.getBcode()+"</pk_psndoc>");//业务员========================业务员(数据同步测试成功)
							sb.append("<prepay>0</prepay>");
					        sb.append("<def6>项目结清款</def6>");//12款项名称
							sb.append("<def7>891</def7>");//15款项内容
							sb.append("<money_cr>"+globalBeforeConfirmBean.getAction_money()+"</money_cr>");
							sb.append("<local_money_cr>"+globalBeforeConfirmBean.getAction_money()+"</local_money_cr>");
							sb.append("<notax_cr>"+globalBeforeConfirmBean.getAction_money()+"</notax_cr>");
							sb.append("<local_notax_cr>"+globalBeforeConfirmBean.getAction_money()+"</local_notax_cr>");
							sb.append("<quantity_cr>1</quantity_cr>");
						sb.append(" </item>");*/
	       if(globalBeforeConfirmBean.getInteret_cha().equals("0.00")||globalBeforeConfirmBean.getInteret_cha().equals("0")){	       	       
	       
	       }else{
					//6利息差额
							sb.append("<item>");
							sb.append("<customer>"+globalBeforeConfirmBean.getCcodetrust()+"</customer>");
							sb.append("<pk_billtype>F2</pk_billtype>");
							sb.append("<billclass>sk</billclass>");
							sb.append("<pk_tradetype>F2-Cxx-03</pk_tradetype>");
							sb.append("<busidate>"+Odateold+"</busidate>");//实际到帐日期
							sb.append("<objtype>0</objtype>");
							sb.append("<direction>1</direction>");
							sb.append("<scomment></scomment>");
							sb.append("<pk_currtype>CNY</pk_currtype>");
							sb.append("<rate>1</rate>");
							sb.append("<recaccount>"+globalBeforeConfirmBean.getReceive_account()+"</recaccount>");
							sb.append("<taxrate>0.00</taxrate>");//24税率
							sb.append("<def18>0.00</def18>");//24税率
							sb.append("<contractno>"+globalBeforeConfirmBean.getContract_id()+"</contractno>");//16合同号
							sb.append("<def5>"+Odate+"</def5>");//10实际到账日期					
							sb.append("<def16>"+(globalBeforeConfirmBean.getRemark_o().equals("营业税")?"1":"2")+"</def16>");//20税种	
							sb.append("<pk_deptid>"+globalBeforeConfirmBean.getNcdeptno()+"</pk_deptid>");//====================部门ID
							sb.append("<pk_psndoc>"+globalBeforeConfirmBean.getBcode()+"</pk_psndoc>");//业务员========================业务员(数据同步测试成功)
							sb.append("<prepay>0</prepay>");
						    sb.append("<def6>利息差额</def6>");//12款项名称
							sb.append("<def7>879</def7>");//15款项内容
							sb.append("<money_cr>"+globalBeforeConfirmBean.getInteret_cha()+"</money_cr>");
							sb.append("<local_money_cr>"+globalBeforeConfirmBean.getInteret_cha()+"</local_money_cr>");
							sb.append("<notax_cr>"+globalBeforeConfirmBean.getInteret_cha()+"</notax_cr>");
							sb.append("<local_notax_cr>"+globalBeforeConfirmBean.getInteret_cha()+"</local_notax_cr>");
							sb.append("<quantity_cr>1</quantity_cr>");
						sb.append(" </item>");
						
	       }
	       if(globalBeforeConfirmBean.getInterest_sr().equals("0.00")||globalBeforeConfirmBean.getInterest_sr().equals("0")){	       	       
	       
	       }else{
                  //利息收入 (要税率)
					sb.append("<item>");
					sb.append("<customer>"+globalBeforeConfirmBean.getCcodetrust()+"</customer>");
					sb.append("<pk_billtype>F2</pk_billtype>");
					sb.append("<billclass>sk</billclass>");
					sb.append("<pk_tradetype>F2-Cxx-03</pk_tradetype>");
					sb.append("<busidate>"+Odateold+"</busidate>");//实际到帐日期
					sb.append("<objtype>0</objtype>");
					sb.append("<direction>1</direction>");
					sb.append("<scomment></scomment>");
					sb.append("<pk_currtype>CNY</pk_currtype>");
					sb.append("<rate>1</rate>");
					sb.append("<recaccount>"+globalBeforeConfirmBean.getReceive_account()+"</recaccount>");
					sb.append("<taxrate>"+globalBeforeConfirmBean.getRemark_2()+"</taxrate>");//24税率
					sb.append("<def18>"+globalBeforeConfirmBean.getRemark_2()+"</def18>");//24税率
					sb.append("<contractno>"+globalBeforeConfirmBean.getContract_id()+"</contractno>");//16合同号
					sb.append("<def5>"+Odate+"</def5>");//10实际到账日期					
					sb.append("<def16>"+(globalBeforeConfirmBean.getRemark_o().equals("营业税")?"1":"2")+"</def16>");//20税种
					sb.append("<pk_deptid>"+globalBeforeConfirmBean.getNcdeptno()+"</pk_deptid>");//====================部门ID
					sb.append("<pk_psndoc>"+globalBeforeConfirmBean.getBcode()+"</pk_psndoc>");//业务员========================业务员(数据同步测试成功)
					sb.append("<prepay>0</prepay>");
					sb.append("<def6>利息收入</def6>");//12款项名称
					sb.append("<def7>860</def7>");//15款项内容
					sb.append("<money_cr>"+globalBeforeConfirmBean.getInterest_sr()+"</money_cr>");
					sb.append("<local_money_cr>"+globalBeforeConfirmBean.getInterest_sr()+"</local_money_cr>");
					sb.append("<notax_cr>"+globalBeforeConfirmBean.getInterest_sr()+"</notax_cr>");
					sb.append("<local_notax_cr>"+globalBeforeConfirmBean.getInterest_sr()+"</local_notax_cr>");
					sb.append("<quantity_cr>1</quantity_cr>");
					sb.append(" </item>");
	       }
			
				sb.append("</bodys>");
			sb.append("</billhead>");
		sb.append("</bill>");
		sb.append("</ufinterface>");
		String xmlMassage = sb.toString();
		System.out.println(xmlMassage);
		return xmlMassage;
	  };
}
