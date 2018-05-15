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
<%
String czy = (String) session.getAttribute("czyid");
ResultSet rs ;
String sqlstr;
String cust_name = "";//客户名称
String corde_id="";//卡号
String hire_date="";//收款日期
double rent_all = 0.0;//收款金额

//获取系统时间
String datestr=getSystemDate(0); 
int fag=0;//数据库操作返回值
boolean bflag = true;//整体是否上传成功
boolean dele=false;//是否要做撤销
String rent_id="";//总记录ID
int iallcol=0;//成功读取记录数
String errMsg = "";//警告消息(数据不合法型)
String message = "";//错误消息(上传失败型)
String filepath="";//文件路径

//设定附件相对路径
	String path = pageContext.getServletContext().getRealPath("/");
	String allpath =path + "\\upload\\zdkk\\up\\";
	fileBean.setObjectPath( allpath );
	//设定上传附件总体大小限制
	fileBean.setSize(8*1024*1024);
	//设定上传附件文件类型
	fileBean.setSuffix(".xls");
	//设定上传用户ID
	fileBean.setUserid("");//设置了用户名之后.上传的文件会以 用户名+当前毫秒时间 为文件名
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
			try{
			execlBean.setExecl(filepath);
			}catch(Exception e){
				bflag = false;
				sqlstr="insert into rent_list (type,creator,createdate,addr,is_verification,remark) values ('0','"+czy+"',getdate(),'"+saObjectFile[j]+"','2','您上传的是个空文件!')";
				fag=db.executeUpdate(sqlstr);
				if(fag==0){
					message+="保存上传记录失败!";
					dele=true;
				}else{
					message="您上传了个空文件!";
				}
				break;
			}
			//保存记录			
			sqlstr="insert into rent_list (type,creator,createdate,addr,is_verification) values ('0','"+czy+"',getdate(),'"+saObjectFile[j]+"','0')";
			fag=db.executeUpdate(sqlstr);
			if(fag==0){
				message+="保存上传记录失败!";
				dele=true;
				bflag = false;
			}else{
				sqlstr="select @@identity as id";
				rs = db.executeQuery(sqlstr);
				rs.next();
				rent_id=rs.getString("id");
				if(execlBean.getFlag()){
					String [][]obj = execlBean.getObject();
					for(int row=0;row<obj.length;row++){
						try{
						iallcol++;
						//读取文件中的内容保存到fund_butten_list 
						String []objrow = obj[row];
						cust_name=objrow[0];
						corde_id=formatNumberDoubleZero(objrow[1]);
						rent_all=Double.parseDouble((getMoneyStr(objrow[2]+"")));
						hire_date=objrow[3];
						sqlstr="select * from (select client_acc_number,dbo.getcustnamebycontractid(contract_id) as cust_name from contract_signatory ) as acc where acc.client_acc_number='"+corde_id+"' and acc.cust_name='"+cust_name+"'";
						System.out.println(sqlstr);
						rs=db.executeQuery(sqlstr); 
						if(rs.next()){
							sqlstr="insert into fund_butten_list (cust_name,acc_number,receive_date,receive_money,creator,create_date,rent_id)" +" values ('"+cust_name+"','"+corde_id+"','"+hire_date+"','"+rent_all+"','"+czy+"','"+datestr+"','"+rent_id+"')";
							System.out.println(sqlstr);
							fag=db.executeUpdate(sqlstr); 
							if(fag==0){
								errMsg+="无法保存卡号:"+corde_id+"的回笼操数据!";
								dele=true;
								continue;
							}
						}else{
							dele=true;
							errMsg+="第"+(row+1)+"行数据的卡号和客户名无法和数据库像匹配!";
						}
						}catch(Exception e){
							dele=true;
							bflag = false;
							message+="\\n导入文件错误!请确认此文件为回盘文件,且数据格式正确!";
							break;
						}
					} 
				}else{
					dele=true;
					bflag = false;
					message+=execlBean.getErrMsg();
					errMsg +=saObjectFile[j]+execlBean.getErrMsg()+";";
				}
			}
		 }
	  }
    }
	if(dele){//撤销操作
		sqlstr="delete from fund_butten_list where rent_id='"+rent_id+"'";
		db.executeUpdate(sqlstr);
		sqlstr="delete from rent_list where id='"+rent_id+"'";
		db.executeUpdate(sqlstr);
		execlBean.deleteFile(filepath);//删除该文件
	}
    db.close();
	if(bflag&&message.equals("")){
		%>
		<script>
		alert("数据读取成功!本次共成功读取<%=iallcol%>条回笼记录");
		<%
		if(errMsg!=""||(!errMsg.equals(""))){
			%>
			alert("但是其中某些数据出现了如下错误:<%=errMsg%>.所以此次数据全部撤销,请修正后再上传!");
			<%
		}
	}else{		
		System.out.println("message:"+message);
	%>
	<script>
	alert("上传主动扣款信息失败,原因:<%=message%>");
	opener.location.reload();
	<%
	}
	%>
		opener.location.reload();
		this.close();
	</script>