package com.bnk.plus.commons.api;

import java.io.File;
import java.io.FileWriter;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;
import org.springframework.beans.factory.annotation.Autowired;

import com.bnk.plus.commons.CoCommonFunc;
import com.bnk.plus.commons.CoConstDef;
import com.bnk.plus.commons.cdManager.CoCodeManager;
import com.bnk.plus.commons.components.CoTopComponent;
import com.bnk.plus.commons.util.StringUtil;
import com.bnk.plus.entity.Car;
import com.bnk.plus.entity.CarMarketInfo;
import com.bnk.plus.entity.Market;
import com.bnk.plus.entity.T2File;
import com.bnk.plus.entity.T2Users;
import com.bnk.plus.service.api.FileService;
import com.bnk.plus.service.car.persistence.CarMarketInfoMapper;
import com.bnk.plus.service.car.persistence.CarMstMapper;
import com.bnk.plus.service.car.service.CarDealerBIGService;
import com.bnk.plus.service.car.service.UserApiService;
import com.bnk.plus.service.common.persistence.commons.api.FileMapper;
import com.bnk.plus.service.common.persistence.commons.api.MigrationMapper;
import com.bnk.plus.service.session.service.T2UserService;

public class MigrationCarBulkDataForBnkConfDealer extends CoTopComponent implements Runnable {

	private static MigrationMapper migrationMapper = (MigrationMapper) getWebappContext().getBean(MigrationMapper.class);
	private static FileMapper fileMapper = (FileMapper) getWebappContext().getBean(FileMapper.class);
	private static FileService fileService = (FileService) getWebappContext().getBean(FileService.class);
	private static CarMarketInfoMapper carMarketInfoMapper = (CarMarketInfoMapper) getWebappContext().getBean(CarMarketInfoMapper.class);
	private static T2UserService userService = (T2UserService) getWebappContext().getBean(T2UserService.class);
	private static CarDealerBIGService carDealerBIGService = (CarDealerBIGService) getWebappContext().getBean(CarDealerBIGService.class);
	private static CarMstMapper carMstMapper = (CarMstMapper) getWebappContext().getBean(CarMstMapper.class);
	
	private String P_KFC_USER_NO = null;
	private String P_USER_ID = null;
	public MigrationCarBulkDataForBnkConfDealer(String userId, String kfcUserNo) {
		// TODO Auto-generated constructor stub
		this.P_USER_ID = userId;
		this.P_KFC_USER_NO = kfcUserNo;
	}


