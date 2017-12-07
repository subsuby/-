package com.bnk.plus.commons.cdManager.beans;

import java.util.HashMap;
import java.util.Vector;

import com.bnk.plus.commons.CoConstDef;
import com.bnk.plus.commons.cdManager.beans.CoCodeDtl;

// TODO: Auto-generated Javadoc
/**
 * The Class CoCode.
 */
public class CoCode {


    /** The cd no. */
    private String cdNo;

    /** The cd nm. */
    private String cdNm;

    /** The code dtls. */
    private Vector<CoCodeDtl> codeDtls;

    /** The code dtls hash. */
    private HashMap<String, CoCodeDtl> codeDtlsHash;
    private HashMap<String, CoCodeDtl> codeDtlsHashByExp;

    /**
     * Gets the cd no.
     *
     * @return the string
     */
    public String getCdNo() {
        return cdNo;
    }

    /**
     * Sets the cd no.
     *
     * @param cdNo the new cd no
     */
    public void setCdNo(String cdNo) {
        this.cdNo = cdNo;
    }

    /**
     * Gets the cd nm.
     *
     * @return the string
     */
    public String getCdNm() {
        return cdNm;
    }

    /**
     * Sets the cd nm.
     *
     * @param cdNm the new cd nm
     */
    public void setCdNm(String cdNm) {
        this.cdNm = cdNm;
    }

    /**
     * Instantiates a new co code.
     *
     * @param s the s
     * @param s1 the s1
     */
    public CoCode(String s, String s1)
    {
        codeDtls = new Vector<CoCodeDtl>();
        codeDtlsHash = new HashMap<String, CoCodeDtl>();
        codeDtlsHashByExp = new HashMap<>();
        cdNo = s;
        cdNm = s1;
    }

    /**
     * Adds the code dtl.
     *
     * @param codedtl the codedtl
     */
    public void addCodeDtl(CoCodeDtl codedtl)
    {
        codeDtls.add(codedtl);
        codeDtlsHash.put(codedtl.cdDtlNo, codedtl);
        if(codedtl.cdDtlExp != null && codedtl.cdDtlExp.trim().length() > 0 ) {
        	for(String s : codedtl.cdDtlExp.split("[,]")) {
        		if(s != null && s.trim().length() > 0) {
        			codeDtlsHashByExp.put(s.trim(), codedtl);
        		}
        	}
        }
    }

    /**
     * Gets the cd dtl nm.
     *
     * @param s the s
     * @return the string
     */
    public String getCdDtlNm(String s)
    {
        CoCodeDtl codedtl = (CoCodeDtl)codeDtlsHash.get(s);
        return codedtl != null ? codedtl.cdDtlNm : "";
    }

    /**
     * Gets the cd dtl exp.
     *
     * @param s the s
     * @return the string
     */
    public String getCdDtlExp(String s)
    {
        CoCodeDtl codedtl = (CoCodeDtl)codeDtlsHash.get(s);
        return codedtl != null ? codedtl.cdDtlExp : "";
    }


    /**
     * 하위코드 반환
     * @param s
     * @return
     */
    public String getCdSubNo(String s)
    {
        CoCodeDtl codedtl = (CoCodeDtl)codeDtlsHash.get(s);
        return codedtl != null ? codedtl.cdSubNo : "";
    }

    /**
     * Gets the cd by dtl exp. <br />
     * 상세코드 설명과 비교하여 해당하는 코드를 반환한다. code convert용
     *
     * @param s the s
     * @return the cd by dtl exp
     */
    public String getCdByDtlExp(String s)
    {
        CoCodeDtl codedtl = (CoCodeDtl)codeDtlsHashByExp.get(s);
        return codedtl != null ? codedtl.cdDtlNo : "";
    }

    /**
     * Gets the cd dtl prior.
     *
     * @param s the s
     * @return the int
     */
    public int getCdDtlPrior(String s)
    {
        CoCodeDtl codedtl = (CoCodeDtl)codeDtlsHash.get(s);
        return (codedtl != null ? Integer.valueOf(codedtl.cdOrder) : null).intValue();
    }

    /**
     * Gets the cd dtl no, cd dtl nm pair vector.
     * @param locale
     *
     * @return the vector
     */
    public Vector<String[]> getCdDtlNoCdDtlNmPairVector(boolean ignoreDel)
    {
        Vector<String[]> vector = new Vector<String[]>();
        int i = 0;
        for(int j = codeDtls.size(); i < j; i++)
        {
            CoCodeDtl codedtl = (CoCodeDtl)codeDtls.get(i);
            if(!ignoreDel && CoConstDef.FLAG_NO.equals(codedtl.useYn)) {
            	continue;
            }
            vector.add(new String[] {
                codedtl.cdDtlNo, codedtl.cdDtlNm, codedtl.cdSubNo
            });
        }

        return vector;
    }

    public Vector<CoCodeDtl> getCdDtlNoCdDtlNmPairVectorBean(boolean ignoreDel)
    {
        Vector<CoCodeDtl> vector = new Vector<CoCodeDtl>();
        int i = 0;
        for(int j = codeDtls.size(); i < j; i++)
        {
            CoCodeDtl codedtl = (CoCodeDtl)codeDtls.get(i);
            if(!ignoreDel && CoConstDef.FLAG_NO.equals(codedtl.useYn)) {
            	continue;
            }
            vector.add(codedtl);
        }

        return vector;
    }


