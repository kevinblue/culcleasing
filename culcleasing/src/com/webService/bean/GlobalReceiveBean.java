/**
 * com.tenwa.datasync.finance.bean
 */
package com.webService.bean;

/**
 * �����տ
 * 
 * @author Jaffe
 * 
 * Date:Sep 10, 2011 8:32:51 PM Email:JaffeHe@hotmail.com
 */
public class GlobalReceiveBean {
	private int id;// ����Id
	private String invcode;// ���ݺ� ��+��Ŀ+��ˮ��
	private String bcode;// ��Ŀ���� �����Ӧ���ϱ�����
	private String acode;// �տ��ʻ� �����Ӧ���ϱ�����
	private String odate;// ʵ�ʵ������� ʾ����ʽΪ��2008-1-1
	private String ccode;// ������ �����Ӧ���ϱ�����
	private String remark;// ��������
	private String rmb;// ����ҽ��
	private String modifydate;// ����ʱ�� ʾ����ʽΪ��2008-1-1
	private String offset;// �Ƿ�֤��ֿ� 0�����ֿۣ�1���ֿ�
	private String invtype;// ��������
	/*
	 * "�����������ͣ������ڻ������±���������м�� 870����֤�� 871���׸��� 872�����޹���� 873��Ԥ������Ϣ����ǰϢ��
	 * 874���մ������շ� 877��������Ϣ 878����Ϣ 880�����޷���� 881����Ϣ���� 882���ʲ���ֵ 884���������� 885������ѯ��
	 * 886�����"
	 */
	private String ordcode;// ��ͬ��
	private String picode;// ��Ŀ���
	private String pcode;// ��Ŀ����
	private String pawnsign;// ���۱�־ 0�������ۣ� 1������ ����ʶ
	private String pawnrmb;// ���ۺ��� ����ʶ
	private String pawncode;// ����ݺ� ��¼������Ŀ��Ӧ�ĸ�����ݺ�
	private String r_flags;// �����ʶ ���ֶ�Ϊ�ϱ����Ƿ���м��ȡ����ʶʹ�ã���������Ҫ������ֶ��κ�ֵ
	private String remark_o;//��ע
	private String industry;//�ڲ���ҵ

	// �����ֶ�
	private String priId;// ����
	private String para_2;//����2
	private String para_3;//����2
	private String para_4;//����2
	private String syncType;// ��������
	
	private String leas_type;//��������
	private String remark_1;//��ע
	private String remark_2;//��ע
	private String nccode;//nc����
	private String ncdeptno;//nc���ű���	
	private String sparecolumn_a;//��ѡ�ֶ�1
	private String sparecolumn_b;//��ѡ�ֶ�2

	
	
	/**
	 * @return the priId
	 */
	public String getPriId() {
		return priId;
	}

	/**
	 * @param priId
	 *            the priId to set
	 */
	public void setPriId(String priId) {
		this.priId = priId;
	}

	/**
	 * @return the syncType
	 */
	public String getSyncType() {
		return syncType;
	}

	/**
	 * @param syncType
	 *            the syncType to set
	 */
	public void setSyncType(String syncType) {
		this.syncType = syncType;
	}

	/**
	 * @return the id
	 */
	public int getId() {
		return id;
	}

	/**
	 * @param id
	 *            the id to set
	 */
	public void setId(int id) {
		this.id = id;
	}

	/**
	 * @return the invcode
	 */
	public String getInvcode() {
		return invcode;
	}

	/**
	 * @param invcode
	 *            the invcode to set
	 */
	public void setInvcode(String invcode) {
		this.invcode = invcode;
	}

	/**
	 * @return the bcode
	 */
	public String getBcode() {
		return bcode;
	}

	/**
	 * @param bcode
	 *            the bcode to set
	 */
	public void setBcode(String bcode) {
		this.bcode = bcode;
	}

	/**
	 * @return the acode
	 */
	public String getAcode() {
		return acode;
	}

	/**
	 * @param acode
	 *            the acode to set
	 */
	public void setAcode(String acode) {
		this.acode = acode;
	}

	/**
	 * @return the odate
	 */
	public String getOdate() {
		return odate;
	}

	/**
	 * @param odate
	 *            the odate to set
	 */
	public void setOdate(String odate) {
		this.odate = odate;
	}

	/**
	 * @return the ccode
	 */
	public String getCcode() {
		return ccode;
	}

	/**
	 * @param ccode
	 *            the ccode to set
	 */
	public void setCcode(String ccode) {
		this.ccode = ccode;
	}

	/**
	 * @return the remark
	 */
	public String getRemark() {
		return remark;
	}

	/**
	 * @param remark
	 *            the remark to set
	 */
	public void setRemark(String remark) {
		this.remark = remark;
	}

