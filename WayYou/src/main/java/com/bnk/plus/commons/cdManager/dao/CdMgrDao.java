package com.bnk.plus.commons.cdManager.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.bnk.plus.entity.Market;
import com.bnk.plus.entity.commons.cdManager.CarCodeBean;
import com.bnk.plus.entity.commons.cdManager.CodeBean;
import com.bnk.plus.entity.commons.cdManager.CodeDtlBean;
import com.bnk.plus.service.common.persistence.commons.cdManager.CodeManagerMapper;
import com.bnk.plus.service.dealer.persistence.MarketMapper;

/**
 * The Class HrCodeDAO.
 */
@Component
public class CdMgrDao/* extends SqlSessionDaoSupport*/{
	
	@Autowired
	private SqlSession sqlSession;
	
	
//	private final String sqlNamespace = "codeDao";
	
    /**
     * Gets the code list.
     *
     * @param vo the vo
     * @return the list
     * @throws Exception the exception
     */
    public List<CodeBean> getCodeList(CodeBean vo) throws Exception {
    	return sqlSession.getMapper(CodeManagerMapper.class).getCodeList(vo);
//       return sqlSession.selectList(sqlNamespace + ".getCodeList", vo);
    }
    
    /**
     * Gets the code list tot cnt.
     *
     * @param vo the vo
     * @return the int
     * @throws Exception the exception
     */
    public int getCodeListTotCnt(CodeBean vo) throws Exception {
    	return sqlSession.getMapper(CodeManagerMapper.class).getCodeListTotCnt(vo);
//        return sqlSession.selectOne(sqlNamespace + ".getCodeListTotCnt", vo);
    }
    
    /**
     * Gets the code info.
     *
     * @param vo the vo
     * @return the hr code vo
     * @throws Exception the exception
     */
    public CodeBean getCodeInfo(CodeBean vo) throws Exception {
    	return sqlSession.getMapper(CodeManagerMapper.class).getCodeInfo(vo);
//        return sqlSession.selectOne(sqlNamespace + ".getCodeInfo", vo);
    }
    
    /**
     * Gets the code dtl list.
     *
     * @param vo the vo
     * @return the list
     * @throws Exception the exception
     */
    public List<CodeDtlBean> getCodeDtlList(CodeBean vo) throws Exception {
    	return sqlSession.getMapper(CodeManagerMapper.class).getCodeDtlList(vo);
//        return sqlSession.selectList(sqlNamespace + ".getCodeDtlList", vo);
    }
    
    /**
     * Insert code.
     *
     * @param vo the vo
     * @throws Exception the exception
     */
    public void insertCode(CodeBean vo) throws Exception  {
    	sqlSession.getMapper(CodeManagerMapper.class).insertCode(vo);
//    	sqlSession.insert(sqlNamespace + ".insertCode", vo);
    }
    
    /**
     * Update code.
     *
     * @param vo the vo
     * @return the int
     * @throws Exception the exception
     */
    public int updateCode(CodeBean vo) throws Exception {
    	return sqlSession.getMapper(CodeManagerMapper.class).updateCode(vo);
//        return sqlSession.update(sqlNamespace + ".updateCode", vo);
    }
    
    /**
     * Insert code dtl.
     *
     * @param vo the vo
     * @throws Exception the exception
     */
    public void insertCodeDtl(CodeDtlBean vo) throws Exception {
    	sqlSession.getMapper(CodeManagerMapper.class).insertCodeDtl(vo);
//    	sqlSession.insert(sqlNamespace + ".insertCodeDtl", vo);
    }
    
//    /**
//     * Delete all code dtl.
//     *
//     * @param vo the vo
//     * @return the int
//     * @throws Exception the exception
//     */
//    public int deleteAllCodeDtl(CodeBean vo) throws Exception {
//        return sqlSession.update(sqlNamespace + ".deleteCodeDtl", vo);
//    }
    
    /**
     * Delete code.
     *
     * @param vo the vo
     * @return the int
     * @throws Exception the exception
     */
    public int deleteCode(CodeBean vo) throws Exception {
    	return sqlSession.getMapper(CodeManagerMapper.class).deleteCode(vo);
//        return sqlSession.delete(sqlNamespace + ".deleteCode", vo);
    }

//    /**
//     * Delete code dtl.
//     *
//     * @param vo the vo
//     * @return the int
//     * @throws Exception the exception
//     */
//    public int deleteCodeDtl(CodeBean vo) throws Exception {
//        return sqlSession.delete(sqlNamespace + ".deleteCodeDtl", vo);
//    }

	public List<CodeDtlBean> getCodeListAll() {
		return sqlSession.getMapper(CodeManagerMapper.class).getCodeListAll();
//        return sqlSession.selectList(sqlNamespace + ".getCodeListAll");
	}
	
	/**
	 * SNC 전체 차량코드정보 조회
	 * @return List<CarCodeBean>
	 */
	public List<CarCodeBean> getCarCodeList() {
//		return slaveSqlSessionFactory.getMapper(CodeManagerCarCodeMapper.class).getCarCodeList();
		return sqlSession.getMapper(CodeManagerMapper.class).getCarCodeList();
	}

}
