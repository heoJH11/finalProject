package kr.or.ddit.manage.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.admin.decl.service.DeclService;
import kr.or.ddit.admin.faq.service.FaqService;
import kr.or.ddit.admin.faq.vo.FaqVO;
import kr.or.ddit.admin.notice.service.NoticeService;
import kr.or.ddit.admin.notice.vo.NoticeVO;
import kr.or.ddit.admin.oneInqry.service.OneInqryService;
import kr.or.ddit.admin.usersSearch.service.UsersSearchService;
import kr.or.ddit.admin.usersSearch.vo.UsersVO;
import kr.or.ddit.manage.service.ManageService;
import kr.or.ddit.pro_service.service_inquiry.vo.V_SrvcBtfInqryVO;
import kr.or.ddit.util.ArticlePage;
import kr.or.ddit.util.fileupload.service.FileuploadService;
import kr.or.ddit.vo.DongChartVO;
import kr.or.ddit.vo.DongChartVO2;
import kr.or.ddit.vo.DongChartVO3;
import kr.or.ddit.vo.OneInqryAnswerVO;
import kr.or.ddit.vo.OneInqryVO;
import kr.or.ddit.vo.SntncDeclVO;
import kr.or.ddit.vo.SprviseAtchmnflVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/manage")
@Controller
public class ManageController {
	
	@Autowired
	ManageService manageService;
	
	
	@Autowired
	DeclService declService;
	
	@Autowired
	OneInqryService oneInqryService;
	
	@Autowired
	NoticeService noticeService;
	
	@Autowired
	FaqService faqService;
	
	@Autowired
	String uploadFolder;
	
	@Autowired
	UsersSearchService usersSearchService;
	
	@Autowired
	
	FileuploadService fileuploadService;
	
	
	String userId = "";
	OneInqryVO oneInqryVO = new OneInqryVO();
	OneInqryAnswerVO oneInqryAnwerVO = new OneInqryAnswerVO();
	
	public String userIdChk(HttpServletRequest request) {
		userId ="";
		HttpSession session = request.getSession();

		if(((HashMap)session.getAttribute("proSession"))!=null){
			userId = ((HashMap)session.getAttribute("proSession")).get("userId").toString();
		}else if(((HashMap)session.getAttribute("memSession"))!=null){
			userId = ((HashMap)session.getAttribute("memSession")).get("userId").toString();
		}else if(session.getAttribute("admSession")!=null){
			UsersVO usersVO = (UsersVO) session.getAttribute("admSession"); 
			userId = usersVO.getUserId(); 
		}
		
		log.info(" [관리자] userId : " + userId);
		return userId;
	}	
	
	
	//유저설치 디테일
	@GetMapping("/userDetail")
	public String usersDetail(@RequestParam String userId, Model model) {
		log.info("detail->usersDetail:"+userId);
		
		UsersVO usersVO = this.usersSearchService.detail(userId);
		log.info("detail->usersVO:"+usersVO);
		
		String profile = this.usersSearchService.getUserProfile(userId);
		
		log.info("profle"+ profile);
		model.addAttribute("usersVO", usersVO);
		model.addAttribute("profile", profile);
		
		return "manage/userDetail";
	}
	
	
	//공지사항 리스트
	@GetMapping("/notice")
	public String noticeList(Model model){
		List<NoticeVO> list = noticeService.getAllNoticeList();
		model.addAttribute("noticeList",list);
		
		DongChartVO dongVO = this.manageService.test();
		log.info("dongVO : " + dongVO);
		
		model.addAttribute("dongVO",dongVO);
		
		return "manage/notice";
	}
	
	//공지사항 등록
	@GetMapping(value="/create")
	  public String create(NoticeVO noticeVO,HttpSession session) {
		  log.info("create->noticeVO:" + noticeVO);
		  
		  return "manage/create2"; 
	  }
	
	//공지사항 상세
	@GetMapping(value="/detail")
	public String noticeDetail(@RequestParam int noticeNo, Model model){
	    log.info("detail->noticeDetail:"+noticeNo);
	    // 조회수 증가
	    this.noticeService.increaseViewCount(noticeNo);
	    // 공지사항 정보 조회
	    NoticeVO noticeVO = this.noticeService.detail(noticeNo);
	    model.addAttribute("noticeVO", noticeVO);
	    
	    NoticeVO noticeVOAtchVOList = this.noticeService.sprviseAtchmnflVO(noticeNo);
	    model.addAttribute("sprviseAtchmnflVOList",noticeVOAtchVOList);
	    
	    return "manage/detail";
	}
		
	//FAQ 리스트
	@GetMapping("/faq")
	public String faqList(Model model) {
		List<FaqVO> faqList = faqService.faqList();
		model.addAttribute("faqList",faqList);
		return "manage/faq";
	}
	
