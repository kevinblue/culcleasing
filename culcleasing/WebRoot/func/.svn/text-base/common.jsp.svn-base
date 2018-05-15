<%@ page contentType="text/html; charset=gbk"%><%@ page import="java.math.BigDecimal,java.util.*,java.text.*,java.util.Date" %><%!public String getStr(String str)  //request字符串中文处理
{
	try
	{
		String temp_p=str;
		byte[] temp_t=temp_p.getBytes("ISO8859-1");
		String temp=new String(temp_t);
		return temp;
	}
	catch(Exception e)
	{
	 
	}
	return "";
}
public String getDBStr(String str1)  //DB字符串取出处理
{
	try
	{
        String temp_n=str1;
        if ((temp_n==null) || (temp_n.equals("")) || (temp_n.equals("null")))
        {
        temp_n="";
        }
        else
        {
        }
        return temp_n; 
	}
	catch(Exception e)
	{
	 
	}
	return "";
}
public String getZeroStr(String value){
	try{
		String temp_n = value;
		if(temp_n==null||temp_n.equals("")||temp_n.equals("null")){
			temp_n = "0";
		}
		return temp_n;
	}catch(Exception e){
	
	}
	return "0";
}

public String getMoneyStr(String value){
	try
	{
        if ((value==null) || (value.equals("")) || (value.equals("null")))
        {
        value="0.00";
        }
       return formatNumberDoubleTwo(getDBStr(value)); 
	}
	catch(Exception e){
	 
	}
	return "0.00";
}

public String getDBDateStr(String datestr)  //DB时间字符串取出处理
{
	try
	{
        String temp_date=datestr;
        if ((temp_date==null) || (temp_date.equals(""))||(temp_date.indexOf("1900")>=0))
        {
        temp_date="";
        }
        else
        {
        temp_date=temp_date.substring(0,10);  
        }
        return temp_date; 
	}
	catch(Exception e)
	{
	 
	}
	return "";
}
public BigDecimal getDBDecStr(BigDecimal decstr)  //DB数字Decimal字符串取出处理
{
	try
	{
        BigDecimal temp_dec=decstr;
        if (temp_dec==null)
        {
        temp_dec=new BigDecimal("0.00");
        }
        else
        {
        temp_dec=decstr;  
        }
        return temp_dec; 
	}
	catch(Exception e)
	{
	 
	}
	return new BigDecimal("0.00");
}
public String getSystemDate(int rtype)   //返回系统时间  0--返回时间字符串  1--返回sql时间字符串
{
	try
	{
        Calendar cal= Calendar.getInstance();
        String module = "yyyy-MM-dd";
        if(rtype==2){
        	module = "yyyyMMdd";
        }
        SimpleDateFormat formatter1 = new SimpleDateFormat(module); 
        String fld_date=formatter1.format(cal.getTime());
        if (rtype==0)
            return  fld_date;
        else if (rtype==1)
        	return "'"+fld_date+"'";     //sql server
     		//return "to_date("+fld_date+",'yyyy-mm-dd')";    //oracle
     	else 
     		return fld_date;
	}
	catch(Exception e)
	{
	 
	}
	return "null";
}
public Date getDateAdd(Date date,int leng,String type){
		Date addDate = null;
		Calendar cal = Calendar.getInstance();
		cal.setTime(date);
		if(type.equals("yy")){
			cal.add(Calendar.YEAR,leng);
		}else if(type.equals("mm")){
			cal.add(Calendar.MONTH,leng);
		}else if(type.equals("we")){
			cal.add(Calendar.WEEK_OF_YEAR,leng);
		}else if(type.equals("dd")){
			cal.add(Calendar.DAY_OF_YEAR,leng);
		}else if(type.equals("hh")){
			cal.add(Calendar.HOUR_OF_DAY,leng);
		}else if(type.equals("mi")){
			cal.add(Calendar.MINUTE,leng);
		}else if(type.equals("ss")){
			
		}
		addDate = cal.getTime();
		return addDate;
}
public String getDateAdd(String strDate,int leng,String type){
		Date addDate = null;
		Date date = null;
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		try{
			date = sdf.parse(strDate);
		}catch(Exception e){
			System.out.println(e);
		}
		Calendar cal = Calendar.getInstance();
		cal.setTime(date);
		if(type.equals("yy")){
			cal.add(Calendar.YEAR,leng);
		}else if(type.equals("mm")){
			cal.add(Calendar.MONTH,leng);
		}else if(type.equals("we")){
			cal.add(Calendar.WEEK_OF_YEAR,leng);
		}else if(type.equals("dd")){
			cal.add(Calendar.DAY_OF_YEAR,leng);
		}else if(type.equals("hh")){
			cal.add(Calendar.HOUR_OF_DAY,leng);
		}else if(type.equals("mi")){
			cal.add(Calendar.MINUTE,leng);
		}else if(type.equals("ss")){
			
		}
		addDate = cal.getTime();
		return sdf.format(addDate);
}
public String getDateAddStr(String str,int leng,String type){
	Date date = null;
	Date returnDate = null;
	SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
	try{
		date = formatter.parse(str);
	}catch(Exception e){
		
	}
	returnDate = getDateAdd(date,leng,type);
	return formatter.format(returnDate);
}
public int getDateDiffMonth(String bdate,String edate){
	try
	{
			String []barray = bdate.split("-");
			String []earray = edate.split("-");
			return (Integer.parseInt(earray[0])-Integer.parseInt(barray[0]))*12+(Integer.parseInt(earray[1])-Integer.parseInt(barray[1]));
	}
	catch(Exception e)
	{
	 
	}
	return 0;
}
public long getDateDiff(Date bdate,Date edate)   //返回两时间间隔天数  bdate--开始时间字符串  edate--结束时间字符串
{
	try
	{
            long datediff = (bdate.getTime() - edate.getTime())/(1000*60*60*24);
            return datediff ;
	}
	catch(Exception e)
	{
	 
	}
	return 0;
}
public long getDateDiff(String strbdate,String stredate)   //返回两时间间隔天数  bdate--开始时间字符串  edate--结束时间字符串
{
	Date bdate = null;
	Date edate = null;
	try
	{
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			bdate = sdf.parse(strbdate);
			edate = sdf.parse(stredate);
            long datediff = (bdate.getTime() - edate.getTime())/(1000*60*60*24);
            return datediff ;
	}
	catch(Exception e)
	{
	 
	}
	return 0;
}
public Vector splitString(String sign, String sourceString) 
{
        Vector splitArrays = new Vector();
        int i = 0;
        int j = 0;
        if (sourceString.length()==0) {return splitArrays;}
        while (i <= sourceString.length()) {
               j = sourceString.indexOf(sign, i);
               if (j < 0) {j = sourceString.length();}
               splitArrays.addElement(sourceString.substring(i, j));
               i = j + 1;
        }
        return splitArrays;
  }
