package com.object;

import java.util.Date;

public class FundRentPlan {

	private String contract_id;
	
	private int rent_list;
	
	private String plan_status;
	
	private String plan_date;
	
	private double eptd_rent;
	
	private double rent;
	
	private double corpus;
	
	private double year_rate;
	
	private double interest;
	
	private double input;
	
	private double output;
	
	private double caution_deduction;

	public String getContract_id() {
		return contract_id;
	}

	public void setContract_id(String contract_id) {
		this.contract_id = contract_id;
	}

	public double getCorpus() {
		return corpus;
	}

	public void setCorpus(double corpus) {
		this.corpus = corpus;
	}

	public double getEptd_rent() {
		return eptd_rent;
	}

	public void setEptd_rent(double eptd_rent) {
		this.eptd_rent = eptd_rent;
	}

	public double getInterest() {
		return interest;
	}

	public void setInterest(double interest) {
		this.interest = interest;
	}

	

	public String getPlan_date() {
		return plan_date;
	}

	public void setPlan_date(String plan_date) {
		this.plan_date = plan_date;
	}

	public String getPlan_status() {
		return plan_status;
	}

	public void setPlan_status(String plan_status) {
		this.plan_status = plan_status;
	}

	public double getRent() {
		return rent;
	}

	public void setRent(double rent) {
		this.rent = rent;
	}

	public int getRent_list() {
		return rent_list;
	}

	public void setRent_list(int rent_list) {
		this.rent_list = rent_list;
	}

	public double getYear_rate() {
		return year_rate;
	}

	public void setYear_rate(double year_rate) {
		this.year_rate = year_rate;
	}

	public double getCaution_deduction() {
		return caution_deduction;
	}

	public void setCaution_deduction(double caution_deduction) {
		this.caution_deduction = caution_deduction;
	}

	public double getInput() {
		return input;
	}

	public void setInput(double input) {
		this.input = input;
	}

	public double getOutput() {
		return output;
	}

	public void setOutput(double output) {
		this.output = output;
	}
	
	
}
