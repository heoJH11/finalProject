package kr.or.ddit.admin.oneInqry.controller;

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

import com.google.gson.Gson;

import kr.or.ddit.admin.oneInqry.service.OneInqryService;
import kr.or.ddit.pro_service.service_inquiry.vo.V_SrvcBtfInqryVO;
import kr.or.ddit.util.ArticlePage;
import kr.or.ddit.util.fileupload.service.FileuploadService;
import kr.or.ddit.vo.OneInqryAnswerVO;
import kr.or.ddit.vo.OneInqryVO;
import kr.or.ddit.vo.SprviseAtchmnflVO;
import kr.or.ddit.vo.SrvcBtfInqryVO;
import kr.or.ddit.vo.UsersVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/oneInqry")
public class oneInqryController {
	
	@Autowired
	OneInqryService oneInqryService;
	
	@Autowired
	FileuploadService fileuploadService;
	
	
	// 세션에서 가져올 아이디
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
	
	@GetMapping("/oneInqryCreate")
	public String oneInqryCreate() {
		return "oneInqry/oneInqryCreate";
	}
	
	@PostMapping("/oneInqryCreatePost")
	public String btfInqryCreatePost(@RequestParam Map<String, Object> oneInqryInfoMap, 
									@RequestParam("uploadFiles") List<MultipartFile> uploadFiles,
									HttpServletRequest request) {
		
		userId = userIdChk(request);
		
		log.info("관리자문의 컨트롤/ 관리자 문의 파람맵" + oneInqryInfoMap );
		
		OneInqryVO oneInqryVO = new OneInqryVO();
		oneInqryVO.setOneInqrySj((String)oneInqryInfoMap.get("oneInqrySj"));
		oneInqryVO.setOneInqryCn((String)oneInqryInfoMap.get("oneInqryCn"));
		oneInqryVO.setUserId(userId);
		
		int res = 0;
		
		res = this.oneInqryService.oneInqryCreatePost(oneInqryVO, uploadFiles);
		
		return "redirect:/oneInqry/oneInqryList";
	}
	
	// 목록
	@GetMapping("/oneInqryList")
	public String oneInqrylist() {
		return "oneInqry/oneInqryList";
	}
	// 목록
	@GetMapping("/oneInqryNoAnswerList")
	public String oneInqryNoAnswerList() {
		return "oneInqry/oneInqryNoAnswerList";
	}
	// 목록
	@GetMapping("/oneInqrySuccessList")
	public String oneInqrySuccessList() {
		return "oneInqry/oneInqrySuccessList";
	}
	
	// 목록
	@GetMapping("/myOneInqryList")
	public String myOneInqrylist() {
		return "oneInqry/myOneInqryList";
	}
	// 목록
	@GetMapping("/myOneInqryNoAnswerList")
	public String myOneInqryNoAnswerList() {
		return "oneInqry/myOneInqryNoAnswerList";
	}
	// 목록
	@GetMapping("/myOneInqrySuccessList")
	public String myOneInqrySuccessList() {
		return "oneInqry/myOneInqrySuccessList";
	}
	
	//전체 및 검색 목록 출력
		@PostMapping("/searchList")
		@ResponseBody
		public Map<String, Object> searchList(@RequestBody(required = false) Map<String,Object> map,
				HttpServletRequest request){
			
			userId = userIdChk(request);
			map.put("userId", userId);
			
			List<OneInqryVO> oneInqryVOList =
					this.oneInqryService.searchList(map);
			log.info("1:1문의 전체 목록 : " + oneInqryVOList);

			int total = this.oneInqryService.getTotal(map);
			
			int size = 10;
			
			String currentPage = map.get("currentPage").toString();
			String keyword = map.get("keyword").toString();
			
			ArticlePage<OneInqryVO> data 
			= new ArticlePage<OneInqryVO>(total, Integer.parseInt(currentPage), size,oneInqryVOList, keyword);
			
			String url = "/oneInqry/oneInqryList";
			data.setUrl(url);
			
			map.put("data", data);
			
			return map;
		}
		
		// 답변 안된 목록 출력
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
			