public String formatNumberStr(String numstr,String style)   //数字格式化，X,XXX,XXX.XX
{
	try
	{
        String temp_num=numstr;
            if ((temp_num==null) || (temp_num.equals("")))
        {
        temp_num="";
        }
        else
        {
// java.text.DecimalFormat ft =  new java.text.DecimalFormat("#,##0.00");
 java.text.DecimalFormat ft =  new java.text.DecimalFormat(style); 
 BigDecimal bd=new BigDecimal(temp_num);
 temp_num=ft.format(bd);
 
        }
        return temp_num; 
	}
	catch(Exception e)
	{
	}
	return "";
}
public String formatNumberDouble(double numstr)   //数字格式化，X,XXX,XXX.XX
{
	try
	{
        String temp_num=String.valueOf(numstr);
            if ((temp_num==null) || (temp_num.equals("")))
        {
        temp_num="";
        }
        else
        {
 java.text.DecimalFormat ft =  new java.text.DecimalFormat("#,##0.00");
 //java.text.DecimalFormat ft =  new java.text.DecimalFormat(style); 
 BigDecimal bd=new BigDecimal(temp_num);
 temp_num=ft.format(bd);
 
        }
        return temp_num; 
	}
	catch(Exception e)
	{
	}
	return "";
}
public String formatNumberDoubleTwo(String str){
	try
	{
        String temp_num=str;
            if ((temp_num==null) || (temp_num.equals("")))
        {
        temp_num="";
        }
        else
        {
		 java.text.DecimalFormat ft =  new java.text.DecimalFormat("###0.00");
		 //java.text.DecimalFormat ft =  new java.text.DecimalFormat(style); 
		 BigDecimal bd=new BigDecimal(temp_num);
		 temp_num=ft.format(bd);
 
        }
        return temp_num; 
	}
	catch(Exception e)
	{
	}
	return "";
}
public String formatNumberDoubleTwo(double str){
	try
	{
        String temp_num=String.valueOf(str);
            if ((temp_num==null) || (temp_num.equals("")))
        {
        temp_num="";
        }
        else
        {
		 java.text.DecimalFormat ft =  new java.text.DecimalFormat("###0.00");
		 //java.text.DecimalFormat ft =  new java.text.DecimalFormat(style); 
		 BigDecimal bd=new BigDecimal(temp_num);
		 temp_num=ft.format(bd);
 
        }
        return temp_num; 
	}
	catch(Exception e)
	{
	}
	return "";
}
public String formatNumberDoubleFour(String str){
	try
	{
        String temp_num=str;
            if ((temp_num==null) || (temp_num.equals("")))
        {
        temp_num="";
        }
        else
        {
		 java.text.DecimalFormat ft =  new java.text.DecimalFormat("###0.0000");
		 //java.text.DecimalFormat ft =  new java.text.DecimalFormat(style); 
		 BigDecimal bd=new BigDecimal(temp_num);
		 temp_num=ft.format(bd);
 
        }
        return temp_num; 
	}
	catch(Exception e)
	{
	}
	return "";
}
public String formatNumberDoubleSix(String str){
	try
	{
        String temp_num=str;
            if ((temp_num==null) || (temp_num.equals("")))
        {
        temp_num="";
        }
        else
        {
		 java.text.DecimalFormat ft =  new java.text.DecimalFormat("###0.000000");
		 //java.text.DecimalFormat ft =  new java.text.DecimalFormat(style); 
		 BigDecimal bd=new BigDecimal(temp_num);
		 temp_num=ft.format(bd);
 
        }
        return temp_num; 
	}
	catch(Exception e)
	{
	}
	return "";
}
public String formatNumberDoubleSix(double str){
	try
	{
        String temp_num=String.valueOf(str);
            if ((temp_num==null) || (temp_num.equals("")))
        {
        temp_num="";
        }
        else
        {
		 java.text.DecimalFormat ft =  new java.text.DecimalFormat("###0.000000");
		 //java.text.DecimalFormat ft =  new java.text.DecimalFormat(style); 
		 BigDecimal bd=new BigDecimal(temp_num);
		 temp_num=ft.format(bd);
 
        }
        return temp_num; 
	}
	catch(Exception e)
	{
	}
	return "";
}
public String formatNumberDoubleZero(String str){
	try
	{
        String temp_num=str;
            if ((temp_num==null) || (temp_num.equals("")))
        {
        temp_num="";
        }
        else
        {
		 java.text.DecimalFormat ft =  new java.text.DecimalFormat("###0");
		 //java.text.DecimalFormat ft =  new java.text.DecimalFormat(style); 
		 BigDecimal bd=new BigDecimal(temp_num);
		 temp_num=ft.format(bd);
 
        }
        return temp_num; 
	}
	catch(Exception e)
	{
	}
	return "";
}
public String formatNumberDoubleZero(double str){
	try
	{
        String temp_num=String.valueOf(str);
            if ((temp_num==null) || (temp_num.equals("")))
        {
        temp_num="";
        }
        else
        {
		 java.text.DecimalFormat ft =  new java.text.DecimalFormat("###0");
		 //java.text.DecimalFormat ft =  new java.text.DecimalFormat(style); 
		 BigDecimal bd=new BigDecimal(temp_num);
		 temp_num=ft.format(bd);
 
        }
        return temp_num; 
	}
	catch(Exception e)
	{
	}
	return "";
}
public String formatNumberInterest(String numstr)   //数字格式化，X,XXX,XXX.XX
{
	try
	{
        String temp_num=numstr;
            if ((temp_num==null) || (temp_num.equals("")))
        {
        temp_num="";
        }
        else
        {
 java.text.DecimalFormat ft =  new java.text.DecimalFormat("#,##0.0000");
// java.text.DecimalFormat ft =  new java.text.DecimalFormat(style); 
 BigDecimal bd=new BigDecimal(temp_num);
 temp_num=ft.format(bd);
 
        }
        return temp_num; 
	}
	catch(Exception e)
	{
	}
	return "";
}
public String formatBooleanStr(String str,int mode)  //boolean字符串中文处理,true/flase或1/0转换为是/否,mode=0 0转为是,mode=1 1转为是
{
	try
	{
		String temp_bs=str;
                if (mode==0)
                {
                    if (temp_bs.equals("true") || temp_bs.equals("1"))
                    {
                          temp_bs="否";
                    } 
                    else
                    {
                          temp_bs="是";
                    } 
                }
                else
                {
                    if (temp_bs.equals("true") || temp_bs.equals("1"))
                    {
                          temp_bs="是";
                    } 
                    else
                    {
                          temp_bs="否";
                    } 

                }
		return temp_bs;
	}
	catch(Exception e)
	{
	 
	}
	return "";
}
public String formatBooleanStr(String str)  //boolean字符串中文处理的缺省情况,对应于mode=1
{
	try
	{
		return formatBooleanStr(str,1);
	}
	catch(Exception e)
	{
	 
	}
	return "";
}
public double rnddouble(double dbl,int scale)  //double四舍五入处理 scale--精度
{
	try
	{
		BigDecimal temp_bd=new BigDecimal(dbl);   
		double newdbl=temp_bd.setScale(scale,BigDecimal.ROUND_HALF_UP).doubleValue();
		return newdbl;
	}
	catch(Exception e)
	{
	 
	}
        return 0;
}
public String getIRR(List l_inflow_pour,String chjg,String zjjg,String nhkcs) 
{	
	chjg=chjg.equals("")?"0":chjg;
	zjjg=zjjg.equals("")?"0":zjjg;
	nhkcs=nhkcs.equals("")?"0":nhkcs;
	//参数说明：l_inflow_pour=所有现金流入流出（流入为正，流出为负），chjg=偿还间隔，
		//zjjg=租金间隔,nhkcs=年还款次数
	//BigDecimal year_number = new BigDecimal("3");//偿还间隔
	BigDecimal year_number = new BigDecimal(chjg);//偿还间隔
	//BigDecimal rent_interval = new BigDecimal("3");//每期租金间隔
	BigDecimal rent_interval = new BigDecimal(zjjg);//每期租金间隔
	BigDecimal tmp = new BigDecimal("1");
	BigDecimal irr = new BigDecimal("0");
	BigDecimal tmp1 = new BigDecimal("0");
	BigDecimal tmp2 = new BigDecimal("100");
	BigDecimal bigdec_1 = new BigDecimal("1");
	BigDecimal bigdec_2 = new BigDecimal("2");
	int j = 0;
	try
	{
		while ( tmp.abs().doubleValue() > 0.0000000001 && j < 100) {
			tmp = new BigDecimal(l_inflow_pour.get(0).toString());
			for ( int i = 1;i < l_inflow_pour.size();i++ ) {
				tmp = tmp.add ( new BigDecimal(l_inflow_pour.get(i).toString()).divide( new BigDecimal ( Math.pow( irr.add(bigdec_1).doubleValue() , i ) ) , 20 , BigDecimal.ROUND_HALF_UP ) );
			}
			if ( tmp.doubleValue() > 0 ) {
				tmp1 = irr;
				irr = irr.add(tmp2).divide( bigdec_2 , 20 , BigDecimal.ROUND_HALF_UP );
			}
			if ( tmp.doubleValue() < 0 ) {
				tmp2 = irr;
				irr = irr.add(tmp1).divide( bigdec_2 , 20 , BigDecimal.ROUND_HALF_UP );
			}
	   		j++;
		}
		irr = irr.multiply( year_number ).divide( rent_interval , 20 , BigDecimal.ROUND_HALF_UP );
		//irr = irr.multiply(new BigDecimal("4"));
		irr = irr.multiply(new BigDecimal(nhkcs));
		return irr.toString().equals("")?"0":irr.toString();
	}
	catch(Exception e)
	{
		e.printStackTrace();
	}
	return "0";
}


