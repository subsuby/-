/**
 * 금액
 */
var Money = function(v) { 
	var $mn 	= this; 
	$mn.val		= '';	// 1100000
	$mn.str 	= '';	// 1,100,000
	$mn.label	= '';
	
	$mn.set = function(d) {
		var bool = (d+'').indexOf('-') === 0;	// '0'= -0 + ''
		d = (d+'').replace(/[^0-9]/g, '');
		d = ($mn.label === '' && !bool) || d == '' ? d : -d;
		$mn.val	= parseInt(d) || 0;
		$mn.str	= d.length === 0 ? '' : ($mn.label === '' ? new Number(d) : new Number(Math.abs(d))).toLocaleString();
		$mn.str = $mn.val !== 0? $mn.label + $mn.str : $mn.str; 
	};
	
	$mn.minus = function() {
		$mn.label = '(-) ';
		$mn.set(-Math.abs($mn.val));
		return $mn;
	};
	$mn.plus = function() {
		$mn.label = '';
		$mn.set(Math.abs($mn.val));
		return $mn;
	};
	$mn.type = function() {
		return $mn.label === ''? 'positive number' : 'negative number'; 
	};
	
	function _init(v){
		$mn.set(v);
	}
	
	
	
	_init(v);
};