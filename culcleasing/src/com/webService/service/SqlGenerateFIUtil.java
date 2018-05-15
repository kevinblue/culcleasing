/**
 * com.tenwa.datasync.finance.service
 */
package com.webService.service;

import com.tenwa.culc.util.CommonTool;
import com.webService.bean.GlobalBjjsBean;
import com.webService.bean.GlobalFundPlanBean;
import com.webService.bean.GlobalInterestBean;
import com.webService.bean.GlobalInterestSubsidyBean;
import com.webService.bean.GlobalPaiedBean;
import com.webService.bean.GlobalProjectEndBean;
import com.webService.bean.GlobalReceiveBean;
import com.webService.bean.GlobalStartRentBean;


/**
 * Sql语句生成工具
 * 
 * @author Jaffe
 * 
 * Date:Sep 12, 2011 9:00:00 PM Email:JaffeHe@hotmail.com
 */
/**
 * @author toybaby Date:Sep 15, 20114:31:15 PM Email: toybaby@mail2.tenwa.com.cn
 */
public class SqlGenerateFIUtil {

	/**
	 * 数据库同步日志保存
	 * 
	 * @param oper_id
	 * @param amount
	 * @param syncType
	 * @return
	 */
	public static String generateFIDataSyncDBLog(String oper_id, int amount,
			String oper_type, String oper_name, String oper_remark) {
		// 1Buffer对象
		StringBuffer sqlStr = new StringBuffer();
		// 2拼接sql
		sqlStr
				.append("Insert into FI_ERP_DATA_SYNC_LOG_NC(oper_id,oper_type,oper_name,oper_remark,oper_date,amount)");

		sqlStr.append(" values('" + oper_id + "','" + oper_type + "','"
				+ oper_name + "','" + oper_remark + "','"
				+ CommonTool.getSysDate("yyyy-MM-dd HH:mm:dd") + "','" + amount
				+ "')");
		// 3返回
		return sqlStr.toString();
	}

	/**
	 * 数据同步数据日志
	 * 
	 * @param oper_id
	 * @param priId
	 * @param syncType
	 * @return
	 */
	public static String generateFIDataSyncDBInfo(String pri_id, String para_2,
			String para_3, String para_4,String para_5, String oper_id, String table_type) {
		// 1Buffer对象
		StringBuffer sqlStr = new StringBuffer();
		// 2拼接sql
		sqlStr
				.append(
						"Insert into FI_ERP_DATA_SYNC_INFO_NC(pri_id,para_2,para_3,para_4,para_5,oper_id,table_type,create_date)")
				.append(
						"values('"  +pri_id + "','" + para_2 + "','" + para_3
								+ "','" + para_4 +"','" + para_5 + "','" + oper_id + "','"
								+ table_type + "',getdate())");
		// 3返回
		return sqlStr.toString();
	}

	/**
	 * 查询ERP 数据库 国内收款单操作
	 * 
	 * @return
	 */
	public static String generateSelectERPGlobalReceiveData() {
		// 1Buffer对象
		StringBuffer sqlStr = new StringBuffer();
		// 2拼接sql
		
		
		//2.1正式
 //sqlStr.append("SELECT * FROM vi_INTERFACE_fina_global_receive_nc WHERE convert(varchar(10),odate,21)>='2017-09-01' ");
 sqlStr.append("SELECT * FROM vi_INTERFACE_fina_global_receive_nc WHERE convert(varchar(10),odate,21)>='2017-09-01' ");
		sqlStr.append("and  isnull(invcode,'')<>'' ");
		sqlStr.append("and isnull(invtype,'')<>''");
		//2.2测试
		//sqlStr.append("SELECT * FROM vi_INTERFACE_fina_global_receive_nc WHERE isnull(invcode,'')<>''and ");
		//sqlStr.append(" isnull(bcode,'')<>'' AND ISNULL(ccode,'')<>'' and isnull(invtype,'')<>''");
		//sqlStr.append(" and ccode<>'null' and nc_deptno<>'' and id = 407 or id =9326 or id=9337 or id ='29343'or id='1243'or id='6254' or id='7793' or id='8017'  or id='8058' or id='8514' or id='7835'");			
	    //sqlStr.append("or id ='15166 ' or id='15167' or id='15168' or id='15169' or id='15488'  or id ='15489' or id='15490' or id='15552' or id='39167'  or id='39274' or id='10062'  or id= '6357' or id='11649' or id='6819' or id='6158'");
 
	
		// 3返回
		return sqlStr.toString();
	}
   
