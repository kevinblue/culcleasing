<%@ page language="java" import="java.net.URL,java.util.*"%>
<%@ page import="jxl.*"%> 
<%@ page import="jxl.*"%> 
<%@ page import="jxl.write.*"%> 
<%@ page import="java.io.*"%> 
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*" %> 
<%@ page import="java.math.BigDecimal" %> 
<%@ page import="com.*" %> 
<%@ include file="common.jsp"%>


<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 

<% 
short rownum = 0;
		String str = null;
String sql=getStr(request.getParameter("expsqlstr"));
ResultSet rs=db.executeQuery(sql); 

ResultSetMetaData rsmd = rs.getMetaData();
 int numberOfColumns = rsmd.getColumnCount();
int i=0;
BigDecimal tempdec=new BigDecimal("0.00");
response.reset();
response.setContentType("application/vnd.ms-excel;charset=GB2312");
response.setHeader("Content-disposition","attachment; filename=1.xls");
jxl.write.WritableWorkbook wwb = Workbook.createWorkbook(response.getOutputStream());
jxl.write.WritableSheet ws = wwb.createSheet("TestSheet1",0);


		jxl.write.Label l=null;
		jxl.write.Number n=null;
		jxl.write.DateTime d=null; 
		//预定义的一些字体和格式
		WritableFont headerFont = new WritableFont(WritableFont.ARIAL, 12, WritableFont.BOLD, false,jxl.format.UnderlineStyle.NO_UNDERLINE, jxl.format.Colour.BLUE); 
		WritableCellFormat headerFormat = new WritableCellFormat (headerFont); 
		WritableFont titleFont = new WritableFont(WritableFont.ARIAL, 10, WritableFont.NO_BOLD, false, jxl.format.UnderlineStyle.NO_UNDERLINE, jxl.format.Colour.RED); 
		WritableCellFormat titleFormat = new WritableCellFormat (titleFont); 
		WritableFont detFont = new WritableFont(WritableFont.ARIAL, 10, WritableFont.NO_BOLD, false, jxl.format.UnderlineStyle.NO_UNDERLINE, jxl.format.Colour.BLACK); 
		WritableCellFormat detFormat = new WritableCellFormat (detFont);
 
		jxl.write.NumberFormat nf=new jxl.write.NumberFormat("#.######");  //用于Number的格式
		WritableCellFormat priceFormat = new WritableCellFormat (detFont, nf); 


		jxl.write.DateFormat df=new jxl.write.DateFormat("yyyy-MM-dd");//用于日期的
		WritableCellFormat dateFormat = new WritableCellFormat (detFont, df); 

short cellnum;
				for (cellnum = (short)0; cellnum < numberOfColumns; cellnum++)
				{
					l = new jxl.write.Label(cellnum,0, rsmd.getColumnName(cellnum + 1), titleFormat);
					ws.addCell(l);

				}


			while(rs.next())
			{
				//为每一行附值
				i+=1;
				for (cellnum = (short)0; cellnum < numberOfColumns; cellnum++)
				{
                                       if ((rsmd.getColumnTypeName(cellnum+1).equals("money")) || (rsmd.getColumnTypeName(cellnum+1).equals("decimal")))
                                       {
                                        tempdec=rs.getBigDecimal(cellnum + 1,4);
                                        if ((tempdec==null) || (tempdec.equals("")))
                                        {
                                        tempdec=new BigDecimal("0.0000");
                                        }
                                        n = new jxl.write.Number(cellnum,i, rs.getDouble(cellnum + 1), priceFormat);
                                        ws.addCell(n);
                                       }
                                       else
                                       {
					l = new jxl.write.Label(cellnum,i, rs.getString(cellnum + 1), detFormat);
                                        ws.addCell(l);
				       }
                                        
				}
			}

 rs.close();
 db.close(); 
wwb.write();
wwb.close();

response.reset();
response.setContentType("text/html; charset=gb2312");
out.print("sdsss");
%>
