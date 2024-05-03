package kr.or.ddit.pro_service.service_inquiry.controller;

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
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.support.RequestDataValueProcessor;

import kr.or.ddit.pro_service.service_inquiry.service.SrvcBtfInqryService;
import kr.or.ddit.pro_service.service_inquiry.vo.V_SrvcBtfInqryVO;
import kr.or.ddit.pro_service.service_request.service.SrvcRequstService;
import kr.or.ddit.pro_service.service_request.vo.V_SrvcRequstVO;
import kr.or.ddit.util.ArticlePage;
import kr.or.ddit.util.fileupload.service.FileuploadService;
import kr.or.ddit.vo.SprviseAtchmnflVO;
import kr.or.ddit.vo.SrvcBtfInqryVO;
import kr.or.ddit.vo.UsersVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/srvcBtfInqry")
public class SrvcBtfInqryController {

	@Autowired
	SrvcBtfInqryService srvcBtfInqryService;

	@Autowired
	FileuploadService fileuploadService;
//	SrvcRequstService srvcRequstService;

	// 세션에서 가져올 아이디
	String userId = "";
	V_SrvcBtfInqryVO vSrvcBtfInqryVO = new V_SrvcBtfInqryVO();

	public String userIdChk(HttpServletRequest request) {
		userId = "";
		HttpSession session = request.getSession();

		if (((HashMap) session.getAttribute("proSession")) != null) {
			userId = ((HashMap) session.getAttribute("proSession")).get("userId").toString();
		} else if (((HashMap) session.getAttribute("memSession")) != null) {
			userId = ((HashMap) session.getAttribute("memSession")).get("userId").toString();
		}
		return userId;
	}

	// 전체 목록 출력
	@GetMapping("/btfInqryList")
	public String btfInqryList(Model model, HttpServletRequest request, Map<String, Object> map,
			@RequestParam(value = "currentPage", required = false, defaultValue = "1") int currentPage) {

		userId = userIdChk(request);

		map.put("userId", userId);
		map.put("currentPage", currentPage);

		// 전체 리스트 출력
		List<V_SrvcBtfInqryVO> vSrvcBtfInqryVOList = this.srvcBtfInqryService.btfInqryList(map);

		model.addAttribute("vSrvcBtfInqryVOList", vSrvcBtfInqryVOList);
		log.info("btfInqryList -> vsrvcBtfInqryVOList : " + vSrvcBtfInqryVOList);

		return "srvcBtfInqry/btfInqryList";
	}

	// 미답변 목록 출력
	@GetMapping("/btfInqryNoAnswerList")
	public String btfInqryNoAnswerList(Model model, HttpServletRequest request, Map<String, Object> map,
			@RequestParam(value = "currentPage", required = false, defaultValue = "1") int currentPage) {

		userId = userIdChk(request);

		map.put("userId", userId);
		map.put("currentPage", currentPage);

		// 미답변 리스트 출력
		List<V_SrvcBtfInqryVO> vSrvcBtfInqryVOList = this.srvcBtfInqryService.btfInqryNoAnswerList(map);

		model.addAttribute("vSrvcBtfInqryVOList", vSrvcBtfInqryVOList);
		log.info("btfInqryList -> vsrvcBtfInqryVOList : " + vSrvcBtfInqryVOList);

		return "srvcBtfInqry/btfInqryNoAnswerList";
	}

	// 미답변 목록 출력
	@GetMapping("/btfInqrySuccessList")
	public String btfInqrySuccessList(Model model, HttpServletRequest request, Map<String, Object> map,
			@RequestParam(value = "currentPage", required = false, defaultValue = "1") int currentPage) {

		userId = userIdChk(request);

		map.put("userId", userId);
		map.put("currentPage", currentPage);

		// 미답변 리스트 출력
		List<V_SrvcBtfInqryVO> vSrvcBtfInqryVOList = this.srvcBtfInqryService.btfInqrySuccessList(map);

		model.addAttribute("vSrvcBtfInqryVOList", vSrvcBtfInqryVOList);
		log.info("btfInqryList -> vsrvcBtfInqryVOList : " + vSrvcBtfInqryVOList);

		return "srvcBtfInqry/btfInqrySuccessList";
	}

