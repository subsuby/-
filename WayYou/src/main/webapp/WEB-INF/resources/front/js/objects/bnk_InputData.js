/**
 * 데이터
 */
var InputData = function(v, n, m) {
	var $in = this;
	$in.val = '';
	$in.msg = util.nvl(m, '메시지를 설정해주세요.');

	var _node = n;

	$in.valid= function(){
		return util.isNotEmpty($in.val);
	}
	$in.alert= function(){
		alert($in.msg);
	}
	$in.getNode = function(){
		return _node;
	}
	$in.focus= function(){
		if(_node != null){
			_node.focus();
		}else{
			console.log('this node - [#'+i+'] is empty.');
		}
	}

};