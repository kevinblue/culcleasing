package com.tenwa.culc.calc.util;

import java.util.List;
import com.Tools;
import dbconn.Conn;

/**
 * <p>往租金测算表更新数据的处理方法。</p>
 * @author 小谢
 * <p>Jan 11, 2011</p>
 */
public class Rent_init {
	
	/**
	 * <p>根据传入的条件更新对应的租金偿还计划表。</p>
	 * @author 小谢
	 * @param tableName 表名
	 * @param l_plan_date 偿还日期list
	 * @param l_rent 租金list
	 * @param l_corpus 财务本金list
	 * @param l_interest 财务利息list
	 * @param l_corpus_overage 财务剩余本金list
	 * @param year_rate 年利率
	 * @param l_corpus_market 市场本金list
	 * @param l_interest_market 市场利息list
	 * @param l_corpus_overage_market 市场剩余本金list
	 * @param doc_id 文档编号
	 * @param proj_id 项目编号
	 * @param contract_id 合同编号
	 * @return 更新成功与否 int
	 */
	@SuppressWarnings("unchecked")
	public int init_Rent(String tableName,List l_plan_date,
				List l_rent,List l_corpus,List l_interest,List l_corpus_overage,
				String year_rate,
				List l_corpus_market,List l_interest_market,List l_corpus_overage_market,
				String doc_id,String proj_id,String contract_id){
		int flag = 0;
		String sqlstr = "";
		Conn db = new Conn();
		//项目租金偿还计划更新
		if("fund_rent_plan_proj_temp".equals(tableName)){
			//先删除再更新
			sqlstr = "delete from fund_rent_plan_proj_temp where proj_id='"+proj_id+"' and measure_id='"+doc_id+"'";
			try {
				flag = db.executeUpdate(sqlstr);
				for(int i=0;i<l_rent.size();i++){
					//插入字段顺序:文档编号(测算编号),合同编号,回笼状态,租金,本金,租息,本金余额,年利率
					sqlstr="insert into fund_rent_plan_proj_temp"+
					"(measure_id,proj_id,"+
					"rent_list,plan_date,plan_status,rent,corpus,"+
					"interest,corpus_overage,year_rate,corpus_market,interest_market,corpus_overage_market) "+
					"select '"+doc_id+"','"+proj_id+"',"+(i+1)+","+
					"'"+l_plan_date.get(i)+"','未回笼',"+l_rent.get(i)+","+
					""+l_corpus.get(i)+","+l_interest.get(i)+","+
					""+l_corpus_overage.get(i)+","+year_rate+","+
					l_corpus_market.get(i)+","+l_interest_market.get(i)+","+l_corpus_overage_market.get(i)+" ;";
					//System.out.println("^^^^^^^^^^^^^^^租金添加sql=====> "+sqlstr);
					flag = db.executeUpdate(sqlstr);
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		//合同租金偿还计划更新
		else if("fund_rent_plan_temp".equals(tableName)){
			//租金测算表  fund_rent_plan_temp //测算编号 等于 文档编号
			sqlstr = "delete from fund_rent_plan_temp where contract_id='"+contract_id+"' and measure_id='"+doc_id+"'";
			try {
				db.executeUpdate(sqlstr);
				for(int i=0;i<l_rent.size();i++){
					//插入字段顺序:文档编号(测算编号),合同编号,回笼状态,租金,本金,租息,本金余额,年利率
					sqlstr="insert into fund_rent_plan_temp"+
					"(measure_id,contract_id,"+
					"rent_list,plan_date,plan_status,rent,corpus,"+
					"interest,corpus_overage,year_rate,corpus_market,interest_market,corpus_overage_market) "+
					"select '"+doc_id+"','"+contract_id+"',"+(i+1)+","+
					"'"+l_plan_date.get(i)+"','未回笼',"+l_rent.get(i)+","+
					""+l_corpus.get(i)+","+l_interest.get(i)+","+
					""+l_corpus_overage.get(i)+","+year_rate+","+
					l_corpus_market.get(i)+","+l_interest_market.get(i)+","+l_corpus_overage_market.get(i)+" ;";
					//System.out.println(i+"^^^^^^^^^^^^^^^合同租金测算添加sqlstr2====="+sqlstr);
					db.executeUpdate(sqlstr);
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		else{
			flag = -1;
		}
		db.close();
		return flag;
	}
	
	/**
	 * <p>更新交易结构中的财务IRR和市场IRR。</p>
	 * @author 小谢
	 * @param irr 财务irr
	 * @param Markirr 市场irr
	 * @param proj_id 项目编号
	 * @param doc_id 文档编号
	 * @param contract_id 合同编号
	 * @param tabelNmae 表名
	 * @return 返回更新成功与否 int
	 */
	@SuppressWarnings("static-access")
	public int init_irr(String irr,String Markirr,String proj_id,String doc_id,String contract_id,String tabelNmae){
		int flag = 0;
		Tools tools = new Tools();
		Conn db = new Conn();
		String sqlstr = "";
		try {
			if("proj_condition_temp".equals(tabelNmae)){//项目交易结构
				sqlstr = "update proj_condition_temp set plan_irr="+tools.formatNumberDoubleScale(irr,8)+"*100 where proj_id='"+proj_id+"' and doc_id = '"+doc_id+"' ";
			}else if("contract_condition_temp".equals(tabelNmae)){//合同交易结构
				sqlstr = "update contract_condition_temp set plan_irr="+tools.formatNumberDoubleScale(irr,8)+"*100  where contract_id='"+contract_id+"' and doc_id = '"+doc_id+"'  ";
			}
			flag = db.executeUpdate(sqlstr);	
			System.out.println("更新交易结构irr的sql--》"+sqlstr);
		} catch (Exception e) {
			e.printStackTrace();
		} finally{
			db.close();
		}
		return flag;
	}
}