	// 전체 목록 출력
	@GetMapping("/myBtfInqryList")
	public String myBtfInqryList(Model model, HttpServletRequest request, Map<String, Object> map,
			@RequestParam(value = "currentPage", required = false, defaultValue = "1") int currentPage) {

		userId = userIdChk(request);

		map.put("userId", userId);
		map.put("currentPage", currentPage);

		// 전체 리스트 출력
		List<V_SrvcBtfInqryVO> vSrvcBtfInqryVOList = this.srvcBtfInqryService.btfInqryList(map);

		model.addAttribute("vSrvcBtfInqryVOList", vSrvcBtfInqryVOList);
		log.info("btfInqryList -> vsrvcBtfInqryVOList : " + vSrvcBtfInqryVOList);

		return "srvcBtfInqry/myBtfInqryList";
	}

	// 미답변 목록 출력
	@GetMapping("/myBtfInqryNoAnswerList")
	public String myBtfInqryNoAnswerList(Model model, HttpServletRequest request, Map<String, Object> map,
			@RequestParam(value = "currentPage", required = false, defaultValue = "1") int currentPage) {

		userId = userIdChk(request);

		map.put("userId", userId);
		map.put("currentPage", currentPage);

		// 미답변 리스트 출력
		List<V_SrvcBtfInqryVO> vSrvcBtfInqryVOList = this.srvcBtfInqryService.btfInqryNoAnswerList(map);

		model.addAttribute("vSrvcBtfInqryVOList", vSrvcBtfInqryVOList);
		log.info("btfInqryList -> vsrvcBtfInqryVOList : " + vSrvcBtfInqryVOList);

		return "srvcBtfInqry/myBtfInqryNoAnswerList";
	}

	// 미답변 목록 출력
	@GetMapping("/myBtfInqrySuccessList")
	public String myBtfInqrySuccessList(Model model, HttpServletRequest request, Map<String, Object> map,
			@RequestParam(value = "currentPage", required = false, defaultValue = "1") int currentPage) {

		userId = userIdChk(request);

		map.put("userId", userId);
		map.put("currentPage", currentPage);

		// 미답변 리스트 출력
		List<V_SrvcBtfInqryVO> vSrvcBtfInqryVOList = this.srvcBtfInqryService.btfInqrySuccessList(map);

		model.addAttribute("vSrvcBtfInqryVOList", vSrvcBtfInqryVOList);
		log.info("btfInqryList -> vsrvcBtfInqryVOList : " + vSrvcBtfInqryVOList);

		return "srvcBtfInqry/myBtfInqrySuccessList";
	}

	// 검색 목록 출력
	@PostMapping("/searchList")
	@ResponseBody
	public ArticlePage<V_SrvcBtfInqryVO> searchList(@RequestBody(required = false) Map<String, Object> map,
			HttpServletRequest request) {

		userId = userIdChk(request);
		map.put("userId", userId);

		List<V_SrvcBtfInqryVO> vSrvcBtfInqryVOList = this.srvcBtfInqryService.btfInqryList(map);

		int total = this.srvcBtfInqryService.getTotal(map);

		int size = 10;

		String currentPage = map.get("currentPage").toString();
		String keyword = map.get("keyword").toString();

		ArticlePage<V_SrvcBtfInqryVO> data = new ArticlePage<V_SrvcBtfInqryVO>(total, Integer.parseInt(currentPage),
				size, vSrvcBtfInqryVOList, keyword);

		String url = "/srvcBtfInqry/btfIqnryList";
		data.setUrl(url);

		return data;
	}

	// 답변 안된 목록 출력
	@PostMapping("/btfInqryNoAnswerList")
	@ResponseBody
	public ArticlePage<V_SrvcBtfInqryVO> btfInqryNoAnswerList(@RequestBody(required = false) Map<String, Object> map,
			HttpServletRequest request) {

		userId = userIdChk(request);
		map.put("userId", userId);

		List<V_SrvcBtfInqryVO> vSrvcBtfInqryVOList = this.srvcBtfInqryService.btfInqryNoAnswerList(map);

		int total = this.srvcBtfInqryService.getNoAnswerTotal(map);

		int size = 10;

		String currentPage = map.get("currentPage").toString();
		String keyword = map.get("keyword").toString();

		ArticlePage<V_SrvcBtfInqryVO> data = new ArticlePage<V_SrvcBtfInqryVO>(total, Integer.parseInt(currentPage),
				size, vSrvcBtfInqryVOList, keyword);

		String url = "/srvcBtfInqry/btfIqnryNoAnswerList";
		data.setUrl(url);

		return data;
	}

