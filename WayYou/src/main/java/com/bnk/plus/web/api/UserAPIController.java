package com.bnk.plus.web.api;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bnk.plus.commons.CoConstDef;
import com.bnk.plus.commons.components.CoTopComponent;
import com.bnk.plus.entity.Car;
import com.bnk.plus.entity.FalseCar;
import com.bnk.plus.entity.ResHis;
import com.bnk.plus.entity.SndPush;
import com.bnk.plus.entity.T2Users;
import com.bnk.plus.service.api.SndService;
import com.bnk.plus.service.car.service.UserApiService;

@Controller
@RequestMapping(value = {"/api/user"})
public class UserAPIController extends CoTopComponent {

	@Autowired UserApiService userApiService;
	@Autowired SndService sndService;

	//로그인 체크
	@RequestMapping(value = {"/loginCheck"}, method = RequestMethod.GET, produces = "text/html; charset=utf-8")
	public ResponseEntity<Object> loginCheck(HttpServletRequest req, HttpServletResponse res) {
		mlog_usual.debug(" :: Load Login Check.");
		HashMap<String, Object> resMap = new HashMap<String, Object>();
		HashMap<String, Object> dataMap = new HashMap<String, Object>();
		String resCd = "00";
		String loginYn = "";
		try{
			loginYn = isLogin() ? "Y" : "N";
			dataMap.put("loginYn", loginYn);
			dataMap.put("sessUserInfo", loginUserInfo());
			dataMap.put("newDataInfo", userApiService.getUserHasNotiData(loginUserName()));
		}catch(Exception e){
			resCd = "99";
		}
		resMap.put("code", resCd);
		resMap.put("data", dataMap);
		return makeJsonResponseHeader(resMap);
	}

