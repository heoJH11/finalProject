package kr.or.ddit.board.pro_hunting.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.board.pro_hunting.mapper.ProHuntingMapper;
import kr.or.ddit.board.pro_hunting.service.ProHuntingService;
import kr.or.ddit.util.fileupload.service.FileuploadService;
import kr.or.ddit.vo.ProJoBbscttVO;
import kr.or.ddit.vo.SprviseAtchmnflVO;


@Service
public class ProHuntingServiceImpl implements ProHuntingService {

	@Autowired
	ProHuntingMapper proHuntingMapper;
	
	@Autowired
	FileuploadService FileuploadService;
	
	@Override
	public List<ProJoBbscttVO> listAjax(Map<String, Object> paramMap) {
		return this.proHuntingMapper.listAjax(paramMap);
	}

	@Override
	public int getTotal(Map<String, Object> paramMap) {
		return this.proHuntingMapper.getTotal(paramMap);
	}
	@Override
	public List<ProJoBbscttVO> myBoardList(Map<String, Object> paramMap) {
		return this.proHuntingMapper.myBoardList(paramMap);
	}
	
	@Override
	public int myBoardListgetTotal(Map<String, Object> paramMap) {
		return this.proHuntingMapper.myBoardListgetTotal(paramMap);
	}

	@Override
	public Map<String,Object> detail(int proJoBbscttNo) {
		// 게시글과 댓글의 세부 내용
		List<ProJoBbscttVO> proJoBbscttVOList = new ArrayList<ProJoBbscttVO>();
		proJoBbscttVOList = this.proHuntingMapper.detail(proJoBbscttNo);
		
		int sprviseAtchmnflNo = 0;
		// 첨부파일 필요
		for(ProJoBbscttVO proJoBbscttVO : proJoBbscttVOList) {
			sprviseAtchmnflNo = proJoBbscttVO.getSprviseAtchmnflNo();
		}
		List<SprviseAtchmnflVO> spviseAtchmnflVOList = this.FileuploadService.getsprviseAtchmnfl(sprviseAtchmnflNo);
		
		Map<String, Object> detailMap = new HashMap<String, Object>();
		detailMap.put("proJoBbscttVOList", proJoBbscttVOList);
		detailMap.put("spviseAtchmnflVOList", spviseAtchmnflVOList);
		
		return detailMap;
		
	}

	@Override
	public int rdCntUpdt(int proJoBbscttNo) {
		return this.proHuntingMapper.rdCntUpdt(proJoBbscttNo);
	}

	@Override
	public int proAnswerRegister(Map<String, Object> map) {
		return this.proHuntingMapper.proAnswerRegister(map);
	}

	@Override
	public int delProAnswer(Map<String, Object> map) {
		return this.proHuntingMapper.delProAnswer(map);
	}

}
