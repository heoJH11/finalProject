package kr.or.ddit.board.pro_collabo.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.board.pro_collabo.mapper.ProCprtnBbscttMapper;
import kr.or.ddit.board.pro_collabo.service.ProCprtnBbscttService;
import kr.or.ddit.board.pro_collabo.vo.ProCprtnAnswerVO;
import kr.or.ddit.board.pro_collabo.vo.ProCprtnBbscttVO;

@Service
public class ProCprtnBbscttServiceImpl implements ProCprtnBbscttService {

	@Autowired
	String uploadFolder;
	
	@Autowired
	ProCprtnBbscttMapper proCprtnBbscttMapper; 
	
//	@Override
//	public List<ProCprtnBbscttVO> proCprtnBbscttList() {
//		// TODO Auto-generated method stub
//		return this.proCprtnBbscttMapper.proCprtnBbscttList();
//	}

	@Override
	public int getTotal(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return this.proCprtnBbscttMapper.getTotal(map);
	}

	@Override
	public List<ProCprtnBbscttVO> list(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return this.proCprtnBbscttMapper.list(map);
	}

	@Override
	public int increaseViewCount(int proCprtnBbscttNo) {
		// TODO Auto-generated method stub
		return this.proCprtnBbscttMapper.increaseViewCount(proCprtnBbscttNo);
	}

	@Override
	public ProCprtnBbscttVO detail(int proCprtnBbscttNo) {
		// TODO Auto-generated method stub
		return this.proCprtnBbscttMapper.detail(proCprtnBbscttNo);
	}

	@Override
	public ProCprtnBbscttVO detail2(int proCprtnBbscttNo) {
		// TODO Auto-generated method stub
		return this.proCprtnBbscttMapper.detail2(proCprtnBbscttNo);
	}

	@Override
	public List<ProCprtnAnswerVO> list2(int proCprtnBbscttNo){
		// TODO Auto-generated method stub
		return this.proCprtnBbscttMapper.list2(proCprtnBbscttNo);
	}

	@Override
	public int write(ProCprtnAnswerVO proCprtnAnswerVO) {
		// TODO Auto-generated method stub
		return this.proCprtnBbscttMapper.write(proCprtnAnswerVO);
	}

	@Override
	public int modify(ProCprtnAnswerVO proCprtnAnswerVO) {
		// TODO Auto-generated method stub
		return this.proCprtnBbscttMapper.modify(proCprtnAnswerVO);
	}

	@Override
	public int delete(ProCprtnAnswerVO proCprtnAnswerVO) {
		// TODO Auto-generated method stub
		return this.proCprtnBbscttMapper.delete(proCprtnAnswerVO);
	}

}