	//찜하기
	@RequestMapping(value={"/dibsOn/{carSeq}"}, method = RequestMethod.POST, produces = "text/html; charset=utf-8")
	public @ResponseBody ResponseEntity<Object> dibsOnCar(@PathVariable String carSeq, Car car, HttpServletRequest req, HttpServletResponse res){
		mlog_usual.debug(" :: Load mstList Page.");
		HashMap<String, Object> resMap = new HashMap<String, Object>();
		String resCd = "00";
		try{
			userApiService.dibsOn(car);
		}catch(Exception e){
			resCd = "99";
		}
		resMap.put("resCd", resCd);
		return makeJsonResponseHeader(resMap);
	}
	//관심딜러등록/삭제
	@RequestMapping(value={"/interestDealer/{userId}"}, method = RequestMethod.POST, produces = "text/html; charset=utf-8")
	public @ResponseBody ResponseEntity<Object> dibsOnDealer(@PathVariable String userId, Car car, HttpServletRequest req, HttpServletResponse res){
		mlog_usual.debug(" :: Load mstList Page.");
		HashMap<String, Object> resMap = new HashMap<String, Object>();
		String resCd = "00";
		try{
			userApiService.toggleInterestDealer(car);
		}catch(Exception e){
			e.printStackTrace();
			resCd = "99";
		}
		resMap.put("resCd", resCd);
		return makeJsonResponseHeader(resMap);
	}
	//Page View Count
	@RequestMapping(value={"/viewCnt/{carSeq}"}, method = RequestMethod.POST, produces = "text/html; charset=utf-8")
	public @ResponseBody ResponseEntity<Object> incViewCnt(@PathVariable String carSeq, Car car, HttpServletRequest req, HttpServletResponse res){
		mlog_usual.debug(" :: Load mstList Page.");
		HashMap<String, Object> resMap = new HashMap<String, Object>();
		String resCd = "00";
		try{
			userApiService.incViewCnt(car);
		}catch(Exception e){
			e.printStackTrace();
			resCd = "99";
		}
		resMap.put("resCd", resCd);
		return makeJsonResponseHeader(resMap);
	}
	//차량매물시세정보 가져오기
	@RequestMapping(value={"/bnkPriceInfo"}, method = RequestMethod.POST, produces = "text/html; charset=utf-8")
	public @ResponseBody ResponseEntity<Object> getBnkPriceInfo(@RequestBody Car car, HttpServletRequest req, HttpServletResponse res){
		mlog_usual.debug(" :: Load bnkPriceInfo.");
		HashMap<String, Object> resMap = new HashMap<String, Object>();
		String resCd = "00";
		try{
			resMap.put("info", userApiService.getBnkPriceInfo(car));
		}catch(Exception e){
			e.printStackTrace();
			resCd = "99";
		}
		resMap.put("resCd", resCd);
		return makeJsonResponseHeader(resMap);
	}
	//딜러프로필정보 가져오기
	@RequestMapping(value={"/dealerProfileInfo"}, method = RequestMethod.POST, produces = "text/html; charset=utf-8")
	public @ResponseBody ResponseEntity<Object> getDealerProfileInfo(@RequestBody Car car, HttpServletRequest req, HttpServletResponse res){
		mlog_usual.debug(" :: Load dealerProfileInfo.");
		HashMap<String, Object> resMap = new HashMap<String, Object>();
		String resCd = "00";
		try{
			T2Users user = userApiService.getDealerProfileInfo(car);
			if(user != null) {
				user.remakeDealerPhone(true);
			}
			resMap.put("user", user);
		}catch(Exception e){
			e.printStackTrace();
			resCd = "99";
		}
		resMap.put("resCd", resCd);
		return makeJsonResponseHeader(resMap);
	}
	//딜러프로필정보 가져오기
	@RequestMapping(value={"/dealerEvalList"}, method = RequestMethod.POST, produces = "text/html; charset=utf-8")
	public @ResponseBody ResponseEntity<Object> getDealerEvalList(@RequestBody Car car, HttpServletRequest req, HttpServletResponse res){
		mlog_usual.debug(" :: Load dealerEvalList.");
		HashMap<String, Object> resMap = new HashMap<String, Object>();
		String resCd = "00";
		try{
			resMap.putAll(userApiService.getDealerEvalList(car));
		}catch(Exception e){
			e.printStackTrace();
			resCd = "99";
		}
		resMap.put("resCd", resCd);
		return makeJsonResponseHeader(resMap);
	}
	//딜러프로필정보 가져오기
	@RequestMapping(value={"/registDealerEval"}, method = RequestMethod.POST, produces = "text/html; charset=utf-8")
	public @ResponseBody ResponseEntity<Object> registDealerEval(@RequestBody T2Users t2Users, HttpServletRequest req, HttpServletResponse res){
		mlog_usual.debug(" :: Load registDealerEval.");
		HashMap<String, Object> resMap = new HashMap<String, Object>();
		String resCd = "00";
		try{
			userApiService.registDealerEval(t2Users);
		}catch(Exception e){
			e.printStackTrace();
			resCd = "99";
		}
		resMap.put("resCd", resCd);
		return makeJsonResponseHeader(resMap);
	}
	//푸시전송용 회원정보 가져오기
	@RequestMapping(value={"/pushUserList"}, produces = "text/html; charset=utf-8")
	public @ResponseBody ResponseEntity<Object> pushUserList(String searchTxt, HttpServletRequest req, HttpServletResponse res){
		mlog_usual.debug(" :: Load pushUserList Page.");
		HashMap<String, Object> resMap = new HashMap<String, Object>();
		String resCd = "00";
		try{
			List<T2Users> list = userApiService.pushUserList(searchTxt);
			resMap.put("data", list);

		}catch(Exception e){
			e.printStackTrace();
			resCd = "99";
		}
		resMap.put("resCd", resCd);
		return makeJsonResponseHeader(resMap);
	}

