<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="java.sql.*" %>
<%@ page import="dbconn.*" %>
<%@ page import="java.io.*" %>
<%@ page import="com.container.*" %>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" />
<jsp:useBean id="db1" scope="page" class="dbconn.Conn" />
<jsp:useBean id="fileBean" scope="page" class="com.UploadBean" />
<jsp:useBean id="execlBean" scope="page" class="com.UploadExecl" />
<%@ include file="../../func/common.jsp"%>
<%!public void saveFileToFile(String F1, String F2) { 
FileInputStream fis = null; 
FileOutputStream fos = null; 
try { 
fis = new FileInputStream(new File(F1)); // 建立文件输入流 
fos = new FileOutputStream(F2); 
byte[] buffer = new byte[100]; 
int len; 
while ((len = fis.read(buffer)) != -1) { 
fos.write(buffer, 0, len); 
} 
} catch (FileNotFoundException ex) { 
System.out.println("Source File not found:" + F1); 
} catch (IOException ex) { 
System.out.println(ex.getMessage()); 
} finally { 
try { 
if (fis != null) 
fis.close(); // 一定要进行文件的关闭,否则在新文件会是空的! 
if (fos != null) 
fos.close(); 
} catch (IOException ex) { 
System.out.println(ex); 
} 
} 
}
%>
<%
String czy = (String) session.getAttribute("czyid");

//获取系统时间
String datestr=getSystemDate(0); 
boolean bflag = true;
String errMsg = "";//错误消息
String sqlstr;//数据库字段
String uid="";

String cust_name = "";//客户名称
String corde_id="";//卡号
String hire_date="";//收款日期
double rent_all = 0.0;//收款金额

ResultSet rs ;
int iallcol=0;

String filePath;
String fileName = "";
String message = "";

