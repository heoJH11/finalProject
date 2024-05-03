package kr.or.ddit.board.pro_story.controller;


import java.io.IOException;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import javax.annotation.PostConstruct;
import javax.inject.Inject;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import kr.or.ddit.board.pro_story.service.ProStoryService;
import kr.or.ddit.board.pro_story.vo.ArticlePage5;
import kr.or.ddit.board.pro_story.vo.GoodPointVO;
import kr.or.ddit.board.pro_story.vo.ProStoryBbscttVO;
import lombok.extern.slf4j.Slf4j;
@Slf4j
@Controller
@RequestMapping("/prostory")
@SuppressWarnings({"unchecked"})
public class ProStoryController {
	
	@Inject
	String uploadFolder;
	
	@Inject
	ProStoryService proStoryService;
	
	@PostConstruct
	private void init() {
//		int totalPage = this.proStoryService.getTotalPages();
	}

	private String userId(HttpServletRequest request) {
	/* 세션체크 아이디 가져오기 */
	
		Object proSession = request.getSession().getAttribute("proSession");
		Object memSession = request.getSession().getAttribute("memSession");
		      
		if(proSession !=null && proSession instanceof HashMap) {
			Object userId = ((HashMap<String, Object>)proSession).get("userId");
			log.debug("proSession : " + userId);
		      
			return userId != null ? userId.toString() : null;
		}
		if(memSession !=null && memSession instanceof HashMap) {
			Object userId = ((HashMap<String, Object>)memSession).get("userId");
			log.debug("memSession : " + userId);
		      
			return userId != null ? userId.toString() : null;

		}

		return "not";
	}
	
	/* 로그인 체크 */
	@ResponseBody
	@GetMapping("/idCheck")
	private String idCheck(HttpServletRequest request) {
		
		return userId(request);
		
	}
	
	/* 메인페이지(리스트) */
	@GetMapping("/main")
	public String list(Model model) {
		
		int total = proStoryService.getTotal();
		List<ProStoryBbscttVO> list = new LinkedList<ProStoryBbscttVO>();
	
		if(this.proStoryService.storyList() == null) { return "prostory/main"; }
		
		list = this.proStoryService.storyList();
		
		// 프로이야기 리스트
		model.addAttribute("proStoryBbscttVO", list);
		model.addAttribute("total", total);
		
		log.debug("proStoryBbscttVO : " + list);
		
		return "prostory/main";
		
	}
	
	@ResponseBody
	@PostMapping("/getPage")
	public ArticlePage5<ProStoryBbscttVO> getContent(
			@RequestParam(required=false      , defaultValue="1") Map<String , Object> param ,
			@RequestParam(value="currentPage" , required=false , defaultValue="1") String currentPage ,
			@RequestParam(value="type"        , required=false , defaultValue="") String type ,
			@RequestParam(value="keyword"     , required=false , defaultValue="") String keyword) throws IOException {
		// 전체글 수
		int total = this.proStoryService.getTotal();
		
		log.info("데이터 체크 currentPage     :: " + currentPage);
		log.info("데이터 체크 totalPageSize   :: " + total);
		log.info("데이터 체크 param           :: " + param);
		log.info("데이터 체크 type            :: " + type);
		log.info("데이터 체크 keyword         :: " + keyword);
		if(type == "") {
			param.put("type" , "제목");
		}
		
		if(param != null && type == "") {

			log.info("String keyword : " + keyword);
			param.put("keyword", keyword);
			param.put("type", "제목");
			log.info("Map keyword : " + param.get("keyword"));
		}
		
		Map<String , Object> searchParam = new HashMap<String, Object>();
		
		searchParam.put("currentPage", currentPage);
		searchParam.put("type"          , type);
		searchParam.put("keyword"       , keyword);
		
		log.info("getContent->searchParam : " + searchParam);
		
		List<ProStoryBbscttVO> pagingList = this.proStoryService.getPage(searchParam);
		
		ArticlePage5<ProStoryBbscttVO> data = new ArticlePage5<ProStoryBbscttVO>(total, Integer.parseInt(currentPage), 8 , pagingList, keyword , type);
		log.info("data : " + data);
	
		return data;
	}
	
	@ResponseBody
	@GetMapping("/getRecommend")
	public List<ProStoryBbscttVO> getWeekRecommend(Model model) {
		
		List<ProStoryBbscttVO> list = this.proStoryService.getWeekRecommend();

		model.addAttribute("list", list);

		return list;

	}
	
	/* 글쓰기 페이지 이동 */
	@GetMapping("/write")
	public String create(ProStoryBbscttVO proStoryBbscttVO) {
		
		return "prostory/write";
	}
	
	/* 글 작성 */
	@ResponseBody
	@PostMapping("/insert")
	public int insert(ProStoryBbscttVO proStoryBbscttVO
					  , HttpServletRequest request
					  , MultipartHttpServletRequest multi
					  ) {
		
		String userId = userId(request);
		
		proStoryBbscttVO.setProId(userId);
		
		int result = this.proStoryService.insert(proStoryBbscttVO , multi);
		System.out.println("proStoryBbscttVO :: "+ proStoryBbscttVO.getProStoryBbscttNo());
		return result;
	}
	
