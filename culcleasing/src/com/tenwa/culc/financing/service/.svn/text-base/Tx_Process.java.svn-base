/**
 * 
 */
package com.tenwa.culc.financing.service;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import com.Tools;
/**
 * 
 * @author toybaby
 * Date:Oct 17, 20112:38:09 PM       Email: toybaby@mail2.tenwa.com.cn
 */
public class Tx_Process {
	
	/**执行调息
	 * @param drawings_str
	 * @param txId
	 * @param czyid
	 * @return
	 * @throws SQLException
	 */
	@SuppressWarnings("unchecked")
	public int tx_ProcessInfo(String drawings_str,String txId,String czyid) throws SQLException{
		int flag = 0;
		Tx_DataCtrolUtil tx_DataCtrolUtil = new Tx_DataCtrolUtil();//初始化数据库数据处理类
		String [] drawings_list = drawings_str.split("#");//合同编号数组
		Map<String, String> Info_Map = new HashMap<String, String>();  //调息所需基本信息
		List <Map<String, String>> OldRefundPlanList = new ArrayList<Map<String, String>>();//开始期次之后的还款计划
		List <Map<String, String>> NewRefundPlanList = new ArrayList<Map<String, String>>();//开始期次之后的还款计划
		
		for(int i = 0; i<drawings_list.length;i++){
			//第一步:把调息开始期次之前的数据拷入到His表中
			System.out.println("11111111111111111111111");
			tx_DataCtrolUtil.copyRefundPlanIntoHis(drawings_list[i],txId,czyid);
			//第二步：获得调息测算前的测算必须条件
			System.out.println("222222222222222222");
			Info_Map = tx_DataCtrolUtil.getConditionInfo(drawings_list[i],txId);
			System.out.println("3333333333333333");
			//第三步：获得开始期次之后的还款计划
			String start_list = Info_Map.get("rent_list_start");
			System.out.println("开始期数========"+start_list);
			OldRefundPlanList = tx_DataCtrolUtil.getRefundPlan(drawings_list[i], start_list);
			System.out.println("44444444444444444444");
			//第四步:根据基本信息，进行调息计算
			NewRefundPlanList = getNewRefundPlan(Info_Map,OldRefundPlanList);
			System.out.println("555555555555555555");
			//第五步:把调息后的数据拷到His表中
			flag += tx_DataCtrolUtil.copyRentPlanIntoHisAfter(drawings_list[i],NewRefundPlanList,txId,czyid);
			System.out.println("执行成功"+flag+"条");
			System.out.println("6666666666666666");
			//第六步:删除正式表开始期次之后的数据
			tx_DataCtrolUtil.delPlanForCancle(drawings_list[i],start_list);
			System.out.println("777777777777777777");
			//第七步:把调息后的数据从his表拷到正式表
			tx_DataCtrolUtil.copyReFundPlanFromHis(drawings_list[i],start_list,txId);
			System.out.println("8888888888888888");
			//第八步:把调息记录表中的调息状态更新为是
			tx_DataCtrolUtil.updateFundAdjust(drawings_list[i],txId);
			System.out.println("999999999999999999");
			//第九步:调交易结构条件中的年利率更新成最新的年利率
			tx_DataCtrolUtil.updateConditionForProcess(drawings_list[i], txId);
			System.out.println("编号"+drawings_list[i]+"提款 调息成功");
		}
			
			
			
			
			
			
				
		
		return flag;
	}
	
	/**
	 * 计算新的还款计划
	 * @param Info_Map
	 * @param OldRefundPlanList
	 * @return
	 */
	public List<Map<String,String>> getNewRefundPlan(Map<String, String> Info_Map,
			List <Map<String, String>> OldRefundPlanList){
		List<Map<String,String>> RefundPlanList = new ArrayList<Map<String,String>>();//返回的计划
		String after_rate = "";
		String refund_list = "";
		String refund_money = "";
		String refund_corpus = "";
		String refund_interest = "";
		Map<String,String> oldRefundPlanMap = new HashMap<String, String>();
		after_rate = Info_Map.get("after_rate");
		for(int i=0;i<OldRefundPlanList.size();i++){
			Map<String,String> newRefundPlanMap = new HashMap<String, String>();
			oldRefundPlanMap = OldRefundPlanList.get(i);
			refund_corpus = oldRefundPlanMap.get("refund_corpus");//本金
			refund_list = oldRefundPlanMap.get("refund_list");
			refund_interest = Tools.formatNumberDoubleTwo(String.valueOf(Double.parseDouble(refund_corpus)*
					Double.parseDouble(after_rate)*0.01));//利息 
			refund_money = Tools.formatNumberDoubleTwo(String.valueOf(Double.parseDouble(refund_corpus)
					+Double.parseDouble(refund_interest)));//金额
			newRefundPlanMap.put("refund_interest", refund_interest);
			newRefundPlanMap.put("refund_money", refund_money);
			newRefundPlanMap.put("refund_list", refund_list);
			RefundPlanList.add(newRefundPlanMap);//封装返回值
		}
		
		return RefundPlanList; 
	}
	
	/**合同都允许调息撤销时进行撤销
	 * @param contract_str
	 * @param czyid
	 * @return
	 * @throws SQLException
	 */
	public int tx_CancleInfo(String drawings_str,String txId) throws SQLException{
		int flag = 0;
		Tx_DataCtrolUtil tx_DataCtrolUtil = new Tx_DataCtrolUtil();//初始化数据库数据处理类
		System.out.println("drawings_list="+drawings_str);
		String [] drawings_list = drawings_str.split("#");//合同编号数组
		for(int i = 0; i<drawings_list.length;i++){
			//第一步:删除正式表开始期次以后的的数据
			tx_DataCtrolUtil.delPlanForCancle(drawings_list[i], txId);
			//第二步:把his表开始期次以后的数据拷到正式表
			tx_DataCtrolUtil.copPlanForCancle(drawings_list[i], txId);
			//第三步:把financing_drawings的年利率恢复到调息前的年利率
			tx_DataCtrolUtil.updateConditionForCancle(drawings_list[i], txId);
			//第四步:把his表的数据删除
			tx_DataCtrolUtil.delPlanHisForCancle(drawings_list[i], txId);
			//第五步:删除调息记录表的记录
			flag +=tx_DataCtrolUtil.delFundAdjustForCancle(drawings_list[i], txId);
		}
		
		return flag;
	}

	
	
}