	/**
	 * 查询ERP 数据库  提前终止收款单操作
	 * 
	 * @return
	 */
	public static String generateSelectERPBeforeConfirmData() {
		// 1Buffer对象
		StringBuffer sqlStr = new StringBuffer();
		// 2拼接sql
		sqlStr
				.append("SELECT * FROM vi_INTERFACE_before_confirm_nc");
		// 3返回
		return sqlStr.toString();
	}
	/**
	 * 查询ERP 数据库 起租信息操作
	 * 
	 * @return
	 */
	public static String generateSelectERPGlobalStartRentData() {
		// 1Buffer对象
		StringBuffer sqlStr = new StringBuffer();
		// 2拼接sql
		sqlStr
				.append("SELECT * FROM vi_INTERFACE_fina_global_start_rent where isnull(invcode,'')<>'' and isnull(ccodetrust,'')<>'' "
						+ "and isnull(ccode,'')<>'' and isnull(bcode,'')<>'' and isnull(invtype,'')<>''");
		// 3返回
		return sqlStr.toString();
	}
	/**
	 * 查询ERP 数据库 起租信息操作
	 * 
	 * @return
	 */
	public static String generateSelectERPGlobalStartRentData1() {
		// 1Buffer对象
		StringBuffer sqlStr = new StringBuffer();
		// 2拼接sql
		//2.1正式环境
		/**sqlStr.append("SELECT * FROM vi_INTERFACE_fina_global_start_rent_nc where convert(varchar(10),odate,21)>='2017-09-01' and isnull(invcode,'')<>'' and isnull(ccodetrust,'')<>'' "
				+ "and isnull(ccode,'')<>''  and isnull(invtype,'')<>''");
				*/
		//2.2测试环境
		sqlStr.append("SELECT * FROM vi_INTERFACE_fina_global_start_rent_nc where   convert(varchar(10),odate,21)>='2017-09-01'   and isnull(invcode,'')<>'' and isnull(ccodetrust,'')<>'' and isnull(ccode,'')<>''  and isnull(invtype,'')<>''");
		// 3返回
		return sqlStr.toString();
	}
	/**
	 * 查询ERP 数据库 利息计算表信息操作
	 * 
	 * @return
	 */
	public static String generateSelectERPGlobalInterestData() {
		// 1Buffer对象
		StringBuffer sqlStr = new StringBuffer();
		// 2拼接sql
		sqlStr.append("SELECT * FROM vi_INTERFACE_fina_global_interest_nc where ")
	.append("isnull(invcode,'')<>''and isnull(invtype,'')<>'' and id in ('1890893')"); //"id in ('1818189','1818193')"测试增加条件
		
//.append("isnull(invcode,'')<>''and isnull(bcode,'')<>'' and isnull(invtype,'')<>'' and id in ('1890893')"); //"id in ('1818189','1818193')"测试增加条件
		// 3返回
		return sqlStr.toString();
	}
	/**
	 * 查询ERP 数据库 本金计税表信息操作
	 * 
	 * @return
	 */
	public static String generateSelectERPGlobalBjjsData(String sqlIds) {
		// 1Buffer对象
		StringBuffer sqlStr = new StringBuffer();
		// 2拼接sql
		sqlStr
				.append("SELECT * FROM vi_INTERFACE_fina_global_bjjs where isnull(invcode,'')<>'' "
						+ "and isnull(ccode,'')<>'' and isnull(bcode,'')<>'' and isnull(invtype,'')<>'' and id in ("+sqlIds+")");
		// 3返回
		return sqlStr.toString();
	}
	