	//FAQ 등록
		@GetMapping(value="/create", params="register")
		public String createRegister(FaqVO faqVO) {	
			log.info("createRegister->faqVO:" + faqVO);
			return "manage/create";
		}
	
	//1대1문의 리스트
		@GetMapping("/oneInqryList")
		public String oneInqrylist() {
			return "manage/oneInqryList";
	}
	
		//1대1 문의 미답변
		@GetMapping("/oneInqryNoAnswerList")
		public String oneInqryNoAnswerList() {
			return "manage/oneInqryNoAnswerList";
		}
		
		@PostMapping("/oneInqryNoAnswerList")
		@ResponseBody
		public ArticlePage<OneInqryVO> oneInqryNoAnswerList(@RequestBody(required = false) Map<String,Object> map,
				HttpServletRequest request){
			
			userId = userIdChk(request);
			map.put("userId", userId);
			
			List<OneInqryVO> oneInqryVOList =
					this.oneInqryService.oneInqryNoAnswerList(map);

			int total = this.oneInqryService.getNoAnswerTotal(map);
			
			int size = 10;
			
			String currentPage = map.get("currentPage").toString();
			String keyword = map.get("keyword").toString();
			
			ArticlePage<OneInqryVO> data 
			= new ArticlePage<OneInqryVO>(total, Integer.parseInt(currentPage), size,oneInqryVOList,keyword);
			
			String url = "/manage/oneIqnryNoAnswerList";
			data.setUrl(url);
		
			map.put("data", data);
			return data;
		}
		
		
		// 1대1 문의 답변성공
		@GetMapping("/oneInqrySuccessList")
		public String oneInqrySuccessList() {
			return "manage/oneInqrySuccessList";
		}
		
		// 답변 완료 목록 출력
				@PostMapping("/oneInqrySuccessList")
				@ResponseBody
				public ArticlePage<OneInqryVO> oneInqrySuccessList(@RequestBody(required = false) Map<String,Object> map,
						HttpServletRequest request){
					
					userId = userIdChk(request);
					map.put("userId", userId);
					
					List<OneInqryVO> oneInqryVOList =
							this.oneInqryService.oneInqrySuccessList(map);

					int total = this.oneInqryService.getSuccessTotal(map);
					
					int size = 10;
					
					String currentPage = map.get("currentPage").toString();
					String keyword = map.get("keyword").toString();
					
					ArticlePage<OneInqryVO> data 
					= new ArticlePage<OneInqryVO>(total, Integer.parseInt(currentPage), size,oneInqryVOList,keyword);
					
					String url = "/manage/oneIqnrySuccessList";
					data.setUrl(url);
				
					return data;
				}
				@GetMapping("/oneInqryDetail")
				public String oneInqryDetail(@RequestParam("oneInqryNo") int oneInqryNo,Model model){
					
					oneInqryVO.setOneInqryNo(oneInqryNo);
					oneInqryVO = this.oneInqryService.oneInqryDetail(oneInqryVO, userId);
					
					log.info("1:1 detail -> userId  : " + userId);
					
					int sprviseAtchmnflNo = oneInqryVO.getSprviseAtchmnflNo();
					List<SprviseAtchmnflVO> sprviseAtchmnflVOList = this.fileuploadService.getsprviseAtchmnfl(sprviseAtchmnflNo);
					log.info("[oneinqryController] detail -> sprviseAtchmnflVOList : " + sprviseAtchmnflVOList );
					
					log.info("[oneinqryController] detail -> oneInqryVO.getSprviseAtchmnflVOList : " + oneInqryVO.getSprviseAtchmnflVOList());
					
					
					 oneInqryVO = this.oneInqryService.oneInqryDetail(oneInqryVO, userId);
					 oneInqryVO.setSprviseAtchmnflVOList(sprviseAtchmnflVOList);
					
					model.addAttribute("oneInqryVO", oneInqryVO);
					if("testAdmin".equals(userId)) {
						model.addAttribute("loginId", "admin");
					}
					
					return "manage/oneInqryDetail";
	
				}
	
				
				@PostMapping("/oneInqryUpdatePost")
				public String oneInqryUpdatePost(@RequestParam Map<String, Object> oneInqryUpdateMap,
											   @RequestParam("uploadFiles") List<MultipartFile> uploadFiles,
												HttpServletRequest request) {
					// 결과값
					// 사전문의 업데이트 
					// 사전문의 업데이트 + 기존 사진 삭제 
					// 사전문의 업데이트 + 기존 사진 삭제 + 새로운 사진 업데이트 
					int res = 0;
					
					userId = userIdChk(request);
					
					res = this.oneInqryService.oneInqryUpdatePost(oneInqryUpdateMap, uploadFiles, userId);
					
					return "redirect:/manage/oneInqryDetail?oneInqryNo="+oneInqryUpdateMap.get("oneInqryNo");
				}
	
	
//	@PostMapping("/searchList")
//	@ResponseBody
//	public Map<String, Object> searchList(@RequestBody(required = false) Map<String,Object> map,
//			HttpServletRequest request){
//		
//		userId = userIdChk(request);
//		map.put("userId", userId);
//		
//		List<OneInqryVO> oneInqryVOList =
//				this.oneInqryService.searchList(map);
//		log.info("1:1문의 전체 목록 : " + oneInqryVOList);
//
//		int total = this.oneInqryService.getTotal(map);
//		
//		int size = 10;
//		
//		String currentPage = map.get("currentPage").toString();
//		String keyword = map.get("keyword").toString();
//		
//		ArticlePage<OneInqryVO> data 
//		= new ArticlePage<OneInqryVO>(total, Integer.parseInt(currentPage), size,oneInqryVOList, keyword);
//		
//		String url = "/manage/oneInqryList";
//		data.setUrl(url);
//		
//		map.put("data", data);
//		
//		return map;
//	}
	
	
	
	
	@GetMapping("/decl")
	public String lbrbbs(Model model, Map<String,Object> map, HttpServletRequest request,
			@RequestParam(value="currentPage",required=false,defaultValue="1") int currentPage) {
		
		map.put("currentPage", currentPage);
		List<SntncDeclVO> lbrbbsList = this.declService.decllbrSelect(map);
		log.info("lbrbbs-> lbrbbsList : " + lbrbbsList);
		model.addAttribute("lbrbbsList",lbrbbsList);
		
		return "manage/decl";
	}
	
