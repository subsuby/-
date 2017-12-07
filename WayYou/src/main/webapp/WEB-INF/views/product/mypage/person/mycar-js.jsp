<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<script type="text/javascript">
$(function(){
	mycar_list();           //마이카 func 호출
    recommend_list(1);      //추천차량 func 호출
    makeup_list(1);    //관심딜러 func 호출
    interest_dealer_list(1);    //관심딜러 func 호출
    interest_car_list(1);       //관심매물 func 호출
    question_list(1);       //문의내역 func 호출
    sale_list(1)    ;       //등록차량 func 호출
    reserve_list(1) ;       //방문/시승/탁송 func 호출
    cost_list(1);			//비용계산 func 호출
    check_list(1);			//체크리스트 func 호출
    businesscard_list(1);

    //$.fn.makerCombo("makerSelect");

    // 2017-08-25 jj-choi 슬라이드 이동
    setTimeout(function() {
		var val = '${val}';
		if(val != ""){
			var offset = $("#"+val).offset();
	        $('html, body').animate({scrollTop : offset.top}, 400);
		}
	}, 1000);

	//제조사리스트 초기화
	$.ajax({
		url : BNK_CTX + "/product/co/makerCombo"
		, dataType : 'json'
		, type: "get"
		, success : function(data){
			var $select = $('select[name=makerCd]');
			render_combo($select, data, '${car.carFullCode}'.substring(0,3));
		},
		error: function(error){
			alertify.alert("데이터 통신상태가 원활하지 않습니다.");
			console.log(status);
		}
	});

    /*
    * [BUTTON] 문의내역 팝업에서 등록 버튼 클릭 시 !!
    * dev  : 김예지
    * date : 2017.08.11
    */
    $("#btnQnaInsert").click(function() {
        var param = {};
        param.qnaTitle = $("#qnaTitle").val();
        param.contents = $("#contents").val();
        if(util.isEmpty(param.qnaTitle)){
			alertify.alert('제목을 입력해주세요.');
			$("#qnaTitle").focus();
			return;
        }else if(util.isEmpty(param.contents)){
			alertify.alert('내용을 입력해주세요.');
        	$("#contents").focus();
        	return;
        }

        alertify.confirm('문의내역을 등록하시겠습니까?', function(){
            $.ajax({
                url : BNK_CTX + "/product/mypage/mycarPersonQnaInsert"
                , data :  JSON.stringify(param)
                , dataType : 'json'
                , type: "POST"
                , contentType: "application/json"
                , success : function(data, textStatus, jqXHR){
                    alertify.alert("문의내역이 등록 되었습니다.");
                    $("#btnQnaCancel").trigger("click");
                    question_list(1);
                    $("#qnaTitle").val("");
                    $("#contents").val("");
                },
                error: function(error){
                }
            });
        });
    });

    $(document).on("click", '#modifySaleCar', function(){
        var $btn        = $('#modifySaleCar').next();
        var data        = $btn.data('popOpts');
        data.display    = true;
        $btn.data('popOpts', data);
        $btn.trigger('click');

        // 정보가져오기
        $.ajax({
            url : BNK_CTX + '/product/mypage/mycarPersonGetReserve',
            method:'POST',
            contentType: 'application/json;charset=UTF-8',
            data: {},
            success : function(data){
                var temp = $('.reverseAdd');

                temp.find('#hiddenMakerCd').val(data.car.makerCd);
                temp.find('#reversMakerCd').val(data.car.makerCd);
                $.fn.modelSelectCombo("reversModelCd", data.car.makerCd, data.car.modelCd);
                $.fn.modelSelectCombo("reversModelDtlCd", data.car.modelCd, data.car.detailModelCd);
                temp.find('#useKmSelect').val(data.car.useKm);
                temp.find('#carRegYearSelect').val(data.car.carRegYear);
                temp.find('#carColorSelect').val(data.car.carColor);
            },
            error : function(request,status,error){
                console.log(error);
            }
        });
    });

    /*
     * [SELECT] 제조사 select box - option 클릭 시 !!
     * dev  : 김예지
     * date : 2017.08.16
     */
     $("#makerSelect").change(function(){
         // 세부모델 셀렉트박스를 초기화
         $("#modelDetailSelect").html("<option value=''>세부모델을 선택하세요</option>");
         $.fn.modelCombo("modelSelect", $(this).val());
     });

     /*
     * [SELECT] 모델 select box - option 클릭 시 !!
     * dev  : 김예지
     * date : 2017.08.16
     */
     $("#modelSelect").change(function(){
         $.fn.modelCombo("modelDetailSelect", $(this).val());
     });




     $(".appraisePop input:checkbox").on('click', function() {
         // in the handler, 'this' refers to the box clicked on
         var $box = $(this);
         if ($box.is(":checked")) {
           // the name of the box is retrieved using the .attr() method
           // as it is assumed and expected to be immutable
           var group = "input:checkbox[name='" + $box.attr("name") + "']";
           // the checked state of the group/box on the other hand will change
           // and the current value is retrieved using .prop() method
           $(group).prop("checked", false);
           $box.prop("checked", true);
         } else {
           $box.prop("checked", false);
         }
     });
     $(".appraisePop textarea").on('keyup', function() {
         var txt = $(this).val();
         $(this).prev().find('i').text('('+txt.length+'/100)');
     });
})

