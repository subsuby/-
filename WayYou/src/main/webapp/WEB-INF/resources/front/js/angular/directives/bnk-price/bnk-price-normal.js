/**
 * BNK시세
 *
 * hk-lee
 *
 **/
angular.module('bnk-common.directive')
.directive('bnkPriceNormal', function ($timeout, $http) {

	var TEMPLATE_ID = 'bnk-price-normal';	// 변경 <= 팝업ID(폴더,파일명)
	/**
	 * oParams
	 *
	 *
	 * @param
	 * 		carFullCode	: 차량 풀코드
	 * 		carRegYear	: 차량 연식
	 * 		carSeq		: 매물고유번호
	 *
	 * */
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
			scope.contentUrl = BNK_CTX + '/front/js/angular/directives/bnk-price/'+ TEMPLATE_ID +'-template.html';

		},
		template: '<div id="'+TEMPLATE_ID+'" ng-include="contentUrl"></div>',
		controller: function($scope, $util){

			//step 1. 차량 풀코드를 이용해 정보 가져오기 - AJAX (차량 매물가, BNK 시세, 차량 매물가 평균)
			$scope.load = function(){

				if(angular.isObject($scope.oParams)){
					$http({
						url: BNK_CTX +'/api/user/bnkPriceInfo'
						, method: 'POST'
						, data: JSON.stringify({
							mycarSeq: $scope.oParams.mycarSeq
						})
					}).then(
						function(json){
							console.log(json.data.info);
							$scope.params = json.data.info;
						}
						, function(){
							console.log('정보 가져오기 실패..');
						}
					);
				}
			}


			$scope.$watch('oParams.carFullCode', function(nv, ov){
				if(nv != ov){
					$scope.load();
				}
			});
			$scope.$watch('oParams.render', function(nv, ov){
				if(nv != ov){
					$scope.load();
				}
			});
			//step 1. bnk 애니메이션 실행 함수 선언
			$scope.start = function(){
				if(angular.isObject($scope.params)){

					//[딜러]시세가격이 책정되지 않았을 경우
					if($scope.params.waited == 'Y'){
						//return;
					}



					//매물가격이 책정되지 않았을 경우
					if($scope.params.amt == 0){
						$scope.params.car_pos = '14%';
						$scope.params.car_margin = '0%';
					}

					$(".pRoad").animate({width: '100%'}, 800,function(){
							$(".pSection").show();
					});
					setTimeout(function(){
						$(".pgCar").show();
						$(".pgPos div").animate({width: '0%'}, function(){		//차량 너비
							$(".pgPos div em").animate({left: $scope.params.car_margin}, 1500);		//차량 위치
							$(".pgPos div").animate({marginLeft: $scope.params.car_pos}, 1500,'easeInExpo',function(){	//차량도착위치
								$(".pgPos div em strong").show();
							});
						});
					}, 2000);
				}
			}

			//step 4. 애니메이션 재실행을 위한 $watch 설정 및 실행
			$scope.$watch('params', function(nv){
				$timeout(function(){
					$(".pgPos div").css({marginLeft: '-30%'});
					$(".pSection span").css({marginLeft: '-70%'});
					$scope.start();
				}, 500);
			});

			$scope.load();

		}
	};
});