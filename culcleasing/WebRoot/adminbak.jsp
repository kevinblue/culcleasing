<%@ page contentType="text/html; charset=gb2312" language="java" import="java.sql.*" errorPage="" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>����Աģʽ</title>
<link href="css/global.css" rel="stylesheet" type="text/css">
<link href="css/admin.css" rel="stylesheet" type="text/css">
<script src="js/menu.js"></script>
<base target="ifmCW">
</head>
<body>
<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td valign="top" id="menuCell">

    <div id="menutit"><!--<%= session.getAttribute("czyname")%>&nbsp;<a href="login.jsp" target="_top">Login</a>--></div> 
<div id="menu1" expmode=1> 
  <div id="menunode"> 
    <div id="menutit" onClick="expThis()">������Ϣ����</div> 
    <div id="menusub">
	<a href="ywjcxx/qyxx/qyxx_list.jsp">������Ϣ����</a><a href="ywjcxx/sjxx/sjxx_list.jsp">ʡ/ֱϽ����Ϣ</a><a href="ywjcxx/csxx/csxx_list.jsp">������Ϣ</a><a href="ywjcxx/bzxx/bzxx_list.jsp">������Ϣ</a><a href="ywjcxx/gszh/gszh_list.jsp">��˾�ڲ��˻�</a><a href="ywjcxx/hlxx/hlxx_list.jsp">������Ϣ</a><a href="ywjcxx/yhxx/yhxx_list.jsp">������Ϣ</a><a href="ywjcxx/zhlx/zhlx_list.jsp">�ʻ�����</a><a href="ywjcxx/zlwj/zlwj_list.jsp">�������</a><a href="ywjcxx/zlwjgys/zlwjgys_list.jsp">���������Ӧ��</a><a href="ywjcxx/zlwjzzs/zlwjzzs_list.jsp">�������������</a>
    </div> 
  </div> 
  <div id="menunode"> 
    <div id="menutit" onClick="expThis()">�ͻ���Ϣ����</div> 
    <div id="menusub">
	<a href="khxx/khhydl/khhydl_list.jsp">��ҵ����</a><a href="khxx/khhyxl/khhyxl_list.jsp">��ҵС��</a><a href="khxx/khjwjl/khjwjl_list.jsp">������¼</a><a href="khxx/khlbdl/khlbdl_list.jsp">������</a><a href="khxx/khlbxl/khlbxl_list.jsp">���С��</a><a href="khxx/khmpxx/khmpxx_list.jsp">��Ƭ��Ϣ</a><a href="khxx/khzygr/khzygr_list.jsp">��Ҫ������Ϣ</a><a href="khxx/khpg/khpglx_list.jsp">�ͻ�������Ϣά��</a><a href="khxx/khps/khpslx_list.jsp">�ͻ�������Ϣά��</a><a href="khxx/khpg/khpg_sel.jsp">�ͻ�����</a><a href="khxx/khps/khps_sel.jsp">�ͻ�����</a>
    </div> 
  </div>
  <div id="menunode"> 
    <div id="menutit" onClick="expThis()">�������</div> 
    <div id="menusub">
	<a href="swgl/swfa/swfa_list.jsp">���񷽰�</a>
    </div> 
  </div>
  <div id="menunode"> 
    <div id="menutit" onClick="expThis()">�ʽ����</div> 
    <div id="menusub">
	<a href="zjxx/zj/zj_listnew.jsp">�ʽ�ƽ����Ϣnew</a><a href="zjxx/zj/zj_list.jsp">�ʽ�ƽ����Ϣ</a><a href="zjxx/zjzk/zj_list.jsp">�ʽ�ƽ��������Ϣ</a><a href="zjxx/zjall/zj_list.jsp">�ʽ�ƽ����ʷ��¼</a><a href="zjxx/xjye/xjye_list.jsp">�ֽ�����</a><a href="zjxx/zjzy/zjzy_list.jsp">�ʽ�ռ�ñ�</a>
    </div> 
  </div>
  <div id="menunode"> 
    <div id="menutit" onClick="expThis()">���ʹ���</div> 
    <div id="menusub">
	<a href="rzxx/dbrz/dbrz_list.jsp">����������Ϣ</a><a href="rzxx/dbsx/dbsx_list.jsp">����������Ϣ</a><a href="rzxx/rzwhdbxmzt/xmzt_list.jsp">ά�������Ŀ״̬��Ϣ</a><a href="rzxx/rzwhsjll/ll_list.jsp">ά��ʵ��������Ϣ</a><a href="rzxx/rzwhqx/qx_list.jsp">ά��������Ϣ</a><a href="rzxx/zhdk/zhdk_list.jsp">��ѯ�ۺ��������</a><a href="rzxx/jflx/jflx_list.jsp">��ѯ������Ϣ</a><a href="rzxx/ztsx/ztsx_list.jsp">��ѯ�����������</a><a href="rzxx/xmrzzk/xmrzzk_list.jsp">��ѯ��Ŀ����״��</a>
    </div> 
  </div>
  <div id="menunode"> 
    <div id="menutit" onClick="expThis()">ͳ�Ʊ���</div> 
    <div id="menusub">
