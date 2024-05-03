package kr.or.ddit.manage.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.admin.decl.service.DeclService;
import kr.or.ddit.manage.mapper.ManageMapper;
import kr.or.ddit.manage.service.ManageService;
import kr.or.ddit.vo.DongChartVO;
import kr.or.ddit.vo.DongChartVO2;
import kr.or.ddit.vo.DongChartVO3;

@Service
public class ManageServiceImpl implements ManageService{
	
	@Autowired
	ManageMapper manageMapper; 
	
	@Override
	public DongChartVO test() {
		return this.manageMapper.test();
	}

	@Override
	public DongChartVO2 test2() {
		return this.manageMapper.test2();
	}

	@Override
	public DongChartVO3 test3() {
		return this.manageMapper.test3();
	}

	
}
