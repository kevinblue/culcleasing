  String.prototype.replaceAll  = function(s1,s2){    
	return this.replace(new RegExp(s1,"gm"),s2);    
} 
/*************************************************

	Validator v1.04 修改版本
	original code by 我佛山人	wfsr@msn.com
	修改 by SOMAX  2003.04.08 v1.04m6
		修改内容: 
		1.添加默认错误信息
		2.允许同时Limit,LimitB验证方法
		3.允许同时Compare验证方法,根据to自动判断是对象还是数值
		4.添加label标签，用于弹出式错误信息
		5.可选择显示提交表单前的确认对话框(confirm)
	
*************************************************/
 Validator = {
	Require : /.+/,
	Email : /^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/,
	Phone : /^((\(\d{2,3}\))|(\d{3}\-))?(\(0\d{2,3}\)|0\d{2,3}-)?[1-9]\d{6,7}(\-\d{1,4})?$/,
	Mobile : /^((\(\d{2,3}\))|(\d{3}\-))?13\d{9}$/,
        Mobile_T:/^(13[0-9]|15[0|3|6|7|8|9]|18[8|9])\d{8}$/,
         Rank  :/^\d{19}$/,
	Url : /^http:\/\/[A-Za-z0-9]+\.[A-Za-z0-9]+[\/=\?%\-&_~`@[\]\':+!]*([^<>\"\"])*$/,
	IdCard : /^\d{15}(\d{2}[A-Za-z0-9])?$/,
	Currency : /^\d+(\.\d+)?$/,
	Number : /^\d+$/,
	Zip : /^[1-9]\d{5}$/,
	QQ : /^[1-9]\d{4,8}$/,
	Integer : /^[-\+]?\d+$/,
	Double : /^[-\+]?\d+(\.\d+)?$/,
	Money : /^[-\+]?\d+(\.[0-9]{1,2})?$/,	
	Rate: /^\d+(\.[0-9]{1,20})?$/,	
        DifferenceRate: /^(-|\d)+(\.[0-9]{1,6})?$/,
	English : /^[A-Za-z]+$/,
	Chinese :  /^[\u0391-\uFFE5]+$/,
	Username : /^[a-z]\w{3,}$/i,
	UnSafe : /^(([A-Z]*|[a-z]*|\d*|[-_\~!@#\$%\^&\*\.\(\)\[\]\{\}<>\?\\\/\'\"]*)|.{0,5})$|\s/,
	IsSafe : function(str){return !this.UnSafe.test(str);},
	SafeString : "this.IsSafe(value)",
	Filter : "this.DoFilter(value, getAttribute('accept'))",
	Limit : "this.limit(value.length,getAttribute('min'),  getAttribute('max'))",
	LimitB : "this.limit(this.LenB(value), getAttribute('minB'), getAttribute('maxB'))",
	Date : "this.IsDate(value, getAttribute('min'), getAttribute('format'))",
	Repeat : "value == document.getElementsByName(getAttribute('to'))[0].value",
	Range : "getAttribute('min') < (value|0) && (value|0) < getAttribute('max')",
	Compare : "this.compare(value,getAttribute('operator'),getAttribute('to'))",
	Custom : "this.Exec(value, getAttribute('regexp'))",
	Group : "this.MustChecked(getAttribute('name'), getAttribute('min'), getAttribute('max'))",
	ErrorItem : [document.forms[0]],
	ErrorMessage : ["以下原因导致提交失败：\t\t\t\t"],
	
	ErrRequire : "必填项",
	ErrEmail : "信箱格式不正确",
	ErrPhone : "不是有效的电话号码",
	ErrMobile : "不是有效手机号码",
     
	ErrUrl : "基于HTTP协议的网址格式错误",
	ErrIdCard : "不是有效身份证号码",
	ErrCurrency : "货币格式错误",
	ErrNumber : "必须为数字",
	ErrZip : "不是有效的邮政编码",
	ErrQQ : "不是有效QQ号码",
	ErrInteger : "必须为整数",
	ErrDouble : "必须为实数",
	ErrMoney : "金额格式不正确，必须为实数并且小数在两位以内",
	ErrRate : "必须为正实数并且小数在六位以内",
    ErrDifferenceRate : "必须为实数并且小数在六位以内",
 
	ErrEnglish : "只允许英文",
	ErrChinese :  "只允许中文",
	ErrUsername : "不是有效的用户名格式",
	ErrUnSafe : "ErrUnSafe",
	ErrIsSafe : "ErrIsSafe",
	ErrSafeString : "不符合安全密码规则",
	ErrFilter : "不被允许的文件格式",
	ErrLimit : "字数超出限制范围",
	ErrLimitB : "字节数超出限制范围(中文占2字节)",
	ErrDate : "不是有效的日期",
	ErrRepeat : "重复输入错误",
	ErrRange : "超出输入范围",
	ErrCompare : "不符合比较规则",
	ErrCustom : "验证错误",
	ErrGroup : "必须选定一项",
	
	
	Validate : function(theForm, mode, cfm){
		if(cfm==undefined)cfm=true;
		var obj = theForm || event.srcElement;
		var count = obj.elements.length;
		this.ErrorMessage.length = 1;
		this.ErrorItem.length = 1;
		this.ErrorItem[0] = obj;
		for(var i=0;i<count;i++){
			var tempErrMsg="";//smx
			with(obj.elements[i]){
				var _dataType = (getAttribute("dataType")!=null && getAttribute("dataType")!="")?getAttribute("dataType"):"Require";//smx
				var _label = (getAttribute("label")!=null && getAttribute("label")!="")?getAttribute("label")+": ":"";//smx
				var _msg = getAttribute("msg");
				if(typeof(_dataType) == "object" || typeof(this[_dataType]) == "undefined")  continue;
				this.ClearState(obj.elements[i]);
				if(getAttribute("require") == "false" && value == "") continue;
				if(getAttribute("require") == null && value == "") continue;//smx

				if(value == ""){                  
					tempErrMsg=_label +"必须填写!"; 
				}else{                      
				 if(_dataType=="Money"){
					 if(value!=null)
					  value=value.replaceAll(",","");					
					 }				
					switch(_dataType){																								
						case "Date" :																								
						case "Repeat" :
						case "Range" :
						case "Compare" :
						case "Custom" :
						case "Group" : 
						case "Limit" :
						case "LimitB" :
						case "SafeString" :
						case "Filter" :
							if(!eval(this[_dataType]))	{
									if(_msg!=null){
										tempErrMsg+=_msg;
									}else{
										tempErrMsg+=_label + this["Err"+dataType];
									}
							}
							break;
						default :
							if(!this[_dataType].test(value)){								
									if(_msg!=null){
										tempErrMsg+=_msg;
									}else{
										tempErrMsg+=_label + this["Err"+dataType];
									}
							}
							break;
					}

					var _minB=(getAttribute('minB')!=null)?getAttribute('minB'):"0";
					var _maxB=(getAttribute('maxB')!=null)?getAttribute('maxB'):"∞";
					
					if (_minB!="0" || _maxB!="∞"){
							if(!eval(this["LimitB"])){
								if (tempErrMsg!="")tempErrMsg+="，并且";
									tempErrMsg+=_label + this["ErrLimitB"] + "("+ _minB + "-"+ _maxB + ")";
							}
					}
					
					var _min=(getAttribute('min')!=null)?getAttribute('min'):"0";
					var _max=(getAttribute('max')!=null)?getAttribute('max'):"∞";
					if (_min!="0" || _max!="∞"){
							if(!eval(this["Limit"])){
								if (tempErrMsg!="")tempErrMsg+="，并且";
									tempErrMsg+=_label + this["ErrLimit"] + "("+ _min + "-"+ _max + ")";
							}
					}

					if (getAttribute('operator')!=null){
							if(!eval(this["Compare"])){
								if (tempErrMsg==""){
									tempErrMsg+=_label + this["ErrCompare"];
								}
							}
					}

				}
				if (tempErrMsg!="")this.AddError(i, tempErrMsg);
			}
		}
		if(this.ErrorMessage.length > 1){
			mode = mode || 1;
			var errCount = this.ErrorItem.length;
			switch(mode){
			case 2 :
				for(var i=1;i<errCount;i++)
					this.ErrorItem[i].style.color = "#ff6600";
			case 1 :
				alert(this.ErrorMessage.join("\n"));
				this.ErrorItem[1].focus();
				break;
			case 3 :
				for(var i=1;i<errCount;i++){
				try{
					var span = document.createElement("SPAN");
					span.id = "__ErrorMessagePanel";
					span.style.color = "#ff6600";
					this.ErrorItem[i].parentNode.appendChild(span);
					span.innerHTML = "<br>"+this.ErrorMessage[i].replace(/.+:/,"");//smx
					}
					catch(e){alert(e.description);}
				}
				this.ErrorItem[1].focus();
				break;
			default :
				alert(this.ErrorMessage.join("\n"));
				break;
			}
			return false;
		}
		if(cfm)return confirm('确定要提交吗？');//smx
	},
	limit : function(len,min, max){
		min = min || 0;
		max = max || Number.MAX_VALUE;
		return min <= len && len <= max;
	},
	LenB : function(str){
		return str.replace(/[^\x00-\xff]/g,"**").length;
	},
	ClearState : function(elem){
		with(elem){
			if(style.color == "#ff6600")
				style.color = "";
			var lastNode = parentNode.childNodes[parentNode.childNodes.length-1];
			if(lastNode.id == "__ErrorMessagePanel")
				parentNode.removeChild(lastNode);
		}
	},
	AddError : function(index, str){
		this.ErrorItem[this.ErrorItem.length] = this.ErrorItem[0].elements[index];
		//this.ErrorMessage[this.ErrorMessage.length] = this.ErrorMessage.length + ":" + str;
		this.ErrorMessage[this.ErrorMessage.length] = str;
	},
	Exec : function(op, reg){
		return new RegExp(reg,"g").test(op);
	},
	compare : function(op1,operator,op2){
		if(typeof(document.all[op2])=="object"){
			op2=document.all[op2].value;
		}
		op1+=0;
		op2+=0;
		switch (operator) {
			case "NotEqual":
				return (op1 != op2);
			case "GreaterThan":
				return (op1 > op2);
			case "GreaterThanEqual":
				return (op1 >= op2);
			case "LessThan":
				return (op1 < op2);
			case "LessThanEqual":
				return (op1 <= op2);
			default:
				return (op1 == op2);            
		}
	},
	MustChecked : function(name, min, max){
		var groups = document.getElementsByName(name);
		var hasChecked = 0;
		min = min || 1;
		max = max || groups.length;
		for(var i=groups.length-1;i>=0;i--)
			if(groups[i].checked) hasChecked++;
		return min <= hasChecked && hasChecked <= max;
	},
	DoFilter : function(input, filter){
		return (eval("/^.+\\.("+filter.split(/\s*,\s*/).join("|")+")$/").test(input));
		//return new RegExp("^.+\.(?=EXT)(EXT)$".replace(/EXT/g, filter.split(/\s*,\s*/).join("|")), "gi").test(input);
	},

	IsDate : function(op, formatString){
		formatString = formatString || "ymd";
		var m, year, month, day;
		switch(formatString){
			case "ymd" :
				m = op.match(new RegExp("^((\\d{4})|(\\d{2}))([-./])(\\d{1,2})\\4(\\d{1,2})$"));
				if(m == null ) return false;
				day = m[6];
				month = m[5]*1;
				year =  (m[2].length == 4) ? m[2] : GetFullYear(parseInt(m[3], 10));
				break;
			case "dmy" :
				m = op.match(new RegExp("^(\\d{1,2})([-./])(\\d{1,2})\\2((\\d{4})|(\\d{2}))$"));
				if(m == null ) return false;
				day = m[1];
				month = m[3]*1;
				year = (m[5].length == 4) ? m[5] : GetFullYear(parseInt(m[6], 10));
				break;
			default :
				break;
		}
		if(!parseInt(month)) return false;
		month = month==0 ?12:month;
		var date = new Date(year, month-1, day);
        return (typeof(date) == "object" && year == date.getFullYear() && month == (date.getMonth()+1) && day == date.getDate());
		function GetFullYear(y){return ((y<30 ? "20" : "19") + y)|0;}
	}
 }
