<%@ page contentType="text/html; charset=gbk" language="java" errorPage="/public/pageError.jsp"  %>
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*" %> 
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="com.container.*" %>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<jsp:useBean id="fileBean" scope="page" class="com.UploadBean" />
<jsp:useBean id="execlBean" scope="page" class="com.UploadExecl2" />
<%@ include file="../../func/common.jsp"%>
<%
String czy = (String) session.getAttribute("czyid");
//获取系统时间
String datestr=getSystemDate(0); 

String errMsg = "";
String sqlstr="";
ResultSet rs;
String uid="";

String fact_date="";//扣款日期
String hxBank = "";//核销银行
String bank_flag="";//回执成功,失败标志

hxBank = request.getParameter("hxBank");
String memo="";//备注

String rent_list[]=null;
boolean bflag = true;

String filePath;
String fileName = "";
String message = "";
String allpath = "";
String hire_number="";

//设定附件相对路径
String path = pageContext.getServletContext().getRealPath("/");
//设定上传附件总体大小限制
//判断上传银行的文件类型
if( "jsBank".equals(hxBank.trim()) ){
	allpath =path + "\\execl\\"+datestr+"\\";
	//设定上传附件文件类型
	fileBean.setSuffix(".xls");
}else if( "msBank".equals(hxBank.trim()) ){
	allpath =path + "\\txt\\"+datestr+"\\";
	//设定上传附件文件类型
	fileBean.setSuffix(".txt");
}
fileBean.setObjectPath( allpath );
fileBean.setSize(10*1024*1024);