/*
* [function] 마이카 호출 시 !!
* desc : 페이징처리 없음
* dev  : 이훈경
* date : 2017.08.10
*/
function mycar_list(){
	$.ajax({
		url : BNK_CTX + '/product/mypage/mycarPersonMyCar/AJAX',
		dataType : 'html',
		cache : false,
		data : {},
		success : function(detailResult){
			$("#mycar_list").empty();
			$("#mycar_list").append(detailResult);
		},
		error : function(request,status,error){
		}
	});
}
function mycar_list_sub(myCar){
	var params = {};
	for(key in myCar){		//json parse 안되는 객체들 제외시킴
		if(key != 'user' && key != 'label' && key != 'estHis'){
			params[key] = myCar[key];
		}
	}
	$.ajax({
		method: 'POST',
		url : BNK_CTX + '/product/mypage/mycarPersonMyCarSub/AJAX',
		dataType : 'html',
		cache : false,
		contentType : 'application/json;charset=UTF-8',
		data : JSON.stringify(params),
		success : function(detailResult){
			$("#mycar_list_sub").empty();
			$("#mycar_list_sub").append(detailResult);
		},
		error : function(request,status,error){
		}
	});
}
function mycar_list_estimate_service(code, mycarSeq){
	var reqMsg = '';
	var resMsg = '';

	switch(code){
	case 'cancel':
		reqMsg = '견적을 취소하시겠습니까?'
		resMsg = '견적을 취소하였습니다.';
		break;
	case 'remove':
		reqMsg = '견적을 삭제하시겠습니까?';
		resMsg = '견적을 삭제하였습니다.';
		break;
	case 'dealer':
		reqMsg = '딜러 견적을 요청하시겠습니까?';
		resMsg = '딜러 견적을 요청하였습니다.';
		break;
	case 'visit':
		reqMsg = '방문 견적을 요청하시겠습니까?';
		resMsg = '방문 견적을 요청하였습니다.';
		break;
	case 'retry':
		reqMsg = '견적을 다시 받아보시겠습니까?';
		resMsg = '견적을 재요청하였습니다.';
		break;
	}


	if(code != 'visit'){
		alertify.confirm(reqMsg, function(){
			$.ajax({
	            url: BNK_CTX + '/product/mypage/mycarPersonMyCar/'+code+'/AJAX'
	            , method: 'POST'
	            , data: { mycarSeq  : mycarSeq }
				, success: function(data){
					if(data.resCd == '00'){
						alertify.alert(resMsg, function(){
							mycar_list();
						});
					}else if(data.resCd == '99'){
						alertify.alert('견적 요정 중 오류가 발생하였습니다.');
					}
				}
				, error: function(){

				}
	        });
		});

	}else{
		alertify.confirm(reqMsg, function(){

			var tab = $("#visitType").find('span.on input[type="button"]')[0].dataset.name;

			var visit={};
			visit.visitType			= tab == "tabCon1" ? '1' : '2';
			visit.mycarSeq			= mycarSeq;
			visit.estReqYn			= "Y";
			visit.visitUserTel		= util.nvl($('.visitApp [name=call]').map(function(){return this.value;}).get().join(''), '');	//연락처
			visit.visitZip			= util.nvl(document.getElementById('zipCode').value, '');	//우편번호
			visit.visitAddr1		= util.nvl(document.getElementById('addr1').value, '');	//주소
			visit.visitAddr2		= util.nvl(document.getElementById('addr2').value, '');	//상세주소
			visit.consignYn			= $('.'+tab+' .visit_1').is(':checked') ? 'Y':'N';	//위탁판매
			visit.makeupYn			= $('.'+tab+' .visit_2').is(':checked') ? 'Y':'N';	//메이크업


			visit.danjiNo			= $("#danjiNo").val()    ;   //그룹번호
			visit.shopNo			= $("#shopNo").val()     ;   //상사번호
			visit.reqDanjiName		= $("#dealerDanjiName").val();   //소속그룹명
			visit.reqShopName		= $("#dealerShopName").val() ;   //소속단체명
			visit.reqDanjiNo		= $("#danjiNo").val()     ;  //소속그룹코드
			visit.reqShopNo			= $("#shopNo").val()      ;  //소속단체코드

			visit.visitResDate = $('.'+tab+' .reserve_date')
			.map(function(){
				var result = '';
				switch(this.name){
					case 'reserve_year': result = this.value; break;
					case 'reserve_month':
					case 'reserve_day': result = util.lpad(this.value, 2); break;
				}
				return result;
			}).get().join('');		//예약날짜

			$.ajax({
	            url: BNK_CTX + '/product/mypage/mycarPersonMyCar/'+code+'/AJAX'
	            , method: 'POST'
	            , contentType: 'application/json;charset=UTF-8'
	            , data: JSON.stringify(visit)
				, success: function(data){
					if(data.resCd == '00'){
						alertify.alert(resMsg, function(){
							$('.p-close').trigger('click');
							mycar_list();
						});
					}else if(data.resCd == '99'){
						alertify.alert('견적 요청 중 오류가 발생하였습니다.');
					}
				}
				, error: function(){

				}
			});
		});

	}
}



/*
* [function] 추천차량 호출 시 !!
* dev  : 김예지
* date : 2017.08.09
*/
function recommend_list(curPage){
    $.ajax({
        url : BNK_CTX + '/product/mypage/mycarPersonRecommend/AJAX',
        dataType : 'html',
        cache : false,
        data : {curPage : curPage},
        success : function(detailResult){
            $("#recommend_list").empty();
            $("#recommend_list").append(detailResult);
        },
        error : function(request,status,error){
        }
    });
}

/*
* [function] 메이크업 호출 시 !!
* dev  : 이훈경
* date : 2017.08.11
*/
function makeup_list(curPage){
    $.ajax({
        url : BNK_CTX + '/product/mypage/mycarPersonMakeupList/AJAX',
        dataType : 'html',
        cache : false,
        data : {
        	curPage : curPage
        	, pageListSize : 5
        },
        success : function(detailResult){
            $("#makeup_list").empty();
            $("#makeup_list").append(detailResult);
        },
        error : function(request,status,error){
        }
    });
}

