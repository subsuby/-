package com.bnk.plus.commons.cdManager;

import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Vector;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.bnk.plus.commons.CoCommonFunc;
import com.bnk.plus.commons.CoConstDef;
import com.bnk.plus.commons.cdManager.beans.CoCode;
import com.bnk.plus.commons.cdManager.beans.CoCodeDtl;
import com.bnk.plus.commons.cdManager.dao.CdMgrDao;
import com.bnk.plus.commons.components.CoTopComponent;
import com.bnk.plus.entity.Market;
import com.bnk.plus.entity.commons.cdManager.CarCodeBean;
import com.bnk.plus.entity.commons.cdManager.CodeDtlBean;
import com.bnk.plus.service.common.persistence.commons.cdManager.CodeManagerCarCodeMapper;
import com.bnk.plus.service.dealer.persistence.MarketMapper;
import com.google.gson.Gson;

@Component
public class CoCodeManager extends CoTopComponent {

	protected static Log logger = LogFactory.getLog("CodeManager");
	private static CoCodeManager instance;
	private static HashMap<String, CoCode> codes;
	private static Vector<String[]> emptyVector;
	private static Vector<CoCodeDtl> emptyVectorBean;

	/*
	private static CodeManagerMapper codeMapper;
	@SuppressWarnings("static-access")
	@Autowired
	public void setCodeManagerMapper(CodeManagerMapper mapper) {
		this.codeMapper = mapper;
		// 차량코드 조회
		//refreshCarCode();
	}
	*/

	private static CdMgrDao cdMgrDao;
	@SuppressWarnings("static-access")
	@Autowired
	public void setCdMgrDao(CdMgrDao cdMgrDao) {
		this.cdMgrDao = cdMgrDao;
		init();
		if((CAR_CODE_INFO == null || CAR_CODE_INFO.isEmpty()) && carCodeMapper != null) {
			refreshCarCode();
		}
	}

	private static CodeManagerCarCodeMapper carCodeMapper;
	@SuppressWarnings("static-access")
	@Autowired
	public void setCodeManagerCarCodeMapper(CodeManagerCarCodeMapper mapper) {
		this.carCodeMapper = mapper;
		// 차량코드 조회
		if(instance != null && (CAR_CODE_INFO == null || CAR_CODE_INFO.isEmpty())) {
			refreshCarCode();
		}
	}



	private static MarketMapper marketMapper;
	@SuppressWarnings("static-access")
	@Autowired
	public void setMarketMapper(MarketMapper mapper) {
		this.marketMapper = mapper;
		// 차량코드 조회
		refreshMarketCode();
	}

	/**
	 * 차량 코드 정보 검색(등록)조건용 10자리 코드에 대해서, 제조사, 모델, 세부모델, 등급별 코드를 key로 참조 예) "AA" :
	 * 한국 => "현대자동차, 기아자동차, 삼성자동차 ....." "AAA" :한국+현대자동차 => "그랜저, 다이너스티, 에쿠스,
	 * 마르샤, 소나타...." "AAA11":한국+현대자동차+그랜저 => "그랜저, 뉴그랜저, 그랜저XG, 뉴그랜저XG, 그랜저TG,
	 * 그랜저TG뉴럭셔리...."
	 */
	public static Map<String, Map<String, String>> CAR_CODE_SEARCH_INFO = new LinkedHashMap<>();
	/**
	 * 차량코드에 따른 세부정보 (차명등에 사용)
	 */
	public static Map<String, CarCodeBean> CAR_CODE_INFO = new LinkedHashMap<>();

	/**
	 * 퀵검색 자동완성을 위한 차량정보
	 */
	public static Vector<Map<String, String>> CAR_CODE_QUICK_SEARCH = new Vector<Map<String, String>>();

	/**
	 * SNC 전체 매매상사 조회
	 */
	public static Map<String, Object> SHOP_CODE_INFO = new HashMap<>();

