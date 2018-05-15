/**
 * 
 */
package com.tenwa.culc.calc.tx;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import com.tenwa.culc.calc.tx.util.Tx_EqualDiffCorUtil;
import com.tenwa.culc.calc.tx.util.Tx_EqualCorpusUtil;
import com.tenwa.culc.calc.tx.util.Tx_EqualDiffRentUtil;
import com.tenwa.culc.calc.tx.util.Tx_EqualPaymentUtil;
import com.tenwa.culc.calc.tx.util.Tx_EqualRatioCorpusUtil;
import com.tenwa.culc.calc.tx.util.Tx_EqualRatioRentUtil;
import com.tenwa.culc.calc.tx.util.Tx_ImplicitInterestUtil;
import com.tenwa.culc.calc.tx.util.Tx_NotEqualCorpusUtil;
import com.tenwa.culc.calc.tx.util.Tx_NotEqualRentUtil;
import com.tenwa.culc.calc.tx.util.Tx_SettleLawUtil;

/**
 * 不规则调息入口
 * @author toybaby
 * Date:Aug 8, 2016-06-26      Email: toybaby@mail2.tenwa.com.cn
 */
public class Tx_Process_BGZ {
	
	/*public static void main(String[] args) {
		Tx_Process_BGZ Tx_Process_BGZ =	new Tx_Process_BGZ();
		try {
			//Tx_Process_BGZ.tx_ProcessInfo("15CULC082828L57", "15CULC082828L5796", "RentCalcType10", "129", "admin", "次期");
			Tx_Process_BGZ.tx_CancleInfo("13CULC202173L58","13CULC202173L5847","129","次日");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}*/
	
	
	/**执行调息
	 * @param contract_str
	 * @param settle_str
	 * @param txId
	 * @param czyid
	 * @return
	 * @throws SQLException
	 */
	@SuppressWarnings("unchecked")
	public int tx_ProcessInfo(String contract_str,String begin_str,String settle_str,
					String txId,String czyid,String adjust_style_str) throws SQLException{
		int flag = 0;
		Tx_DataCtrolUtil_BGZ tx_DataCtrolUtil = new Tx_DataCtrolUtil_BGZ();//初始化数据库数据处理类
		Tx_RentInfoBox rentInfoBox = null;//封装租金计划bean
		String [] contract_list = contract_str.split("#");//合同编号数组
		String [] begin_id  = begin_str.split("#");//合同编号数组
		String [] settle_method_list = settle_str.split("#");//测算方法
		String [] adjust_style = adjust_style_str.split("#");//调息方式
		Map<String, String> condition_Map = new HashMap<String, String>(); 

		for(int i = 0; i<contract_list.length;i++){
			/**
			 *=================================
			 * 预留部分接口处，次日次期判断条件不同（暂时只处理次期）
			 * if(次期){  （由于次期的占大多数，所以次期优先）
			 * 次期算法
			 * }
			 * else if("次日"){
			 * 	1.当期的单独处理，次期的整个过程都要单独改写，留意当期的特殊情况
			 *  2.次日中的特例：只有最后一期时，次日只能单独处理，不再调用次期的方法计算租金
			 * 次日算法
			 * }
			 * ================================
			 */	
			if("次期".equals(adjust_style[i])){
			
					//第一步:把调息开始期次之前的数据拷入到His表中
					tx_DataCtrolUtil.copyRentPlanIntoHis(contract_list[i],begin_id[i],txId,czyid);
					//第二步：获得调息测算前的测算商务条件
					condition_Map = tx_DataCtrolUtil.getConditionInfo(contract_list[i],begin_id[i],txId);
					
					String rate_float_type = condition_Map.get("rate_float_type");//利率浮动类型
					if("2".equals(rate_float_type)){//隐含利率调息
						Tx_ImplicitInterestUtil tx_ImplicitInterestUtil=new Tx_ImplicitInterestUtil();
						//第三步 调用相应的算法进行计算调息后的租金计划数据
						rentInfoBox = tx_ImplicitInterestUtil.getRentInfoBox(contract_list[i], begin_id[i],settle_method_list[i], condition_Map);
						//第四步:把调息后的数据拷到His表中
						//			System.out.println("开始期数========"+rent_list_start);
						flag += tx_DataCtrolUtil.copyRentPlanIntoHisAfterForImp(contract_list[i],begin_id[i],rentInfoBox,condition_Map,txId,czyid);
						//System.out.println("执行成功"+flag+"条");
						//第五步:删除正式表开始期次之后的数据
						int rent_list_start = Integer.parseInt(condition_Map.get("rent_list_start"));//开始期数
									
						tx_DataCtrolUtil.delRentPlanAfter(contract_list[i],begin_id[i],rent_list_start);
						//第六步:把调息后的数据从his表拷到正式表
						tx_DataCtrolUtil.copyRentPlanFromHis(contract_list[i],begin_id[i],txId);
						//第七步:把调息记录表中的调息状态更新为是
						tx_DataCtrolUtil.updateFundAdjust(contract_list[i],begin_id[i],txId);				
					}else{//非隐含利率调息
						//第三步:根本不同的测算方式，调用相应的算法进行计算调息后的租金计划数据
						rentInfoBox = choiceSettleMethod(contract_list[i],begin_id[i],settle_method_list[i],condition_Map,txId);
						//第四步:把调息后的数据拷到His表中
			//			System.out.println("开始期数========"+rent_list_start);
						flag += tx_DataCtrolUtil.copyRentPlanIntoHisAfter(contract_list[i],begin_id[i],rentInfoBox,condition_Map,txId,czyid);
			//			System.out.println("执行成功"+flag+"条");
						//第五步:删除正式表开始期次之后的数据
						int rent_list_start = Integer.parseInt(condition_Map.get("rent_list_start"));//开始期数
						tx_DataCtrolUtil.delRentPlanAfter(contract_list[i],begin_id[i],rent_list_start);
						//第六步:把调息后的数据从his表拷到正式表
						tx_DataCtrolUtil.copyRentPlanFromHis(contract_list[i],begin_id[i],txId);
						//第七步:把调息记录表中的调息状态更新为是
						tx_DataCtrolUtil.updateFundAdjust(contract_list[i],begin_id[i],txId);
						//第八步:调交易结构条件中的年利率更新成最新的年利率
						tx_DataCtrolUtil.updateConditionForProcess(contract_list[i],begin_id[i], txId);
						}
						System.out.println("合同"+contract_list[i]+" 调息成功");
		}else if("次日".equals(adjust_style[i])){//次日的算法
			 //	1.当期的单独处理，次期的整个过程都要单独改写，留意当期的特殊情况
			 // 2.次日中的特例：只有最后一期时，次日只能单独处理，不再调用次期的方法计算租金
			 // 3.第一期的次日调息也需单独考虑
			//################
			//综合考虑，采取调息方案为先进行正常的次期的调息，完成后，然后对开始期次的那一期进行更新操作。
			//因为考虑到第一期的情况，故剩余本金采用当初的剩余本金+当期的本金，再乘以调息前后的利率差，
			//再加上当初原始的利息，即得到正确的调息值，租金再更新一下
			//但是，在执行次期操作的时候，需要排除掉剩最后一期的特例
			//开始期次的另一种特例，如果开始期次已核销，并且不是最大期次，则直接执行次期。
			//############################################################################
			//次日在第一部之前多增一步，查询第一期是否是第一期，如果是第一期，调过次期的步骤，直接执行次日步骤
			int max_list = tx_DataCtrolUtil.getMaxRentList(begin_id[i]);
			//第一步:把调息开始期次之前的数据拷入到His表中
			tx_DataCtrolUtil.copyRentPlanIntoHis(contract_list[i],begin_id[i],txId,czyid);
			//第二步：获得调息测算前的测算商务条件
			condition_Map = tx_DataCtrolUtil.getConditionInfo(contract_list[i],begin_id[i],txId);
			int rent_list_start = Integer.parseInt(condition_Map.get("rent_list_start"));//开始期数
			String rate_float_type = condition_Map.get("rate_float_type");//利率浮动类型
			//非最后一期或是
			if(max_list!=rent_list_start){
			if("2".equals(rate_float_type)){//隐含利率调息
				Tx_ImplicitInterestUtil tx_ImplicitInterestUtil=new Tx_ImplicitInterestUtil();
				//第三步 调用相应的算法进行计算调息后的租金计划数据
				rentInfoBox = tx_ImplicitInterestUtil.getRentInfoBox(contract_list[i], begin_id[i],settle_method_list[i], condition_Map);
				//第四步:把调息后的数据拷到His表中
				//			System.out.println("开始期数========"+rent_list_start);
				flag += tx_DataCtrolUtil.copyRentPlanIntoHisAfterForImp(contract_list[i],begin_id[i],rentInfoBox,condition_Map,txId,czyid);
				//System.out.println("执行成功"+flag+"条");
				//第五步:删除正式表开始期次之后的数据
							
				tx_DataCtrolUtil.delRentPlanAfter(contract_list[i],begin_id[i],rent_list_start);
				//第六步:把调息后的数据从his表拷到正式表
				tx_DataCtrolUtil.copyRentPlanFromHis(contract_list[i],begin_id[i],txId);
				//第七步:把调息记录表中的调息状态更新为是
				tx_DataCtrolUtil.updateFundAdjust(contract_list[i],begin_id[i],txId);				
			}else{//非隐含利率调息
				//第三步:根本不同的测算方式，调用相应的算法进行计算调息后的租金计划数据
				rentInfoBox = choiceSettleMethod(contract_list[i],begin_id[i],settle_method_list[i],condition_Map,txId);
				//第四步:把调息后的数据拷到His表中
	//			System.out.println("开始期数========"+rent_list_start);
				flag += tx_DataCtrolUtil.copyRentPlanIntoHisAfter(contract_list[i],begin_id[i],rentInfoBox,condition_Map,txId,czyid);
	//			System.out.println("执行成功"+flag+"条");
				//第五步:删除正式表开始期次之后的数据
				
				tx_DataCtrolUtil.delRentPlanAfter(contract_list[i],begin_id[i],rent_list_start);
				//第六步:把调息后的数据从his表拷到正式表
				tx_DataCtrolUtil.copyRentPlanFromHis(contract_list[i],begin_id[i],txId);
				//第七步:把调息记录表中的调息状态更新为是
				tx_DataCtrolUtil.updateFundAdjust(contract_list[i],begin_id[i],txId);
				//第八步:调交易结构条件中的年利率更新成最新的年利率
				tx_DataCtrolUtil.updateConditionForProcess(contract_list[i],begin_id[i], txId);
				}
			//次期部分结束
			}
			/*开始单独处理次日部分
			 * 如果 开始期次 已回笼，当次日不再做处理
			 * 次日产生的利息计算公式：
			 * （当期的剩余本金+当期的本金）*（当期计划日期-调息日期）*（调息后利率-调息前利率）
			 * 
			 */
			//先判断当期是否已产生回笼值
			String is_hire = tx_DataCtrolUtil.getIsRentHire(begin_id[i],rent_list_start);
			System.out.println("当期是否已产生回笼值======"+is_hire);
			if("否".equals(is_hire)){//当期未回笼时执行次日调息的内容
			double adjust_interest=0.00;
			//获得调息当期的利息增加值
			adjust_interest = tx_DataCtrolUtil.getAdjust_Interest(begin_id[i],rent_list_start,txId);
			System.out.println("起租编号为"+begin_id[i]+"的项目的第"+rent_list_start+"期增加"+adjust_interest);
			//更新his表中调息后的当期的利息值
			tx_DataCtrolUtil.updateRentAfterHis(begin_id[i],adjust_interest,rent_list_start,txId);
			tx_DataCtrolUtil.updateRentAfter(begin_id[i],adjust_interest,rent_list_start);
			//更新正式中表调息后的当期的利息值
			}
				System.out.println("合同"+contract_list[i]+" 调息成功");
		}else if("次年".equals(adjust_style[i])){
			//*****注意：次年调息逻辑上，可理解为调息日下一年，一月一号开始的次日调息，故也走跟次日相同方法，只是分配操作时将开始期次改为下一年的第一期*****
			//############################################################################
			//查询第一期是否是第一期，如果是第一期，调过次期的步骤，直接执行次日步骤
			int max_list = tx_DataCtrolUtil.getMaxRentList(begin_id[i]);
			//第一步:把调息开始期次之前的数据（包括开始期次）拷入到His表中
			tx_DataCtrolUtil.copyRentPlanIntoHis(contract_list[i],begin_id[i],txId,czyid);
			//第二步：获得调息测算前的测算商务条件
			condition_Map = tx_DataCtrolUtil.getConditionInfo(contract_list[i],begin_id[i],txId);
			int rent_list_start = Integer.parseInt(condition_Map.get("rent_list_start"));//开始期数
			String rate_float_type = condition_Map.get("rate_float_type");//利率浮动类型
			//非最后一期或是
			if(max_list!=rent_list_start){
			    //非隐含利率调息
				if("-1".equals(condition_Map.get("rent_list_start"))){//次年没有期次的情况
					tx_DataCtrolUtil.copyRentPlanAllIntoHis(contract_list[i],begin_id[i],txId,czyid);
					//第七步:把调息记录表中的调息状态更新为是
					tx_DataCtrolUtil.updateFundAdjust(contract_list[i],begin_id[i],txId);
					//第八步:调交易结构条件中的年利率更新成最新的年利率
					tx_DataCtrolUtil.updateConditionForProcess(contract_list[i],begin_id[i], txId);
					flag +=1;
					continue;
				}else{
					//第三步:根本不同的测算方式，调用相应的算法进行计算调息后的租金计划数据
					rentInfoBox = choiceSettleMethod(contract_list[i],begin_id[i],settle_method_list[i],condition_Map,txId);
					//第四步:把调息后的数据拷到His表中
		//			System.out.println("开始期数========"+rent_list_start);
					flag += tx_DataCtrolUtil.copyRentPlanIntoHisAfter(contract_list[i],begin_id[i],rentInfoBox,condition_Map,txId,czyid);
		//			System.out.println("执行成功"+flag+"条");
					//第五步:删除正式表开始期次之后的数据
					tx_DataCtrolUtil.delRentPlanAfter(contract_list[i],begin_id[i],rent_list_start);
					//第六步:把调息后的数据从his表拷到正式表
					tx_DataCtrolUtil.copyRentPlanFromHis(contract_list[i],begin_id[i],txId);
					//第七步:把调息记录表中的调息状态更新为是
					tx_DataCtrolUtil.updateFundAdjust(contract_list[i],begin_id[i],txId);
					//第八步:调交易结构条件中的年利率更新成最新的年利率
					tx_DataCtrolUtil.updateConditionForProcess(contract_list[i],begin_id[i], txId);
				}
			//次期部分结束
			}
			/*开始单独处理次日部分
			 * 如果 开始期次 已回笼，当次日不再做处理
			 * 次日产生的利息计算公式：
			 * （当期的剩余本金+当期的本金）*（当期计划日期-调息日期）*（调息后利率-调息前利率）
			 * 
			 */
			//先判断当期是否已产生回笼值
			String is_hire = tx_DataCtrolUtil.getIsRentHire(begin_id[i],rent_list_start);
			System.out.println("当期是否已产生回笼值======"+is_hire);
			if("否".equals(is_hire)){//当期未回笼时执行次日调息的内容
			double adjust_interest=0.00;
			//获得调息当期的利息增加值
			adjust_interest = tx_DataCtrolUtil.getAdjust_Interest2(begin_id[i],rent_list_start,txId);
			System.out.println("起租编号为"+begin_id[i]+"的项目的第"+rent_list_start+"期增加"+adjust_interest);
			//更新his表中调息后的当期的利息值
			tx_DataCtrolUtil.updateRentAfterHis(begin_id[i],adjust_interest,rent_list_start,txId);
			//更新正式中表调息后的当期的利息值
			tx_DataCtrolUtil.updateRentAfter(begin_id[i],adjust_interest,rent_list_start);
			}
				System.out.println("合同"+contract_list[i]+" 调息成功");
		
		}
		
	}
		
		
		
		
		
		return flag;
	}
	