	/**
	 * 查询ERP 数据库 本金计税表信息操作
	 * 
	 * @return
	 */
	public static String generateSelectERPGlobalBjjsDataNc(String sqlIds) {
		// 1Buffer对象
		StringBuffer sqlStr = new StringBuffer();
		// 2拼接sql
		sqlStr
				.append("SELECT * FROM vi_INTERFACE_fina_global_bjjs_nc where isnull(invcode,'')<>'' "
						+ " and isnull(bcode,'')<>'' and isnull(invtype,'')<>'' and id in ("+sqlIds+")");
		// 3返回
		return sqlStr.toString();
	}
	/**
	 * 查询ERP 数据库 本金计税(营业税)表信息操作
	 * 
	 * @return
	 */
	public static String generateSelectERPGlobalBjjsYYData(String sqlIds) {
		// 1Buffer对象
		StringBuffer sqlStr = new StringBuffer();
		// 2拼接sql
		sqlStr
				.append("SELECT * FROM vi_INTERFACE_fina_global_bjjs_YY_nc where isnull(invcode,'')<>'' "
						+ " and isnull(bcode,'')<>'' and isnull(invtype,'')<>'' and id in ("+sqlIds+")");
		// 3返回
		return sqlStr.toString();
	}
	/**
	 * 查询ERP 数据库 利息计税表信息操作
	 * 
	 * @return
	 */
	public static String generateSelectERPGlobalLxjsData(String sqlIds) {
		// 1Buffer对象
		StringBuffer sqlStr = new StringBuffer();
		// 2拼接sql
		sqlStr
				.append("SELECT * FROM vi_INTERFACE_fina_global_lxjs_nc where isnull(invcode,'')<>'' "
						+ " and isnull(bcode,'')<>'' and isnull(invtype,'')<>'' and id in ("+sqlIds+")");
		// 3返回
		return sqlStr.toString();
	}
	/**
	 * 查询ERP 数据库 利息计税(营业税)表信息操作
	 * 
	 * @return
	 */
	public static String generateSelectERPGlobalLxjsYYData(String sqlIds) {
		// 1Buffer对象
		StringBuffer sqlStr = new StringBuffer();
		// 2拼接sql
		sqlStr
				.append("SELECT * FROM vi_INTERFACE_fina_global_lxjs_YY_nc where isnull(invcode,'')<>'' "
						+ " and isnull(bcode,'')<>'' and isnull(invtype,'')<>'' and id in ("+sqlIds+")");
		// 3返回
		return sqlStr.toString();
	}
	/**
	 * 查询ERP 数据库 资金收付计划表操作
	 * 
	 * @return
	 */
	public static String generateSelectERPGlobalFundPlanData() {
		// 1Buffer对象
		StringBuffer sqlStr = new StringBuffer();
		// 2拼接sql
		sqlStr
				.append("SELECT * FROM vi_INTERFACE_fina_global_fundplan WHERE isnull(invcode,'')<>'' "
						+ "AND isnull(ccode,'')<>'' AND isnull(ccodetrust,'')<>'' and isnull(bcode,'')<>'' and isnull(invtype,'')<>'' and ccodetrust<>'null'");

		// 3返回
		return sqlStr.toString();
	}
	/**
	 * 查询ERP 数据库 资金收付计划表操作
	 * 
	 * @return
	 */
	public static String generateSelectERPGlobalFundPlanData1() {
		// 1Buffer对象
		StringBuffer sqlStr = new StringBuffer();
		// 2拼接sql
		/*sqlStr
				.append("SELECT * FROM vi_INTERFACE_fina_global_fundplan_nc WHERE isnull(invcode,'')<>'' "
						+ "AND isnull(ccode,'')<>'' AND isnull(ccodetrust,'')<>'' and nc_deptno<>'' and isnull(bcode,'')<>'' and isnull(invtype,'')<>'' and ccodetrust<>'null'");
*/
		sqlStr.append("SELECT * FROM vi_INTERFACE_fina_global_fundplan_nc WHERE ")  
        .append("convert(varchar(10),odate,21)>='2017-09-01'")  
		 .append("and isnull(invcode,'')<>'' AND isnull(ccodetrust,'')<>'' and isnull(bcode,'')<>'' and isnull(invtype,'')<>'' and ccodetrust<>'null'");

		
		/*if("many".equals(projid)){
			sqlStr.append("SELECT * FROM vi_INTERFACE_fina_global_fundplan_nc WHERE  id<14 and isnull(invcode,'')<>'' "
					+ "AND isnull(ccode,'')<>'' AND isnull(ccodetrust,'')<>''  and isnull(invtype,'')<>'' and ccodetrust<>'null'");
		}else{
			sqlStr.append("SELECT * FROM vi_INTERFACE_fina_global_fundplan_nc WHERE  picode='"+projid+"' and isnull(invcode,'')<>'' "
					+ "AND isnull(ccode,'')<>'' AND isnull(ccodetrust,'')<>''  and isnull(invtype,'')<>'' and ccodetrust<>'null'");
		}*/
		
		// 3返回
		return sqlStr.toString();
	}

	/**
	 * 查询ERP 数据库 确认利息补贴表操作
	 * 
	 * @return
	 */
	public static String generateSelectERPGlobalInterestSubsidyData() {
		// 1Buffer对象
		StringBuffer sqlStr = new StringBuffer();
		// 2拼接sql
		sqlStr.append("SELECT  * FROM vi_INTERFACE_fina_global_interestSubsidy_nc where ")
				.append("convert(varchar(10),sub_date,21)>='2017-09-01'") 
.append("and isnull(invcode,'')<>''  and isnull(bcode,'')<>'' and nc_deptno<>'' and isnull(invtype,'')<>''");
		// 3返回
		return sqlStr.toString();
	}

	/**
	 * 查询ERP 数据库 合同结清表操作
	 * 
	 * @return
	 */
	public static String generateSelectERPGlobalProjectEndData() {
		// 1Buffer对象
		StringBuffer sqlStr = new StringBuffer();
		// 2拼接sql - 客户代码或者项目经理代码不能为空
		sqlStr
				.append("SELECT * FROM vi_INTERFACE_fina_global_htjq WHERE isnull(ccodetrust,'')<>''  AND isnull(bcode,'')<>'' "
						+ "and isnull(invcode,'')<>'' and isnull(ccode,'')<>'' and isnull(invtype,'')<>'' ");
		// 3返回
		return sqlStr.toString();
	}
	
	/**
	 * 查询ERP 数据库 合同结清表操作
	 * 
	 * @return
	 */
	public static String generateSelectERPGlobalProjectEndData1() {
		// 1Buffer对象
		StringBuffer sqlStr = new StringBuffer();
		// 2拼接sql - 客户代码或者项目经理代码不能为空
		
		
		sqlStr.append("SELECT * FROM vi_INTERFACE_fina_global_htjq_nc WHERE " +
				"convert(varchar(10),odate,21)>='2017-09-01' " +
				"  AND isnull(bcode,'')<>'' and isnull(invcode,'')<>'' and isnull(ccode,'')<>''  and isnull(invtype,'')<>'' ");
		// 3返回
		return sqlStr.toString();
	}