/*
* [function] 관심 딜러 호출 시 !!
* dev  : 이훈경
* date : 2017.08.11
*/
function interest_dealer_list(curPage){
    $.ajax({
        url : BNK_CTX + '/product/mypage/mycarPersonInterestDealerList/AJAX',
        dataType : 'html',
        cache : false,
        data : {curPage : curPage},
        success : function(detailResult){
            $("#interest_dealer_list").empty();
            $("#interest_dealer_list").append(detailResult);
        },
        error : function(request,status,error){
        }
    });
}
/*
* [function] 관심 차량 호출 시 !!
* dev  : 이훈경
* date : 2017.08.11
*/
function interest_car_list(curPage){
    $.ajax({
        url : BNK_CTX + '/product/mypage/mycarPersonInterestCarList/AJAX',
        dataType : 'html',
        cache : false,
        data : {
        	curPage : curPage
        	, pageListSize : 8
        },
        success : function(detailResult){
            $("#interest_car_list").empty();
            $("#interest_car_list").append(detailResult);
        },
        error : function(request,status,error){
        }
    });
}
/*
* [function] 찜하기 호출 시 !!
* dev  : 이훈경
* date : 2017.08.11
*/
function set_interest(code, seq, elem){
	var func = '';
	if(code == 'DIBS_ON'){
		func = interest_car_list;
	}else if(code == 'INST_ON'){
		func = interest_dealer_list
	}
	util.loginCheck(code, seq, elem, func);
}

/*
* [function] 문의내역 리스트 호출 시 !!
* dev  : 김예지
* date : 2017.08.10
*/
function question_list(curPage){
    $.ajax({
        url : BNK_CTX + '/product/mypage/mycarPersonQuestion/AJAX',
        dataType : 'html',
        cache : false,
        data : {curPage : curPage},
        success : function(detailResult){
            $("#question_list").empty();
            $("#question_list").append(detailResult);
            ITCButton.setupTypeAccordion();
        },
        error : function(request,status,error){
        }
    });
}
function onClick(code){
	switch(code){
	case 'BTN_SELECT_MYCAR':
		if($(arguments[2]).hasClass('on')){		//이미 선택된 라인 리로딩 막기
			//TODO:
		}else{
			mycar_list_sub(arguments[1]);
			$(arguments[2]).addClass('on').siblings('tr').removeClass('on');
		}
		break;
	}
}

/*
* [function] 내게맞는 매물 리스트 호출 시 !!
* dev  : 김예지
* date : 2017.08.11
*/
function sale_list(curPage){
    $.ajax({
        url : BNK_CTX + '/product/mypage/mycarPersonSaleCar/AJAX',
        dataType : 'html',
        cache : false,
        data : {curPage : curPage},
        success : function(detailResult){
            $("#sale_list").empty();
            $("#sale_list").append(detailResult);
            ITCButton.setupTypeAccordion();
        },
        error : function(request,status,error){
        }
    });
}

/*
* [function] 방문사전/시승/탁송 리스트 호출 시 !!
* dev  : 김예지
* date : 2017.08.11
*/
function reserve_list(curPage){
    $.ajax({
        url : BNK_CTX + '/product/mypage/mycarPersonReserveList/AJAX',
        dataType : 'html',
        cache : false,
        data : {curPage : curPage, pageListSize: 5},
        success : function(detailResult){
            $("#reserve_list").empty();
            $("#reserve_list").append(detailResult);
            ITCButton.setupTypeAccordion();
        },
        error : function(request,status,error){
        }
    });
}
var checkArr = new Array();

/*
* [function] 방문사전/시승/탁송 예약취소 시 !!
* dev  : 김예지
* date : 2017.08.14
*/
function fn_cancel(resHisSeq){
    /* $("input[name='resSeq[]']:checked").each(function (){
        checkArr.push($(this).val());
    }); */
    alertify.confirm('예약을 취소 하시겠습니까?', function(){
        var param = { resHisSeq: resHisSeq };

        $.ajax({
            url : BNK_CTX + "/product/mypage/mycarPersonCancelReserve"
            , data :  JSON.stringify(param)
            , dataType : 'json'
            , type: "POST"
            , contentType: "application/json"
            , success : function(data, textStatus, jqXHR){
                alertify.alert("예약 취소 되었습니다.");
                reserve_list(1);
            },
            error: function(error){
            }
        });
    });
}

/*
* [function] 방문사전/시승/탁송 예약 승인 시 !!
* dev  : 김예지
* date : 2017.08.17
*/
function fn_acceptReserve(resHisSeq){
    alertify.confirm('예약을 승인 하시겠습니까?', function(){
        var param = { resHisSeq : resHisSeq
                     ,resStatus : "20"
        };

        $.ajax({
            url : BNK_CTX + "/product/mypage/mycarPersonAcceptReserve"
            , data :  JSON.stringify(param)
            , dataType : 'json'
            , type: "POST"
            , contentType: "application/json"
            , success : function(data, textStatus, jqXHR){
                alertify.alert("예약 승인 되었습니다.");
                reserve_list(1);
            },
            error: function(error){
            }
        });
    });
}

/*
* [function] 방문사전/시승/탁송 예약 거절 시 !!
* dev  : 김예지
* date : 2017.08.17
*/
function fn_refuseReserve(resHisSeq){
    alertify.confirm('예약을 거절 하시겠습니까?', function(){
        var param = { resHisSeq : resHisSeq
                     ,resStatus : "92"
        };

        $.ajax({
            url : BNK_CTX + "/product/mypage/mycarPersonAcceptReserve"
            , data :  JSON.stringify(param)
            , dataType : 'json'
            , type: "POST"
            , contentType: "application/json"
            , success : function(data, textStatus, jqXHR){
                alertify.alert("예약 거절 되었습니다.");
                reserve_list(1);
            },
            error: function(error){
            }
        });
    });
}