    /**
     * Gets the cd dtl no, cd dtl nm pair vector, cd dtl exp.
     *
     * @return the vector
     */
    public Vector<String[]> getCdAllPairVector(boolean ignoreDel)
    {
        Vector<String[]> vector = new Vector<String[]>();
        int i = 0;
        for(int j = codeDtls.size(); i < j; i++)
        {
            CoCodeDtl codedtl = (CoCodeDtl)codeDtls.get(i);
            if(!ignoreDel && CoConstDef.FLAG_NO.equals(codedtl.useYn)) {
            	continue;
            }
            vector.add(new String[] {
                codedtl.cdDtlNo, codedtl.cdSubNo, codedtl.cdDtlNm, codedtl.cdDtlNm2, codedtl.cdDtlExp, codedtl.cdOrder+""
            });
        }
        return vector;
    }

    public Vector<CoCodeDtl> getCdAllPairVectorBean(boolean ignoreDel)
    {
        Vector<CoCodeDtl> vector = new Vector<CoCodeDtl>();
        int i = 0;
        for(int j = codeDtls.size(); i < j; i++)
        {
            CoCodeDtl codedtl = (CoCodeDtl)codeDtls.get(i);
            if(!ignoreDel && CoConstDef.FLAG_NO.equals(codedtl.useYn)) {
            	continue;
            }
            vector.add(codedtl);
        }

        return vector;
    }


    /**
     * Gets the cd dtl no vector.
     *
     * @return the vector
     */
    public Vector<String> getCdDtlNoVector(boolean ignoreDel)
    {
        Vector<String> vector = new Vector<String>();
        int i = 0;
        for(int j = codeDtls.size(); i < j; i++)
        {
            CoCodeDtl codedtl = (CoCodeDtl)codeDtls.get(i);
            if(!ignoreDel && CoConstDef.FLAG_NO.equals(codedtl.useYn)) {
            	continue;
            }
            vector.add(codedtl.cdDtlNo);
        }

        return vector;
    }

    /**
     * Gets the cd dtl nm vector.
     * @param locale
     *
     * @return the vector
     */
	public Vector<String> getCdDtlNmVector(boolean ignoreDel) {
		Vector<String> vector = new Vector<String>();
		int i = 0;
		for (int j = codeDtls.size(); i < j; i++) {
			CoCodeDtl codedtl = (CoCodeDtl) codeDtls.get(i);
			if (!ignoreDel && CoConstDef.FLAG_NO.equals(codedtl.useYn)) {
				continue;
			}
			vector.add(codedtl.cdDtlNm);
		}

		return vector;
	}

    /**
     * Creates the combo box string.
     *
     * @param s the s
     * @param s1 the s1
     * @param i the i
     * @return the string
     */
    public String createComboBoxString(String s, String s1, int i)
    {
        StringBuffer stringbuffer = (new StringBuffer("<select name='")).append(s).append("'>\n");
        int j = 0;
        for(int k = codeDtls.size(); j < k; j++)
        {
            CoCodeDtl codedtl = (CoCodeDtl)codeDtls.get(j);
            stringbuffer.append("    <option value='").append(codedtl.cdDtlNo).append('\'');
            if(i == 0 && codedtl.cdDtlNo.equals(s1) || i == 1 && codedtl.cdDtlNm.equals(s1))
            {
                stringbuffer.append(" selected");
            }
            stringbuffer.append(">").append(codedtl.cdDtlNm).append("</option>\n");
        }

        return stringbuffer.append("</select>\n").toString();
    }

    /**
     * Creates the option string.
     *
     * @param s the s
     * @param i the i
     * @return the string
     */
    public String createOptionString(String s, int i)
    {
        StringBuffer stringbuffer = new StringBuffer();
        int j = 0;
        for(int k = codeDtls.size(); j < k; j++)
        {
            CoCodeDtl codedtl = (CoCodeDtl)codeDtls.get(j);
            stringbuffer.append("    <option VALUE='").append(codedtl.cdDtlNo).append('\'');
            if(i == 0 && codedtl.cdDtlNo.equals(s) || i == 1 && codedtl.cdDtlNm.equals(s))
            {
                stringbuffer.append(" selected");
            }
            stringbuffer.append(">").append(codedtl.cdDtlNm).append("</option>\n");
        }

        return stringbuffer.toString();
    }

    /**
     * Creates the option tag string.
     *
     * @param s the s
     * @param s1 the s1
     * @param i the i
     * @return the string
     */
    public String createOptionTagString(String s, int i)
    {
    	StringBuffer stringbuffer = new StringBuffer();
    	int j = 0;
    	for(int k = codeDtls.size(); j < k; j++)
    	{
    		CoCodeDtl codedtl = (CoCodeDtl)codeDtls.get(j);
    		stringbuffer.append("    <option value='").append(codedtl.cdDtlNo).append('\'');
    		if(i == 0 && codedtl.cdDtlNo.equals(s) || i == 1 && codedtl.cdDtlNm.equals(s))
    		{
    			stringbuffer.append(" selected");
    		}
    		stringbuffer.append(">").append(codedtl.cdDtlNm).append("</option>\n");
    	}

    	return stringbuffer.toString();
    }

}
