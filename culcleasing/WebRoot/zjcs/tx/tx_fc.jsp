<%@ page contentType="text/html; charset=gbk" language="java"  %>
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" />
<jsp:useBean id="db1" scope="page" class="dbconn.Conn" /> 
<jsp:useBean id="db2" scope="page" class="dbconn.Conn" /> 
<jsp:useBean id="db3" scope="page" class="dbconn.Conn" /> 
<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common.jsp"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>调息 - 租金阶段</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
</head>

<body>
<form name="list" target="xj" action="tx_zj.jsp" method="post" onSubmit="Validator.Validate(this,3)">
<table  class="title_top" width=100% align=center cellspacing=0 border="0" cellpadding="0">
	<tr valign="top">
		<td  align=center width=100%>
			<table align=center width=96%  border="0" cellspacing="0" cellpadding="0" style="margin-top:0px">
				<tr>
					<td>
						<table border="0" cellspacing="0" cellpadding="0">    
							<tr class="maintab_dh">
								<td nowrap >
									<BUTTON class="btn_2" name="btnSave" value="调整回笼计划"  type="button" onclick="fun_save()">
									<img src="../../images/save.gif" align="absmiddle" border="0">调整回笼计划</button>	
									<BUTTON class="btn_2" name="btnSave" value="察看现金流量"  type="button" onclick="fun_xj()">
									<img src="../../images/save.gif" align="absmiddle" border="0">察看现金流量</button>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<%
	
	String lease_money = "";
	double dlease_money = 0;
	String contract_id = getStr(request.getParameter("contract_id"));
	String fund_id = getStr(request.getParameter("fund_id"));
	String rent_list = getStr(request.getParameter("volume"));
	String rate_date = getStr(request.getParameter("rate_date"));
	String savetype = getStr(request.getParameter("savetype"));
	String doc_id = getStr(request.getParameter("doc_id"));
	String sql = "";
	if(fund_id!=null&&!fund_id.equals("")){
		sql = "select sum(corpus) as sum_corpus from fund_rent_plan where contract_id='"+contract_id+"' and id>="+fund_id;
		System.out.println(sql);
		ResultSet rssum = db.executeQuery(sql);
		if(rssum.next()){
			lease_money = getDBStr(rssum.getString("sum_corpus"));
		}
		rssum.close();
	}
	if(lease_money!=null&&!lease_money.equals("")){
		dlease_money = Double.parseDouble(lease_money);
	}
	
	////合同总期数，期初（期末）类型,年还租次数
	int ilease_term = 0;
	String period_type = null;
	ResultSet rscond = null;
	double prin_money = 0;
	int income_number = 0;
	String lease_term = "";
	sql = "select lease_term,period_type,income_number,lease_money from contract_condition where contract_id='"+contract_id+"'";
	System.out.println(sql);
	rscond = db.executeQuery(sql);
	if(rscond.next()){
		ilease_term = rscond.getInt("lease_term")/12;
		lease_term = getDBStr(rscond.getString("lease_term"));
		period_type = getDBStr(rscond.getString("period_type"));
		income_number = Integer.parseInt(getDBStr(rscond.getString("income_number")));
		prin_money = Double.parseDouble(getDBStr(rscond.getString("lease_money")));
	}
	rscond.close();

	
	//
	int ivolume = 0;
	//总期数
	int ihave = 0;
	//当前阶段
	int stage = 0;
	//当前阶段修改后的期数 
	int iedit = 0;
	//之前阶段的总期数
	int ifront = 0;
	if(rent_list!=null&&!rent_list.equals("")){
	ivolume = Integer.parseInt(rent_list);
	}
	double dotherprincipal=0;
	ResultSet rsnumber = null;
	ArrayList al = new ArrayList();
	if(rent_list!=null&&!rent_list.equals("")){
		ivolume = Integer.parseInt(rent_list);
		sql="select * from contract_rent_stage where contract_id='"+contract_id+"'";
		System.out.println(sql);
		rsnumber = db.executeQuery(sql);
		while(rsnumber.next()){
			ihave += Integer.parseInt(getDBStr(rsnumber.getString("rent_number")));
			stage = Integer.parseInt(getDBStr(rsnumber.getString("stage_list")));
			if(ivolume<ihave){
				iedit = ivolume-ifront-1;
				break;
			}
			ifront=ihave;
		}
		rsnumber.close();
		//
		ResultSet rsStage = null;
		
		//需要调整的合同阶段
		sql = "select * from contract_rent_stage where contract_id='"+contract_id+"' and stage_list>="+stage;
		System.out.println(sql);
		rsStage = db.executeQuery(sql);
		while(rsStage.next()){
			HashMap hm = new HashMap ();
			hm.put("stage_list",getDBStr(rsStage.getString("stage_list")));
			hm.put("rent_number",getDBStr(rsStage.getString("rent_number")));
			hm.put("return_ratio",getDBStr(rsStage.getString("return_ratio")));
			hm.put("return_amt",getDBStr(rsStage.getString("return_amt")));
			hm.put("year_rate",getDBStr(rsStage.getString("year_rate")));
			hm.put("stage_rent",getDBStr(rsStage.getString("stage_rent")));
			hm.put("old_year_rate",getDBStr(rsStage.getString("year_rate")));
			hm.put("old_stage_rent",getDBStr(rsStage.getString("stage_rent")));
			al.add(hm);
			if(!getDBStr(rsStage.getString("stage_list")).equals(String.valueOf(stage))){
				dotherprincipal += Double.parseDouble(getDBStr(rsStage.getString("return_amt")));
			}
		}
		
		sql = "select sum(return_amt) as return_amt from contract_rent_stage where contract_id='"+contract_id+"' and stage_list>="+stage;
		System.out.println(sql);
		ResultSet rsAmt = db.executeQuery(sql);
		double sumamt = 0;
		if(rsAmt.next()){
			sumamt = Double.parseDouble(getDBStr(rsAmt.getString("return_amt")));
		}
		//调整租金阶段，分离出需要调整的租金阶段
		if(iedit==0){
			//当前及之后阶段的租金计划直接取消，重新计算
		}else{
			//当前阶段部分记录需要进行修改，之后阶段全部重新计算，dotherprincipal需要修改的租金阶段的本金总额-dlease_money开始调息的租金计划的剩余本金总额=不需要调息的阶段的本金
			HashMap hm = (HashMap)al.get(0);
			System.out.println("sumamt:"+String.valueOf(sumamt));
			System.out.println("dlease_money:"+dlease_money);
			System.out.println("return_amt - (sumamt - dlease_money):"+String.valueOf(Double.parseDouble(String.valueOf(hm.get("return_amt")))-(sumamt - dlease_money)));
			hm.put("return_ratio",String.valueOf((Double.parseDouble(String.valueOf(hm.get("return_amt")))-(sumamt - dlease_money))/prin_money*100));
			hm.put("return_amt",String.valueOf(Double.parseDouble(String.valueOf(hm.get("return_amt")))-(sumamt - dlease_money)));
			hm.put("rent_number",String.valueOf(Integer.parseInt(String.valueOf(hm.get("rent_number")))-iedit));
			al.set(0,hm);
		}
		
		
		String sign_date = null;
		//合同签约时的时间
		sql = "select sign_date from contract_info where contract_id='"+contract_id+"'";
		System.out.println(sql);
		ResultSet rsDate = db.executeQuery(sql);
		if(rsDate.next()){
			sign_date = getDBDateStr(rsDate.getString("sign_date"));
		}
		//旧的央行利率B
		double ointerest = 0;
		sql = "select * from fund_standard_interest where start_date<'"+sign_date+"' order by start_date desc";
		System.out.println(sql);
		ResultSet rsIn = db.executeQuery(sql);
		if(rsIn.next()){
			if(ilease_term>5){
				ointerest = Double.parseDouble(getDBStr(rsIn.getString("base_rate_abovefive")));
			}else if(ilease_term==5){
				ointerest = Double.parseDouble(getDBStr(rsIn.getString("base_rate_five")));
			}
			else if(ilease_term>=3){
				ointerest = Double.parseDouble(getDBStr(rsIn.getString("base_rate_three")));
			}
			else if(ilease_term>=1){
				ointerest = Double.parseDouble(getDBStr(rsIn.getString("base_rate_one")));
			}else if (ilease_term<1){
				ointerest = Double.parseDouble(getDBStr(rsIn.getString("base_rate_half")));
			}
		}
		//调息时央行利率C
		double linterest = 0;
		sql = "select * from fund_standard_interest where start_date<'"+rate_date+"' order by start_date desc";
		System.out.println(sql);
		ResultSet rsInl = db.executeQuery(sql);
		if(rsInl.next()){
			if(ilease_term>5){
				linterest = Double.parseDouble(getDBStr(rsInl.getString("base_rate_abovefive")));
			}else if(ilease_term==5){
				linterest = Double.parseDouble(getDBStr(rsInl.getString("base_rate_five")));
			}
			else if(ilease_term>=3){
				linterest = Double.parseDouble(getDBStr(rsInl.getString("base_rate_three")));
			}
			else if(ilease_term>=1){
				linterest = Double.parseDouble(getDBStr(rsInl.getString("base_rate_one")));
			}else if (ilease_term<1){
				linterest = Double.parseDouble(getDBStr(rsInl.getString("base_rate_half")));
			}
		}
		//A
		double stagerate = 0;
		//D
		double nstagerate = 0;
		double nrent = 0;
		double dotherlease_money = 0;
		//所有租金
		double dallRent = 0;
		double dallprincipal = 0;
		//调整利息、租金
		dotherlease_money = Double.parseDouble(lease_money);
		if(al.size()>0){
			for(int j=0;j<al.size();j++){
				
				HashMap hm = (HashMap)al.get(j);
				//A
				stagerate = Double.parseDouble(String.valueOf(hm.get("year_rate")));
				if(stagerate>=ointerest){
					nstagerate = stagerate - (ointerest - linterest);
				}else{
					nstagerate = stagerate*linterest/ointerest;
				}
				String rent_number = (String)hm.get("rent_number");
				double dreturn_amt = Double.parseDouble((String)hm.get("return_amt"));
				System.out.println("nstagerate:"+nstagerate);
				System.out.println("rent_number:"+rent_number);
				System.out.println("dotherlease_money:"+dotherlease_money);
				System.out.println("dotherlease_money-dreturn_amt:"+(dotherlease_money-dreturn_amt));
				System.out.println("period_type:"+period_type);
				String nstage_rent = getPMT(String.valueOf(nstagerate/(income_number*100)),rent_number,"-"+String.valueOf(dotherlease_money),String.valueOf(dotherlease_money-dreturn_amt),period_type);
				hm.put("year_rate",String.valueOf(nstagerate));
				hm.put("stage_rent",nstage_rent);
				al.set(j,hm);
				dotherlease_money -= dreturn_amt;
				dallRent+=Double.parseDouble(nstage_rent);
			}
		}
	}
	
	
 %>