	/**
	 * 查询ERP 数据库 付款单表操作
	 * 
	 * @return
	 */
	public static String generateSelectERPGlobalPaiedData() {
		// 1Buffer对象
		StringBuffer sqlStr = new StringBuffer();
		// 2拼接sql
		// 所有非资金抵扣的数据导入
		sqlStr
				.append("SELECT  * FROM vi_INTERFACE_fina_global_paied where pawnsign=0");
		// 3返回
		return sqlStr.toString();
	}

	/**
	 * 查询ERP 数据库 付款单表操作
	 * 
	 * @return
	 */
	public static String generateSelectERPGlobalPaiedData1() {
		// 1Buffer对象
		StringBuffer sqlStr = new StringBuffer();
		// 2拼接sql
		// 所有资金抵扣的数据导入
		// sqlStr.append("SELECT * FROM vi_INTERFACE_fina_global_paied where
		// pawnsign=1");
		/*sqlStr
				.append("SELECT * FROM vi_INTERFACE_fina_global_paied_nc where isnull(invcode,'')<>'' "
						+ "and isnull(bcode,'')<>''and nc_deptno<>'' and isnull(ccode,'')<>'' and isnull(invtype,'')<>'' ");*/
		//sqlStr.append("select* from vi_INTERFACE_fina_global_paied_nc ")
		//		.append("WHERE convert(varchar(10),rdate,21)>='2017-09-01' and convert(varchar(10),rdate,21)<='2017-09-30' and rmb<>'0.00'");
		
		sqlStr.append("select* from vi_INTERFACE_fina_global_paied_nc ")
		.append("WHERE  rdate>='2017-09-01'  and rmb<>'0.00'");

		// 3返回
		return sqlStr.toString();
	}

	/**
	 * 插入财务接口GlobalReceive数据
	 * 
	 * @param globalReceiveBean
	 * @return
	 */
	public static String generateInsertOracleGlobalReceiveSql(
			GlobalReceiveBean globalReceiveBean) {
		// 1Buffer对象
		StringBuffer sqlStr = new StringBuffer();
		// 2拼接sql
		sqlStr
				.append(
						"Insert into Global_Receive(id,invcode,bcode,acode,odate,ccode,remark,")
				.append("rmb,modifydate,offset,invtype,ordcode,picode,")
				.append("pcode,pawnsign,pawnrmb,pawncode,remark_o,industry,leas_type,remark_1,remark_2)");

		sqlStr.append("Values(");

		sqlStr.append(
				"SEQ_GLOBAL_RECEIVE.nextval," + "'"
						+ globalReceiveBean.getInvcode() + "','"
						+ globalReceiveBean.getBcode() + "','"
						+ globalReceiveBean.getAcode() + "',to_date('"
						+ globalReceiveBean.getOdate() + "','yyyy-mm-dd'),")
				.append(
						"'" + globalReceiveBean.getCcode() + "','"
								+ globalReceiveBean.getRemark() + "','"
								+ globalReceiveBean.getRmb() + "',to_date('"
								+ globalReceiveBean.getModifydate()
								+ "','yyyy-mm-dd'),").append(
						"'" + globalReceiveBean.getOffset() + "','"
								+ globalReceiveBean.getInvtype() + "','"
								+ globalReceiveBean.getOrdcode() + "','"
								+ globalReceiveBean.getPicode() + "','"
								+ globalReceiveBean.getPcode() + "','"
								+ globalReceiveBean.getPawnsign() + "','"
								+ globalReceiveBean.getPawnrmb() + "','"
								+ globalReceiveBean.getPawncode() + "','"
								+ globalReceiveBean.getRemark_o() + "','"
								+ globalReceiveBean.getIndustry() + "','"
								+ globalReceiveBean.getLeas_type() + "','"
								+ globalReceiveBean.getRemark_1() + "','"
								+ globalReceiveBean.getRemark_2() 
								+ "'");

		sqlStr.append(")");
		System.out.println("语句sql——————————————" + sqlStr);
		// 3返回
		return sqlStr.toString();
	}

