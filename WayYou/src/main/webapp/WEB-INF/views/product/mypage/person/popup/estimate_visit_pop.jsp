<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!-- 방문견적 -->
<div class="popupAutoWrap visitApp p-container w980"> <!-- 2017-07-24 -->
    <!-- popup header -->
	<div class="popupHeaderAuto">
		<header><h1>방문견적</h1></header>
		<a class="btnClose p-close" onclick="return false;"><em class="blind">닫기</em></a>
	</div>
	<hr/>
    <!-- popup contents -->
    <div class="popupContents">
        <section>
            <div class="autoPop">
				<div class="tabArea mt10" id="visitType">
					<span class="on"><input type="button" value="방문요청" data-name="tabCon1"></span>
					<span><input type="button" value="직접방문" data-name="tabCon2"></span>
				</div>
            	<div class="popTable mt20 tabCon1">
					<div>
						<strong>차량번호</strong>
						<span><input type="text" value="${myCar.carPlateNum}" readonly/></span>
					</div>
					<div>
						<strong>차종</strong>
						<span>
							<select>
								<option value="${myCar.makerCd}">${myCar.label.makerName}</option>
							</select>
							<select>
								<option value="${myCar.modelCd}">${myCar.label.modelName}</option>
							</select>
							<select>
								<option value="${myCar.detailModelCd}">${myCar.label.modelDtlName}</option>
							</select>
						</span>
					</div>
					<div class="addr">
						<strong>주소</strong>
							<span>
								<span class="db mb10"><input id="zipCode" type="text" value="${sessUserInfo.zipCode}"/>
									<button class="btn-popup-auto" id="btnAddr" onclick="return false;" data-pop-opts='{"target": ".findAddress"}'>검색</button>
								</span>
								<span><input id="addr1" type="text" value="${sessUserInfo.addr1}"/><input id="addr2" type="text" value="${sessUserInfo.addr2}"/></span>
							</span>
					</div>
					<div class="callArea">
						<strong>연락처</strong>
						<span>
							<select name="call">
								<option value="010">010</option>
								<option value="011">011</option>
								<option value="016">016</option>
								<option value="017">017</option>
								<option value="018">018</option>
								<option value="019">019</option>
							</select>
							-
							<input name="call" type="text" />
							-
							<input name="call" type="text" />
						</span>
					</div>
					<div class="resDay">
						<strong>예약 날짜</strong>
						<span>
							<select name="reserve_year" class="reserve_date w100" ></select>
							<select name="reserve_month" class="reserve_date w100" ></select>
							<select name="reserve_day" class="reserve_date w100 ml7"></select>
							<select name="reserve_time" class="reserve_date w130 ml7"></select>
						</span>
					</div>
					<div class="service">
						<strong>부가서비스</strong>
						<span>
							<span class="checkSet"><input type="checkbox" class="visit_1" id="vvisit_1" /><label for="vvisit_1" class="pl10">메이크업</label></span>
							<span class="checkSet"><input type="checkbox" class="visit_2" id="vvisit_2" /><label for="vvisit_2">위탁판매</label></span>
						</span>
					</div>
					<div>
						<strong>비고</strong>
						<span>
						</span>
					</div>
				</div>
				<div class="popTable mt20 tabCon2" style="display:none">
                    <div>
                        <strong>차량번호</strong>
                        <span><input type="text" value="${myCar.carPlateNum}" placeholder="차량번호를 입력하세요" readonly="readonly" /></span>
                    </div>
                    <div>
                        <strong>차종</strong>
                        <span>
                            <select name="carType">
                                <option value="${myCar.makerCd}">${myCar.label.makerName}</option>
                            </select>
                            <select name="carModel">
                                <option value="${myCar.modelCd}">${myCar.label.modelName}</option>
                            </select>
                            <select name="carDetail">
                                <option value="${myCar.detailModelCd}">${myCar.label.modelDtlName}</option>
                            </select>
                        </span>
                    </div>
                    <div class="findAff">
                        <strong>소속단지</strong>
                        <span>
                            <input type="hidden" value="" id="danjiNo" name="danjiNo">
                            <input type="text" id="dealerDanjiName" name="dealerDanjiName" placeholder="소속단지를 선택하세요" readonly="readonly" />
                            <button class="btn-popup-auto" id="btnGroup" onclick="return false;" data-pop-opts='{"target": ".popGroup"}'>검색</button>
                        </span>
                    </div>
                    <div class="findAff">
                        <strong>소속상사</strong>
                        <span>
                            <input type="hidden" value="" id="shopNo" name="shopNo">
                            <input type="text" id="dealerShopName" name="dealerShopName" placeholder="소속상사를 선택하세요" readonly="readonly" />
                            <button onclick="openPopup('SHOP_POP')">검색</button>
                            <button style="display:none;" id="btnShop" class="btn-popup-auto" onclick="return false;" data-pop-opts='{"target": ".popGroup2"}'>검색</button>
                        </span>
                    </div>
                    <div class="callArea">
                        <strong>연락처</strong>
                        <span>
                            <select name="visitCall">
                                <option value="010">010</option>
                                <option value="011">011</option>
                                <option value="016">016</option>
                                <option value="017">017</option>
                                <option value="018">018</option>
                                <option value="019">019</option>
                            </select>
                            -
                            <input name="visitCall" type="text" />
                            -
                            <input name="visitCall" type="text" />
                        </span>
                    </div>
                    <div class="resDay">
                        <strong>예약 날짜</strong>
                        <span>
                            <select name="reserve_year" class="reserve_date w100" ></select>
                            <select name="reserve_month" class="reserve_date w100" ></select>
                            <select name="reserve_day" class="reserve_date w100 ml7"></select>
                            <select name="reserve_time" class="reserve_date w130 ml7"></select>
                        </span>
                    </div>
                    <div class="service">
                        <strong>부가서비스</strong>
                        <span>
                            <span class="checkSet"><input type="checkbox" class="visit_1" id="vvisit_3" /><label for="vvisit_3" class="pl10">메이크업</label></span>
                            <span class="checkSet"><input type="checkbox" class="visit_2" id="vvisit_4" /><label for="vvisit_4">위탁판매</label></span>
                        </span>
                    </div>
                    <div>
                        <strong>비고</strong>
                        <span></span>
                    </div>
                </div>
				<div class="btnAreaType mt40">
                    <span><button type="button" onclick="javascript:mycar_list_estimate_service('visit', '${myCar.mycarSeq}')">신청하기</button></span>
                </div>
            </div>
        </section>
    </div>