	/**
	 * SNC 지역별 매매단지 코드 조회
	 */
	public static Map<String, Map<String, Object>> AREA_DANJI_CODE_INFO = new HashMap<>();

	private CoCodeManager() {
	}

	private static void init() {
		if(codes == null) {
			codes = new HashMap<String, CoCode>();
		}
		emptyVector = new Vector<String[]>();
		instance = new CoCodeManager();
		List<CodeDtlBean> list = null;
		CoCode code = null;
		CoCodeDtl codedtl = null;

		try {
			list = cdMgrDao.getCodeListAll();

			if (list == null) {
				throw new RuntimeException("SYSTEM ERR GET CODE INFO FAIL");
			}

			for (CodeDtlBean vo : list) {
				String s = vo.getCdNo();
				code = (CoCode) codes.get(s);
				if (code == null) {
					code = new CoCode(s, vo.getCdNm());
					codes.put(s, code);
				}
				codedtl = new CoCodeDtl(vo.getCdNo(), vo.getCdDtlNo(), vo.getCdSubNo(), vo.getCdDtlNm(),
						vo.getCdDtlNm2(), vo.getCdDtlExp(),
						Integer.parseInt(CoCommonFunc.avoidNull(vo.getCdOrder(), "1")),
						CoCommonFunc.avoidNull(vo.getUseYn(), CoConstDef.FLAG_YES));

				code.addCodeDtl(codedtl);
			}
		} catch (Exception e) {
			logger.error(e.getMessage(), e);
		}

	}

	public void refreshMarketCode() {

		List<Market> marketList = null;
		try {
			// DB정보 취득
			marketList = marketMapper.selectMarketList(new Market());
		} catch (Exception e) {
			logger.error(e.getMessage(), e);
		}

		if (marketList == null) {
			throw new RuntimeException("SYSTEM ERR GET CAR CODE INFO FAIL");
		}

		// 매매단지 코드 map 정보
		Map<String, Object> _shopCodeInfoMap = new LinkedHashMap<>();

		// 전체 매매단지 -> 전체 매매상사 정보
		for (Market mBean : marketList) {
			for (int i = 0; i < mBean.getShopList().size(); i++) {
				Market sBean = mBean.getCodeBean(i);
				// 매매단지번호 필수,매매상사번호 필수
				if (!isEmpty(sBean.getDanjino()) && !isEmpty(sBean.getShop().getShopno())) {
					// 매매상사번호 정보 등록
					if (!_shopCodeInfoMap.containsKey(sBean.getShop().getShopno())) {
						_shopCodeInfoMap.put(sBean.getShop().getShopno(), sBean);
					}
					// 매매단지번호,매매상사번호 빈값 예외처리
					else {
						logger.warn((new StringBuilder()).append("Shop No").append(" is empty.").toString());
					}
				}
			}
		}
		if (_shopCodeInfoMap != null && !_shopCodeInfoMap.isEmpty()) {
			SHOP_CODE_INFO = _shopCodeInfoMap;
		}
	}

