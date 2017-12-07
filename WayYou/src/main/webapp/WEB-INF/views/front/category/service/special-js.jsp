<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<script>
bnkApp.controller(CTRL_NAME, ['$scope', '$http', '$filter', '$util', function($scope, $http, $filter, $util){
	//로그인 체크 후 메이크업 페이지 이동
	$scope.goMakeup = function(){
		$scope.isLogin({
			success: function(){
				location.href = "<c:url value='/front/my/makeup'/>";
			},
			fail: function(){
				alertify.confirm('로그인이 필요한 페이지입니다.\n로그인하시겠습니까?', function(){ ITCButton.getPopup('.loginPop').open(); });
			}
		});
	};
	
	//로그인 체크 후 마이카 페이지 이동
	$scope.goMycar = function(){
		$scope.isLogin({
			success: function(){
				location.href = "<c:url value='/front/my/mycar'/>";
			},
			fail: function(){
				alertify.confirm('로그인이 필요한 페이지입니다.\n로그인하시겠습니까?', function(){ ITCButton.getPopup('.loginPop').open(); });
			}
		});
	};
}]);
</script>