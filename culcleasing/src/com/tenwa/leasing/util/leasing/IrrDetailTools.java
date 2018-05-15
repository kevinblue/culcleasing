package com.tenwa.leasing.util.leasing;

import java.util.ArrayList;
import java.util.Hashtable;
import java.util.List;

/**
 * �ֽ�����ϸ������ ��Ŀ���ƣ�iulcleasing �����ƣ�IrrDetailTools �������� �����ˣ�ʷ��� ����ʱ�䣺2011-2-9
 * ����03:30:43 �޸��ˣ�ʷ��� �޸�ʱ�䣺2011-2-9 ����03:30:43 �޸ı�ע��
 * 
 * @version
 */
public class IrrDetailTools {

	/**
	 * �õ���֤��ֿ����List
	 * 
	 * @Title: getRentCautNew
	 * @Description:
	 * @param
	 * @param rent_list���List
	 * @param
	 * @param caut_money��֤��
	 * @param
	 * @return
	 * @return List
	 * @throws
	 */
	@SuppressWarnings("unchecked")
	public List getRentCautNew(List rentlist, String caut_money) {
		List rent_list = new ArrayList(rentlist);
		double d_total = 0;
		double dcaut = Double.parseDouble(caut_money);
		String int_s = "";// ���ڼ�¼�±��
		if (Double.parseDouble(caut_money) > 0) {
			for (int i = rent_list.size() - 1; i >= 0; i--) {
				d_total = d_total
						+ Double.parseDouble(rent_list.get(i).toString());
				int_s += i + ",";
				if (d_total > Double.parseDouble(caut_money)) {
					break;
				}
			}
			int_s = int_s.indexOf(",") > -1 ? int_s.substring(0,
					int_s.length() - 1) : int_s;// �õ����Եֿ۵������±�
			String[] i_array = int_s.split(",");// ������Եֿ۵�����±�
			for (int j = 0; j < i_array.length; j++) {
				double temp_rent = Double.parseDouble(rent_list.get(
						Integer.parseInt(i_array[j])).toString());// ���ڱ�������
				if (Double.parseDouble(rent_list.get(
						Integer.parseInt(i_array[j])).toString()) < dcaut) {
					rent_list.set(Integer.parseInt(i_array[j]), "0");// ����֤����ڵ������Ϊ0
				} else {
					rent_list.set(Integer.parseInt(i_array[j]), Double
							.parseDouble(rent_list.get(
									Integer.parseInt(i_array[j])).toString())
							- dcaut);
				}
				dcaut = dcaut - temp_rent;// �޸ı�֤��ֿ۵�ֵ
			}
		}
		return rent_list;
	}

	/**
	 * �õ���֤��ֿ����List �ֽ� ����ϸ
	 * 
	 * @Title: getRentDetails
	 * @Description:
	 * @param
	 * @param rent_list���List
	 * @param
	 * @param caut_money��֤��
	 * @param
	 * @return
	 * @return List
	 * @throws
	 */
	@SuppressWarnings("unchecked")
	public List getRentDetails(List rent_list, String caut_money) {

		// �ȹ�����������µ���� ��ϸ
		List cash_follow_detail = new ArrayList();

		double d_total = 0;
		double dcaut = Double.parseDouble(caut_money);
		String int_s = "";// ���ڼ�¼�±��
		if (Double.parseDouble(caut_money) > 0) {
			for (int i = rent_list.size() - 1; i >= 0; i--) {
				d_total = d_total
						+ Double.parseDouble(rent_list.get(i).toString());
				int_s += i + ",";
				if (d_total > Double.parseDouble(caut_money)) {
					break;
				}
			}
			int_s = int_s.indexOf(",") > -1 ? int_s.substring(0,
					int_s.length() - 1) : int_s;// �õ����Եֿ۵������±�
			String[] i_array = int_s.split(",");// ������Եֿ۵�����±�

			System.out.println("id_s:" + int_s);

			Hashtable ht = null;// ���ڱ����ֽ�������ϸ
			for (int i = 0; i < rent_list.size(); i++) {
				ht = new Hashtable();
				ht.put("follow_in", rent_list.get(i).toString());
				ht.put("follow_in_detail", "���" + rent_list.get(i).toString());
				ht.put("follow_out", "0");
				ht.put("follow_out_detail", "");
				ht.put("net_follow", rent_list.get(i).toString());

				cash_follow_detail.add(ht);
			}

			for (int j = 0; j < i_array.length; j++) {
				double temp_rent = Double.parseDouble(rent_list.get(
						Integer.parseInt(i_array[j])).toString());// ���ڱ�������
				if (Double.parseDouble(rent_list.get(
						Integer.parseInt(i_array[j])).toString()) < dcaut) {
					// rent_list.set(Integer.parseInt(i_array[j]),
					// "0");//����֤����ڵ������Ϊ0

					// �ֽ�����ϸ����
					ht = new Hashtable();
					ht.put("follow_in", rent_list.get(
							Integer.parseInt(i_array[j])).toString());
					ht.put("follow_in_detail", "���"
							+ rent_list.get(Integer.parseInt(i_array[j]))
									.toString());
					ht.put("follow_out", rent_list.get(
							Integer.parseInt(i_array[j])).toString());
					ht.put("follow_out_detail", "��֤��ֿۣ�"
							+ rent_list.get(Integer.parseInt(i_array[j]))
									.toString());
					ht.put("net_follow", "0");

					cash_follow_detail.set(Integer.parseInt(i_array[j]), ht);

				} else {
					// �ֽ�����ϸ����
					ht = new Hashtable();
					ht.put("follow_in", rent_list.get(
							Integer.parseInt(i_array[j])).toString());
					ht.put("follow_in_detail", "���"
							+ rent_list.get(Integer.parseInt(i_array[j]))
									.toString());
					ht.put("follow_out", dcaut);
					ht.put("follow_out_detail", "��֤��ֿۣ�" + dcaut);
					ht.put("net_follow", Double.parseDouble(rent_list.get(
							Integer.parseInt(i_array[j])).toString())
							- dcaut);

					cash_follow_detail.set(Integer.parseInt(i_array[j]), ht);

				}
				dcaut = dcaut - temp_rent;// �޸ı�֤��ֿ۵�ֵ
			}
		} else {

			Hashtable ht = null;
			for (int i = 0; i < rent_list.size(); i++) {
				ht = new Hashtable();
				ht.put("follow_in", rent_list.get(i).toString());
				ht.put("follow_in_detail", "���" + rent_list.get(i).toString());
				ht.put("follow_out", "0");
				ht.put("follow_out_detail", "");
				ht.put("net_follow", rent_list.get(i).toString());

				cash_follow_detail.add(ht);
			}

		}
		return cash_follow_detail;
	}

}
