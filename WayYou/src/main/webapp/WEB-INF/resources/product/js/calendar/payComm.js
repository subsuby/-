
function LayerAutoBuilder(configObj) {
	var LAYER_BUILDER_TYPE_DIMMED = 1;
	var LAYER_BUILDER_TYPE_MOUSEOVER = 2;
	var LAYER_BUILDER_TYPE_TOGGLE = 3;

	var DIMMED_LAYER_ZINDEX = 100001;
	var MOUSEOVER_LAYER_ZINDEX = 100000;
	var TOGGLE_LAYER_ZINDEX = 100;

	
	var TOGGLE_CURRENT_ZINDEX = TOGGLE_LAYER_ZINDEX; 

	
	checkTgtObjValid = function(srcObj, tgtSelector) {
		var tgtObj;
		try {
			tgtObj = jQuery(tgtSelector);
		} catch (e) {
		}
		if (!tgtObj || tgtObj.length == 0) {
			srcObj.click(function() {
				alertify.alert("layer missed");
				return false;
			});
			return tgtObj;
		}
		return tgtObj;
	};

	
	buildLayerDimmed = function(srcObj, tgtSelector) {
	    var tgtObj;
	    if ((tgtObj = checkTgtObjValid(srcObj, tgtSelector))) {
	        srcObj.click(function(e) {
	            e.preventDefault();
	            var resetPosition = function () {
	                $(target).css({
	                    'left': $(window).width() / 2 - $(target).outerWidth() / 2,
	                    'margin': '0 auto',
	                    'top': Math.max($(window).scrollTop() + $(window).height() / 2 - $(target).outerHeight() / 2, 0)
	                });
	            };

	            var target = tgtObj;
	            $('.dimmed').css('position', 'fixed').show();
	            $(target).show();
	            resetPosition();

	            $(window).on('resize', function (e) {
	                resetPosition();
	            });

	            $(target).find('button.btn.close, .close').on('click', function (e) {
	                e.preventDefault();
	                $('.dimmed').hide();
	                $(target).hide();
	            });
	        });
	    }
	    return tgtObj;
	};

	
	buildLayerMouseover = function(srcObj, tgtSelector) {
		var tgtObj;
        if ((tgtObj = checkTgtObjValid(srcObj, tgtSelector))) {
            srcObj.on('mouseenter focusin',function(){
                var cord = srcObj.offset();
                cord.top += srcObj.height();
                cord.left += (srcObj.width() / 2);
                tgtObj.show().offset(cord);
                return false;
            }).on('mouseleave focusout',function(){
                tgtObj.hide();
                return false;
            }).click(function() {
                return false;
            });
        }
        return tgtObj;
	};

	
	buildLayerToggle = function(srcObj, tgtSelector) {
		var tgtObj;
		if ((tgtObj = checkTgtObjValid(srcObj, tgtSelector))) {
			srcObj.click(function() {
				var cord = srcObj.offset();
				cord.top += 15;
				cord.left += 15;
				//			TOGGLE_LAYER_JQUERY_OBJ.not(tgtObj).toggle(false);
				tgtObj.css("z-index", ++TOGGLE_CURRENT_ZINDEX).toggle().offset(cord);
				return false;
			});
			
		}
		return tgtObj;
	};

	
	appnedLayer = function(layerDefInfoList) {
		for ( var i in layerDefInfoList) {
			var layerDefInfo = layerDefInfoList[i];
			var srcObj = jQuery(layerDefInfo.srcSelector);
			this.appnedLayerSolo(layerDefInfo.type, srcObj, tgtSelector);
		}
	};

	
	appnedLayerSolo = function(type, srcObj, tgtSelector) {
		var zindex = TOGGLE_LAYER_ZINDEX;

		var tgtObj;
		switch (type) {
			case LAYER_BUILDER_TYPE_DIMMED :
				tgtObj = buildLayerDimmed(srcObj, tgtSelector);
				zindex = DIMMED_LAYER_ZINDEX;
				break;
			case LAYER_BUILDER_TYPE_MOUSEOVER :
				tgtObj = buildLayerMouseover(srcObj, tgtSelector);
				zindex = MOUSEOVER_LAYER_ZINDEX;
				break;
			case LAYER_BUILDER_TYPE_TOGGLE :
				tgtObj = buildLayerToggle(srcObj, tgtSelector);
				zindex = TOGGLE_LAYER_ZINDEX;
				break;
		}

		if(tgtObj){
			tgtObj.css("z-index", zindex).css("position","absolute").hide(); 
			if (type != LAYER_BUILDER_TYPE_DIMMED ) {
				if (configObj.layerParentObj) {
					configObj.layerParentObj.append(tgtObj); 
				}
			} else {
				jQuery("body").append(tgtObj);
			}
		}
	};

	
	appendLayerAnnotation = function(mouseOverClass, toggleClass, dimmedClass) {
		jQuery("a." + mouseOverClass + ", a." + toggleClass + ", a." + dimmedClass).each(function() {
			var srcObj = jQuery(this);
			var tgtSelector = "div" + srcObj.attr("href");
			var layerType = LAYER_BUILDER_TYPE_TOGGLE;
			if (srcObj.hasClass(mouseOverClass)) {
			    layerType = LAYER_BUILDER_TYPE_MOUSEOVER;
			} else if (srcObj.hasClass(dimmedClass)) {
			    layerType = LAYER_BUILDER_TYPE_DIMMED;
			}
			appnedLayerSolo(layerType, srcObj, tgtSelector);
		});
	};

	
	init = function() {
		jQuery("body").append("<div class=\"dimmed\" style=\"display:none;\"></div>");

		var defaultConfigObj = {
			dimmedClass    : "layerbuild_dimmed",
			mouseOverClass : "layerbuild_mouseover",
			toggleClass    : "layerbuild_toggle",
			layerParentSelector : "body"
		};

		
		if (!configObj) {
			configObj = new Object();
		}

		
		for ( var i in defaultConfigObj) {
			if (!configObj[i]) {
				configObj[i] = defaultConfigObj[i];
			}
		}
		var layerParentObj = jQuery(configObj.layerParentSelector);
		if (layerParentObj.length > 0) {
			layerParentObj.children().hide();
			configObj.layerParentObj = layerParentObj;
			configObj.layerParentObj.css("z-index", "100");
		}
	};

	
	init();
	appendLayerAnnotation(configObj.mouseOverClass, configObj.toggleClass, configObj.dimmedClass);
};


