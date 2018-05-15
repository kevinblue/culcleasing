function myfun(act,theUrl,objItem,str) {
	var czid;	
	var msg1 = "没有可";
	if (objItem!=null){
		if(objItem.length==undefined){
			if(objItem.checked){
				czid=objItem.value;
				//alert("czid:"+czid);
			}
		}else{
			for (i=0;i<objItem.length;i++){
				if (objItem[i].checked){
					czid=objItem[i].value;
				}
			}
		}
		msg1 = "请选中要";
		
		
		if (!czid){
				alert(msg1+"删除的项目！");
				return false;
			} else {
				if (!confirm("您确定要删除您选中的项目?")){
				//alert("test");
					return false;
				}
				dataHander(act,theUrl,objItem,str);
				return true;
			}
		}
		
		//return true;
}