	@GetMapping("/userdecl")
	public String userdecl(Model model, Map<String,Object> map, HttpServletRequest request,
			@RequestParam(value="currentPage",required=false,defaultValue="1") int currentPage) {
		
		map.put("currentPage", currentPage);
		List<SntncDeclVO> lbrbbsList = this.declService.decllbrSelect(map);
		log.info("lbrbbs-> lbrbbsList : " + lbrbbsList);
		model.addAttribute("lbrbbsList",lbrbbsList);
		
		return "manage/userdecl";
	}
	
	@GetMapping("/resignPro")
	public String btfInqryList(Model model, HttpServletRequest request, Map<String, Object> map,
			@RequestParam(value = "currentPage", required = false, defaultValue = "1") int currentPage) {

		map.put("currentPage", currentPage);

		// 전체 리스트 출력
		List<OneInqryVO> oneInqryVOList = this.oneInqryService.resignProList(map);

		model.addAttribute("oneInqryVOList", oneInqryVOList);

		return "manage/resignProList";
	}
	
	@PostMapping("/userDanger")
	@ResponseBody
	public int userDanger(String userId) {
		log.info("update->result : "+userId);
		int result = this.usersSearchService.userDanger(userId);
		return result;
	}
	
	
	// 검색 목록 출력
	@PostMapping("/resignProList")
	@ResponseBody
	public ArticlePage<OneInqryVO> resignProList(@RequestBody(required = false) Map<String, Object> map,
			HttpServletRequest request) {

		List<OneInqryVO> oneInqryVOList = this.oneInqryService.resignProList(map);

		int total = this.oneInqryService.getTotalResignPro(map);

		int size = 10;

		String currentPage = map.get("currentPage").toString();
		String keyword = map.get("keyword").toString();

		ArticlePage<OneInqryVO> data = new ArticlePage<OneInqryVO>(total, Integer.parseInt(currentPage),
				size, oneInqryVOList, keyword);

		String url = "/manage/resignProList";
		data.setUrl(url);

		return data;
	}
	
	// 유저 탈퇴 수락
	@ResponseBody
	@PostMapping("/proSecssion")
	public int proSecssion(String proId) {
		
		return this.oneInqryService.proSecssion(proId);
	}
	
	//메인 페이지 가기
	@GetMapping("/main")
	public String main(Model model) {
		DongChartVO dongVO = this.manageService.test();
		log.info("dongVO : " + dongVO);
		
		DongChartVO2 dongVO2 = this.manageService.test2();
		log.info("dongVO2 : " + dongVO2);
		
		DongChartVO3 dongVO3 = this.manageService.test3();
		log.info("dongVO3 : " + dongVO3);
		
		
		model.addAttribute("dongVO",dongVO);
		model.addAttribute("dongVO2",dongVO2);
		model.addAttribute("dongVO3",dongVO3);
		
		return "manage/main";
	}
	
	//메인 페이지 가기
	@GetMapping("/main2")
	public String main2(Model model) {
		return "manage/main2";
	}
	
}
