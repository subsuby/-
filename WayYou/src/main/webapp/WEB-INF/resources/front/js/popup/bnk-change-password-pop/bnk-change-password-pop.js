/**
 * 비밀번호 변경
 *
 * yj-kim
 * 
 **/
angular.module('bnk-common.directive')
.directive('changePasswordPop', function ($rootScope,$timeout,$http) {
	
/* ####################################################################################	
 * ## 팝업 상수설정														  				 ##
 * #################################################################################### */

	var PARENT_ID = 'wrap_back';				// 고정 
	var TEMPLATE_ID = 'change-password-pop';	// 변경 <= 팝업ID(폴더,파일명)

/* #################################################################################### */	
	
	return {
		
		/* [scope 옵션]
		 * 	 - scope : false -> 새로운 scope 객체를 생성하지 않고 부모가 가진 같은 scope 객체를 공유. (default 옵션)
		 * 	 - scope : true -> 새로운 scope 객체를 생성하고 부모 scope 객체를 상속.
		 * [binding 옵션]
		 *   - = : 부모 scope의 property와 디렉티브의 property를 data binding하여 부모 scope에 접근
		 *   - @ : 디렉티브의 attribute value를 {{}}방식(interpolation)을 이용해 부모 scope에 접근
		 *   - & : Two-way Binding 없이 각 Directive에서 사용하는 데이터를 상위 스코프로 전달할 수 있다.
		 */
		scope: {
			oParams: '=params',
			onLoadCallback: '&onLoadCallback'
		},
		restrict: 'E',		// E : elements, A : attributes, C : class name (CSS), M : comments 
		replace: true, 		// directive를 설정한 태그를 템플릿 태그로 교체하고자 할때 따라서 template 또는 templateUrl과 함께 사용한다
//		transclude: false,	// ngTransclude를 통하여 DOM에 transcluded DOM을 insert 할 수 있다
//							// transcluded DOM을 template에서 ngTransclude directive에 삽입한다
		link: function(scope, element, attrs) {
			scope.contentUrl = BNK_CTX + '/front/js/popup/bnk-'+ TEMPLATE_ID +'/bnk-'+ TEMPLATE_ID +'-template.html';
	       },
		template: '<div id="'+TEMPLATE_ID+'" ng-include="contentUrl"></div>',
		controller: function($scope, $util){
			
		/* ####################################################################################	
		 * ## 멤버 초기값 설정													  				 ##
		 * #################################################################################### */
			
			// 팝업 초기화
			$scope.$this = {};	// 팝업객체
			$scope.templateInit = function(){
				$scope.$this = ITCButton.initPopup(angular.element('#'+TEMPLATE_ID).find('.popupWrap'), 'full');
				ITCButton.setupTypePopup(angular.element('#'+TEMPLATE_ID).find('.popupWrap'));
				$rootScope.$broadcast(TEMPLATE_ID, {});
			};
			
			$scope.mod = {};
			
		/* #################################################################################### */
			
			
			
		/* ####################################################################################	
		 * ## 이벤트 설정													  				 	 ##
		 * #################################################################################### */
			
			$scope.onClose = function(){
				// callback function 
				$scope.onLoadCallback({ 'id': TEMPLATE_ID, 'data': {} });
			};
			
		/* #################################################################################### */
			$scope.chkPw = function(){
	        	
	        	var invalid;
	        	angular.element('#'+TEMPLATE_ID).find('input[type=password]').each(function(i,d){
	        		//빈값체크
	        		if($util.isEmpty(d.value)){
	        			alert(d.placeholder);
	        			invalid = d;
	        			return false;
	        		}
	        		
	        		//변경할 비밀번호 유효성 검사
		            if(d.id == 'modPw'){
		            	//비밀번호 정규식
			        	var chkReg = /^(?=.*[a-zA-Z])(?=.*[!@#$%^~*+=-])(?=.*[0-9]).{10,20}$/;
			            if(!chkReg.test($scope.mod.password)){
			                alert("비밀번호는 숫자와 영문자, 특수문자 조합으로 10~20자를 사용해야 합니다.");
			                $scope.mod.password     = "";
			                $scope.mod.passwordChk  = "";
			                invalid = d;
			                return false;
			            }
	        		}
		            if(d.id == 'modPwChk'){
		            	//비밀변호 일치 체크
			            if($scope.mod.password != $scope.mod.passwordChk){
			                alert("입력하신 두 비밀번호가 일치하지 않습니다.");
			                $scope.mod.password     = "";
			                $scope.mod.passwordChk  = "";
			                invalid = angular.element('#modPw');
			                return false;
			            }
		            }
	        	});
	        	if(invalid){
	        		angular.element(invalid).focus();
	        		return false;
	        	}
	        	
	        	alertify.confirm('비밀번호를 변경 하시겠습니까?', function(){ 
	        		var userId      = $("#userUpdForm input[name=userId]").val();  //사용자 아이디
	        		var userName      = $("#userUpdForm input[name=userName]").val();  //사용자 이름
	        		var phoneMobile      = $("#userUpdForm input[name=phoneMobile]").val();  //사용자 전화번호
		            var params={
		                    oldPw      	: $scope.mod.oldPw,
		                    password   	: $scope.mod.password,
		                    userId     	: userId,
		                    userName   	: userName,
		                    phoneMobile : phoneMobile
		                };
		            var url = BNK_CTX + '/front/common/chkUpdatePw';
		        	$http({
		                url: url
		                , method: 'POST'
		                , async: false
		                , headers: { 'Content-Type': 'application/json'}
		                , data :JSON.stringify(params)
		                , dataType : 'json'
		            }).success(function(data, status, headers, config){
		            	if(data.resCd == '99'){
	                        alert("입력하신 비밀번호가 현재 비밀번호와 동일하지 않습니다.");
	                        return false;
	                    }else{
	                    	if(data.rslt != '00'){
	                    		alert("비밀번호가 변경 되었습니다.");
	                    		$scope.mod.oldPw 		= "";
	            				$scope.mod.password 	= "";
	            				$scope.mod.passwordChk 	= "";
	                    		$scope.$this.close();
	                    	}else{
	                    		alert("네트워크 연결상태가 원활하지 않습니다. 다시 시도해 주세요.");
	                    	}
	                    }
		            }).error(function(data, status, headers, config) {
		            	alert("네트워크 연결상태가 원활하지 않습니다. 다시 시도해 주세요.");
		            });
	        	});
		    }
			
		}
	};
});

