<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<script type="text/javascript">
$(function() {
	$("#goTop").click(function(){
		$('.serviceMenu a').removeClass('on');
		$("#menu1").addClass("on");
	});
	
	if(util.isNotEmpty('${param.serviceMenu}')){
		var top = $('.icon${param.serviceMenu}').offset().top;
		$('html,body').animate({
			'scrollTop' : top
		},500);
	}
	
   $('.serviceMenu a').click(function(){
        var len = $(this).index();
        //util.toggleClass(this, 'a', 'on');
        if(len === 0){
			if ($('.serviceMenu').hasClass('on')){
				var top = $('.icon1').offset().top -98;
			}else{
				var top = $('.icon1').offset().top - 240;
			}
            $('html,body').animate({
                'scrollTop' : top
            },500);
            return false;
        }else if(len === 1){
			if ($('.serviceMenu').hasClass('on')){
				var top = $('.icon3').offset().top -98;
			}else{
				var top = $('.icon3').offset().top - 240;
			}
           // var top = $('.icon3').offset().top - 98;
            $('html,body').animate({
                'scrollTop' : top
            },500);
            return false;
        }else if(len === 2){
			if ($('.serviceMenu').hasClass('on')){
				var top = $('.icon6').offset().top -98;
			}else{
				var top = $('.icon6').offset().top - 240;
			}
            //var top = $('.icon6').offset().top - 98;
            $('html,body').animate({
                'scrollTop' : top
            },500);
            return false;
        }else if(len === 3){
			if ($('.serviceMenu').hasClass('on')){
				var top = $('.icon8').offset().top -98;
			}else{
				var top = $('.icon8').offset().top - 240;
			}
            //var top = $('.icon8').offset().top - 98;
            $('html,body').animate({
                'scrollTop' : top
            },500);
            return false;
        }
    });	
	
	if(util.isNotEmpty('${menu}')){
		var menu = '${menu}';
        //util.toggleClass(this, 'a', 'on');
        if(menu == 1){
            var top = $('.icon1').offset().top -40;
            $('html,body').animate({
                'scrollTop' : top
            },500);
            return false;
        }else if(menu == 2){
            var top = $('.icon3').offset().top - 98;
            $('html,body').animate({
                'scrollTop' : top
            },500);
            return false;
        }else if(menu == 3){
            var top = $('.icon2').offset().top - 98;
            $('html,body').animate({
                'scrollTop' : top
            },500);
            return false;
        }else if(menu == 4){
            var top = $('.icon2').offset().top - 98;
            $('html,body').animate({
                'scrollTop' : top
            },500);
            return false;
        }
	}

	/* 2017-08-19 */
    $('.specialMore').on('click', function (){
		var dtop = $(this).parent().next('.innerLayout').offset().top - 98;
		$('html,body').animate({
			'scrollTop' : dtop
		},500);
    });
	/* end 2017-08-19 */
	

	$(window).scroll(function()  
	{  
		/* 2017-09-22 */
		if ($(window).scrollTop() < 57){
			$('.special .serviceMenu').removeClass('on');
		} else {
			$('.special .serviceMenu').addClass('on');
			$('.special .serviceMenu').css('width', ($(window).width()- 49) +'px');
			
			$('.innerLayout').each(function() {
		        if($(window).scrollTop() >= $(this).offset().top - 138) {
		            var id = $(this).attr('id');
		            $('.serviceMenu a').removeClass('on');
		            $('#menu'+id).addClass('on');
		        }
		    });
		}
		/* end 2017-09-22 */ 
	});
	
	$(".isLogin").click(function(){
		var classes = $(this).attr('class').split(' ');
		/* util.isLogin({
			success: function(){
				var oDivision = '${sessUserInfo.division}';
				if(oDivision == 'D'){
					location.href = '<c:url value="/product/mypage/mycarDealer"/>';
				}else{
					$("#navVal").val(classes[2]);
					$("#navForm").attr("action", "/product/mypage/mycarPerson");
					$("#navForm").submit();
				}
			},
			fail: function(){
				alertify.confirm('로그인이 필요한 페이지입니다.\n로그인하시겠습니까?', function(){ location.href = '/product/co/login' });
			}
		}) */
	});
});
</script>