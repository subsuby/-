<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!-- 문의내역 답변하기 -->
<div class="popupAutoWrap popQue answerCase p-container w670">
    <!-- popup header -->
    <div class="popupHeaderAuto">
        <header><h1>문의내역 답변하기</h1></header>
        <a class="btnClose p-close" onclick="return false;"><em class="blind">닫기</em></a>
    </div>
    <hr/>
    <!-- popup contents -->
    <div class="popupContents">
        <section>
            <div class="autoPop">
                <div class="popTable">
					<dl>
						<dt>제목이 나옵니다. 제목이 나옵니다. 제목이 나옵니다. 제목이 나옵니다. 제목이 나옵니다. 제목이 나옵니다. 제목이 나옵니다. 제목이 나옵니다. 제목이 나옵니다. 제목이 나옵니다. 제목이 나옵니다. 제목이 나옵니다. 제목이 나옵니다. 제목이 나옵니다. 제목이 나옵니다. 제목이 나옵니다.</dt>
						<dd>내용이 나옵니다. 내용이 나옵니다. 내용이 나옵니다. 내용이 나옵니다. 내용이 나옵니다. 내용이 나옵니다. 내용이 나옵니다. 내용이 나옵니다. 내용이 나옵니다. 내용이 나옵니다. 내용이 나옵니다. 내용이 나옵니다.</dd>
					</dl>
                  	<table cellpadding="0" cellspacing="0" border="0">
						<colgroup>
							<col width="100" />
							<col width="800" />
						</colgroup>
						<tbody>
							<form id="questionForm">
								<input name="qtSeq" type="hidden"/>
								<tr>
									<th class="bgGrayCase">답변내용</th>
									<td><textarea name="contents" rows="10" class="f_s12" placeholder="답변내용을 입력하세요."></textarea></td>
								</tr>
							</form>
						</tbody>
					</table>
                </div>
                <div class="btnAreaType mt40">
                    <span><button class="line p-close">취소</button></span>
                    <span><button type="button" onclick="onClick('QNA_REGIST')">등록</button></span>
                </div>
            </div>
        </section>
    </div>
</div>
<!-- //문의내역 답변하기 -->