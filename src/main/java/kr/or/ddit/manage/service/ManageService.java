package kr.or.ddit.manage.service;

import kr.or.ddit.vo.DongChartVO;
import kr.or.ddit.vo.DongChartVO2;
import kr.or.ddit.vo.DongChartVO3;

public interface ManageService {
	
	//전문분야 통계
	public DongChartVO test();
	
	//서비스 요청 통계
	public DongChartVO2 test2();

	// 서비스요청 프로 수락 거절 현황
	public DongChartVO3 test3();

}
