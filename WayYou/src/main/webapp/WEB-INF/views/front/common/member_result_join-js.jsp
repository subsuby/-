<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<script type="text/javascript">
bnkApp.controller(CTRL_NAME, ['$scope', '$http','$util', '$timeout', function($scope, $http, $util, $timeout){
	
    $scope.userName     = "${name}";
    $scope.phoneMobile  = "${phoneNo}";
    
	var params={
			name   		: $scope.userName,
			phoneNo     : $scope.phoneMobile
	};
	
	$timeout(function(){
	    if(isAppGubun()){
	    	location.href = 'bnk://popup.close?param=' + JSON.stringify(params)
		}else{
			window.onunload = function (e) {
			    opener.__closeCallback(params);
			};
			window.close();
		}
	}, 1000);
}]);

</script>