			String url = "/oneInqry/oneIqnryNoAnswerList";
			data.setUrl(url);
		
			map.put("data", data);
			return data;
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
			
			String url = "/oneInqry/oneIqnrySuccessList";
			data.setUrl(url);
		
			return data;
		}
		
		//전체 및 검색 목록 출력
		@PostMapping("/mySearchList")
		@ResponseBody
		public Map<String, Object> mySearchList(@RequestBody(required = false) Map<String,Object> map,
				HttpServletRequest request){
			
			userId = userIdChk(request);
			map.put("userId", userId);
			
			List<OneInqryVO> oneInqryVOList =
					this.oneInqryService.searchList(map);
			log.info("1:1문의 전체 목록 : " + oneInqryVOList);

			int total = this.oneInqryService.getTotal(map);
			
			int size = 10;
			
			String currentPage = map.get("currentPage").toString();
			String keyword = map.get("keyword").toString();
			
			ArticlePage<OneInqryVO> data 
			= new ArticlePage<OneInqryVO>(total, Integer.parseInt(currentPage), size,oneInqryVOList, keyword);
			
			String url = "/oneInqry/myOneInqryList";
			data.setUrl(url);
			
			map.put("data", data);
			
			return map;
		}
		
		// 답변 안된 목록 출력
		@PostMapping("/myOneInqryNoAnswerList")
		@ResponseBody
		public ArticlePage<OneInqryVO> myOneInqryNoAnswerList(@RequestBody(required = false) Map<String,Object> map,
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
			
			String url = "/oneInqry/myOneIqnryNoAnswerList";
			data.setUrl(url);
		
			map.put("data", data);
			return data;
		}
		
		// 답변 완료 목록 출력
		@PostMapping("/myOneInqrySuccessList")
		@ResponseBody
		public ArticlePage<OneInqryVO> myOneInqrySuccessList(@RequestBody(required = false) Map<String,Object> map,
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
			
			String url = "/oneInqry/myOneIqnrySuccessList";
			data.setUrl(url);
		
			return data;
		}
	
		@GetMapping("/oneInqryDetail")
		public String oneInqryDetail(@RequestParam("oneInqryNo") int oneInqryNo, String userId,Model model){
			OneInqryVO oneInqryVO = new OneInqryVO();
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
			
			return "oneInqry/oneInqryDetail";
			
			
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
			
			return "redirect:/oneInqry/oneInqryDetail?oneInqryNo="+oneInqryUpdateMap.get("oneInqryNo");
		}
		
		@PostMapping("/updateAnswer")
		@ResponseBody
		public int updateAnswer(@RequestBody Map<String, Object> param) {
			int res = 0;
			
			int oneInqryNo = Integer.parseInt(String.valueOf(param.get("oneInqryNo")));
			String oneInqryAnswerCn = (String)param.get("oneInqryAnswerCn");
			userId = (String)param.get("userId");
			
			Map<String, Object> updateParamMap = new HashMap<String, Object>();
			updateParamMap.put("oneInqryNo", oneInqryNo);
			updateParamMap.put("oneInqryAnswerCn", oneInqryAnswerCn);
			updateParamMap.put("userId", userId);
			
			res = this.oneInqryService.updateAnswer(updateParamMap, userId);
			
			return res;
		}
		
		@PostMapping("/resignPro")
		public String resignPro(@RequestParam("resignReason") String resignReason, 
								@RequestParam(value="resignReasonInput", required = false) String resignReasonInput,
								@RequestParam("userId") String userId) {
			
			int res = 0;
			
			
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("userId", userId);
			if("기타".equals(resignReason)) {
				map.put("oneIqnryCn", resignReasonInput);
			}else {
				map.put("oneIqnryCn", resignReason);
				
			}
			
			log.info("프로 탈퇴 사유 : " + resignReason);
			log.info("프로 탈퇴 사유(기타) : " + resignReasonInput);
			log.info("프로 탈퇴 아이디: " + userId);
			log.info("프로 탈퇴 map : " + map);
			
			res = this.oneInqryService.resignPro(map);
			
			return "redirect:/pro/proMypage";
		}
	
}