<input type="hidden" name="lease_money" value=<%=lease_money %>>
<input type="hidden" name="fund_id" value=<%=fund_id %>>
<input type="hidden" name="savetype" value="tx">
<input type="hidden" name="contract_id" value="<%=contract_id %>">
<input type="hidden" name="volume" value="<%=rent_list %>">
<input type="hidden" name="doc_id" value="<%=doc_id %>">
<input type="hidden" name="income_number" value="<%=income_number %>">
<input type="hidden" name="lease_term" value="<%=lease_term %>">
<input type="hidden" name="period_type" value="<%=period_type %>">

<div id="divH" class="tabBody" style="background:#ffffff;width:100%;overflow:auto;">
<div id="TD_tab_0">
    <table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" cellspacing="1" width="100%" class="maintab_content_table">
      <tr class="maintab_content_table_title">
      	<th>期数</th>
		<th>本金占用比率</th>
		<th>本金占用额</th>
		<th>利率</th>
		<th>租金</th>
      </tr>
      <%
     	if(al!=null){
     		for(int i=1;i<=al.size();i++){
     		HashMap hm = (HashMap)al.get(i-1);
     		String stage_list = (String)hm.get("stage_list");
     		String rent_number = (String)hm.get("rent_number");
     		String return_ratio = (String)hm.get("return_ratio");
     		String return_amt = (String)hm.get("return_amt");
     		String year_rate = (String)hm.get("year_rate");
     		String stage_rent = (String)hm.get("stage_rent");
     		String old_year_rate = (String)hm.get("old_year_rate");
     		String old_stage_rent = (String)hm.get("old_stage_rent");
     		double dother = 0;
			double dreturn_amt = 0;
			if(return_amt!=null&&!return_amt.equals("")){
				dreturn_amt=Double.parseDouble(return_amt);
			}
			dother = dlease_money-dreturn_amt;
			dlease_money = dother;
		%>
      <tr class="cwDLRow" >
        <td align="center"><input type="hidden" name="stage_list" value="<%=stage_list %>"><input type="text" name="volume<%=stage_list %>" size="5" value="<%=rent_number %>"> 期</td>
        <td align="center"><input type="text" name="principal_rate<%=stage_list %>" maxlength="3" size="10" value="<%=return_ratio %>" onPropertychange="fun_pcpl(document.forms[0].principal_rate<%=stage_list %>,document.forms[0].principal_money<%=stage_list %>,document.forms[0].other_rent<%=stage_list %>,document.forms[0].lease_money.value)"> %</td>
		<td align="center"><input type="text" name="principal_money<%=stage_list %>" size="10" value="<%=return_amt %>"> 元<input type="hidden" name="other_rent<%=stage_list %>" value="<%=dother %>"></td>
		<td align="center"><input type="text" name="old_year_rate<%=stage_list %>" value="<%=old_year_rate %>" size="10"> 改为 <input type="text" name="rate<%=stage_list %>" size="10" value="<%=year_rate %>" onPropertychange="fun_rent(document.forms[0].principal_money<%=stage_list %>.value,document.forms[0].rate<%=stage_list %>.value,document.forms[0].rent<%=stage_list %>,<%if(stage_list.equals("1")){ %>document.forms[0].lease_money.value<%}else{ %>document.forms[0].other_rent<%=Integer.parseInt(stage_list)-1 %>.value<%} %>,document.forms[0].volume<%=stage_list %>.value);"> %</td>
		<td align="center"><input type="text" name="old_stage_rent<%=stage_list %>" value="<%=old_stage_rent %>" size="10"> 改为 <input type="text" name="rent<%=stage_list %>" size="10" value="<%=stage_rent %>"> 元</td>
      </tr>
      <% }} %>
    </table>
