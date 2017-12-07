package com.bnk.plus.web.front;

import com.bnk.plus.commons.components.CoTopComponent;
import com.bnk.plus.service.car.persistence.CarMstMapper;
import com.bnk.plus.service.session.service.T2UserService;

// TODO: Auto-generated Javadoc
/**
 * The Class UserRecommendCarPush. <br>
 * 매물이 등록된 경우 내게 맞는 매물이 등록괸 경우 push 발송
 */
public class UserRecommendCarPush extends CoTopComponent implements Runnable {

	/** The user service. */
	private static T2UserService userService = (T2UserService) getWebappContext().getBean(T2UserService.class);
	

	/** The car mst mapper. */
	private static CarMstMapper carMstMapper = (CarMstMapper) getWebappContext().getBean(CarMstMapper.class);
	
	/* (non-Javadoc)
	 * @see java.lang.Runnable#run()
	 */
	@Override
	public void run() {
		
	}
}
