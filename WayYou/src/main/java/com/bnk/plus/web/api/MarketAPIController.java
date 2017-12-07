package com.bnk.plus.web.api;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bnk.plus.commons.components.CoTopComponent;
import com.bnk.plus.entity.Market;
import com.bnk.plus.service.dealer.service.MarketService;

@Controller
@RequestMapping(value = {"/api/market"})
public class MarketAPIController extends CoTopComponent {
	
	@Autowired
	MarketService marketService;
	
	//매매단지 리스트 조회
	@RequestMapping(value={"/region/list"}, method = RequestMethod.GET, produces = "text/html; charset=utf-8")
	public @ResponseBody ResponseEntity<Object> marketRegionList(Market market, HttpServletRequest req, HttpServletResponse res){
		mlog_usual.debug(" :: Load marketList Page.");
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		String resultCode = "00";
		try{
			// 2017-08-02 매매단지 리스트 수정
			if(market != null){
				if(!"".equals(market.getDanjisido())){
					String[] marketArr = market.getDanjisido().split("\\,");
					if(marketArr.length > 0){
						market.setDanjiArr(marketArr);
					}else{
						marketArr = new String[1];
						marketArr[0] = market.getDanjisido();
						market.setDanjiArr(marketArr);
					}
				}
			}
			resultMap.put("data", marketService.selectMarket(market, MarketService.SELECT_TYPE_SEARCH));
		}catch(Exception e){
			e.printStackTrace();
			resultCode = "99";
		}
		resultMap.put("code", resultCode);
		return makeJsonResponseHeader(resultMap);  
	}
	
}
