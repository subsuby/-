<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<script type="text/javascript">
bnkApp.controller(CTRL_NAME, ['$scope', '$http' , '$compile', 'Upload', '$timeout', function($scope, $http, $complie, Upload, $timeout){
    
    $scope.oParams={'division':"${sessUserInfo.division}"};
    $scope.onLoad=function(){
        console.log('callback!');
    }
}]);
$(document).ready(function() {

});
</script>