<a href="tjcx/khtj/khtj_cx.jsp">�ͻ���Ϣ�����</a><a href="tjcx/zbzjsq/zjsq_list.jsp">���������Ŀ����</a><a href="tjcx/zbzjsq/zjsq_list2.jsp">���ʵ����Ŀ����</a><a href="tjcx/zbzjsq/zjsq_list3.jsp">���Ӧ����Ŀ����</a><a href="tjcx/sybqy/sybqy_list.jsp">����ҵ��ǩԼ�ֲ�</a><a href="tjcx/ylzlzc/ylzlzc_list.jsp">ҽ�������ʲ��ֲ�</a><a href="tjcx/qyqkfl/qyqkfl_list.jsp">ǩԼ��Ŀ����ͳ��</a>
<a href="tjcx/xmjzqk/xmjzqk_list.jsp">ӡˢ��Ŀ��չ���</a><a href="tjcx/allxmjzqk/xmjzqk_list.jsp">��Ŀ��չ���ͳ��</a>
    </div> 
  </div>
	
  <div id="menunode"> 
    <div id="menutit" onClick="expThis()">�ۺϲ�ѯ</div> 
    <div id="menusub">
	<a href="zhcx/khxx/khzhcx.jsp">�ͻ���Ϣ��ѯ</a><a href="zhcx/khxx/khmpxxcx.jsp">�ͻ���Ƭ��Ϣ��ѯ</a><a href="zhcx/khxx/ylkhxxcx.jsp">ҽ�ƿͻ���Ϣ��ѯ</a><a href="zhcx/khxx/yskhxxcx.jsp">ӡˢ�ͻ���Ϣ��ѯ</a><a href="zhcx/khxx/cbkhxxcx.jsp">�����ͻ���Ϣ��ѯ</a><a href="zhcx/zjxx/zjcx.jsp">ͨ�ò�ѯ-�ʽ�</a><a href="zhcx/rzxx/rzcx.jsp">ͨ�ò�ѯ-���ʴ���</a><a href="zhcx/rzxx/rzcx2.jsp">ͨ�ò�ѯ-��������</a><a href="zhcx/rzxx/rzcx3.jsp">ͨ�ò�ѯ-������Ŀ</a><a href="zhcx/zjxx/zjtdcx.jsp">�ض���ѯ-�ʽ�</a><a href="zhcx/zjxx/zjzjtdcx.jsp">�ض���ѯ-�ʽ����</a><a href="zhcx/zjxx/zjyqtdcx.jsp">�ض���ѯ-�������</a><a href="zhcx/zjxx/zlzctdcx.jsp">�ض���ѯ-�����ʲ�</a><a href="tjcx/xmjz/xzqycx.jsp">�ض���ѯ-��Ŀ��Ϣ</a><a href="tjcx/xmbg/xmbgcx.jsp">�ض���ѯ-��Ŀ����</a>
    </div> 
  </div>
</div>
</td>
    <td><iframe id="cw" name="ifmCW"  frameborder="0" src="ywjcxx/qyxx/qyxx_list.jsp" scrolling="auto" width="100%" height="100%"></iframe>
&nbsp;</td>
  </tr>
</table>
<script>
initMenu(menu1,0);

</script>
</body>
</html>