/*
* [function] 내게맞는매물 삭제 시 !!
* dev  : 김예지
* date : 2017.08.16
*/
function fn_deleteSaleCar(){
    alertify.confirm('등록조건을 삭제 하시겠습니까?', function(){
        var param = { makerCd : $("#reversMakerCd").val() ,
                      modelCd : $("#reversModelCd").val() ,
                      detailModelCd : $("#reversModelDtlCd").val()
                    };
        $.ajax({
            url : BNK_CTX + "/product/mypage/mycarPersonDeleteRecommend"
            , data :  JSON.stringify(param)
            , dataType : 'json'
            , type: "POST"
            , contentType: "application/json"
            , success : function(data, textStatus, jqXHR){
                alertify.alert("삭제 되었습니다.");
                $("#hiddenMakerCd").val("");	//등록인지 수정인지 구별하기위한 히든값 초기화
                $("#reversMakerCd").val("");	//제조사 초기화
                $("#reversModelCd").val("");	//모델 초기화
                $("#reversModelDtlCd").val("");	//상세모델 초기화
                $("#useKmSelect").val("");		//주행거리 초기화
                $("#carRegYearSelect option:eq(0)").attr("selected", "selected");	//연식 기본값으로 셀렉트
                $("#carColorSelect option:eq(0)").attr("selected", "selected");		//색상 옵션 기본값으로 셀렉트
                sale_list(1);
            	$.ajax({
            		url : BNK_CTX + "/product/co/makerCombo"
            		, dataType : 'json'
            		, type: "get"
            		, success : function(data){
            			var $select = $('select[name=makerCd]');
            			render_combo($select, data, '${car.carFullCode}'.substring(0,3));
            		},
            		error: function(error){
            			alertify.alert("데이터 통신상태가 원활하지 않습니다.");
            			console.log(status);
            		}
            	});
            },
            error: function(error){
            }
        });
    });
}

/*
* [function] 내게맞는매물 등록 시 !!
* dev  : 김예지
* date : 2017.08.16
*/
function fn_insertReserve(){
    if($("#hiddenMakerCd").val() == null || $("#hiddenMakerCd").val() == ""){
        alertify.confirm('내게맞는매물을 신청 하시겠습니까?', function(){

            if($('select[name=makerCd]').val() == null || $('select[name=makerCd]').val() == ""){
                alertify.alert("제조사 선택은 필수 입니다.");
                return false;
            }
            if($('select[name=modelCd]').val() == null || $('select[name=modelCd]').val() == ""){
                alertify.alert("모델 선택은 필수 입니다.");
                return false;
            }
            if($('select[name=modelDtlCd]').val() == null || $('select[name=modelDtlCd]').val() == ""){
                alertify.alert("세부모델 선택은 필수 입니다.");
                return false;
            }

            var param = { makerCd       : $('select[name=makerCd]').val() ,
                          modelCd       : $('select[name=modelCd]').val() ,
                          detailModelCd : $('select[name=modelDtlCd]').val() ,
                          useKm         : $('#useKmSelect').val() ,
                          carRegYear    : $('select[name=carRegYear]').val() ,
                          carColor      : $('select[name=carColor]').val() ,
                        };
            $.ajax({
                url : BNK_CTX + "/product/mypage/mycarPersonInsertReserve"
                , data :  JSON.stringify(param)
                , dataType : 'json'
                , type: "POST"
                , contentType: "application/json"
                , success : function(data, textStatus, jqXHR){
                    alertify.alert("등록 되었습니다.");
                    $(".p-close").trigger('click');
                    sale_list(1);
                },
                error: function(error){
                }
            });
        });
    }else{
        alertify.confirm('내게맞는매물을 수정 하시겠습니까?', function(){

            if($('select[name=makerCd]').val() == null || $('select[name=makerCd]').val() == ""){
                alertify.alert("제조사 선택은 필수 입니다.");
                return false;
            }
            if($('select[name=modelCd]').val() == null || $('select[name=modelCd]').val() == ""){
                alertify.alert("모델 선택은 필수 입니다.");
                return false;
            }
            if($('select[name=modelDtlCd]').val() == null || $('select[name=modelDtlCd]').val() == ""){
                alertify.alert("세부모델 선택은 필수 입니다.");
                return false;
            }

            var param = { makerCd       : $('select[name=makerCd]').val() ,
                          modelCd       : $('select[name=modelCd]').val() ,
                          detailModelCd : $('select[name=modelDtlCd]').val() ,
                          useKm         : $('#useKmSelect').val() ,
                          carRegYear    : $('select[name=carRegYear]').val() ,
                          carColor      : $('select[name=carColor]').val() ,
                        };
            $.ajax({
                url : BNK_CTX + "/product/mypage/mycarPersonModifyReserve"
                , data :  JSON.stringify(param)
                , dataType : 'json'
                , type: "POST"
                , contentType: "application/json"
                , success : function(data, textStatus, jqXHR){
                    alertify.alert("수정 되었습니다.");
                    $(".p-close").trigger('click');
                    sale_list(1);
                },
                error: function(error){
                }
            });
        });
    }
}

