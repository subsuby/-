<%
	//************************************************************************
	//																		//
	//		본 샘플소스는 개발 및 테스트를 위한 목적으로 만들어졌으며,		//
	//																		//
	//		실제 서비스에 그대로 사용하는 것을 금합니다.					//
	//																		//
	//************************************************************************
%>
<%
    response.setHeader("Pragma", "no-cache" );
    response.setDateHeader("Expires", 0);
    response.setHeader("Pragma", "no-store");
    response.setHeader("Cache-Control", "no-cache" );
%>
<%@ page import = "java.util.*" %>
<%@ page import = "java.util.regex.*" %>
<%@ page import = "java.text.*" %>
<%
    //tr_cert 데이터 변수 선언 ---------------------------------------------------------------
	String tr_cert       = "";
    String cpId          = request.getParameter("cpId");        // 회원사ID
    String urlCode       = request.getParameter("urlCode");     // URL코드
    String certNum       = request.getParameter("certNum");     // 요청번호
    String date          = request.getParameter("date");        // 요청일시
    String certMet       = request.getParameter("certMet");     // 본인인증방법
    String name          = request.getParameter("name");        // 성명
    String phoneNo	     = request.getParameter("phoneNo");	    // 휴대폰번호
    String phoneCorp     = request.getParameter("phoneCorp");   // 이동통신사
	if(phoneCorp == null) phoneCorp = "";
	String birthDay	     = request.getParameter("birthDay");	// 생년월일
	String gender	     = request.getParameter("gender");		// 성별
	if(gender == null) gender = "";
    String nation        = request.getParameter("nation");      // 내외국인 구분
	String plusInfo      = request.getParameter("plusInfo");	// 추가DATA정보
	String extendVar     = "0000000000000000";                  // 확장변수
    //End-tr_cert 데이터 변수 선언 ---------------------------------------------------------------

	String tr_url     = request.getParameter("tr_url");         // 본인인증서비스 결과수신 POPUP URL
	String tr_add     = request.getParameter("tr_add");         // IFrame사용여부

	/** certNum 주의사항 **************************************************************************************
	* 1. 본인인증 결과값 복호화를 위한 키로 활용되므로 중요함.
	* 2. 본인인증 요청시 중복되지 않게 생성해야함. (예-시퀀스번호)
	* 3. certNum값은 본인인증 결과값 수신 후 복호화키로 사용함.
	       tr_url값에 certNum값을 포함해서 전송하고, (tr_url = tr_url + "?certNum=" + certNum;)
		   tr_url에서 쿼리스트링 형태로 certNum값을 받으면 됨. (certNum = request.getParameter("certNum"); )
	*
	***********************************************************************************************************/
%>
<%!
   // 파라미터 유효성 검증 --------------------------------------------
	boolean b = true;
	String regex = "";
	String regex1 = "";

	public Boolean paramChk(String patn, String param){
		Pattern pattern = Pattern.compile(patn);
		Matcher matcher = pattern.matcher(param);
		b = matcher.matches();
		return b;
	}
%>
<%
	// END 파라미터 유효성 검증 --------------------------------------------

    //01. 한국모바일인증(주) 암호화 모듈 선언
   com.icert.comm.secu.IcertSecuManager seed  = new com.icert.comm.secu.IcertSecuManager();

	//02. 1차 암호화 (tr_cert 데이터변수 조합 후 암호화)
	String enc_tr_cert = "";
	tr_cert            = cpId +"/"+ urlCode +"/"+ certNum +"/"+ date +"/"+ certMet +"/"+ birthDay +"/"+ gender +"/"+ name +"/"+ phoneNo +"/"+ phoneCorp +"/"+ nation +"/"+ plusInfo +"/"+ extendVar;
	enc_tr_cert        = seed.getEnc(tr_cert, "");

	//03. 1차 암호화 데이터에 대한 위변조 검증값 생성 (HMAC)
	String hmacMsg = "";
	hmacMsg = seed.getMsg(enc_tr_cert);

	//04. 2차 암호화 (1차 암호화 데이터, HMAC 데이터, extendVar 조합 후 암호화)
	tr_cert  = seed.getEnc(enc_tr_cert + "/" + hmacMsg + "/" + extendVar, "");