	// 답변 완료 목록 출력
	@PostMapping("/btfInqrySuccessList")
	@ResponseBody
	public ArticlePage<V_SrvcBtfInqryVO> btfInqrySuccessList(@RequestBody(required = false) Map<String, Object> map,
			HttpServletRequest request) {

		userId = userIdChk(request);
		map.put("userId", userId);

		List<V_SrvcBtfInqryVO> vSrvcBtfInqryVOList = this.srvcBtfInqryService.btfInqrySuccessList(map);

		int total = this.srvcBtfInqryService.getSuccessTotal(map);

		int size = 10;

		String currentPage = map.get("currentPage").toString();
		String keyword = map.get("keyword").toString();

		ArticlePage<V_SrvcBtfInqryVO> data = new ArticlePage<V_SrvcBtfInqryVO>(total, Integer.parseInt(currentPage),
				size, vSrvcBtfInqryVOList, keyword);

		String url = "/srvcBtfInqry/btfIqnrySuccessList";
		data.setUrl(url);

		return data;
	}

	// 검색 목록 출력
	@PostMapping("/mySearchList")
	@ResponseBody
	public ArticlePage<V_SrvcBtfInqryVO> mySearchList(@RequestBody(required = false) Map<String, Object> map,
			HttpServletRequest request) {

		userId = userIdChk(request);
		map.put("userId", userId);

		List<V_SrvcBtfInqryVO> vSrvcBtfInqryVOList = this.srvcBtfInqryService.btfInqryList(map);

		int total = this.srvcBtfInqryService.getTotal(map);

		int size = 10;

		String currentPage = map.get("currentPage").toString();
		String keyword = map.get("keyword").toString();

		ArticlePage<V_SrvcBtfInqryVO> data = new ArticlePage<V_SrvcBtfInqryVO>(total, Integer.parseInt(currentPage),
				size, vSrvcBtfInqryVOList, keyword);

		String url = "/srvcBtfInqry/myBtfIqnryList";
		data.setUrl(url);

		return data;
	}

	// 답변 안된 목록 출력
	@PostMapping("/myBtfInqryNoAnswerList")
	@ResponseBody
	public ArticlePage<V_SrvcBtfInqryVO> myBtfInqryNoAnswerList(@RequestBody(required = false) Map<String, Object> map,
			HttpServletRequest request) {

		userId = userIdChk(request);
		map.put("userId", userId);

		List<V_SrvcBtfInqryVO> vSrvcBtfInqryVOList = this.srvcBtfInqryService.btfInqryNoAnswerList(map);

		int total = this.srvcBtfInqryService.getNoAnswerTotal(map);

		int size = 10;

		String currentPage = map.get("currentPage").toString();
		String keyword = map.get("keyword").toString();

		ArticlePage<V_SrvcBtfInqryVO> data = new ArticlePage<V_SrvcBtfInqryVO>(total, Integer.parseInt(currentPage),
				size, vSrvcBtfInqryVOList, keyword);

		String url = "/srvcBtfInqry/myBtfIqnryNoAnswerList";
		data.setUrl(url);

		return data;
	}

	// 답변 완료 목록 출력
	@PostMapping("/myBtfInqrySuccessList")
	@ResponseBody
	public ArticlePage<V_SrvcBtfInqryVO> myBtfInqrySuccessList(@RequestBody(required = false) Map<String, Object> map,
			HttpServletRequest request) {

		userId = userIdChk(request);
		map.put("userId", userId);

		List<V_SrvcBtfInqryVO> vSrvcBtfInqryVOList = this.srvcBtfInqryService.btfInqrySuccessList(map);

		int total = this.srvcBtfInqryService.getSuccessTotal(map);

		int size = 10;

		String currentPage = map.get("currentPage").toString();
		String keyword = map.get("keyword").toString();

		ArticlePage<V_SrvcBtfInqryVO> data = new ArticlePage<V_SrvcBtfInqryVO>(total, Integer.parseInt(currentPage),
				size, vSrvcBtfInqryVOList, keyword);

		String url = "/srvcBtfInqry/myBtfIqnrySuccessList";
		data.setUrl(url);

		return data;
	}