/*
* [function] 메이크업 차량 조회 시 !!
* dev  : 김예지
* date : 2017.08.16
*/
function fn_searchMakeupCar(){

    var param = {};
    param.schValue = $("#MakeupCarPlateNum").val();

    if(util.isEmpty(param.schValue)){
		alertify.alert('마이카에 등록한 차량번호를 입력하세요.');
		$("#MakeupCarPlateNum").focus();
		return;
    }

    $.ajax({
        url : BNK_CTX + "/product/mypage/mycarPersonSelectMakupCar"
        , data :  JSON.stringify(param)
        , dataType : 'json'
        , type: "POST"
        , contentType: "application/json"
        , success : function(data, textStatus, jqXHR){


        	if(util.isEmpty(data.car)){
				alertify.alert('차량이 존재하지 않습니다.');
        	}else{
	            var temp = $('.makeupAdd');
	            //모바일에도 배기량은 공란으로 되어있어 무조건 없음으로 뿌려줌
	            temp.find("#carCC").text("없음");
	            temp.find("#mycarSeqHidden").val(data.car.mycarSeq);
	            temp.find("#carPlateNumHidden").val(data.car.carPlateNum);

	            if(data.car.carPlateNum == null || data.car.carPlateNum == ""){
	                temp.find("#carPlateNum").text("없음");
	            }else{
	                temp.find("#carPlateNum").text(data.car.carPlateNum);
	            }
	            if(data.car.carRegYear == null || data.car.carRegYear == ""){
	                temp.find("#carRegYear").text("없음");
	            }else{
	                temp.find("#carRegYear").text(data.car.carRegYear);
	            }
	            if(data.car.carColor == null || data.car.carColor == ""){
	                temp.find("#carColor").text("없음");
	            }else{
	                temp.find("#carColor").text(data.car.label.carColor);
	            }
	            if(data.car.useKm == null || data.car.useKm == ""){
	                temp.find("#useKm").text("없음");
	            }else{
	                temp.find("#useKm").text(util.addComma(data.car.useKm) + "KM");
	            }
	            if(data.car.carRegDay == null || data.car.carRegDay == ""){
	                temp.find("#carRegDay").text("없음");
	            }else{
	                temp.find("#carRegDay").text(data.car.carRegDay);
	            }
	            if(data.car.carMission == null || data.car.carMission == ""){
	                temp.find("#carMission").text("없음");
	            }else{
	                temp.find("#carMission").text(data.car.label.carMission);
	            }
	            if(data.car.attachCnt == null || data.car.attachCnt == ""){
	                temp.find("#attachCnt").text("없음" + "/ ");
	            }else{
	                temp.find("#attachCnt").text(data.car.attachCnt + "/");
	            }
	            if(data.car.mortGageCnt == null || data.car.mortGageCnt == ""){
	                temp.find("#mortGageCnt").text("없음");
	            }else{
	                temp.find("#mortGageCnt").text(data.car.mortGageCnt);
	            }
	            if(data.car.carFuel == null || data.car.carFuel == ""){
	                temp.find("#carFuel").text("없음");
	            }else{
	                temp.find("#carFuel").text(data.car.label.carFuel);
	            }
	            if(data.car.unpaidTax == null || data.car.unpaidTax == ""){
	                temp.find("#unpaidTax").text("없음");
	            }else{
	                temp.find("#unpaidTax").text(data.car.unpaidTax);
	            }
        	}

        },
        error: function(error){
        }
    });
}

/*
* [function] 메이크업 등록 시 !!
* dev  : 김예지
* date : 2017.08.16
*/
function fn_insertMakeup(){
    var param = {};
    param.carSeq        = $('#mycarSeqHidden').val();
    param.carPlateNum   = $('#carPlateNumHidden').val();
    param.reqRemark     = $('textarea[name=reqRemark]').val();
    param.reqItems      = '1,2,3';

   	if(util.isEmpty(param.carSeq)){
   		alertify.alert('차량 검색을 먼저 진행해주세요.');
   		return;
   	}

    alertify.confirm('메이크업을 신청 하시겠습니까?', function(){
        $.ajax({
            url : BNK_CTX + "/product/mypage/mycarPersonInsertMakeUp"
            , data :  JSON.stringify(param)
            , dataType : 'json'
            , type: "POST"
            , contentType: "application/json"
            , success : function(data, textStatus, jqXHR){

            	if(data.resCd == '00'){
	                alertify.alert("메이크업이 등록 되었습니다.");
	                $(".p-close").trigger('click');
	                makeup_list(1);

	                var temp = $('.makeupAdd');
		            //모바일에도 배기량은 공란으로 되어있어 무조건 없음으로 뿌려줌
		            temp.find("#carCC").text("");
		            temp.find("#mycarSeqHidden").val("");
		            temp.find("#carPlateNumHidden").val("");
	                temp.find("#carPlateNum").text("");
	                temp.find("#carRegYear").text("");
	                temp.find("#carColor").text("");
	                temp.find("#useKm").text("");
	                temp.find("#carRegDay").text("");
	                temp.find("#carMission").text("");
	                temp.find("#attachCnt").text("");
	                temp.find("#mortGageCnt").text("");
	                temp.find("#carFuel").text("");
	                temp.find("#unpaidTax").text("");
	                temp.find("#MakeupCarPlateNum").val("");
	                temp.find("#reqRemark").val("");
            	}else if(data.resCd == '99'){
            		alertify.alert('메이크업 등록이 실패하였습니다.')
            	}


            },
            error: function(error){
            }
        });
    });
}

/*
* [function] 딜러 팝업 차량 리스트 호출 시 !!
* dev  : 김예지
* date : 2017.08.16
*/
function fn_dealerProfile(curPage){
    var param = {userId         : $("#dealerIdHidden").val()
                ,curPage        : curPage
                }

    // 정보가져오기
    $.ajax({
        url : BNK_CTX + '/product/mypage/mycarPersonGetDealerCarInfo/AJAX',
        method:'POST',
        contentType: 'application/json;charset=UTF-8',
        data: JSON.stringify(param),
        success : function(detailResult){
            $("#saleCarDiv").empty();
            $("#saleCarDiv").append(detailResult);
        },
        error : function(request,status,error){
            alertify.alert(error);
        }
    });
}

/*
* [function] 딜러 팝업 거래평가 호출 시 !!
* dev  : 김예지
* date : 2017.08.16
*/
function fn_dealerEval(curPage){
    var param = {userId         : $("#dealerIdHidden").val()
                ,curPage        : curPage
                }

    // 정보가져오기
    $.ajax({
        url : BNK_CTX + '/product/mypage/mycarPersonGetDealerEvalInfo/AJAX',
        method:'POST',
        contentType: 'application/json;charset=UTF-8',
        data: JSON.stringify(param),
        success : function(detailResult){
            //console.log(JSON.stringify(data));
            $("#evalListDiv").empty();
            $("#evalListDiv").append(detailResult);
            ITCButton.setupTypeAccordion();
        },
        error : function(request,status,error){
            alertify.alert(error);
        }
    });
}

