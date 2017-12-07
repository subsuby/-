package com.bnk.plus.web.front;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bnk.plus.commons.CoConstDef;
import com.bnk.plus.commons.components.CoTopComponent;
import com.bnk.plus.entity.Car;
import com.bnk.plus.entity.EstHis;
import com.bnk.plus.entity.ResHis;
import com.bnk.plus.entity.T2File;
import com.bnk.plus.service.api.FileService;
import com.bnk.plus.service.car.service.CarDealerBIGService;
import com.bnk.plus.service.car.service.CarMstService;
import com.bnk.plus.service.car.service.UserApiService;
import com.bnk.plus.service.estimate.service.EstimateService;

@Controller
@RequestMapping(value = {"/front/my"})
public class MyCarController extends CoTopComponent {
	private final String tilesPrefix = "tiles.front.my.";

	@Resource
	private Environment env;

	@Autowired
	CarMstService carMstService;

	@Autowired
	FileService fileService;

	@Autowired
	CarDealerBIGService carDealerBIGService;

	@Autowired
	EstimateService estimateService;
	
	@Autowired UserApiService userApiService;

	//마이카 - 일반
	@RequestMapping(value={"/mycar"}, produces = "text/html; charset=utf-8")
	public String mycar(Car car,HttpServletRequest req, HttpServletResponse res, Model model){
		mlog_usual.debug(" :: Load mycar Page.");
		userApiService.updateReadFlag("mycar");
		return tilesPrefix+"mycar.mycar";
	}

	//마이카 - 일반회원 리스트
	@RequestMapping(value = {"/getMyCarList"}, method = RequestMethod.POST, produces = "text/html; charset=utf-8")
	public @ResponseBody ResponseEntity<Object> myCarList(@RequestBody Car car,HttpServletRequest req, HttpServletResponse res, Model model){
	    HashMap<String, Object> resMap = new HashMap<>();

	    try {
	        resMap = carMstService.getMyCarList(car);
	        model.addAttribute("myCarList",resMap);
        } catch (Exception e) {
            // TODO: handle exception
            e.printStackTrace();
        }
	    return makeJsonResponseHeader(resMap);
	}

	//마이카 - 딜러회원 리스트
	@RequestMapping(value = {"/getCarList"}, method = RequestMethod.GET, produces = "text/html; charset=utf-8")
	public @ResponseBody ResponseEntity<Object> carList(Car car,HttpServletRequest req, HttpServletResponse res, Model model){
	    HashMap<String, Object> resMap = new HashMap<>();

	    try {
	        resMap = carMstService.getCarList(car);
	        model.addAttribute("carList",resMap);
        } catch (Exception e) {
            // TODO: handle exception
            e.printStackTrace();
        }
	    return makeJsonResponseHeader(resMap);
	}

	//마이카 - 등록
	@RequestMapping(value={"/mycar/regist"}, method = RequestMethod.POST, produces = "text/html; charset=utf-8")
	public @ResponseBody ResponseEntity<Object> mycarRegist(@RequestBody Car car, HttpServletRequest req, HttpServletResponse res, Model model){
		mlog_usual.debug(" :: Load mycar Page.");

		Map<String, Object> resMap = new HashMap<>();
		String resCd = "00";
		try{
		    if(CoConstDef.SECURITY_ROLE_DEALER.equals(car.getLoginUserRole())){               //딜러회원일 경우
		        carMstService.registCarModel(car);
		    }else{                                                                            //일반회원일 경우
		        carMstService.registMyCarlModel(car);
		    }
		    resMap.put("car", car);
		}catch(Exception e){
			resCd="99";
			e.printStackTrace();
			log.error(e.getMessage(), e);
		}


		resMap.put("resCd", resCd);
		return makeJsonResponseHeader(resMap);
	}
	//마이카 - 파일업로드등록
	@RequestMapping(value={"/mycar/fileUpload"}, method = RequestMethod.POST, produces = "text/html; charset=utf-8")
	public @ResponseBody ResponseEntity<Object> mycarFileUpload(HttpServletRequest req, HttpServletResponse res, Model model){
		mlog_usual.debug(" :: Load mycar Page.");
		T2File file = null;
		try {
			file = fileService.fileUploadEx(req);
		} catch (IOException e) {
		}
		return makeJsonResponseHeader(file);
	}
	//마이카 - 판매완료
	@RequestMapping(value={"/mycar/complete"}, method = RequestMethod.POST, produces = "text/html; charset=utf-8")
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
	//마이카 - 딜러
	@RequestMapping(value={"/mycarDealer"}, produces = "text/html; charset=utf-8")
	public String mycar_dealer(HttpServletRequest req, HttpServletResponse res, Model model){
		mlog_usual.debug(" :: Load mycar_dealer Page.");
		return tilesPrefix+"mycar_dealer.mycar_dealer";
	}

