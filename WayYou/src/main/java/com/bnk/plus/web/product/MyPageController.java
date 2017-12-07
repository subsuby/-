package com.bnk.plus.web.product;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.StandardPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.ObjectUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bnk.plus.commons.CoCommonFunc;
import com.bnk.plus.commons.CoConstDef;
import com.bnk.plus.commons.components.CoTopComponent;
import com.bnk.plus.commons.util.StringUtil;
import com.bnk.plus.config.AppConstBean;
import com.bnk.plus.entity.Car;
import com.bnk.plus.entity.CarCost;
import com.bnk.plus.entity.CarMarketInfoShop;
import com.bnk.plus.entity.CheckListHis;
import com.bnk.plus.entity.Makeup;
import com.bnk.plus.entity.My;
import com.bnk.plus.entity.ResHis;
import com.bnk.plus.entity.Reserve;
import com.bnk.plus.entity.SndPush;
import com.bnk.plus.entity.T2File;
import com.bnk.plus.entity.T2Users;
import com.bnk.plus.service.api.FileService;
import com.bnk.plus.service.api.SndService;
import com.bnk.plus.service.car.service.CarDealerBIGService;
import com.bnk.plus.service.car.service.CarMarketInfoService;
import com.bnk.plus.service.car.service.CarMstService;
import com.bnk.plus.service.car.service.UserApiService;
import com.bnk.plus.service.estimate.service.EstimateService;
import com.bnk.plus.service.my.service.MyService;
import com.bnk.plus.service.session.service.T2UserService;
import com.bnk.plus.service.transmit.service.TransmitService;

@Controller
@RequestMapping(value = {"/product/mypage"})
public class MyPageController extends CoTopComponent {

	private final String tilesPrefix = "tiles.product.mypage.";

	@Resource
	private Environment env;

	@Autowired
    T2UserService t2UserService;

	@Autowired
	CarMstService carMstService;

	@Autowired
	FileService fileService;

	@Autowired
	CarDealerBIGService carDealerBIGService;

	@Autowired
	EstimateService estimateService;

	@Autowired UserApiService userApiService;

	@Autowired
    CarMarketInfoService carMarketInfoService;

	@Autowired TransmitService transmitService;

	@Autowired
	MyService myService;

	@Autowired SndService sndService;

	//마이카 - 일반
	@RequestMapping(value={"/mycarPerson"}, produces = "text/html; charset=utf-8")
	public String mycar(Car car,HttpServletRequest req, HttpServletResponse res, Model model){
		mlog_usual.debug(" :: Load mycar_person Page.");
		String navVal = StringUtil.nvl(req.getParameter("navVal"));
		model.addAttribute("val", navVal);
		userApiService.updatePcReadFlag("mycar");
		return tilesPrefix+"person.mycar";
	}

    //내게맞는매물 - 등록조건 리스트
    @RequestMapping(value={"/mycarPersonSaleCar/AJAX"}, method = RequestMethod.GET, produces = "text/html; charset=utf-8")
    public String mycarPersonSaleCar(Car car, HttpServletRequest req, HttpServletResponse res, Model model){
        mlog_usual.debug(" :: Load sale_list_Ajax Page.");
        Map<String, Object> resMap = new HashMap<>();

        List<Car> carList = new ArrayList<Car>();
        try {
            int curPage = car.getCurPage();
            car = myService.getReverseAuctionInfo(car);
            model.addAttribute("car",car);

            if(!ObjectUtils.isEmpty(car)){
                car.setSchType(CarMstService.SELECT_TYPE_REAUCTION);
                car.setPageListSize(8);		//페이징 제거 2017-09-06 KFC 요청
                car.setCurPage(curPage);

                resMap = carMstService.selectCarModel(car);
                carList = (List<Car>) resMap.get("list");
                if(carList.size() != 0){
                    carList.get(0).setTotListSize(Integer.parseInt(resMap.get("totListSize").toString()));
                    model.addAttribute("totPages" , carList.get(0).getTotBlockSize());
                }
            }else{
                model.addAttribute("totPages" , 0);
            }

            model.addAttribute("recommend", carList);
            model.addAttribute("curPage"  , curPage);
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }

        return tilesAjaxPrefix+"mypage.person.AJAX.sale_list_ajax";
    }