/*
* [function] 딜러 팝업 거래평가 추가 시 !!
* dev  : 김예지
* date : 2017.08.16
*/
function evaluate_regist(){

    var evaluate = {};
    evaluate.dealerId   = $("#dealerIdHidden").val();
    evaluate.rating     = $('.appraisePop .rating').rateit('value');
    evaluate.reviews    = $('textarea[name=reviews]').val();
    if($('#ch1').is(":checked")){
		evaluate.evalDiv = $('#ch1').val();
    }else if($('#ch2').is(":checked")){
    	evaluate.evalDiv = $('#ch2').val();
    }else{
    	evaluate.evalDiv = $('#ch1').val();
    }

    if(evaluate.rating == 0){
        alertify.alert('별점은 1점 이상 입력하세요.');
        return;
    }
    if(evaluate.reviews.length === 0){
        alertify.alert('평가 내용을 입력하세요.');
        return;
    }

    alertify.confirm('작성한 평가를 등록하시겠습니까?', function(){
        $.ajax({
            method : 'POST',
            url : BNK_CTX + '/product/car/evaluateRegist/AJAX',
            contentType: 'application/json;charset=UTF-8',
            data : JSON.stringify({eval: evaluate}),
            success : function(data){
                fn_dealerEval(1);
                $('.appraisePop a.p-close').trigger('click');
                $('#ch1').prop('checked', true);
                $('#ch2').prop('checked', false);
                $('textarea[name=reviews]').val("");
                $('.appraisePop .rating').rateit('value',0);
            },
            error : function(request,status,error){
                alertify.alert(error);
            }
        });
    });
}

/*
* [function] 관심딜러 하나의 상세 화면 팝업 호출 시 !!
* dev  : 김예지
* date : 2017.08.16
*/
function fn_interestDealer(elem, userId ){

	var $btn = $(elem).parents().find(".namePop");
	var data = $btn.data('popOpts');

	data.display = true;
	$btn.data('popOpts', data);
	$btn.trigger('click');

//     var $btn        = $(elem).next();
//     var data        = $('#detailPop').data('popOpts');
//     data.display    = true;
//     $btn.data('popOpts', data);
//     $btn.trigger('click');

    var param = {userId         : userId
                ,curPage        : 1
                ,pageListSize   : 6
                }

    // 정보가져오기
    $.ajax({
        url : BNK_CTX + '/product/mypage/mycarPersonGetDealerInfo/AJAX',
        method:'POST',
        contentType: 'application/json;charset=UTF-8',
        data: JSON.stringify(param),
        success : function(detailResult){
            $("#dealerInfoDiv").empty();
            $("#dealerInfoDiv").append(detailResult);
            fn_dealerEval(1);
            fn_dealerProfile(1);
        },
        error : function(request,status,error){
            alertify.alert(error);
        }
    });
}



//매물관리상세팝업초기화
function mycar_detail_pop_init(){
	/* 주소 변경 */
	$("#btnSearchAddr").click(function() {
		searchAddr();
	});
	$("#searchAddrName").keypress(function(e){
		if(e.keyCode === 13){
			searchAddr();
		}
	});
	$("#dataList").on("click", "li", function() {
		$("#dataList").find("li").removeClass();
		$(this).prop("class","selected");
		$("#selectAddrCode").val($(this).find("span").text());
		$("#selectAddr").val($(this).find("strong").text());
	});
	$("#btnAddrSelect").click(function() {
		$("#detail_zipCode").val($("#selectAddrCode").val());
		$("#detail_addr1").val($("#selectAddr").val());
		$("#btnAddrCancel").trigger("click");
	});


	//파일 업로드
	$('.mycarImage input[type=file]').fileupload({
		url: '/product/mypage/fileUpload/AJAX'
		, acceptFileTypes: /(\.|\/)(jpg)$/i
		, dataType: 'json'
		, done: function(e, data){
			var blob=new Blob(data.files, {type: "octet/stream"});
            var url = URL.createObjectURL(blob);
            var $ul = $(this).closest('ul');
            var $uploader = $('#uploader');
            var $li_clone = $uploader.clone();

            //step 1. 사진등록 완료 li
            $li_clone
            .find('.imgFileDelete').show().end()
            .find('.imgFileUp').hide().end()
            .find('img').prop('src', url);

            //step 2. 사진 삭제 기능
            $li_clone
            .find('.imgFileDelete')
            .on('click', function(){
				$li_clone.remove();		//업로드된 파일 삭제
				$uploader.show();		//사진등록버튼 표출
            });
            //step 3. 가져온 fileseq hidden으로 등록
            $li_clone
            .append($('<input>', {
				type: 'hidden'
				, name: 'fileSeqs[]'
				, value: data.result.fileSeq
			}));

			//step 4. 다음 사진등록 대기 li 추가
			$uploader.before($li_clone);

			//step 5. 업로드 갯수제한 처리
			var allowFileCount = $('.mycarImage .imgFileDelete:visible').length;
			if(allowFileCount === 20){
				$uploader.hide();
			}
		}
	}).on('fileuploadprocessalways', function (e, data) {
		var currentFile = data.files[data.index];
		if (data.files.error && currentFile.error) {
			alertify.alert('jpg 형식만 올릴 수 있습니다.');
		}
	});
}
//매물관리상세팝업열기
function mycar_detail_pop(elem, data){
	$.ajax({
		url : BNK_CTX + '/product/mypage/mycarPersonDetailPop/AJAX',
		dataType : 'html',
		cache : false,
		contentType: 'application/json;charset=UTF-8',
		data : {mycarSeq: data},
		success : function(detailResult){
			$("#carModifyDetailPop").html(detailResult);
			mycar_detail_pop_init();
			$(elem).next('input').trigger('click');
		},
		error : function(request,status,error){
			alertify.alert(error);
		}
	});
}
//매물관리상세팝업 파일삭제
function mycar_detail_pop_file_delete(elem){
	var $btn = $(elem);
	$('#uploader').show();		//사진등록버튼 표출
	$btn.closest('li').remove();
}