</div>
<!-- //방문견적 -->
<script>
$(function(){
    $('.tabArea input').click(function () {
        $('.popTable').hide();
        $('.tabArea span').removeClass('on');
        $(this).parents('span').addClass('on');
        var activeTab = $(this).attr('data-name');
        $('.' + activeTab).show();
    }); // 탭 클릭시 해당 컨텐츠 노출

    //소속단지 검색버튼 클릭 시 !!
    $("#btnSearch").click(function() {
        if($("#searchName").val() == "") {
            alertify.alert("검색어를 입력하여 주세요.");
            $("#searchName").focus();
            return false;
        }
        searchGroup();
    });

    //소속상사 검색버튼 클릭 시 !!
    $("#btnGrpSearch").click(function() {
        if($("#searchGrpName").val() == "") {
            alertify.alert("검색어를 입력하여 주세요.");
            $("#searchGrpName").focus();
            return false;
        }
        searchFirm();
    });

    //소속단지 결과 리스트 li 클릭 시 !!
    $("#dataDanjiList").on("click", "li", function() {
        $("#dataDanjiList").find("li").removeClass();
        $(this).prop("class","selected");
        $("#selectNo").val($(this).val());
        $("#selectName").val($(this).text());
    });

    //소속상사 결과 리스트 li 클릭 시 !!
    $("#dataGrpList").on("click", "li", function() {
        $("#dataGrpList").find("li").removeClass();
        $(this).prop("class","selected");
        $("#selectDanjiNo").val($(this).val());
        $("#selectDanjiName").val($(this).text());
    });

    //소속그룹 확인버튼 클릭 시 !!
    $("#success").click(function() {
        $("#danjiNo").val($("#selectNo").val());
        $("#dealerDanjiName").val($("#selectName").val());
        $("#cancel").trigger("click");
    });

    //소속상사 확인버튼 클릭 시 !!
    $("#successGrp").click(function() {
        $("#shopNo").val($("#selectDanjiNo").val());
        $("#dealerShopName").val($("#selectDanjiName").val());
        $("#cancelGrp").trigger("click");
    });
});

