package com.tenwa.culc.financing.util.interestDateFormula;

import java.math.BigDecimal;
import java.util.Date;

public class PBCRate {
	private Date adjust_time;
	private Date rate_start_date;
	private Date rate_end_date;
	private BigDecimal base_rate_one;
	private BigDecimal base_rate_three;
	private BigDecimal base_rate_five;
	private BigDecimal base_rate_aboveFive;
	public Date getAdjust_time() {
		return adjust_time;
	}
	public void setAdjust_time(Date adjust_time) {
		this.adjust_time = adjust_time;
	}
	public Date getRate_start_date() {
		return rate_start_date;
	}
	public void setRate_start_date(Date rate_start_date) {
		this.rate_start_date = rate_start_date;
	}
	public Date getRate_end_date() {
		return rate_end_date;
	}
	public void setRate_end_date(Date rate_end_date) {
		this.rate_end_date = rate_end_date;
	}
	public BigDecimal getBase_rate_one() {
		return base_rate_one;
	}
	public void setBase_rate_one(BigDecimal base_rate_one) {
		this.base_rate_one = base_rate_one;
	}
	public BigDecimal getBase_rate_three() {
		return base_rate_three;
	}
	public void setBase_rate_three(BigDecimal base_rate_three) {
		this.base_rate_three = base_rate_three;
	}
	public BigDecimal getBase_rate_five() {
		return base_rate_five;
	}
	public void setBase_rate_five(BigDecimal base_rate_five) {
		this.base_rate_five = base_rate_five;
	}
	public BigDecimal getBase_rate_aboveFive() {
		return base_rate_aboveFive;
	}
	public void setBase_rate_aboveFive(BigDecimal base_rate_aboveFive) {
		this.base_rate_aboveFive = base_rate_aboveFive;
	}
	
}