</div>
</div>
</form>
</body>
</html>
<%db.close();
db1.close();
db2.close();
db3.close(); %>
<script language="javascript">
function fun_pcpl(varValue,varObject,varOtherObj,varPreValue){
	if(varValue.value>100){
		alert("本金占用比率应小于100%");
		varValue.value=100;
		return false;
	}
	var pcpl = parseFloat(document.forms[0].lease_money.value);
	var pcplRate = parseFloat(varValue.value);
	varObject.value = (pcpl*pcplRate)/100;
	varOtherObj.value = parseFloat(varPreValue)-pcpl*pcplRate/100;
}

function fun_rent(varPcpl,varRate,varObject,varOtherValue,varvol){
	var pcpl = parseFloat(document.forms[0].lease_money.value);
	var leng = parseFloat(document.forms[0].lease_term.value);
	var volume = parseInt(document.forms[0].income_number.value);
	var period_type = document.forms[0].period_type.value;
	var rent_volume = (leng/12)*volume;
	var ivarvol = parseInt(varvol);
	var rent_rate = (parseFloat(varRate)/100/volume);
	if(period_type=="0"){
		varObject.value = Math.round(fun_pmtStart(rent_rate,varvol,parseFloat(varOtherValue),(parseFloat(varOtherValue)-parseFloat(varPcpl))));
	}else{
		varObject.value = Math.round(fun_pmtEnd(rent_rate,varvol,parseFloat(varOtherValue),(parseFloat(varOtherValue)-parseFloat(varPcpl))));
	}
}

