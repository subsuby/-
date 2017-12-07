<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!-- 명함수정 -->
<div class="popupAutoWrap popCardModify p-container w800">
	<!-- popup header -->
	<div class="popupHeaderAuto">
	    <header><h1>명함수정</h1></header>
	    <a class="btnClose p-close" onclick="return false;"><em class="blind">닫기</em></a>
	</div>
	<hr/>
	<!-- popup contents -->
	<section>
	<div class="popupContents">
		<div class="cardWrap cardP1">
			<dl class="cardArea">
				<dt class="logo"><span><em class="blind">bnk</em></span></dt>
				<dd>
					<!-- 2017-08-19 프로필이미지 변경 -->
					<div class="profileImage main">
						<img src="/product/images/thumbnail/profileCorver2.png" alt="" class="corver">
						<div class="imgBack"><span><img src="" onerror="this.src='<c:url value="/product/images/thumbnail/profile1.png"/>'" alt=""></span></div>
					</div>
					<!-- 2017-08-19 프로필이미지 변경 -->
					<span class="levelArea"><i class="levelBadge level2"></i><strong id="dealerName"></strong>딜러</span>
					<span class="text"><em id="dealerDanjiName"></em><em id="danjiaddr"></em></span>
					<span class="num" id="num1"></span>
					<span class="memo" id="memo"></span>
				</dd>
			</dl>
			<div class="btnSet">
					<span><button class="redLine" id="cModifyBtn">명함 수정하기</button></span>
			</div>
		</div>
	</div>
	<div class="cardWrap cardP2" style="display:none">
		<dl class="cardArea modify">
			<dt class="logo"><span><em class="blind">bnk</em></span></dt>
			<dd>
				<!-- 2017-08-19 프로필이미지 변경 -->
				<div class="profileImage modify">
					<button class="btnDel"><em class="blind">삭제</em></button>
					<strong class="btnAdd" style="display:none">
						<input type="file" id="prFile" />
						<label for="prFile">추가</label>
					</strong>
					<img src="/product/images/thumbnail/profileCorver2.png" alt="" class="corver">
					<button class="btnDel"><em class="blind">추가</em></button>
					<div class="imgBack">
						<span id="imgSpan">
							<img src="" alt="" class="realImage">
							<img src="" alt="" class="noImage" style="display:none" id="noImage">
						</span>
					</div>
				</div>
				<!-- 2017-08-19 프로필이미지 변경 -->
				<span class="levelArea"><i class="levelBadge level2"></i><strong id="dealerName2"></strong>딜러</span>
				<span class="text"><em id="dealerDanjiName2"></em><em id="danjiaddr2"></em></span>
				<span class="num" id="num2"></span>
				<span class="memo"><label for=""><input type="text" id="dealerMemo" value=""></label></span>
			</dd>
		</dl>
		<div class="btnSet">
			<span><button class="redLine p-close modifyCancel">취소</button></span>
			<span><button class="red modifyOk">수정완료</button></span>
		</div>
	</div>
	</section>
</div>