public String getPMT(String Rate,String Nper,String Pv,String Fv,String Type) 
{
     //参数说明：Pv=现值，Nper=期数，Rate=利率(注意同期数周期一致，且要求已经包括百分号的数值！如0.05)
	//Fv=未来值，Type=数字 0 或 1，用以指定各期的付款时间是在期初还是期末
	Rate=Rate.equals("")?"0":Rate;
	Nper=Nper.equals("")?"0":Nper;
	Pv=Pv.equals("")?"0":Pv;
	Fv=Fv.equals("")?"0":Fv;
	Type=Type.equals("")?"0":Type;
	BigDecimal Pv_B = new BigDecimal(Pv);
	BigDecimal Nper_B = new BigDecimal(Nper);
	BigDecimal Rate_B = new BigDecimal(Rate);
	BigDecimal Fv_B = new BigDecimal(Fv);
	BigDecimal Type_B = new BigDecimal(Type);
	BigDecimal pmt_B = new BigDecimal("0");	
	BigDecimal num1_B = new BigDecimal("1");
	BigDecimal numfu1_B = new BigDecimal("-1");
	int Nper_i = Integer.valueOf(Nper).intValue();
	try
	{
		pmt_B=numfu1_B.multiply(Rate_B).multiply(Pv_B.multiply((num1_B.add(Rate_B)).pow(Nper_i)).add(Fv_B)).divide((num1_B.add(Rate_B.multiply(Type_B))).multiply((num1_B.add(Rate_B)).pow(Nper_i).subtract(num1_B)),20,BigDecimal.ROUND_HALF_UP);
		return pmt_B.toString().equals("")?"0":pmt_B.toString();
	}
	catch(Exception e)
	{
		e.printStackTrace();
	}
	return "0";
}
public String getPmtYearRate(String Nper,String Pv,String Fv,String Type,String Pmt,String lease_term){ //"10","-23000000","6900000","0","1742210","1"
	ArrayList al = new ArrayList();
	int j=0;
	double dpv = 0;
	if(Pv!=null&&!Pv.equals("")){
		dpv = Double.parseDouble(Pv);
	}
	double dpmt = 0;
	if(Pmt!=null&&!Pmt.equals("")){
		dpmt = Double.parseDouble(Pmt);
	}
	int inper = 0;
	if(Nper!=null&&!Nper.equals("")){
		inper = Integer.parseInt(Nper);
	}
	int ilease_term = 0;
	if(lease_term!=null&&!lease_term.equals("")){
		ilease_term = Integer.parseInt(lease_term);
	}
	if(Type.equals("1")){
		//期初
		double dsub = dpv+dpmt;
		al.add(new BigDecimal(String.valueOf(dsub)));
		if(ilease_term>1){
			for(int i=0;i<(ilease_term-1);i++){
				al.add(new BigDecimal("0"));
			}
		}
		j=1;
	}else{
		al.add(new BigDecimal(String.valueOf(dpv)));
		if(ilease_term>1){
			for(int i=0;i<(ilease_term-1);i++){
				al.add(new BigDecimal("0"));
			}
		}
	}
	for(;j<inper;j++){
		al.add(new BigDecimal(String.valueOf(dpmt)));
		//
		if(j!=(inper-1)){
			if(ilease_term>1){
				for(int i=0;i<(ilease_term-1);i++){
					al.add(new BigDecimal("0"));
				}
			}
		}
	}
	String irr = formatNumberDoubleSix(String.valueOf(Double.parseDouble(getIRR(al,"1","1","12"))*100));
	return irr;
}
public String getPowRate(String rate,String lease_term){
	return String.valueOf(Math.pow(new BigDecimal(rate).add(new BigDecimal("1")).doubleValue(),Integer.parseInt(lease_term))-1);
}
//调息时使用的回笼计划制作公式，由已存在的回笼计划和新的年利率生成
public ArrayList getRentPlanInterest(ArrayList al,double dallRent,double dlease_money,double dyear_rate,String period_type,int income_number,ArrayList alAdjust){
	//生成等额租金租金计划;al租金回笼阶段；dallRent租金总额，由回笼阶段获取；dlease_money本金总额，由交易结构获取；income_number，年还租次数；charge_first_date首期租金回笼日；rent_first_date二期租金回笼日；ivolume 开始期数，新增为1，如果不是从1开始应传入起始期数,interval还租间隔时间=12/income_number
		ArrayList alrent = new ArrayList();
		int iarrleng = al.size();
		//剩余租金
		double dremainrent = dallRent;
		//剩余本金
		double dremainprincipal = dlease_money;
		//剩余利息
		double dremaininterest = dallRent - dlease_money;
		double dcalprincipal = 0;
		//租金计划中的本金总合
		double allPrincipal = 0;
		double sumprincipal = 0;
		if(al.size()>0){
			//时间
			int flag = 0;
			//期次
			int volumeflag = 0;
			for(int j=0;j<al.size();j++){
				HashMap hm = (HashMap)al.get(j);
				int involume = 0;
				String volume = (String)hm.get("volume");
				String rent_date = (String)hm.get("rent_date");
				String corpus = (String)hm.get("corpus");
				String year_rate = (String)hm.get("year_rate");
				String interest = (String)hm.get("interest");
				String rent = (String)hm.get("rent");
				String eptd_rent = (String)hm.get("eptd_rent");
				String adjust_amount = (String)hm.get("adjust_amount");
				String strrentadjust = "";
				//本期利息
				double ninterest = 0;
				//本期本金
				double nprincipal = 0;
				//本期租金
				double nrent = 0;
				
				double nyear_rate = 0;
				if(year_rate!=null&&!year_rate.equals("")){
					nyear_rate = Double.parseDouble(year_rate);
				}
				if(rent!=null&&!rent.equals("")){
					nrent = Double.parseDouble(rent);
				}
				
				if(alAdjust!=null&&alAdjust.size()>=(j+1)){
					strrentadjust = (String)alAdjust.get(j);
				}
				double drentadjust = 0;
				if(strrentadjust!=null&&!strrentadjust.equals("")){
					drentadjust = Double.parseDouble(strrentadjust);
				}
				nrent+=drentadjust;
				//利息计算  = 剩余本金*(年利率/100)/年还租次数  ,期初支付的第一笔租金不记录利息
				if(period_type.equals("1")&&(volume.equals("1"))){
					ninterest = 0;
				}else{
					ninterest = Double.parseDouble(formatNumberDoubleTwo(String.valueOf(dremainprincipal*nyear_rate/100/income_number)));
				}
				//本金计算 = 租金-利息
				nprincipal = nrent - ninterest;
				//剩余租金
				dremainrent -= nrent;
				//剩余本金
				dremainprincipal -=nprincipal;
				//剩余利息
				dremaininterest -=ninterest;
				hm.put("corpus",String.valueOf(nprincipal));
				hm.put("year_rate",String.valueOf(year_rate));
				hm.put("rent",String.valueOf(nrent));
				hm.put("interest",String.valueOf(ninterest));
				alrent.add(hm);
				allPrincipal+=nprincipal;
			}
			//租赁本金与租金计算过程中所得本金进行比较
			if(allPrincipal>dlease_money){
		    	double other = allPrincipal-dlease_money;
		    	HashMap hmo = (HashMap)alrent.get(alrent.size()-1);
		    	hmo.put("corpus",String.valueOf(Double.parseDouble((String)hmo.get("corpus"))-other));
		    	allPrincipal-=other;
		    	hmo.put("interest",String.valueOf(Double.parseDouble((String)hmo.get("interest"))+other));;
		    	alrent.set(alrent.size()-1,hmo);
		    	dremainprincipal+=other;
		    	dremaininterest-=other;
		    }else if(allPrincipal<dlease_money){
		    	double other = dlease_money-allPrincipal;
		    	HashMap hmo = (HashMap)alrent.get(alrent.size()-1);
		    	hmo.put("corpus",String.valueOf(Double.parseDouble((String)hmo.get("corpus"))+other));
		    	allPrincipal+=other;
		    	hmo.put("interest",String.valueOf(Double.parseDouble((String)hmo.get("interest"))-other));
		    	alrent.set(alrent.size()-1,hmo);
		    	dremainprincipal-=other;
		    	dremaininterest+=other;
		    }
		}
	    return alrent;
}
//由交易结构和租金调整项生成回笼计划
public ArrayList getRentPlan(ArrayList al,double dallRent,double dlease_money,int income_number,String charge_first_date,String rent_first_date,int ivolume,int interval,boolean cash_flag,ArrayList alAdjust,String period_type){
		//生成等额租金租金计划;al租金回笼阶段；dallRent租金总额，由回笼阶段获取；dlease_money本金总额，由交易结构获取；income_number，年还租次数；charge_first_date首期租金回笼日；rent_first_date二期租金回笼日；ivolume 开始期数，新增为1，如果不是从1开始应传入起始期数,interval还租间隔时间=12/income_number
		ArrayList alrent = new ArrayList();
		int iarrleng = al.size();
		//剩余租金
		double dremainrent = dallRent;
		//剩余本金
		double dremainprincipal = dlease_money;
		//剩余利息
		double dremaininterest = dallRent - dlease_money;
		double dcalprincipal = 0;
		//租金计划中的本金总合
		double allPrincipal = 0;
		double sumprincipal = 0;
		if(al.size()>0){
			//时间
			int flag = 0;
			//期次
			int volumeflag = 0;
			for(int j=0;j<al.size();j++){
				HashMap hm = (HashMap)al.get(j);
				int involume = 0;
				String stage_list = String.valueOf(hm.get("stage_list")); 
				String rent_number = String.valueOf(hm.get("rent_number")); 
				String return_ratio = String.valueOf(hm.get("return_ratio")); 
				String return_amt = String.valueOf(hm.get("return_amt")); 
				String year_rate = String.valueOf(hm.get("year_rate")); 
				String stage_rent = String.valueOf(hm.get("stage_rent"));
				int istage_list = Integer.parseInt(stage_list);
				int irent_number = Integer.parseInt(rent_number);
				double dreturn_ratio = Double.parseDouble(return_ratio);
				double dreturn_amt = Double.parseDouble(return_amt);
				double dyear_rate = Double.parseDouble(year_rate);
				double dstage_rent = Double.parseDouble(formatNumberDoubleTwo(stage_rent));
				//本期利息
				double ninterest = 0;
				//本期本金
				double nprincipal = 0;
				
				if(rent_number!=null&&!rent_number.equals("")){
					involume = Integer.parseInt(rent_number);
					allPrincipal = 0;
					for(int i=1;i<=involume;i++){
						dstage_rent = Double.parseDouble(stage_rent);
						HashMap hmrent = new HashMap();
						String strrentadjust = "";
						if(alAdjust.size()>=i){
							strrentadjust = (String)alAdjust.get(i-1);
						}
						double drentadjust = 0;
						if(strrentadjust!=null&&!strrentadjust.equals("")){
							drentadjust = Double.parseDouble(strrentadjust);
						}
						hmrent.put("eptd_rent",String.valueOf(dstage_rent));
						dstage_rent+=drentadjust;
						//利息计算  = 剩余本金*(年利率/100)/年还租次数  ,期初支付的第一笔租金不记录利息
						if(period_type.equals("1")&&(j==0&&i==1)){
							ninterest = 0;
						}else{
							ninterest = Double.parseDouble(formatNumberDoubleTwo(String.valueOf(dremainprincipal*dyear_rate/100/income_number)));
						}
						//本金计算 = 租金-利息
						nprincipal = dstage_rent - ninterest;
						if(j==0&&i==1){}else{flag++;volumeflag++;}
						hmrent.put("rent_date",j==0&&i==1?charge_first_date:rent_first_date!=null&&!rent_first_date.equals("")?getDateAddStr(rent_first_date,((flag-1)*interval),"mm"):getDateAddStr(charge_first_date,((flag)*interval),"mm"));
						hmrent.put("volume",String.valueOf(volumeflag+(ivolume!=0?ivolume:1)));
						hmrent.put("rent",String.valueOf(dstage_rent));
						hmrent.put("corpus",String.valueOf(nprincipal));
						hmrent.put("year_rate",String.valueOf(dyear_rate));
						hmrent.put("interest",String.valueOf(ninterest));
						//剩余租金
						dremainrent -= dstage_rent;
						//剩余本金
						dremainprincipal -=nprincipal;
						//剩余利息
						dremaininterest -=ninterest;
						hmrent.put("rent_overage",String.valueOf(dremainrent));
						hmrent.put("corpus_overage",String.valueOf(dremainprincipal));
						hmrent.put("interest_overage",String.valueOf(dremaininterest));
						hmrent.put("otherinput","0");
						hmrent.put("otheroutput","0");
						hmrent.put("otheroutput","0");
						hmrent.put("adjust_amount",String.valueOf(drentadjust));
						hmrent.put("net_flow","0");
						alrent.add(hmrent);
						allPrincipal+=nprincipal;
						//用于生成现金流，目前已弃用
						if(!cash_flag){
						
							if(j==0&&i==1){
								if(getDateDiffMonth(charge_first_date,rent_first_date)>1){
					      			for(int k=1;k<getDateDiffMonth(charge_first_date,rent_first_date);k++){
						      			HashMap chm = new HashMap();
						      			volumeflag++;
							      		chm.put("rent_date",charge_first_date!=null&&!charge_first_date.equals("")?getDateAddStr(charge_first_date,k,"mm"):"");
							      		chm.put("volume",String.valueOf(volumeflag+(ivolume!=0?ivolume:1)));
							      		chm.put("corpus","0");
							      		chm.put("year_rate","0");
							      		chm.put("interest","0");
							      		chm.put("rent","0");
							      		chm.put("rent_overage","0");
							      		chm.put("corpus_overage","0");
							      		chm.put("interest_overage","0");
							      		chm.put("otherinput","0");
							      		chm.put("otheroutput","0");
							      		alrent.add(chm);
						      		}
					      		}
							}else if(!(j==(iarrleng-1)&&i==involume)){
								
								for(int k=1;k<interval;k++){
									volumeflag++;
						      		HashMap chm = new HashMap();
						      		chm.put("rent_date",rent_first_date!=null&&!rent_first_date.equals("")?getDateAddStr(rent_first_date,((flag-1)*interval)+k,"mm"):getDateAddStr(charge_first_date,((flag)*interval)+k,"mm"));
						      		chm.put("volume",String.valueOf(volumeflag+(ivolume!=0?ivolume:1)));
						      		chm.put("corpus","0");
						      		chm.put("year_rate","0");
						      		chm.put("interest","0");
						      		chm.put("rent","0");
						      		chm.put("rent_overage","0");
						      		chm.put("corpus_overage","0");
							      	chm.put("interest_overage","0");
						      		chm.put("otherinput","0");
						      		chm.put("otheroutput","0");
						      		alrent.add(chm);
						      	}
							}
						}
					}
					//租赁本金与租金计算过程中所得本金进行比较
					if(allPrincipal>dreturn_amt){
				    	double other = allPrincipal-dreturn_amt;
				    	HashMap hmo = (HashMap)alrent.get(alrent.size()-1);
				    	hmo.put("corpus",String.valueOf(Double.parseDouble((String)hmo.get("corpus"))-other));
				    	allPrincipal-=other;
				    	hmo.put("interest",String.valueOf(Double.parseDouble((String)hmo.get("interest"))+other));;
				    	hmo.put("corpus_overage",String.valueOf(Double.parseDouble((String)hmo.get("corpus_overage"))+other));
				    	hmo.put("interest_overage",String.valueOf(Double.parseDouble((String)hmo.get("interest_overage"))-other));
				    	alrent.set(alrent.size()-1,hmo);
				    	dremainprincipal+=other;
				    	dremaininterest-=other;
				    }else if(allPrincipal<dreturn_amt){
				    	double other = dreturn_amt-allPrincipal;
				    	HashMap hmo = (HashMap)alrent.get(alrent.size()-1);
				    	hmo.put("corpus",String.valueOf(Double.parseDouble((String)hmo.get("corpus"))+other));
				    	allPrincipal+=other;
				    	hmo.put("interest",String.valueOf(Double.parseDouble((String)hmo.get("interest"))-other));
				    	hmo.put("corpus_overage",String.valueOf(Double.parseDouble((String)hmo.get("corpus_overage"))-other));
				    	hmo.put("interest_overage",String.valueOf(Double.parseDouble((String)hmo.get("interest_overage"))+other));
				    	alrent.set(alrent.size()-1,hmo);
				    	dremainprincipal-=other;
				    	dremaininterest+=other;
				    }
				}
			}
		}
	    return alrent;
}
public ArrayList getRentPlan(ArrayList al,double dallRent,double dlease_money,int income_number,String charge_first_date,String rent_first_date,int ivolume,int interval,boolean cash_flag){
	return getRentPlan(al,dallRent,dlease_money,income_number,charge_first_date,rent_first_date,ivolume,interval,cash_flag,new ArrayList(),"0");
}
//用于由回笼计划计算现金流，由于缺少保证金抵扣计算目前已停用
public ArrayList getRentCash(ArrayList al,double dinput,double doutput,double dendinput,double dendoutput){
	//[DELETE] [ZHANGHF] [START] [已停用] [2009-5-25-0001]
	int ivolume = 1;
	String preDate = "";
	String nextDate = "";
	String rent = "";
	ArrayList alCash = new ArrayList();
	alCash.add(al.get(0));
	HashMap hmFirst = (HashMap)al.get(0);
	preDate = (String)hmFirst.get("rent_date");
	rent = (String)hmFirst.get("rent");
	hmFirst.put("otherinput",String.valueOf(dinput));
	hmFirst.put("otheroutput",String.valueOf(doutput));
	hmFirst.put("net_flow",String.valueOf(Double.parseDouble(rent)+dinput-doutput));
	alCash.set(0,hmFirst);
	for(int i=1;i<al.size();i++){
		HashMap hm = (HashMap)al.get(i);
		nextDate = (String)hm.get("rent_date");
		if(getDateDiffMonth(preDate,nextDate)>1){
     		for(int k=1;k<getDateDiffMonth(preDate,nextDate);k++){
     			HashMap chm = new HashMap();
     			ivolume++;
	      		chm.put("rent_date",getDateAddStr(preDate,k,"mm"));
	      		chm.put("volume",String.valueOf(ivolume));
	      		chm.put("corpus","0");
	      		chm.put("year_rate","0");
	      		chm.put("interest","0");
	      		chm.put("rent","0");
	      		chm.put("rent_overage","0");
	      		chm.put("corpus_overage","0");
	      		chm.put("interest_overage","0");
	      		chm.put("otherinput","0");
	      		chm.put("otheroutput","0");
	      		chm.put("net_flow","0");
	      		alCash.add(chm);
      		}
		}
		ivolume++;
		hm.put("volume",String.valueOf(ivolume));
		hm.put("net_flow",hm.get("rent"));
		al.set(i,hm);
		alCash.add(hm);
		preDate = nextDate;
	}
	HashMap hmEnd = (HashMap)al.get(al.size()-1);
	String endRent = (String)hmEnd.get("rent");
	double dendRent = Double.parseDouble(endRent);
	hmEnd.put("otherinput",String.valueOf(dendinput));
	hmEnd.put("otheroutput",String.valueOf(dendoutput));
	hmEnd.put("net_flow",String.valueOf(dendRent+dendinput-dendoutput));
	alCash.set(alCash.size()-1,hmEnd);
	return alCash;
	//[DELETE] [ZHANGHF] [END] [已停用] [2009-5-25-0001]
}
//计算现金流量
public ArrayList getRentCashArray(ArrayList al,ArrayList alput,String period_type,String start_date,String exps){
	//获取现金流量，al租金回笼计划，alput其他收入、其他支出、保证金抵扣情况，period_type支付类型，起租日，exps是否按月计算现金流量
	int ivolume = 1;
	String preDate = "";
	String nextDate = "";
	String rent = "";
	ArrayList alCash = new ArrayList();
	double dsubCaution = 0;
	if(period_type.equals("0")){
		//如果是期末支付，回笼计划中增加一项
		preDate = start_date;
		HashMap hmget = (HashMap)alput.get(0);
		String input = (String)hmget.get("input");
		String output = (String)hmget.get("output");
		String caution_deduction = (String)hmget.get("caution_deduction");
		double dinput = 0;
		double doutput = 0;
		double dcaution_deduction = 0;
		if(input!=null&&!input.equals("")){
			dinput = Double.parseDouble(input);
		}
		if(output!=null&&!output.equals("")){
			doutput = Double.parseDouble(output);
		}
		if(caution_deduction!=null&&!caution_deduction.equals("")){
			dcaution_deduction = Double.parseDouble(caution_deduction);
		}
		HashMap chm = new HashMap();
   		chm.put("rent_date",start_date);
   		chm.put("volume",String.valueOf(ivolume));
   		chm.put("corpus","0");
   		chm.put("year_rate","0");
   		chm.put("interest","0");
   		chm.put("rent","0");
   		chm.put("rent_overage","0");
   		chm.put("corpus_overage","0");
   		chm.put("interest_overage","0");
   		chm.put("caution_deduction","0");
   		chm.put("otherinput",input);
   		chm.put("otheroutput",output);
   		chm.put("net_flow",String.valueOf(dinput-doutput));
   		alCash.add(chm);
	}else{
		HashMap hmFirst = (HashMap)al.get(0);
		preDate = (String)hmFirst.get("rent_date");
		ivolume = 0;
	}
	for(int i=0;i<al.size();i++){
		//由al中获取回笼计划
		HashMap hm = (HashMap)al.get(i);
		//计算回笼间隔，如果间隔大于1，补0
		nextDate = (String)hm.get("rent_date");
		if(exps!=null&&exps.equals("1")){
		if(getDateDiffMonth(preDate,nextDate)>1){
     		for(int k=1;k<getDateDiffMonth(preDate,nextDate);k++){
     			HashMap chm = new HashMap();
     			ivolume++;
	      		chm.put("rent_date",getDateAddStr(preDate,k,"mm"));
	      		chm.put("volume",String.valueOf(ivolume));
	      		chm.put("corpus","0");
	      		chm.put("year_rate","0");
	      		chm.put("interest","0");
	      		chm.put("rent","0");
	      		chm.put("rent_overage","0");
	      		chm.put("corpus_overage","0");
	      		chm.put("interest_overage","0");
	      		chm.put("caution_deduction","0");
	      		chm.put("otherinput","0");
	      		chm.put("otheroutput","0");
	      		chm.put("net_flow","0");
	      		alCash.add(chm);
      		}
		}
		}
		//租金
		String strrent = (String)hm.get("rent");
		double drent = 0;
		if(strrent!=null&&!strrent.equals("")){
			drent = Double.parseDouble(strrent);
		}
		//其他收入、其他支出
		HashMap hmget = null;
		if(period_type.equals("0")){
			hmget = (HashMap)alput.get(i+1);
		}else{
			hmget = (HashMap)alput.get(i);
		}
		String input = (String)hmget.get("input");
		String output = (String)hmget.get("output");
		String caution_deduction = (String)hmget.get("caution_deduction");
		double dcaution_deduction = 0;
		double dinput = 0;
		double doutput = 0;
		if(input!=null&&!input.equals("")){
			dinput = Double.parseDouble(input);
		}
		if(output!=null&&!output.equals("")){
			doutput = Double.parseDouble(output);
		}
		if(caution_deduction!=null&&!caution_deduction.equals("")){
			dcaution_deduction = Double.parseDouble(caution_deduction);
		}
		//添加其他收入、其他支出
		ivolume++;
		hm.put("volume",String.valueOf(ivolume));
		hm.put("otherinput",input);
   		hm.put("otheroutput",output);
   		hm.put("caution_deduction",caution_deduction);
		hm.put("net_flow",String.valueOf(drent+dinput-doutput-dcaution_deduction));
		alCash.add(hm);
		preDate = nextDate;
	}
	return alCash;
}
public ArrayList invertList(ArrayList al){
	//ArrayList倒置
	ArrayList alout = new ArrayList();
	for(int i=(al.size()-1);i>=0;i--){
		alout.add(al.get(i));
	}
	return alout;
}
public String getIRRByFlow(ArrayList alCash){
	//根据现金流获取IRR
	ArrayList alirr = new ArrayList();
	for(int i=0;i<alCash.size();i++){
		HashMap hm = (HashMap)alCash.get(i);
		alirr.add(new BigDecimal((String)hm.get("net_flow")));
	}
	return formatNumberDoubleSix(Double.parseDouble(getIRR(alirr,"1","1","12"))*100);
}
public String getRateByFlow(ArrayList alCash,String income_number_year){
	//根据现金流获取年利率
	ArrayList alirr = new ArrayList();
	for(int i=0;i<alCash.size();i++){
		HashMap hm = (HashMap)alCash.get(i);
		alirr.add(new BigDecimal((String)hm.get("net_flow")));
	}
	return formatNumberDoubleSix(Double.parseDouble(getIRR(alirr,"1","1",income_number_year))*100);
}
public String getRateByFlowArray(ArrayList al,ArrayList alput,String period_type,String start_date,String exps,String income_number_year){
	return getRateByFlow(getRentCashArray(al,alput,period_type,start_date,exps),income_number_year);
}
public String getAllRent(ArrayList alRent){
	//得到总租金
	double dAllRent = 0;
	if(alRent!=null){
		for(int i=0;i<alRent.size();i++){
			HashMap hmTemp = (HashMap)alRent.get(i);
			String rent = null;
			rent = (String)hmTemp.get("rent");
			double dRent = 0;
			if(rent!=null&&!rent.equals("")){
				dRent = Double.parseDouble(rent);
				dAllRent+=dRent;
			}
		}
	}
	return String.valueOf( dAllRent);
}
public boolean isNotNull(String value){
	return value!=null&&!value.equals("");
}
//获取租金列表
public ArrayList getExpectRent(String income_number,String rent){
	ArrayList alExpect = new ArrayList();
	int income = 0;
	if(income_number!=null&&!income_number.equals("")){
		income = Integer.parseInt(income_number);
	}
	for(int i=0;i<income;i++){
		alExpect.add(rent);
	}
	return alExpect;
}
//
public ArrayList getAdjustRent(ArrayList al ,ArrayList aladjust){
	double dexpect = 0;
	double dadjust = 0;
	double dactual = 0;
	ArrayList alactual = new ArrayList();
	if(al!=null){
		for(int i=0;i<al.size();i++){
			dexpect = 0;
			dadjust = 0;
			dactual = 0;
			String expect = (String)al.get(i);
			if(expect!=null&&!expect.equals("")){
				dexpect = Double.parseDouble(expect);
			}
			if(aladjust!=null){
				if(aladjust.size()>=(i+1)){
					String adjust = (String)aladjust.get(i);
					if(adjust!=null&&!adjust.equals("")){
						dadjust = Double.parseDouble(adjust);
					}
				}
			}
			dactual = dexpect+dadjust;
			HashMap hm = new HashMap();
			hm.put("rent",String.valueOf(dactual));
			alactual.add(hm);
		}
	}
	return alactual;
}