function fun_interest(varPcpl,varRate,varObject,varOtherValue,varvol){
	var pcpl = parseFloat(document.forms[0].lease_money.value);
	var leng = parseFloat(document.forms[0].lease_term.value);
	var volume = parseInt(document.forms[0].income_number.value);
	var period_type = document.forms[0].period_type.value;
	var rent_volume = (leng/12)*volume;
	var ivarvol = parseInt(varvol); 
	var returnNo= 12/leng;
	varRate.value = getPmtYearRate(varvol,parseFloat(varOtherValue),(parseFloat(varOtherValue)-parseFloat(varPcpl)),period_type,parseFloat(varObject),returnNo);

}
function getPmtYearRate(Nper,Pv,Fv,Type,Pmt,lease_term){
	var min_rate = 0;
	var max_rate = 100;
	var rent = Pmt;
	var tmp_pmt=0;
	var j=0;
	var tmp=1;
	var tmp_rate=10;
	
	while(j<=1000 && tmp.abs()>0.000001){
		if(Type==0){
			tmp_pmt = fun_pmtStart(tmp_rate,Nper,Pv,Fv);
		}else{
			tmp_pmt = fun_pmtEnd(tmp_rate,Nper,Pv,Fv);
		}
		
		tmp=tmp_pmt-rent;
		if(tmp>0 && tmp.abs()>0.000001){
			max_rate=tmp_rate;
			tmp_rate=(tmp_rate+min_rate)/2;
		}
		if(tmp<0 && tmp.abs()>0.000001){
			min_rate=tmp_rate;
			tmp_rate=(tmp_rate+max_rate)/2;
		}
		j++;
	}
	return Math.pow(1+tmp_rate,1/lease_term)-1;
}
function fun_pmtStart(rate,volume,rent,futureValue){
	return (rate*Math.pow((1+rate),volume))/(Math.pow((1+rate),volume)-1)*(rent-futureValue)+(futureValue*rate);
}