	/**
	 * 插入财务接口GlobalStartRent数据
	 * 
	 * @param globalReceiveBean
	 * @return
	 */
	public static String generateInsertOracleGlobalStartRentSql(
			GlobalStartRentBean globalStartRentBean) {
		// 1Buffer对象
		StringBuffer sqlStr = new StringBuffer();
		// 2拼接sql
		sqlStr
				.append(
						"Insert into global_startrent(id,invcode,ccodetrust,ccode,bcode,picode,pcode,ordcode,remark")
				.append(
						",changesign,odate,modifydate,invtype,rmb,startrentscode,remark_o,industry,leas_type,remark_1,remark_2)");

		sqlStr.append("Values(");

		sqlStr.append("SEQ_GLOBAL_STARTRENT.nextval," + "'"
				+ globalStartRentBean.getInvcode() + "','"
				+ globalStartRentBean.getCcodetrust() + "','"
				+ globalStartRentBean.getCcode() + "','"
				+ globalStartRentBean.getBcode() + "','"
				+ globalStartRentBean.getPicode() + "','"
				+ globalStartRentBean.getPcode() + "','"
				+ globalStartRentBean.getOrdcode() + "','"
				+ globalStartRentBean.getRemark() + "','"
				+ globalStartRentBean.getChangesign() + "',to_date('"
				+ globalStartRentBean.getOdate() + "','yyyy-mm-dd'),to_date('"
				+ globalStartRentBean.getModifydate() + "','yyyy-mm-dd'),'"
				+ globalStartRentBean.getInvtype() + "','"
				+ globalStartRentBean.getRmb() + "','"
				+ globalStartRentBean.getStartrentscode() + "','"
				+ globalStartRentBean.getRemark_o() + "','"
				+ globalStartRentBean.getIndustry() + "','"
				+ globalStartRentBean.getLeas_type() + "','"
				+ globalStartRentBean.getRemark_1() + "','"
				+ globalStartRentBean.getRemark_2() 
				+ "'");
		sqlStr.append(")");
		// 3返回
		return sqlStr.toString();
	}

	/**
	 * 插入财务接口GlobalFundPlan数据
	 * 
	 * @param globalReceiveBean
	 * @return
	 */
	public static String generateInsertOracleGlobalFundPlanSql(
			GlobalFundPlanBean globalFundPlanBean) {
		// 1Buffer对象
		StringBuffer sqlStr = new StringBuffer();
		// 2拼接sql
		sqlStr
				.append(
						"Insert into global_fundplan(id,invcode,ccodetrust,ccode,bcode,tenancytype,picode,pcode,ordcode")
				.append(
						",remark,changesign,odate,modifydate,invtype,rmb,industry,remark_o,leas_type,remark_1,remark_2)");

		sqlStr.append("Values(");

		sqlStr.append("SEQ_GLOBAL_FUNDPLAN.Nextval," + "'"
				+ globalFundPlanBean.getInvcode() + "','"
				+ globalFundPlanBean.getCcodetrust() + "','"
				+ globalFundPlanBean.getCcode() + "','"
				+ globalFundPlanBean.getBcode() + "','"
				+ globalFundPlanBean.getTenancytype() + "','"
				+ globalFundPlanBean.getPicode() + "','"
				+ globalFundPlanBean.getPcode() + "','"
				+ globalFundPlanBean.getOrdcode() + "','"
				+ globalFundPlanBean.getRemark() + "','"
				+ globalFundPlanBean.getChangesign() + "',to_date('"
				+ globalFundPlanBean.getOdate() + "','yyyy-mm-dd'),to_date('"
				+ globalFundPlanBean.getModifydate() + "','yyyy-mm-dd'),'"
				+ globalFundPlanBean.getInvtype() + "','"
				+ globalFundPlanBean.getRmb() + "','"
				+ globalFundPlanBean.getIndustry() + "','"
				+ globalFundPlanBean.getRemark_o() + "','"
				+ globalFundPlanBean.getLeas_type() + "','"
				+ globalFundPlanBean.getRemark_1() + "','"
				+ globalFundPlanBean.getRemark_2() 
				+ "'");

		sqlStr.append(")");

		System.out.println("资金付款计划=============" + sqlStr);
		// 3返回
		return sqlStr.toString();
	}

	/**
	 * 插入财务接口GlobalInterestSubsidy数据
	 * 
	 * @param globalReceiveBean
	 * @return
	 */
	public static String generateInsertOracleGlobalInterestSubsidySql(
			GlobalInterestSubsidyBean globalInterestSubsidyBean) {
		// 1Buffer对象
		StringBuffer sqlStr = new StringBuffer();
		// 2拼接sql
		sqlStr
				.append(
						"Insert into GLOBAL_INTERESTSUBSIDY(id,invcode,ccode,bcode,picode,pcode,ordcode")
				.append(",modifydate,sub_date,invtype,rmb,remark_o,industry,leas_type,remark_1,remark_2)");
		sqlStr.append("Values(");

		sqlStr.append("SEQ_GLOBAL_INTERESTSUBSIDY.nextval," + "'"
				+ globalInterestSubsidyBean.getInvcode() + "','"
				+ globalInterestSubsidyBean.getCcode() + "','"
				+ globalInterestSubsidyBean.getBcode() + "','"
				+ globalInterestSubsidyBean.getPicode() + "','"
				+ globalInterestSubsidyBean.getPcode() + "','"
				+ globalInterestSubsidyBean.getOrdcode() + "','"
				+ globalInterestSubsidyBean.getModifydate() + "','"
				+ globalInterestSubsidyBean.getSub_date() + "','"
				+ globalInterestSubsidyBean.getInvtype() + "','"
				+ globalInterestSubsidyBean.getRmb() + "','"
				+ globalInterestSubsidyBean.getRemark_o() + "','"
				+ globalInterestSubsidyBean.getIndustry() + "','"
				+ globalInterestSubsidyBean.getLeas_type() + "','"
				+ globalInterestSubsidyBean.getRemark_1() + "','"
				+ globalInterestSubsidyBean.getRemark_2() 
				+ "'");

		sqlStr.append(")");
		// 3返回
		return sqlStr.toString();
	}