	/* 아이디 체크 */
	@ResponseBody
	@GetMapping("/idChk")
	public String idCheck(@RequestParam("writer")String chkId , HttpServletRequest request) {

		String userId = userId(request);
		
		System.out.println("체크할 아이디 : " + chkId);
		System.out.println("내 아이디 : " + userId);
		
		return userId.equals(chkId) ? "true" : "false";
		
	}
	/* 글 수정 페이지 이동 */
	@GetMapping("/update")
	public String update(@RequestParam("storyNo")int storyNo , Model model) {
		
		ProStoryBbscttVO proStoryBbscttVO = this.proStoryService.getStory(storyNo);
		
		log.debug("수정페이지 데이터 체크 : " + proStoryBbscttVO);
		
		model.addAttribute("getStory", this.proStoryService.getStory(storyNo));
		
		return "prostory/update";
	}
	
	/* 글 수정 */
	@ResponseBody @PostMapping("/update")
	public int updateStory(ProStoryBbscttVO proStoryBbscttVO
							, RedirectAttributes rttr
							, HttpServletRequest request
							, MultipartHttpServletRequest multi) {
		
		proStoryBbscttVO.setProId(userId(request));
		
		log.debug("proStoryBbscttVO 아이디 세팅 후" + proStoryBbscttVO);
		
		int result = this.proStoryService.updateStory(proStoryBbscttVO, multi);
		
		rttr.addFlashAttribute("result" , result);
		rttr.addFlashAttribute("storyNo" , result);
		return result;
	}
	
	/* 글 삭제 */
	@ResponseBody @PostMapping("/delete")
	public int delete(HttpServletRequest request , @RequestParam int storyNo) {
		
			return this.proStoryService.deleteStory(userId(request) , storyNo);
		
	}
	
	/* 게시글 상세보기 + 조회수 증가 */
	@GetMapping("/getStory")
	public String getProStory(@RequestParam("storyNo")Integer storyNo
								, HttpServletRequest request
								, HttpServletResponse response
								, Model model) throws JsonProcessingException {
		
		ProStoryBbscttVO proStoryBbscttVO = this.proStoryService.getStory(storyNo);
		
		ObjectMapper objp =  new ObjectMapper();
		
		String getStoryStr = objp.writeValueAsString(proStoryBbscttVO);
		
		int count = 0;
		
		
		Cookie orgCookie = null;
		Cookie[] cookies = request.getCookies();
		if(cookies != null) {
			
			for(Cookie cookie : cookies) {
				
				if(cookie.getName().equals("vistiNo")) {
					
					orgCookie = cookie;
				}
			}
		}
		
		if(orgCookie != null) {
			
			if(!orgCookie.getValue().contains("[" + storyNo.toString()+ "]")) {
				
				count = this.proStoryService.getStoryCount(storyNo);
				
				orgCookie.setValue(orgCookie.getValue() + "["+ storyNo + "]");
				orgCookie.setPath("/");
				orgCookie.setMaxAge(0);
				response.addCookie(orgCookie);
			}
		}
			else {
				count = this.proStoryService.getStoryCount(storyNo);
				
				Cookie newCookie = new Cookie("vistiNo" , "["+ storyNo + "]");
				newCookie.setPath("/");
				newCookie.setMaxAge(0);
				response.addCookie(newCookie);
			}
		log.debug("조회수 : " + count);
		log.debug("프로이야기 데이터 확인 : " + proStoryBbscttVO);
		
		model.addAttribute("getStory", proStoryBbscttVO);
		model.addAttribute("getStoryStr", getStoryStr);
		model.addAttribute("userId", userId(request));
		model.addAttribute("goodChk", getGoodCheck(userId(request), storyNo));
		
		log.info("모델 데이터 확인 userId : " + model.getAttribute("userId"));
		log.info("모델 데이터 확인 goodChk : " + model.getAttribute("goodChk"));

		return "prostory/detail";
		
	}
	/* 좋아요 체크 여부*/
	public int getGoodCheck(String userId , @RequestParam("storyNo")int storyNo) {
		
		System.out.println("체크 데이터 확인 : " + userId + "스토리 넘버 : " + storyNo);
		GoodPointVO goodPointVO = new GoodPointVO(storyNo , userId);
		
		System.out.println("체크 데이터 확인  goodPointVO: " + goodPointVO);
		int result = this.proStoryService.getGoodCheck(goodPointVO);
		
		log.debug("result Check " + result);
		return result;
	}
	
	/* 좋아요 */
	@ResponseBody
	@GetMapping("/goodUp")
	public ProStoryBbscttVO goodUp(@RequestParam("storyNo") int storyNo , HttpServletRequest request) {
		
		GoodPointVO goodPointVO = new GoodPointVO(storyNo , userId(request));
		
		ProStoryBbscttVO proStoryBbscttVO = this.proStoryService.updateGood(goodPointVO);
		
		return proStoryBbscttVO;
	}
	/* 좋아요 취소 */
	@ResponseBody
	@GetMapping("/goodCancle")
	public ProStoryBbscttVO goodCancle(@RequestParam("storyNo") int storyNo , HttpServletRequest request) {
		
		GoodPointVO goodPointVO = new GoodPointVO(storyNo ,userId(request) );
		
		ProStoryBbscttVO proStoryBbscttVO = this.proStoryService.goodRemove(goodPointVO);
		
		return proStoryBbscttVO;
	}
	
}