	/**
	 * SNC DB를 조회하여 차량정보 생성
	 */
	public void refreshCarCode() {

		{
			List<CarCodeBean> list = null;
			try {
				// DB정보 취득
				list = carCodeMapper.getCarCodeList();
				//list = codeMapper.getCarCodeList();
			} catch (Exception e) {
				logger.error(e.getMessage(), e);
			}

			if (list == null) {
				throw new RuntimeException("SYSTEM ERR GET CAR CODE INFO FAIL");
			}

			// 차량코드 map 정보 생성
			Map<String, Map<String, String>> _carCodeMap = new LinkedHashMap<>();
			Map<String, String> _makerListMap = new LinkedHashMap<>();
			Map<String, String> _makerMap;
			Map<String, String> _modelMap;
			Map<String, String> _detailModelMap;

			Map<String, CarCodeBean> _carCodeInfoMap = new LinkedHashMap<>();
			// Map<String, String> _gradeMap;
			String _key = "";
			String _subKey = "";
			// 2017-07-22 jy-seo
			// BNK 요청사항 - 제조사 순서 변경
			for (String[] maker : getValues(CoConstDef.SYS_CODE_CAR_MAKER)) {
				_makerListMap.put(maker[0], maker[1]);
			}
			////
			for (CarCodeBean bean : list) {

				if (!isEmpty(bean.getCarcode())) {
					_carCodeInfoMap.put(bean.getCarcode(), bean);
				}

				// country
				// if(!isEmpty(bean.getCountryCode())) {
				// _countryMap = _carCodeMap.get(bean.getCountryCode());
				// if(_countryMap == null) {
				// _countryMap = new LinkedHashMap<>();
				// }
				// if(!isEmpty(bean.getMakerCode()) &&
				// !_countryMap.containsKey(bean.getMakerCode())) {
				// _countryMap.put(bean.getMakerCode(), bean.getMakerName());
				// _carCodeMap.put(bean.getCountryCode(), _countryMap);
				// }
				// }

				// maker
				if (!isEmpty(bean.getMakerCode()) && !_makerListMap.containsKey(bean.getMakerCode())) {
					_makerListMap.put(bean.getMakerCode(), bean.getMakerName());
				}

				// model
				if (!isEmpty(bean.getMakerCode())) {
					_key = bean.getMakerCode();
					_makerMap = _carCodeMap.get(_key);
					if (_makerMap == null) {
						_makerMap = new LinkedHashMap<>();
					}
					_subKey = _key + bean.getModelCode();
					if (!isEmpty(bean.getModelCode()) && !_makerMap.containsKey(_subKey)) {
						_makerMap.put(_subKey, bean.getModelName());
						_carCodeMap.put(_key, _makerMap);
					}
				}
				// model detail
				if (!isEmpty(bean.getModelCode())) {
					_key = bean.getMakerCode() + bean.getModelCode();
					_modelMap = _carCodeMap.get(_key);
					if (_modelMap == null) {
						_modelMap = new LinkedHashMap<>();
					}

					_subKey = _key + bean.getModeldetailCode();
					if (!isEmpty(bean.getModeldetailCode()) && !_modelMap.containsKey(bean.getModeldetailCode())) {
						_modelMap.put(_subKey, bean.getModeldetailName());
						_carCodeMap.put(_key, _modelMap);
					}
				}
				// grade
				if (!isEmpty(bean.getModeldetailCode())) {
					_key = bean.getMakerCode() + bean.getModelCode() + bean.getModeldetailCode();
					_detailModelMap = _carCodeMap.get(_key);
					if (_detailModelMap == null) {
						_detailModelMap = new LinkedHashMap<>();
					}

					_subKey = _key + bean.getKindCode() + bean.getSubKindCode() + bean.getGradeCode();
					if (!isEmpty(bean.getModeldetailCode()) && !_detailModelMap.containsKey(_subKey)) {
						_detailModelMap.put(_subKey, bean.getGradeName());
						_carCodeMap.put(_key, _detailModelMap);
					}
				}
			}

			if (_makerListMap != null && !_makerListMap.isEmpty()) {
				_carCodeMap.put("makerList", _makerListMap);
				CAR_CODE_SEARCH_INFO = _carCodeMap;
			}

			if (_carCodeInfoMap != null && !_carCodeInfoMap.isEmpty()) {
				CAR_CODE_INFO = _carCodeInfoMap;

				refreshQuickSearchItemList();
			}
		}


		// SNB 공통코를 BNK+의 관리 코드 처럼 싱글톤에 격납

		{
			List<CodeDtlBean> list = null;
			CoCode code = null;
			CoCodeDtl codedtl = null;

			if(codes == null) {
				codes = new HashMap<String, CoCode>();
			}

			try {
				list = carCodeMapper.getCommCodeListAll();

				if (list == null) {
					throw new RuntimeException("SYSTEM ERR GET CODE INFO FAIL");
				}

				for (CodeDtlBean vo : list) {
					String s = vo.getCdNo();
					code = (CoCode) codes.get(s);
					if (code == null) {
						code = new CoCode(s, vo.getCdNm());
						codes.put(s, code);
					}
					codedtl = new CoCodeDtl(vo.getCdNo(), vo.getCdDtlNo(), vo.getCdSubNo(), vo.getCdDtlNm(),
							vo.getCdDtlNm2(), vo.getCdDtlExp(),
							Integer.parseInt(CoCommonFunc.avoidNull(vo.getCdOrder(), "1")),
							CoCommonFunc.avoidNull(vo.getUseYn(), CoConstDef.FLAG_YES));

					code.addCodeDtl(codedtl);
				}
			} catch (Exception e) {
				logger.error(e.getMessage(), e);
			}

		}


	}

