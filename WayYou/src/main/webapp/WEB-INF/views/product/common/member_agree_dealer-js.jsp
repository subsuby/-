<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<script type="text/javascript">
$(function() {
	var $document = $(document);
    var selector = '[data-rangeslider]';
    var $element = $(selector);

    // For ie8 support
    var textContent = ('textContent' in document) ? 'textContent' : 'innerText';

    // Example functionality to demonstrate a value feedback
    function valueOutput(element) {
        var value = element.value;
        var output = element.parentNode.getElementsByTagName('output')[0] || element.parentNode.parentNode.getElementsByTagName('output')[0];
        output[textContent] = value;
    }

    $document.on('input', 'input[type="range"], ' + selector, function(e) {
        valueOutput(e.target);
    });

    // Basic rangeslider initialization
    $element.rangeslider({

        // Deactivate the feature detection
        polyfill: false,

        // Callback function
        onInit: function() {
            valueOutput(this.$element[0]);
        }
    });
	
    $("#agree").click(function() {
		if( $("#agree").prop("checked") ) {
			$("input[name=checkbox]").prop("checked",true);
		} else {
			$("input[name=checkbox]").prop("checked",false);
		}
	});
	    
    $("#nextPage").click(function() {
    	if(!$("#agree01").prop("checked")) {
			alertify.alert("서비스 이용약관 동의는 필수 체크 입니다.");
			$("#agree01").focus();
			return false;
		}
		
		if(!$("#agree02").prop("checked")) {
			alertify.alert("개인정보를 위한 이용자 동의사항 및 개인 취급방침는 필수 체크 입니다.");
			$("#agree02").focus();
			return false;
		}
		
		if(!$("#agree03").prop("checked")) {
			alertify.alert("책임한계 및 면책고지는 필수 체크 입니다.");
			$("#agree03").focus();
			return false;
		}
		
		if($("#agree04").prop("checked")) {
			$("#agreeMarketing").val("Y");
		}
		$("#frm").attr("action", "/product/co/memberJoinDealer");
		$("#frm").submit();
    });
});
</script>