%>

<html>
<head>
<title>본인인증서비스 Sample 화면</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<meta name="robots" content="noindex">
<style>
<!--
   body,p,ol,ul,td
   {
	 font-family: 굴림;
	 font-size: 12px;
   }

   a:link { size:9px;color:#000000;text-decoration: none; line-height: 12px}
   a:visited { size:9px;color:#555555;text-decoration: none; line-height: 12px}
   a:hover { color:#ff9900;text-decoration: none; line-height: 12px}

   .style1 {
		color: #6b902a;
		font-weight: bold;
	}
	.style2 {
	    color: #666666
	}
	.style3 {
		color: #3b5d00;
		font-weight: bold;
	}
-->
</style>

<script language=javascript>
</script>

</head>

<body bgcolor="#FFFFFF" topmargin=0 leftmargin=0 marginheight=0 marginwidth=0>

<center>
<br><br><br><br><br><br>
<span class="style1">본인인증서비스 요청화면 Sample입니다.</span><br>
<br><br>
<table cellpadding=1 cellspacing=1>
    <tr>
        <td align=center>회원사ID</td>
        <td align=left><%=cpId%></td>
    </tr>
    <tr>
        <td align=center>URL코드</td>
        <td align=left><%=urlCode%></td>
    </tr>
    <tr>
        <td align=center>요청번호</td>
        <td align=left><%=certNum%></td>
    </tr>
    <tr>
        <td align=center>요청일시</td>
        <td align=left><%=date%></td>
    </tr>
    <tr>
        <td align=center>본인인증방법</td>
        <td align=left><%=certMet%></td>
        </td>
    </tr>
    <tr>
        <td align=center>이용자성명</td>
        <td align=left><%=name%></td>
    </tr>
    <tr>
        <td align=center>휴대폰번호</td>
        <td align=left><%=phoneNo%></td>
    </tr>
    <tr>
        <td align=center>이동통신사</td>
        <td align=left><%=phoneCorp%></td>
    </tr>
    <tr>
        <td align=center>생년월일</td>
		<td align=left><%=birthDay%></td>
    </tr>
	<tr>
        <td align=center>이용자성별</td>
        <td align=left><%=gender%></td>
    </tr>
    <tr>
        <td align=center>내외국인</td>
        <td align=left><%=nation%></td>
    </tr>
    <tr>
        <td align=center>추가DATA정보</td>
        <td align=left><%=plusInfo%></td>
        </td>
    </tr>
    <tr>
        <td align=center>&nbsp</td>
        <td align=left>&nbsp</td>
    </tr>
    <tr width=100>
        <td align=center>요청정보(암호화)</td>
        <td align=left>
            <%=tr_cert.substring(0,50)%>...
        </td>
    </tr>
    <tr>
        <td align=center>결과수신URL</td>
        <td align=left><%=tr_url%></td>
    </tr>
    <tr>
        <td align=center>IFrame사용여부</td>
        <td align=left><%=tr_add%></td>
    </tr>
</table>

<!-- 본인인증서비스 요청 form --------------------------->
<form name="reqKMCISForm" method="post" action="#">
    <input type="hidden" name="tr_cert"     value = "<%=tr_cert%>">
    <input type="hidden" name="tr_url"      value = "<%=tr_url%>">
    <input type="hidden" name="tr_add"      value = "<%=tr_add%>">
    <input type="submit" value="본인인증서비스 요청"  onclick= "javascript:openKMCISWindow();">
</form>
<BR>
<BR>
<!--End 본인인증서비스 요청 form ----------------------->

<br>
<br>
  이 Sample화면은 본인인증서비스 요청화면 개발시 참고가 되도록 제공하고 있는 화면입니다.<br>
<br>
</center>
</BODY>
</HTML>