	/**
	 * 插入财务接口projectend数据
	 * 
	 * @param globalReceiveBean
	 * @return
	 */
	public static String generateInsertOracleGlobalProjectEndSql(
			GlobalProjectEndBean globalProjectEndBean) {
		// 1Buffer对象
		StringBuffer sqlStr = new StringBuffer();
		// 2拼接sql
		sqlStr
				.append(
						"Insert into GLOBAL_PROJECTEND(id,invcode,ccodetrust,acode,ccode,bcode,picode,pcode,ordcode,odate")
				.append(",modifydate,remark,invtype,rmb,remark_o,industry,leas_type,remark_1,remark_2)");
		sqlStr.append("Values(");

		sqlStr.append("SEQ_GLOBAL_PROJECTEND.nextval," + "'"
				+ globalProjectEndBean.getInvcode() + "','"
				+ globalProjectEndBean.getCcodetrust() + "','"
				+ globalProjectEndBean.getAcode() + "','"
				+ globalProjectEndBean.getCcode() + "','"
				+ globalProjectEndBean.getBcode() + "','"
				+ globalProjectEndBean.getPicode() + "','"
				+ globalProjectEndBean.getPcode() + "','"
				+ globalProjectEndBean.getOrdcode() + "','"
				+ globalProjectEndBean.getOdate() + "','"
				+ globalProjectEndBean.getModifydate() + "','"
				+ globalProjectEndBean.getRemark() + "','"
				+ globalProjectEndBean.getInvtype() + "','"
				+ globalProjectEndBean.getRmb() + "','"
				+ globalProjectEndBean.getRemark_o() + "','"
				+ globalProjectEndBean.getIndustry() + "','"
				+ globalProjectEndBean.getLeas_type() + "','"
				+ globalProjectEndBean.getRemark_1() + "','"
				+ globalProjectEndBean.getRemark_2() 
				+ "'");

		sqlStr.append(")");
		// 3返回

		System.out.println("sql" + sqlStr);
		return sqlStr.toString();
	}

