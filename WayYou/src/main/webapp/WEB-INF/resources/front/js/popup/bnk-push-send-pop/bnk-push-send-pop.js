/**
 * 푸시전송하기
 *
 * jj-choi
 * 
 **/

angular.module('bnk-common.directive')
.directive('pushSendPop', function ($rootScope, $timeout) {
	
/* ####################################################################################	
 * ## 팝업 상수설정														  				 ##
 * #################################################################################### */

	var PARENT_ID = 'wrap_back';				// 고정 
	var TEMPLATE_ID = 'push-send-pop';	// 변경 <= 팝업ID(폴더,파일명)

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
		controller: function($scope, $http, $timeout){
			
			// 팝업 초기화
			$scope.$this = {};	// 팝업객체
			$scope.templateInit = function(){
				$scope.$this = ITCButton.initPopup(angular.element('#'+TEMPLATE_ID).find('.popupWrap'), 'full');
				ITCButton.setupTypePopup(angular.element('#'+TEMPLATE_ID).find('.popupWrap'));
				$scope.$this.onOpenHandle = function(){
					$scope.car = $scope.$parent.costParams;
				};
				$rootScope.$broadcast(TEMPLATE_ID, {});
			};
			
			$scope.car = {};
			
			// 검색하기
			$scope.onSearch = function(){
				$scope.userList = [];					// 회원 리스트
				var searchTxt = $("#searchTxt").val();
				
				if(searchTxt == ""){
					$("#searchTxt").focus();
					alert("검색어를 입력해주세요.");
					return;
				}
				
				$http({
					method:'GET',
					url: BNK_CTX + "/api/user/pushUserList",
					params: {"searchTxt": searchTxt}
				}).success(function(oRes){
					if(oRes.resCd == "00"){
						$scope.userList = oRes.data;
					}
				})
				
				/*$http.get(value="/api/user/pushUserList", { 
					params: {"searchTxt": searchTxt}
				})
				.success(function(oRes){
					if(oRes.resCd == "00"){
						$scope.userList = oRes.data;
					}
				})
				.error(function(data, status, headers, config) {
					alert("데이터 통신상태가 원활하지 않습니다.");
				});*/
			}
			
			// 전송하기
			$scope.onSend = function(){
				var type = $("#type").val();
				var items = $("#items").val();
				var url = "";
				var params = {};
				var userId = $(':radio[name="checkList"]:checked').prev().val();

				if($(':radio[name="checkList"]:checked').length == 0){
					alert("전송할 사람을 선택해주세요.");
					return;
				}

				if(type == "C"){			// 체크리스트 일때
					url = BNK_CTX + "/front/my/checkList/register";
					params={
							checkItems : items
							, userId : userId
						};
				}else if(type == "N"){		// 명함 일때
					url = BNK_CTX + "/front/my/namecard/register";
					params={
							userId : userId
						};
				}else if(type == "B"){		// 비용계산 일때
					url = BNK_CTX + "/front/my/cost/register";
					$scope.car.userId = userId;
					params = $scope.car;
				}
				
				$http({
					method:'POST',
					url: url,
					data: JSON.stringify(params)
				}).success(function(data){
					alert("전송이 완료되었습니다.");
					$("#searchTxt").val("");
					$scope.userList = [];
					$scope.$this.close();
				})
			}
			
			$scope.onClose = function(){
				// callback function 
				$scope.onLoadCallback({ 'id': TEMPLATE_ID, 'data': {} });
			};
		}
	};
});