	//방문,시승,탁송 예약 요청
	@RequestMapping(value={"/registCarReserve"}, method = RequestMethod.POST, produces = "text/html; charset=utf-8")
	public @ResponseBody ResponseEntity<Object> registCarReserve(@RequestBody Map<String, String> params, HttpServletRequest req, HttpServletResponse res){
		mlog_usual.debug(" :: Load requestCarReserve.");
		Map<String, String> resMap = new HashMap<>();
		String resCd = "00";
		try{
			int rows = userApiService.registResHis(params);
			if(rows >= 3){
				resCd = "10";	//예약 갯수 초과
			}else if(rows == -1){
				resCd = "11";	//중복된 매물
			}
		} catch(Exception e){
			e.printStackTrace();
			resCd = "99";
		}

		// push는 서비스에서

		resMap.put("resCd", resCd);

		return makeJsonResponseHeader(resMap);
	}

	//방문,시승,탁송 예약 취소
	@RequestMapping(value={"/cancelCarReserve"}, method = RequestMethod.POST, produces = "text/html; charset=utf-8")
	public @ResponseBody ResponseEntity<Object> cancelCarReserve(@RequestBody Map<String, String> params, HttpServletRequest req, HttpServletResponse res){
		mlog_usual.debug(" :: Load requestCarReserve.");
		Map<String, String> resMap = new HashMap<>();
		String resCd = "00";

		if(params.containsKey("resHisSeq") && !isEmpty(params.get("resHisSeq"))) {
			try{
				userApiService.cancelCarReserve(params);
			} catch(Exception e){
				e.printStackTrace();
				resCd = "99";
			}

			// push는 service단에서 처리

		}



		resMap.put("resCd", resCd);

		return makeJsonResponseHeader(resMap);
	}
	//방문,시승,탁송 예약 승인, 거절
	@RequestMapping(value={"/requestCarReserve"}, method = RequestMethod.POST, produces = "text/html; charset=utf-8")
	public @ResponseBody ResponseEntity<Object> requestCarReserve(@RequestBody Map<String, String> params, HttpServletRequest req, HttpServletResponse res){
		mlog_usual.debug(" :: Load requestCarReserve.");
		Map<String, String> resMap = new HashMap<>();
		String resCd = "00";
		try{
			userApiService.requestCarReserve(params);
		} catch(Exception e){
			e.printStackTrace();
			resCd = "99";
		}

		resMap.put("resCd", resCd);

		return makeJsonResponseHeader(resMap);
	}

	//명함정보 가져오기
	@RequestMapping(value={"/nameCardProfileInfo"}, method = RequestMethod.POST, produces = "text/html; charset=utf-8")
	public @ResponseBody ResponseEntity<Object> getNameCardProfileInfo(HttpServletRequest req, HttpServletResponse res){
		mlog_usual.debug(" :: Load nameCardProfileInfo.");
		HashMap<String, Object> resMap = new HashMap<String, Object>();
		String resCd = "00";
		try{
			if(isLogin()){
				if("D".equals(loginUserInfo().getDivision())){
					T2Users user = userApiService.getNameCardProfileInfo(loginUserName());
					resMap.put("user", user);
				}else{
					resCd = "99";
				}
			}else{
				resCd = "99";
			}
		}catch(Exception e){
			e.printStackTrace();
			resCd = "99";
		}
		resMap.put("resCd", resCd);
		return makeJsonResponseHeader(resMap);
	}

	//명함정보 수정하기
	@RequestMapping(value={"/modifyNameCard"}, method = RequestMethod.POST, produces = "text/html; charset=utf-8")
	public @ResponseBody ResponseEntity<Object> modifyNameCard(@RequestBody T2Users t2Users, HttpServletRequest req, HttpServletResponse res){
		mlog_usual.debug(" :: Load modifyNameCard.");
		HashMap<String, Object> resMap = new HashMap<String, Object>();
		String resCd = "00";
		try{
			userApiService.modifyNameCard(t2Users);
		}catch(Exception e){
			e.printStackTrace();
			resCd = "99";
		}
		resMap.put("resCd", resCd);
		return makeJsonResponseHeader(resMap);
	}