public ArrayList getRentCashArray(ArrayList al,ArrayList alput,String period_type){
	//获取现金流量，al租金回笼计划，alput其他收入、其他支出、保证金抵扣情况，period_type支付类型，起租日，exps是否按月计算现金流量

	String rent = "";
	ArrayList alCash = new ArrayList();
	double dsubCaution = 0;
	System.out.println("al.size():"+al.size());
	System.out.println("alput.size():"+alput.size());
	if(period_type.equals("0")){
		//如果是期末支付，回笼计划中增加一项
		HashMap hmget = (HashMap)alput.get(0);
		String input = (String)hmget.get("input");
		String output = (String)hmget.get("output");
		String caution_deduction = (String)hmget.get("caution_deduction");
		double dinput = 0;
		double doutput = 0;
		double dcaution_deduction = 0;
		if(input!=null&&!input.equals("")){
			dinput = Double.parseDouble(input);
		}
		if(output!=null&&!output.equals("")){
			doutput = Double.parseDouble(output);
		}
		if(caution_deduction!=null&&!caution_deduction.equals("")){
			dcaution_deduction = Double.parseDouble(caution_deduction);
		}
		HashMap chm = new HashMap();
   		chm.put("net_flow",String.valueOf(dinput-doutput));
   		alCash.add(chm);
	}
	for(int i=0;i<al.size();i++){
		//由al中获取回笼计划
		HashMap hm = (HashMap)al.get(i);
		//计算回笼间隔，如果间隔大于1，补0
		//租金
		String strrent = (String)hm.get("rent");
		double drent = 0;
		if(strrent!=null&&!strrent.equals("")){
			drent = Double.parseDouble(strrent);
		}
		//其他收入、其他支出
		HashMap hmget = null;
		if(period_type.equals("0")){
			hmget = (HashMap)alput.get(i+1);
		}else{
			hmget = (HashMap)alput.get(i);
		}
		String input = (String)hmget.get("input");
		String output = (String)hmget.get("output");
		String caution_deduction = (String)hmget.get("caution_deduction");
		double dcaution_deduction = 0;
		double dinput = 0;
		double doutput = 0;
		if(input!=null&&!input.equals("")){
			dinput = Double.parseDouble(input);
		}
		if(output!=null&&!output.equals("")){
			doutput = Double.parseDouble(output);
		}
		if(caution_deduction!=null&&!caution_deduction.equals("")){
			dcaution_deduction = Double.parseDouble(caution_deduction);
		}
		//添加其他收入、其他支出
		hm.put("net_flow",String.valueOf(drent+dinput-doutput-dcaution_deduction));
		alCash.add(hm);
	}
	return alCash;
}
public String getRateByFlowArray(ArrayList al,ArrayList alput,String period_type,String income_number_year){
	return getRateByFlow(getRentCashArray(al,alput,period_type),income_number_year);
}
//由新利率和旧利率计算租金调整值，二分法
public String getAdjustRentByCash(ArrayList al,String newRate,String oldRate,String income_number_year){
	double dnewRate = 0;
	double dsubRate = 0;
	double doldRate = 0;
	double dadjustRate = 0;
	double iavg=10000000;
	ArrayList alcash = new ArrayList();
	if(newRate!=null&&!newRate.equals("")){
		dnewRate = Double.parseDouble(newRate);
	}
	if(oldRate!=null&&!oldRate.equals("")){
		doldRate = Double.parseDouble(oldRate);
	}
	double dold = new BigDecimal(dnewRate-dsubRate).abs().doubleValue();
	double dmaxavg = 0;
	double dminavg = 0;
	int flag = 0;
	while(new BigDecimal(dnewRate-dsubRate).abs().doubleValue()>0.000000001 &&flag<100){
			alcash = new ArrayList();
			alcash.add(al.get(0));
			for(int i=1;i<al.size();i++){
				HashMap hm = (HashMap)al.get(i);
				HashMap hmTemp = new HashMap();
				BigDecimal bigDecimal = new BigDecimal(String.valueOf(hm.get("net_flow")));
				if(dnewRate>=doldRate){
					bigDecimal = bigDecimal.add(new BigDecimal(iavg));
				}else{
					bigDecimal = bigDecimal.subtract(new BigDecimal(iavg));
				}
				hmTemp.put("net_flow",String.valueOf(bigDecimal));
				alcash.add(hmTemp);
			}
			String subRate = getRateByFlow(alcash,income_number_year);
			if(subRate!=null&&!subRate.equals("")){
				dsubRate = Double.parseDouble(subRate);
			}
			if(new BigDecimal(dnewRate-dsubRate).doubleValue()>0){
				dmaxavg = iavg;
				iavg=(iavg+dminavg)/2;
			}else if(new BigDecimal(dnewRate-dsubRate).doubleValue()<0){
				dminavg = iavg;
				iavg = (dmaxavg+iavg)/2;
			}else{
				//break;
			}
			flag++;
			System.out.println("iavg:"+iavg);
	}
	return String.valueOf(iavg);
}
public String getSumList(List list1) {
	String r_turn = "0";
	for (int i = 0; i < list1.size(); i++) {
		String tmp=(String) list1.get(i);
		if(null==tmp || tmp.equals("")){
			tmp="0";
		}
		r_turn = String.valueOf(Double.parseDouble(r_turn)
				+ Double.parseDouble(tmp));
	}
	return r_turn;
}
public String getInsurance(String method,String lease_term,String equip_amt){
	
	String insurance="";
	String p_year=String.valueOf(Integer.parseInt(lease_term)/12);
	String p_month=String.valueOf(Integer.parseInt(lease_term)%12);
	if(!p_month.equals("0")){
		p_year=String.valueOf(Integer.parseInt(p_year)+1);
	}
	
	if(method.equals("1")){//人保
		String p1=formatNumberDoubleTwo(Double.parseDouble(equip_amt)*0.78/100+418);
		String p2=formatNumberDoubleTwo(Double.parseDouble(equip_amt)*0.78/100+418);
		String p3=formatNumberDoubleTwo(Double.parseDouble(equip_amt)*0.77/100+414);
		String p4=formatNumberDoubleTwo(Double.parseDouble(equip_amt)*0.76/100+410);
		String p5=formatNumberDoubleTwo(Double.parseDouble(equip_amt)*0.51/100+130);
		String p6=formatNumberDoubleTwo(Double.parseDouble(equip_amt)*(1-9.9/100)*0.51/100+130);
		String p7=formatNumberDoubleTwo(Double.parseDouble(equip_amt)*(1-20.7/100)*0.51/100+130);
		String p8=formatNumberDoubleTwo(Double.parseDouble(equip_amt)*(1-31.5/100)*0.51/100+130);
		String p9="3208";
		String p10="3208";
		String p11="3208";
		String p12="3208";
		if(p_year.equals("0")){
			
		}else if(p_year.equals("1")){
			insurance=String.valueOf(
				(Double.parseDouble(p1)+Double.parseDouble(p5)+Double.parseDouble(p9))*0.78);
		}else if(p_year.equals("2")){
			insurance=String.valueOf(
				(Double.parseDouble(p1)+Double.parseDouble(p5)+Double.parseDouble(p9)+
				Double.parseDouble(p2)+Double.parseDouble(p6)+Double.parseDouble(p10))*0.78);
		}else if(p_year.equals("3")){
		
			insurance=String.valueOf(
				(Double.parseDouble(p1)+Double.parseDouble(p5)+Double.parseDouble(p9)+
				Double.parseDouble(p2)+Double.parseDouble(p6)+Double.parseDouble(p10)+
				Double.parseDouble(p3)+Double.parseDouble(p7)+Double.parseDouble(p11))*0.78);
		}else if(p_year.equals("4")){
			insurance=String.valueOf(
				(Double.parseDouble(p1)+Double.parseDouble(p5)+Double.parseDouble(p9)+
				Double.parseDouble(p2)+Double.parseDouble(p6)+Double.parseDouble(p10)+
				Double.parseDouble(p3)+Double.parseDouble(p7)+Double.parseDouble(p11)+
				Double.parseDouble(p4)+Double.parseDouble(p8)+Double.parseDouble(p12))*0.78);
		}else{
			insurance="-1";
		}
	}else if(method.equals("2")){//平安
		String per_amt="";
		per_amt=String.valueOf(Double.parseDouble(equip_amt)*1.17/100);
		if(p_year.equals("0")){
			
		}else if(p_year.equals("1")){
			insurance=String.valueOf(
				Double.parseDouble(per_amt));
		}else if(p_year.equals("2")){
			insurance=String.valueOf(
				Double.parseDouble(per_amt)*2);
		}else if(p_year.equals("3")){
			insurance=String.valueOf(
				Double.parseDouble(per_amt)*3);
		}else if(p_year.equals("4")){
			insurance=String.valueOf(
				Double.parseDouble(per_amt)*4);
		}else {
			insurance=String.valueOf(
				Double.parseDouble(per_amt)*5);
		}
	}else if(method.equals("3")){//平安免一年保费
		String per_amt="";
		per_amt=String.valueOf(Double.parseDouble(equip_amt)*1.17/100);
		if(p_year.equals("0")){
			
		}else if(p_year.equals("1")){
			insurance="0";
		}else if(p_year.equals("2")){
			insurance=String.valueOf(
				Double.parseDouble(per_amt));
		}else if(p_year.equals("3")){
			insurance=String.valueOf(
				Double.parseDouble(per_amt)*2);
		}else if(p_year.equals("4")){
			insurance=String.valueOf(
				Double.parseDouble(per_amt)*3);
		}else{
			insurance=String.valueOf(
				Double.parseDouble(per_amt)*4);
		}
	}else{
		insurance="-1";
	}
	insurance=formatNumberDoubleTwo(insurance);
	return insurance;
}
	public static int compare_date(String DATE1, String DATE2) {
        DateFormat df = new SimpleDateFormat("yyyy-MM-dd");// hh:mm
        try {
            Date dt1 = df.parse(DATE1);
            Date dt2 = df.parse(DATE2);
            if (dt1.getTime() > dt2.getTime()) {
                System.out.println("日期1大于日期二");
                return 1;
            } else if (dt1.getTime() < dt2.getTime()) {
                System.out.println("日期一小于日期二");
                return -1;
            } else {
                System.out.println("日期一等于日期二");
                return 0;
            }
        } catch (Exception exception) {
            exception.printStackTrace();
        }
        return 0;
    }
%>