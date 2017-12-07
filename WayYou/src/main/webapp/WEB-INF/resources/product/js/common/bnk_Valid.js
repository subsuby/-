//의존성
//jquery
//serializeObject.js
//validate.js
//순서
//1. serialize
//2. constraints 수정
//3. validate
//4. action
var Valid = (function($, validate){
	var params={};
	var constraints={};
	var valid={};
	return {
		serialize: function(form){
			this.params = $(form).serializeObject();
			this.constraints={};
			for(var key in this.params){
				this.constraints[key]={};
			}
			//this.constraints['valid_manual']={presence:{message:"^메시지를 정의해주세요."}};
			//console.log('Object[constraints] === ', this.constraints);
			return this;
		},
		validate: function(c){
			if(!c){ throw '제약조건을 입력해주세요'; }
			this.valid = validate(this.params, c);
			return this.valid;
		},
		//기본 행동
		//유효성 체크후 해당 컬럼 contratins에 의거한 메시지 출력
		//해당 form name 에 포커싱
		action: function(){
			if(this.valid){	//유효성 판단
				var elem = "";
				var msg = "";
				for(var key in this.valid){
					elem = key;
					msg = this.valid[key][0];
					break;
				}
				alertify.alert(msg);							//유효성 메시지
				$('[name='+elem+']:last').focus();	//해당 컬럼으로 포커스
			}
		},
		getConstraints: function(){
			return this.constraints;
		},
		getParams: function(){
			return this.params;
		},

	}
})(jQuery, validate);