	/**
	 * 根本不同的租金测算式，进行租金测算
	 * @param contract_id
	 * @param settle_method
	 * @throws SQLException 
	 */
	@SuppressWarnings("unchecked")
	public Tx_RentInfoBox choiceSettleMethod(String contract_id,String begin_id,String settle_method,Map condition_Map,String txId) throws SQLException{
		Tx_RentInfoBox rentInfoBox = null;
		if ("RentCalcType1".equals(settle_method)) {// 等额租金
			System.out.println("进入"+contract_id+"等额租金的调息测算");
			rentInfoBox = Tx_EqualPaymentUtil.getRentInfoBox(condition_Map);
		} else if ("RentCalcType2".equals(settle_method)) {// 等差租金
			System.out.println("进入"+contract_id+"等差租金的调息测算");
			rentInfoBox = Tx_EqualDiffRentUtil.getRentInfoBox(condition_Map);
		} else if ("RentCalcType3".equals(settle_method)) {// 等比租金
			System.out.println("进入"+contract_id+"等比租金的调息测算");
			rentInfoBox = Tx_EqualRatioRentUtil.getRentInfoBox(condition_Map);
		} else if ("RentCalcType4".equals(settle_method)) {// 等额本金
			System.out.println("进入"+contract_id+"等额本金的调息测算");
			rentInfoBox = Tx_EqualCorpusUtil.getRentInfoBox(condition_Map);
		} else if ("RentCalcType5".equals(settle_method)) {// 等差本金
			System.out.println("进入"+contract_id+"等差本金的调息测算");
			rentInfoBox = Tx_EqualDiffCorUtil.getRentInfoBox(contract_id,begin_id,condition_Map);
		} else if ("RentCalcType6".equals(settle_method)) {// 等比本金
			System.out.println("进入"+contract_id+"等比本金的调息测算");
			rentInfoBox = Tx_EqualRatioCorpusUtil.getRentInfoBox(condition_Map);
		} else if ("RentCalcType7".equals(settle_method)) {// 均息法
			System.out.println("进入"+contract_id+"均息法的调息测算");
			rentInfoBox = Tx_SettleLawUtil.getRentInfoBox(contract_id,begin_id,condition_Map);
		} else if ("RentCalcType9".equals(settle_method)) {// 不等额本金
			System.out.println("进入"+contract_id+"不等额本金的调息测算");
			rentInfoBox = Tx_NotEqualCorpusUtil.getRentInfoBox(contract_id,begin_id,condition_Map);
		}else if ("RentCalcType8".equals(settle_method)) {// 不等额租金
			System.out.println("进入"+contract_id+"不等额租金的调息测算");
			rentInfoBox = Tx_NotEqualRentUtil.getRentInfoBox(contract_id,begin_id,condition_Map,txId);
		}else if ("RentCalcType10".equals(settle_method)) {// 不等额租金
			System.out.println("进入"+contract_id+"不规则的调息测算");
			rentInfoBox = Tx_NotEqualRentUtil.getRentInfoBox(contract_id,begin_id,condition_Map,txId);
		}
		System.out.println("合同"+contract_id+"测算完成");
		return rentInfoBox;
	}
	