    //내게맞는매물 수정버튼 클릭 시 화면으로 이동 할 때
    @RequestMapping(value = {"/mycarPersonGetReserve"}, method = RequestMethod.POST, produces = "text/html; charset=utf-8")
    public @ResponseBody ResponseEntity<Object> mycarPersonGetReserve(Car car, HttpServletRequest req, HttpServletResponse res, Model model){
        mlog_usual.debug(" :: Load mycarPersonInsertReserve");
        HashMap<String, Object> resMap = new HashMap<>();

        try {
            car = myService.getReverseAuctionInfo(car);
            resMap.put("car", car);
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return makeJsonResponseHeader(resMap);
    }

  //내게맞는매물 삭제
    @RequestMapping(value  = {"/mycarPersonDeleteRecommend"}, method = RequestMethod.POST, produces = "text/html; charset=utf-8")
    public @ResponseBody ResponseEntity<Object> mycarPersonDeleteRecommend(@RequestBody Car car, HttpServletRequest req, HttpServletResponse res, Model model){
        mlog_usual.debug(" :: Load mycarPersonDeleteRecommend");
        HashMap<String, Object> resMap = new HashMap<>();
        String resCd = "00";

        try {
            myService.deleteReverseAuctionInfo(car);
            resMap.put("resCd", resCd);
        } catch (Exception e) {
            resCd = "99";
            resMap.put("resCd", resCd);
        }

        return makeJsonResponseHeader(resMap);
    }

    //내게맞는매물 등록
    @RequestMapping(value = {"/mycarPersonInsertReserve"}, method = RequestMethod.POST, produces = "text/html; charset=utf-8")
    public @ResponseBody ResponseEntity<Object> mycarPersonInsertReserve(@RequestBody Car car, HttpServletRequest req, HttpServletResponse res, Model model){
        mlog_usual.debug(" :: Load mycarPersonInsertReserve");
        HashMap<String, Object> resMap = new HashMap<>();

        try {
            myService.registReverseAuction(car);
        } catch (Exception e) {
            // TODO Auto-generated catch block
        }

        return makeJsonResponseHeader(resMap);
    }

    //내게맞는매물 수정
    @RequestMapping(value = {"/mycarPersonModifyReserve"}, method = RequestMethod.POST, produces = "text/html; charset=utf-8")
    public @ResponseBody ResponseEntity<Object> mycarPersonModifyReserve(@RequestBody Car car, HttpServletRequest req, HttpServletResponse res, Model model){
        mlog_usual.debug(" :: Load mycarPersonModifyReserve");
        HashMap<String, Object> resMap = new HashMap<>();

        try {
            myService.modifyReverseAuctionInfo(car);
        } catch (Exception e) {
            // TODO Auto-generated catch block
        }

        return makeJsonResponseHeader(resMap);
    }

    //방문/시승/탁송 리스트
    @RequestMapping(value = {"/mycarPersonReserveList/AJAX"}, method = RequestMethod.GET, produces="text/html; charset=utf-8")
    public String mycarPersonReserveList(Reserve reserve, HttpServletRequest req, HttpServletResponse res, Model model){
        mlog_usual.debug(" :: Load sale_list_Ajax Page.");
        Map<String, Object> resMap = new HashMap<>();

        try {
            resMap = myService.getPersonReserveList(reserve);
            model.addAllAttributes(resMap);

        } catch (Exception e) {
            e.printStackTrace();
        }

        return tilesAjaxPrefix+"mypage.person.AJAX.reserve_list_ajax";
    }

	//마이카 - 일반 - 추천차량
	@RequestMapping(value={"/mycarPersonRecommend/AJAX"}, produces = "text/html; charset=utf-8")
	public String mycarPersonRecommend(Car car,HttpServletRequest req, HttpServletResponse res, Model model){
		mlog_usual.debug(" :: Load mycar_person_recommend Page.");

		Map<String, Object> resMap = new HashMap<>();
		List<Car> carList = new ArrayList<Car>();
		try {
			int curPage = car.getCurPage();
            car = myService.getReverseAuctionInfo(car);

            if(!ObjectUtils.isEmpty(car)){
                car.setSchType(CarMstService.SELECT_TYPE_RECOMMEND);
                car.setPageListSize(4);
                car.setCurPage(curPage);

                resMap = carMstService.selectCarModel(car);
                carList = (List<Car>) resMap.get("list");
                if(carList.size() != 0){
                    carList.get(0).setTotListSize(Integer.parseInt(resMap.get("totListSize").toString()));
                    model.addAttribute("totPages" , carList.get(0).getTotBlockSize());
                }
            }else{
                model.addAttribute("totPages" , 0);
            }

            model.addAttribute("recommend", carList);
            model.addAttribute("curPage"  , curPage);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return tilesAjaxPrefix+"mypage.person.AJAX.recommend_list_ajax";

	}
    //마이카 - 일반 - 마이카
    @RequestMapping(value={"/mycarPersonMyCar/AJAX"}, produces = "text/html; charset=utf-8")
    public String mycarPersonMyCar(Car car,HttpServletRequest req, HttpServletResponse res, Model model){
        mlog_usual.debug(" :: Load mycar_person_mycar Page.");

        try {
        	Map<String, Object> resMap = carMstService.getMyCarList(car);
        	if(resMap != null){
        		model.addAllAttributes(resMap);
        		model.addAttribute("arr",toJson(resMap));
        	}
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }

        return tilesAjaxPrefix+"mypage.person.AJAX.mycar_list_ajax";
    }
    //마이카 - 일반 - 마이카 하위
    @RequestMapping(value={"/mycarPersonMyCarSub/AJAX"}, produces = "text/html; charset=utf-8")
    public String mycarPersonMyCarSub(@RequestBody Map<String, Object> data, Car car,HttpServletRequest req, HttpServletResponse res, Model model){
    	mlog_usual.debug(" :: Load mycar_person_mycar_sub Page.");
    	try {
    		BeanUtils.populate(car, data);
    		Car myCar = carMstService.selectMyCarMstInfo(car.getMycarSeq());
			Map<String, Object> myCarPrice = userApiService.getBnkPriceInfo(myCar);
			model.addAttribute("myCar", car);
			model.addAttribute("myCarArr", toJson(car));
			model.addAttribute("myCarPrice", myCarPrice);
			model.addAttribute("myCarPriceArr", toJson(myCarPrice));
    	} catch (Exception e) {
    		e.printStackTrace();
    	}

    	return tilesAjaxPrefix+"mypage.person.AJAX.mycar_list_sub_ajax";
    }
    //마이카 - 일반 - 마이카 견적 요청 서비스(방문견적전용)
    //항상 마이카 견적 요청 서비스 보다 위쪽에 위치되어야 맵핑이되므로 위치를 옮기지 말것
    @RequestMapping(value={"/mycarPersonMyCar/visit/AJAX"}, produces = "text/html; charset=utf-8")
    public @ResponseBody ResponseEntity<Object> mycarPersonMyCarEstServiceForVisit(@RequestBody Map<String, Object> params, HttpServletRequest req, HttpServletResponse res, Model model){
    	mlog_usual.debug(" :: Load mycar_person_mycar_est_service Page.");
    	Map<String, Object> resMap = new HashMap<>();
    	String resCd="00";

    	try {
    		estimateService.estimateVisit(params);
    	} catch (Exception e) {
    		resCd="99";
    	}

    	resMap.put("resCd", resCd);
    	return makeJsonResponseHeader(resMap);
    }
    //마이카 - 일반 - 마이카 견적 요청 서비스
    @RequestMapping(value={"/mycarPersonMyCar/{estService}/AJAX"}, produces = "text/html; charset=utf-8")
    public @ResponseBody ResponseEntity<Object> mycarPersonMyCarEstService(@PathVariable String estService, Car car,HttpServletRequest req, HttpServletResponse res, Model model){
    	mlog_usual.debug(" :: Load mycar_person_mycar_est_service Page.");

    	Map<String, Object> resMap = new HashMap<>();
    	String resCd="00";

    	try {
    		switch(estService){
    		case "cancel":		//견적취소, 삭제
    		case "remove":
    			carMstService.updateEstReqYn(car);
    			break;
    		case "dealer":		//딜러견적요청
    			estimateService.estimateDealer(car);
    			break;
    		case "retry":		//딜러견적 재요청
    			carMstService.updateEstReqYn(car);
    			estimateService.estimateDealer(car);
    			break;
    		}
    	} catch (Exception e) {
    		resCd="99";

    	}
    	resMap.put("resCd", resCd);
    	return makeJsonResponseHeader(resMap);
    }

    //마이카 - 일반 - 메이크업 리스트
    @RequestMapping(value = {"/mycarPersonMakeupList/AJAX"}, method = RequestMethod.GET, produces = "text/html; charset=utf-8")
    public String mycarPersonMakeupList(Makeup makeup, HttpServletRequest req, HttpServletResponse res, Model model){
        mlog_usual.debug(" :: Load mycar_person_nameCard Page.");
        Map<String, Object> resMap  = new HashMap<>();

        try{
            resMap = myService.getMakeupListPaging(makeup);
            model.addAllAttributes(resMap);
        }catch (Exception e) {
            e.printStackTrace();
        }
        return tilesAjaxPrefix+"mypage.person.AJAX.makeup_list_ajax";
    }
    //마이카 - 일반 - 관심 딜러 리스트
    @RequestMapping(value = {"/mycarPersonInterestDealerList/AJAX"}, method = RequestMethod.GET, produces = "text/html; charset=utf-8")
    public String mycarPersonInterestDealerList(T2Users t2Users,Car car, HttpServletRequest req, HttpServletResponse res, Model model){
        mlog_usual.debug(" :: Load mycar_person_nameCard Page.");
        Map<String, Object> resMap  = new HashMap<>();

        try{
        	resMap = userApiService.getInterestDealerListPaging(t2Users);
        	model.addAllAttributes(resMap);
        	model.addAttribute("test",toJson(resMap));
        }catch (Exception e) {
        	e.printStackTrace();
        }
        return tilesAjaxPrefix+"mypage.person.AJAX.interest_dealer_list_ajax";
    }

    //관심딜러프로필 개별 상세 팝업
    @RequestMapping(value = {"/mycarPersonGetDealerInfo/AJAX"}, method = RequestMethod.POST, produces = "text/html;charset=utf-8")
    public String mycarPersonGetDealerInfo(@RequestBody Car car, HttpServletRequest req, HttpServletResponse res, Model model){
        mlog_usual.debug(" :: Load mycar_person_nameCard Page.");
        Map<String, Object> resMap  = new HashMap<>();
        String resCd = "00";
        try{

            //딜러 상세
            T2Users user = userApiService.getDealerProfileInfo(car);
            if(user != null) {
                user.remakeDealerPhone(true);
            }
            resMap.put("user", user);
            //딜러 상세 끝

            model.addAttribute("user"   , resMap.get("user"));

        }catch(Exception e){
            e.printStackTrace();
            model.addAttribute("totPages" , 0);
            resCd = "99";
        }
        resMap.put("resCd", resCd);
        //return makeJsonResponseHeader(resMap);
        return tilesAjaxPrefix+"mypage.person.AJAX.dealerInfo_ajax";
    }

    //딜러 상세 팝업 평가
    @RequestMapping(value = {"/mycarPersonGetDealerEvalInfo/AJAX"}, method = RequestMethod.POST, produces = "text/html;charset=utf-8")
    public String mycarPersonGetDealerEvalInfo(@RequestBody Car car, HttpServletRequest req, HttpServletResponse res, Model model){
        mlog_usual.debug(" :: Load mycar_person_nameCard Page.");
        try{
            // 딜러 평가
            car.setPageListSize(3);         //3개씩 화면에 노출
            model.addAllAttributes(userApiService.getDealerEvalListPaging(car));
            //딜러 평가 끝
        }catch(Exception e){

        }
        return tilesAjaxPrefix+"mypage.person.AJAX.dealerEval_ajax";
    }

    //딜러 상세 팝업 차량 리스트
    @RequestMapping(value = {"/mycarPersonGetDealerCarInfo/AJAX"}, method = RequestMethod.POST, produces = "text/html;charset=utf-8")
    public String mycarPersonGetDealerCarInfo(@RequestBody Car car, HttpServletRequest req, HttpServletResponse res, Model model){
        mlog_usual.debug(" :: Load mycar_person_nameCard Page.");
        Map<String, Object> resMap  = new HashMap<>();
        Map<String, Object> carMap  = new HashMap<>();
        List<Car> carList           = new ArrayList<>();
        String resCd = "00";

        try{
            //판매차량
            car.setPageListSize(6);         //6개씩 화면에 노출
            car.setSchType(CarMstService.SELECT_TYPE_DEALER);
            carMap = carMstService.selectCarModel(car);
            carList = (List<Car>)carMap.get("list");

            if(!ObjectUtils.isEmpty(carList)){
                model.addAttribute("totPages"   , car.getTotBlockSize());
                model.addAttribute("curPage"    , car.getCurPage());
                model.addAttribute("interestCarList"    , carList);
            }
            //판매차량 끝


        }catch(Exception e){
            e.printStackTrace();
            model.addAttribute("totPages" , 0);
            resCd = "99";
        }
        resMap.put("resCd", resCd);
        return tilesAjaxPrefix+"mypage.person.AJAX.dealerCar_ajax";
    }


    //마이카 - 일반 - 관심 매물 리스트
    @RequestMapping(value = {"/mycarPersonInterestCarList/AJAX"}, method = RequestMethod.GET, produces = "text/html; charset=utf-8")
    public String mycarPersonInterestCarList(T2Users t2Users,Car car, HttpServletRequest req, HttpServletResponse res, Model model){
    	mlog_usual.debug(" :: Load mycar_person_nameCard Page.");
    	Map<String, Object> resMap  = new HashMap<>();

    	try{
    		car.setSchType(CarMstService.SELECT_TYPE_INTEREST);
    		resMap = carMstService.selectCarModel(car);
    		model.addAttribute("interestCarList", resMap.get("list"));
    		model.addAttribute("curPage", car.getCurPage());
    		model.addAttribute("totPages", car.getTotBlockSize());
    	}catch (Exception e) {
    		e.printStackTrace();
    	}
    	return tilesAjaxPrefix+"mypage.person.AJAX.interest_car_list_ajax";
    }

    //문의내역 리스트
    @RequestMapping(value={"/mycarPersonQuestion/AJAX"}, method = RequestMethod.GET, produces = "text/html; charset=utf-8")
    public String qna_list_Ajax(My my, HttpServletRequest req, HttpServletResponse res, Model model){
        mlog_usual.debug(" :: Load qna_list Page.");
        Map<String, Object> resMap = new HashMap<>();
        List<My> myQnaList = new ArrayList<>();
        String resCd = "00";

        try{
            int curPage = my.getCurPage();
            resMap = myService.getPersonQnaList(my);

            myQnaList = (List<My>)resMap.get("list");
            if(myQnaList.size() != 0){
            	myQnaList.get(0).setTotListSize(Integer.parseInt(resMap.get("totListSize").toString()));
            	model.addAttribute("totPages"   , myQnaList.get(0).getTotBlockSize());
            }

            model.addAttribute("qnaList"    , myQnaList);
            model.addAttribute("curPage"    , curPage);
        }catch (Exception e) {
            resCd = "99";
            model.addAttribute("totPages"   , 0);
            e.printStackTrace();
        }

        resMap.put("resCd", resCd);
        return tilesAjaxPrefix+"mypage.person.AJAX.question_list_ajax";
    }

    //문의 내역 등록
    @RequestMapping(value = {"/mycarPersonQnaInsert"}, method = RequestMethod.POST, produces = "text/html; charset=utf-8")
    public @ResponseBody ResponseEntity<Object> qna_insert(@RequestBody My my, HttpServletRequest req, HttpServletResponse res, Model model){
        mlog_usual.debug(" :: Load chkUpdatePw");
        HashMap<String, Object> resMap = new HashMap<>();
        String resCd = "00";

        try {
            myService.registFrontQuestion(my);
        } catch (Exception e) {
            resCd = "99";
        }

        resMap.put("resCd", resCd);
        return makeJsonResponseHeader(resMap);
    }

    //방문/시승/탁송 예약 취소
    @RequestMapping(value = {"/mycarPersonCancelReserve"}, method = RequestMethod.POST, produces = "text/html; charset=utf-8")
    public @ResponseBody ResponseEntity<Object> mycarPersonCancelReserve(@RequestBody Reserve reserve, HttpServletRequest req, HttpServletResponse res, Model model){
        mlog_usual.debug(" :: Load mycarPersonCancelReserve");
        HashMap<String, Object> resMap = new HashMap<>();
        HashMap<String, String> params = new HashMap<>();

        String str = null;
        try {
            /*for(int i=0;i<reserve.getResSeqs().length;i++){
                str = reserve.getResSeqs()[i];
                params.put("resHisSeq", str);
            }*/
            params.put("resHisSeq", reserve.getResHisSeq());
            userApiService.cancelCarReserve(params);
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }

        return makeJsonResponseHeader(resMap);
    }

    //방문/시승/탁송 예약 승인
    @RequestMapping(value = {"/mycarPersonAcceptReserve"}, method = RequestMethod.POST, produces = "text/html; charset=utf-8")
    public @ResponseBody ResponseEntity<Object> mycarPersonAcceptReserve(@RequestBody ResHis resHis, HttpServletRequest req, HttpServletResponse res, Model model){
        mlog_usual.debug(" :: Load mycarPersonCancelReserve");
        HashMap<String, Object> resMap = new HashMap<>();

        try {
            userApiService.requestReserveStatus(resHis);
        } catch (Exception e) {
            // TODO: handle exception
        }

        return makeJsonResponseHeader(resMap);
    }

    //메이크업 차량 번호로 조회 클릭 시
    @RequestMapping(value = {"/mycarPersonSelectMakupCar"}, method = RequestMethod.POST, produces = "text/html; charset=utf-8")
    public @ResponseBody ResponseEntity<Object> mycarPersonSelectMakupCar(@RequestBody Car car, HttpServletRequest req, HttpServletResponse res, Model model){
        mlog_usual.debug(" :: Load mycarPersonSelectMakupCar");
        HashMap<String, Object> resMap = new HashMap<>();

        try {
            car = myService.getMakeupSearch(car);
        } catch (Exception e) {
            // TODO Auto-generated catch block
        }

        resMap.put("car", car);
        return makeJsonResponseHeader(resMap);
    }

    //메이크업 신청
    @RequestMapping(value = {"/mycarPersonInsertMakeUp"}, method = RequestMethod.POST, produces = "text/html; charset=utf-8")
    public @ResponseBody ResponseEntity<Object> mycarPersonInsertMakeUp(@RequestBody Makeup makeup, HttpServletRequest req, HttpServletResponse res, Model model){
        mlog_usual.debug(" :: Load mycarPersonInsertMakeUp");
        HashMap<String, Object> resMap = new HashMap<>();
        String resCd = "00";
        try {
            myService.registMakeup(makeup);
        } catch (Exception e) {
        	resCd = "99";
        }
        resMap.put("resCd", resCd);
        return makeJsonResponseHeader(resMap);
    }





	//프로필수정 (일반)
    @RequestMapping(value={"/memberModifyPerson"}, method = RequestMethod.GET, produces = "text/html; charset=utf-8")
    public String memModify(HttpServletRequest req, HttpServletResponse res, Model model){
        mlog_usual.debug(" :: Load member_modify");
        T2Users userInfo = t2UserService.getUser(loginUserInfo());
        model.addAttribute("userInfo",toJson(userInfo));
        model.addAttribute("userInfo",userInfo);
        return tilesPrefix+"person.member_modify";
    }


	//마이카 - 딜러
	@RequestMapping(value={"/mycarDealer"}, method = RequestMethod.GET, produces = "text/html; charset=utf-8")
	public String mycar_dealer(HttpServletRequest req, HttpServletResponse res, Model model) throws IOException {
		mlog_usual.debug(" :: Load mycar_dealer Page.");
		if(isLogin()) {
			res.sendRedirect(req.getContextPath() + "/product/mypage/mycarDealerList");
		}
		return tilesPrefix+"dealer.mycar_dealer";
	}

	//마이카 - 매물등록
	@RequestMapping(value={"/mycarDealerRegist"}, method = RequestMethod.GET, produces = "text/html; charset=utf-8")
	public String mycar_regist(HttpServletRequest req, HttpServletResponse res, Model model){
		mlog_usual.debug(" :: Load mycar_regist Page.");
		return tilesPrefix+"dealer.mycar_regist";
	}

	//마이카 - 매물등록
	@RequestMapping(value={"/mycarDealerRegist/AJAX"}, method = RequestMethod.POST, produces = "text/html; charset=utf-8")
	public @ResponseBody ResponseEntity<Object> mycar_regist_ajax(@RequestBody Car car, HttpServletRequest req, HttpServletResponse res, Model model){
//		public @ResponseBody ResponseEntity<Object> mycar_regist_ajax(@RequestBody Map<String, Object> car, HttpServletRequest req, HttpServletResponse res, Model model){
		mlog_usual.debug(" :: Load mycar_regist AJAX.");
		Map<String, Object> resMap = new HashMap<>();
		String resCd = "00";
		try{
			carMstService.registCarModel(car);
			resMap.put("car", car);
		}catch(Exception e){
			resCd="99";
			log.error(e.getMessage(), e);
		}
		resMap.put("resCd", resCd);
		return makeJsonResponseHeader(resMap);
	}
	//마이카 - 매물등록
	@RequestMapping(value={"/mycarPersonRegist/AJAX"}, method = RequestMethod.POST, produces = "text/html; charset=utf-8")
	public @ResponseBody ResponseEntity<Object> mycar_person_regist_ajax(@RequestBody Car car, HttpServletRequest req, HttpServletResponse res, Model model){
//		public @ResponseBody ResponseEntity<Object> mycar_regist_ajax(@RequestBody Map<String, Object> car, HttpServletRequest req, HttpServletResponse res, Model model){
		mlog_usual.debug(" :: Load mycar_regist AJAX.");
		Map<String, Object> resMap = new HashMap<>();
		String resCd = "00";
		try{
			carMstService.registMyCarlModel(car);
			resMap.put("car", car);
		}catch(Exception e){
			resCd="99";
			log.error(e.getMessage(), e);
		}
		resMap.put("resCd", resCd);
		return makeJsonResponseHeader(resMap);
	}

	//마이카 - 매물관리 (딜러)
	@RequestMapping(value={"/mycarDealerList"}, produces = "text/html; charset=utf-8")
	public String mycar_list(HttpServletRequest req, HttpServletResponse res, Model model){
		mlog_usual.debug(" :: Load mycar_list Page.");
		return tilesPrefix+"dealer.mycar_list";
	}

	@RequestMapping(value={"/mycarDealerList/AJAX"}, method = RequestMethod.GET ,produces = "text/html; charset=utf-8")
	public String mycar_list_ajax(Car car, HttpServletRequest req, HttpServletResponse res, Model model){
		mlog_usual.debug(" :: Load mycar_list AJAX Page.");
		HashMap<String, Object> resMap = new HashMap<>();
	    try {
	    	car.setLoginUserName(loginUserName());
	        resMap = carMstService.getCarListPaging(car);

	        model.addAttribute("car",resMap);
	        model.addAttribute("curPage",car.getCurPage());
        } catch (Exception e) {
            e.printStackTrace();
        }
		return tilesAjaxPrefix+"mypage.dealer.AJAX.mycar_list_ajax";
	}
	@RequestMapping(value={"/mycarDealerDetailPop/AJAX"}, method = RequestMethod.GET ,produces = "text/html; charset=utf-8")
	public String mycar_dealer_detail_pop_ajax(Car car, HttpServletRequest req, HttpServletResponse res, Model model){
		mlog_usual.debug(" :: Load mycar_list AJAX Page.");
		HashMap<String, Object> resMap = new HashMap<>();
		try {
			car = carMstService.getCarCommonInfo(car);
			model.addAttribute("car", car);
			model.addAttribute("carArr",toJson(car));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return tilesAjaxPrefix+"mypage.dealer.AJAX.mycar_detail_pop_ajax";
	}
	@RequestMapping(value={"/mycarPersonDetailPop/AJAX"}, method = RequestMethod.GET ,produces = "text/html; charset=utf-8")
	public String mycar_person_detail_pop_ajax(Car car, HttpServletRequest req, HttpServletResponse res, Model model){
		mlog_usual.debug(" :: Load mycar_list AJAX Page.");
		HashMap<String, Object> resMap = new HashMap<>();
		try {
			car = carMstService.getMyCarInfo(car);
			T2Users t2Users = new T2Users();
			t2Users.setUserId(loginUserName());
			model.addAttribute("userInfo", t2UserService.getUserAndAuthorities(t2Users));
			model.addAttribute("car", car);
			model.addAttribute("carArr",toJson(car));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return tilesAjaxPrefix+"mypage.person.AJAX.mycar_detail_pop_ajax";
	}

	//마이카 - 판매완료
	@RequestMapping(value={"/mycarDealerComplete/AJAX"}, method = RequestMethod.POST, produces = "text/html; charset=utf-8")
	public @ResponseBody ResponseEntity<Object> mycarComplete(@RequestBody Car car, HttpServletRequest req, HttpServletResponse res, Model model){
		mlog_usual.debug(" :: Load mycar Complete.");
		HashMap<String, Object> resMap = new HashMap<>();
		String resCd = "00";
		try {
			ResHis resHis = carMstService.completeCarState(car);
			resMap.put("resHis", resHis);
		} catch (Exception e) {
			resCd="99";
		}
		resMap.put("resCd", resCd);
		return makeJsonResponseHeader(resMap);
	}

	//마이카 - 매물전송서비스
	@RequestMapping(value={"/mycarDealerForwarding"}, produces = "text/html; charset=utf-8")
	public String mycar_forwarding(HttpServletRequest req, HttpServletResponse res, Model model){
		mlog_usual.debug(" :: Load mycar_forwarding Page.");
		return tilesPrefix+"dealer.mycar_forwarding";
	}

	//마이카 - 사전방문예약관리
	@RequestMapping(value={"/mycarDealerVisit"}, produces = "text/html; charset=utf-8")
	public String mycar_visit(HttpServletRequest req, HttpServletResponse res, Model model){
		mlog_usual.debug(" :: Load mycar_visit Page.");
		userApiService.updatePcReadFlag("reserListDealer");
		return tilesPrefix+"dealer.mycar_visit";
	}

	@RequestMapping(value={"/mycarDealerVisit/AJAX"}, method = RequestMethod.GET ,produces = "text/html; charset=utf-8")
	public String mycar_visit_ajax(Reserve reserve, HttpServletRequest req, HttpServletResponse res, Model model){
		mlog_usual.debug(" :: Load mycar_visit_list AJAX Page.");
		HashMap<String, Object> resMap = new HashMap<>();
		try {
			//로그인 ID
			reserve.setResUserId(loginUserName());

			resMap = myService.getReserveListDealerPaging(reserve);

			model.addAttribute("reserve",resMap);
			model.addAttribute("curPage",reserve.getCurPage());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return tilesAjaxPrefix+"mypage.dealer.AJAX.mycar_visit_list_ajax";
	}

    //사전방문등록 하나의 상세 정보
    @RequestMapping(value = {"/mycarDealerAcceptVisit/{resHisSeq}"}, method = RequestMethod.POST, produces = "text/html; charset=utf-8")
    public @ResponseBody ResponseEntity<Object> mycarPersonGetReserve(@PathVariable String resHisSeq,Reserve reserve, HttpServletRequest req, HttpServletResponse res, Model model){
        mlog_usual.debug(" :: Load mycarPersonGetReserve.");
        HashMap<String, Object> resMap = new HashMap<String, Object>();

        try {
            resMap = myService.getReserveDealer(resHisSeq);
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        model.addAttribute("reserve", resMap.get("resMap"));

        return makeJsonResponseHeader(resMap);
    }

    //사전방문등록 시간 저장
    @RequestMapping(value = {"/mycarDealerAcceptReserve"}, method = RequestMethod.POST, produces = "text/html; charset=utf-8")
    public @ResponseBody ResponseEntity<Object> mycarDealerAcceptReserve(@RequestBody ResHis resHis, HttpServletRequest req, HttpServletResponse res, Model model){
        mlog_usual.debug(" :: Load mycarPersonGetReserve.");
        HashMap<String, Object> resMap = new HashMap<String, Object>();
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

    //사정방문등록 거절
    @RequestMapping(value = {"/mycarDealerRefuseReserve"}, method = RequestMethod.POST, produces = "text/html; charset=utf-8")
    public @ResponseBody ResponseEntity<Object> mycarDealerRefuseReserve(@RequestBody ResHis resHis, HttpServletRequest req, HttpServletResponse res, Model model){
        mlog_usual.debug(" :: Load requestCarReserve.");
        Map<String, String> resMap = new HashMap<>();
        Map<String, String> params = new HashMap<>();

        String resCd = "00";

        try{
            params.put("reqStatus", "reject");
            params.put("resKey", resHis.getResKey());
            params.put("resHisSeq", resHis.getResHisSeq());

            userApiService.requestCarReserve(params);
        } catch(Exception e){
            e.printStackTrace();
            resCd = "99";
        }

        resMap.put("resCd", resCd);
        return makeJsonResponseHeader(resMap);
    }



	//마이카 - 시승요청관리
	@RequestMapping(value={"/mycarDealerDriveReq"}, produces = "text/html; charset=utf-8")
	public String mycar_drive_req(HttpServletRequest req, HttpServletResponse res, Model model){
		mlog_usual.debug(" :: Load mycar_drive_req Page.");
		return tilesPrefix+"dealer.mycar_drive_req";
	}

	//마이카 - 견적요청관리
	@RequestMapping(value={"/mycarDealerEstimate"}, produces = "text/html; charset=utf-8")
	public String mycar_estimate(HttpServletRequest req, HttpServletResponse res, Model model){
		mlog_usual.debug(" :: Load mycar_estimate Page.");
		return tilesPrefix+"dealer.mycar_estimate";
	}

	//마이카 - 명함관리
	@RequestMapping(value={"/mycarDealerBusinesscard"}, produces = "text/html; charset=utf-8")
	public String mycar_businesscard(HttpServletRequest req, HttpServletResponse res, Model model){
		mlog_usual.debug(" :: Load mycar_businesscard Page.");
		return tilesPrefix+"dealer.mycar_businesscard";
	}

	//마이카 - 명함 리스트
	@RequestMapping(value={"/mycarDealerBusinesscard/AJAX"}, method = RequestMethod.GET, produces = "text/html; charset=utf-8")
	public String mycar_businesscard_ajax(T2Users t2Users, HttpServletRequest req, HttpServletResponse res, Model model){
		mlog_usual.debug(" :: Load mycar_businesscard_AJAX Page.");
		HashMap<String, Object> resMap = new HashMap<>();
		try {
			int curPage = t2Users.getCurPage();
			t2Users.setCurPage(curPage);
			resMap = transmitService.getBusinesscardListPaging(t2Users);
			model.addAttribute("cardList",resMap);
			model.addAttribute("curPage",curPage);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return tilesAjaxPrefix+"mypage.dealer.AJAX.mycar_businesscard_list_ajax";
	}

	//명함등록
	@RequestMapping(value={"/mycarDealerBusinesscard/register"}, method = RequestMethod.POST, produces = "text/html; charset=utf-8")
	public @ResponseBody ResponseEntity<Object> mycarDealerBusinesscard_register(@RequestBody CheckListHis cls, HttpServletRequest req, HttpServletResponse res){
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

	//명함 - 파일업로드등록
		@RequestMapping(value={"/businesscard/fileUpload/AJAX"}, method = RequestMethod.POST, produces = "text/html; charset=utf-8")
		public @ResponseBody ResponseEntity<Object>businesscardFileUpload(HttpServletRequest req, HttpServletResponse res, Model model){
			mlog_usual.debug(" :: Load mycar Page.");
			T2File file = null;
			try {
				file = fileService.cardUpload(req, loginUserInfo());
			} catch (IOException e) {

			}
			return makeJsonResponseHeader(file);
		}

	//명함정보 가져오기
	@RequestMapping(value={"/mycarDealerBusinesscard/nameCardProfileInfo"}, method = RequestMethod.POST, produces = "text/html; charset=utf-8")
	public @ResponseBody ResponseEntity<Object> getNameCardProfileInfo(HttpServletRequest req, HttpServletResponse res, Model model){
		mlog_usual.debug(" :: Load nameCardProfileInfo.");
		HashMap<String, Object> resMap = new HashMap<String, Object>();
		String resCd = "00";
		try{
			if(isLogin()){
				if("D".equals(loginUserInfo().getDivision())){
					T2Users user = userApiService.getNameCardDealerProfileInfo(loginUserName());
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
	@RequestMapping(value={"/mycarDealerBusinesscard/modifyNameCard"}, method = RequestMethod.POST, produces = "text/html; charset=utf-8")
	public @ResponseBody ResponseEntity<Object> modifyNameCard(@RequestBody T2Users t2Users, HttpServletRequest req, HttpServletResponse res){
		mlog_usual.debug(" :: Load modifyNameCard.");
		HashMap<String, Object> resMap = new HashMap<String, Object>();
		String resCd = "00";
		try{
			userApiService.modifyNameCard(t2Users);

			Authentication auth = SecurityContextHolder.getContext().getAuthentication();
			HashMap<String, Object> info = (HashMap<String, Object>)auth.getDetails();
			//2017-08-23 바로 적용되어야하기때문에 주석 달아 놓았음.
			info.put("sessUserInfo", t2UserService.getUserAndAuthorities(t2Users));

		}catch(Exception e){
			e.printStackTrace();
			resCd = "99";
		}
		resMap.put("resCd", resCd);
		return makeJsonResponseHeader(resMap);
	}

	//마이카 - 체크리스트관리
	@RequestMapping(value={"/mycarDealerCheckList"}, produces = "text/html; charset=utf-8")
	public String mycar_check_list(HttpServletRequest req, HttpServletResponse res, Model model){
		mlog_usual.debug(" :: Load mycar_check_list Page.");
		return tilesPrefix+"dealer.mycar_check_list";
	}

	@RequestMapping(value={"/mycarDealerCheckList/AJAX"}, method = RequestMethod.GET, produces = "text/html; charset=utf-8")
	public String mycar_check_list_ajax(CheckListHis checkListHis, HttpServletRequest req, HttpServletResponse res, Model model){
		mlog_usual.debug(" :: Load mycar_check_list_AJAX Page.");
		HashMap<String, Object> resMap = new HashMap<>();
		try {
			resMap = transmitService.getCheckListPaging(checkListHis);

			model.addAttribute("check",resMap);
			model.addAttribute("curPage",checkListHis.getCurPage());
		} catch (Exception e) {
			e.printStackTrace();
		}

		return tilesAjaxPrefix+"mypage.dealer.AJAX.mycar_check_list_ajax";
	}

	//체크리스트등록
	@RequestMapping(value={"/mycarDealerCheckList/register"}, method = RequestMethod.POST, produces = "text/html; charset=utf-8")
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

	// 푸시보내기전 회원정보 리스트
	@RequestMapping(value={"/mycarDealerPushList/AJAX"}, method = RequestMethod.GET, produces = "text/html; charset=utf-8")
	public String mycar_push_list_ajax(String searchTxt, HttpServletRequest req, HttpServletResponse res, Model model){
		mlog_usual.debug(" :: Load mycar_push_list_AJAX Page.");
		try {
			List<T2Users> pushList = userApiService.pushUserList(searchTxt);

			for (int i = 0; i < pushList.size(); i++) {
				T2Users user = pushList.get(i);
				user.setPhoneMobile(CoCommonFunc.phoneFomatter(user.getPhoneMobile(), true));
			}
			model.addAttribute("pushList",pushList);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return tilesAjaxPrefix+"mypage.dealer.AJAX.mycar_push_list_ajax";
	}

	//마이카 - 구매비용항목관리
	@RequestMapping(value={"/mycarDealerCostList"}, produces = "text/html; charset=utf-8")
	public String mycar_cost_list(HttpServletRequest req, HttpServletResponse res, Model model){
		mlog_usual.debug(" :: Load mycar_cost_list Page.");
		return tilesPrefix+"dealer.mycar_cost_list";
	}

	//마이카 - 구매비용항목관리-AJAX
	@RequestMapping(value={"/mycarDealerCostList/AJAX"}, method = RequestMethod.GET ,produces = "text/html; charset=utf-8")
	public String mycar_cost_list_ajax(CarCost carCost, HttpServletRequest req, HttpServletResponse res, Model model){
		mlog_usual.debug(" :: Load mycar_cost_list AJAX Page.");
		try {
			HashMap<String, Object> resMap = new HashMap<>();
			try {
				carCost.setDealerId(loginUserName());	// 세션아이디를 딜러아이디에 넣는다.
				resMap = transmitService.selectCostListPaging(carCost);
				model.addAttribute("cost",resMap);
				model.addAttribute("curPage",carCost.getCurPage());

			} catch (Exception e) {
				e.printStackTrace();
			}

        } catch (Exception e) {
            e.printStackTrace();
        }
		return tilesAjaxPrefix+"mypage.dealer.AJAX.mycar_cost_list_ajax";
	}

	//비용등록
    @RequestMapping(value={"/mycarDealerCostList/register"}, method = RequestMethod.POST, produces = "text/html; charset=utf-8")
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

	//비용등록 상세 팝업
    @RequestMapping(value={"/mycarDealerCostList/detail"}, method = RequestMethod.POST, produces = "text/html; charset=utf-8")
    public @ResponseBody ResponseEntity<Object> cost_detail(@RequestBody CarCost carCost, HttpServletRequest req, HttpServletResponse res){
        mlog_usual.debug(" :: Load cost_detail Page.");
        HashMap<String, Object> resMap = new HashMap<String, Object>();
        String resCd = "00";
        try{
        	 resMap  = transmitService.getCostDetail(carCost);
        }catch(Exception e){
            e.printStackTrace();
            resCd = "99";
        }

        resMap.put("resCd", resCd);
        return makeJsonResponseHeader(resMap);
    }

    //매물전송서비스  리스트
    @RequestMapping(value={"/mycarDealerFowardingPaging/AJAX"}, method = RequestMethod.GET ,produces = "text/html; charset=utf-8")
	public String mycar_fowarding_list_ajax(Car car, HttpServletRequest req, HttpServletResponse res, Model model){
		mlog_usual.debug(" :: Load mycar_fowarding_list AJAX Page.");
		try {
			HashMap<String, Object> resMap = new HashMap<>();
			try {

				car.setDealerId(loginUserName());	// 세션아이디를 딜러아이디에 넣는다.
				car.setDealerLicenseNo(loginUserInfo().getDealerLicenseNo());
				car.getLabel().setCarFuel(car.getCarFuel());

				resMap = transmitService.selectForwardingListPaging(car);
				model.addAttribute("fowarding",resMap);
				model.addAttribute("curPage",car.getCurPage());
			} catch (Exception e) {
				e.printStackTrace();
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return tilesAjaxPrefix+"mypage.dealer.AJAX.mycar_fowarding_list_ajax";
	}

	//마이카 - 매물등록
	@RequestMapping(value={"/mycarDealerRegist/forward"}, method = RequestMethod.GET, produces = "text/html; charset=utf-8")
	public String mycar_fowarding_regist(Car car, HttpServletRequest req, HttpServletResponse res, Model model){
		mlog_usual.debug(" :: Load mycar_regist Page.");

		try {
			car = carDealerBIGService.getCarInfoFromBIG(car.getCarPlateNum(), car.getDealerLicenseNo());
			model.addAttribute("car",car);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return tilesPrefix+"dealer.mycar_regist";
	}

    //프로필수정 (딜러)
    @RequestMapping(value={"/memberModifyDealer"}, method = RequestMethod.GET, produces = "text/html; charset=utf-8")
    public String memModifyDealer(T2Users t2Users,CarMarketInfoShop carMarketInfoShop,HttpServletRequest req, HttpServletResponse res, Model model){
        mlog_usual.debug(" :: Load member_modify_dealer");
        T2Users userInfo = t2UserService.getUser(loginUserInfo());

        model.addAttribute("userInfo",toJson(userInfo));
        model.addAttribute("userInfo",userInfo);
        return tilesPrefix+"dealer.member_modify_dealer";
    }

    /*
     * 내용   : 비밀번호 변경
     */
    @RequestMapping(value = {"/chkUpdatePw"}, method = {RequestMethod.GET,RequestMethod.POST}, produces = "text/html; charset=utf-8")
    public @ResponseBody ResponseEntity<Object> chkUpdatePw(@RequestBody T2Users t2users, HttpServletRequest req, HttpServletResponse res, Model model){
        mlog_usual.debug(" :: Load chkUpdatePw");
        HashMap<String, Object> resMap = new HashMap<>();
        String resCd = "00";
        //입력한 현재비밀번호와 기존 비밀번호가 동일한지 확인
        String str = t2users.getOldPw();
        //기존비밀번호 가져오기
        String getPassword = t2UserService.getPassword(t2users);

        StandardPasswordEncoder s = new StandardPasswordEncoder(AppConstBean.StandardPasswordEncoderSalt);

        boolean psChk = s.matches(str,getPassword);

        if(psChk){//입력한 비밀번호가 현재 비밀번호와 동일 할 때 비밀번호 변경 실행
            resMap.put("resCd", resCd);
            int rslt = t2UserService.updateUsersPassword(t2users);
            resMap.put("rslt", rslt);
            return makeJsonResponseHeader(resMap);
        }else{
            resMap.put("resCd", "99");
            return makeJsonResponseHeader(resMap);
        }
    }

    /*
     * 내용   : 회원정보 수정(일반, 딜러)
     */
    @RequestMapping(value = {"/updateUser"}, method =RequestMethod.POST, produces = "text/html; charset=utf-8")
    public @ResponseBody ResponseEntity<Object> updateUser(@RequestBody T2Users t2Users, HttpServletRequest req, HttpServletResponse res, Model model){
        mlog_usual.debug(" :: Load updateUser");
        Map<String, Object> resMap = new HashMap<>();
        String resCd="00";
        try{
        	t2UserService.updateUsers(t2Users);
        }catch(Exception e){
        	resCd="99";
        }

        resMap.put("resCd", resCd);
        return makeJsonResponseHeader(resMap);
    }

    /*
     * 내용   : 종사자번호 변경
     * 개발자 : 김예지
     */
    @RequestMapping(value = {"/changeDealerNo"}, method = {RequestMethod.GET,RequestMethod.POST}, produces = "text/html; charset=utf-8")
    public @ResponseBody ResponseEntity<Object> changeDealerNo(@RequestBody T2Users t2Users, HttpServletRequest req, HttpServletResponse res, Model model){
        mlog_usual.debug(" :: Load changeDealerNo");

        HashMap<String, Object> resMap = new HashMap<>();
        String resCd = "00";
        //입력한 현재 종사자번호와 기존 종사자번호와 동일한지 확인
        String str = t2Users.getDealerNoCurrent();
        //기존종사자번호 가져오기
        String getDealerNo = t2UserService.getDealerNo(t2Users);

        if(str.equals(getDealerNo)){//기존 종사자번호와 입력한 종사자번호가 같을 떄
            //딜러가 입력한 정보에 해당하는 종사자번호가 유효한지 체크
            String rsltDealer = carMarketInfoService.getDealerChk(t2Users);
            //딜러가 입력한 정보가 이미 회원가입이 되어있는지 체크(이름과 종사자번호로)
            int chkDealer  = t2UserService.selectDuplicateByDealerNo(t2Users);

            if("N".equals(rsltDealer)){
                resMap.put("rsltDealer", rsltDealer);
            }else{
                //기존 등록 된 사용자일경우(이름과 종사자번호로 체크)
                if(chkDealer != 0){
                    resMap.put("chkDealer", chkDealer);
                }else{
                    //종사자번호 변경
                    t2UserService.updateDealerNo(t2Users);
                    resMap.put("dealerLicenseNo", t2Users.getDealerLicenseNo());
                    resMap.put("resCd", "00");
                }
            }
        }else{
            resMap.put("resCd", "99");
        }
        return makeJsonResponseHeader(resMap);
    }

	//마이카 - 파일업로드등록
	@RequestMapping(value={"/fileUpload/AJAX"}, method = RequestMethod.POST, produces = "text/html; charset=utf-8")
	public @ResponseBody ResponseEntity<Object> mycarFileUpload(HttpServletRequest req, HttpServletResponse res, Model model){
		mlog_usual.debug(" :: Load mycar Page.");
		T2File file = null;
		try {
			file = fileService.fileUploadEx(req);
		} catch (IOException e) {
		}
		return makeJsonResponseHeader(file);
	}

	//마이카 - 메이크업
	@RequestMapping(value={"/mycarDealerMakeup"}, method = RequestMethod.GET, produces = "text/html; charset=utf-8")
	public String mycar_dealer_makeup(Car car, HttpServletRequest req, HttpServletResponse res, Model model){
		mlog_usual.debug(" :: Load mycar_dealer_makeup Page.");
		userApiService.updatePcReadFlag("makeupDealer");
		return tilesPrefix+"dealer.mycar_makeup";
	}

    //마이카 - 일반 - 메이크업 리스트
    @RequestMapping(value = {"/mycarDealerMakeup/AJAX"}, method = RequestMethod.GET, produces = "text/html; charset=utf-8")
    public String mycar_dealer_makeup_ajax(Makeup makeup, HttpServletRequest req, HttpServletResponse res, Model model){
        mlog_usual.debug(" :: Load mycar_dealer_makeup_ajax Page.");
        Map<String, Object> resMap  = new HashMap<>();

        try{
            int curPage = makeup.getCurPage();
            resMap = myService.getMakeupDealerListPaging(makeup);

            model.addAttribute("makeup", resMap);
            model.addAttribute("curPage"  , curPage);
        }catch (Exception e) {
            e.printStackTrace();
        }
        return tilesAjaxPrefix+"mypage.dealer.AJAX.mycar_makeup_ajax";
    }

    //메이크업 딜러 차량 번호로 조회 클릭 시
    @RequestMapping(value = {"/mycarDealerSelectMakupCar"}, method = RequestMethod.POST, produces = "text/html; charset=utf-8")
    public @ResponseBody ResponseEntity<Object> mycarDealerSelectMakupCar(@RequestBody Car car, HttpServletRequest req, HttpServletResponse res, Model model){
        mlog_usual.debug(" :: Load mycarDealerSelectMakupCar");
        HashMap<String, Object> resMap = new HashMap<>();

        try {
            car = myService.getMakeupDealerSearch(car);
        } catch (Exception e) {
            // TODO Auto-generated catch block
        }

        resMap.put("car", car);
        return makeJsonResponseHeader(resMap);
    }

    //메이크업 신청
    @RequestMapping(value = {"/mycarDealerInsertMakeUp"}, method = RequestMethod.POST, produces = "text/html; charset=utf-8")
    public @ResponseBody ResponseEntity<Object> mycarDealerInsertMakeUp(@RequestBody Makeup makeup, HttpServletRequest req, HttpServletResponse res, Model model){
        mlog_usual.debug(" :: Load mycarDealerInsertMakeUp");
        HashMap<String, Object> resMap = new HashMap<>();

        try {
            myService.registMakeupDealer(makeup);
        } catch (Exception e) {
            // TODO Auto-generated catch block
        }

        return makeJsonResponseHeader(resMap);
    }

	//메뉴 전체상황
	@RequestMapping(value = {"/mycarDealerMenu/status"}, method = RequestMethod.POST, produces = "text/html; charset=utf-8")
	public @ResponseBody ResponseEntity<Object> mycarDealerMenu(Car car, HttpServletRequest req, HttpServletResponse res, Model model){
		mlog_usual.debug(" :: Load mycarDealerMenu");
		HashMap<String, Object> resMap = new HashMap<>();
		try {
			car.setDealerLicenseNo(loginUserInfo().getDealerLicenseNo());
			car = myService.mycarDealerMenu(car);
		} catch (Exception e) {
			e.printStackTrace();
		}
		resMap.put("car", car);
		return makeJsonResponseHeader(resMap);
	}

	//마이카 - 비용계산기
	@RequestMapping(value={"/mycarPersonCostList/AJAX"}, method = RequestMethod.GET, produces = "text/html; charset=utf-8")
	public String mycarPersonCostList(CarCost carCost, HttpServletRequest req, HttpServletResponse res, Model model){
		mlog_usual.debug(" :: Load mycarPersonCostList Page.");
		HashMap<String, Object> resMap = new HashMap<>();
		try {
			int curPage = carCost.getCurPage();
			carCost.setCurPage(curPage);
			resMap = transmitService.mycarPersonCostList(carCost);
			model.addAttribute("costList",resMap.get("costInfo"));
			model.addAttribute("totPages",resMap.get("totPages"));
			model.addAttribute("curPage",curPage);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return tilesAjaxPrefix+"mypage.person.AJAX.cost_list_ajax";
	}

	//마이카  - 비용계산기 상세 팝업
	@RequestMapping(value={"/mycarPersonCostList/detail"}, method = RequestMethod.POST, produces = "text/html; charset=utf-8")
	public String  mycarPersonCostListDetail(@RequestBody CarCost carCost, HttpServletRequest req, HttpServletResponse res, Model model){
		mlog_usual.debug(" :: Load mycarPersonCostListDetail Page.");
		HashMap<String, Object> resMap = new HashMap<String, Object>();
		String resCd = "00";
		try{
			resMap  = transmitService.getCostDetail(carCost);
			model.addAttribute("costInfo",resMap);
		}catch(Exception e){
			e.printStackTrace();
			resCd = "99";
	}
		resMap.put("resCd", resCd);

		return tilesAjaxPrefix+"mypage.person.AJAX.cost_detail_ajax";
	}

	@RequestMapping(value={"/mycarPersonCheckList/AJAX"}, method = RequestMethod.GET, produces = "text/html; charset=utf-8")
	public String mycarPersonCheckList(CheckListHis checkListHis, HttpServletRequest req, HttpServletResponse res, Model model){
		mlog_usual.debug(" :: Load mycarPersonCheckList Page.");
		HashMap<String, Object> resMap = new HashMap<>();
		try {
			resMap = transmitService.mycarPersonCheckList(checkListHis);
			model.addAllAttributes(resMap);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return tilesAjaxPrefix+"mypage.person.AJAX.check_list_ajax";
	}

    @RequestMapping(value = {"/mycarPersonBusinesscardList/AJAX"}, method = RequestMethod.GET, produces="text/html; charset=utf-8")
    public String mycarPersonBusinesscardList(T2Users t2Users, HttpServletRequest req, HttpServletResponse res, Model model){
        mlog_usual.debug(" :: Load businesscard_list_ajax Page.");
        Map<String, Object> resMap = new HashMap<>();
        try {
        	t2Users.setPageListSize(6);
        	resMap = myService.selectBusinessCardMgmtListPaging(t2Users);
        	model.addAllAttributes(resMap);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return tilesAjaxPrefix+"mypage.person.AJAX.businesscard_list_ajax";
    }

	//일반 - 명함관리 리스트
	@RequestMapping(value={"/mycarPersonBusinesscardDelete/AJAX"}, method = RequestMethod.POST, produces = "text/html; charset=utf-8")
	public ResponseEntity<Object> mycarPersonBusinesscardDelete(@RequestBody T2Users t2Users, HttpServletRequest req, HttpServletResponse res, Model model){
		mlog_usual.debug(" :: Load mycarPersonBusinesscardDelete Page.");
		Map<String, Object> resMap  = new HashMap<>();
		String resCd = "00";
		try{
			myService.deleteBusinessCard(t2Users);
		}catch (Exception e) {
			resCd = "99";
		}
		resMap.put("resCd", resCd);
		return makeJsonResponseHeader(resMap);
	}

	//마이카 - 마크서비스
	@RequestMapping(value={"/mycarDealerMark"}, method = RequestMethod.GET, produces = "text/html; charset=utf-8")
	public String mycar_dealer_mark(Car car, HttpServletRequest req, HttpServletResponse res, Model model){
		mlog_usual.debug(" :: Load mycar_dealer_mark Page.");
		return tilesPrefix+"dealer.mycar_mark";
	}

	//마이카 - 문의내역관리
	@RequestMapping(value={"/mycarDealerQna"}, method = RequestMethod.GET, produces = "text/html; charset=utf-8")
	public String mycar_dealer_Qna(Car car, HttpServletRequest req, HttpServletResponse res, Model model){
		mlog_usual.debug(" :: Load mycar_dealer_Qna Page.");
		return tilesPrefix+"dealer.mycar_qna";
	}
	//마이카 - 문의내역관리
	@RequestMapping(value={"/mycarDealerQnaList/AJAX"}, method = RequestMethod.GET, produces = "text/html; charset=utf-8")
	public String mycarDealerQnaList(My my, HttpServletRequest req, HttpServletResponse res, Model model){
		mlog_usual.debug(" :: Load mycar_dealer_Qna Page.");
		try {
			model.addAllAttributes(myService.getQnaListPaging(my));

		} catch (Exception e) {
			e.printStackTrace();
		}

		return tilesAjaxPrefix+"mypage.dealer.AJAX.mycar_qna_list_ajax";
	}
	//마이카 - 문의내역관리
	@RequestMapping(value={"/mycarDealerQnaRegist/AJAX"}, method = RequestMethod.GET, produces = "text/html; charset=utf-8")
	public @ResponseBody ResponseEntity<Object> mycarDealerQnaRegist(My my, HttpServletRequest req, HttpServletResponse res, Model model){
		mlog_usual.debug(" :: Load mycar_dealer_Qna_regist Page.");
		Map<String, Object> resMap = new HashMap<>();
		String resCd = "00";
		try {
			myService.registQuestionAnswer(my);
		} catch (Exception e) {
			resCd = "99";
		}
		resMap.put("resCd", resCd);
		return makeJsonResponseHeader(resMap);
	}
}
