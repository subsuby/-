<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<section>
	<div class="myCarLayout">
        <input type="hidden" name="separation" value="N"></input>
		<div class="noList"><em class="blind">목록없음</em></div>
		<div class="btn-toggle-wrapper">
			<div class="btnTab case1 grid3">
				<a href="" onclick="return false;" class="btn-toggle-switch on"><span>내차시세</span></a>
				<a href="" onclick="return false;" class="btn-toggle-switch" ><span>내차견적</span></a>
			</div>
			<div class="btn-toggle-switch-target noList"> 
				<strong>등록된 차량·시세 정보가 없습니다.</strong>
				<span>
				내차팔기에서 회원님의 차량정보를 등록하시고<br>
				BNK 시세정보를 확인하세요.
				</span>
				<button class="btn-popup-full" data-pop-opts='{"target": ".mycarRegist"}' >등록하기</button>
			</div>
			<div class="btn-toggle-switch-target noList" style="display:none;">
				<strong>등록된 차량·시세 정보가 없습니다.</strong>
				<span>
				내차팔기에서 회원님의 차량정보를 등록하시고<br>
				BNK 시세정보를 확인하세요.
				</span>
				<button onClick="location.href='mycar.html'">등록하기</button>
			</div>
		</div>
	</div>
</section>