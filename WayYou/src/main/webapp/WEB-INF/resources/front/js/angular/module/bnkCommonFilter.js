/*******      Filter            *******/
angular.module('bnk-common.filter', [])
//구입조건 필터
/**
 * 예제
 * {{'I'| buyGbFilter}}
 */
.filter('buyGbFilter',function(){
	return function(input){
		var out='';
		if(input == 'C'){
			out = '현금';
		}else if(input == 'I'){
			out = '할부';
		}
		return out;
	}
})
//가격 필터
/**
 * 예제
 * {{'123456789'|moneyFilter}}
 */
.filter('moneyFilter',function(){
	return function(input){
		var out='';
		out = Number(input).toLocaleString('en');
		return out;
	}
})
//이메일 필터
/**
 * 예제
 * {{'10'| emailFilter}}
 */
.filter('emailFilter',function(){
	return function(input){
		var out='';
		var codeArr = emailCodeList;
		for(var i=0; i<codeArr.length; i++){
			if(input == codeArr[i].cdDtlNo){
				out=codeArr[i].cdDtlNm;
				break;
			}
		}
		return out;
	}
})
//날짜 포멧 필터
/**
* 예제
* {{'date'| dateFormat}}
* return yyyy
*/
.filter('dateFormat4',function(){
	return function(input){
		if(input){
			var basicDate = input.replace(/[^0-9]/g, '');
			var year = basicDate.substring(0,4)
		}else{
			out = '-';
		}
		return year;
	}
})
/**
* 예제
* {{'date'| dateFormat6}}
* return yyyy-mm
*/
.filter('dateFormat6',function(){
	return function(input){
		var out = '';
		if(input){
			var basicDate = input.replace(/[^0-9]/g, '');
			var year = basicDate.substring(0,4);
			var month = basicDate.substring(4,6);
			out = year+'-'+month;
		}else{
			out = '-';
		}
		return out;
	}
})
/**
* 예제
* {{'date'| dateFormat8}}
* return yyyy-mm-dd
*/
.filter('dateFormat8',function(){
	return function(input){
		var out = '';
		if(input){
			var basicDate = input.replace(/[^0-9]/g, '');
			var year = basicDate.substring(0,4);
			var month = basicDate.substring(4,6);
			var day = basicDate.substring(6,8);
			out = year+'-'+month+'-'+day;
		}else{
			out = '-';
		}
		return out;
	}
})
/**
* 예제
* {{'date'| dateFormatTime}}
* return yyyy-mm-dd hh:MM:ss
*/
.filter('dateFormatTime',function(){
	return function(input){
		var out = '';
		if(input){
			var basicDate = input.replace(/[^0-9]/g, '');
			var year = basicDate.substring(0,4);
			var month = basicDate.substring(4,6);
			var day = basicDate.substring(6,8);
			var hour = basicDate.substring(8,10);
			var minute = basicDate.substring(10,12);
			var second = basicDate.substring(12,14);
			out = year+'-'+month+'-'+day+' '+hour+':'+minute+':'+second;
		}else{
			out = '-';
		}
		return out;
	}
})
/**
 * 예제
 * {{ecStatus | ecStatusFilter}}
 *
 */
.filter('ecStatusFilter', function(){
	return function(input){
		var out = '';
		for(var i = 0; i < ecStatusCodeList.length; i++){
			if(ecStatusCodeList[i].cdDtlNo == input){
				out = ecStatusCodeList[i].cdDtlNm;
			}
		}
		return out;
	}
})
/**
* 에제
* {{ctStatus | ctStatusFilter}}
*/
.filter('ctStatusFilter', function(){
	return function(input){
		var out = '';
		for(var i = 0; i < ctStatusCodeList.length; i++){
			if(ctStatusCodeList[i].cdDtlNo == input){
				out = ctStatusCodeList[i].cdDtlNm;
			}
		}
		return out;
	}
})
.filter('matchGroup', function() {
	return function(input, code, index) {
		var out = '';
		if(input){
			if(code == 1){
				var result = phoneRegex.exec(input);
				if(result){
					out = result[index];
				}
			}else{
				var result = telRegex.exec(input);
				if(result){
					out = result[index];
				}
			}
		}
		return out;
	};
})
.filter('dateFormat', function() {
	return function(input, format) {
		var out = '';
		if(input){
			if(format == 'yyyy'){
				out = input.substring(0,4);
			}else if(format = 'MM'){
				out = input.substring(4,6);
			}else if(format = 'dd'){
				out = input.substring(6,8);
			}
		}
		return out;
	};
})
.filter('noteOption', function() {
	return function(input, bit) {
		var out = '';
		if(input&&bit){
			if(input & bit){
				out = 'V';
			}
		}
		return out;
	};
})
//필터추가 2017-06-08 hk-lee
.filter('suffix', function($util){
	return function(input, param1){
		var out ='';
		if($util.isNotEmpty(input)){
			out = input + param1;
		}else{
			out = '없음';
		}
		return out;
	}
})
.filter('isEmpty', function($util){
	return function(input){
		var out = $util.isEmpty(input) ? '없음' : input;
		return out;
	}
})
.filter('nvl', function($util){
	return function(input, param1){
		return $util.nvl(input, param1);
	}
})
.filter("phoneHyphen", function($util){
    return function(phone) {
    	if($util.isEmpty(phone)){
    		return;
    	}
        var pNo = '', len = phone.length;
        // TODO argument로 넘어오는 phone에 문자가 들어가 있을 경우 걸러냄
        if(len < 7) {
            pNo = phone.replace(/(^02.{0}|^01.{1}|^0505.{0}|[0-9]{3})([0-9]{1,4})/,'$1-$2');
        } else if(len < 10){
            pNo = phone.replace(/(^02.{0}|^01.{1}|^0505.{0}|[0-9]{3})([0-9]{3})([0-9])/,'$1-$2-$3');
        } else {
            pNo = phone.replace(/(^02.{0}|^01.{1}|^0505.{0}|[0-9]{3})([0-9]{3,4})([0-9]{4})/,'$1-$2-$3');
        }
        return pNo;
    }
})

//가운데 휴대폰번호 가운데 **** 처리
.filter("securityPhon", function($util){
    return function(phone) {
    	if($util.isEmpty(phone)){
    		return;
    	}
        var pNo = '', len = phone.length;
        // TODO argument로 넘어오는 phone에 문자가 들어가 있을 경우 걸러냄
        if(len < 7) {
            pNo = phone.replace(/(^02.{0}|^01.{1}|^0505.{0}|[0-9]{3})([0-9]{1,4})/,'$1-****');
        } else if(len < 11){
            pNo = phone.replace(/(^02.{0}|^01.{1}|^0505.{0}|[0-9]{3})([0-9]{3})([0-9])/,'$1-***-$3');
        } else {
            pNo = phone.replace(/(^02.{0}|^01.{1}|^0505.{0}|[0-9]{3})([0-9]{3,4})([0-9]{4})/,'$1-****-$3');
        }
        return pNo;
    }
})