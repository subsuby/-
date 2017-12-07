<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<script>
// 계약서
var Contract = {
		init : function(){
			this.bindData();
			this.bindEvent();
		},
		bindData : function(){
			
		},
		bindEvent : function(){
			evt.tabFix();
			evt.installmentToggle();
		}
};

// 이벤트
var evt = {
		// 상단 탭 메뉴 스크롤시 fix 효과
		tabFix : function(){
			var jbOffset = $( '.ctMenu' ).offset();
			$( window ).scroll( function() {
				if ( $( document ).scrollTop() > (jbOffset.top - '42') ) {
					$( '.ctMenu' ).addClass( 'ctMFixed' );
				}
				else {
					$( '.ctMenu' ).removeClass( 'ctMFixed' );
				}
			});
		},
		
		// 할부 상품 박스 토글 이벤트
		installmentToggle : function(){
			$(".installToggle h4").click(function(){
			    $(".installToggle .box").toggle();
			    $(this).toggleClass("plus");
			});
		}
};

$(document).ready(function(){
	Contract.init();
});
</script>