	/**
	 * 퀵검색 자동완성을 위한 차량정보 Item 생성
	 */
	public void refreshQuickSearchItemList() {
		if (CAR_CODE_INFO != null) {
			String _containCode = "";
			String _containDCode = "";
			Map<String, String> _tempMap = null;
			//TreeMap<String, CarCodeBean> sortMap = new TreeMap<>(CAR_CODE_INFO);
			for (CarCodeBean bean : CAR_CODE_INFO.values()) {
				// maker (3자리)
				if (!_containCode.equals(bean.getMakerCode())) {
					_tempMap = new HashMap<>();
					_containCode = bean.getMakerCode();
					_tempMap.put("code", bean.getMakerCode());
					_tempMap.put("name", bean.getMakerName());
					CAR_CODE_QUICK_SEARCH.add(_tempMap);
				}
			}

			for (CarCodeBean bean : CAR_CODE_INFO.values()) {
				if (!_containDCode.equals(bean.getMakerCode() + bean.getModelCode() + bean.getModeldetailCode())) {
					_containDCode = bean.getMakerCode() + bean.getModelCode() + bean.getModeldetailCode();
					_tempMap = new HashMap<>();
					// maker + model + detail (6자리)
					_tempMap.put("code", _containDCode);
					_tempMap.put("name", bean.getMakerName() + " " + bean.getModeldetailName());
					CAR_CODE_QUICK_SEARCH.add(_tempMap);
				}

			}
		}
	}

	public static CoCodeManager getInstance() {
		return instance;
	}

	private static CoCode getCodeInstance(String s) {
		CoCode code = (CoCode) codes.get(s);
		if (code == null) {
			logger.warn((new StringBuilder()).append("Code No.").append(s).append(" is not found.").toString());
		}
		return code;
	}

	public String getGroupName(String s) {
		CoCode code = getCodeInstance(s);
		return code != null ? code.getCdNm() : null;
	}

	public static Vector<String[]> getValues(String s) {
		return getValues(s, null);
	}

	public static Vector<String[]> getValues(String s, String lang) {
		if (instance == null) {
			throw new IllegalStateException();
		} else {
			CoCode code = getCodeInstance(s);
			return code != null ? code.getCdDtlNoCdDtlNmPairVector(false) : emptyVector;
		}
	}

	// 새로 추가 : hj-kim - 2016-05-31
	public static String getValuesJson(String s) {
		return getValuesJson(s, null);
	}

	// 새로 추가 : hj-kim - 2016-05-31
	public static String getValuesJson(String s, String lang) {
		if (instance == null) {
			throw new IllegalStateException();
		} else {
			CoCode code = getCodeInstance(s);

			Gson gson = new Gson();
			String jsonStr = gson.toJson(code.getCdDtlNoCdDtlNmPairVectorBean(false));

			return code != null ? jsonStr : "[]";
		}
	}

	// 새로 추가 : hk-lee 2017-05-30
	public static String getCarCodeSearchInfoJson() {
		if (CAR_CODE_SEARCH_INFO == null) {
			throw new IllegalStateException();
		} else {

			Gson gson = new Gson();
			String jsonStr = gson.toJson(CAR_CODE_SEARCH_INFO);

			return CAR_CODE_SEARCH_INFO != null ? jsonStr : "[]";
		}
	}