	/**
	 * 插入财务接口GlobalBjjs数据
	 * 
	 * @param globalBjjsBean
	 * @return
	 */
	public static String generateInsertOracleGlobalBjjsSql(
			GlobalBjjsBean globalBjjsBean) {
		// 1Buffer对象
		StringBuffer sqlStr = new StringBuffer();
		// 2拼接sql
		sqlStr
				.append(
						"Insert into global_interest(id,invcode,ccode,bcode,picode,pcode,ordcode")
				.append(
						",modifydate,invyear,invmonth,invtype,rmb,invyear_month,remark_o,industry,leas_type,remark_1,remark_2)");

		sqlStr.append("Values(");

		sqlStr.append(
				"SEQ_GLOBAL_INTEREST.nextval," + "'"
						+ globalBjjsBean.getInvcode() + "','"
						+ globalBjjsBean.getCcode() + "','"
						+ globalBjjsBean.getBcode() + "','"
						+ globalBjjsBean.getPicode() + "','"
						+ globalBjjsBean.getPcode() + "','"
						+ globalBjjsBean.getOrdcode() + "'").append(
				",to_date('" + globalBjjsBean.getModifydate()
						+ "','yyyy-mm-dd'),'" + globalBjjsBean.getInvyear()
						+ "','" + globalBjjsBean.getInvmonth() + "','"
						+ globalBjjsBean.getInvtype() + "','"
						+ globalBjjsBean.getRmb() + "','"
						+ globalBjjsBean.getInvyear_month() + "','"
						+ globalBjjsBean.getRemark_o() + "','"
						+ globalBjjsBean.getIndustry() + "','"
						+ globalBjjsBean.getLeas_type() + "','"
						+ globalBjjsBean.getRemark_1() + "','"
						+ globalBjjsBean.getRemark_2() 
						+ "'");

		sqlStr.append(")");
		// 3返回
		return sqlStr.toString();
	}
	/**
	 * 插入财务接口GlobalBjjsYY数据
	 * 
	 * @param globalBjjsBean
	 * @return
	 */
	public static String generateInsertOracleGlobalBjjsYYSql(
			GlobalBjjsBean globalBjjsBean) {
		// 1Buffer对象
		StringBuffer sqlStr = new StringBuffer();
		// 2拼接sql
		sqlStr
				.append(
						"Insert into global_interest(id,invcode,ccode,bcode,picode,pcode,ordcode")
				.append(
						",modifydate,invyear,invmonth,invtype,rmb,invyear_month,remark_o,industry,leas_type,remark_1,remark_2)");

		sqlStr.append("Values(");

		sqlStr.append(
				"SEQ_GLOBAL_INTEREST.nextval," + "'"
						+ globalBjjsBean.getInvcode() + "','"
						+ globalBjjsBean.getCcode() + "','"
						+ globalBjjsBean.getBcode() + "','"
						+ globalBjjsBean.getPicode() + "','"
						+ globalBjjsBean.getPcode() + "','"
						+ globalBjjsBean.getOrdcode() + "'").append(
				",to_date('" + globalBjjsBean.getModifydate()
						+ "','yyyy-mm-dd'),'" + globalBjjsBean.getInvyear()
						+ "','" + globalBjjsBean.getInvmonth() + "','"
						+ globalBjjsBean.getInvtype() + "','"
						+ globalBjjsBean.getRmb() + "','"
						+ globalBjjsBean.getInvyear_month() + "','"
						+ globalBjjsBean.getRemark_o() + "','"
						+ globalBjjsBean.getIndustry() + "','"
						+ globalBjjsBean.getLeas_type() + "','"
						+ globalBjjsBean.getRemark_1() + "','"
						+ globalBjjsBean.getRemark_2() 
						+ "'");

		sqlStr.append(")");
		// 3返回
		return sqlStr.toString();
	}
	/**
	 * 插入财务接口GlobalLxjs数据
	 * 
	 * @param globalLxjsBean
	 * @return
	 */
	public static String generateInsertOracleGlobalLxjsSql(
			GlobalBjjsBean globalBjjsBean) {
		// 1Buffer对象
		StringBuffer sqlStr = new StringBuffer();
		// 2拼接sql
		sqlStr
				.append(
						"Insert into global_interest(id,invcode,ccode,bcode,picode,pcode,ordcode")
				.append(
						",modifydate,invyear,invmonth,invtype,rmb,invyear_month,remark_o,industry,leas_type,remark_1,remark_2)");

		sqlStr.append("Values(");

		sqlStr.append(
				"SEQ_GLOBAL_INTEREST.nextval," + "'"
						+ globalBjjsBean.getInvcode() + "','"
						+ globalBjjsBean.getCcode() + "','"
						+ globalBjjsBean.getBcode() + "','"
						+ globalBjjsBean.getPicode() + "','"
						+ globalBjjsBean.getPcode() + "','"
						+ globalBjjsBean.getOrdcode() + "'").append(
				",to_date('" + globalBjjsBean.getModifydate()
						+ "','yyyy-mm-dd'),'" + globalBjjsBean.getInvyear()
						+ "','" + globalBjjsBean.getInvmonth() + "','"
						+ globalBjjsBean.getInvtype() + "','"
						+ globalBjjsBean.getRmb() + "','"
						+ globalBjjsBean.getInvyear_month() + "','"
						+ globalBjjsBean.getRemark_o() + "','"
						+ globalBjjsBean.getIndustry() + "','"
						+ globalBjjsBean.getLeas_type() + "','"
						+ globalBjjsBean.getRemark_1() + "','"
						+ globalBjjsBean.getRemark_2() 
						+ "'");

		sqlStr.append(")");
		// 3返回
		return sqlStr.toString();
	}
	/**
	 * 插入财务接口GlobalLxjs数据
	 * 
	 * @param globalLxjsBean
	 * @return
	 */
	public static String generateInsertOracleGlobalLxjsYYSql(
			GlobalBjjsBean globalBjjsBean) {
		// 1Buffer对象
		StringBuffer sqlStr = new StringBuffer();
		// 2拼接sql
		sqlStr
				.append(
						"Insert into global_interest(id,invcode,ccode,bcode,picode,pcode,ordcode")
				.append(
						",modifydate,invyear,invmonth,invtype,rmb,invyear_month,remark_o,industry,leas_type,remark_1,remark_2)");

		sqlStr.append("Values(");

		sqlStr.append(
				"SEQ_GLOBAL_INTEREST.nextval," + "'"
						+ globalBjjsBean.getInvcode() + "','"
						+ globalBjjsBean.getCcode() + "','"
						+ globalBjjsBean.getBcode() + "','"
						+ globalBjjsBean.getPicode() + "','"
						+ globalBjjsBean.getPcode() + "','"
						+ globalBjjsBean.getOrdcode() + "'").append(
				",to_date('" + globalBjjsBean.getModifydate()
						+ "','yyyy-mm-dd'),'" + globalBjjsBean.getInvyear()
						+ "','" + globalBjjsBean.getInvmonth() + "','"
						+ globalBjjsBean.getInvtype() + "','"
						+ globalBjjsBean.getRmb() + "','"
						+ globalBjjsBean.getInvyear_month() + "','"
						+ globalBjjsBean.getRemark_o() + "','"
						+ globalBjjsBean.getIndustry() + "','"
						+ globalBjjsBean.getLeas_type() + "','"
						+ globalBjjsBean.getRemark_1() + "','"
						+ globalBjjsBean.getRemark_2() 
						+ "'");

		sqlStr.append(")");
		// 3返回
		return sqlStr.toString();
	}
	/**
	 * 插入财务接口GlobalInterest数据
	 * 
	 * @param globalStartRentBean
	 * @return
	 */
	public static String generateInsertOracleGlobalInterestSql(
			GlobalInterestBean globalInterestBean) {
		// 1Buffer对象
		StringBuffer sqlStr = new StringBuffer();
		// 2拼接sql
		sqlStr
				.append(
						"Insert into global_interest(id,invcode,ccode,bcode,picode,pcode,ordcode")
				.append(
						",modifydate,invyear,invmonth,invtype,rmb,invyear_month,remark_o,industry,leas_type,remark_1,remark_2)");

		sqlStr.append("Values(");

		sqlStr.append(
				"SEQ_GLOBAL_INTEREST.nextval," + "'"
						+ globalInterestBean.getInvcode() + "','"
						+ globalInterestBean.getCcode() + "','"
						+ globalInterestBean.getBcode() + "','"
						+ globalInterestBean.getPicode() + "','"
						+ globalInterestBean.getPcode() + "','"
						+ globalInterestBean.getOrdcode() + "'").append(
				",to_date('" + globalInterestBean.getModifydate()
						+ "','yyyy-mm-dd'),'" + globalInterestBean.getInvyear()
						+ "','" + globalInterestBean.getInvmonth() + "','"
						+ globalInterestBean.getInvtype() + "','"
						+ globalInterestBean.getRmb() + "','"
						+ globalInterestBean.getInvyear_month() + "','"
						+ globalInterestBean.getRemark_o() + "','"
						+ globalInterestBean.getIndustry() + "','"
						+ globalInterestBean.getLeas_type() + "','"
						+ globalInterestBean.getRemark_1() + "','"
						+ globalInterestBean.getRemark_2() 
						+ "'");

		sqlStr.append(")");
		// 3返回
		return sqlStr.toString();
	}
	/**
	 * 插入财务接口GlobalPaied数据
	 * 
	 * @param globalStartRentBean
	 * @return
	 */
	public static String generateInsertOracleGlobalPaiedSql(
			GlobalPaiedBean globalPaiedBean) {
		// 1Buffer对象
		StringBuffer sqlStr = new StringBuffer();
		// 2拼接sql
		sqlStr
				.append(
						"Insert into global_paied(id,invcode,bcode,rdate,ccode,rmb,modifydate,remark")
				.append(
						",invtype,ordcode,picode,pcode,ccodetrust,settlement,pawnsign,pawnrmb,acode,remark_o,industry,o_acode,leas_type,remark_1,remark_2)");

		sqlStr.append("Values(");

		sqlStr.append("SEQ_GLOBAL_PAIED.nextval," + "'"
				+ globalPaiedBean.getInvcode() + "','"
				+ globalPaiedBean.getBcode() + "',to_date('"
				+ globalPaiedBean.getRdate() + "','yyyy-mm-dd'),'"
				+ globalPaiedBean.getCcode() + "','" + globalPaiedBean.getRmb()
				+ "',to_date('" + globalPaiedBean.getModifydate()
				+ "','yyyy-mm-dd'),'" + globalPaiedBean.getRemark() + "','"
				+ globalPaiedBean.getInvtype() + "','"
				+ globalPaiedBean.getOrdcode() + "','"
				+ globalPaiedBean.getPicode() + "','"
				+ globalPaiedBean.getPcode() + "','"
				+ globalPaiedBean.getCcodetrust() + "','"
				+ globalPaiedBean.getSettlement() + "','"
				+ globalPaiedBean.getPawnsign() + "','"
				+ globalPaiedBean.getPawnrmb() + "','"
				+ globalPaiedBean.getAcode() + "','"
				+ globalPaiedBean.getRemark_o() + "','"
				+ globalPaiedBean.getIndustry() + "','"
				+ globalPaiedBean.getO_acode() + "','"
				+ globalPaiedBean.getLeas_type() + "','"
				+ globalPaiedBean.getRemark_1() + "','"
				+ globalPaiedBean.getRemark_2() 
				+ "'");

		sqlStr.append(")");
		// 3返回
		return sqlStr.toString();
	}