	@GetMapping("/btfInqryDetail")
	public String btfInqryDetail(@RequestParam("btfInqryNo") int btfInqryNo, Model model) {

		vSrvcBtfInqryVO.setBtfInqryNo(btfInqryNo);
		vSrvcBtfInqryVO = this.srvcBtfInqryService.btfInqryDetail(vSrvcBtfInqryVO, userId);

		int sprviseAtchmnflNo = vSrvcBtfInqryVO.getSprviseAtchmnflNo();
		List<SprviseAtchmnflVO> sprviseAtchmnflVOList = this.fileuploadService.getsprviseAtchmnfl(sprviseAtchmnflNo);

		log.info("btfInqryDetail -> vSrvcBtfInqryVO : " + vSrvcBtfInqryVO);

		vSrvcBtfInqryVO = this.srvcBtfInqryService.btfInqryDetail(vSrvcBtfInqryVO, userId);
		log.info("btfInqryDetail -> vSrvcBtfInqryVO.getSprviseAtchmnflVOList() : "
				+ vSrvcBtfInqryVO.getSprviseAtchmnflVOList());
		log.info("btfInqryDetail -> vSrvcBtfInqryVO.getEmplyrTy : " + vSrvcBtfInqryVO.getEmplyrTy());

		model.addAttribute("vSrvcBtfInqryVO", vSrvcBtfInqryVO);

		return "srvcBtfInqry/btfInqryDetail";
	}

	@PostMapping("/updateAnswer")
	@ResponseBody
	public int updateAnswer(@RequestBody Map<String, Object> param) {
		int res = 0;

		System.out.println("번호 : " + param.get("btfInqryNo"));

		int btfInqryNo = Integer.parseInt(String.valueOf(param.get("btfInqryNo")));
		String btfInqryAnswerCn = (String) param.get("btfInqryAnswerCn");

		Map<String, Object> updateParamMap = new HashMap<String, Object>();
		updateParamMap.put("btfInqryNo", btfInqryNo);
		updateParamMap.put("btfInqryAnswerCn", btfInqryAnswerCn);

		res = this.srvcBtfInqryService.updateAnswer(updateParamMap, userId);

		return res;
	}

	@GetMapping("/btfInqryCreate")
	public String btfInqryCreate(@RequestParam("proId") String proId) {
		return "srvcBtfInqry/btfInqryCreate";
	}

	@PostMapping("/btfInqryCreatePost")
	public String btfInqryCreatePost(@RequestParam Map<String, Object> btfInqryInfoMap,
			@RequestParam("uploadFiles") List<MultipartFile> uploadFiles, HttpServletRequest request) {

		userId = userIdChk(request);

		log.info("[btfInqryController] createPost -> proId : " + btfInqryInfoMap.get("proId"));
		SrvcBtfInqryVO srvcBtfInqryVO = new SrvcBtfInqryVO();
		srvcBtfInqryVO.setBtfInqrySj((String) btfInqryInfoMap.get("btfInqrySj"));
		srvcBtfInqryVO.setBtfInqryCn((String) btfInqryInfoMap.get("btfInqryCn"));
		srvcBtfInqryVO.setProId((String) btfInqryInfoMap.get("proId"));

		log.info("[btfInqryController] btfInqryCreatePost->userId : " + userId);
		srvcBtfInqryVO.setMberId(userId);
		int res = 0;

		res = this.srvcBtfInqryService.btfInqryCreatePost(srvcBtfInqryVO, uploadFiles);

		return "redirect:/srvcBtfInqry/btfInqryList?mberCheck=mber";
	}

	@PostMapping("/btfInqryUpdatePost")
	public String btfInqryUpdatePost(@RequestParam Map<String, Object> btfInqryUpdateMap,
			@RequestParam("uploadFiles") List<MultipartFile> uploadFiles, HttpServletRequest request) {
		// 결과값
		// 사전문의 업데이트
		// 사전문의 업데이트 + 기존 사진 삭제
		// 사전문의 업데이트 + 기존 사진 삭제 + 새로운 사진 업데이트
		int res = 0;

		userId = userIdChk(request);
		log.info("btfInqryUpdatePost -> btfInqryUpdateMap : " + btfInqryUpdateMap.toString());
		log.info("btfInqryUpdatePost -> uploadFiles : " + uploadFiles.toString());

		res = this.srvcBtfInqryService.btfInqryUpdatePost(btfInqryUpdateMap, uploadFiles, userId);

		return "redirect:/srvcBtfInqry/btfInqryDetail?btfInqryNo=" + btfInqryUpdateMap.get("btfInqryNo");
	}
}