	@RequestMapping(value={"/mycarNone"}, method = RequestMethod.GET, produces = "text/html; charset=utf-8")
	public String mycar_none(HttpServletRequest req, HttpServletResponse res, Model model){
		mlog_usual.debug(" :: Load mycar_none Page.");

		return tilesPrefix+"mycar_none.mycar_none";
	}

    //딜러견적 버튼 클릭 시
    @RequestMapping(value = {"/estimateDealer"}, method = RequestMethod.POST, produces = "text/html; charset=utf-8")
    public @ResponseBody ResponseEntity<Object> estimateDealer(@RequestBody Car car, HttpServletRequest req, HttpServletResponse res, Model model){
        mlog_usual.debug(" :: Load estimateDealer Page.");

        HashMap<String, Object> resMap = new HashMap<>();
        String resCd = "00";

        try {
        	EstHis estHis =  estimateService.estimateDealer(car);
            //if(estHis == null){ resCd="88"; } //myCarSeq 가 넘어오지 않음
        	//2017-07-05 현재 무결성 오류 생김 SQL
        } catch (Exception e) {
        	resCd = "99";
        }
        resMap.put("resCd", resCd);

	    return makeJsonResponseHeader(resMap);
	}

	//견적요청 버튼 클릭 시
	@RequestMapping(value = {"/applyVisitReq"}, method = RequestMethod.POST, produces = "text/html; charset=utf-8")
	public @ResponseBody ResponseEntity<Object> applyVisitReq(@RequestBody Map<String, Object> params, HttpServletRequest req, HttpServletResponse res, Model model){
	    mlog_usual.debug(" :: Load Apply Request Page.");

	    HashMap<String, Object> resMap = new HashMap<>();
	    try{
	    	EstHis estHis = estimateService.estimateVisit(params);
	    }catch(Exception e){
	    	e.printStackTrace();
	    }
	    return makeJsonResponseHeader(resMap);
	}

    //한건에 해당하는 견적요청 취소
    @RequestMapping(value = {"/cnclReq"}, method = RequestMethod.POST, produces = "text/html; charset=utf-8")
    public @ResponseBody ResponseEntity<Object> cnclReq(@RequestBody Car car, HttpServletRequest req, HttpServletResponse res, Model model){
        mlog_usual.debug(" :: Load Cancel Request Page.");

        HashMap<String, Object> resMap = new HashMap<>();

        try {
            int rslt = carMstService.updateEstReqYn(car);
            resMap.put("rslt", rslt);
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return makeJsonResponseHeader(resMap);
    }


    //마이카(딜러) > 매물가져오기 > 차량 검색 시
    //파라미터(종사자번호, 차량번호)
    @RequestMapping(value = {"/getCarInfo"}, method = RequestMethod.POST, produces = "text/html; charset=utf-8")
    public @ResponseBody ResponseEntity<Object> getCarInfo(@RequestBody Map<String, Object> params, HttpServletRequest req, HttpServletResponse res, Model model){
        mlog_usual.debug(" :: Load getCarInfo Page.");

        HashMap<String, Object> resMap = new HashMap<>();
        String resCd = "00";

        try {
        	String carPlateNumber	= (String)params.get("carPlateNumber");
        	String licenseNo		= (String)params.get("dealerLicenseNo");
            Car car = carDealerBIGService.getCarInfoFromBIG(carPlateNumber, licenseNo);
            resMap.put("car", car);
        } catch (Exception e) {
        	resCd = "99";
            e.printStackTrace();
        }

        resMap.put("resCd", resCd);

        return makeJsonResponseHeader(resMap);
    }

    @RequestMapping(value = {"/updateGetCarInfo"}, method = RequestMethod.POST, produces = "text/html; charset=utf-8")
    public @ResponseBody ResponseEntity<Object> updateGetCarInfo(@RequestBody Car car, HttpServletRequest req, HttpServletResponse res, Model model){

    	HashMap<String, Object> resMap = new HashMap<>();
        String resCd = "00";

        try {
        	if(CoConstDef.SECURITY_ROLE_DEALER.equals(car.getLoginUserRole())){               //딜러회원일 경우
		        carMstService.registCarModel(car);
		    }else{                                                                            //일반회원일 경우
		        //carMstService.registMyCarlModel(car);
		    }
        } catch (Exception e) {
        	resCd = "99";
            e.printStackTrace();
        }

        resMap.put("resCd", resCd);

        return makeJsonResponseHeader(resMap);
    }
}
