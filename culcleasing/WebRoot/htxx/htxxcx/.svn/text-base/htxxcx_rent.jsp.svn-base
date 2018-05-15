<%@ page contentType="text/html; charset=gbk" language="java"  %>
<%@ page import="dbconn.*" %> 
<%@ page import="java.sql.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" />
<%@ include file="../../func/common.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>租金测算 - 租金回笼计划</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
</head>

<body style="overflow:auto;" >
<form method="post" action="" target="rentplan">
<table  class="title_top" width=100% align=center cellspacing=0 border="0" cellpadding="0">
	<tr valign="top">
		<td  align=center width=100%>
			<table align=center width=96%  border="0" cellspacing="0" cellpadding="0" style="margin-top:0px">
				<tr>
					<td>
						<table border="0" cellspacing="0" cellpadding="0">    
							<tr class="maintab_dh">
								<td nowrap >
									
									<BUTTON class="btn_2" name="btnSave" value="察看现金流"  type="button" onclick="fun_xj()" >
									<img src="../../images/save.gif" align="absmiddle" border="0">察看现金流</button>
									<BUTTON class="btn_2" name="btnReset" value="取消" onclick="window.close();">
									<img src="../../images/hg.gif" align="absmiddle" border="0">取消</button>
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
%>
<%
	String contract_id = getStr(request.getParameter("contract_id"));
	String sql = "";
	ResultSet rsPlan = null;
	ArrayList al = null;
	
	
	sql = "select fund_rent_plan.*,dbo.bb_getPunishInterest_item('1970-01-01',convert(char(10),getdate(),21),fund_rent_plan.contract_id,fund_rent_plan.rent_list)+isnull(fund_rent_income.penalty,0)+isnull(fund_rent_income.penalty_adjust,0) as should_penalty,fund_rent_income.rent as atl_rent,fund_rent_income.corpus as atl_corpus,fund_rent_income.interest as atl_interest,fund_rent_income.penalty as atl_penalty,fund_rent_income.rent_adjust as atl_rent_adjust,fund_rent_income.corpus_adjust as atl_corpus_adjust,fund_rent_income.interest_adjust as atl_interest_adjust,fund_rent_income.penalty_adjust as atl_penalty_adjust from fund_rent_plan left outer join (select contract_id,plan_list,sum(isnull(rent,0)) as rent,sum(isnull(rent_adjust,0)) as rent_adjust,sum(isnull(corpus,0)) as corpus,sum(isnull(corpus_adjust,0)) as corpus_adjust,sum(isnull(interest,0)) as interest,sum(isnull(interest_adjust,0)) as interest_adjust,sum(isnull(penalty,0)) as penalty,sum(isnull(penalty_adjust,0)) as penalty_adjust from fund_rent_income group by contract_id,plan_list) as fund_rent_income on fund_rent_plan.contract_id=fund_rent_income.contract_id and fund_rent_plan.rent_list=fund_rent_income.plan_list where fund_rent_plan.contract_id='"+contract_id+"' order by fund_rent_plan.rent_list";
	System.out.println(sql);
	rsPlan = db.executeQuery(sql);
	al = new ArrayList();
	while (rsPlan.next()){
		HashMap hm = new HashMap();
		String rsvolume = "";
		String rsrent_date = "";
		String rscorpus = "";
		String rsyear_rate = "";
		String rsinterest = "";
		String rsrent = "";
		String rsadjust_amount = "";
		String rent = "";
		String atl_rent = "";
		String atl_corpus = "";
		String atl_interest = "";
		String atl_penalty = "";
		String atl_rent_adjust = "";
		String atl_corpus_adjust = "";
		String atl_interest_adjust = "";
		String atl_penalty_adjust = "";
		String should_penalty = "";
		rsvolume = getDBStr(rsPlan.getString("rent_list"));
		rsrent_date = getDBDateStr(rsPlan.getString("plan_date"));
		rscorpus = getDBStr(rsPlan.getString("corpus"));
		rsyear_rate = getDBStr(rsPlan.getString("year_rate"));
		rsinterest = getDBStr(rsPlan.getString("interest"));
		rsrent = getDBStr(rsPlan.getString("rent"));

		atl_rent = getDBStr(rsPlan.getString("atl_rent"));
		atl_corpus = getDBStr(rsPlan.getString("atl_corpus"));
		atl_interest =  getDBStr(rsPlan.getString("atl_interest"));
		atl_penalty = getDBStr(rsPlan.getString("atl_penalty")); 
		
		atl_rent_adjust = getDBStr(rsPlan.getString("atl_rent_adjust"));
		atl_corpus_adjust = getDBStr(rsPlan.getString("atl_corpus_adjust"));
		atl_interest_adjust =  getDBStr(rsPlan.getString("atl_interest_adjust"));
		atl_penalty_adjust = getDBStr(rsPlan.getString("atl_penalty_adjust")); 
		
		should_penalty = getDBStr(rsPlan.getString("should_penalty"));
		
		hm.put("volume",rsvolume);
		hm.put("rent_date",rsrent_date);
		hm.put("corpus",rscorpus);
		hm.put("year_rate",rsyear_rate);
		hm.put("interest",rsinterest);
		hm.put("rent",rsrent);
		hm.put("atl_rent",atl_rent);
		hm.put("atl_corpus",atl_corpus);
		hm.put("atl_interest",atl_interest);
		hm.put("atl_penalty",atl_penalty);
		hm.put("atl_rent_adjust",atl_rent_adjust);
		hm.put("atl_corpus_adjust",atl_corpus_adjust);
		hm.put("atl_interest_adjust",atl_interest_adjust);
		hm.put("atl_penalty_adjust",atl_penalty_adjust);
		hm.put("should_penalty",should_penalty);
		al.add(hm);
	}
	rsPlan.close();
	db.close();
 %>