function fun_pmtEnd(rate,volume,rent,futureValue){
	return (rate*Math.pow((1+rate),(volume-1)))/(Math.pow((1+rate),volume)-1)*(rent-futureValue)+(futureValue*rate);
}

function fun_change1(){
fun_clear("rate1");
fun_clear("rent1");
fun_clear("volume2");
fun_clear("principal_rate2");
fun_clear("principal_money2");
fun_clear("rate2");
fun_clear("rent2");
fun_clear("volume3");
fun_clear("principal_rate3");
fun_clear("principal_money3");
fun_clear("rate3");
fun_clear("rent3");
fun_clear("volume4");
fun_clear("principal_rate4");
fun_clear("principal_money4");
fun_clear("rate4");
fun_clear("rent4");
}
function fun_change2(){
fun_clear("volume2");
fun_clear("principal_rate2");
fun_clear("principal_money2");
fun_clear("rate2");
fun_clear("rent2");
fun_clear("volume3");
fun_clear("principal_rate3");
fun_clear("principal_money3");
fun_clear("rate3");
fun_clear("rent3");
fun_clear("volume4");
fun_clear("principal_rate4");
fun_clear("principal_money4");
fun_clear("rate4");
fun_clear("rent4");
}
function fun_change3(){
fun_clear("rate2");
fun_clear("rent2");
fun_clear("volume3");
fun_clear("principal_rate3");
fun_clear("principal_money3");
fun_clear("rate3");
fun_clear("rent3");
fun_clear("volume4");
fun_clear("principal_rate4");
fun_clear("principal_money4");
fun_clear("rate4");
fun_clear("rent4");
}
function fun_change4(){
fun_clear("volume3");
fun_clear("principal_rate3");
fun_clear("principal_money3");
fun_clear("rate3");
fun_clear("rent3");
fun_clear("volume4");
fun_clear("principal_rate4");
fun_clear("principal_money4");
fun_clear("rate4");
fun_clear("rent4");
}
function fun_change5(){
fun_clear("rate3");
fun_clear("rent3");
fun_clear("volume4");
fun_clear("principal_rate4");
fun_clear("principal_money4");
fun_clear("rate4");
fun_clear("rent4");
}
function fun_change6(){
fun_clear("volume4");
fun_clear("principal_rate4");
fun_clear("principal_money4");
fun_clear("rate4");
fun_clear("rent4");
}
function fun_change7(){
fun_clear("rate4");
fun_clear("rent4");
}
function fun_change8(){}
function fun_clear(varName){
eval("document.forms[0]."+varName+".value=''");
}
var flag='<%=savetype!=null&&!savetype.equals("")?savetype:"0"%>';
function fun_hl(){
	if(flag=="tx"){
		document.forms[0].action="tx_zjhl.jsp";
		document.forms[0].target="hl";
			document.forms[0].submit();
	}else{
		alert("请选择调息开始期项");
		return false;
	}
}
function fun_xj(){
	if(flag=="tx"){
		document.forms[0].action="tx_zj.jsp";
		document.forms[0].target="_black";
		document.forms[0].submit();
	}else{
		alert("请选择调息开始期项");
		return false;
	}
}
function fun_save(){
	if(flag=="tx"){
		document.forms[0].action="tx_save.jsp";
		document.forms[0].target="hl";
		document.forms[0].submit();
	}else{
		alert("请选择调息开始期项");
		return false;
	}
}
</script>