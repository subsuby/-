package com.bnk.plus.commons.api;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FilenameUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.bnk.plus.commons.CoConstDef;
import com.bnk.plus.commons.cdManager.CoCodeManager;
import com.bnk.plus.commons.components.CoTopComponent;
import com.bnk.plus.entity.Car;
import com.bnk.plus.entity.T2File;
import com.bnk.plus.entity.T2Users;
import com.bnk.plus.service.api.FileService;
import com.bnk.plus.service.car.persistence.CarMarketInfoMapper;
import com.bnk.plus.service.car.persistence.CarMstMapper;
import com.bnk.plus.service.car.service.CarDealerBIGService;
import com.bnk.plus.service.car.service.CarSchedulerService;
import com.bnk.plus.service.car.service.UserApiService;
import com.bnk.plus.service.common.persistence.commons.api.FileMapper;
import com.bnk.plus.service.common.persistence.commons.api.MigrationMapper;
import com.bnk.plus.service.session.service.T2UserService;

@Controller
@RequestMapping(value = {"/migration"})
public class MigrationAPIController extends CoTopComponent {
	
	@Autowired UserApiService userApiService;
	@Autowired MigrationMapper migrationMapper;
	@Autowired FileMapper fileMapper;
	@Autowired FileService fileService;
	@Autowired CarMarketInfoMapper carMarketInfoMapper;
	@Autowired T2UserService userService;
	@Autowired CarDealerBIGService carDealerBIGService;
	@Autowired CarMstMapper carMstMapper;
	@Autowired CarSchedulerService carSchedulerService;
	
