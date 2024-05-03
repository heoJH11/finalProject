package kr.or.ddit.pro_service.service_request.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;

import kr.or.ddit.pro_service.service_request.service.ReviewService;
import kr.or.ddit.pro_service.service_request.service.SrvcRequstService;
import kr.or.ddit.util.ArticlePage;
import kr.or.ddit.vo.CommonCdDetailVO;
import kr.or.ddit.vo.ReviewVO;
import kr.or.ddit.vo.UsersVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/srvcRqReview")
public class ReviewController {
	
	@Autowired
	ReviewService reviewService;
	
	@Autowired
	SrvcRequstService srvcRequstService;
	
	@Autowired
	SrvcRequstController srvcRequstController;
	
	@GetMapping("/reInfo")
	@ResponseBody
	List<CommonCdDetailVO> reInfo() {
		List<CommonCdDetailVO> commonCdDetailVOList = this.reviewService.reInfo();
		log.info("[reviewController] 리뷰 공통코드 : " + commonCdDetailVOList);
		
		return commonCdDetailVOList;
	}
	
	@PostMapping("/reCreatePost")
	@ResponseBody
	public int reCreate(@RequestBody ReviewVO reviewVO) {
		log.info("reviewVO : " + reviewVO);
		
		int res = 0;
		res = this.reviewService.reCreate(reviewVO);
		
		return res; 
	}
	
	@GetMapping("/reDetail")
	@ResponseBody
	public List<ReviewVO> reDetail(HttpServletRequest request) {
		String userId = this.srvcRequstController.userIdChk(request);
		
		List<ReviewVO> reviewVOList = this.reviewService.reDetail(userId); 
		
		return reviewVOList;
		
	}
	
	@GetMapping("/reMgmt")
	public String reMgmt(Model model, HttpServletRequest request) {
		Map<String, Object> map = new HashMap<String, Object>();
		
		// 리스트 토탈 구하기
		// 필요값 : vSrvcRequstVO.userId, vSrvcRequstVO.emplyrTy='ET02'
		String userId = this.srvcRequstController.userIdChk(request);
		UsersVO usersVO = this.srvcRequstService.userChk(userId);
		map.put("userId", userId);
		map.put("vSrvcRequstVO.emplyrTy", usersVO.getEmplyrTy());
		int rqrvTotal = this.reviewService.rqrvTotal(map);
		
		// 리뷰 건수 토탈 구하기 
		// 필요값 : userId, emplyrTy
		map.put("userId", usersVO.getUserId());
		log.info("reMgMt -> totalMap(rvTotal 파라미터) : " + map);
		int rvTotal = this.reviewService.reviewTotal(map);
		
		// 별점
		List<ReviewVO> reviewVOList = this.reviewService.reDetail(userId);
		int scoreSum = 0;
		for (ReviewVO reviewVO : reviewVOList) {
		    scoreSum += reviewVO.getReScore();
		}

		float scoreAvgF = (float) scoreSum / reviewVOList.size();
		String rvScoreAvg = String.format("%.1f", scoreAvgF);
		log.info("값 : " + rvScoreAvg);
		
		List<CommonCdDetailVO> cdDetailList = this.reviewService.reInfo();
		
		model.addAttribute("rqrvTotal", rqrvTotal);
		model.addAttribute("rvTotal", rvTotal);
		model.addAttribute("reviewVOList", new Gson().toJson(reviewVOList));
		model.addAttribute("rvScoreAvg", rvScoreAvg);
		model.addAttribute("cdDetailList", new Gson().toJson(cdDetailList));
		
		return "srvcRqReview/reviewMgmt";
	}
	
	@GetMapping("/proReMgmt")
	public String proReMgmt(Model model, HttpServletRequest request) {
		Map<String, Object> map = new HashMap<String, Object>();

		String userId = this.srvcRequstController.userIdChk(request);
		UsersVO usersVO = this.srvcRequstService.userChk(userId);

		// 리뷰 건수 토탈 구하기 
		// 필요값 : userId, emplyrTy
		map.put("userId", usersVO.getUserId());

		int rvTotal = this.reviewService.proReviewTotal(map);
		
		// 별점
		List<ReviewVO> reviewVOList = this.reviewService.proReDetail(userId);
		int scoreSum = 0;
		for (ReviewVO reviewVO : reviewVOList) {
		    scoreSum += reviewVO.getReScore();
		}
		float scoreAvgF = (float) scoreSum / reviewVOList.size();
		String rvScoreAvg = String.format("%.1f", scoreAvgF);
	
		List<CommonCdDetailVO> cdDetailList = this.reviewService.reInfo();
		model.addAttribute("rvTotal", rvTotal);
		model.addAttribute("reviewVOList", new Gson().toJson(reviewVOList));
		model.addAttribute("rvScoreAvg", rvScoreAvg);
		model.addAttribute("cdDetailList", new Gson().toJson(cdDetailList));
		
		return "srvcRqReview/proReviewMgmt";
	}
	