	/**
	 * @return the rmb
	 */
	public String getRmb() {
		return rmb;
	}

	/**
	 * @param rmb
	 *            the rmb to set
	 */
	public void setRmb(String rmb) {
		this.rmb = rmb;
	}

	/**
	 * @return the modifydate
	 */
	public String getModifydate() {
		return modifydate;
	}

	/**
	 * @param modifydate
	 *            the modifydate to set
	 */
	public void setModifydate(String modifydate) {
		this.modifydate = modifydate;
	}

	/**
	 * @return the offset
	 */
	public String getOffset() {
		return offset;
	}

	/**
	 * @param offset
	 *            the offset to set
	 */
	public void setOffset(String offset) {
		this.offset = offset;
	}

	/**
	 * @return the invtype
	 */
	public String getInvtype() {
		return invtype;
	}

	/**
	 * @param invtype
	 *            the invtype to set
	 */
	public void setInvtype(String invtype) {
		this.invtype = invtype;
	}

	/**
	 * @return the ordcode
	 */
	public String getOrdcode() {
		return ordcode;
	}

	/**
	 * @param ordcode
	 *            the ordcode to set
	 */
	public void setOrdcode(String ordcode) {
		this.ordcode = ordcode;
	}

	/**
	 * @return the picode
	 */
	public String getPicode() {
		return picode;
	}

	/**
	 * @param picode
	 *            the picode to set
	 */
	public void setPicode(String picode) {
		this.picode = picode;
	}

	/**
	 * @return the pcode
	 */
	public String getPcode() {
		return pcode;
	}

	/**
	 * @param pcode
	 *            the pcode to set
	 */
	public void setPcode(String pcode) {
		this.pcode = pcode;
	}

	/**
	 * @return the pawnsign
	 */
	public String getPawnsign() {
		return pawnsign;
	}

	/**
	 * @param pawnsign
	 *            the pawnsign to set
	 */
	public void setPawnsign(String pawnsign) {
		this.pawnsign = pawnsign;
	}

	/**
	 * @return the pawnrmb
	 */
	public String getPawnrmb() {
		return pawnrmb;
	}

	/**
	 * @param pawnrmb
	 *            the pawnrmb to set
	 */
	public void setPawnrmb(String pawnrmb) {
		this.pawnrmb = pawnrmb;
	}

	/**
	 * @return the pawncode
	 */
	public String getPawncode() {
		return pawncode;
	}

	/**
	 * @param pawncode
	 *            the pawncode to set
	 */
	public void setPawncode(String pawncode) {
		this.pawncode = pawncode;
	}

	/**
	 * @return the r_flags
	 */
	public String getR_flags() {
		return r_flags;
	}

	/**
	 * @param r_flags
	 *            the r_flags to set
	 */
	public void setR_flags(String r_flags) {
		this.r_flags = r_flags;
	}

	public String getPara_2() {
		return para_2;
	}

	public void setPara_2(String para_2) {
		this.para_2 = para_2;
	}

	public String getPara_3() {
		return para_3;
	}

	public void setPara_3(String para_3) {
		this.para_3 = para_3;
	}

	public String getPara_4() {
		return para_4;
	}

	public void setPara_4(String para_4) {
		this.para_4 = para_4;
	}

	public String getRemark_o() {
		return remark_o;
	}

	public void setRemark_o(String remark_o) {
		this.remark_o = remark_o;
	}

	public String getIndustry() {
		return industry;
	}

	public void setIndustry(String industry) {
		this.industry = industry;
	}

	public String getLeas_type() {
		return leas_type;
	}

	public void setLeas_type(String leas_type) {
		this.leas_type = leas_type;
	}

	public String getRemark_1() {
		return remark_1;
	}

	public void setRemark_1(String remark_1) {
		this.remark_1 = remark_1;
	}

	public String getRemark_2() {
		return remark_2;
	}

	public void setRemark_2(String remark_2) {
		this.remark_2 = remark_2;
	}

	public String getNccode() {
		return nccode;
	}

	public void setNccode(String nccode) {
		this.nccode = nccode;
	}
	public String getNcdeptno() {
		return ncdeptno;
	}

	public void setNcdeptno(String ncdeptno) {
		this.ncdeptno = ncdeptno;
	}

	public String getSparecolumn_a() {
		return sparecolumn_a;
	}

	public void setSparecolumn_a(String sparecolumnA) {
		sparecolumn_a = sparecolumnA;
	}

	public String getSparecolumn_b() {
		return sparecolumn_b;
	}

	public void setSparecolumn_b(String sparecolumnB) {
		sparecolumn_b = sparecolumnB;
	}

	 
	
}
