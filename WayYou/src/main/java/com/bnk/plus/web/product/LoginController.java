package com.bnk.plus.web.product;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AbstractAuthenticationToken;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.WebAuthenticationDetails;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.bnk.plus.commons.components.CoTopComponent;
import com.bnk.plus.entity.T2Authorities;
import com.bnk.plus.entity.T2Users;
import com.bnk.plus.service.session.service.T2UserService;

@Controller
@RequestMapping(value = {"/product/co"})
public class LoginController extends CoTopComponent{

	private final String tilesPrefix = "tiles.product.login";

	@Autowired T2UserService   t2userSerivce;
//	@Autowired AuthenticationManager authenticationManager;
	@Autowired AuthenticationProvider authenticationProvider;

	@RequestMapping(value = {"/login"}, method = RequestMethod.GET, produces = "text/html; charset=utf-8")
	public String frontLogin(HttpServletRequest req, HttpServletResponse res) throws IOException {
		if(isLogin()) {
			res.sendRedirect(req.getContextPath() + "/product/index");
		}
		return tilesPrefix+".login";
	}

	@RequestMapping(value = {"/loginExpired"}, method = RequestMethod.GET, produces = "text/html; charset=utf-8")
	public void loginExpired(HttpServletRequest req, HttpServletResponse res) throws IOException {
		res.sendRedirect(req.getContextPath() + "/index");
	}


	@RequestMapping(value = {"/customLogin"}, method = RequestMethod.POST, produces = "text/html; charset=utf-8")
	public ResponseEntity<Object> customLoginProc(T2Users loginUser, HttpServletRequest req, HttpServletResponse res) {
		mlog_usual.debug(" :: Load customLogin Page.");
		HashMap<String, Object> resMap = new HashMap<String, Object>();
		HashMap<String, Object> dataMap = new HashMap<String, Object>();
		//User Detail
		String resCd = "00";
		String url = "";
		try {
			T2Users userInfo = t2userSerivce.getUserInfo(loginUser);
			if(userInfo == null) resCd = "01";	// 이름, 핸드폰번호가 맞지 않습니다.
			if(resCd.equals("00")){

				// 권한조회
				List<GrantedAuthority> roles = new ArrayList<GrantedAuthority>();
	        	T2Users getUser = t2userSerivce.getUserAndAuthorities(userInfo);
	        	for(T2Authorities auth : getUser.getAuthoritiesList()) {
	        		roles.add(new SimpleGrantedAuthority(auth.getAuthority()));
	        	}

				// Must be called from request filtered by Spring Security, otherwise SecurityContextHolder is not updated
		        UsernamePasswordAuthenticationToken token = new UsernamePasswordAuthenticationToken(userInfo.getUserId(), loginUser.getPassword(), roles);
		        token.setDetails(new WebAuthenticationDetails(req));
		        Authentication authentication = this.authenticationProvider.authenticate(token);
		        mlog_usual.debug("Logging in with [{}]", authentication.getPrincipal());
		        SecurityContextHolder.getContext().setAuthentication(authentication);

		        // Security session에 추가 정보(Cusom)를 저장한다(Map형태)
				SecurityContext sec = SecurityContextHolder.getContext();
				AbstractAuthenticationToken auth = (AbstractAuthenticationToken)sec.getAuthentication();

				HashMap<String, Object> info = new HashMap<String, Object>();
				info.put("sessUserInfo", getUser);
				/*
				 * AdviceController.java 에서
				 * @ModelAttribute("sessUserInfo")로 값을 넣어준다.
				 * JSP에서 ${sessUserInfo}로 가져올 수 있다.
				 */
				dataMap.put("sessUserInfo", getUser);
				auth.setDetails(info);

				url = (String) getSessionObject("moveUrl", true);
				if(!"".equals(url) && url != null){
					resMap.put("moveUrl", url);
				}

			}
	    } catch (Exception e) {
	        SecurityContextHolder.getContext().setAuthentication(null);
	        resCd = "02";	// 비밀번호 오류
	    }
		resMap.put("code", resCd);
		resMap.put("data", dataMap);

		return makeJsonResponseHeader(resMap);
	}

