<%@ page contentType="text/html; charset=gbk" language="java" %>
<%@ page import="dbconn.*" %>  
<%@ page import="java.sql.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ page import="java.util.ArrayList"%> 
<%@ page import="java.util.List"%> 
<%@ include file="../../func/common.jsp"%>
<jsp:useBean id="right" scope="page" class="com.filter.FilterCredit" />
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>��Ʊ - �ύ���</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/validator.js"></script>
<SCRIPT  Language="Javascript"  SRC="/tenwa/js/public.js"></SCRIPT>
<SCRIPT  Language="Javascript"  SRC="/tenwa/js/publicEvent.js"></SCRIPT>
<script language="javascript" src="/dict/js/js_dictionary.js"></script>
<script language="javascript" src="/dict/js/ajax_popupDialog.js"></script>
<!-- ���ڿؼ� -->
<script src="../../js/calend.js"></script>
<script type="text/javascript">
	function closeWin(){
		opener.parent.location.reload();
		window.close();
	}
	function form_submit(){
		
		if(change_ci()){
			form1.submit();
		}else{
			window.close();
			opener.location.reload();
		}
	}
	
	
	/**����2λС�� ������������ 
		������ģ� 
		v��ʾҪת����ֵ 
		e��ʾҪ������λ�� 
		�����������for��������ص��ˣ�
		��һ��for���С�����ұߵ������Ҳ���Ǳ���С�����ұ߶���λ��
		�ڶ���for���С������ߵ������Ҳ���Ǳ���С������߶���λ�� 
		for�����ã����Ǽ���t��ֵ��Ҳ����vӦ�÷Ŵ������С���ٱ��ı���������=t����
		for�������õ���for����������ԣ������жϺͼ������ۼƣ�ѭ������
		��e��������ʱfor����������eÿ���ۼӣ�e��ÿ���ۼӣ����Ǹ�for���첻����ѭ������������ͬʱ��Ҳ����t��ֵ�� 
		���������ԭ����round���������㱻�Ŵ�/��С���v�Ľ����Ȼ��ѽ���Ŵ�/��С����ȷ�ı��� 
	*/
	function round(v,e){ 
		var t=1; 
		for(;e>0;t*=10,e--); 
		for(;e<0;t/=10,e++); 
		//alert(Math.round(v*t)/t);
		return Math.round(v*t)/t; 
	}
	//������֤
	function check_lm(text_value){
		 text_value = trim(text_value);//��ȥ�ո�
		 //�Ƿ��ַ�����֤ 				
		 var reg_ff = /\/{2}|\/\*|-{2}|[';\"%<>]+/;
          if(text_value.match(reg_ff)){ 
              str = "��������Ʋ��ܰ��������ַ���-- /* ';\"% < > // \"��" ;
               alert(str);
              return false;
           }else{
           	  return true;
           }
	}
	
	function chack_rate(text_value){
		if(check_lm(text_value)){
			//���ʸ�ʽ: /^\d+(\.[0-9]{1,8})?$/,
			var reg_Rate =  /^\d+(\.[0-9]{1,8})?$/;
			//alert("reg_Rate��֤->"+list[i].name+"="+text_value+"----"+list[i].dataType+"--����ǣ�"+reg_Rate.test(text_value));
			if(reg_Rate.test(text_value) == false){
				str = "����Ϊ��ʵ������С���ڰ�λ����";
				alert(str);
				return false;			
			}else{
				return true;			
			}
		}
	}
	/*
    ���������� ȥ������ո���
    	return: s 2�ߵĶ���Ŀո��Ѿ�ȥ����
    	author:  sea
    	date: 2010-04-13
	*/
	function trim(s){  
  		return s.replace(/(^\s*)|(\s*$)/g,"");      
	}
	//�������ӷ�����   
 function FloatAdd(arg1,arg2){   
   var r1,r2,m;   
   try{r1=arg1.toString().split(".")[1].length}catch(e){r1=0}   
   try{r2=arg2.toString().split(".")[1].length}catch(e){r2=0}   
   m=Math.pow(10,Math.max(r1,r2))   
   return (arg1*m+arg2*m)/m   
  } 
 //��������������   
 function FloatSub(arg1,arg2){   
	 var r1,r2,m,n;   
	 try{
	 		r1 = arg1.toString().split(".")[1].length
	 	}catch(e){
	 		r1=0
	 	}   
	 try{
	 		r2=arg2.toString().split(".")[1].length
	 	}catch(e){
	 		r2=0
	 	}   
	 m = Math.pow(10,Math.max(r1,r2));   
	 //��̬���ƾ��ȳ���   
	 n = (r1>=r2)?r1:r2;   
	 return ((arg1*m-arg2*m)/m).toFixed(n);   
 }
</script>
</head>
<body onload="">
<%
	String model = getStr(request.getParameter("model"));
	
	//Ȩ�޴��� 
	String dqczy = (String) session.getAttribute("czyid");
	//���ݵ�¼�˱�Ų�ѯ��¼��������
	//String qx_value = "";//����������Ȩ�޵��ж�
	//String query_department = " select dept_name from base_department where id = ( ";
	//query_department = query_department +" select department from base_user where id = '"+dqczy+"')  ";
	//ResultSet rs_d = db.executeQuery(query_department);
	//String dept_name = "";
	//if(rs_d.next()){
	//	dept_name = getDBStr( rs_d.getString("dept_name") ) ;
	//}
	//if("".equals(dept_name) || dept_name == null){//δ�в���
	//	qx_value = "0";
	//}else if ("�ʲ�����".equals(dept_name)){
	//	qx_value = "1";
	//}else if ("�ƻ�����".equals(dept_name)){
	//	qx_value = "2";
	//}
	//rs_d.close();
	
//	if ((dqczy == null) || (dqczy.equals("")))
//	{
//	  dqczy = "����֤";
//	  response.sendRedirect("../../noright.jsp");
//	}
//	int canedit = 0;
	//���
//	if(model == null || model.equals("")){
//		if (right.CheckRight("zjcs-tx-add",dqczy) > 0) canedit=1;
//	}else if(model.equals("mod")){
//		if (right.CheckRight("zjcs-tx-mod",dqczy) > 0) canedit=1;
//	}else{
//		if (right.CheckRight("zjcs-tx-del",dqczy) > 0) canedit=1;
//	}
//	if (canedit == 0) response.sendRedirect("../../noright.jsp"v);
%>

<%
		String readonly = "true";
		String user_id = (String)session.getAttribute("czyid");//ȡ�õ�¼�˵�ID ����ȡ�õ�¼�˵�name
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");//��ʽ��ʱ��
		String nowDateTime = sdf.format(new Date());//��ǰ��ʽ��֮���ʱ��
		String Zc_num = getStr(request.getParameter("Zc_num"));//Zc_num
		String UserName = getStr(request.getParameter("UserName"));//������
		String key_id = getStr(request.getParameter("key_id"));//��Ʊ������
		System.out.println("key_id--->"+key_id);
		ResultSet rs; 
		//���ݵ�¼ID��ѯ��¼�û�����
		String user_name = "";
		rs = db.executeQuery(" select name from base_user where id = '"+user_id+"' ");//
		if(rs.next()){
			user_name = getDBStr(rs.getString("name"));
		}

		//
		List<String> list = new ArrayList<String>();
		int flag = 0;
		System.out.println("model��ֵΪ==>"+model);

		//�����ʲ����ͳ�ƶ�Ӧ�ʲ���ŵĳ����ƻ�������ܺ� �Լ� ��Ʊ�����ѿ�����ܶ� 
		//���1�����߱Ƚϣ���ȣ������ʲ������е�״̬Ϊ�����ύ ����ʾ���ύ��ˡ���ť�����ʲ������е�״̬��Ϊ������ˡ�
		//���2���ʲ���Ŷ�Ӧ�ķ�Ʊ���еġ���Ʊ���Fp_num����Ϊ�� �ʲ���������ɾ���������ʲ������е�״̬Ϊ������� ����ʾ�������ϡ���ť ���״̬��Ϊ�������ϡ�
		if("tjshenhe".equals(model)){//�ύ���
			String u_s = " update fund_Assets_Package set status = '�����'  where  Zc_num = '"+Zc_num+"'  ";
			flag = db.executeUpdate(u_s);
		}
		if("shenheOk".equals(model)){//������
			String u_s = " update fund_Assets_Package set status = '������'  where  Zc_num = '"+Zc_num+"'  ";
			flag = db.executeUpdate(u_s);
		}
		//if("mod".equals(model)){//�޸Ĵ���-
		//}
	 	
%>

<form name="form1" action="fp_save.jsp" method="post" target="" onSubmit="return Validator.Validate(this,3);">
<input type="hidden" name="model" id="model" value="<%=model%>">
<input type="hidden" name="Zc_num" id="Zc_num" value="<%=Zc_num%>">
<input type="hidden" name="key_id" id="key_id" value="<%=key_id%>">
  <!--���⿪ʼ-->
<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
	<tr valign="top" class="tree_title_txt">
		<td class="tree_title_txt"  height=26 valign="middle">
			��Ʊ &gt; �ύ���
		</td>
	</tr>
	<tr valign="top">
		<td  align=center width=100% height=100%>
<div id="mydiv" class="tabBody" style="background:#ffffff;width:96%;height:500px;overflow:auto;">
<div id="TD_tab_0">
<%
	 if("tjshenhe".equals(model)){
			if(flag > 0){
			String hrefStr="";
%>
		        <script>
					alert("�ύ��˳ɹ�!");
					opener.location.reload();
					window.close();
				</script>
<%
			}else{
%>
		        <script>
					alert("�ύ���ʧ��!");
					opener.location.reload();
					this.close();
				</script>
<%	
			}
	  }
	   if ("shenheOk".equals(model)){
			if(flag > 0){
			String hrefStr="";
%>
		        <script>
					alert("�����ϲ����ɹ�!");
					opener.location.reload();
					window.close();
				</script>
<%
			}else{
%>
		        <script>
					alert("�����ϲ���ʧ��!");
					opener.location.reload();
					this.close();
				</script>
<%	
			}
		} 
		db.close();
%>
</div>
</div>
</form>
</body>
</html>