$("#dataDanjiList").html("");       //소속그룹 리스트 초기화
$("#dataGrpList").html("");         //소속상사 리스트 초기화

//소속그룹 검색 시 !!
function searchGroup() {
    var param = {danjiFullName : $("#searchName").val()};
    $.ajax({
        url : BNK_CTX + "/product/co/searchGroup"
        , data :  JSON.stringify(param)
        , dataType : 'json'
        , type: "post"
        , contentType: "application/json"
        , success : function(data, textStatus, jqXHR){
            $("#dataDanjiList").html("");
            for(var i=0; i<data.carGroupList.length; i++) {
                $("#dataDanjiList").append('<li value="'+data.carGroupList[i].danjiNo+'">'+data.carGroupList[i].danjiFullName+'</li>');
            }
        },
        error: function(error){
        }
    });
}

//소속상사 검색 시 !!
function searchFirm() {
    var param = {danjiNo : $("#danjiNo").val(), shopFullName : $("#searchGrpName").val()};

    $.ajax({
        url : BNK_CTX + "/product/co/searchFirm"
        , data :  JSON.stringify(param)
        , dataType : 'json'
        , type: "post"
        , contentType: "application/json"
        , success : function(data, textStatus, jqXHR){
            $("#dataGrpList").html("");
            for(var i=0; i<data.carFirmList.length; i++) {
                $("#dataGrpList").append('<li value="'+data.carFirmList[i].shopNo+'">'+data.carFirmList[i].shopFullName+'</li>');
            }
        },
        error: function(error){
        }
    });
}

//전화번호 입력
var phoneNumArr = '${ct:phoneFomatter(sessUserInfo.phoneMobile)}'.split('-');

if(phoneNumArr.length === 3){
	var $phones = $('.visitApp [name=call]');
	$phones.each(function(index){
		this.value = phoneNumArr[index];
	});
	var $phones = $('.visitApp [name=visitCall]');
	$phones.each(function(index){
		this.value = phoneNumArr[index];
	});
}
//주소 입력 처리
/* 주소 변경 */
$("#btnSearchAddr").click(function() {
	$("#keyword").val($("#searchAddrName").val());
	$.ajax({
		 url  : "http://www.juso.go.kr/addrlink/addrLinkApiJsonp.do"  //인터넷망
		, type : "post"
		, data : $("#addrFrm").serialize()
		, dataType : "jsonp"
		, crossDomain : true
		, success : function(data){
			$("#list").html("");
			var errCode = data.results.common.errorCode;
			var errDesc = data.results.common.errorMessage;
			if(errCode != "0"){
				alertify.alert(errCode+"="+errDesc);
			}else{
				if(data != null){
					addAddrListData(data);
				}
			}
		}
	    ,error: function(xhr,status, error){
	    }
	});
});

$("#dataList").on("click", "li", function() {
	$("#dataList").find("li").removeClass();
	$(this).prop("class","selected");
	$("#selectAddrCode").val($(this).find("span").text());
	$("#selectAddr").val($(this).find("strong").text());
});

$("#btnAddrSelect").click(function() {
	$("#zipCode").val($("#selectAddrCode").val());
	$("#addr1").val($("#selectAddr").val());
	$("#btnAddrCancel").trigger("click");
});

