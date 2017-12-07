var hasMacroPop = false;
var onAjaxLoadingHide = false;
(function($){

	/*
	 * 공통 제조사 코드 추가
	 * */
	$.fn.makerCombo = function(id){
		$.ajax({
			url : BNK_CTX + '/product/co/makerCombo',
			success : function(result){
				var opt = JSON.stringify(result);
				var items ="";
				items += "<option value=''>제조사</option>";
				$.each(result, function(key, value){
					items += "<option value='"+key+"'>" + value + "</option>";
				});
				$("#"+id).html(items);
			},
			error : function(request,status,error){
				alertify.alert(error);
			}
		});
	};

	$.fn.modelCombo = function(id, makerCd){
		$.ajax({
			url : BNK_CTX + '/product/co/modelCombo',
			data : {makerCd : makerCd},
			success : function(result){
				var opt = JSON.stringify(result);
				var items ="";

				if(makerCd.length == 0){
					if(id == "modelCombo"){
						items += "<option value=''>모델</option>";
					}else{
						items += "<option value=''>세부모델</option>";
					}
				}else if(makerCd.length == 3){
					items += "<option value=''>모델</option>";
				}else if(makerCd.length == 5){
					items += "<option value=''>세부모델</option>";
				}

				$.each(result, function(key, value){
					items += "<option value='"+key+"'>" + value + "</option>";
				});
				$("#"+id).html(items);
			},
			error : function(request,status,error){
				alertify.alert(error);
			}
		});
	};


	$.fn.modelSelectCombo = function(id, makerCd, modelCd){
		$.ajax({
			url : BNK_CTX + '/product/co/modelCombo',
			data : {makerCd : makerCd},
			success : function(result){
				var opt = JSON.stringify(result);
				var items ="";
				var selected = "";
				$.each(result, function(key, value){
					if(modelCd == key){
						selected = "selected";
					}
					items += "<option value='"+key+"' "+selected+">" + value + "</option>";
					selected = "";
				});
				$("#"+id).html(items);
			},
			error : function(request,status,error){
				alertify.alert(error);
			}
		});
	};


    /**
     * 행 추가
     */
    $.fn.addRow = function(data){
        var $tr = $('<tr>');
        $(this).append($tr);
        return $tr;
    };
    /**
     * 열 추가
     * @param1 각 열에 들어갈 내용
     * @param2 각 열의 내용이 코드일 경우 변환시 필요한 코드 리스트
     * @param3 td에 class가 필요한 경우
     */
    $.fn.addColumn = function(data, codeList, addClass){
        //코드 존재할시
        if(codeList && codeList instanceof Array && codeList.length > 1){
            codeList.forEach(function(c){
                if(c.cdDtlNo == data){
                    data = c.cdDtlNm;
                }
            });
        }
        var test = addClass?'class="'+addClass+'"':'';
        return $(this).append($('<td '+ test +'>').html( util.nvl(data,'') ));
    };
    /**
     * 열 추가 확장
     * @param1 각 열에 들어갈 내용
     * @param2 각 열의 내용을 임의로 작성해야하는경우 사용할 콜백함수
     */
    $.fn.addColumnEx = function(data, callback){
        var result = '';

        if($.isFunction(callback)){
            result = callback(data);
        }else{
            result = $('<td>').append(data);
        }

        return $(this).append(result);
    };
    String.prototype.replaceHyphen  = function(){
        if(typeof this === undefined){
            return;
        }
        var phone = this;
        var pNo = '', len = phone.length;
        if(len < 7) {
            pNo = phone.replace(/(^02.{0}|^01.{1}|^0505.{0}|[0-9]{3})([0-9]{1,4})/,'$1-$2');
        } else if(len < 10){
            pNo = phone.replace(/(^02.{0}|^01.{1}|^0505.{0}|[0-9]{3})([0-9]{3})([0-9])/,'$1-$2-$3');
        } else {
            pNo = phone.replace(/(^02.{0}|^01.{1}|^0505.{0}|[0-9]{3})([0-9]{3,4})([0-9]{4})/,'$1-$2-$3');
        }
        return pNo;
    }

	Storage.prototype.setObject = function(key, value) {
        this.setItem(key, JSON.stringify(value));
    }

    Storage.prototype.getObject = function(key) {
        return JSON.parse(this.getItem(key));
    }

    /*

    highlight v5

    Highlights arbitrary terms.

    <http://johannburkard.de/blog/programming/javascript/highlight-javascript-text-higlighting-jquery-plugin.html>

    MIT license.

    Johann Burkard
    <http://johannburkard.de>
    <mailto:jb@eaio.com>

    */

    $.fn.highlight = function(pat) {
     function innerHighlight(node, pat) {
      var skip = 0;
      if (node.nodeType == 3) {
       var pos = node.data.toUpperCase().indexOf(pat);
       pos -= (node.data.substr(0, pos).toUpperCase().length - node.data.substr(0, pos).length);
       if (pos >= 0) {
        var spannode = document.createElement('span');
        spannode.className = 'gmk-highlight';
        var middlebit = node.splitText(pos);
        var endbit = middlebit.splitText(pat.length);
        var middleclone = middlebit.cloneNode(true);
        spannode.appendChild(middleclone);
        middlebit.parentNode.replaceChild(spannode, middlebit);
        skip = 1;
       }
      }
      else if (node.nodeType == 1 && node.childNodes && !/(script|style)/i.test(node.tagName)) {
       for (var i = 0; i < node.childNodes.length; ++i) {
        i += innerHighlight(node.childNodes[i], pat);
       }
      }
      return skip;
     }
     return this.length && pat && pat.length ? this.each(function() {
      innerHighlight(this, pat.toUpperCase());
     }) : this;
    };

    $.fn.removeHighlight = function() {
     return this.find("span.gmk-highlight").each(function() {
      this.parentNode.firstChild.nodeName;
      with (this.parentNode) {
       replaceChild(this.firstChild, this);
       normalize();
      }
     }).end();
    };

})(jQuery);

