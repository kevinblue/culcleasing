<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@ page import="java.sql.*" %> 
<%@ page import="java.util.*" %>
<%@ page import="com.tenwa.log.LogWriter"%>
<%@ page import="java.util.regex.Pattern"%>
<%@page import="java.io.*"%>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<jsp:useBean id="fileBean" scope="page" class="com.UploadBean" />
<jsp:useBean id="execlBean" scope="page" class="com.UploadExecl2" />
<%@ include file="../../func/common_simple.jsp"%>

<%
String czy = (String) session.getAttribute("czyid");
//获取系统时间
String datestr=getSystemDate(0); 
String sqlstr="";
ResultSet rs;
String uid="";

String fact_date="";//扣款日期
String hxBank = "";//核销银行
String bank_flag="";//回执成功,失败标志

hxBank = request.getParameter("hxBank");
String memo="";//备注
String kk_amt="";//扣款金额
String fail_reason="";//失败原因
String rem_amt="";//余额
String hire_object="";//核销人
String hire_number="";

String rent_list[]=null;

boolean bflag = true;

String filePath = "";
String fileName = "";
String message = "";
String allpath = "";

//设定附件相对路径
String path = pageContext.getServletContext().getRealPath("/");
//设定上传附件总体大小限制
//判断上传银行的文件类型
if( "jsBank".equals(hxBank.trim()) ){
	allpath =path + "\\excel\\"+datestr+"\\";
	//设定上传附件文件类型
	fileBean.setSuffix(".xls");
}else if( "msBank".equals(hxBank.trim()) ){
	allpath =path + "\\txt\\"+datestr+"\\";
	//设定上传附件文件类型
	fileBean.setSuffix(".txt");
}
fileBean.setObjectPath( allpath );
fileBean.setSize(8*1024*1024);

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
String plan_id="";
//==================判断核销银行予以不同操作===============
if( hxBank!=null && !"".equals(hxBank) && "jsBank".equals(hxBank.trim()) ){//以建行模板导出
	int flag = 0;
	plan_id="";
	for(int i=0;i<iCount;i++){
		plan_id="";
		execlBean.setExecl(allpath+saObjectFile[i]);
		if(execlBean.getFlag()){
			String [][]obj = execlBean.getObject();

			for(int row=0;row<obj.length;row++){//从第五行开始
				String [] objrow = obj[row];	
				
				LogWriter.logDebug(request, "第"+row+"行，===第8列值："+objrow[7]+"共"+objrow.length+"列");

				if(objrow.length<8){//列数不为8的不读
					LogWriter.logDebug(request,"不符合"+row);
					continue;
				}
				memo=objrow[7];//备注列
				if( memo==null ||  "".equals(memo) ){
					continue;
				}
				
				//得到plan_id
				if(memo.indexOf(".0")!=-1){//0.0的处理
					memo = memo.substring(0, memo.lastIndexOf(".0"));
				}	
				plan_id=memo.indexOf("_")>-1?memo.substring(0,memo.indexOf("_")):memo;	
				
				//判断plan_id是否是数字
				Pattern pattern = Pattern.compile("[0-9]*");  
				if(!pattern.matcher(plan_id).matches()){
					continue;
				} 
									
				//失败原因、余额
				fail_reason=objrow[6];//失败原因
				//rem_amt=objrow[1];//余额
				hire_number=objrow[1];//扣款账户
				bank_flag=objrow[5];

				if( bank_flag==null || "".equals(bank_flag) ){
					continue;
				}
				
				if(bank_flag!=null && !"".equals(bank_flag) && "成功".equals(bank_flag)){//回执扣款成功
					//查看是否息还是租金的核销
					if (memo.indexOf("_")>-1) {//罚息时
						sqlstr="select id from fund_rent_income where proj_id=(select proj_id from fund_rent_plan where id='"+plan_id+"')";
						sqlstr+="and plan_list=(select rent_list from fund_rent_plan where id='"+plan_id+"')and rent_type='违约金'";
						rs = db.executeQuery(sqlstr);
						boolean noData = !rs.next();
						System.out.print("违约金========"+noData);
						rs.close();
						if(noData){
							sqlstr=" insert into fund_rent_income(proj_id,plan_list,hire_date,rent,corpus,interest,hire_object,hire_account,hire_number,penalty,rent_type,item_method)";
							sqlstr+=" select a.proj_id,rent_list,'"+fact_date+"',"+0+","+0+",penalty,b.account_name,'中国建设银行',b.account,penalty,'违约金','网银' from fund_rent_plan a left ";
							sqlstr+=" join proj_info b on a.proj_id=b.proj_id where a.id='"+plan_id+"'  ";
							System.out.println("sqlstr==================="+sqlstr);
							db.executeUpdate(sqlstr);
						}
						
					} else {//租金时
						sqlstr="select id from fund_rent_income where proj_id=(select proj_id from fund_rent_plan where id='"+plan_id+"')";
						sqlstr+="and plan_list=(select rent_list from fund_rent_plan where id='"+plan_id+"')and rent_type='租金'";
						rs = db.executeQuery(sqlstr);
						boolean noData = !rs.next();
						System.out.print("租金金========"+noData);
						rs.close();
						if(noData){
							sqlstr="insert into fund_rent_income(proj_id,plan_list,hire_date,rent,corpus,interest,hire_object,hire_account,hire_number,rent_type,item_method,remark) ";
							sqlstr+=" select a.proj_id,rent_list,'"+fact_date+"',rent,corpus,interest,b.account_name,'中国建设银行',b.account,'租金','网银',a.hg_remark from fund_rent_plan a left ";
							sqlstr+=" join proj_info b on a.proj_id=b.proj_id where a.id='"+plan_id+"'  ";
							sqlstr+="  update fund_rent_plan set plan_status='1' where  id='"+plan_id+"'  ";
							System.out.println("sqlstr==================="+sqlstr);
							db.executeUpdate(sqlstr);
						}
						
					}
					//修改状态
					sqlstr =" update fund_rent_plan set show_flag=NULL,show_flag2=NULL,export_flag=NULL,fail_reason='',exp_state=0,";
					sqlstr+=" modificator='"+czy+"',modify_date='"+datestr+"' where id='"+plan_id+"' ";
					flag = db.executeUpdate(sqlstr);
					System.out.println("wyhx_save.jsp================"+sqlstr);
					//如果该期租金产生罚息，设置罚息计划收取日期为下一收款日期与违约金金额
					sqlstr="  exec rent_penalty_calculate '"+plan_id+"'";
					System.out.println("===罚息项目======"+sqlstr);
					db.executeUpdate(sqlstr);
				}else{//扣款失败
					//＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊失败＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊
					//失败次数加1 = 失败原因、余额
					sqlstr= " update fund_rent_plan set show_flag=NULL,show_flag2=NULL,export_flag=NULL,fail_reason='"+fail_reason+"',modificator='"+czy+"',modify_date='"+fact_date+"',";
					sqlstr+=" exp_state=(select isnull(exp_state,0)+1 from fund_rent_plan where id=frp.id) from fund_rent_plan frp where frp.id='"+plan_id+"' ";		
					flag = db.executeUpdate(sqlstr);
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
	plan_id="";
	for(int i=0;i<contentList.size();i++){
		plan_id="";
		contStr = contentList.get(i)+"";
		int flag = 0;
		if( contStr!=null && !"".equals(contStr) ){
			String[] strSegment = contStr.trim().split("\\|");
			System.out.println(strSegment[13]+"===habcTest======="+strSegment.length);
			//文件头不读
			if(strSegment.length<10){
				continue;
			}
			String tempMemo=strSegment[13];//标志值
			if(tempMemo.indexOf(":")==-1){
				continue;
			}
			memo = tempMemo.substring(tempMemo.indexOf(":")+1);
			//得到plan_id
			if(memo.indexOf(".0")!=-1){//0.0的处理
				memo = memo.substring(0, memo.lastIndexOf(".0"));
			}
			plan_id=memo.indexOf("_")>-1?memo.substring(0,memo.indexOf("_")):memo;			System.out.println("memo==================="+memo+"=="+plan_id);
			//判断plan_id是否是数字
			Pattern pattern = Pattern.compile("[0-9]*");  
			if(!pattern.matcher(plan_id).matches()){
				continue;
			}
			 
			fail_reason=strSegment[19];//失败原因
			//rem_amt=objrow[1];//余额
			bank_flag=strSegment[17];//成功标志
			sqlstr = "";
			if(bank_flag!=null && !"".equals(bank_flag) && "1".equals(bank_flag)){//回执扣款成功
				//查看是否息还是租金的核销
				if (memo.indexOf("_")>-1) {//罚息时
					sqlstr="select id from fund_rent_income where proj_id=(select proj_id from fund_rent_plan where id='"+plan_id+"')";
					sqlstr+="and plan_list=(select rent_list from fund_rent_plan where id='"+plan_id+"')and rent_type='违约金'";
					rs = db.executeQuery(sqlstr);
					boolean noData = !rs.next();
					System.out.print("违约金========"+noData);
					rs.close();
					if(noData){
						sqlstr=" insert into fund_rent_income(proj_id,plan_list,hire_date,rent,corpus,interest,hire_object,hire_account,hire_number,penalty,";
						sqlstr+=" rent_type,item_method) select a.proj_id,rent_list,'"+fact_date+"',"+0+","+0+",penalty,b.account_name,'中国民生银行',b.account,penalty,'违约金','网银' from fund_rent_plan a ";
						sqlstr+=" left join proj_info b on a.proj_id=b.proj_id where a.id='"+plan_id+"'  ";	
						System.out.println("sqlstr==================="+sqlstr);
						flag = db.executeUpdate(sqlstr);
					}
				} else {//租金时
					sqlstr="select id from fund_rent_income where proj_id=(select proj_id from fund_rent_plan where id='"+plan_id+"')";
					sqlstr+="and plan_list=(select rent_list from fund_rent_plan where id='"+plan_id+"')and rent_type='租金'";
					rs = db.executeQuery(sqlstr);
					boolean noData = !rs.next();
					System.out.print("租金========"+noData);
					rs.close();
					if(noData){
						sqlstr=" insert into fund_rent_income(proj_id,plan_list,hire_date,rent,corpus,interest,hire_object,hire_account,hire_number,rent_type,item_method,remark) ";
						sqlstr+=" select a.proj_id,rent_list,'"+fact_date+"',rent,corpus,interest,b.account_name,'中国民生银行',b.account,'租金','网银',a.hg_remark from fund_rent_plan a ";
						sqlstr+=" left join proj_info b on a.proj_id=b.proj_id where a.id='"+plan_id+"'  ";
						sqlstr+=" update fund_rent_plan set plan_status='1' where  id='"+plan_id+"'  ";
						System.out.println("sqlstr==================="+sqlstr);
						flag = db.executeUpdate(sqlstr);
					}
				}
				sqlstr =" update fund_rent_plan set show_flag=NULL,show_flag2=NULL,export_flag=NULL,fail_reason='',exp_state=0,";
				sqlstr+=" modificator='"+czy+"',modify_date='"+datestr+"' where id='"+plan_id+"' ";
				System.out.println("sqlstr==================="+sqlstr);
				flag = db.executeUpdate(sqlstr);
				
				//如果该期租金产生罚息，设置罚息计划收取日期为下一收款日期与违约金金额
				sqlstr="  exec rent_penalty_calculate '"+plan_id+"'";
				System.out.println("===罚息项目======"+sqlstr);
				db.executeUpdate(sqlstr);
				
			}else{//扣款失败
				//System.out.println("失败＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊");
				//失败次数加1 = 失败原因、余额
				sqlstr= " update fund_rent_plan set show_flag=NULL,show_flag2=NULL,export_flag=NULL,fail_reason='"+fail_reason+"',modificator='"+czy+"',modify_date='"+fact_date+"',";
				sqlstr+=" exp_state=(select isnull(exp_state,0)+1 from fund_rent_plan where id=frp.id) from fund_rent_plan frp where frp.id='"+plan_id+"' ";		
				flag = db.executeUpdate(sqlstr);
			}
		}
		if(flag!=0){//
			bflag=false;
		}else{//
			bflag=true;
		}
	}
}
db.close();

if(bflag){
%>
<script>
		window.close();
		opener.alert("核销完成，扣款失败数据已重置申请");
		opener.location.reload();
</script>
<%
}else{
%>
<script>
		window.close();
		opener.alert("核销失败,请检查上传文件内容的格式是否合法");
		opener.location.reload();
</script>
<% } %>