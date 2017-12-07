<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!-- 2017-07-19 문의내역 등록하기 -->
<div class="popupAutoWrap popQue p-container w670">
    <!-- popup header -->
    <div class="popupHeaderAuto">
        <header><h1>문의내역 등록하기</h1></header>
        <a class="btnClose p-close" onclick="return false;"><em class="blind">닫기</em></a>
    </div>
    <hr/>
    <!-- popup contents -->
    <div class="popupContents">
        <section>
            <div class="autoPop">
                <div class="popTable">
                    <table cellpadding="0" cellspacing="0" border="0">
                        <colgroup>
                            <col width="200" />
                            <col width="700" />
                        </colgroup>
                        <tbody>
                            <tr>
                                <th class="bgGrayCase">제목</th>
                                <td><input type="text" name="qnaTitle" id="qnaTitle" placeholder="제목을 입력하세요." maxlength="100" /></td>
                            </tr>
                            <tr>
                                <th class="bgGrayCase">내용</th>
                                <td><textarea rows="10" name="contents" id="contents" class="f_s12" placeholder="내용을 입력하세요." maxlength="1000"></textarea></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <div class="btnAreaType mt40">
                    <span><button type="button" id="btnQnaCancel" class="line p-close">취소</button></span>
                    <span><button type="button" id="btnQnaInsert">등록</button></span>
                </div>
            </div>
        </section>
    </div>
</div>
<!-- //문의내역 등록하기 -->