var util = (function(){
    return {
        getOrderNum : function(obj, index, order){
            if(order == 'DESC'){
                return obj.totListSize- ((obj.curPage-1) * obj.pageListSize + index);
            }
            else if(order == 'ASC'){
                return 1 + ((obj.curPage-1) * obj.pageListSize + index);
            }else{
                return obj.totListSize- ((obj.curPage-1) * obj.pageListSize + index);
            }
        },

        dateFormatTime : function(input){
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
        },
        beforeDateFormat : function(input,startId,endId){
            var out = '';
            if(input){
                var settingDate = new Date();
                var year = settingDate.getFullYear();
                var beforeYear = settingDate.getFullYear();
                var month = (settingDate.getMonth()+1);
                var beforeMonth = (settingDate.getMonth()+1);
                var date = settingDate.getDate();
                var beforeDate = settingDate.getDate();


                switch (input) {
                case "1":
                    beforeMonth =  month-1;
                    break;
                case "3":
                    beforeMonth =  month-3;
                    break;
                case "5":
                    beforeMonth =  month-5;
                    break;
                case "6":
                    beforeMonth =  month-6;
                    break;
                case "8":
                    beforeMonth =  month-8;
                    break;
                case "12":
                    beforeYear = year-1;
                    break;
                case "24":
                    beforeYear = year-2;
                    break;

                default:
                    $(startId).val("");
                    $(endId).val("");
                    return;
                    break;
                }

                if(beforeMonth <= 0){
                    beforeMonth = 12 + beforeMonth;
                    beforeYear = year-1;
                }

                if(beforeMonth == 2 && date >= 29){
                    beforeDate = 28;
                }


                var beforeDateString = beforeYear.toString() + "-" + util.datePlus0(beforeMonth.toString()) + "-" + util.datePlus0(beforeDate.toString());
                var nowDateString = year.toString() + "-" + util.datePlus0(month.toString()) + "-" + util.datePlus0(date.toString());

                $(startId).val(beforeDateString);
                $(endId).val(nowDateString);
            }
        },

        isEmpty: function(obj){
    		return typeof obj == "undefined" || obj == "undefined" || obj == '' || obj == "null" || obj == null;
    	},
    	isNotEmpty: function(obj){
    		return !(typeof obj == "undefined" || obj == "undefined" || obj == '' || obj == "null" || obj == null);
    	},
    	nvl: function(obj, ref){
    		return (typeof obj == "undefined" || obj == "undefined" || obj == '' || obj == "null" || obj == null) ? ref : obj;
    	},
        phoneHyphen: function(phone) {
        	if(this.isEmpty(phone)){
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
        },

        passwordCheck : function(pwd) {
    		var pwReg = /^(?=.*[a-zA-Z])(?=.*[!@#$%^~*+=-])(?=.*[0-9]).{10,20}$/;
    		if(!pwReg.test(pwd)){
    	            return false;
    		}
    		return true;
    	},

    	emailCheck : function(email) {
        	var emailExp = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
            if(!emailExp.test(email)){
                return false;
            }
            return true;
        },

    	phoneCheck : function(phoneNo) {
        	var phoneExp = /^01[01689]\d{3,4}\d{4}$/;
            if(!phoneExp.test(phoneNo)){
                return false;
            }
            return true;
        },
        addComma : function(num) {
        	str = String(num);
        	return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
        },
        isLogin : function(options){
    		options.success = $.isFunction(options.success) ? options.success : function(){};
    		options.fail = $.isFunction(options.fail) ? options.fail : function(){};
    		/* AJAX 통신 처리 */
    		$.get('/product/co/loginCheck',{async:false})
    		.success(function(oRes){
    			if(oRes.data.loginYn == 'Y'){
    				options.success();
    			}else{
    				options.fail();
    			}
    		})
    		.error(function(){});
    	},
        /**
         * 관심딜러 등록/삭제
         * 기능 : 관심딜러 클릭시 이벤트 처리(토글형식)
         * 매개변수 :
         * 1. 관심딜러ID(userId) 가 포함된 객체 형태 매개변수
         * EX) {userId : 'hklee', carSeq: '103'}
         * 2. 콜백함수
         * resCd :
         * 10 - 관심딜러 성공
         * 99 - 관심딜러 실패
         * */
        getInterestDealer : function(param, callback){
        	var param = param;
			if(param.dealerInterestYn == 'Y'){
				param.dealerInterestYn = 'N';
			}else{
				param.dealerInterestYn = 'Y';
			}
			$.ajax({
				url: BNK_CTX + '/product/co/interestDealer/'+param.userId
				, method: 'POST'
				, success : function(data){
    				console.log('success : ', data);
    				switch(data.resCd){
    				case '00':
    					console.log('관심딜러(등록/삭제) 성공 ')
    					break;
    				case '99':
    					console.log('관심딜러 중 실패');
    					break;
    				}

    				if($.isFunction(callback)){
    					callback(data);
    				}
    			}
    			, error : function(){
    				console.log('error');
    			}
			});
        },
        /**
         * 찜하기
         * 기능 : 찜하기 클릭시 이벤트 처리(토글형식)
         * 매개변수 :
         * 1. 매물식별SEQ(carSeq) 가 포함된 객체 형태 매개변수
         * EX) {carPlateNum : '12345', carSeq: '103'}
         * 2. 콜백함수
         * resCd :
         * 10 - 찜하기 성공
         * 99 - 찜하기 실패
         * */
        getDibsOnCar : function(param, callback){
        	var param = param;
			$.ajax({
				url: BNK_CTX + '/product/co/dibsOn/'+param.carSeq
				, method: 'POST'
				, success: function(data){
					console.log('success : ', data);
					switch(data.resCd){
					case '00':
						console.log('찜하기(등록/삭제) 성공 ')
						break;
					case '99':
						console.log('찜하기 중 실패');
						break;
					}

					if($.isFunction(callback)){
						callback(data);
					}
				}
    			, error: function(){
    				console.log('error');
    			}
			});
        },

        /**
         * 뷰 카운트
         * 기능 : 뷰 카운트 처리
         * 매개변수 :
         *
         * 1. 매물식별SEQ(carSeq) 가 포함된 객체 형태 매개변수
         * EX) {carPlateNum : '12345', carSeq: '103'}
         *
         * 2. 콜백함수
         *
         * resCd :
         * 10 - 뷰 카운트 성공
         * 99 - 뷰 카운트 실패
         * */
        incViewCnt : function(param, callback){
        	$.ajax({
        		url: BNK_CTX + '/product/co/viewCnt/'+param.carSeq
        		, method: 'POST'
    			, success: function(data){
    				console.log('success : ', data);
    				switch(data.resCd){
    				case '00':
    					console.log('뷰 카운트 성공 ')
    					break;
    				case '99':
    					console.log('뷰 카운트 중 실패');
    					break;
    				}

    				if($.isFunction(callback)){
    					callback(data);
    				}
    			}
		    	, error: function(){
		    		console.log('error');
		    	}
        	});
        },
        /**
		 * heartSet을 클래스로 가지고 있는 span에 적용해야하는 부분
		 * 1. data-htype ( dibs: 찜하기, inst: 관심딜러)
		 * 2. data-seq - 찜하기용(carSeq 전달)
		 * 3. data-dealer - 관심딜러용(딜러의 userId 전달)
		 */
        heartOn: function(code, value){
			switch(code){
			case 'DIBS_ON':
				util.getDibsOnCar({carSeq: value});
				break;
			case 'INST_ON':
				util.getInterestDealer({userId: value});
				break;
			}
		},
		loginCheck: function(code, value, elem, func){
			util.isLogin({
				success: function(){
					switch(code){
					case 'INST_ON':
					case 'DIBS_ON':
						if(elem == '#hHeart'){
							$("#summary_21").prop('checked', !$("#summary_21").prop('checked'));
						}else if(!$(elem).is(':checkbox')){
							$(elem).find(':checkbox').prop('checked', !$(elem).find(':checkbox').prop('checked'));
						}
						util.heartOn(code, value);
						break;
					case 'POPUP':
						$('#'+value).trigger('click');
						break;
					}

					if($.isFunction(func)){
						func();
					}
				},
				fail: function(){
					alertify.confirm('로그인이 필요한 페이지입니다.\n로그인하시겠습니까?', function(){ location.href = '/product/co/login' });
					switch(code){
					case 'INST_ON':
					case 'DIBS_ON':
						if($(elem).is(':checkbox')){
							$(elem).prop('checked', false);
						}else{
							$(elem).find(':checkbox').prop('checked', false);
						}
						break;
					}
				}
			})
		},
		range: function(N, S, V) {
		    S = S|0;
		    V = V|1;
		    var a = [];
		    for (var i = S; i <= N; i+=V) {
		        a.push(i);
		    }
		    return a;
		},
		lpad: function(originalstr, length, strToPad) {
			strToPad = util.nvl(strToPad, '0');
			while (originalstr.length < length)
				originalstr = strToPad + originalstr;
			return originalstr;
		},
		getComponent: function(element, componentId, object){
			$(element).load('/product/co/getComponent/AJAX '+componentId, {"json" : JSON.stringify(object)});
		},
		toggleClass: function(element, friend, className){
			$(element).addClass(className).siblings(friend).removeClass(className);
		}
    }





})();
