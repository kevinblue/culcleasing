<%@ page contentType="text/html; charset=gbk" language="java" errorPage=""%>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" />
<%@ include file="../../func/common_simple.jsp"%>
<%
	String sqlstr = "";
	int flag = 0;
	String sql_bh_ids = request.getParameter("sql_bh_ids");

	String sql_upd = "";

	System.out.println(sql_bh_ids);
	//首先得到那个是可以进行重置的

	if (sql_bh_ids.indexOf(",") > -1) {
		String[] obj_s = sql_bh_ids.split(",");

		//循环记录数
		for (int i = 0; i < obj_s.length; i++) {
			sql_upd += "  update fund_rent_plan set export_flag='0' where id in(select case when CHARINDEX('_','"
			+ obj_s[i]
			+ "')>0 then substring('"
			+ obj_s[i]
			+ "',0,CHARINDEX('_','"
			+ obj_s[i]
			+ "')) else '"
			+ obj_s[i] + "' end)  ";
		}
	} else {
		sql_upd += "  update fund_rent_plan set export_flag='0' where id in(select case when CHARINDEX('_','"
		+ sql_bh_ids
		+ "')>0 then substring('"
		+ sql_bh_ids
		+ "',0,CHARINDEX('_','"
		+ sql_bh_ids
		+ "')) else '"
		+ sql_bh_ids + "' end)  ";
	}

	try {
		System.out.println(sql_upd);
		db.executeUpdate(sql_upd);
		flag++;
		db.close();
	} catch (Exception e) {
		System.out.println(e);
		flag = 0;
	}
	if (flag > 0) {
%>
<script>
 	window.close();
    opener.alert("重置成功!");
	opener.location.reload();
</script>
<%
} else {
%>
<script>
	window.close();
	opener.alert("重置失败!");
	opener.location.reload();
</script>
<%
}
%>
