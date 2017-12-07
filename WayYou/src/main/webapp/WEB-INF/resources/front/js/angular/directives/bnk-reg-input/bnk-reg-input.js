/**
 * ng-model input regex replace
 *
 * jy-seo
 * 
 **/
angular.module('bnk-common.directive')
.directive('regInputPhoneNumber', function ($timeout, $http, $filter) {
	return {
		
		require: '?ngModel',
		link: function(scope, element, attrs, ctrl) {
			if(!ctrl) return;
			
			var filterSpaces = function (str) {
				console.log('@@@@ ','A');
				return $filter('phoneNumberFilter')(str);
			}
			
			ctrl.$parsers.unshift(function (viewValue){
				console.log('@@@@ ','B');
				var elem = element[0],
					pos = elem.selectionStart,
					value = '';
				
				if(pos !== viewValue.length){
					var valueInit = filterSpaces(viewValue.substring(0, elem.selectionStart));
					pos = valueInit.length;
				}
				
				value = filterSpaces(viewValue);
				element.val(value);
				
				elem.setSelectionRange(pos, pos);
				
				ctrl.$setViewValue(value);
				
				return value;
			});
			
			ctrl.$render = function(){
				console.log('@@@@ ','C');
				if(ctrl.$viewValue){
					ctrl.$setViewValue(filterSpaces(ctrl.$viewValue));
				}
			};
			
		}
	};
});