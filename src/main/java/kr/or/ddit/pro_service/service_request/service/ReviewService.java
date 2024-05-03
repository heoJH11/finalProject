package kr.or.ddit.pro_service.service_request.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.vo.CommonCdDetailVO;
import kr.or.ddit.vo.ReviewVO;

public interface ReviewService {

	public List<CommonCdDetailVO> reInfo();

	public int reCreate(ReviewVO reviewVO);

	public List<ReviewVO> reDetail(String userId);

	public List<ReviewVO> reviewList(Map<String, Object> map);

	public int reviewTotal(Map<String, Object> map);

	public int reviewNoWrCnt(Map<String, Object> map);

	public Map<String, Object> showReview(int reNo);

	public int rqrvTotal(Map<String, Object> map);

	public List<ReviewVO> reTyChrtList(Map<String, Object> paramMap);

	public List<ReviewVO> reScoreChrtList(Map<String, Object> paramMap);

	public List<ReviewVO> proReviewList(Map<String, Object> map);
	
	public int proReviewTotal(Map<String, Object> map);

	public List<ReviewVO> proReDetail(String userId);

	public List<ReviewVO> proReTyChrtList(Map<String, Object> paramMap);

	public List<ReviewVO> proReScoreChrtList(Map<String, Object> paramMap);

}