	// 새로 추가 : hk-lee 2017-05-30
	public static String getCarCodeInfoJson() {
		if (CAR_CODE_INFO == null) {
			throw new IllegalStateException();
		} else {

			Gson gson = new Gson();
			String jsonStr = gson.toJson(CAR_CODE_INFO);

			return CAR_CODE_INFO != null ? jsonStr : "[]";
		}
	}

	// 새로 추가 : jy-seo 2017-06-01
	public static String getCarCodeQuickSearchInfoJson() {
		if (CAR_CODE_QUICK_SEARCH == null) {
			throw new IllegalStateException();
		} else {

			Gson gson = new Gson();
			String jsonStr = gson.toJson(CAR_CODE_QUICK_SEARCH);

			return CAR_CODE_QUICK_SEARCH != null ? jsonStr : "[]";
		}
	}

	// //새로 추가 : jy-seo 2017-06-07
	public static String getShopCodeInfoJson() {
		if (SHOP_CODE_INFO == null) {
			throw new IllegalStateException();
		} else {

			Gson gson = new Gson();
			String jsonStr = gson.toJson(SHOP_CODE_INFO);

			return SHOP_CODE_INFO != null ? jsonStr : "[]";
		}
	}

	public static Vector<String[]> getValuesIgnoreUse(String s) {
		if (instance == null) {
			throw new IllegalStateException();
		} else {
			CoCode code = getCodeInstance(s);
			return code != null ? code.getCdDtlNoCdDtlNmPairVector(true) : emptyVector;
		}
	}

	// 새로 추가 : hj-kim - 2016-05-31
	public static String getValuesIgnoreUseJson(String s) {
		if (instance == null) {
			throw new IllegalStateException();
		} else {
			CoCode code = getCodeInstance(s);

			Vector<CoCodeDtl> t = code.getCdDtlNoCdDtlNmPairVectorBean(true);

			Gson gson = new Gson();
			String jsonStr = gson.toJson(t);

			return code != null ? jsonStr : "[]";
		}
	}

	public static Vector<String[]> getAllValues(String s) {
		if (instance == null) {
			throw new IllegalStateException();
		} else {
			CoCode code = getCodeInstance(s);
			return code != null ? code.getCdAllPairVector(false) : emptyVector;
		}
	}

	// 새로 추가 : jy-seo - 2017-06-20
	public static Vector<CoCodeDtl> getAllValuesCodeBean(String s) {
		if (instance == null) {
			throw new IllegalStateException();
		} else {
			CoCode code = getCodeInstance(s);
			return code != null ? code.getCdAllPairVectorBean(false) : emptyVectorBean;
		}
	}

	// 새로 추가 : hj-kim - 2016-05-31
	public static String getAllValuesJson(String s) {
		if (instance == null) {
			throw new IllegalStateException();
		} else {
			CoCode code = getCodeInstance(s);

			Vector<CoCodeDtl> t = code.getCdAllPairVectorBean(false);

			Gson gson = new Gson();
			String jsonStr = gson.toJson(t);

			return code != null ? jsonStr : "[]";
		}
	}

	public static Vector<String[]> getAllValuesIgnoreUse(String s) {
		if (instance == null) {
			throw new IllegalStateException();
		} else {
			CoCode code = getCodeInstance(s);
			return code != null ? code.getCdAllPairVector(true) : emptyVector;
		}
	}

	public static Vector<String> getCodes(String s) {
		if (instance == null) {
			throw new IllegalStateException();
		} else {
			CoCode code = getCodeInstance(s);
			return code != null ? code.getCdDtlNoVector(false) : null;
		}
	}