	@PostMapping("/reviewList")
	@ResponseBody
	public Map<String, Object> reviewList(@RequestBody(required = false) Map<String,Object> map, 
			HttpServletRequest request){
		String userId = this.srvcRequstController.userIdChk(request);
		map.put("userId", userId);
		
		int size = (Integer.parseInt(map.get("size").toString()));
		map.put("size", size);
		
		// 리뷰 목록 가져오기
		List<ReviewVO> reviewVOList = this.reviewService.reviewList(map);
		int total = this.reviewService.reviewTotal(map);
		
		String currentPage = map.get("currentPage").toString();
		String keyword = map.get("keyword").toString();
		
		// 목록 paging처리
		ArticlePage<ReviewVO> data 
		= new ArticlePage<ReviewVO>(total, Integer.parseInt(currentPage), size,reviewVOList, keyword);
		String url = "/srvcRqReview/reviewMgmt";
		data.setUrl(url);
			
		// 작성 안된 review 수
		int res = this.reviewService.reviewNoWrCnt(map);
		
		Map<String , Object> reviewListMap = new HashMap<String, Object>();
		reviewListMap.put("data", data);
		reviewListMap.put("reviewNoWrCnt", res);
		
		log.info("reviewList-> userId : " + userId);
		log.info("reviewList-> reviewVOList : " + reviewVOList);
		log.info("reviewList-> 페이징 처리 : " + data);
		return reviewListMap;
	}

	@PostMapping("/proReviewList")
	@ResponseBody
	public Map<String, Object> proReviewList(@RequestBody(required = false) Map<String,Object> map, 
			HttpServletRequest request){
		String userId = this.srvcRequstController.userIdChk(request);
		map.put("userId", userId);
		log.info("reviewList-> userId : " + userId);
		
		int size = (Integer.parseInt(map.get("size").toString()));
		map.put("size", size);
		
		// 리뷰 목록 가져오기
		List<ReviewVO> reviewVOList = this.reviewService.proReviewList(map);
		log.info("proReviewList controller -> reviewVOList : " + reviewVOList);
		int total = this.reviewService.proReviewTotal(map);
		
		String currentPage = map.get("currentPage").toString();
		String keyword = map.get("keyword").toString();
		
		// 목록 paging처리
		ArticlePage<ReviewVO> data 
		= new ArticlePage<ReviewVO>(total, Integer.parseInt(currentPage), size,reviewVOList, keyword);
		String url = "/srvcRqReview/proReviewMgmt";
		data.setUrl(url);
		
		// 작성 안된 review 수
		int res = this.reviewService.reviewNoWrCnt(map);
		
		Map<String , Object> reviewListMap = new HashMap<String, Object>();
		reviewListMap.put("data", data);
		reviewListMap.put("reviewNoWrCnt", res);
		
		log.info("페이징 처리 : " + data);
		return reviewListMap;
	}
	
	@PostMapping("/showReview")
	@ResponseBody
	public Map<String, Object> showReview(@RequestParam int reNo) {
		Map<String, Object> showReviewMap = this.reviewService.showReview(reNo);
		
		return showReviewMap;
	}
		
	@GetMapping("/reTyChrtList")
	@ResponseBody
	public Map<String, Object> reTyChrtList(HttpServletRequest request){
		
		Map<String, Object> paramMap = new HashMap<String, Object>();
		String userId = this.srvcRequstController.userIdChk(request);
		paramMap.put("userId", userId);
		
		List<ReviewVO> reTyChrtList = new ArrayList<ReviewVO>();
		reTyChrtList = this.reviewService.reTyChrtList(paramMap);
		log.info("[reTyChartLsit] : ", reTyChrtList);
		
		List<CommonCdDetailVO> reviewCodeNmList = new ArrayList<CommonCdDetailVO>();
		reviewCodeNmList = this.reviewService.reInfo();
		
		List<ReviewVO> reScoreChrtList = new ArrayList<ReviewVO>();
		reScoreChrtList = this.reviewService.reScoreChrtList(paramMap);
		
		
		paramMap.put("reTyChrtList", reTyChrtList);
		paramMap.put("reScoreChrtList", reScoreChrtList);
		paramMap.put("reviewCodeNmList", reviewCodeNmList);
		
		return paramMap;
	}

	@GetMapping("/proReTyChrtList")
	@ResponseBody
	public Map<String, Object> proReTyChrtList(HttpServletRequest request){
		
		Map<String, Object> paramMap = new HashMap<String, Object>();
		String userId = this.srvcRequstController.userIdChk(request);
		paramMap.put("userId", userId);
		
		List<ReviewVO> reTyChrtList = new ArrayList<ReviewVO>();
		reTyChrtList = this.reviewService.proReTyChrtList(paramMap);
		log.info("[reScoreChartLsit] : ", reTyChrtList);
		
		List<CommonCdDetailVO> reviewCodeNmList = new ArrayList<CommonCdDetailVO>();
		reviewCodeNmList = this.reviewService.reInfo();
		
		List<ReviewVO> reScoreChrtList = new ArrayList<ReviewVO>();
		reScoreChrtList = this.reviewService.proReScoreChrtList(paramMap);
		
		
		paramMap.put("reTyChrtList", reTyChrtList);
		paramMap.put("reScoreChrtList", reScoreChrtList);
		paramMap.put("reviewCodeNmList", reviewCodeNmList);
		
		return paramMap;
	}
	
	@GetMapping("/reScoreChrtList")
	@ResponseBody
	public List<ReviewVO> reScoreChrtList(HttpServletRequest request){
		Map<String, Object> paramMap = new HashMap<String, Object>();
		String userId = this.srvcRequstController.userIdChk(request);
		paramMap.put("userId", userId);
		
		List<ReviewVO> reScoreChrtList = new ArrayList<ReviewVO>();
		reScoreChrtList = this.reviewService.reScoreChrtList(paramMap);
		
		return reScoreChrtList;
		
	}

}