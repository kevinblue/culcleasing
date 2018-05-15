package test;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import util.YongYouDataSource;

public class TestOracle {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		YongYouDataSource  tt= new YongYouDataSource();
	String sql="select * from inter_fund_plan  where proj_id='12D070713'";
	try {
		ResultSet rs=tt.executeQuery(sql);
		ArrayList a=new ArrayList();
		while(rs.next()){
	    String id=rs.getString("id");
	    System.out.print(id+",");
	    a.add(id);
		String proj_id=rs.getString("proj_id");
	    System.out.print(proj_id+",");
			a.add(proj_id);
			System.out.println();
			System.out.println(a);
		}
		System.out.println();
	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	}

}