<input type="hidden" name="contract_id" value="<%=contract_id %>">
<input type="hidden" name="savetype" value="rentplan">
<!-- end cwCellTop -->
<input type="hidden" name="cs" value="1">
<div id="divH" class="tabBody" style="background:#ffffff;width:100%;overflow:auto;">
<div id="TD_tab_0">

    <table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" cellspacing="1" width="100%" class="maintab_content_table">
      <tr class="maintab_content_table_title">
		<th>请款日</th>
		<th>期数</th>
		<th>利率(%)</th>
		<th>应收本金</th>
		<th>应收利息</th>
		<th>应收租金</th>
		
		<th>已收本金</th>
		<th>已收利息</th>
		<th>已收租金</th>
		
		<th>本金调整</th>
		<th>利息调整</th>
		<th>租金调整</th>
		
		<th>应收罚息</th>
		<th>已收罚息</th>
		<th>罚息调整</th>
      </tr>
   
	<%
	double doldRent = 0;
	double doldInterest = 0;
	double doldEptdRent = 0;
	double doldcorpus = 0;
	
	double dallrent = 0;
	double dallinterest = 0;
	double dallcorpus = 0;
	double dallpenalty = 0;
	
	double dallrentAdjust = 0;
	double dallinterestAdjust = 0;
	double dallcorpusAdjust = 0;
	double dallpenaltyAdjust = 0;
	
	double dallShouldPenalty = 0;
	if(al!=null&&al.size()>0){
		for(int i=0;i<al.size();i++){
			HashMap hm = (HashMap)al.get(i);
			String return_volume = (String)hm.get("volume");
			String return_rent_date = (String)hm.get("rent_date");
			String return_corpus  = (String)hm.get("corpus");
			String return_year_rate = (String)hm.get("year_rate");
			String return_interest = (String)hm.get("interest");
			String return_rent = (String)hm.get("rent");
			
			String return_alt_rent = (String)hm.get("atl_rent");
			String return_atl_corpus = (String)hm.get("atl_corpus");
			String return_atl_interest = (String)hm.get("atl_interest");
			String return_atl_penalty = (String)hm.get("atl_penalty");
			
			
			String return_alt_rent_adjust = (String)hm.get("atl_rent_adjust");
			String return_atl_corpus_adjust = (String)hm.get("atl_corpus_adjust");
			String return_atl_interest_adjust = (String)hm.get("atl_interest_adjust");
			String return_atl_penalty_adjust = (String)hm.get("atl_penalty_adjust");
			
			String return_should_penalty = (String)hm.get("should_penalty");
			
			if(return_rent!=null&&!return_rent.equals("")){
				doldRent += Double.parseDouble(return_rent);
			}
			if(return_interest!=null&&!return_interest.equals("")){
			doldInterest +=Double.parseDouble(return_interest);
			}
			if(return_corpus!=null&&!return_corpus.equals("")){
				doldcorpus +=Double.parseDouble(return_corpus);
			}
			
			if(return_alt_rent!=null&&!return_alt_rent.equals("")){
				dallrent+=Double.parseDouble(return_alt_rent);
			}
			if(return_atl_corpus!=null&&!return_atl_corpus.equals("")){
				dallcorpus+=Double.parseDouble(return_atl_corpus);
			}
			if(return_atl_interest!=null&&!return_atl_interest.equals("")){
				dallinterest+=Double.parseDouble(return_atl_interest);
			}
			if(return_atl_penalty!=null&&!return_atl_penalty.equals("")){
				dallpenalty+=Double.parseDouble(return_atl_penalty);
			}
			
			if(return_alt_rent_adjust!=null&&!return_alt_rent_adjust.equals("")){
				dallrentAdjust+=Double.parseDouble(return_alt_rent_adjust);
			}
			if(return_atl_corpus_adjust!=null&&!return_atl_corpus_adjust.equals("")){
				dallcorpusAdjust+=Double.parseDouble(return_atl_corpus_adjust);
			}
			if(return_atl_interest_adjust!=null&&!return_atl_interest_adjust.equals("")){
				dallinterestAdjust+=Double.parseDouble(return_atl_interest_adjust);
			}
			if(return_atl_penalty_adjust!=null&&!return_atl_penalty_adjust.equals("")){
				dallpenaltyAdjust+=Double.parseDouble(return_atl_penalty_adjust);
			}
			if(return_should_penalty!=null&&!return_should_penalty.equals("")){
				dallShouldPenalty+=Double.parseDouble(return_should_penalty);
			}
		 %>
		<tr>
			<td><%=return_rent_date %></td>
			<td><%=return_volume %></td>
			<td><%=return_year_rate!=null&&!return_year_rate.equals("")?formatNumberDoubleSix(return_year_rate):"" %></td>
			<td><%=return_corpus!=null&&!return_corpus.equals("")?formatNumberStr(return_corpus,"#,##0.00"):"" %></td>
			<td><%=return_interest!=null&&!return_interest.equals("")?formatNumberStr(return_interest,"#,##0.00"):"" %></td>
			<td><%=return_rent!=null&&!return_rent.equals("")?formatNumberStr(return_rent,"#,##0.00"):"" %></td>
			
			
			
			
			<td><%=return_atl_corpus!=null&&!return_atl_corpus.equals("")?formatNumberStr(return_atl_corpus,"#,##0.00"):"" %></td>
			<td><%=return_atl_interest!=null&&!return_atl_interest.equals("")?formatNumberStr(return_atl_interest,"#,##0.00"):"" %></td>
			<td><%=return_alt_rent!=null&&!return_alt_rent.equals("")?formatNumberStr(return_alt_rent,"#,##0.00"):"" %></td>
			
			
			
			<td><%=return_atl_corpus_adjust!=null&&!return_atl_corpus_adjust.equals("")?formatNumberStr(return_atl_corpus_adjust,"#,##0.00"):"" %></td>
			<td><%=return_atl_interest_adjust!=null&&!return_atl_interest_adjust.equals("")?formatNumberStr(return_atl_interest_adjust,"#,##0.00"):"" %></td>
			<td><%=return_alt_rent_adjust!=null&&!return_alt_rent_adjust.equals("")?formatNumberStr(return_alt_rent_adjust,"#,##0.00"):"" %></td>
			
			<td><%=return_should_penalty!=null&&!return_should_penalty.equals("")?formatNumberStr(return_should_penalty,"#,##0.00"):"" %></td>
			<td><%=return_atl_penalty!=null&&!return_atl_penalty.equals("")?formatNumberStr(return_atl_penalty,"#,##0.00"):"" %></td>
			<td><%=return_atl_penalty_adjust!=null&&!return_atl_penalty_adjust.equals("")?formatNumberStr(return_atl_penalty_adjust,"#,##0.00"):"" %></td>
			
		</tr>
	<%}} %>
   <tr>
		<td></td>
		<td></td>
		<td></td>
		<td><%=formatNumberDouble(doldcorpus) %></td>
		<td><%=formatNumberDouble(doldInterest) %></td>
		<td><%=formatNumberDouble(doldRent) %></td>
		
		
		<td><%=formatNumberDouble(dallcorpus) %></td>
		<td><%=formatNumberDouble(dallinterest) %></td>
		<td><%=formatNumberDouble(dallrent) %></td>
		
		
		<td><%=formatNumberDouble(dallcorpusAdjust) %></td>
		<td><%=formatNumberDouble(dallinterestAdjust) %></td>
		<td><%=formatNumberDouble(dallrentAdjust) %></td>
		
		<td><%=formatNumberDouble(dallShouldPenalty) %></td>
		<td><%=formatNumberDouble(dallpenalty) %></td>
		<td><%=formatNumberDouble(dallpenaltyAdjust) %></td>
      </tr>
    </table>


</div>
</div>
</form>
</body>
</html>
<script language="javascript">
function fun_xj(){
	document.forms[0].action="htxxcx_cash.jsp";
	document.forms[0].target="cashplan";
	document.forms[0].submit();
}
</script>
