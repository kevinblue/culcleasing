<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>测试jquery循环遍历</title>
<script Language="Javascript" src="scripts/jquery.js"></script>
<script Language="Javascript" src="scripts/ajaxfileupload.js"></script>
<style type="text/css">
.divcss5{

} 
</style>
</head>
<script type="text/javascript">
/**
 * 基本思路：主要是用来设计删除或者修改功能
 *方案一：在每行的第一列中添加隐藏的input框来获取指定的参数
 *通过jquery遍历的方式获取所有对象对应的值并以|隔开的字符串
 *js(字符串转数组)var s = "abc,abcd,aaa";
 *ss = s.split(",");// 在每个逗号(,)处进行分解。
 *java(字符串转数组)
 *String items="1000|2000|3000";
 *String[] item = items.split("\\|");
 *js(遍历对象)获取对象对应的值 
 *	 var items ={
 *     'Website_logo_title':'学而思',
 *	     'Website_logo_Theme':'教育行业',
 *     'Website_logo_Company':'好未来'
 *  };
 * var temp="";
 *  for(var i in items){//用javascript的for/in循环遍历对象的属性 
 * temp += i+":"+items[i]+"\n"; //拼接字符串、、目的为了当参数传值 \n表示“|“
 * Websitelogo =Websitelogo+'&'+''+Key+'='+items[Key]+'';
 *	} 
 *jQuery(遍历对象)获取对象对应的值 
 */
function updMaterStatus(){
	var flag = 0;
	var erItems = "";
	var items = "";
	var item="";
	var begin_id="";
	var rent_list="";
	var invoice_remark="";
	$("#data>tr").each(function(i){
	    var $materTr = $(this); //获取当前对象
	    alert("this"+$materTr);
	    item = $materTr.find("td>:input[name^='it_']");//td下input框name已it_开头的所有
	    begin_id=$materTr.find("td>:input[name^='begin_id_']");
	    rent_list=$materTr.find("td>:input[name^='rent_list_']");
	    //方式1：
		items += $.trim(item.val())+"|";// 以|分实体以-分字段  //jquery的方式获取对象所对应的值，并以|隔开
		alert(item);//都是对象	
		alert(items);//都是对象	
	});
	//方式2：如果不是jquery可用以下方法遍历
	var temp="";
	var temp1="";
	for(var i in items){//用javascript的for/in循环遍历对象的属性 
		temp += i+":"+items[i]+"\n"; 
		temp1+=items[i]+"\n"; 
	alert("temp:"+temp);
	alert("temp1:"+temp1);
		} 
	alert("temp所有:"+temp);
	alert("temp1所有:"+temp1);
}
</script>
 <body> 
 <input class="btn_2" type="button"  value="测试循环" onclick="return updMaterStatus();">
   <table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" cellspacing="1" width="100%" 
   class="maintab_content_table" >
   <tr class="maintab_content_table_title">
     	<th>项目编号</th>
		<th>起租编号</th>
	    <th>项目名称</th>
	    <th>客户名称</th>
		<th>部门名称</th>
	    <th>大区名称</th>
     	<th>项目经理</th>
 		<th>租金笔数</th>	
    </tr>
 <tbody id="data"> 
       <tr class="materTr_1">
        <td align="left">1
        <input type="hidden" name="it_1" value="1">
	    <input type="hidden" name="begin_id_1" value="1"/>
	    <input type="hidden" name="rent_list_1" value="1"/>
        </td>
        <td align="left">2</td>
        <td align="left">3</td>
		<td align="left">4</td>
        <td align="left">5</td>
        <td align="left">6</td>
        <td align="left">7</td>
        <td align="left">8</td>
        </tr>
        <tr class="materTr_2">
        <td align="left">a
        <input type="hidden" name="it_2" value="2">
	    <input type="hidden" name="begin_id_2" value="2"/>
	    <input type="hidden" name="rent_list_2" value="2"/></td>
        <td align="left">a</td>
        <td align="left">a</td>
		<td align="left">a</td>
        <td align="left">a</td>
        <td align="left">a</td>
        <td align="left">a</td>
        <td align="left">a</td>
        </tr>
        <tr class="materTr_3">
        <td align="left">c
        <input type="hidden" name="it_3" value="3">
	    <input type="hidden" name="begin_id_3" value="3"/>
	    <input type="hidden" name="rent_list_3" value="3"/></td>
        <td align="left">d</td>
        <td align="left">ds</td>
		<td align="left">d</td>
        <td align="left">dt</td>
        <td align="left">6t</td>
        <td align="left">72</td>
        <td align="left">80</td>
        </tr>
        <tr class="materTr_4">
        <td align="left">1
        <input type="hidden" name="it_4" value="4">
	    <input type="hidden" name="begin_id_4" value="4"/>
	    <input type="hidden" name="rent_list_4" value="4"/></td>
        <td align="left">2</td>
        <td align="left">3</td>
		<td align="left">4</td>
        <td align="left">5</td>
        <td align="left">6</td>
        <td align="left">7</td>
        <td align="left">8</td>
        </tr>
        <tr class="materTr_5">
        <td align="left">1
        <input type="hidden" name="it_5" value="5">
	    <input type="hidden" name="begin_id_5" value="5"/>
	    <input type="hidden" name="rent_list_5" value="5"/></td>
        <td align="left">2</td>
        <td align="left">3</td>
		<td align="left">4</td>
        <td align="left">5</td>
        <td align="left">6</td>
        <td align="left">7</td>
        <td align="left">8</td>
        </tr>
         </tbody> 
        </table>
</body>
</html>