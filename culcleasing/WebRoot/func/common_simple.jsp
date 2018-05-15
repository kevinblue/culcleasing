<%@ page contentType="text/html; charset=gbk"%>
<%@ page
	import="java.math.BigDecimal,java.util.*,java.text.* "%>
<%!public int getInt(String str) //request字符串处理为数字
	{
		int result = 0;
		try {
			result = Integer.parseInt(str);
		} catch (Exception e) {
			result = 1;
		}
		return result;
	}

	public int getInt(String str, int defaultVal) //request字符串处理为数字
	{
		int result = 0;
		try {
			result = Integer.parseInt(str);
		} catch (Exception e) {
			result = defaultVal;
		}

		return result;
	}

	public String getStr(String str) //request字符串中文处理
	{
		try {
			String temp_p = str.trim();
			byte[] temp_t = temp_p.getBytes("ISO8859-1");
			String temp = new String(temp_t);
			return temp;
		} catch (Exception e) {

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
	
	public String getDBStr(String str1) //DB字符串取出处理
	{
		try {
			String temp_n = str1.trim();
			if ((temp_n == null) || (temp_n.equals(""))
					|| (temp_n.equals("null"))) {
				temp_n = "";
			} else {
			}
			return temp_n;
		} catch (Exception e) {

		}
		return "";
	}

	public String getZeroStr(String value) {
		try {
			String temp_n = value;
			if (temp_n == null || temp_n.equals("") || temp_n.equals("null")) {
				temp_n = "0";
			}
			return temp_n;
		} catch (Exception e) {

		}
		return "0";
	}

	public String getDBDateStr(String datestr) //DB时间字符串取出处理
	{
		try {
			String temp_date = datestr;
			if ((temp_date == null) || (temp_date.equals(""))
					|| (temp_date.indexOf("1900") >= 0)) {
				temp_date = "";
			} else {
				temp_date = temp_date.substring(0, 10);
			}
			return temp_date;
		} catch (Exception e) {

		}
		return "";
	}

	public BigDecimal getDBDecStr(BigDecimal decstr) //DB数字Decimal字符串取出处理
	{
		try {
			BigDecimal temp_dec = decstr;
			if (temp_dec == null) {
				temp_dec = new BigDecimal("0.00");
			} else {
				temp_dec = decstr;
			}
			return temp_dec;
		} catch (Exception e) {

		}
		return new BigDecimal("0.00");
	}

	public String getSystemDate(int rtype) //返回系统时间  0--返回时间字符串  1--返回sql时间字符串
	{
		try {
			Calendar cal = Calendar.getInstance();
			String module = "yyyy-MM-dd";
			if (rtype == 2) {
				module = "yyyyMMdd";
			} else if (rtype == 3) {
				module = "yyyyMMddHHmmss";
			} else if(rtype == 4){
				module = "yyyy-MM-dd HH:mm:ss";
			}
			SimpleDateFormat formatter1 = new SimpleDateFormat(module);
			String fld_date = formatter1.format(cal.getTime());
			if (rtype == 0)
				return fld_date;
			else if (rtype == 1)
				return "'" + fld_date + "'"; //sql server
			//return "to_date("+fld_date+",'yyyy-mm-dd')";    //oracle
			else if (rtype == 3)
				return fld_date;
			else
				return fld_date;
		} catch (Exception e) {

		}
		return "null";
	}
	
	public String getSystemDate() //返回系统时间 
	{
		try {
			Calendar cal = Calendar.getInstance();
			String module = "yyyy-MM-dd HH:mm:ss";
			SimpleDateFormat formatter1 = new SimpleDateFormat(module);
			String fld_date = formatter1.format(cal.getTime());
			
			return "'" + fld_date + "'"; //sql server
			
		} catch (Exception e) {

		}
		return "null";
	}
	public int getCurrentDatePart(int part) //返回系统年份日期部分
	{
		Calendar ca = Calendar.getInstance();
		ca.setTime(new java.util.Date());
		int year = ca.get(Calendar.YEAR);
		int month = ca.get(Calendar.MONTH);
		int day = ca.get(Calendar.DAY_OF_MONTH);
		if (part == 1) {
			return year;
		} else if (part == 2) {
			return (month + 1);
		} else {
			return day;
		}
	}

	public String formatNumberStr(String numstr, String style) 
	{
		try {
			String temp_num = numstr;
			if ((temp_num == null) || (temp_num.equals(""))) {
				temp_num = "";
			} else {
				// java.text.DecimalFormat ft =  new java.text.DecimalFormat("#,##0.00");
				java.text.DecimalFormat ft = new java.text.DecimalFormat(style);
				BigDecimal bd = new BigDecimal(temp_num);
				temp_num = ft.format(bd);

			}
			return temp_num;
		} catch (Exception e) {
		}
		return "";
	}

	public String formatNumberDouble(double numstr) 
	{
		try {
			String temp_num = String.valueOf(numstr);
			if ((temp_num == null) || (temp_num.equals(""))) {
				temp_num = "";
			} else {
				java.text.DecimalFormat ft = new java.text.DecimalFormat(
						"#,##0.00");
				//java.text.DecimalFormat ft =  new java.text.DecimalFormat(style); 
				BigDecimal bd = new BigDecimal(temp_num);
				temp_num = ft.format(bd);

			}
			return temp_num;
		} catch (Exception e) {
		}
		return "";
	}

	public String formatNumberDoubleTwo(String str) {
		try {
			String temp_num = str;
			if ((temp_num == null) || (temp_num.equals(""))) {
				temp_num = "0.00";
			} else {
				java.text.DecimalFormat ft = new java.text.DecimalFormat(
						"###0.00");
				//java.text.DecimalFormat ft =  new java.text.DecimalFormat(style); 
				BigDecimal bd = new BigDecimal(temp_num);
				temp_num = ft.format(bd);

			}
			return temp_num;
		} catch (Exception e) {
		}
		return "";
	}

	public String formatNumberDoubleTwo(double str) {
		try {
			String temp_num = String.valueOf(str);
			if ((temp_num == null) || (temp_num.equals(""))) {
				temp_num = "0.00";
			} else {
				java.text.DecimalFormat ft = new java.text.DecimalFormat(
						"###0.00");
				//java.text.DecimalFormat ft =  new java.text.DecimalFormat(style); 
				BigDecimal bd = new BigDecimal(temp_num);
				temp_num = ft.format(bd);

			}
			return temp_num;
		} catch (Exception e) {
		}
		return "";
	}%>