	// 현장서비스 - 딜러프로필정보 가져오기
	@RequestMapping(value={"/dealerProfileList"}, method = RequestMethod.POST, produces = "text/html; charset=utf-8")
	public @ResponseBody ResponseEntity<Object> dealerProfileList(String lat, String lag, HttpServletRequest req, HttpServletResponse res){
		mlog_usual.debug(" :: Load registDealerEval.");
		HashMap<String, Object> resMap = new HashMap<String, Object>();
		HashMap<String, Object> searchMap = new HashMap<String, Object>();

		searchMap.put("lat", lat);
		searchMap.put("lag", lag);

		String resCd = "00";
		try{
			resMap.put("data", userApiService.selectDealerProfileList(searchMap));
		}catch(Exception e){
			e.printStackTrace();
			resCd = "99";
		}
		resMap.put("resCd", resCd);
		return makeJsonResponseHeader(resMap);
	}

	// 허위매물신고 등록 여부 확인
	@RequestMapping(value={"/selectFakeReport"}, method = RequestMethod.POST, produces = "text/html; charset=utf-8")
	public @ResponseBody ResponseEntity<Object> selectFakeReport(@RequestBody FalseCar car, HttpServletRequest req, HttpServletResponse res){
		mlog_usual.debug(" :: Load mstList Page.");
		HashMap<String, Object> resMap = new HashMap<String, Object>();
		String resCd = "00";
		int result = 0;
		try{
			result = userApiService.selectFakeReport(car);

			if(result == 0){
				resCd = "11";	// 등록된 허위매물이 없다.
			}
		}catch(Exception e){
			System.out.println(e.getMessage());
			resCd = "99";
		}
		resMap.put("resCd", resCd);
		return makeJsonResponseHeader(resMap);
	}

	// 허위매물신고 등록
	@RequestMapping(value={"/insFakeReport"}, method = RequestMethod.POST, produces = "text/html; charset=utf-8")
	public @ResponseBody ResponseEntity<Object> insFakeReport(@RequestBody FalseCar car, HttpServletRequest req, HttpServletResponse res){
		mlog_usual.debug(" :: Load mstList Page.");
		HashMap<String, Object> resMap = new HashMap<String, Object>();
		String resCd = "00";
		try{
			userApiService.insFakeReport(car);
		}catch(Exception e){
			System.out.println(e.getMessage());
			resCd = "99";
		}
		resMap.put("resCd", resCd);
		return makeJsonResponseHeader(resMap);
	}

	//방문,시승,탁송 예약 승인, 예약시간 저장
	@RequestMapping(value={"/requestTimeReserve"}, method = RequestMethod.POST, produces = "text/html; charset=utf-8")
	public @ResponseBody ResponseEntity<Object> requestTimeReserve(@RequestBody ResHis resHis, HttpServletRequest req, HttpServletResponse res){
		mlog_usual.debug(" :: Load requestTimeReserve.");
		Map<String, String> resMap = new HashMap<>();
		String resCd = "00";
		try{
			userApiService.requestTimeReserve(resHis);
		} catch(Exception e){
			e.printStackTrace();
			resCd = "99";
		}

		resMap.put("resCd", resCd);

		return makeJsonResponseHeader(resMap);
	}


	//방문,시승,탁송 예약 승인, 예약시간 상태값 변경
	@RequestMapping(value={"/requestReserveStatus"}, method = RequestMethod.POST, produces = "text/html; charset=utf-8")
	public @ResponseBody ResponseEntity<Object> requestReserveStatus(@RequestBody ResHis resHis, HttpServletRequest req, HttpServletResponse res){
		mlog_usual.debug(" :: Load requestReserveStatus.");
		Map<String, String> resMap = new HashMap<>();
		String resCd = "00";
		try{
			userApiService.requestReserveStatus(resHis);
		} catch(Exception e){
			e.printStackTrace();
			resCd = "99";
		}

		resMap.put("resCd", resCd);

		return makeJsonResponseHeader(resMap);
	}

}