	/**合同都允许调息撤销时进行撤销
	 * @param contract_str
	 * @param czyid
	 * @return
	 * @throws SQLException
	 */
	public int tx_CancleInfo(String contract_str,String begin_str,String txId,String adjust_style_str) throws SQLException{
		int flag = 0;
		Tx_DataCtrolUtil_BGZ tx_DataCtrolUtil = new Tx_DataCtrolUtil_BGZ();//初始化数据库数据处理类
		System.out.println("contract_list="+contract_str+"     begin_id="+begin_str);
		String [] contract_list = contract_str.split("#");//合同编号数组
		String [] begin_id = begin_str.split("#");//起租编号数组
		String [] adjust_style = adjust_style_str.split("#");//调息方式
		/**
		 *=================================
		 * 预留部分接口处，次日次期判断条件不同（暂时只处理次期）
		 * if("次日"){
		 * 次日时撤销有不同之处，在于当初的处理方式的不同
		 * 次日算法
		 * }
		 * else{
		 * 次期算法
		 *  同调息执行：在撤销的时候，仍可维持原来的，只是需要单独再把当期的进行恢复一下
		 * }
		 * ================================
		 */	
		
		for(int i = 0; i<contract_list.length;i++){
			//第一步:删除正式表开始期次以后的的数据
			tx_DataCtrolUtil.delPlanForCancle(contract_list[i],begin_id[i], txId);
			//第二步:把his表开始期次以后的数据拷到正式表
			tx_DataCtrolUtil.copPlanForCancle(contract_list[i],begin_id[i], txId);
			//第三步:把begin_info的年利率恢复到调息前的年利率
			tx_DataCtrolUtil.updateConditionForCancle(contract_list[i],begin_id[i], txId);
			//新增加一步：如果次日，当期单独进行更新
			if("次日".equals(adjust_style[i])||"次年".equals(adjust_style[i])){
				tx_DataCtrolUtil.updateRentAfterCancle(begin_id[i],txId);
			}
			//第四步:把his表的数据删除
			tx_DataCtrolUtil.delPlanHisForCancle(contract_list[i],begin_id[i], txId);
			//第五步:删除调息记录表的记录
			flag +=tx_DataCtrolUtil.delFundAdjustForCancle(contract_list[i],begin_id[i], txId);
			//tx_DataCtrolUtil.delPlanHisForCancle(contract_list[i], begin_id[i], txId);
		    //flag += tx_DataCtrolUtil.delFundAdjustForCancle(contract_list[i], begin_id[i], txId);
		}
		
		return flag;
	}

	
	
}