	@RequestMapping(value = {"/front/loginChk"}, method = RequestMethod.POST, produces = "text/html; charset=utf-8")
	public ResponseEntity<Object> loginChk(@RequestBody T2Users loginUser,HttpServletRequest req, HttpServletResponse res) throws Exception{
	    Map<String, Object> resMap = new HashMap<>();
	    Map<String, Object> dataMap = new HashMap<>();
	    String resCd = "00";
	    //핸드폰 번호와 이름으로 아이디 조회
	    T2Users userInfo = t2userSerivce.getUserInfo(loginUser);
		if(userInfo == null) {
			resCd = "01";	// 이름, 핸드폰번호가 맞지 않습니다.
		}else{
			dataMap.put("userId", userInfo.getUserId());
		}
		resMap.put("code", resCd);
		resMap.put("data", dataMap);
        return makeJsonResponseHeader(resMap);
	}


	/**
	 * code 설명
	 * 00 : 성공
	 * 01 : 카매니저 정보 갱신 또는 디바이스가 인증되지 않았습니다.
//	 * 02 : 디바이스가 등록되지 않았습니다.
//	 * 03 : 디바이스 등록요청 대기중입니다.
//	 * 04 : 접속이 제한되었습니다.
//	 * 05 : 등록된 디바이스 정보가 일치하지 않습니다.
	 * 10 : 비밀번호가 틀렸습니다.
	 * 20 : 비밀번호가 만료되었습니다.
	 * 30 : 비밀번호 오류횟수가 초과되었습니다.
	 * 40 : 입력하신 사번을 확인해 주세요.
	 * 77 : 이전사번 로그인 시도
	 * 88 : 인증서버 연결을 실패하였습니다.
	 * 99 : 기타오류
	 * @throws IOException
	 *
	 */
	/*
	@RequestMapping(value = {"/custom-login-proc"}, method = RequestMethod.POST, produces = "text/html; charset=utf-8")
	public void customLoginProc(HttpServletRequest req, HttpServletResponse res) throws IOException {
		String id = nvl((String)req.getParameter("un"));
		String pwd = nvl((String)req.getParameter("up"));

		String resCd = "";
		String uuid = "";

		if(resCd.equals("00")){

			Employee empl = new Employee();
			Device device = new Device();
			empl.setSaleManCd(id);
			device.setDeviceUuid(uuid);

			// App Server 인증 확인
			if(employeeService.isUserRegistAndDeviceAuth(empl, device)){

				try {
					// Session 암오화 키 등록(ID + Timestamp)
					String authKey = String.format("%s|%d", id, DateUtil.getCurrentDate().getTime());
					String enc = CryptUtil.encryptAES256(authKey, "a0f8enekjak32bFI");
					req.getSession().setAttribute("authKey", enc);
					req.getSession().setAttribute("sessUserInfo", employeeService.getEmplDetailInfo(empl));
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
					resCd = "99";
				}

				// TODO: 로그인 이력

			}else{
				// 카매니저 정보 갱신 또는 디바이스가 인증되지 않았습니다.
				resCd = "01";
			}
		}

		if(resCd.equals("00")) {
			res.sendRedirect(req.getContextPath() + AppConstBean.SECURITY_FRONT_DEFAULT_SUCCESS_URL);
		}else{
			res.sendRedirect(req.getContextPath() + AppConstBean.SECURITY_FRONT_FAILURE_URL+"&cd="+resCd);
		}
	}

	@RequestMapping(value = {"/custom-logout-proc"}, method = RequestMethod.POST, produces = "text/html; charset=utf-8")
	public void customLoginoutProc(HttpServletRequest req, HttpServletResponse res) throws IOException {
		req.getSession().removeAttribute("authKey");
		req.getSession().removeAttribute("sessUserInfo");
		res.sendRedirect(req.getContextPath() + AppConstBean.SECURITY_FRONT_LOGOUT_URL);
	}
	*/
}