$('.popGroup  .p-close').on('click', function(){
	$("#searchName").val('');
	$("#selectNo").val('');
	$("#selectName").val('');
	$("#dataDanjiList").empty();
});
$('.popGroup2  .p-close').on('click', function(){
	$("#searchGrpName").val('');
	$("#selectDanjiNo").val('');
	$("#selectDanjiName").val('');
	$("#dataDanjiList").empty();
});
$('.visitApp .p-close').on('click', function(){
		$("#dataDanjiList").empty();
		$("#dataGrpList").empty();
		$('#zipCode').val('');
		$('#addr1').val('');
		$('#addr2').val('');
		$('#vvisit_1').prop('checked', false);
		$('#vvisit_2').prop('checked', false);
		$("#searchName").val('');
		$("#searchGrpName").val('');
		$("#selectNo").val('');
		$("#selectName").val('');
		$("#selectDanjiNo").val('');
		$("#selectDanjiName").val('');
		$("#danjiNo").val('');
		$("#dealerDanjiName").val('');
		$("#shopNo").val('');
		$("#dealerShopName").val('');
		$('.tabCon1').show();
		$('.tabCon2').hide();
});

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
//날짜 입력 처리
$(function(){
	$(".visitApp select.reserve_date").on('change', function() {
		var value = this.value;

		switch(this.name){
			case 'reserve_year':
				var $year = $(this);
				var $month = $year.next('select[name=reserve_month]').empty();
				var $day = $month.next('select[name=reserve_day]').empty();
				var $time = $day.next('select[name=reserve_time]').empty();

				var now = new Date();
				var year = value;
				var month = 1;
				var day = 1;

				// 선택한 값이 현재 연도와 같을 경우
				if(value == now.getFullYear()){
					month = now.getMonth() + 1;
				}
				// 선택한 값이 현재 월과 같을 경우
				if(month == now.getMonth() + 1){
					day = now.getDate();
				}

				var years = util.range(year+1, year);
				var months = util.range(12, month);
				var days = util.range(new Date( year , month, 0).getDate(), day);
				var times = ['AM','PM'];

				if(day == now.getDate()){
					if(now.getHours() > 11){
						times = ['PM'];
					}else{
						times = ['AM','PM'];
					}
				}

				render_date($month, months, '월');
				render_date($day, days, '일');
				render_date($time, times, '오전/오후', true);
				break;
			case 'reserve_month':
				var $year = $(this).siblings('select[name=reserve_year]');
				var $month = $year.next('select[name=reserve_month]');
				var $day = $month.next('select[name=reserve_day]').empty();
				var $time = $day.next('select[name=reserve_time]').empty();

				var now = new Date();
				var year = $year[0].value;
				var month = value;
				var day = 1;

				// 선택한 값이 현재 연도, 월과 같을 경우
				if(value == now.getMonth() + 1 && year == now.getFullYear()){
					day = now.getDate();
				}

				var days = util.range(new Date( year , month, 0).getDate(), day);
				var times = ['AM','PM'];

				if(day == now.getDate()){
					if(now.getHours() > 11){
						times = ['PM'];
					}else{
						times = ['AM','PM'];
					}
				}

				render_date($day, days, '일');
				render_date($time, times, '오전/오후', true);
				break;
			case 'reserve_day':
				var $year = $(this).siblings('select[name=reserve_year]');
				var $month = $year.next('select[name=reserve_month]');
				var $day = $month.next('select[name=reserve_day]');
				var $time = $day.next('select[name=reserve_time]').empty();

				var now = new Date();
				var year = $year[0].value;
				var month = $month[0].value;
				var day = value;
				var times = ['AM','PM'];

				if(year==now.getFullYear() && month==(now.getMonth()+1) && value==now.getDate())
				{
					if(now.getHours() > 11){
						times = ['PM'];
					}else{
						times= ['AM','PM'];
					}
				}else{
					times = ['AM','PM'];
				}

				render_date($time, times, '오전/오후', true);
				break;
		}
	});
	render_date_init();
});
function render_date_init(){
	var now		= new Date();
	var year	= now.getFullYear();
	var month	= 1;
	var day		= 1;

	if(year == now.getFullYear()){
		month = now.getMonth() + 1;
	}
	if(month == now.getMonth() + 1){
		day = now.getDate();
	}

	var years = util.range(year+1, year);
	var months = util.range(12, month);
	var days = util.range(new Date( year , month, 0).getDate(), day);
	var times = ['AM','PM'];

	if(day == now.getDate()){
		if(now.getHours() > 11){
			times = ['PM'];
		}else{
			times = ['AM','PM'];
		}
	}

	$('select[name=reserve_year]').each(function(){
		var $this = $(this);
		render_date($this, years, '년');
	});
	$('select[name=reserve_month]').each(function(){
		var $this = $(this);
		render_date($this, months, '월');
	});
	$('select[name=reserve_day]').each(function(){
		var $this = $(this);
		render_date($this, days, '일');
	});
	$('select[name=reserve_time]').each(function(){
		var $this = $(this);
		render_date($this, times, '오전/오후', true);
	});
}
function render_date($this, arr, label, custom){
	arr.forEach(function(obj, index){
		if(!custom){
			$this.append('<option value="'+obj+'">'+obj+label+'</option>');
		}else{
			$this.append('<option value="'+obj+'">'+(obj=='AM'?'오전':'오후')+'</option>');
		}
	});
}
</script>