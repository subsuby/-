package com.bnk.plus.commons.cdManager.beans;

/**
 * The Class CoCodeDtl.
 */
public class CoCodeDtl {

	/** The cd no. */
	String cdNo;
	
	/** The cd dtl no. */
	String cdDtlNo;
	
	/** The cd sub no. */
    String cdSubNo;
    
    /** The cd dtl nm. */
    String cdDtlNm;

    /** The cd dtl nm. */
    String cdDtlNm2;
    
    /** The cd dtl exp. */
    String cdDtlExp;
    
    /** The prir seq. */
    int cdOrder;
    
    /** The use Flag. */
    String useYn;

    /**
     * Instantiates a new co code dtl.
     *
     * @param cdDtlNo the Code Dtl No
     * @param cdSubNo the Code Dtl Sub No
     * @param cdDtlNm the Code Dtl Name
     * @param cdDtlExp the Code Dtl Exp
     * @param cdBit the Code Bit
     * @param cdOrder the Code Order
     * @param useYn the useYn
     */
    public CoCodeDtl(String cdNo, String cdDtlNo, String cdSubNo, String cdDtlNm, String cdDtlNm2, String cdDtlExp, int cdOrder, String useYn)
    {
    	this.cdNo = cdNo;
        this.cdDtlNo = cdDtlNo;
        this.cdSubNo = cdSubNo;
        this.cdDtlNm = cdDtlNm;
        this.cdDtlNm2 = cdDtlNm2;
        this.cdDtlExp = cdDtlExp;
        this.cdOrder = cdOrder;
        this.useYn = useYn;
    }

	public String getCdNo() {
		return cdNo;
	}

	public void setCdNo(String cdNo) {
		this.cdNo = cdNo;
	}

	public String getCdDtlNo() {
		return cdDtlNo;
	}

	public void setCdDtlNo(String cdDtlNo) {
		this.cdDtlNo = cdDtlNo;
	}

	public String getCdSubNo() {
		return cdSubNo;
	}

	public void setCdSubNo(String cdSubNo) {
		this.cdSubNo = cdSubNo;
	}

	public String getCdDtlNm() {
		return cdDtlNm;
	}

	public void setCdDtlNm(String cdDtlNm) {
		this.cdDtlNm = cdDtlNm;
	}

	public String getCdDtlNm2() {
		return cdDtlNm2;
	}

	public void setCdDtlNm2(String cdDtlNm2) {
		this.cdDtlNm2 = cdDtlNm2;
	}

	public String getCdDtlExp() {
		return cdDtlExp;
	}

	public void setCdDtlExp(String cdDtlExp) {
		this.cdDtlExp = cdDtlExp;
	}

	public int getCdOrder() {
		return cdOrder;
	}

	public void setCdOrder(int cdOrder) {
		this.cdOrder = cdOrder;
	}

	public String getUseYn() {
		return useYn;
	}

	public void setUseYn(String useYn) {
		this.useYn = useYn;
	}
}
