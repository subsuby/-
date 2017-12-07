<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<div class="contents">
     <section>
         <div class="myLayout">
				<jsp:include page="mycar_menu.jsp" flush="false" />
             <!--  -->
             <div class="titBar"><!-- active 추가시 활성화 -->
                 <h2>구매비용항목관리 <em>전체 <i id="costTotCnt"></i>건</em></h2>
                 <!-- <span class="btnHelp"><em class="blind">도움말</em></span>
                 <div class="popHelp">
                 </div> -->
             </div>
             <div class="searchBox visitSearch">
                 <div class="box mb0">
                     <strong>차량</strong>
                     <select id="makerCombo" value=""></select>
                     <select id="modelCombo" class="w150">
	                     <option value="">모델</option>
	                 </select>
                     <select id="modelDetailCombo" class="w150">
                         <option value="">세부모델</option>
                     </select>
                     <label for=""><input type="text" id="carPlateNum" placeholder="차량번호"></label>
                     <button class="btnSearch btnL" id="btnSearch">검색</button>
                     <button class="btnInit" id="btnClear">초기화</button>
                 </div>
             </div>
             <div class="btnTab">
                 <button class="enrollment btn-popup-auto" onclick="return false;" data-pop-opts='{"target": ".popCostSetting"}'>구매비용발송</button>
             </div>
             <div class="btn-toggle-wrapper">
                 <div class="btn-toggle-switch-target" id="templateList">
                    
                </div>
            </div>
        </div>
    </section>
</div>