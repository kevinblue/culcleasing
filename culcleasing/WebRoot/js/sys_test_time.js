//�жϵ�ǰѡ���������ϵͳ��ǰ��������1����
function validDate(chuanDate,date){
	//var now = Date().getDate();
	var now =date
	//var choiDate = $(":input[name='plan_date']").val();
	var choiDate = chuanDate
	var difDays = DateDiff(now, choiDate);
	//alert("��ǰ���ڣ�"+now+"__"+choiDate+"���"+difDays);
	if( choiDate < now ){
		alert("�ƻ����ڲ���С�ڵ�ǰ���ڣ�ϵͳ��Ĭ����/��ʱ��Ϊ��ǰ���ڣ�");
		//clearText
		$(":input[name='plan_date']").val(now);
	}else if( difDays>300 ){
		alert("��ѡ����Ч�ļƻ���/�������ڣ�������ǰϵͳʱ��ϳ���");
		//$(":input[name='plan_date']").val(now);
		//$(":input[name='plan_date']").val("");
	}
}
//����������
function DateDiff(beginDate, endDate)   //���������ĺ���
{    
    //beginDate��endDate����2007-8-10��ʽ
    var arrbeginDate, Date1,Date2,arrendDate,iDays 
    arrbeginDate= beginDate.split("-") 
    Date1= new Date(arrbeginDate[1]+'-'+arrbeginDate[2]+'-'+arrbeginDate[0])    //ת��Ϊ8-10-2007��ʽ
    arrendDate= endDate.split("-") 
    Date2= new Date(arrendDate[1]+'-'+arrendDate[2]+'-'+arrendDate[0]) 
    iDays = parseInt(Math.abs(Date1- Date2)/1000/60/60/24)        //ת��Ϊ���� 
    return iDays 
}