function JquerySelectCache(configObj) {
	var jQuerySelectCacheObj = new Object();

	
	this.get = function(selectQuery, ancestor) {
		
		if (ancestor || typeof selectQuery != "string") {
			
			return jQuery(selectQuery, ancestor);
		}

		
		var retObj = jQuerySelectCacheObj[selectQuery];
		if (!retObj) {
			retObj = jQuery(selectQuery);
			jQuerySelectCacheObj[selectQuery] = retObj;
		}
		return retObj;
	};

};



var formatNumber = function(num) {
	var reg = /(^[+-]?\d+)(\d{3})/;
	num += "";
	while (reg.test(num))
		num = num.replace(reg, '$1' + ',' + '$2');
	return num;
};

var isNotEmpty = function(_str) {
    obj = String(_str);
    if(obj == null || obj == undefined || obj == 'null' || obj == 'undefined' || obj == '' ) return false;
    else return true;
};
var isEmpty = function(_str) {
    return !isNotEmpty(_str);
}


function isValidHpNo(pHpNo1, pHpNo2, pHpNo3) {
    var phoneEx = /[01](0|1|6|7|8|9)[-](\d{4}|\d{3})[-]\d{4}$/g;
    if (!phoneEx.test(pHpNo1 + "-" + pHpNo2 + "-" + pHpNo3)) {
        return false;
    }
    return true;
}


function isValidTelNo(pNo) {
    if (pNo) {
        var regExp = /^(01[016789]{1}|02|0[3-9]{1}[0-9]{1})-?[0-9]{3,4}-?[0-9]{4}$/;
        return regExp.test(pNo);
    } else {
        return false;
    }
}
function splitPhoneNumber(pNum) {
    var pt = /^(01\d{1}|02|0505|0506|0502|0\d{1,2})-?(\d{3,4})-?(\d{4})$/g;
    var splitTel = pt.exec(pNum);
    var result = new Array(3);
    if(splitTel != null) {
     result[0] = splitTel[1];
     result[1] = splitTel[2];
     result[2] = splitTel[3];
    }
    return result;
}

jQuery.fn.extend({
    
    numberOnly : function() {
        return this.each(function() {
            try {
                var $this = $(this);

               
                $this.css('ime-mode', 'disabled');

                
                $this.keydown(function(p_event) {
                    var l_before_length = $this.val().length;
                    var l_keycode = p_event.keyCode;
                    var l_str     = l_keycode > 57 ? String.fromCharCode(l_keycode-48) : String.fromCharCode(l_keycode);
                    var l_pattern = /^[0-9]+$/;
                   
                    if(l_keycode == 8 || l_keycode == 9 || l_keycode == 13 || l_keycode == 46 || l_keycode == 37 || l_keycode == 38 || l_keycode == 39 || l_keycode == 40) {
                        return true;
                    }

                    // �レ옄留� �낅젰 媛��ν븯�꾨줉 ��
                    var l_after_length = $this.val().length;
                    if(!l_pattern.test(l_str)) {
                        if(l_before_length != l_after_length) {
                            $this.val($this.val().substring(0, l_after_length - 1));
                        }
                        return false;
                    } else {
                        return true;
                    }
                });

               
                $this.focus(function() {
                    $this.val($this.val().replace(/,/g, ''));
                });
            } catch(e) {
                alertify.alert("[jsutil.js's numberFormat] " + e.description);
            }
        });
    }
});

function stringToArray(pStr, pGb) {
    var resultArr = new Array();
    if (isEmpty(pStr) || isEmpty(pGb)) {
        return resultArr;
    }
    if (pStr.indexOf(pGb) > -1) {
        var pArr = pStr.split(pGb);
        for (var i = 0; i < pArr.length; i++) {
            resultArr[i] = pArr[i];
        }
    } else {
        resultArr[0] = pStr;
    }
    return resultArr;
}