//设定附件相对路径
	String path = pageContext.getServletContext().getRealPath("/");
	String allpath =path + "\\upload\\zdkk\\up\\"+datestr+"\\";
	String filepath="";
	fileBean.setObjectPath( allpath );
	//设定上传附件总体大小限制
	fileBean.setSize(8*1024*1024);
	//设定上传附件文件类型
	fileBean.setSuffix(".xls");
	//设定上传用户ID
	if ( ( czy != null ) && ( !czy.equals("") ) ) {
	   uid=czy.substring(7);
	}
	fileBean.setUserid(uid);
	fileBean.setSourceFile(request);//文件上传
	String [] saSourceFile = fileBean.getSourceFile();
	String [] saObjectFile = fileBean.getObjectFileName();
	String [] saDescription = fileBean.getDescription();
	int iCount = fileBean.getCount();
	String sObjectPath = fileBean.getObjectPath();
    if(saObjectFile!=null){
	  for(int j=0;j<saObjectFile.length;j++){
		if(saObjectFile[j]!=null&&!saObjectFile[j].equals("")){ 
		System.out.print(allpath+saObjectFile[j]);
			filepath=allpath+saObjectFile[j];
			execlBean.setExecl(filepath);
			if(execlBean.getFlag()){
				String [][]obj = execlBean.getObject();
				for(int row=0;row<obj.length;row++){
					String []objrow = obj[row];
					cust_name=objrow[0];
					corde_id=formatNumberDoubleZero(objrow[1]);
					rent_all=Double.parseDouble((getMoneyStr(objrow[2]+"")));
					hire_date=objrow[3];
					
///////////////////回笼操作区////////////////////////////
/*开始通过卡号回笼-----------------------------------------------------------------------------------------------------*/
			//保存此次回笼记录
			sqlstr="insert into fund_butten_list (cust_id,acc_number,receive_date,receive_money,creator,create_date)" +
			" values ('"+cust_name+"','"+corde_id+"','"+hire_date+"','"+rent_all+"','"+czy+"','"+datestr+"')";
			int tag=0;
			System.out.println(sqlstr);
			tag=db.executeUpdate(sqlstr); 
			if(tag==0){
				errMsg+="无法保存卡号:"+corde_id+"的回笼操作记录,因此不进行此卡的回笼!";
				continue;
			}
			sqlstr="select @@identity as id";
			rs = db.executeQuery(sqlstr);
			String ebank_number="";//将此次操作记录关联到实际回笼表
			if(rs.next()){
				ebank_number=rs.getString("id");
			}
			rs.close();
			//根据卡号查找有几个合同
			sqlstr="select count(contract_id) as size from contract_signatory where client_acc_number='"+corde_id+"'";
			System.out.println(sqlstr);
			rs = db.executeQuery(sqlstr);
			int i=0;
			if(rs.next()){
			i=rs.getInt("size");
			}
			rs.close();
			//根据卡号查找合同编号 
			sqlstr="select contract_id from contract_signatory where client_acc_number='"+corde_id+"'";
			System.out.println(sqlstr);
			rs = db.executeQuery(sqlstr);			
			if(i==0){
				errMsg+="没有找到卡号:"+corde_id+"对应的合同!";
				System.out.println(errMsg);
				continue;
			}
			String[] contract_ids=new String[i];//合同编号 一个卡号可能对应多个合同编号
			i=0;
			while(rs.next()){
				contract_ids[i]=rs.getString("contract_id");
				i++;
			}
			rs.close();

			sqlstr="select id,contract_id,rent_list,plan_status,rent,corpus,interest from  fund_rent_plan where  ";
			for (j = 0; j < contract_ids.length; j++) {
				sqlstr+=" (contract_id='"+contract_ids[j]+"' and plan_status<>'已回笼' )";
				if(j!=contract_ids.length-1){
					sqlstr+=" or ";
				}
			}
			sqlstr +="  order by plan_date,contract_id";
			System.out.println(sqlstr);
			rs = db.executeQuery(sqlstr);
			String[] temp_data=new String [3];//存储回笼到哪一期了.
			temp_data[0]=contract_ids[0];
			temp_data[1]=1+"";
			temp_data[2]=1+"";
			//回笼租金
			while(rs.next()){
				String id=rs.getString("id");
				String contract_id=rs.getString("contract_id");//合同编号
				int rent_list=rs.getInt("rent_list");//计划期项
				String plan_status=rs.getString("plan_status");//回笼状态
				double rent=rs.getDouble("rent");//计划回笼租金
				double corpus=rs.getDouble("corpus");//计划回笼本金
				double interest=rs.getDouble("interest");//计划回笼租息
				if(plan_status=="部分回笼"||plan_status.equals("部分回笼")){
					//查询上一次部分回笼期数
					int hire_list=0;
					sqlstr="select hire_list  from fund_rent_income where contract_id='"+contract_id+"' and plan_list='"+rent_list+"'";
					System.out.println(sqlstr);
					ResultSet rs1 = db1.executeQuery(sqlstr);
					if(rs1.next()){
					hire_list=rs1.getInt("hire_list")+1;//期数加1为这次回笼期数
					}
					rs1.close();
					//查询此期以还
					double[] hire=new double[3];
					sqlstr="select sum(rent) as rent,sum(corpus) as corpus,sum(interest) as interest " +
					"from fund_rent_income where contract_id='"+contract_id+"' group by plan_list  having plan_list='"+rent_list+"'";
					System.out.println(sqlstr);
					rs1 = db1.executeQuery(sqlstr);
					if(rs1.next()){
						hire[0]=rs1.getDouble("rent");//租金
						hire[1]=rs1.getDouble("corpus");//本金
						hire[2]=rs1.getDouble("interest");//租息
					}
					rs1.close();

					if((rent_all-(rent-hire[0]))>=0){//足够回笼此期
						//回笼此次 部分回笼期项
						sqlstr="insert into fund_rent_income " +
						"(contract_id,ebank_number,plan_list,hire_list,balance_mode,hire_date,rent,currency,corpus,interest,penalty," +
						"rent_adjust,corpus_adjust,interest_adjust,penalty_adjust,hire_object,hire_number,creator,create_date) values " +
						"('"+contract_id+"','"+ebank_number+"','"+rent_list+"','"+hire_list+"','BalanceWay1','"+hire_date+
						"','"+(rent-hire[0])+"','CoinType1','"+(corpus-hire[1])+"','"+(interest-hire[2])+"','0','0','0','0','0','"+
						cust_name+"','"+corde_id+"','"+czy+"','"+datestr+"')";
						System.out.println(sqlstr);
						db1.executeUpdate(sqlstr);
						sqlstr="update fund_rent_plan set plan_status='已回笼' where id='"+id+"'";
						System.out.println(sqlstr);
						db1.executeUpdate(sqlstr);
						rent_all=rent_all-(rent-hire[0]);//把总金额改变
					}else{
						//记录会回笼租金到哪里了就不够了
						temp_data[0]=contract_id;
						temp_data[1]=rent_list-1+"";
						temp_data[2]=hire_list+"";
						break;//不够就退出回笼租金
					}
				}
				if(plan_status=="未回笼"||plan_status.equals("未回笼")){
					if((rent_all-rent)>=0){//足够回笼此期
						sqlstr="insert into fund_rent_income " +
						"(contract_id,ebank_number,plan_list,hire_list,balance_mode,hire_date,rent,currency,corpus,interest,penalty," +
						"rent_adjust,corpus_adjust,interest_adjust,penalty_adjust,hire_object,hire_number,creator,create_date) values " +
						"('"+contract_id+"','"+ebank_number+"','"+rent_list+"','1','BalanceWay1','"+hire_date+
						"','"+rent+"','CoinType1','"+corpus+"','"+interest+"','0','0','0','0','0','"+
						cust_name+"','"+corde_id+"','"+czy+"','"+datestr+"')";
						System.out.println(sqlstr);
						db1.executeUpdate(sqlstr);
						sqlstr="update fund_rent_plan set plan_status='已回笼' where id='"+id+"'";
						System.out.println(sqlstr);
						db1.executeUpdate(sqlstr);
						rent_all=rent_all-rent;//把总金额改变
					}else if(rent_all-interest>0){//不够还租金但是够还租息
						sqlstr="insert into fund_rent_income " +
						"(contract_id,ebank_number,plan_list,hire_list,balance_mode,hire_date,rent,currency,corpus,interest,penalty," +
						"rent_adjust,corpus_adjust,interest_adjust,penalty_adjust,hire_object,hire_number,creator,create_date) values " +
						"('"+contract_id+"','"+ebank_number+"','"+rent_list+"','1','BalanceWay1','"+hire_date+
						"','"+interest+"','CoinType1','0','"+interest+"','0','0','0','0','0','"+
						cust_name+"','"+corde_id+"','"+czy+"','"+datestr+"')";
						System.out.println(sqlstr);
						db1.executeUpdate(sqlstr);
						sqlstr="update fund_rent_plan set plan_status='部分回笼' where id='"+id+"'";
						System.out.println(sqlstr);
						db1.executeUpdate(sqlstr);
						rent_all=rent_all-interest;//把总金额改变
						//记录会回笼租金到哪里了就不够了
						temp_data[0]=contract_id;
						temp_data[1]=rent_list+"";
						temp_data[2]="1";
						break;
					}else{	
						//记录会回笼租金到哪里了就不够了
						temp_data[0]=contract_id;
						temp_data[1]=rent_list-1+"";
						temp_data[2]="1";
						break;//不够就退出回笼租金
					}
				}
			}//回笼租金结束
			//回笼罚息
			sqlstr="select id,contract_id,hire_date,penalty from fund_rent_income where ";
			for (j = 0; j < contract_ids.length; j++) {
				sqlstr+=" contract_id='"+contract_ids[j]+"'";
				if(j!=contract_ids.length-1){
					sqlstr+=" or ";
				}
			}
			sqlstr+="  order by hire_date,contract_id";
			System.out.println(sqlstr);
			rs = db.executeQuery(sqlstr);
			while(rs.next()){
				String id=rs.getString("id");//用来唯一表示此条数据
				String contract_id=rs.getString("contract_id");//合同编号
				String hire_date_temp=rs.getString("hire_date");//还款日  用于计算罚息
				double penalty_hire=rs.getDouble("penalty");//已经还了的罚息 
				sqlstr="select dbo.bb_getPunishInterest('"+contract_id+"','"+hire_date_temp+"') as fx";
				System.out.println(sqlstr);
				ResultSet rs1 = db1.executeQuery(sqlstr);
				rs1.next();
				double penalty_plant=rs1.getDouble("fx");//计算所要还的罚息
				System.out.println("计算所要还的罚息"+penalty_plant);
				rs1.close();
				if(penalty_plant==0||penalty_hire==penalty_plant){//罚息为零或者实还罚息等于计算所得罚息则跳过此条罚息回笼
					System.out.println("跳过罚息");
					continue;
				}

				double penalty_plant_temp=penalty_plant-penalty_hire;//要还罚息
				if(rent_all<penalty_plant_temp){//余额比要还的罚息小
					System.out.println("buzu");
					sqlstr="update fund_rent_income set penalty='"+(penalty_hire+rent_all)+"' where id='"+id+"'";
					System.out.println(sqlstr);
					db1.executeUpdate(sqlstr);
					rent_all=0;
					break;
				}else{//足够偿还罚息
					System.out.println("zu");
					sqlstr="update fund_rent_income set penalty='"+penalty_plant+"' where id='"+id+"'";
					System.out.println(sqlstr);
					db1.executeUpdate(sqlstr);
					rent_all=rent_all-penalty_plant_temp;
				}
			}
			rs.close();
			if(rent_all>0){//还了罚息还有钱则把剩下的钱还本金				
				sqlstr="update fund_rent_income set corpus='"+(rent_all)+"',rent=rent+'"+rent_all+"' where contract_id='"+temp_data[0]+"' and plan_list='"+temp_data[1]+"' and hire_list='"+temp_data[2]+"'";
				System.out.println(sqlstr);
				db.executeUpdate(sqlstr);
			}
			//回笼罚息结束
			/*回笼结束--------------------------------------------------------------------------------------------------------------*/
////////////////////////////////////////////////////////
iallcol++;
				} 
			}else{
				bflag = false;
				errMsg +=saObjectFile[j]+execlBean.getErrMsg()+";";
				execlBean.deleteFile(allpath+saObjectFile[j]);
			}
			//保存记录
			String filename=new java.util.Date().getTime()+".xls";
			saveFileToFile(filepath,path+"\\upload\\zdkk\\down\\"+filename);			
			String czyid=(String)session.getAttribute("czyid");
			String createdate=getSystemDate(0);
			sqlstr="insert into rent_list (type,creator,createdate,addr,remark) values ('0','"+czy+"','"+createdate+"','"+filename+"','"+errMsg+"')";
			db.executeUpdate(sqlstr);
		 }
	  }
    }
	db1.close();
	
	
	
	
    db.close();
	if(bflag&&message.equals("")){
		%>
		<script>
		alert("上传数据成功!本次共上传<%=iallcol%>条回笼记录");
		<%
		if(errMsg!=""||(!errMsg.equals(""))){
			%>
			alert("但是其中某些数据出现了如下错误:<%=errMsg%>");
			<%
		}
	}else{
		
		System.out.println("message:"+message);
	%>
	<script>
	alert("上传主动扣款信息失败,execl文件<%=errMsg%>数据格式错误");
	opener.location.reload();
	<%
	}
	%>
		opener.location.reload();
		this.close();
	</script>