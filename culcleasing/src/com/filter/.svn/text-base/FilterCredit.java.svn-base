package com.filter;

import java.util.*;
import java.sql.*;

import com.Tools;
import com.parse.xml.ParseXMLConfigFactory;


import dbconn.Conn;


public class FilterCredit {
	
	public int CheckRight(String operate_id,String user_id){
		ArrayList array = null;
		int iCredit = 0;
		
		//if(checkCredit(operate_id)){
			array = CheckDept(user_id);
			if(array!=null){
				for(int i=0;i<array.size();i++){
					iCredit+=getCreditByDept(operate_id,"dept",String.valueOf(array.get(i)));
				}
			}
			
			ArrayList group = null;
			group = CheckGroup(user_id);
			if(group!=null){
				for(int i=0;i<group.size();i++){
					iCredit+=getCreditByDept(operate_id,"group",String.valueOf(group.get(i)));
				}
			}
			
		
			if(user_id!=null){
					iCredit+=getCreditByDept(operate_id,"person",user_id);
			}
//		}else{
//			iCredit = 1;
//		}
		return iCredit;
	}
	
	
	
	private boolean checkCredit(String operate_id) {
		// TODO Auto-generated method stub
		boolean reflag = false;
		String sql = "";
		sql = "select credit_flag from base_operate where operate_id='"+operate_id+"'";
		Conn conn = new Conn();
		ResultSet rs  = null;
		try{
			
			rs = conn.executeQuery(sql);
			if(rs.next()){
				String flag = Tools.getDBStr(rs.getString("credit_flag"));
				
				if(flag.equals("1")){
					reflag = true;
				}
			}
			rs.close();
		}catch(Exception e){
			System.out.println(e);
		}finally{
			conn.close();
		}
		return reflag;
	}

	private ArrayList CheckRole(String user_id) {
		// TODO Auto-generated method stub
		ArrayList array = CheckDept(user_id);
		ArrayList group = new ArrayList();
		if(array!=null){
			for(int i=0;i<array.size();i++){
				String dept = (String)array.get(i);
				String sql = "";
				sql = "select role_id from base_role where role_staff='"+user_id+"' and dept='"+dept+"'";
				System.out.println(sql);
				Conn conn = new Conn();
				ResultSet rs  = null;
				try{
					rs = conn.executeQuery(sql);
					while(rs.next()){
						group.add(rs.getString("role_id"));
					}
					rs.close();
				}catch(Exception e){
					System.out.println(e);
				}finally{
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
		sql = "select group_id from base_group_user_relation where user_id='"+user_id+"'";
		System.out.println(sql);
		Conn conn = new Conn();
		ResultSet rs  = null;
		try{
			rs = conn.executeQuery(sql);
			while(rs.next()){
				group.add(rs.getString("group_id"));
			}
			rs.close();
		}catch(Exception e){
			System.out.println(e);
		}finally{
			conn.close();
		}
		return group;
	}

	public String getUserName(String user_id){
		String sql = "";
		sql = "select name from base_user where id='"+user_id+"'";
		System.out.println(sql);
		Conn conn = new Conn();
		ResultSet rs  = null;
		String user_name = "";
		try{
			rs = conn.executeQuery(sql);
			if(rs.next()){
				user_name = rs.getString("name");
			}
			rs.close();
		}catch(Exception e){
			System.out.println(e);
		}finally{
			conn.close();
		}
		return user_name;
	}
	
	public int getCreditByDept(String operate_id,String credit_type_id,String credit_group_id){
		String sql = "";
		sql = "select count(*) from base_operate_credit where 1=1 ";
		sql+= " and operate_id='"+operate_id+"'";
		sql+= " and credit_type_id='"+credit_type_id+"'";
		sql+= " and credit_group_id like '%"+credit_group_id+"%'";
		System.out.println(sql);
		Conn conn = new Conn();
		ResultSet rs  = null;
		int iReturn = 0;
		try{
			rs = conn.executeQuery(sql);
			if(rs.next()){
				iReturn = rs.getInt(1);
			}
			rs.close();
		}catch(Exception e){
			System.out.println(e);
		}finally{
			conn.close();
		}
		return iReturn;
	}
	
	public ArrayList CheckDept(String user_id){
		ArrayList al = new ArrayList();
		String sql = "";
		sql = "select base_user.department,base_department.superior_dept from base_user inner join base_department on base_user.department = base_department.id where base_user.id='"+user_id+"'";
		System.out.println(sql);
		Conn conn = new Conn();
		ResultSet rs  = null;
		String strDept = null;
		String sprDept = null;
		try{
			rs = conn.executeQuery(sql);
			while(rs.next()){
				strDept = rs.getString("department");
				sprDept = rs.getString("superior_dept");
				al.add(strDept);
				if(sprDept!=null&&!sprDept.equals("")&&sprDept.indexOf("NULL")==-1&&strDept.indexOf("null")==-1){
					al.addAll(getSprDept(sprDept));
				}
			}
			rs.close();
		}catch(Exception e){
			System.out.println(e);
		}finally{
			conn.close();
		}
		return al;
	}
	
	public ArrayList getSprDept(String dept){
		String sql = "";
		sql = "select base_department.superior_dept from base_department where base_department.id='"+dept+"'";
		System.out.println(sql);
		Conn conn = new Conn();
		ResultSet rs  = null;
		String strDept = null;
		ArrayList al = new ArrayList();
		try{
			rs = conn.executeQuery(sql);
			if(rs.next()){
				strDept = rs.getString("superior_dept");
			}
			al.add(dept);
			if(strDept!=null&&!strDept.equals("")&&strDept.indexOf("NULL")==-1&&strDept.indexOf("null")==-1){
				al.addAll(getSprDept(strDept));
			}
			rs.close();
		}catch(Exception e){
			System.out.println(e);
		}finally{
			conn.close();
		}
		return al;
	}



	public boolean adminACL(String userSno) {
		// TODO Auto-generated method stub
		String user_name = "";
		user_name=getUserName(userSno);
		Hashtable ht = null;
		ParseXMLConfigFactory parse = new ParseXMLConfigFactory();
		String admin = "";
		try{
			ht = parse.getConfiguration();
			admin = (String)ht.get("admin");
		}catch(Exception e){
			System.out.println(e);
		}
		if(admin.indexOf(user_name)!=-1){
			return true;
		}
		return false;
	}

}