	@RequestMapping(value={"/bulk/carImage"}, method = RequestMethod.GET, produces = "text/html; charset=utf-8")
	public String carImage(HttpServletRequest req, HttpServletResponse res, Model model){
		
		
		Map<String, String[]> paramMap = new HashMap<>();
		String[] _targetCodeArr = new String[]{"AAA11", "AAA15", "AAA16", "AAA30", "AAB35", "BBA12", "BBB11"};
		paramMap.put("carCodeArray", _targetCodeArr);
		List<Car> carList = migrationMapper.getCarListByCarCodeArr(paramMap);
		
		// 이미지 파일 정보를 찾는다.
		Map<String, File[]> imageListMap = new HashMap<>();
		File rootDir = new File("D:/00. Project/06. BNK/TEST_SQL/dummyImage");
		for(File imageDir : rootDir.listFiles()) {
			List<String> list = new ArrayList<>();
			imageListMap.put(imageDir.getName(), imageDir.listFiles());
		}
		
		// db 등록
		for(String carCode : imageListMap.keySet()) {
			
		}
		
		
		for(Car bean : carList) {
			File[] imageFiles = imageListMap.get(bean.getCarFullCode().substring(0,5));
			
			List<String> fileSeqList = new ArrayList<>();
			
			fileMapper.deleteFileInfoByGroupId(bean.getCarSeq());
			
			for(File f : imageFiles) {
				String ext = FilenameUtils.getExtension(f.getName());
				T2File fBean = new T2File();
				fBean.setOrigNm(f.getName().replaceFirst("."+ext, ""));
				fBean.setLogiNm(f.getName().replaceFirst("."+ext, ""));
				fBean.setLogiPath(f.getAbsolutePath().substring(0, f.getAbsolutePath().lastIndexOf("\\")));
				fBean.setFileExt(ext);
				//fBean.setFileSize(f.length());
				
				fileMapper.uploadFile(fBean);
				
				fileSeqList.add(fBean.getFileSeq());

			}
			
			T2File updateFileBean = new T2File();
			updateFileBean.setFileGroupId(bean.getCarSeq());
			updateFileBean.setFileSeqs(fileSeqList.toArray(new String[fileSeqList.size()]));
			fileMapper.saveFileGroupId(updateFileBean);

			try {
				fileService.carImageFileResize(updateFileBean, bean.getCarFullCode(), bean.getCarSeq());
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		
		
		// 일단 사용할 이미지 들을 업로드 한다.
		HashMap<String, Object> resMap = new HashMap<String, Object>();
		String resCd = "00";
		resMap.put("resCd", resCd);
		return "";  
	}
	

	@RequestMapping(value={"/bulk/regDealer"}, method = RequestMethod.GET, produces = "text/html; charset=utf-8")
	public String regDealer(HttpServletRequest req, HttpServletResponse res, Model model){
		
		MigrationCarBulkData test = new MigrationCarBulkData();
		Thread thread = new Thread(test);
		thread.start();
		return "";
	}
	
	@RequestMapping(value={"/bulk/regDealer2"}, method = RequestMethod.GET, produces = "text/html; charset=utf-8")
	public String regDealer2(HttpServletRequest req, HttpServletResponse res, Model model){
		
		MigrationCarBulkData2 test = new MigrationCarBulkData2();
		Thread thread = new Thread(test);
		thread.start();
		return "";
	}
	

	

	@RequestMapping(value={"/bulk/updCheckNo"}, method = RequestMethod.GET, produces = "text/html; charset=utf-8")
	public String updateCheckNo(HttpServletRequest req, HttpServletResponse res, Model model){
		
		// 등록중인 전ㅊ 매물 목록 취득
		List<Car> carList = migrationMapper.getAllCarList();
		Map<String, String> dealerLicenseInfo = new HashMap<>();
		
		for(Car bean : carList) {
			String licenseNo = dealerLicenseInfo.get(bean.getUserId());
			if(isEmpty(licenseNo)) {
				T2Users user = userService.getUserBasicInfoById(bean.getUserId());
				licenseNo = user.getDealerLicenseNo();
			}
			// 매물가져오기
			Car carInfo = null;
			try {
				carInfo = carDealerBIGService.getCarInfoFromBIG(bean.getCarPlateNum(), licenseNo);
				
				if(carInfo != null && !isEmpty(carInfo.getCarCheckNo()) && !avoidNull(bean.getCarCheckNo()).equals(carInfo.getCarCheckNo())) {
					// update
					bean.setCarCheckNo(carInfo.getCarCheckNo());
					migrationMapper.updateCheckNo(bean);
				}
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
		}
		
		// 성능점검번호 업데이트
		
		
		return "success";
	}
	

	@RequestMapping(value={"/bulk/makeImage"}, method = RequestMethod.GET, produces = "text/html; charset=utf-8")
	public String makeImage(HttpServletRequest req, HttpServletResponse res, Model model){
		
		// 등록중인 전ㅊ 매물 목록 취득
		List<Car> carList = migrationMapper.getAllCarList();
		Map<String, String> dealerLicenseInfo = new HashMap<>();
		
		for(Car bean : carList) {
			String licenseNo = dealerLicenseInfo.get(bean.getUserId());
			if(isEmpty(licenseNo)) {
				T2Users user = userService.getUserBasicInfoById(bean.getUserId());
				licenseNo = user.getDealerLicenseNo();
			}
			// 매물가져오기
			Car carInfo = null;
			try {
				carInfo = carDealerBIGService.getCarInfoFromBIG(bean.getCarPlateNum(), licenseNo);

				if(!isEmpty(carInfo.getFileSeqs())) {
					String[] fileSeqs = carInfo.getFileSeqs().split("[,]");
					T2File paramFile = new T2File();
					paramFile.setFileSeqs(fileSeqs);
					paramFile.setFileGroupId(carInfo.getCarSeq());
					paramFile.setContentType(CoConstDef.CD_CAR_REGIST_DEALER);
					paramFile.setCarDiv(CoConstDef.CAR_IMAGE_DIVISION_CAR);
					
					fileService.carImageFileResize(paramFile, carInfo.getCarFullCode(), carInfo.getCarSeq());
				}
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
		}
		
		// 성능점검번호 업데이트
		
		
		return "success";
	}
	

	@RequestMapping(value={"/bulk/carRegTest"}, method = RequestMethod.GET, produces = "text/html; charset=utf-8")
	public String carRegTest(HttpServletRequest req, HttpServletResponse res, Model model){
		carSchedulerService.regBulkCarInfo();
		return "";
	}
	
	@RequestMapping(value={"/bulk/regTestDealer"}, method = RequestMethod.GET, produces = "text/html; charset=utf-8")
	public String regTestDealer(HttpServletRequest req, HttpServletResponse res, Model model){
/*
		String phoneNo = "01000000000";
		String shopNo = "200393"; //성신모터스(주)
		String danjiNo = "94201"; //서울시자동차매매사업조합
		String licenseNo = "10-000-00000";
		T2Users userBean = new T2Users();
		userBean.setUserName("test딜러");
		userBean.setPassword("bnktest!!00");
		userBean.setPhoneMobile(avoidNull(phoneNo).replaceAll("-", ""));
		userBean.setDivision(CoConstDef.USER_DIVISION_DEALER);
		userBean.setDealerLicenseNo(licenseNo);
		userBean.setGradeDealer("1");
		userBean.setAgreeMarketing(CoConstDef.FLAG_YES);
		userBean.setAgreePushYn(CoConstDef.FLAG_YES);
		userBean.setAgreeSmsYn(CoConstDef.FLAG_YES);
		userBean.setShopNo(shopNo);
		userBean.setActualPhoneMobile(avoidNull(phoneNo).replaceAll("-", ""));
		userBean.setBnkConfYn(CoConstDef.FLAG_NO); //bnk 인증딜러
		userBean.setDanjiNo(danjiNo);
		userBean.setSaleCnt("0");
		userBean.setDealerProfileTel(avoidNull(phoneNo).replaceAll("-", ""));
		userBean.setDealerProfileDesc("정직과 신용으로 최선을 다하겠습니다.");
		userBean.setMigrationFlag(CoConstDef.FLAG_YES);
		userService.addNewUsers(userBean);
		*/
		

		String phoneNo = "010-9343-0635";
		String shopNo = "301719"; //성신모터스(주)
		String danjiNo = "93078"; //서울시자동차매매사업조합
		String licenseNo = "17-031-80196";
		T2Users userBean = new T2Users();
		userBean.setUserName("황인성");
		userBean.setPassword(licenseNo.replaceAll("-", ""));
		userBean.setPhoneMobile(avoidNull(phoneNo).replaceAll("-", ""));
		userBean.setDivision(CoConstDef.USER_DIVISION_DEALER);
		userBean.setDealerLicenseNo(licenseNo);
		userBean.setGradeDealer("1");
		userBean.setAgreeMarketing(CoConstDef.FLAG_YES);
		userBean.setAgreePushYn(CoConstDef.FLAG_YES);
		userBean.setAgreeSmsYn(CoConstDef.FLAG_YES);
		userBean.setShopNo(shopNo);
		userBean.setActualPhoneMobile(avoidNull(phoneNo).replaceAll("-", ""));
		userBean.setBnkConfYn(CoConstDef.FLAG_NO); //bnk 인증딜러
		userBean.setDanjiNo(danjiNo);
		userBean.setSaleCnt("0");
		userBean.setDealerProfileTel(avoidNull(phoneNo).replaceAll("-", ""));
		userBean.setDealerProfileDesc("정직과 신용으로 최선을 다하겠습니다.");
		userBean.setMigrationFlag(CoConstDef.FLAG_YES);
		userService.addNewUsers(userBean);
		
		return "";
	}
	

	@RequestMapping(value={"/bulk/checkBigCar"}, method = RequestMethod.GET, produces = "text/html; charset=utf-8")
	public String checkBigCar(HttpServletRequest req, HttpServletResponse res, Model model){
		
		String licenseNo = req.getParameter("license");
		String plateNo = req.getParameter("plateNo");
		try {
			Car carInfo = carDealerBIGService.getCarInfoFromBIG(plateNo, licenseNo);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return "";
		
	}

}