	/**
	 * 查询ERP 国内收款单试图单一数据
	 * 
	 * @param pri_id
	 * @return
	 */
	public static String generateSelectERPGlobalReceiveOneData(String pri_id) {
		// 1Buffer对象
		StringBuffer sqlStr = new StringBuffer();
		// 2拼接sql
		sqlStr
				.append("SELECT * FROM vi_INTERFACE_fina_global_receive where XX='"
						+ pri_id + "'");
		// 3返回
		return sqlStr.toString();
	}
	/**
	 * 数据同步数据日志
	 * 
	 * @param oper_id
	 * @param priId
	 * @param syncType
	 * @return
	 */
	public static String generateFIDataSyncDBInfo(String pri_id, String para_2,
			String para_3, String para_4, String oper_id, String table_type) {
		// 1Buffer对象
		StringBuffer sqlStr = new StringBuffer();
		// 2拼接sql
		sqlStr
				.append(
						"Insert into FI_ERP_DATA_SYNC_INFO(pri_id,para_2,para_3,para_4,oper_id,table_type,create_date)")
				.append(
						"values('" + pri_id + "','" + para_2 + "','" + para_3
								+ "','" + para_4 + "','" + oper_id + "','"
								+ table_type + "',getdate())");
		// System.out.println(sqlStr);
		// 3返回
		return sqlStr.toString();
	}
}
