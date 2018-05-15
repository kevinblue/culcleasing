<%@ page contentType="text/html; charset=gbk" language="java"
	errorPage="/public/pageError.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
		<title>项目基本信息</title>
		<link href="../../css/global.css" rel="stylesheet" type="text/css">
		<script src="../../js/comm.js">
</script>
		<script src="../../js/calend.js">
</script>

		<script Language="Javascript" src="../../js/jquery.js"></script>
		<script Language="Javascript" src="../../js/jquery-1.3.2.min.js"></script>
		<script language="javascript">
function clearQuery() {
	$("#queryArea input").not(":button").val("");
	$("#queryArea select").val("");
}

function waitSub() {
	
	$("#firstload").css("display", "none");
	$("#waitload").css("display", "block");
	
	var project_name = document.getElementById("project_name").value;
	var cust_name = document.getElementById("cust_name").value;
	var proj_id = document.getElementById("proj_id").value;
	if((proj_id==null||proj_id=="")&&(project_name==null||project_name=="")&&(cust_name==null||cust_name=="")){
		
		alert("请填写合同编号或项目名称或客户名称");
		return false;//直接返回本身
		//window.location;
	}else{
		
		dataNav.submit();
		
	}
	
}
</script>
		<style type="text/css">
.maintab_content_table_title2 {
	/*background-image:url(../images/pageleft_topbg_1.gif);*/
	background-color: #ffffff;
	color: #15428B;
	text-align: center;
	border-top: 1px solid #FF0000;
	position: relative;
}
</style>
	</head>

	<body onload="public_onload(0);">
		<form action="proj_basic_report.jsp" name="dataNav" method="get">
			<!--标题开始-->
			<table border="0" width="100%" cellspacing="0" cellpadding="0"
				height="25">
				<tr class="tree_title_txt">
					<td nowrap width="100%" class="tree_title_txt" valign="middle"
						id="cwCellTopTitTxt">
						项目基本信息
					</td>
				</tr>
			</table>
			<!--标题结束-->

			<!--可折叠查询开始-->
			<div style="width: 100%;" id="queryArea">
				<fieldset
					style="width: 100%; TEXT-ALIGN: center; margin: 0px 5px 0px 5px;">
					<legend>
						&nbsp;查询条件
						<img name="Changeicon" border="0" src="../../images/jt_b.gif"
							onclick="javascript:fieldsetHidden();" style="cursor: hand"
							title="显示/隐藏内容">
						&nbsp;
					</legend>
					<table border="0" width="100%" cellspacing="1" cellpadding="0">
						<tr>


					<td>项目编号:&nbsp;
						<input style="width:150px;" name="proj_id" id="proj_id" type="text" value="12D081829"> 
					</td>
							<td>
								项目名称:&nbsp;
								<input style="width: 150px;" name="project_name"
									id="project_name" type="text">
							</td>

							<td>
								客户名称:&nbsp;&nbsp;
								<input style="width: 150px;" name="cust_name" id="cust_name"
									type="text">
							</td>
							<td colspan="2" align="left">
								<input type="button" onClick="waitSub();" value="查询">
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								<input type="button" onclick="clearQuery();" value="清空">
							</td>
						</tr>
					</table>
				</fieldset>
			</div>
			<!-- 查询条件结束 -->

			<!--副标题和操作区开始-->
			<table border="0" width="100%" id="table8" cellspacing="0"
				cellpadding="0" style="margin-top: 2px;">
				<tr class="maintab">
					<td align="left" width="1%">
						<!--操作按钮开始-->
						<table border="0" cellspacing="0" cellpadding="0">
							<tr class="maintab">


								<td nowrap>
								</td>
								<!--操作按钮结束-->
							</tr>
						</table>
						<!--操作按钮结束-->
					</td>
					<td align="right" width="90%">
					</td>
				</tr>
			</table>

			<!--报表开始-->
			<div
				style="vertical-align: top; width: 100%; overflow: auto; position: relative;"
				id="mydiv">
				<table border="0" style="border-collapse: collapse;" align="center"
					width="100%">
					<tr>
						<td align="center" colspan="10">
							<h5>
								融资租赁合同台账
							</h5>
						</td>
					</tr>
					<tr class="maintab_content_table_title">
						<td align="left" style="font-weight: bold;">
							项目编号:
						</td>
						<td colspan="3">
						</td>
						<td align="left" style="font-weight: bold;">
							项目名称：
						</td>
						<td colspan="5"></td>
					</tr>
					<tr class="maintab_content_table_title">
						<td align="left" style="font-weight: bold;">
							项目状态:
						</td>
						<td colspan="3"></td>
						<td align="left" style="font-weight: bold;">
							租赁形式：
						</td>
						<td colspan="1"></td>
						<td align="left" style="font-weight: bold;">
							融资类型:
						</td>
						<td></td>
						<td align="left" style="font-weight: bold;">
							承租人:
						</td>
						<td></td>
					</tr>
					<tr class="maintab_content_table_title">
						<td align="left" style="font-weight: bold;">
							出单部门:
						</td>
						<td colspan="2"></td>
						<td align="left" style="font-weight: bold;">
							项目经理：
							<td>
						<td></td>
						<td align="left" style="font-weight: bold;">
							项目助理:
						</td>
						<td></td>
						<td align="left" style="font-weight: bold;">
							质控经理:
						</td>
						<td></td>
						<td align="left" style="font-weight: bold;">
							商务经理:
						</td>
						<td></td>
					</tr>
					<tr class="maintab_content_table_title">
						<td align="left" style="font-weight: bold;">
							项目金额:
						</td>
						<td colspan="2"></td>
						<td align="left" style="font-weight: bold;">
							融资净额:
						</td>
						<td></td>
					</tr>
					<tr><td>直租:</td></tr>
					<tr class="maintab_content_table_title">
						    <th>设备名称</th>
						    <th>规格型号</th>
						    <th>生产商</th>
						    <th>产地</th>
						    <th>供应商</th>
						    <th>单价</th>
						    <th>数量</th>
						    <th colspan="3">总价</th>
						    <th>预计到货时间</th>
						    <th>实际到货时间</th>
						    <th>设备状态</th>
      				</tr>
      				<tr><td>回租:</td></tr>
					<tr class="maintab_content_table_title">
						    <th>设备名称</th>
						    <th>规格型号</th>
						    <th>生产商</th>
						    <th>价格</th>
						    <th>数量</th>
						    <th>发票日期</th>
						    <th>发票日期</th>
						    <th>尚可使用月份</th>
						    <th>规定用月份</th>
						    <th>折现率</th>
						    <th>公司折价</th>
						    <th>折现价</th>
						    <th>总价</th>
						    <th>预计到货时间</th>
						    <th>实际到货时间</th>
						    <th>设备状态</th>
      				</tr>
      				
      				
      				
				</table>
				<table>
					<tbody>



						<tr>
							<td colspan="6">
								<div id="firstload">
									<!-- 友好提示 -->
									<center>
										<div style="margin-top: 10px">
											<font color=#808080> &nbsp;&nbsp;您好，首次载入请点击查询...</font>
										</div>
									</center>
									<!-- 友好提示结束 -->
								</div>
								<div id="waitload" style="display: none;">
									<!-- 友好提示 -->
									<center>
										<div style="margin-top: 10px">
											<img src="../../images/loading.gif"
												style="text-align: center;">
											<font color=#808080> &nbsp;&nbsp;报表载入中，请稍候...</font>
										</div>
									</center>
									<!-- 友好提示结束 -->
								</div>
							</td>
						</tr>
					</tbody>

				</table>
			</div>
			<!--报表结束-->
		</form>
	</body>
</html>