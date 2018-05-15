<%@ page contentType="text/html; charset=gb2312" language="java" import="java.sql.*" errorPage="" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>管理员模式</title>
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
    <div id="menutit" onClick="expThis()">基础信息管理</div> 
    <div id="menusub">
	<a href="ywjcxx/qyxx/qyxx_list.jsp">区域信息管理</a><a href="ywjcxx/sjxx/sjxx_list.jsp">省/直辖市信息</a><a href="ywjcxx/csxx/csxx_list.jsp">城市信息</a><a href="ywjcxx/bzxx/bzxx_list.jsp">币种信息</a><a href="ywjcxx/gszh/gszh_list.jsp">公司内部账户</a><a href="ywjcxx/hlxx/hlxx_list.jsp">汇率信息</a><a href="ywjcxx/yhxx/yhxx_list.jsp">银行信息</a><a href="ywjcxx/zhlx/zhlx_list.jsp">帐户类型</a><a href="ywjcxx/zlwj/zlwj_list.jsp">租赁物件</a><a href="ywjcxx/zlwjgys/zlwjgys_list.jsp">租赁物件供应商</a><a href="ywjcxx/zlwjzzs/zlwjzzs_list.jsp">租赁物件制造商</a>
    </div> 
  </div> 
  <div id="menunode"> 
    <div id="menutit" onClick="expThis()">客户信息管理</div> 
    <div id="menusub">
	<a href="khxx/khhydl/khhydl_list.jsp">行业大类</a><a href="khxx/khhyxl/khhyxl_list.jsp">行业小类</a><a href="khxx/khjwjl/khjwjl_list.jsp">交往记录</a><a href="khxx/khlbdl/khlbdl_list.jsp">类别大类</a><a href="khxx/khlbxl/khlbxl_list.jsp">类别小类</a><a href="khxx/khmpxx/khmpxx_list.jsp">名片信息</a><a href="khxx/khzygr/khzygr_list.jsp">重要个人信息</a><a href="khxx/khpg/khpglx_list.jsp">客户评估信息维护</a><a href="khxx/khps/khpslx_list.jsp">客户评审信息维护</a><a href="khxx/khpg/khpg_sel.jsp">客户评估</a><a href="khxx/khps/khps_sel.jsp">客户评审</a>
    </div> 
  </div>
  <div id="menunode"> 
    <div id="menutit" onClick="expThis()">商务管理</div> 
    <div id="menusub">
	<a href="swgl/swfa/swfa_list.jsp">商务方案</a>
    </div> 
  </div>
  <div id="menunode"> 
    <div id="menutit" onClick="expThis()">资金管理</div> 
    <div id="menusub">
	<a href="zjxx/zj/zj_listnew.jsp">资金平衡信息new</a><a href="zjxx/zj/zj_list.jsp">资金平衡信息</a><a href="zjxx/zjzk/zj_list.jsp">资金平衡作扣信息</a><a href="zjxx/zjall/zj_list.jsp">资金平衡历史记录</a><a href="zjxx/xjye/xjye_list.jsp">现金余额表</a><a href="zjxx/zjzy/zjzy_list.jsp">资金占用表</a>
    </div> 
  </div>
  <div id="menunode"> 
    <div id="menutit" onClick="expThis()">融资管理</div> 
    <div id="menusub">
	<a href="rzxx/dbrz/dbrz_list.jsp">单笔融资信息</a><a href="rzxx/dbsx/dbsx_list.jsp">单笔授信信息</a><a href="rzxx/rzwhdbxmzt/xmzt_list.jsp">维护打包项目状态信息</a><a href="rzxx/rzwhsjll/ll_list.jsp">维护实际利率信息</a><a href="rzxx/rzwhqx/qx_list.jsp">维护期限信息</a><a href="rzxx/zhdk/zhdk_list.jsp">查询综合融资情况</a><a href="rzxx/jflx/jflx_list.jsp">查询季付利息</a><a href="rzxx/ztsx/ztsx_list.jsp">查询总体授信情况</a><a href="rzxx/xmrzzk/xmrzzk_list.jsp">查询项目融资状况</a>
    </div> 
  </div>
  <div id="menunode"> 
    <div id="menutit" onClick="expThis()">统计报表</div> 
    <div id="menusub">
<a href="tjcx/khtj/khtj_cx.jsp">客户信息库汇总</a><a href="tjcx/zbzjsq/zjsq_list.jsp">租金逾期项目报表</a><a href="tjcx/zbzjsq/zjsq_list2.jsp">租金实收项目报表</a><a href="tjcx/zbzjsq/zjsq_list3.jsp">租金应收项目报表</a><a href="tjcx/sybqy/sybqy_list.jsp">各事业部签约分布</a><a href="tjcx/ylzlzc/ylzlzc_list.jsp">医疗租赁资产分布</a><a href="tjcx/qyqkfl/qyqkfl_list.jsp">签约项目分类统计</a>
<a href="tjcx/xmjzqk/xmjzqk_list.jsp">印刷项目进展情况</a><a href="tjcx/allxmjzqk/xmjzqk_list.jsp">项目进展情况统计</a>
    </div> 
  </div>
	
  <div id="menunode"> 
    <div id="menutit" onClick="expThis()">综合查询</div> 
    <div id="menusub">
	<a href="zhcx/khxx/khzhcx.jsp">客户信息查询</a><a href="zhcx/khxx/khmpxxcx.jsp">客户名片信息查询</a><a href="zhcx/khxx/ylkhxxcx.jsp">医疗客户信息查询</a><a href="zhcx/khxx/yskhxxcx.jsp">印刷客户信息查询</a><a href="zhcx/khxx/cbkhxxcx.jsp">船舶客户信息查询</a><a href="zhcx/zjxx/zjcx.jsp">通用查询-资金</a><a href="zhcx/rzxx/rzcx.jsp">通用查询-融资贷款</a><a href="zhcx/rzxx/rzcx2.jsp">通用查询-融资授信</a><a href="zhcx/rzxx/rzcx3.jsp">通用查询-融资项目</a><a href="zhcx/zjxx/zjtdcx.jsp">特定查询-资金</a><a href="zhcx/zjxx/zjzjtdcx.jsp">特定查询-资金租金</a><a href="zhcx/zjxx/zjyqtdcx.jsp">特定查询-租金逾期</a><a href="zhcx/zjxx/zlzctdcx.jsp">特定查询-租赁资产</a><a href="tjcx/xmjz/xzqycx.jsp">特定查询-项目信息</a><a href="tjcx/xmbg/xmbgcx.jsp">特定查询-项目报告</a>
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