	public static Vector<String> getCodesIgnoreUse(String s) {
		if (instance == null) {
			throw new IllegalStateException();
		} else {
			CoCode code = getCodeInstance(s);
			return code != null ? code.getCdDtlNoVector(true) : null;
		}
	}

	public static Vector<String> getCodeNames(String s) {
		if (instance == null) {
			throw new IllegalStateException();
		} else {
			CoCode code = getCodeInstance(s);
			return code != null ? code.getCdDtlNmVector(false) : null;
		}
	}

	public static Vector<String> getCodeNames(String s, String lang) {
		if (instance == null) {
			throw new IllegalStateException();
		} else {
			CoCode code = getCodeInstance(s);
			return code != null ? code.getCdDtlNmVector(false) : null;
		}
	}

	public static String getCodeNamesJson(String s) {
		if (instance == null) {
			throw new IllegalStateException();
		} else {
			CoCode code = getCodeInstance(s);

			Vector<String> t = code.getCdDtlNmVector(false);

			Gson gson = new Gson();
			String jsonStr = gson.toJson(t);

			return code != null ? jsonStr : "[]";
		}
	}

	public static String getCodeNamesJson(String s, String lang) {
		if (instance == null) {
			throw new IllegalStateException();
		} else {
			CoCode code = getCodeInstance(s);

			Vector<String> t = code.getCdDtlNmVector(false);

			Gson gson = new Gson();
			String jsonStr = gson.toJson(t);

			return code != null ? jsonStr : "[]";
		}
	}

	public static Vector<String> getCodeNamesIgnoreUse(String s) {
		if (instance == null) {
			throw new IllegalStateException();
		} else {
			CoCode code = getCodeInstance(s);
			return code != null ? code.getCdDtlNmVector(true) : null;
		}
	}

	public static String getCodeString(String s, String s1) {
		if (instance == null) {
			throw new IllegalStateException();
		} else {
			CoCode code = getCodeInstance(s);
			return code != null ? code.getCdDtlNm(s1) : "";
		}
	}

	public static String getCodeExpString(String s, String s1) {
		CoCode code = getCodeInstance(s);
		return code != null ? code.getCdDtlExp(s1) : "";
	}
	
	public static String getCodeSubNoString(String s, String s1) {
	    CoCode code = getCodeInstance(s);
	    return code != null ? code.getCdSubNo(s1) : "";
	}

	public static int getCodePriority(String s, String s1) {
		CoCode code = getCodeInstance(s);
		return code != null ? code.getCdDtlPrior(s1) : -1;
	}

	public String genComboBox(String s, String s1) {
		return genComboBox(s, s1, null, -1);
	}

	public String genComboBox(String s, String s1, String s2, int i) {
		CoCode code = getCodeInstance(s);
		if (code != null) {
			return code.createComboBoxString(s1, s2, i);
		} else {
			return "<select name='" + s1 + "'>\n</select>\n";
		}
	}

	public static String genOption(String s) {
		return genOption(s, null, -1);
	}

	public static String genOption(String s, String s1, int i) {
		CoCode code = getCodeInstance(s);
		if (code != null) {
			return code.createOptionString(s1, i);
		} else {
			return null;
		}
	}

	public static String genOptionTag(String s, String s1) {
    	return genOptionTag(s, s1, 0);
    }
    public static String genOptionTag(String s, String s1, int i) {
    	s = CoCommonFunc.getCoConstDefVal(s);
    	CoCode code = getCodeInstance(s);
    	if (code != null) {
    		return code.createOptionTagString(s1, i);
    	} else {
    		return "";
    	}
    }

	public String getCode(String s) {
		Vector<String> vector = getCodes(s);
		if (vector != null) {
			return (String) vector.get(0);
		} else {
			return null;
		}
	}

