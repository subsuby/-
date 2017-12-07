package com.bnk.plus.config.handler;

import java.util.ArrayList;
import java.util.Hashtable;
import java.util.List;

import javax.naming.Context;
import javax.naming.NamingException;
import javax.naming.directory.DirContext;
import javax.naming.directory.InitialDirContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.crypto.password.StandardPasswordEncoder;
import org.springframework.stereotype.Component;

import com.bnk.plus.commons.CoConstDef;
import com.bnk.plus.commons.util.StringUtil;
import com.bnk.plus.config.AppConstBean;
import com.bnk.plus.entity.T2Authorities;
import com.bnk.plus.entity.T2Users;
import com.bnk.plus.service.session.service.T2UserService;

// TODO: Auto-generated Javadoc
/**
 * The Class CustomAuthenticationProvider.
 */
@Component
public class CustomAuthenticationProvider implements AuthenticationProvider {

	/** The user service. */
	@Autowired
    T2UserService userService;
	
	/* (non-Javadoc)
	 * @see org.springframework.security.authentication.AuthenticationProvider#authenticate(org.springframework.security.core.Authentication)
	 */
	@Override
	public Authentication authenticate(Authentication authentication) throws AuthenticationException {
		
        String user_id = (String)authentication.getPrincipal();     
        String user_pw = (String)authentication.getCredentials();
         
//        if(
//        		(("oscAdmin".equals(user_id) || "guest".equals(user_id)) 
//        				&& checkSystemUser(user_id, user_pw)
//        				) || checkByADUser(user_id, user_pw)
//        		){
//            List<GrantedAuthority> roles = new ArrayList<GrantedAuthority>();
//
//            T2Users user = new T2Users();
//            user.setUserId(user_id);
//            T2Users getUser = userService.getUserAndAuthorities(user);
//            for(T2Authorities auth : getUser.getAuthoritiesList()) {
//            	roles.add(new SimpleGrantedAuthority(auth.getAuthority()));
//            }
        
        if(checkSystemUser(user_id, user_pw)){
        	List<GrantedAuthority> roles = new ArrayList<GrantedAuthority>();
        	
        	T2Users user = new T2Users();
        	user.setUserId(user_id);
        	T2Users getUser = userService.getUserAndAuthorities(user);
        	for(T2Authorities auth : getUser.getAuthoritiesList()) {
        		roles.add(new SimpleGrantedAuthority(auth.getAuthority()));
        	}
            return new UsernamePasswordAuthenticationToken(user_id, user_pw, roles);          
        }else{
            throw new BadCredentialsException("Bad credentials");
        }
	}

	/**
	 * Check system user.
	 *
	 * @param user_id the user_id
	 * @param user_pw the user_pw
	 * @return true, if successful
	 */
	private boolean checkSystemUser(String user_id, String user_pw) {
		T2Users param = new T2Users();
		param.setUserId(user_id);
		
		StandardPasswordEncoder s = new StandardPasswordEncoder(AppConstBean.StandardPasswordEncoderSalt);
		return s.matches(user_pw, userService.getPassword(param));
	}

	/**
	 * Check by ad user.
	 * AD연동 로그인 체크
	 *
	 * @param user_id the user_id
	 * @param user_pw the user_pw
	 * @return true, if successful
	 */
//	private boolean checkByADUser(String user_id, String user_pw) {
//		boolean isAuthenticated = false;
//		//String path = String.format(Const.LDAP_PATH_FORMAT , Const.LDAP_DOMAIN);
//
//		if (StringUtil.isNotEmpty(user_pw)) {
//			Hashtable<String, String> properties = new Hashtable<String, String>();
//			properties.put(Context.INITIAL_CONTEXT_FACTORY, CoConstDef.AD_LDAP_LOGIN.INITIAL_CONTEXT_FACTORY.getValue());
//			properties.put(Context.PROVIDER_URL, CoConstDef.AD_LDAP_LOGIN.LDAP_SERVER_URL.getValue());
//			properties.put(Context.SECURITY_AUTHENTICATION, "simple");
//			properties.put(Context.SECURITY_PRINCIPAL, user_id+CoConstDef.AD_LDAP_LOGIN.LDAP_DOMAIN.getValue());
//			properties.put(Context.SECURITY_CREDENTIALS, user_pw);
//
//			DirContext con = null;
//			try {
//				con = new InitialDirContext(properties);
//				isAuthenticated = true;
//			}catch (NamingException e) {
//				e.printStackTrace();
//				if(e.getMessage().contains(CoConstDef.AD_LDAP_LOGIN.ERROR_49.getValue())){
//					//throw new Exception(CoConstDef.LOGIN_FAIL);
//				}else{
//					//throw new Exception(e.getMessage());
//				}
//			} finally {
//				if(con != null) {
//					try {
//						con.close();
//					} catch (NamingException e) {}
//				}
//			}
//		}
//		return isAuthenticated;
//	}

	/* (non-Javadoc)
	 * @see org.springframework.security.authentication.AuthenticationProvider#supports(java.lang.Class)
	 */
	@Override
	public boolean supports(Class<?> authentication) {
		return true;
	}

}
