package com.tenwa.culc.financing.util.interestDateFormula;

import java.math.BigDecimal;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.tenwa.culc.financing.util.interestDateFormula.PBCRate;
import com.tenwa.culc.util.ERPDataSource;

public class PBCRateInterest {
	
	/**
	 * 获取所有年份央行利率信息
	 * @return
	 * @throws Exception
	 */
	public List<PBCRate> getPBCRateList() throws Exception {
		List<PBCRate> list = new ArrayList<PBCRate>();
		
		//Conn db = new Conn();
		ERPDataSource db = new ERPDataSource();
		String sqlstr = " select * from financing_list_rate order by id "; 
		
		System.out.println("****sqlstr= "+sqlstr);
		
		ResultSet rs = db.executeQuery(sqlstr);
		while(rs.next()){
			PBCRate rate = new PBCRate();
			rate.setAdjust_time(rs.getDate("Adjust_time"));
			rate.setRate_start_date(rs.getDate("rate_start_date"));
			rate.setRate_end_date(rs.getDate("rate_end_date"));
			rate.setBase_rate_one(rs.getBigDecimal("base_rate_one"));
			rate.setBase_rate_three(rs.getBigDecimal("base_rate_three"));
			rate.setBase_rate_five(rs.getBigDecimal("base_rate_five"));
			rate.setBase_rate_aboveFive(rs.getBigDecimal("base_rate_abovefiv"));
			
			list.add(rate);
		}
		rs.close();
		db.close();
		System.out.println("****listSize = "+list.size());
		return list;
	}
	
	/**
	 * 获取符合查询条件的某一次的央行利率信息
	 * @param searchDate
	 * @return
	 * @throws Exception 
	 */
	public PBCRate getPBCRate(Date searchDate) throws Exception{
		PBCRateInterest rateInterest = new PBCRateInterest();
		List<PBCRate> list = rateInterest.getPBCRateList() ;
		
		System.out.println("****getPBCRate= "+list.size());
		
		long searchDateTime = searchDate.getTime();
		
		System.out.println("****getPBCRate= "+searchDateTime);
		
		PBCRate rate = new PBCRate();
		for(int i= 0 ; i < list.size();i++){
			PBCRate temp = list.get(i);
			Date rate_start_date = temp.getRate_start_date();
			Date rate_end_date = temp.getRate_end_date();
			if(rate_end_date != null){
				if(searchDateTime >= rate_start_date.getTime() && searchDateTime < rate_end_date.getTime() ){
					rate = temp ;
				}else{
					rate= list.get((list.size())-1);
				}
			}
		}
		
		System.out.println("****getPBCRate= "+rate.getAdjust_time());
		return rate;
	}
	
	/**
	 * 获取对应类型的利息数据
	 * @param searchDate
	 * @param adjustNumber
	 * @param interestType
	 * @return
	 * @throws Exception 
	 */
	public double getPBCRateInterest(Date searchDate , double adjustNumber ,String interestType ) throws Exception{
		PBCRateInterest rateInterest = new PBCRateInterest();
		PBCRate rate = rateInterest.getPBCRate(searchDate);
		
		double interest = 0;
		double temp = 0;
		if(interestType.equals("base_rate_one")){
			temp = rate.getBase_rate_one().doubleValue();
		}else if(interestType.equals("base_rate_three")){
			temp = rate.getBase_rate_three().doubleValue();
		}else if(interestType.equals("base_rate_five")){
			temp = rate.getBase_rate_five().doubleValue();
		}else if(interestType.equals("base_rate_abovefiv")){
			temp = rate.getBase_rate_aboveFive().doubleValue();
		}
		
        interest = temp*adjustNumber;
		
        BigDecimal   bd   =   new   BigDecimal(interest);  
        double  finalInterest  =   bd.setScale(6,   BigDecimal.ROUND_HALF_UP).doubleValue();  
        
		System.out.println("****getPBCRateInterest = "+ finalInterest);
		
		return  finalInterest ;
	}
}
