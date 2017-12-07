var hasMacroPop = false;
var onAjaxLoadingHide = false;
(function($){

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
        }
    }
})();
/*
$(document).ready(function (){
	$(document).ajaxStart(function(){
		loading.show();
	}).ajaxStop(function(){
		loading.hide();
	});
});

var loading = {
	show: function(){
		if($('#loadingAll').css("display") == "none" && !onAjaxLoadingHide){
			$('#loadingAll').show();
		}

		onAjaxLoadingHide = false;
	},
	hide: function(){
		$('#loadingAll').hide();
	}
}
*/