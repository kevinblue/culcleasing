package com.tenwa.leasing.web.filter;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Hashtable;

import com.tenwa.leasing.dao.Conn;
import com.tenwa.leasing.util.xml.ParseXMLConfigFactory;

public class FilterCredit {

	public int CheckRight(String operate_id, String user_id) {
		ArrayList array = null;
		array = CheckDept(user_id);
		int iCredit = 0;
		if (array != null) {
			for (int i = 0; i < array.size(); i++) {
				iCredit += getCreditByDept(operate_id, "dept", String
						.valueOf(array.get(i)));
			}
		}
		ArrayList group = null;
		group = CheckGroup(user_id);
		if (group != null) {
			for (int i = 0; i < group.size(); i++) {
				iCredit += getCreditByDept(operate_id, "group", String
						.valueOf(group.get(i)));
			}
		}
		ArrayList role = null;
		// role = CheckRole(user_id);
		// if(role!=null){
		// for(int i=0;i<role.size();i++){
		// iCredit+=getCreditByDept(operate_id,"group",String.valueOf(role.get(i)));
		// }
		// }

		String user_name = "";
		user_name = getUserName(user_id);
		if (user_name == null || user_name.equals("")) {
			return 0;
		}
		Hashtable ht = null;
		ParseXMLConfigFactory parse = new ParseXMLConfigFactory();
		String admin = "";
		try {
			ht = parse.getConfiguration();
			admin = (String) ht.get("admin");
		} catch (Exception e) {
			System.out.println(e);
		}
		if (admin.indexOf(user_name) != -1) {
			return 1;
		}
		return iCredit;
	}

	private ArrayList CheckRole(String user_id) {
		// TODO Auto-generated method stub
		ArrayList array = CheckDept(user_id);
		ArrayList group = new ArrayList();
		if (array != null) {
			for (int i = 0; i < array.size(); i++) {
				String dept = (String) array.get(i);
				String sql = "";
				sql = "select role_id from base_role where role_staff='"
						+ user_id + "' and dept='" + dept + "'";
				System.out.println(sql);
				Conn conn = new Conn();
				ResultSet rs = null;
				try {
					rs = conn.executeQuery(sql);
					while (rs.next()) {
						group.add(rs.getString("role_id"));
					}
					rs.close();
				} catch (Exception e) {
					System.out.println(e);
				} finally {
					conn.close();
				}
			}
		}
		return group;
	}

	private ArrayList CheckGroup(String user_id) {
		// TODO Auto-generated method stub
		ArrayList group = new ArrayList();
		String sql = "";
		sql = "select group_name from dbo.v_base_group where user_id='"
				+ user_id + "'";
		System.out.println(sql);
		Conn conn = new Conn();
		ResultSet rs = null;
		try {
			rs = conn.executeQuery(sql);
			while (rs.next()) {
				group.add(rs.getString("group_name"));
			}
			rs.close();
		} catch (Exception e) {
			System.out.println(e);
		} finally {
			conn.close();
		}
		return group;
	}

	public String getUserName(String user_id) {
		String sql = "";
		sql = "select name from base_user where id='" + user_id + "'";
		System.out.println(sql);
		Conn conn = new Conn();
		ResultSet rs = null;
		String user_name = "";
		try {
			rs = conn.executeQuery(sql);
			if (rs.next()) {
				user_name = rs.getString("name");
			}
			rs.close();
		} catch (Exception e) {
			System.out.println(e);
		} finally {
			conn.close();
		}
		return user_name;
	}

	public int getCreditByDept(String operate_id, String credit_type_id,
			String credit_group_id) {
		String sql = "";
		sql = "select count(*) from base_operate_credit where 1=1 ";
		sql += " and operate_id='" + operate_id + "'";
		sql += " and credit_type_id='" + credit_type_id + "'";
		sql += " and credit_group_id like '%" + credit_group_id + "%'";
		System.out.println(sql);
		Conn conn = new Conn();
		ResultSet rs = null;
		int iReturn = 0;
		try {
			rs = conn.executeQuery(sql);
			if (rs.next()) {
				iReturn = rs.getInt(1);
			}
			rs.close();
		} catch (Exception e) {
			System.out.println(e);
		} finally {
			conn.close();
		}
		return iReturn;
	}

	public ArrayList CheckDept(String user_id) {
		ArrayList al = new ArrayList();
		String sql = "";
		sql = "select base_user.department,base_department.id,base_department.parent_deptno from base_user inner join base_department on base_user.department = base_department.id where base_user.id='"
				+ user_id + "'";
		System.out.println(sql);
		Conn conn = new Conn();
		ResultSet rs = null;
		String strDept = null;
		String sprDept = null;
		try {
			rs = conn.executeQuery(sql);
			while (rs.next()) {
				sprDept = rs.getString("parent_deptno");
				strDept = rs.getString("id");
				al.add(strDept);
				if (sprDept != null && !sprDept.equals("")
						&& sprDept.indexOf("NULL") == -1
						&& strDept.indexOf("null") == -1) {
					al.addAll(getSprDept(sprDept));
				}
			}
			rs.close();
		} catch (Exception e) {
			System.out.println(e);
		} finally {
			conn.close();
		}
		return al;
	}

	public ArrayList getSprDept(String dept) {
		String sql = "";
		sql = "select base_department.id from base_department where base_department.id='"
				+ dept + "'";
		System.out.println(sql);
		Conn conn = new Conn();
		ResultSet rs = null;
		String strDept = null;
		ArrayList al = new ArrayList();
		try {
			rs = conn.executeQuery(sql);
			if (rs.next()) {
				strDept = rs.getString("id");
			}
			al.add(dept);
			if (strDept != null && !strDept.equals("")
					&& strDept.indexOf("NULL") == -1
					&& strDept.indexOf("null") == -1) {
				al.addAll(getSprDept(strDept));
			}
			rs.close();
		} catch (Exception e) {
			System.out.println(e);
		} finally {
			conn.close();
		}
		return al;
	}

}
