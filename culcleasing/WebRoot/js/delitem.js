function myfun(act,theUrl,objItem,str) {
	var czid;	
	var msg1 = "û�п�";
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
		msg1 = "��ѡ��Ҫ";
		
		
		if (!czid){
				alert(msg1+"ɾ������Ŀ��");
				return false;
			} else {
				if (!confirm("��ȷ��Ҫɾ����ѡ�е���Ŀ?")){
				//alert("test");
					return false;
				}
				dataHander(act,theUrl,objItem,str);
				return true;
			}
		}
		
		//return true;
}