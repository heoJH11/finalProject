package kr.or.ddit.pro_service.service_request.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.pro_service.service_request.mapper.ReviewMapper;
import kr.or.ddit.pro_service.service_request.service.ReviewService;
import kr.or.ddit.pro_service.service_request.service.SrvcRequstService;
import kr.or.ddit.vo.CommonCdDetailVO;
import kr.or.ddit.vo.ReviewVO;
import kr.or.ddit.vo.UsersVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class ReviewServiceImpl implements ReviewService {
	
	@Autowired
	ReviewMapper reviewMapper;
	
	@Autowired
	SrvcRequstService srvcRequstService;

	@Override
	public List<CommonCdDetailVO> reInfo() {
		return this.reviewMapper.reInfo();
	}

	@Override
	public int reCreate(ReviewVO reviewVO) {

		return this.reviewMapper.reCreate(reviewVO);
	}

	@Override
	public List<ReviewVO> reDetail(String userId) {
		return this.reviewMapper.reDetail(userId);
	}

	@Override
	public List<ReviewVO> proReDetail(String userId) {
		return this.reviewMapper.proReDetail(userId);
	}

	@Override
	public List<ReviewVO> reviewList(Map<String, Object> map) {
		UsersVO usersVO = this.srvcRequstService.userChk((String)map.get("userId"));
		map.put("emplyrTy", usersVO.getEmplyrTy());
		
		return this.reviewMapper.reviewList(map);
	}

	@Override
	public List<ReviewVO> proReviewList(Map<String, Object> map) {
		UsersVO usersVO = this.srvcRequstService.userChk((String)map.get("userId"));
		
		return this.reviewMapper.proReviewList(map);
	}

	@Override
	public int reviewTotal(Map<String, Object> map) {
		UsersVO usersVO = this.srvcRequstService.userChk((String)map.get("userId"));
		map.put("emplyrTy", usersVO.getEmplyrTy());
		
		return this.reviewMapper.reviewTotal(map);
	}

	@Override
	public int proReviewTotal(Map<String, Object> map) {
		UsersVO usersVO = this.srvcRequstService.userChk((String)map.get("userId"));
		
		return this.reviewMapper.proReviewTotal(map);
	}

	@Override
	public int reviewNoWrCnt(Map<String, Object> map) {
		return this.reviewMapper.reviewNoWrCnt(map);
	}

	@Override
	public Map<String, Object> showReview(int reNo) {
		ReviewVO reviewVO =  this.reviewMapper.showReview(reNo);
		
		List<CommonCdDetailVO> commonCdDetailVOList = this.reviewMapper.reInfo();
		log.info("shoReview 공통코드 변환 : " + commonCdDetailVOList);
		
		Map<String, Object> showRvMap = new HashMap<String, Object>();

		showRvMap.put("reviewVO", reviewVO);
		showRvMap.put("commonCdDetailVOList", commonCdDetailVOList);
		
		
		return showRvMap;
	}

	@Override
	public int rqrvTotal(Map<String, Object> map) {
		return this.reviewMapper.rqrvTotal(map);
	}

	@Override
	public List<ReviewVO> reTyChrtList(Map<String, Object> paramMap) {
		List<String> reTyList = new ArrayList<String>();
		for(int i= 1; i<15; i++) {
			if(i<10) {
				reTyList.add("REV0"+i);
			}else {
				reTyList.add("REV"+i);
			}
		}
		paramMap.put("reTyList", reTyList);
		
		
		return this.reviewMapper.reTyChrtList(paramMap); 

	}
	
	@Override
	public List<ReviewVO> proReTyChrtList(Map<String, Object> paramMap) {
		List<String> reTyList = new ArrayList<String>();
		for(int i= 1; i<15; i++) {
			if(i<10) {
				reTyList.add("REV0"+i);
			}else {
				reTyList.add("REV"+i);
			}
		}
		paramMap.put("reTyList", reTyList);
		
		
		return this.reviewMapper.proReTyChrtList(paramMap); 
		
	}

	@Override
	public List<ReviewVO> reScoreChrtList(Map<String, Object> paramMap) {
		int[] reScoreArray = {1,2,3,4,5};
		
		paramMap.put("reScoreArray", reScoreArray);
		
		return this.reviewMapper.reScoreChrtList(paramMap);
	}

	@Override
	public List<ReviewVO> proReScoreChrtList(Map<String, Object> paramMap) {
		int[] reScoreArray = {1,2,3,4,5};
		
		paramMap.put("reScoreArray", reScoreArray);
		
		return this.reviewMapper.proReScoreChrtList(paramMap);
	}
	
}