	public void refreshCodes() {

		HashMap<String, CoCode> hashmap = new HashMap<String, CoCode>();
		List<CodeDtlBean> list = null;
		CoCode code = null;
		CoCodeDtl codedtl = null;

		try {
			list = cdMgrDao.getCodeListAll();
			if (list == null) {
				throw new RuntimeException("SYSTEM ERR GET CODE INFO FAIL");
			}

			for (CodeDtlBean vo : list) {
				String s = vo.getCdNo();
				code = (CoCode) hashmap.get(s);
				if (code == null) {
					code = new CoCode(s, vo.getCdNm());
					hashmap.put(s, code);
				}
				codedtl = new CoCodeDtl(vo.getCdNo(), vo.getCdDtlNo(), vo.getCdSubNo(), vo.getCdDtlNm(),
						vo.getCdDtlNm2(), vo.getCdDtlExp(),
						Integer.parseInt(CoCommonFunc.avoidNull(vo.getCdOrder(), "1")), vo.getUseYn());

				code.addCodeDtl(codedtl);
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			logger.error(e.getMessage(), e);
		}

		if (!hashmap.isEmpty()) {
			codes = hashmap;
		}

	}

	public static Vector<String> getStandardCodeExp(String s) {
		Vector<String> ret = null;
		Vector<String> codes = null;
		Vector<String> exps = new Vector<String>();
		int size = 0;
		int i = 0;
		int j = 0;
		if (instance == null) {
			throw new IllegalStateException();
		} else {
			CoCode code = getCodeInstance(s);
			codes = code != null ? code.getCdDtlNoVector(false) : null;
			while (i < codes.size()) {
				if (!codes.get(i).equals("")) {
					String temp = code != null ? code.getCdDtlExp(codes.get(i)) : "";
					if (!temp.equals("")) {
						exps.add(temp);
						CoCode code_ = getCodeInstance(temp);
						Vector<String> temps = code_ != null ? code_.getCdDtlNoVector(false) : null;
						if (temps != null && temps.size() > size) {
							size = temps.size();
							j++;
						}
					}
				}
				i++;
			}
			if (size > 0) {
				code = getCodeInstance(exps.get(j - 1));
				ret = code != null ? code.getCdDtlNoVector(false) : null;
			}
		}
		return ret;
	}

	public static String getCodeConvertWithExp(String s, String s1) {
		if (instance == null) {
			throw new IllegalStateException();
		} else {
			CoCode code = getCodeInstance(s);
			return code != null ? code.getCdByDtlExp(s1) : "";
		}
	}

	/**
	 * Gets the sub code no.
	 * 하위코드가 존재할 경우 코드 번호를 반환한다.
	 *
	 * @param s the s
	 * @param s1 the s 1
	 * @return the sub code no
	 */
	public static String getCdSubNo(String s, String s1) {
		if (instance == null) {
			throw new IllegalStateException();
		} else {
			CoCode code = getCodeInstance(s);
			return code != null ? code.getCdSubNo(s1) : "";
		}
	}

	// static {
	// instance = null;
	// codes = new HashMap<String, CoCode>();
	// emptyVector = new Vector<String[]>();
	// instance = new CoCodeManager();
	// List<CodeDtlBean> list = null;
	// CoCode code = null;
	// CoCodeDtl codedtl = null;
	//
	// try {
	// list = cdMgrDao.getCodeListAll();
	// if(list == null) {
	// throw new RuntimeException("SYSTEM ERR GET CODE INFO FAIL");
	// }
	//
	// for(CodeDtlBean vo : list) {
	// String s = vo.getCdNo();
	// code = (CoCode) codes.get(s);
	// if (code == null) {
	// code = new CoCode(s, vo.getCdNm());
	// codes.put(s, code);
	// }
	// codedtl = new CoCodeDtl(
	// vo.getCdDtlNo(),
	// vo.getCdDtlNm(),
	// vo.getCdDtlExp(),
	// Integer.parseInt(CoCommonFunc.avoidNull(vo.getPrirSeq(), "1")));
	//
	// code.addCodeDtl(codedtl);
	// }
	// } catch (Exception e) {
	// // TODO Auto-generated catch block
	// e.printStackTrace();
	// }
	//
	// }
}
