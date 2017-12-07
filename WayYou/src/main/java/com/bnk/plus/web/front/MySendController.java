package com.bnk.plus.web.front;

import java.util.HashMap;
import java.util.List;
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

import com.bnk.plus.commons.CoConstDef;
import com.bnk.plus.commons.components.CoTopComponent;
import com.bnk.plus.entity.CarCost;
import com.bnk.plus.entity.CheckListHis;
import com.bnk.plus.entity.SndPush;
import com.bnk.plus.entity.T2Users;
import com.bnk.plus.service.api.SndService;
import com.bnk.plus.service.car.service.UserApiService;
import com.bnk.plus.service.my.service.MyService;
import com.bnk.plus.service.transmit.service.TransmitService;

@Controller
@RequestMapping(value = {"/front/my"})
public class MySendController extends CoTopComponent {

	private final String tilesPrefix = "tiles.front.my.";

	@Autowired TransmitService transmitService;
	@Autowired MyService myService;
	@Autowired SndService sndService;
	@Autowired UserApiService userApiService;

	//체크리스트 - 일반
	@RequestMapping(value={"/checkList"}, method = RequestMethod.GET, produces = "text/html; charset=utf-8")
	public String check_list(HttpServletRequest req, HttpServletResponse res, Model model){
		mlog_usual.debug(" :: Load check_list Page.");
		userApiService.updateReadFlag("checkList");
		return tilesPrefix+"check_list.check_list";
	}

	//[딜러]명함발송관리
	@RequestMapping(value={"/businesscard"}, method = RequestMethod.GET, produces = "text/html; charset=utf-8")
	public String my_businesscard(HttpServletRequest req, HttpServletResponse res, Model model){
		mlog_usual.debug(" :: Load businesscard Page.");
		return tilesPrefix+"businesscard.businesscard";
	}
	//[딜러]명함발송관리 리스트
	@RequestMapping(value={"/businesscard/list"}, method = RequestMethod.POST, produces = "text/html; charset=utf-8")
	public ResponseEntity<Object> businesscardList(@RequestBody T2Users t2Users, HttpServletRequest req, HttpServletResponse res, Model model){
		mlog_usual.debug(" :: Load businesscardList Page.");
		Map<String, Object> resMap  = new HashMap<>();
		String resCd = "00";
		try{
			resMap = myService.setBusinessCardList(t2Users);
		}catch (Exception e) {
			resCd = "99";
		}
		resMap.put("resCd", resCd);
		return makeJsonResponseHeader(resMap);
	}

	//[딜러]명함 재발송 하기
	@RequestMapping(value={"/businesscard/reSend"}, method = RequestMethod.POST, produces = "text/html; charset=utf-8")
	public ResponseEntity<Object> businesscardReSend(@RequestBody T2Users t2Users, HttpServletRequest req, HttpServletResponse res, Model model){
		mlog_usual.debug(" :: Load businesscard_resend");
		HashMap<String, Object> resMap  = new HashMap<>();
		String resCd = "00";

		try {
			myService.reSendBusinesscard(t2Users);
		} catch (Exception e) {
			resCd = "99";
		}

		// push namecard
		if("00".equals(resCd) && !isEmpty(t2Users.getUserId())) {
			SndPush sndParam = new SndPush(CoConstDef.CD_SND_PUSH_NAMECARD);
			sndParam.setParamUserId(t2Users.getUserId());
			sndService.sndPush(sndParam);
		}

		resMap.put("resCd", resCd);
		return makeJsonResponseHeader(resMap);
	}
	//[딜러]명함 관리
	@RequestMapping(value={"/businesscardEdit"}, method = RequestMethod.GET, produces = "text/html; charset=utf-8")
	public String businesscardEdit(HttpServletRequest req, HttpServletResponse res, Model model){
		mlog_usual.debug(" :: Load businesscardEdit");
		return tilesPrefix+"businesscard.businesscard_edit";
	}
	//견적발송관리 - 딜러
	@RequestMapping(value={"/sendQuotation"}, method = RequestMethod.GET, produces = "text/html; charset=utf-8")
	public String send_quotation(HttpServletRequest req, HttpServletResponse res, Model model){
		mlog_usual.debug(" :: Load send_quotation Page.");
		return tilesPrefix+"send_quotation.send_quotation";
	}

	//체크리스트 - 딜러
	@RequestMapping(value={"/checkDealer"}, method = RequestMethod.GET, produces = "text/html; charset=utf-8")
	public String my_check_dealer(HttpServletRequest req, HttpServletResponse res, Model model){
		mlog_usual.debug(" :: Load check_dealer Page.");
		return tilesPrefix+"check_dealer.check_dealer";
	}

	//체크리스트 - 데이터 가져오기
	@RequestMapping(value={"/checkDealer/ajax"}, produces = "text/html; charset=utf-8")
	public @ResponseBody ResponseEntity<Object> pushUserList(@RequestBody CheckListHis cls,HttpServletRequest req, HttpServletResponse res){
		mlog_usual.debug(" :: Load checkDealer ajax.");
		HashMap<String, Object> resMap = new HashMap<String, Object>();
		String resCd = "00";
		try{
			List<CheckListHis> list = transmitService.checkDealerList(cls);
			resMap.put("data", list);

		}catch(Exception e){
			e.printStackTrace();
			resCd = "99";
		}
		resMap.put("resCd", resCd);
		return makeJsonResponseHeader(resMap);
	}

