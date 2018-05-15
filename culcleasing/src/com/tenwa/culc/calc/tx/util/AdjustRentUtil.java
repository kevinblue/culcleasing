package com.tenwa.culc.calc.tx.util;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

public class AdjustRentUtil {
	/**
	 * 调息时计算租金变化值
	 * @param rentlist
	 * @param datelist
	 * @param yearrate
	 * @param allremaincorpus   //剩余本金
	 * @param endvalue          //期末余值
	 * @param startdate
	 * @return  adjustVlaue
	 */
	public static BigDecimal getRentAdjust(List<String> rentlist,List<String> datelist,String rate1,String allremaincorpus,String endvalue,String startdate){
		//剩余本金C，租金R,期利率r,每期租金变化值;
		//第一期：C1=(1+r)C0-R1-x；第n期：Cn=(1+r)Cn-1 - Rn - x。
	    //得：Cn-(1+r)^n*C0=(Rn+x)(1+r)^0+(Rn-1 +x)(1+r)^1+...+(R1+x)(1+r)^(n-1)
		BigDecimal allrent=BigDecimal.ZERO;
		BigDecimal coefficient=BigDecimal.ZERO;//x系数
		BigDecimal power=BigDecimal.ONE;
		BigDecimal one=BigDecimal.ONE;
		BigDecimal rate=BigDecimal.ZERO;
		BigDecimal yearrate=new BigDecimal(rate1).divide(new BigDecimal(100));
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
		BigDecimal x=BigDecimal.ZERO;
		try {
			for(int i=0;i<rentlist.size();i++){
				if(i>0){
					String adate=datelist.get(datelist.size()-i);
					String bdate=datelist.get(datelist.size()-i-1);
					int monthdiff=DateUtils.getBetweenMonths(sdf.parse(bdate),sdf.parse(adate));
					rate= yearrate.multiply(new BigDecimal(monthdiff)).divide(new BigDecimal(12),20 ,BigDecimal.ROUND_HALF_UP);
					power=power.multiply(one.add(rate));
					power=power.setScale(20,BigDecimal.ROUND_HALF_UP);
				}
				BigDecimal rent=new BigDecimal(rentlist.get(rentlist.size()-1-i));
				allrent=allrent.add(power.multiply(rent));
				coefficient=coefficient.add(power);
			}
			int monthdiff=DateUtils.getBetweenMonths(sdf.parse(startdate),sdf.parse(datelist.get(0)));
			rate= yearrate.multiply(new BigDecimal(monthdiff)).divide(new BigDecimal(12),20 ,BigDecimal.ROUND_HALF_UP);
			power=power.multiply(one.add(rate));
			power=power.setScale(20,BigDecimal.ROUND_HALF_UP);
			x = power.multiply(new BigDecimal(allremaincorpus)).subtract(allrent).subtract(new BigDecimal(endvalue)).divide(coefficient, 6,BigDecimal.ROUND_HALF_UP);
			System.out.println(x.doubleValue());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return x;
	}
	/*public static void main(String[] args) {
		List<String> rentlist=new ArrayList<String>();
		List<String> datelist=new ArrayList<String>();
		String yearrate="0.08826435";
		String allremaincorpus="129897399.12";
		String endvalue="0";
		String startdate=("2017-01-26");
		rentlist.add("7805200");datelist.add("2017-04-26");
		rentlist.add("8401675");datelist.add("2017-07-26");
		rentlist.add("8983800");datelist.add("2017-10-26");
		rentlist.add("9551575");datelist.add("2018-01-26");
		rentlist.add("10105000");datelist.add("2018-04-26");
		rentlist.add("10644075");datelist.add("2018-07-26");
		rentlist.add("11168800");datelist.add("2018-10-26");
		rentlist.add("11679175");datelist.add("2019-01-26");
		rentlist.add("12175200");datelist.add("2019-05-26");
		rentlist.add("12656875");datelist.add("2019-09-26");
		rentlist.add("13124200");datelist.add("2020-01-26");
		rentlist.add("13577175");datelist.add("2020-05-26");
		rentlist.add("14015800");datelist.add("2020-09-26");
		rentlist.add("14440075");datelist.add("2021-01-26");
		
		BigDecimal x=getRentAdjust(rentlist, datelist, yearrate, allremaincorpus,endvalue,startdate);
		System.out.println(x);
	}*/
}
