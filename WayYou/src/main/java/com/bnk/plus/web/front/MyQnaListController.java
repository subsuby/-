package com.bnk.plus.web.front;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bnk.plus.commons.components.CoTopComponent;
import com.bnk.plus.entity.My;
import com.bnk.plus.service.car.service.UserApiService;
import com.bnk.plus.service.my.service.MyService;

@Controller
@RequestMapping(value = {"/front/my"})
public class MyQnaListController extends CoTopComponent {
	private final String tilesPrefix = "tiles.front.my.";

	@Autowired
	MyService myService;
	@Autowired UserApiService userApiService;

	//문의내역관리 - 일반
	@RequestMapping(value={"/qnaList"}, method = RequestMethod.GET, produces = "text/html; charset=utf-8")
	public String qna_list(HttpServletRequest req, HttpServletResponse res, Model model){
		mlog_usual.debug(" :: Load qna_list Page.");
		userApiService.updateReadFlag("qnaList");
		return tilesPrefix+"qna_list.qna_list";
	}

	//문의내역 리스트
	@RequestMapping(value={"/qnaList/ajax"}, method = RequestMethod.POST, produces = "text/html; charset=utf-8")
	public @ResponseBody ResponseEntity<Object> qna_list_Ajax(@RequestBody My my, HttpServletRequest req, HttpServletResponse res, Model model){
		mlog_usual.debug(" :: Load qna_list Page.");

		Map<String, Object> resMap = new HashMap<>();
		String resCd = "00";

		try{
			resMap = myService.getQnaList(my);
		}catch (Exception e) {
			resCd = "99";
		}

		resMap.put("resCd", resCd);
		return makeJsonResponseHeader(resMap);
	}

	//문의 등록
	@RequestMapping(value={"/qnaList/regist"}, method = RequestMethod.POST, produces = "text/html; charset=utf-8")
	public @ResponseBody ResponseEntity<Object> questionSaveAjax(@RequestBody My my, HttpServletRequest req, HttpServletResponse res, Model model){
		log_usual.debug(" :: Start qnaSaveAjax");
		HashMap<String, Object> resMap  = new HashMap<>();
		String resCd = "00";

		try {
			myService.registFrontQuestion(my);
		} catch (Exception e) {
			resCd = "99";
		}

		resMap.put("resCd", resCd);
		return makeJsonResponseHeader(resMap);
	}
}