//체크박스 전체선택
function checkAll(id, elem){
	$('input[id^='+id+']').prop('checked', $(elem).prop('checked'));
}
//텍스트자동입력
function setArea(elem){
	var txt = $('textarea[name=carDesc]').val();
	//체크박스를 라디오버튼 처럼
	//$(elem).closest('.explain').find(':checkbox').not(elem).prop('checked', false);		//현재 선택된 체크박스를 제외한 모든 체크박스 해제

	//체크되어있으면 매크로 문자열 입력
	if($(elem).is(':checked')){
		$('textarea[name=carDesc]').val(txt + elem.value + '\n');
	//체크되어있지않으면 매크로 문자열 제거
	}else{
		$('textarea[name=carDesc]').val(txt.replace(elem.value + '\n', ''));
	}
}

function openPopup(code){
	switch(code){
	case 'SHOP_POP':
		if(util.isEmpty($("#danjiNo").val())){
			alertify.alert('소속단지를 먼저 선택해주세요.');
			return;
		}
		searchFirm();
		$('#btnShop').trigger('click');
		break;
	}
}
//매물등록/수정
function modify(){
	var constraints = {};
	var params = {};

	Valid.serialize('#mycarDealerForm');
	constraints = Valid.getConstraints();
	//presence: 필수값
 	constraints.carPlateNum.presence	={message:"^차량번호는 필수값입니다."};
 	constraints.carPlateNum.format		={message:"^잘못된 차량번호 형식입니다.", pattern:"^[0-9]{2}[\s]*[가-힣]{1}[\s]*[0-9]{4}"};
	constraints.makerCd.presence		={message:"^제조사는 필수값입니다."};
	constraints.modelCd.presence		={message:"^모델은 필수값입니다."};
	constraints.modelDtlCd.presence		={message:"^세부모델은 필수값입니다."};
	constraints.gradeCd.presence		={message:"^등급은 필수값입니다."};
	constraints.carRegYear.presence		={message:"^연식은 필수값입니다."};
	constraints.carFuel.presence		={message:"^연료타입은 필수값입니다."};
	constraints.carMission.presence		={message:"^변속기는 필수값입니다."};
	constraints.useKm.presence			={message:"^주행거리는 필수값입니다."};
	constraints.useKm.format			={message:"^주행거리 형식이 올바르지 않습니다.", pattern: "[0-9]+"};
	constraints.carColor.presence		={message:"^색상은 필수값입니다."};
	constraints.surfaceState.presence	={message:"^외관상태는 필수값입니다."};
	constraints.rentYn.presence			={message:"^렌터카 사용이력은 필수값입니다."};


	var valid = Valid.validate(constraints);	//유효성체크 시작
	if(valid){	//유효성 판단
		Valid.action();
		return;
	}

	//데이터재가공처리
	//1. 차량코드
	//2. 옵션
	params = Valid.getParams();
	params.carFullCode = params.gradeCd;
	params.fileSeqs = util.nvl(params.fileSeqs, []).join(',');
	params.optionCds = $('.carOptions input[id^=option]:checked').map(function(){ return this.value; }).get().join();

	//매물등록 시작
	var tit = params.mycarSeq ? '수정':'등록';
	alertify.confirm('매물을 '+tit+'하시겠습니까?', function(){
		$.ajax({
			url: BNK_CTX + '/product/mypage/mycarPersonRegist/AJAX'
			, method: 'POST'
			, data: JSON.stringify(params)
			, contentType: 'application/json;charset=UTF-8'
			, success: function(data){
				if(data.resCd == '00'){
					mycar_list();//마이카 func 호출
					$('.p-close').trigger('click');
				}else if(data.resCd == '99'){
					alertify.alert('매물'+tit+'에 실패하였습니다.');
				}
			}
			, error: function(){
				alertify.alert("데이터 통신상태가 원활하지 않습니다.");
			}
		});
	});
}
function businesscard_list(curPage){
    $.ajax({
        url : BNK_CTX + '/product/mypage/mycarPersonBusinesscardList/AJAX',
        dataType : 'html',
        cache : false,
        data : {curPage : curPage},
        success : function(detailResult){
            $("#businesscard_list").empty();
            $("#businesscard_list").append(detailResult);
        },
        error : function(request,status,error){
        }
    });
}
function businesscard_delete(nameCardSeq){
	alertify.confirm('해당 명함을 삭제하시겠습니까?', function(){
		$.ajax({
			url : "/product/mypage/mycarPersonBusinesscardDelete/AJAX",
			method : 'POST',
			contentType: 'application/json;charset=UTF-8',
			data : JSON.stringify({
				nameCardSeq : nameCardSeq
			}),
			success: function(data){
				if(data.resCd == "00"){
					businesscard_list(1);
				}else{
					alertify.alert("데이터를 가져오는중 오류가 발생하였습니다.");
				}
			},
			error: function(){
				alertify.alert("데이터를 가져오는중 오류가 발생하였습니다.");
			},
		})
	});
}

/* 주소검색 TAG 생성 */
function addAddrListData(data) {
	$("#dataList").html("");
	$(data.results.juso).each(function(index){
		$("#dataList").append($('<li/>', {
			id: index
		}));
		$("#"+index).append($('<strong/>', {
	        text: this.roadAddr
		}));
		$("#"+index).append($('<span/>', {
	        text: this.zipNo
		}));
	});
}
function searchAddr(){
	$("#keyword").val($("#searchAddrName").val());
	$.ajax({
		 url  : BNK_CTX + "/api/juso/addrlink"  //인터넷망
		, method : "GET"
		, data : $("#addrFrm").serializeObject()
		, success : function(response){
			$("#list").html("");
			if(response.code == '00'){
				var json = response.data;
				var data = JSON.parse(json.substring(1, json.length-1));
				if(data.results.common.errorCode !== '0'){	//실패시 처리
					alertify.alert(data.results.common.errorMessage);

				}else if(data.results.common.errorCode === '0'){//성공시 처리
					if(data != null){
						addAddrListData(data);
					}
				}
			}else{
				alertify.alert('통신 환경이 원활하지 않거나 시스템 작업중입니다. 잠시 후 다시 접속해주세요.');
			}
		}
	    ,error: function(xhr,status, error){
	    }
	});
}
/*
* [function] 비용계산기 리스트 호출 시 !!
* dev  : 이윤호
* date : 2017.08.23
*/
function cost_list(curPage){
	$.ajax({
		url : BNK_CTX + '/product/mypage/mycarPersonCostList/AJAX',
		dataType : 'html',
		cache : false,
		data : {curPage : curPage},
		success : function(detailResult){
			$("#cost_list").empty();
			$("#cost_list").append(detailResult);
		},
		error : function(request,status,error){
		}
	});
}