//设定上传用户ID
if ( ( czy != null ) && ( !czy.equals("") ) ) {
   uid=czy.substring(7);
}
fileBean.setUserid(uid);
fileBean.setSourceFile(request);
String [] saSourceFile = fileBean.getSourceFile();
String [] saObjectFile = fileBean.getObjectFileName();
String [] saDescription = fileBean.getDescription();
int iCount = fileBean.getCount();
String sObjectPath = fileBean.getObjectPath();
fact_date=fileBean.getFieldValue("fact_date");
//==================判断核销银行予以不同操作===============
if( hxBank!=null && !"".equals(hxBank) && "jsBank".equals(hxBank.trim()) ){//以建行模板导出
	for(int i=0;i<iCount;i++){
		execlBean.setExecl(allpath+saObjectFile[i]);
		if(execlBean.getFlag()){
			String [][]obj = execlBean.getObject();
			System.out.println(obj.length+"========length======="+obj[0].length);
			for(int row=0;row<obj.length;row++){//从第五行开始
				String []objrow = obj[row];	
				if(objrow.length<8){//列数不为8的不读
					continue;
				}

				memo=objrow[7];
				System.out.println(row+"========length======="+memo);
				//空行
				if( memo==null ||  "".equals(memo) ){
					continue;
				}
				//如果memo在数据库中不存在跳过
				sqlstr = "select id from fund_fund_charge_plan where proj_id='"+memo+"'";
				rs = db.executeQuery(sqlstr);
				if(!rs.next()){
					System.out.println("不存在===="+memo);
					continue;
				}

				hire_number=objrow[3];//核销金额
				bank_flag=objrow[5];//成功标志
				System.out.println(row+"========length===5===="+bank_flag);
				if( bank_flag==null || "".equals(bank_flag) ){
					continue;
				}
				
				if(bank_flag!=null && !"".equals(bank_flag) && "成功".equals(bank_flag.trim())){
					sqlstr=" update fund_fund_charge_plan set export_flag=NULL where proj_id='"+memo+"' and funds_mode='收款' and item_method='网银' and status='0'";
					db.executeUpdate(sqlstr);
					sqlstr =" insert into fund_fund_charge(fact_date,fact_money,account_bank,account,acc_number,proj_id,funds_mode,";
					sqlstr+=" funds_type,funds_name,plan_date,plan_money,item_method,payer,payee,status,settle_mode,create_date,";
					sqlstr+=" creator,plan_id) select '"+fact_date+"' as fact_date,fund_fund_charge_plan.plan_money,'中国建设银行',";
					sqlstr+=" proj_info.account_name,proj_info.account, fund_fund_charge_plan.proj_id,";
					sqlstr+=" fund_fund_charge_plan.funds_mode,fund_fund_charge_plan.funds_type,fund_fund_charge_plan.funds_name, ";
					sqlstr+=" fund_fund_charge_plan.plan_date,fund_fund_charge_plan.plan_money,fund_fund_charge_plan.item_method,";
					sqlstr+=" proj_info.cust_id, fund_fund_charge_plan.payee,'1' as status,fund_fund_charge_plan.settle_mode,";
					sqlstr+=" '"+datestr+"','"+czy+"',fund_fund_charge_plan.id from fund_fund_charge_plan left join proj_info on ";
					sqlstr+=" fund_fund_charge_plan.proj_id=proj_info.proj_id where fund_fund_charge_plan.proj_id='"+memo+"' and ";
					sqlstr+=" funds_mode='收款' and item_method='网银' and status='0'";
					//System.out.println("sqlstr2===hhhj======="+proj_id);
					db.executeUpdate(sqlstr);
					sqlstr="update fund_fund_charge_plan set status='1' where proj_id='"+memo+"' and funds_mode='收款' and item_method='网银' and status='0'";
					db.executeUpdate(sqlstr);
					//System.out.println("sqlstr2===hhhj2======="+sqlstr);
					//修改租金计划表第一期租金状态
					sqlstr="update fund_rent_plan set plan_status='1',penalty=0 where proj_id='"+memo+"' and rent_list=1 ";
					db.executeUpdate(sqlstr);
					//System.out.println("sqlstr2===hhhj3======="+sqlstr);
					//租金实收表添加数据
					sqlstr=" insert into fund_rent_income(proj_id,plan_list,hire_date,rent,corpus,interest,hire_object,";
					sqlstr+=" hire_account,hire_number,rent_type,item_method) select a.proj_id,rent_list,";
					sqlstr+=" '"+fact_date+"',rent,corpus,interest,b.account_name,'中国建设银行',b.account,'租金','网银' from ";
					sqlstr+=" fund_rent_plan a left join proj_info b on a.proj_id=b.proj_id where a.proj_id='"+memo+"' ";
					sqlstr+=" and a.rent_list=1 ";

					db.executeUpdate(sqlstr);
				} else
				{
					sqlstr="update fund_fund_charge_plan set export_flag=NULL where proj_id='"+memo+"' and funds_mode='收款' and item_method='网银' and status='0'";
					db.executeUpdate(sqlstr);
				}
			}
		}else{
			bflag=false;
		}
	}
}else if( hxBank!=null && !"".equals(hxBank) && "msBank".equals(hxBank.trim()) ){
	List contentList = new ArrayList(0);
	File txtFile = new File(allpath+saObjectFile[0]);
	//读取
	BufferedReader br = null;
	String titleStr = "";
	try {
		br=new BufferedReader(new FileReader(txtFile));
		//文件头
		titleStr = br.readLine();
		System.out.println("titleStr==========="+titleStr);
		//文件体一条条内容
		String contentStr = ""; 
		while((contentStr=br.readLine())!=null) {
			contentList.add(contentStr);
			System.out.println("contentStr==========="+contentStr);
		}
	}catch(FileNotFoundException e){
	   e.printStackTrace();
	}finally{//关闭流
	   try {
			br.close();
	   } catch (IOException e) {
			e.printStackTrace();
	   }
	}
	//循环操作
	String contStr = "";
	for(int i=0;i<contentList.size();i++){
		contStr = contentList.get(i)+"";
		int flag = 0;
		if( contStr!=null && !"".equals(contStr.trim()) ){
			String[] strSegment = contStr.trim().split("\\|");
			System.out.println(memo+"===habcTest======="+strSegment.length);
			//文件头不读
			if(strSegment.length<10){
				continue;
			}
			String tempMemo=strSegment[13];//标志值
			if(tempMemo.indexOf(":")==-1){
				continue;
			}
			memo = tempMemo.substring(tempMemo.indexOf(":")+1);
			//如果memo在数据库中不存在跳过
			sqlstr = "select id from fund_fund_charge_plan where proj_id='"+memo+"'";
			rs = db.executeQuery(sqlstr);
			if(!rs.next()){
				System.out.println("不存在===="+memo);
				continue;
			}
				
			bank_flag=strSegment[17];//成功标志
			System.out.println(memo+"===habcTest======="+tempMemo+"=="+bank_flag);
			
			if(bank_flag!=null && !"".equals(bank_flag) && "1".equals(bank_flag)){//回执扣款成功
				sqlstr="update fund_fund_charge_plan set export_flag=NULL where proj_id='"+memo+"' and funds_mode='收款' and item_method='网银' and status='0'";
				db.executeUpdate(sqlstr);
				sqlstr =" insert into fund_fund_charge(fact_date,fact_money,account_bank,account,acc_number,proj_id,funds_mode,";
				sqlstr+=" funds_type,funds_name,plan_date,plan_money,item_method,payer,payee,status,settle_mode,create_date,";
				sqlstr+=" creator,plan_id) select '"+fact_date+"' as fact_date,fund_fund_charge_plan.plan_money,'中国民生银行',";
				sqlstr+=" proj_info.account_name,proj_info.account, fund_fund_charge_plan.proj_id,";
				sqlstr+=" fund_fund_charge_plan.funds_mode,fund_fund_charge_plan.funds_type,fund_fund_charge_plan.funds_name, ";
				sqlstr+=" fund_fund_charge_plan.plan_date,fund_fund_charge_plan.plan_money,fund_fund_charge_plan.item_method,";
				sqlstr+=" proj_info.cust_id, fund_fund_charge_plan.payee,'1' as status,fund_fund_charge_plan.settle_mode,";
				sqlstr+=" '"+datestr+"','"+czy+"',fund_fund_charge_plan.id from fund_fund_charge_plan left join proj_info on ";
				sqlstr+=" fund_fund_charge_plan.proj_id=proj_info.proj_id where fund_fund_charge_plan.proj_id='"+memo+"' and ";
				sqlstr+=" funds_mode='收款' and item_method='网银' and status='0'";

				//System.out.println("sqlstr2===hhhj======="+proj_id);
				db.executeUpdate(sqlstr);
				sqlstr="update fund_fund_charge_plan set status='1' where proj_id='"+memo+"' and funds_mode='收款' and item_method='网银' and status='0'";
				db.executeUpdate(sqlstr);
				System.out.println("sqlstr2===hhhj2======="+sqlstr);
				//修改租金计划表第一期租金状态
				sqlstr="update fund_rent_plan set plan_status='1',penalty=0 where proj_id='"+memo+"' and rent_list=1 ";
				db.executeUpdate(sqlstr);
				//System.out.println("sqlstr2===hhhj3======="+sqlstr);
				//租金实收表添加数据
				sqlstr="insert into fund_rent_income(proj_id,plan_list,hire_date,rent,corpus,interest,hire_object,hire_account,hire_number,rent_type,item_method) select '"+memo+"',rent_list,'"+fact_date+"',rent,corpus,interest,b.account_name,'中国民生银行',b.account,'租金','网银' from fund_rent_plan a left join proj_info b on a.proj_id=b.proj_id where a.proj_id='"+memo+"' and a.rent_list=1 "; 

				flag = db.executeUpdate(sqlstr);
			}else{//扣款失败
				//System.out.println("失败＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊");
				sqlstr="update fund_fund_charge_plan set export_flag=NULL where proj_id='"+memo+"' and funds_mode='收款' and item_method='网银' and isnull(status,0)=0 ";
				flag = db.executeUpdate(sqlstr);
			}
		}else{//
			bflag=false;
		}
	}
}
db.close();

if(bflag){
%>
<script>
		window.close();
		opener.alert("核销完成，扣款失败数据已重置申请");
		opener.location.reload(true);
</script>
<%
}else{
%>
<script>
		window.close();
		opener.alert("核销错误,请检查上传文件内容,格式非法");
		opener.location.reload(true);
</script>
<% } %>