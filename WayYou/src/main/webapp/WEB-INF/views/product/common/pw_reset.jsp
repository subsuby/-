<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>         
<!-- contents -->
<div class="contents">
    <section>
        <div class="form">
			<div class="innerLayout">
				<div class="dataSet">
					<h2>비밀번호 재설정<em>새로운 비밀번호를 입력해주세요.</em></h2>
				</div>
			</div>
			<div class="loginLayout bgGrayCase pt80">
                <div class="loginForm">
                    <form method="post" action="">
                        <fieldset>
                        	<input type="hidden" id="name" name="name" value="${param.name}">
                        	<input type="hidden" id="phoneNo" name="phoneNo" value="${param.phoneNo}">
                            <input type="password" id="newPw" name="newPw" value="" class="bdbn mb0" placeholder="새 비밀번호를 입력하세요.">
                            <input type="password" id="newPwChk" name="newPwChk" value="" placeholder="다시 입력하세요.">
                            <div class="btnSet loginBtn mt40">
                                <span><a href="<c:url value="/product//index"/>" class="redLine">취소</a></span>
                                <span><a href="#" id="pwChange" class="red">변경</a></span>
                            </div>
                        </fieldset>
                    </form>
                </div>                      
            </div>
        </div>
    </section>
</div>
<!-- //contents -->