/*
* [function] 비용계산기 상세보기 클릭 시 !!
* dev  : 이윤호
* date : 2017.08.23
*/
function fn_costDetail(elem, seq){
	var $btn = $(elem).next();
	var data = $btn.data('popOpts');

	data.display = true;
	$btn.data('popOpts', data);
	$btn.trigger('click');

	var param = {costingSeq : seq};

	// 정보가져오기
	$.ajax({
		url : BNK_CTX + '/product/mypage/mycarPersonCostList/detail',
		method:'POST',
		contentType: 'application/json;charset=UTF-8',
		data: JSON.stringify(param),
		success : function(detailResult){
			$("#costTemplete").empty();
			$("#costTemplete").append(detailResult);
		},
		error : function(request,status,error){
			alertify.alert(error);
		}
	});
}

/*
* [function] 체크리스트 리스트 호출 시 !!
* dev  : 이윤호
* date : 2017.08.23
*/
function check_list(curPage){
	$.ajax({
		url : BNK_CTX + '/product/mypage/mycarPersonCheckList/AJAX',
		dataType : 'html',
		cache : false,
        data : {
        	curPage : curPage
        	, pageListSize : 5
        },
		success : function(detailResult){
			$("#check_list").empty();
			$("#check_list").append(detailResult);
		},
		error : function(request,status,error){
		}
	});
}

/*
* [function] 체크리스트 상세보기 클릭 시 !!
* dev  : 이윤호
* date : 2017.08.23
*/
function fn_checkDetail(elem){
	$("input[type=checkbox]").prop("checked", false);
	$(".checkDiv").hide();
	$("input[type=checkbox]").parent("p").hide();

	var items = $(elem).parent().find(".items").val();
	var itemSplit = items.split(",");
	if(itemSplit.length > 0){
		for (var i = 0; i < itemSplit.length; i++) {
			$("#"+itemSplit[i]).prop("checked" , true);	// 체크
			$("#"+itemSplit[i]).parent().show();
			$("#"+itemSplit[i]).parent().parent("div").show();
		}
	}

	var $btn = $(elem).next();
	var data = $btn.data('popOpts');

	data.display = true;
	$btn.data('popOpts', data);
	$btn.trigger('click');
}

/*
* [function] 관심딜러 삭제버튼 클릭 시 !!
* dev  : 이윤호
* date : 2017.08.23
*/
function fn_delDealer(userId){
	alertify.confirm('삭제하시겠습니까?', function(){
		$.ajax({
			url : BNK_CTX + "/product/co/interestDealer/" + userId,
			method : 'POST',
			contentType: 'application/json;charset=UTF-8',
			data : JSON.stringify({
				userId : userId
			}),
			success: function(data){
				if(data.resCd == "00"){
					interest_dealer_list(1);
				}else{
					alertify.alert("데이터를 가져오는중 오류가 발생하였습니다.");
				}
			},
			error: function(){
				alertify.alert("데이터를 가져오는중 오류가 발생하였습니다.");
			},
		})
	});
}

/*
* [function] 관심차량 삭제버튼 클릭 시 !!
* dev  : 이윤호
* date : 2017.08.23
*/
function fn_deleteCar(carSeq){
	$.ajax({
		url : BNK_CTX + "/product/co/dibsOn/" + carSeq,
		method : 'POST',
		contentType: 'application/json;charset=UTF-8',
		data : JSON.stringify({
			carSeq : carSeq
		}),
		success: function(data){
			if(data.resCd == "00"){
				interest_car_list(1);
			}else{
				alertify.alert("데이터를 가져오는중 오류가 발생하였습니다.");
			}
		},
		error: function(){
			alertify.alert("데이터를 가져오는중 오류가 발생하였습니다.");
		},
	});
}
//콤보박스 그리기
function render_combo($select, data, value){
	var label = '';
	$select.empty();
	switch($select.attr('name')){
	case 'makerCd':
		label = '제조사를 선택해주세요';
		break;
	case 'modelCd':
		label = '모델을 선택해주세요';
		break;
	case 'modelDtlCd':
		label = '세부모델을 선택해주세요';
		break;
	case 'gradeCd':
		label = '등급을 선택해주세요';
		break;
	}
	$select.append($('<option>').val('').text(label));
	for(var key in data){
		var $option = $('<option>');
		$option.val(key);
		$option.text(data[key]);
		$select.append($option);
	}

	$select.val(value);
	$select.trigger('change');
}
//차량모델리스트 가져오기
function model_list(makerCd, name){
	$.ajax({
		url : BNK_CTX + "/product/co/modelCombo"
		, data : {makerCd : makerCd}
		, dataType : 'json'
		, type: "get"
		, contentType: "application/json; charset=UTF-8"
		, success : function(data){
			var $select = $('select[name='+name+']');
			var value = '';
			switch(name){
				case 'modelCd':
					value='${car.modelCd}';
					break;
				case 'modelDtlCd':
					value='${car.detailModelCd}';
					break;
				case 'gradeCd':
					value='${car.carFullCode}';
					break;
			}
			render_combo($select, data, value);
		},
		error: function(error){
			alertify.alert("데이터 통신상태가 원활하지 않습니다.");
			console.log(status);
		}
	});
}
</script>