	@Override
	public void run() {

		int errCnt = 0;
		
		File migFile1 = new File("/home/service/bnk/userErrForConfDealer_"+CoCommonFunc.getCurrentDateTime(CoConstDef.DISP_FORMAT_DATE_TAG_SIMPLE_NUMBER)+".txt");
		File migFile2 = new File("/home/service/bnk/carErrForConfDealer_"+CoCommonFunc.getCurrentDateTime(CoConstDef.DISP_FORMAT_DATE_TAG_SIMPLE_NUMBER)+".txt");
		FileWriter fw1 = null;
		FileWriter fw2 = null;
		try {
			fw1 = new FileWriter(migFile1, true) ;
			fw2 = new FileWriter(migFile2, true) ;
			
			fw1.write("\r\n");
			fw1.write("############ start #############");

			fw2.write("\r\n");
			fw2.write("############ start #############");
			
			int totalCarCnt = 0;

			// 사용자 정보를 가져온다.
			T2Users userInfo = userService.getUserBasicInfoById(P_USER_ID);
			
			// 추가된 매물 정보를 취득한다.
			if(userInfo == null || isEmpty(userInfo.getDealerLicenseNo())) {
				throw new Exception("USER INFO IS NULL, USER_NO : " + P_USER_ID);
			}
			
			
			
			List<HashMap<String, String>> carList = migrationMapper.getUnRegCarListByUserNo(P_KFC_USER_NO);

			// 매물 등록
			if(carList != null && !carList.isEmpty()) {
				for(Map<String, String> carMap : carList) {
					
					String plateNum = carMap.get("CAR_PLATE_NUMBER");
					String amountSale = carMap.get("CAR_AMOUNT_SALE");
					String carNo = carMap.get("CAR_NO");
					
					if(isEmpty(plateNum)) {
						continue;
					}
					
					if(migrationMapper.existsCarPlateNumber(plateNum) > 0) {
						continue;
					}
					// 매물 정보 가져오기
					Car carInfo = null;
					try {
						carInfo = carDealerBIGService.getCarInfoFromBIG(plateNum, userInfo.getDealerLicenseNo());
						if(carInfo != null) {
							
							if(isEmpty(carInfo.getFileSeqs())) {
								// 매물 이미지가 없는 경우
								fw2.write(carNo + "|" + "car image is empty");
								fw2.write("\r\n");
								continue;
							}
							
//							if(StringUtil.string2integer(avoidNull(carInfo.getSaleAmt(), "0")) > 0) {
//								// 가격이 0인 경우
//								continue;
//							}
							if(isEmpty(carInfo.getCarFullCode())) {
								fw2.write(carNo + "|" + "CarFullCode is empty");
								fw2.write("\r\n");
								continue;
							}
							
//							if(carInfo.getCarFullCode().startsWith("A") && carCntDom > MAX_CAR_CNT_D) {
//								continue;
//							}
//							if(!carInfo.getCarFullCode().startsWith("A") && carCntFor > MAX_CAR_CNT_F) {
//								continue;
//							}
							if(isEmpty(amountSale) || "0".equals(amountSale)) {
								fw2.write(carNo + "|" + "CarAmountSale is 0");
								fw2.write("\r\n");
								continue;
							}
							
							Market bean = (Market) CoCodeManager.SHOP_CODE_INFO.get(userInfo.getShopNo());
							
							// 매물정보 DB 등록
							carInfo.setUserId(userInfo.getUserId());
							carInfo.setLoginUserName(userInfo.getUserId());
							carInfo.setShopNo(userInfo.getShopNo());
							carInfo.setDanjiNo(bean.getDanjino());
							carInfo.setCarArea(bean.getDanjisido());
							carInfo.setCarState("1");
							
							// bnk 인증 딜러이기 때문에 flag update 처리를 함
							carInfo.setCarGuarFruitlessYn(CoConstDef.FLAG_YES);
							carInfo.setCarGuarRefundYn(CoConstDef.FLAG_YES);
							carInfo.setCarGuarTermYn(CoConstDef.FLAG_YES);
							
							// 판매가격
							carInfo.setSaleAmt(amountSale);

							// 매물정보
							carMstMapper.insertCarModel(carInfo);
							totalCarCnt++;

							System.out.println("## totalCarCnt : " + totalCarCnt);
							
							// 옵션정보
							String[] optionCdArr = carInfo.getOptionCdArr();
							if(optionCdArr != null && optionCdArr.length > 0){
								carMstMapper.saveCarOption(carInfo);
							}
							
							// 이미지 원본 group id
							if(!isEmpty(carInfo.getFileSeqs())) {
								carMstMapper.updateCarModelDealerToFileId(carInfo);
								
								String[] fileSeqs = carInfo.getFileSeqs().split("[,]");
								T2File paramFile = new T2File();
								paramFile.setFileSeqs(fileSeqs);
								paramFile.setFileGroupId(carInfo.getCarSeq());
								paramFile.setContentType(CoConstDef.CD_CAR_REGIST_DEALER);
								paramFile.setCarDiv(CoConstDef.CAR_IMAGE_DIVISION_CAR);
								fileMapper.saveFileGroupId(paramFile);
								
								try {
									fileService.carImageFileResize(paramFile, carInfo.getCarFullCode(), carInfo.getCarSeq());
								} catch (Exception e) {
									log.error(e.getMessage(), e);
								}
								
							}
							
						} else {
							fw2.write(carNo + "|" + "error on get BIG data");
							fw2.write("\r\n");
						}								
					} catch (Exception e) {
						// TODO: handle exception
						fw2.write(carNo + "|" + e.getMessage());
						fw2.write("\r\n");
						errCnt ++;
					}
				}
				
			} else {
				fw2.write(P_USER_ID + " car list is empty");
				fw2.write("\r\n");
			}
					
			
			
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		} finally {

			try {
				fw1.write("\r\n");
				fw1.write("############ END #############");

				fw2.write("\r\n");
				fw2.write("############ END #############");
	            fw1.flush();
	            fw1.close();
	            fw2.flush();
	            fw2.close();
			} catch (Exception e2) {
				// TODO: handle exception
			}

		}
		
		System.out.println("END------------------");
		System.out.println("ERROR CNT : " + errCnt);
	}
	
}