	//체크리스트등록
	@RequestMapping(value={"/checkList/register"}, method = RequestMethod.POST, produces = "text/html; charset=utf-8")
	public @ResponseBody ResponseEntity<Object> check_register(@RequestBody CheckListHis cls, HttpServletRequest req, HttpServletResponse res){
		mlog_usual.debug(" :: Load checkList Page.");
		HashMap<String, Object> resMap = new HashMap<String, Object>();
		String resCd = "00";
		try{
			cls.setDealerId(loginUserName());	// 세션아이디를 딜러아이디에 넣는다.
			transmitService.checkRegister(cls);
		}catch(Exception e){
			e.printStackTrace();
			resCd = "99";
		}

		// push checklist
		if("00".equals(resCd) && !isEmpty(cls.getUserId())) {
			SndPush sndParam = new SndPush(CoConstDef.CD_SND_PUSH_CHECKLIST);
			sndParam.setParamUserId(cls.getUserId());
			sndService.sndPush(sndParam);
		}
		resMap.put("resCd", resCd);
		return makeJsonResponseHeader(resMap);
	}

	//명함등록
	@RequestMapping(value={"/namecard/register"}, method = RequestMethod.POST, produces = "text/html; charset=utf-8")
	public @ResponseBody ResponseEntity<Object> namecard_register(@RequestBody CheckListHis cls, HttpServletRequest req, HttpServletResponse res){
		mlog_usual.debug(" :: Load mstList Page.");
		HashMap<String, Object> resMap = new HashMap<String, Object>();
		String resCd = "00";
		try{
			cls.setDealerId(loginUserName());	// 세션아이디를 딜러아이디에 넣는다.
			transmitService.namecardRegister(cls);
		}catch(Exception e){
			e.printStackTrace();
			resCd = "99";
		}
		// push namecard
		if("00".equals(resCd) && !isEmpty(cls.getUserId())) {
			SndPush sndParam = new SndPush(CoConstDef.CD_SND_PUSH_NAMECARD);
			sndParam.setParamUserId(cls.getUserId());
			sndService.sndPush(sndParam);
		}
		resMap.put("resCd", resCd);
		return makeJsonResponseHeader(resMap);
	}
	//비용등록
    @RequestMapping(value={"/cost/register"}, method = RequestMethod.POST, produces = "text/html; charset=utf-8")
    public @ResponseBody ResponseEntity<Object> cost_register(@RequestBody CarCost carCost, HttpServletRequest req, HttpServletResponse res){
        mlog_usual.debug(" :: Load register Page.");
        HashMap<String, Object> resMap = new HashMap<String, Object>();
        String resCd = "00";
        try{
            carCost.setDealerId(loginUserName());   // 세션아이디를 딜러아이디에 넣는다.
            transmitService.costRegister(carCost);

        }catch(Exception e){
            e.printStackTrace();
            resCd = "99";
        }
		// push
		if("00".equals(resCd) && !isEmpty(carCost.getUserId())) {
			// 구매비용이 도작하였습니다.
			SndPush sndParam = new SndPush(CoConstDef.CD_SND_PUSH_CALC);
			sndParam.setParamUserId(carCost.getUserId());
			sndService.sndPush(sndParam);
		}
        resMap.put("resCd", resCd);
        return makeJsonResponseHeader(resMap);
    }

	//수신함 - 데이터 가져오기
    @RequestMapping(value={"/checkList/ajax"}, produces = "text/html; charset=utf-8")
    public @ResponseBody ResponseEntity<Object> checkList(@RequestBody CheckListHis cls,HttpServletRequest req, HttpServletResponse res){
        mlog_usual.debug(" :: Load checkList ajax.");
        HashMap<String, Object> resMap = new HashMap<String, Object>();
        String resCd = "00";
        try{
            List<CheckListHis> list = transmitService.checkList(cls);
            resMap.put("data", list);

        }catch(Exception e){
            e.printStackTrace();
            resCd = "99";
        }
        resMap.put("resCd", resCd);
        return makeJsonResponseHeader(resMap);
    }

    //비용 가져오기
    @RequestMapping(value = {"/searchCostDeatil"}, method = {RequestMethod.GET,RequestMethod.POST}, produces = "text/html; charset=utf-8")
    public @ResponseBody ResponseEntity<Object> searchCostDeatil(@RequestBody CarCost carCost, HttpServletRequest req, HttpServletResponse res,Model model){
        mlog_usual.debug(" :: Load searchCostDeatil ajax.");
        HashMap<String, Object> resMap = new HashMap<String, Object>();

        try {
            resMap  = transmitService.getCostDetail(carCost);
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }

        return makeJsonResponseHeader(resMap);
    }

	//비용계산 발송관리 - 데이터 가져오기
    @RequestMapping(value={"/costList/ajax"}, produces = "text/html; charset=utf-8")
    public @ResponseBody ResponseEntity<Object> costList( String carPlateNum,HttpServletRequest req, HttpServletResponse res){
        mlog_usual.debug(" :: Load checkList ajax.");
        HashMap<String, Object> resMap = new HashMap<String, Object>();
        CarCost carCost = new CarCost();
        String resCd = "00";
        try{
        	carCost.setCarPlateNum(carPlateNum);
        	System.out.println("carCost = " + carPlateNum);
        	carCost.setDealerId(loginUserName());	// 세션아이디를 딜러아이디에 넣는다.
            List<CarCost> list = transmitService.selectCostList(carCost);
            resMap.put("data", list);

        }catch(Exception e){
            e.printStackTrace();
            resCd = "99";
        }
        resMap.put("resCd", resCd);
        return makeJsonResponseHeader(resMap);
    }

}
