package com.bnk.plus.commons.api;

import java.io.File;
import java.io.FileWriter;
import java.math.BigDecimal;
import java.util.ArrayList;
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

public class MigrationCarBulkData2 extends CoTopComponent implements Runnable {

	private static MigrationMapper migrationMapper = (MigrationMapper) getWebappContext().getBean(MigrationMapper.class);
	private static FileMapper fileMapper = (FileMapper) getWebappContext().getBean(FileMapper.class);
	private static FileService fileService = (FileService) getWebappContext().getBean(FileService.class);
	private static CarMarketInfoMapper carMarketInfoMapper = (CarMarketInfoMapper) getWebappContext().getBean(CarMarketInfoMapper.class);
	private static T2UserService userService = (T2UserService) getWebappContext().getBean(T2UserService.class);
	private static CarDealerBIGService carDealerBIGService = (CarDealerBIGService) getWebappContext().getBean(CarDealerBIGService.class);
	private static CarMstMapper carMstMapper = (CarMstMapper) getWebappContext().getBean(CarMstMapper.class);
	
	@Override
	public void run() {

		// 딜러정보 읽어오기
		//File file = new File("D:/00. Project/06. BNK/BNK썸카플러스/전개Data/cardata_migration.xlsx");

		//File file = new File("/home/service/bnk/cardata_migration.xlsx");
		File[] files = new File[1];
		//files[0] = new File("/home/service/bnk/cardata_migration.xlsx");
		files[0] = new File("/home/service/bnk/cardata_migration2.xlsx"); //0717 추가 
		//files[1] = new File("/home/service/bnk/cardata_migration2.xlsx");
		
		
		List<String> bnkDealerList = Arrays.asList(new String[]{
				"1000324346","1000324344","1000324339","1000324196","1000324190","1000324139","1000323934","1000323921","1000323869","1000323867","1000323757","1000323751","1000323738","1000323728","1000323677","1000323672","1000323670","1000323629","1000323626","1000323623","1000323621","1000323620","1000323617","1000323613","1000323612","1000323604","1000323598","1000323594","1000323592","1000323591","1000323590","1000323541","1000323511","1000323342","1000323308","1000323302","1000323300","1000323251","1000323249","1000323248","1000323244","1000323241","1000323239","1000323173","1000323168","1000323166","1000323165","1000323163","1000323162","1000323158","1000323152","1000323151","1000323150","1000323148","1000322974","1000322967","1000322760","1000322753","1000322747","1000322695","1000322468","1000322401","1000322390","1000322341","1000322335","1000322318","1000322233","1000322100","1000322090","1000322060","1000321953","1000321924","1000321833","1000321563","1000321535","1000321507","1000321404","1000321393","1000321383","1000321382","1000321317","1000321172","1000320881","1000320824","1000320823","1000320754","1000320740","1000320739","1000320738","1000320736","1000320735","1000320734","1000320732","1000320723","1000320660","1000320647","1000320512","1000320362","1000320197","1000320144","1000320142","1000319992","1000319890","1000319889","1000319740","1000319738","1000319687","1000319637","1000319636","1000319634","1000319633","1000319568","1000319521","1000319355","1000319342","1000319320","1000319171","1000319112","1000319060","1000319011","1000318951","1000318916","1000318782","1000318609","1000318548","1000318487","1000318464","1000318274","1000318272","1000318269","1000318266","1000318163","1000318127","1000318048","1000317994","1000317880","1000317817","1000317816","1000317815","1000317814","1000317439","1000317427","1000317381","1000317288","1000317210","1000317067","1000316905","1000316904","1000316903","1000316902","1000316901","1000316900","1000316897","1000316896","1000316894","1000316893","1000316891","1000316890","1000316889","1000316886","1000316885","1000316882","1000316881","1000316878","1000316877","1000316876","1000316873","1000316872","1000316871","1000316869","1000316868","1000316867","1000316803","1000316785","1000316772","1000316592","1000316424","1000316414","1000316357","1000316289","1000316283","1000316279","1000316149","1000316148","1000316141","1000316099","1000316098","1000316043","1000316041","1000316005","1000315998","1000315997","1000315872","1000315870","1000315829","1000315816","1000315803","1000315782","1000315779","1000315778","1000315672","1000315664","1000315603","1000315600","1000315572","1000315524","1000315414","1000315244","1000315204","1000315201","1000315191","1000315186","1000315057","1000315055","1000315052","1000314994","1000314984","1000314941","1000314937","1000314932","1000314918","1000314908","1000314907","1000314906","1000314903","1000314900","1000314861","1000314860","1000314859","1000314858","1000314783","1000314760","1000314756","1000314749","1000314593","1000314505","1000314314","1000314310","1000314197","1000314145","1000314034","1000314031","1000313957","1000313945","1000313926","1000313852","1000313851","1000313842","1000313810","1000313806","1000313798","1000313772","1000313755","1000313739","1000313703","1000313697","1000313676","1000313615","1000313610","1000313609","1000313608","1000313588","1000313580","1000313440","1000313421","1000313256","1000313253","1000313127","1000313123","1000313081","1000313064","1000312955","1000312952","1000312921","1000312918","1000312917","1000312881","1000312834","1000312728","1000312724","1000312720","1000312651","1000312641","1000312481","1000312419","1000312281","1000312237","1000312175","1000312163","1000312038","1000311687","1000311632","1000311630","1000311510","1000311421","1000311363","1000311304","1000311277","1000311230","1000311223","1000311072","1000310981","1000310864","1000310775","1000310759","1000310751","1000310618","1000310532","1000310450","1000310432","1000310416","1000310413","1000310409","1000310391","1000310388","1000310167","1000309988","1000309935","1000309638","1000309623","1000309544","1000309541","1000309513","1000309512","1000309230","1000309176","1000309132","1000309094","1000309086","1000309038","1000309036","1000309026","1000308931","1000308912","1000308848","1000308830","1000308829","1000308656","1000308489","1000308448","1000308424","1000308389","1000308376","1000308370","1000308241","1000308176","1000307962","1000307941","1000307936","1000307934","1000307932","1000307759","1000307758","1000307582","1000307372","1000307293","1000307291","1000307283","1000307022","1000306648","1000306630","1000306628","1000306509","1000306499","1000306118","1000306082","1000306081","1000306060","1000306046","1000306036","1000306024","1000305912","1000305852","1000305806","1000305733","1000305720","1000305533","1000305469","1000305334","1000305315","1000305309","1000305044","1000305007","1000304967","1000304933","1000304868","1000304798","1000304778","1000304694","1000304681","1000304625","1000304620","1000304601","1000304596","1000304523","1000304462","1000304260","1000304198","1000304194","1000304193","1000304189","1000304188","1000304187","1000304186","1000304184","1000304182","1000304168","1000304002","1000303916","1000303657","1000303545","1000303409","1000303407","1000303404","1000303362","1000303299","1000303287","1000303285","1000303284","1000303283","1000303281","1000303215","1000303168","1000303099","1000303082","1000303026","1000303024","1000302897","1000302850","1000302752","1000302703","1000302676","1000302666","1000302629","1000302581","1000302408","1000302391","1000302389","1000302387","1000302384","1000302383","1000302381","1000302380","1000302379","1000302378","1000302374","1000302373","1000302369","1000301964","1000301933","1000301930","1000301859","1000301770","1000301727","1000301722","1000301489","1000301477","1000301450","1000301363","1000301206","1000301136","1000301066","1000301008","1000301007","1000300986","1000300734","1000300296","1000300145","1000299889","1000299834","1000299747","1000299727","1000299680","1000299661","1000299536","1000299506","1000299455","1000299302","1000299256","1000299223","1000299140","1000299139","1000299088","1000299067","1000299066","1000298998","1000298979","1000298881","1000298827","1000298802","1000298801","1000298786","1000298689","1000298676","1000298586","1000298558","1000298553","1000298443","1000298335","1000298334","1000298323","1000298237","1000298236","1000298195","1000298066","1000298024","1000297983","1000297974","1000297972","1000297966","1000297951","1000297949","1000297947","1000297942","1000297936","1000297930","1000297928","1000297922","1000297283","1000296795","1000296775","1000296706","1000296657","1000296463","1000296294","1000296178","1000296166","1000296108","1000295924","1000295857","1000295488","1000295408","1000295377","1000295301","1000295264","1000295213","1000295187","1000294869","1000294850","1000294645","1000294609","1000294431","1000294391","1000294341","1000294321","1000294295","1000294293","1000294292","1000294090","1000294000","1000293976","1000293854","1000293817","1000293801","1000293752","1000293696","1000293632","1000293518","1000293289","1000293245","1000293057","1000292983","1000292936","1000292918","1000292866","1000292722","1000292565","1000292326","1000292318","1000292317","1000292305","1000292301","1000292282","1000292237","1000292234","1000292227","1000292184","1000292102","1000292100","1000292073","1000292038","1000291927","1000291925","1000291886","1000291874","1000291531","1000291513","1000291474","1000291390","1000291365","1000291360","1000291238","1000291082","1000290999","1000290989","1000290978","1000290977","1000290972","1000290968","1000290946","1000290900","1000290842","1000290701","1000290648","1000290647","1000290449","1000290448","1000290445","1000290401","1000290396","1000290282","1000290279","1000290257","1000290166","1000290141","1000290134","1000289986","1000289851","1000289845","1000289821","1000289762","1000289721","1000289713","1000289687","1000289684","1000289471","1000289204","1000289051","1000288940","1000288939","1000288937","1000288917","1000288870","1000288817","1000288780","1000288552","1000288362","1000288300","1000288251","1000288232","1000288156","1000288133","1000288083","1000288066","1000287925","1000287916","1000287876","1000287858","1000287842","1000287814","1000287784","1000287783","1000287782","1000287698","1000287656","1000287559","1000287548","1000287435","1000287416","1000287324","1000287242","1000287230","1000287229","1000287169","1000287119","1000287033","1000286899","1000286843","1000286765","1000286679","1000286660","1000286622","1000286621","1000286619","1000286618","1000286613","1000286586","1000286565","1000286562","1000286397","1000286262","1000286256","1000286197","1000286143","1000286138","1000286124","1000286102","1000286092","1000286085","1000286082","1000286035","1000285906","1000285899","1000285896","1000285894","1000285893","1000285885","1000285883","1000285879","1000285872","1000285844","1000285839","1000285837","1000285834","1000285832","1000285830","1000285820","1000285800","1000285781","1000285780","1000285777","1000285773","1000285760","1000285758","1000285754","1000285750","1000285748","1000285747","1000285746","1000285745","1000285744","1000285743","1000285741","1000285734","1000285733","1000285729","1000285713","1000285711","1000285709","1000285706","1000285705","1000285700","1000285691","1000285648","1000285638","1000284926","1000284922","1000284921","1000284443","1000284419","1000284307","1000283593","1000281767","1000280058","1000273510","1000271595","1000267254","1000258765","1000258133","1000252783","1000251868","1000249751","1000246467","1000244641","1000240844","1000235878","1000231816","1000219264","1000218207","1000210808","1000210804","1000210803","1000210800","1000200373","1000200017","1000197968","1000187080","1000187046","1000187042","1000187035","1000186885","1000182641","1000182226","1000182206","1000182132","1000182129","1000182096","1000182095"
		});
		
		int MAX_CAR_CNT_D = 300;
		int MAX_CAR_CNT_F = 100;
		int carCntDom = 0; // 국산차
		int carCntFor = 0; // 외제차
		int errCnt = 0;
		
		int regDealercnt = 0;
		
		File migFile1 = new File("/home/service/bnk/userErr.txt");
		File migFile2 = new File("/home/service/bnk/carErr.txt");
		FileWriter fw1 = null;
		FileWriter fw2 = null;
		try {
			fw1 = new FileWriter(migFile1, true) ;
			fw2 = new FileWriter(migFile2, true) ;
			
			fw1.write("\r\n");
			fw1.write("############ start #############");

			fw2.write("\r\n");
			fw2.write("############ start #############");
			
			for(File file : files) {

				Workbook wb = WorkbookFactory.create(file);
				Sheet sheet = wb.getSheet("Sheet1");
				Map<String, Integer> carCodeMaxInfo = new HashMap<>(); // 상세모델별 최대 10건 까지만
				
				int totalCarCnt = 0;

				for(int rowIdx = 1; rowIdx < sheet.getPhysicalNumberOfRows(); rowIdx++) {
					System.out.println("## reg Dealer Cnt : " + rowIdx);
					
					
//					if(carCntDom > MAX_CAR_CNT_D && carCntFor > MAX_CAR_CNT_F) {
//						break;
//					}
					
					Row row = sheet.getRow(rowIdx);
					if(row == null) {
						continue;
					}
					int cellIdx = 0;
					// shopno 딜러명	종사원번호	소속단지	소속상사
//					String shopNo = getCellData(row.getCell(cellIdx++)).trim();
//					String dealerName = getCellData(row.getCell(cellIdx++)).trim();
//					String licenseNo = getCellData(row.getCell(cellIdx++)).trim();
//					String danjiName = getCellData(row.getCell(cellIdx++)).trim();
//					String shopName = getCellData(row.getCell(cellIdx)).trim();
					
					
					String shopNo = "";
					String dealerName = "";
					String licenseNo = "";
					String danjiName = "";
					String phoneNo = "";
					
					
					//String excelShopName = getCellData(row.getCell(cellIdx++)).trim();
					//String excelUserName = getCellData(row.getCell(cellIdx++)).trim();
					//String excelLicenseNo = getCellData(row.getCell(cellIdx++)).trim();
					//String excelPhone = getCellData(row.getCell(cellIdx++)).trim();
					String excelUserNo = getCellData(row.getCell(cellIdx++)).trim();
					
					String defaultReadStr = excelUserNo + "|";
					
					String area = "";
					
					String danjiNo = null;
					
					// shop | user | license | phone | use no | car no | error
					if(isEmpty(excelUserNo)) {
						fw1.write(defaultReadStr + "user no is empty");
						fw1.write("\r\n");
						continue;
					}
					
					
					
					// 실매물 정보에서 user no가 가진 매물정보를 가져온다.
					CarMarketInfo tmpcar = carMarketInfoMapper.getCarInfoWithUserNoForMigration(excelUserNo);
					
					if(tmpcar != null) {
						licenseNo = tmpcar.getLicenseNo();
						shopNo = tmpcar.getShopNo();
						dealerName = tmpcar.getUserName();
						phoneNo = tmpcar.getUserHp();
					}
					
					// licenseNo
					if(isEmpty(shopNo)) {
						fw1.write(defaultReadStr + "shopNo is empty");
						fw1.write("\r\n");
						continue;
					}
					
					if(isEmpty(licenseNo)) {
						fw1.write(defaultReadStr + "licenseNo is empty");
						fw1.write("\r\n");
						continue;
					}
					
					if(isEmpty(dealerName)) {
						fw1.write(defaultReadStr + "dealerName is empty");
						fw1.write("\r\n");
						continue;
					}
					
					if(isEmpty(phoneNo)) {
						fw1.write(defaultReadStr + "phoneNo is empty");
						fw1.write("\r\n");
						continue;
					}
					
					// 소속상사 체크
					if(!CoCodeManager.SHOP_CODE_INFO.containsKey(shopNo)) {
						fw1.write(defaultReadStr + "cannot find shop Info");
						fw1.write("\r\n");
						continue;
					} else {
						Market bean = (Market) CoCodeManager.SHOP_CODE_INFO.get(shopNo);
						danjiNo = bean.getDanjino();
						area = bean.getDanjisido();
					}
					
					if(isEmpty(danjiNo)) {
						fw1.write(defaultReadStr + "cannot find danjiNo Info");
						fw1.write("\r\n");
						continue;
					}
					

					boolean isBnk = bnkDealerList.contains(excelUserNo);

					List<CarMarketInfo> carList = carMarketInfoMapper.getCarListWithUserNoForMigration(excelUserNo);

					// 등록 대상 딜러 LIST 구성
					// 종사자번호에 해당하는 실매물 정보를 취득
					//List<CarMarketInfo> carList = carMarketInfoMapper.getDealerInfoFromCarListForMigration(licenseNo);
					
					String userId = migrationMapper.getCntDealerByLicenseNo(licenseNo);
					// 이미등록되어 잇는 딜러인지 확인
					if(isEmpty(userId)) {

						// 전화번호 변경
						//_temp.setUserHp("01000000000");
						
						T2Users userBean = new T2Users();
						userBean.setUserName(dealerName);
						//userBean.setPassword("bnktest!!00");
						userBean.setPassword(avoidNull(licenseNo).replaceAll("-", ""));
						userBean.setPhoneMobile(avoidNull(phoneNo).replaceAll("-", ""));
						userBean.setDivision(CoConstDef.USER_DIVISION_DEALER);
						userBean.setDealerLicenseNo(licenseNo);
						userBean.setGradeDealer("1");
						userBean.setAgreeMarketing(CoConstDef.FLAG_YES);
						userBean.setAgreePushYn(CoConstDef.FLAG_YES);
						userBean.setAgreeSmsYn(CoConstDef.FLAG_YES);
						userBean.setShopNo(shopNo);
						userBean.setActualPhoneMobile(avoidNull(phoneNo).replaceAll("-", ""));
						userBean.setBnkConfYn(isBnk ? CoConstDef.FLAG_YES : CoConstDef.FLAG_NO); //bnk 인증딜러
						userBean.setDanjiNo(danjiNo);
						userBean.setSaleCnt(Integer.toString(carList.size()));
						userBean.setDealerProfileTel(avoidNull(phoneNo).replaceAll("-", ""));
						userBean.setDealerProfileDesc("정직과 신용으로 최선을 다하겠습니다.");
						userBean.setMigrationFlag(CoConstDef.FLAG_YES);
						userService.addNewUsers(userBean);
						
						userId = userBean.getUserId();
					
					}
					

					// 매물 등록
					if(carList != null && !carList.isEmpty()) {
						for(CarMarketInfo bean : carList) {
							
							if(migrationMapper.existsCarPlateNumber(bean.getCarPlateNumber()) > 0) {
								fw2.write(defaultReadStr + bean.getCarNo() + "|" + "CarPlateNumber is exists : " + bean.getCarPlateNumber());
								fw2.write("\r\n");
								continue;
							}
							// 매물 정보 가져오기
							Car carInfo = null;
							try {
								//carInfo = carDealerBIGService.getCarInfoFromBIG(bean.getCarPlateNumber(), licenseNo);
								carInfo = getCarInfoFromDatabase(bean.getCarNo());
								if(carInfo != null) {
									
									if(isEmpty(carInfo.getFileSeqs())) {
										// 매물 이미지가 없는 경우
										fw2.write(defaultReadStr + bean.getCarNo() + "|" + "car image is empty");
										fw2.write("\r\n");
										continue;
									}
									
//									if(StringUtil.string2integer(avoidNull(carInfo.getSaleAmt(), "0")) > 0) {
//										// 가격이 0인 경우
//										continue;
//									}
									if(isEmpty(carInfo.getCarFullCode())) {
										fw2.write(defaultReadStr + bean.getCarNo() + "|" + "CarFullCode is empty");
										fw2.write("\r\n");
										continue;
									}
									
//									if(carInfo.getCarFullCode().startsWith("A") && carCntDom > MAX_CAR_CNT_D) {
//										continue;
//									}
//									if(!carInfo.getCarFullCode().startsWith("A") && carCntFor > MAX_CAR_CNT_F) {
//										continue;
//									}
									if(isEmpty(bean.getCarAmountSale()) || "0".equals(bean.getCarAmountSale())) {
										fw2.write(defaultReadStr + bean.getCarNo() + "|" + "CarAmountSale is 0");
										fw2.write("\r\n");
										continue;
									}
									
									// 매물정보 DB 등록
									carInfo.setUserId(userId);
									carInfo.setLoginUserName(userId);
									carInfo.setShopNo(shopNo);
									carInfo.setDanjiNo(danjiNo);
									carInfo.setCarArea(area);
									carInfo.setCarState("1");
									
									// 판매가격
									carInfo.setSaleAmt(bean.getCarAmountSale());

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
									
									String _chk = bean.getCarFullcode().substring(0, 8);
									if(carCodeMaxInfo.containsKey(_chk)) {
										carCodeMaxInfo.put(_chk, carCodeMaxInfo.get(_chk)+1);
									} else {
										carCodeMaxInfo.put(_chk, 1);
									}
									

									if(carInfo.getCarFullCode().startsWith("A")) {
										carCntDom ++;
									} else {
										carCntFor ++;
									}
								} else {
									fw2.write(defaultReadStr + bean.getCarNo() + "|" + "error on get BIG data");
									fw2.write("\r\n");
								}								
							} catch (Exception e) {
								// TODO: handle exception
								e.printStackTrace();
								fw2.write(defaultReadStr + bean.getCarNo() + "|" + e.getMessage());
								fw2.write("\r\n");
								errCnt ++;
							}
						}
						
					} else {
						fw2.write(defaultReadStr + "car list is empty");
						fw2.write("\r\n");
					}
				}
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
	

	private Car getCarInfoFromDatabase(String carNo) {
		
		Car carBean = null;
		try {

			Map<String, String> carInfoMap = carMarketInfoMapper.getCarInfoWithCarNoForMigration(carNo);
			


	        String _carNo = carInfoMap.get("CAR_NO");
	        String _carPlateNumber = carInfoMap.get("CAR_PLATE_NUMBER"); //차량번호
	        String _carFullcode = carInfoMap.get("CAR_FULL_CODE"); //차량코드 10자리
	        String _carFrameNo = carInfoMap.get("CAR_FRAME_NO");
	        String _carRegDay = carInfoMap.get("CAR_REGDAY"); // 차량최초등록일
	        String _carRegYear = carInfoMap.get("CAR_REGYEAR"); // 년식
	        String _carMission = carInfoMap.get("CAR_MISSION"); // 미션
	        String _carFuel = carInfoMap.get("CAR_FUEL"); // 연료
	        String _carUseKm = carInfoMap.get("CAR_USEKM"); // 주행거리
	        String _WonbuUseKm = carInfoMap.get("WONBUUSEKM"); //원보상 주행거리
	        String _SagoYn = carInfoMap.get("CAR_SAGOYN"); // 사고여부
	        String _CarCheckNo = carInfoMap.get("CAR_CHECKOUT_NO");// 점검번호
	        String _carColor = carInfoMap.get("CAR_COLOR"); // 색상
	        String _oprionStr = carInfoMap.get("CAROPTION"); // 옵션

	    	// 사진정보 가져오기
	    	List<T2File> imageList = new ArrayList<>();

	        for (int i = 1; i <= 20; i++) {
	        	String imageUrl = (String) carInfoMap.get("CARPHOTOURL"+i);
	        	if(!isEmpty(imageUrl)) {
	        		T2File _f = fileService.customFileRegFromUrl(imageUrl);
	        		if(_f != null) {
	        			imageList.add(_f);
	        		}
	        	}
	        }

	        carBean = new Car();
	        // 차량 정보 Entity로 변환
	        carBean.setCarNo(_carNo);
	        carBean.setCarPlateNum(_carPlateNumber);
	        carBean.setCarFullCode(_carFullcode);
	        carBean.setCarFrameNum(_carFrameNo);
	        carBean.setCarRegDay(_carRegDay);
	        carBean.setCarRegYear(_carRegYear);
	        // 연료 name to code
	        carBean.setCarFuel(avoidNull(CoCodeManager.getCodeConvertWithExp(CoConstDef.SYS_CODE_CAR_FUEL_TYPE, _carFuel), CoConstDef.CD_DTL_CAR_FUEL_TYPE_ETC));
	        // 변속기
	        carBean.setCarMission(avoidNull(CoCodeManager.getCodeConvertWithExp(CoConstDef.SYS_CODE_CAR_MISSION_TYPE, _carMission), CoConstDef.CD_DTL_CAR_MISSION_ETC));
	        // 주행거리
	        carBean.setUseKm(_carUseKm);
	        // 원보상 주행거리
	        carBean.setUseKmWonbu(_WonbuUseKm);
	        // 사고여부
	        carBean.setSagoYn(_SagoYn);
	        // 점검번호
	        carBean.setCarCheckNo(_CarCheckNo);
	        // 색상
	        carBean.setCarColor(avoidNull(CoCodeManager.getCodeConvertWithExp(CoConstDef.SYS_CODE_CAR_COLOR_TYPE, _carColor), CoConstDef.CD_DTL_CAR_COLOR_ETC));
	        // 옵션
	        String _optArrStr = "";
	        for(String optName : avoidNull(_oprionStr).split("[,]")) {
	        	if(!isEmpty(optName)) {
	        		String convertRtn = convertOptionNameToCode(optName);
	        		if(!isEmpty(convertRtn)) {
		            	if(!isEmpty(_optArrStr)) {
		            		_optArrStr += ",";
		            	}
		            	_optArrStr += convertRtn;
	        		}
	        	}
	        }
	        carBean.setOptionCds(_optArrStr);
	        carBean.setOptionCdArr(_optArrStr);

	        //resultMap.put("carSaleInfo", carBean);
	        //resultMap.put("imageList", imageList);
	        if(imageList != null) {
	        	String _fileSeqs = "";
	        	for(T2File imgFile : imageList) {
	        		if(!isEmpty(_fileSeqs)) {
	        			_fileSeqs += ",";
	        		}
	        		_fileSeqs += imgFile.getFileSeq();
	        	}
	        	carBean.setFileSeqs(_fileSeqs);
	        }

	        carBean.setCarImageFileList(imageList);
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return null;
		}

        return carBean;
	}


	private static String getCellData(Cell cell) {
		String value = "";
		try {

			if(cell == null){
				value = "";
			}else{
				int cellType = cell.getCellType();
				switch (cellType) {
				case HSSFCell.CELL_TYPE_FORMULA:
					if(HSSFCell.CELL_TYPE_NUMERIC == cell.getCachedFormulaResultType()){
						//value = Double.toString((double) cell.getNumericCellValue());
						cell.setCellType(Cell.CELL_TYPE_STRING);
						value = cell.getStringCellValue();	
					}else if(HSSFCell.CELL_TYPE_STRING == cell.getCachedFormulaResultType()){
						value = cell.getStringCellValue();	
					}
					break;
				case HSSFCell.CELL_TYPE_NUMERIC:
					//value = String.valueOf((long) cell.getNumericCellValue());
					/*cell.setCellType(Cell.CELL_TYPE_STRING);
					value = cell.getStringCellValue();*/	
					//value = Double.toString(cell.getNumericCellValue());
					// 2017.04.03 yuns 실제로 숫자가 아닌데 숫자로 인식되어 String으로 casting 결과 소수점이 붙는 경우가 있어서 추가
					cell.setCellType(Cell.CELL_TYPE_STRING);
					value = cell.getStringCellValue();
//					if(_temp.indexOf(".") == -1 && value.indexOf(".") > -1) {
//						value = value.substring(0, value.indexOf("."));
//					}
					
					break;
				case HSSFCell.CELL_TYPE_STRING:
					value = cell.getStringCellValue() + "";
					break;
				case HSSFCell.CELL_TYPE_BLANK:
					value = cell.getStringCellValue() + "";
					break;
				case HSSFCell.CELL_TYPE_ERROR:
					value = cell.getErrorCellValue() + "";
					break;
				default:
					break;
				}
			}
		} catch (Exception e) {
			// TODO: handle exception
			value = "";
		}
		// 트림으로 공백 제거 되지 않는것들 정규식으로 앞 뒤 공백만 제거 한다
		return "false".equals(value) ? "" : StringUtil.trim(avoidNull(value));
	}
	/**
	 * BIG의 옵션 정보(text)를 코드로 변환한다.
	 * @param optName
	 * @return
	 */
	private String convertOptionNameToCode(String optName) {
		String rtn = "";
		if(!isEmpty(optName)) {
			for(String s : CoCodeManager.getCodes(CoConstDef.SYS_CODE_CAR_OPTION_TYPE)) {
				if(!isEmpty(s) && !isEmpty(CoCodeManager.getCdSubNo(CoConstDef.SYS_CODE_CAR_OPTION_TYPE, s))) {
					rtn = CoCodeManager.getCodeConvertWithExp(CoCodeManager.getCdSubNo(CoConstDef.SYS_CODE_CAR_OPTION_TYPE, s), optName.trim());
					if(!isEmpty(rtn)) {
						break;
					}
				}
			}
		}
		return rtn;
	}
}
