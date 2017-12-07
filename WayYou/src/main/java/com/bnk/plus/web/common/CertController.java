package com.bnk.plus.web.common;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.StandardPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bnk.plus.commons.components.CoTopComponent;
import com.bnk.plus.config.AppConstBean;
import com.bnk.plus.entity.CarMarketInfoShop;
import com.bnk.plus.entity.T2Users;
import com.bnk.plus.service.car.service.CarMarketInfoService;
import com.bnk.plus.service.session.service.T2UserService;

@Controller
@RequestMapping(value = {"/front/cert"})
public class CertController extends CoTopComponent {
    
    private final String tilesPrefix = "tiles.front.cert.";
    
    @RequestMapping(value = {"/kmcis_web_sample_step01"}, produces = "text/html; charset=utf-8")
    public String kmcis_web_sample_step01(HttpServletRequest req, HttpServletResponse res, Model model){
        mlog_usual.debug(" :: Load kmcis_web_sample_step01");
        
        return tilesPrefix+"kmcis_web_sample_step01";
    }
    
    @RequestMapping(value = {"/kmcis_web_sample_step02"}, produces = "text/html; charset=utf-8")
    public String kmcis_web_sample_step02(HttpServletRequest req, HttpServletResponse res, Model model){
        mlog_usual.debug(" :: Load kmcis_web_sample_step02");
        
        return tilesPrefix+"kmcis_web_sample_step02";
    }
    
    @RequestMapping(value = {"/kmcis_web_sample_step03"}, produces = "text/html; charset=utf-8")
    public String kmcis_web_sample_step03(HttpServletRequest req, HttpServletResponse res, Model model){
        mlog_usual.debug(" :: Load kmcis_web_sample_step03");
        
        return tilesPrefix+"kmcis_web_sample_step03";
    }
    
    @RequestMapping(value = {"/kmcis_web_sample_step04"}, produces = "text/html; charset=utf-8")
    public String kmcis_web_sample_step04(HttpServletRequest req, HttpServletResponse res, Model model){
        mlog_usual.debug(" :: Load kmcis_web_sample_step04");
        
        return tilesPrefix+"kmcis_web_sample_step04";
    }    
        
}
