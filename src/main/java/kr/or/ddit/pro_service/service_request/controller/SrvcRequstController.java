package kr.or.ddit.pro_service.service_request.controller;

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

import kr.or.ddit.pro.proProfl.service.ProProflService;
import kr.or.ddit.pro_service.service_request.service.ReviewService;
import kr.or.ddit.pro_service.service_request.service.SrvcRequstService;
import kr.or.ddit.pro_service.service_request.vo.V_SrvcRequstVO;
import kr.or.ddit.util.ArticlePage;
import kr.or.ddit.util.fileupload.service.FileuploadService;
import kr.or.ddit.vo.ProProflVO;
import kr.or.ddit.vo.SprviseAtchmnflVO;
import kr.or.ddit.vo.SrvcRequstVO;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/srvcRequst")
@Slf4j
public class SrvcRequstController {

	@Autowired
	SrvcRequstService srvcRequstService;

	@Autowired
	ReviewService reviewService;

	@Autowired
	FileuploadService fileuploadService;

	@Autowired
	ProProflService proProflService;

	String userId = "";
	V_SrvcRequstVO vSrvcRequstVO = new V_SrvcRequstVO();

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

	@GetMapping("/srvcRqList")
	public String srvcRqList(Model model, Map<String, Object> map, HttpServletRequest request,
			@RequestParam(value = "currentPage", required = false, defaultValue = "1") int currentPage) {

		userId = userIdChk(request);
		map.put("userId", userId);
		map.put("currentPage", currentPage);

		int size = 10;
		map.put("size", size);

		List<V_SrvcRequstVO> vSrvcRequstVOList = this.srvcRequstService.srvcRqList(map);

		model.addAttribute("vSrvcRequstVOList", vSrvcRequstVOList);
		log.info("srvcRqList -> vSrvcRequstVOList : " + vSrvcRequstVOList);

		return "srvcRq/srvcRqList";
	};

	@GetMapping("/srvcRqNoAnswerList")
	public String srvcRqNoAnswerList(Model model, Map<String, Object> map, HttpServletRequest request,
			@RequestParam(value = "currentPage", required = false, defaultValue = "1") int currentPage) {

		userId = userIdChk(request);

		map.put("userId", userId);
		map.put("currentPage", currentPage);

		int size = 10;
		map.put("size", size);

		List<V_SrvcRequstVO> vSrvcRequstVOList = this.srvcRequstService.srvcRqNoAnswerList(map);

		model.addAttribute("vSrvcRequstVOList", vSrvcRequstVOList);
		log.info("srvcRqList -> vSrvcRequstVOList : " + vSrvcRequstVOList);

		return "srvcRq/srvcRqNoAnswerList";
	};

	@GetMapping("/srvcRqSuccessList")
	public String srvcRqSuccessList(Model model, Map<String, Object> map, HttpServletRequest request,
			@RequestParam(value = "currentPage", required = false, defaultValue = "1") int currentPage) {

		userId = userIdChk(request);

		map.put("userId", userId);
		map.put("currentPage", currentPage);

		int size = 10;
		map.put("size", size);

		List<V_SrvcRequstVO> vSrvcRequstVOList = this.srvcRequstService.srvcRqSuccessList(map);

		model.addAttribute("vSrvcRequstVOList", vSrvcRequstVOList);
		log.info("srvcRqList -> vSrvcRequstVOList : " + vSrvcRequstVOList);

		return "srvcRq/srvcRqSuccessList";
	};

	@GetMapping("/srvcRqRejectList")
	public String srvcRqRejectList(Model model, Map<String, Object> map, HttpServletRequest request,
			@RequestParam(value = "currentPage", required = false, defaultValue = "1") int currentPage) {

		userId = userIdChk(request);

		map.put("userId", userId);
		map.put("currentPage", currentPage);

		int size = 10;
		map.put("size", size);

		List<V_SrvcRequstVO> vSrvcRequstVOList = this.srvcRequstService.srvcRqRejectList(map);

		model.addAttribute("vSrvcRequstVOList", vSrvcRequstVOList);
		log.info("srvcRqList -> vSrvcRequstVOList : " + vSrvcRequstVOList);

		return "srvcRq/srvcRqRejectList";
	};

	@GetMapping("/mySrvcRqList")
	public String mySrvcRqList(Model model, Map<String, Object> map, HttpServletRequest request,
			@RequestParam(value = "currentPage", required = false, defaultValue = "1") int currentPage) {

		userId = userIdChk(request);
		map.put("userId", userId);
		map.put("currentPage", currentPage);

		int size = 10;
		map.put("size", size);

		List<V_SrvcRequstVO> vSrvcRequstVOList = this.srvcRequstService.srvcRqList(map);

		model.addAttribute("vSrvcRequstVOList", vSrvcRequstVOList);
		log.info("srvcRqList -> vSrvcRequstVOList : " + vSrvcRequstVOList);

		return "srvcRq/mySrvcRqList";
	};

	@GetMapping("/mySrvcRqNoAnswerList")
	public String mySrvcRqNoAnswerList(Model model, Map<String, Object> map, HttpServletRequest request,
			@RequestParam(value = "currentPage", required = false, defaultValue = "1") int currentPage) {

		userId = userIdChk(request);

		map.put("userId", userId);
		map.put("currentPage", currentPage);

		int size = 10;
		map.put("size", size);

		List<V_SrvcRequstVO> vSrvcRequstVOList = this.srvcRequstService.srvcRqNoAnswerList(map);

		model.addAttribute("vSrvcRequstVOList", vSrvcRequstVOList);
		log.info("srvcRqList -> vSrvcRequstVOList : " + vSrvcRequstVOList);

		return "srvcRq/mySrvcRqNoAnswerList";
	};

	@GetMapping("/mySrvcRqSuccessList")
	public String mySrvcRqSuccessList(Model model, Map<String, Object> map, HttpServletRequest request,
			@RequestParam(value = "currentPage", required = false, defaultValue = "1") int currentPage) {

		userId = userIdChk(request);

		map.put("userId", userId);
		map.put("currentPage", currentPage);

		int size = 10;
		map.put("size", size);

		List<V_SrvcRequstVO> vSrvcRequstVOList = this.srvcRequstService.srvcRqSuccessList(map);

		model.addAttribute("vSrvcRequstVOList", vSrvcRequstVOList);
		log.info("srvcRqList -> vSrvcRequstVOList : " + vSrvcRequstVOList);

		return "srvcRq/mySrvcRqSuccessList";
	};

	@GetMapping("/mySrvcRqRejectList")
	public String mySrvcRqRejectList(Model model, Map<String, Object> map, HttpServletRequest request,
			@RequestParam(value = "currentPage", required = false, defaultValue = "1") int currentPage) {

		userId = userIdChk(request);

		map.put("userId", userId);
		map.put("currentPage", currentPage);

		int size = 10;
		map.put("size", size);

		List<V_SrvcRequstVO> vSrvcRequstVOList = this.srvcRequstService.srvcRqRejectList(map);

		model.addAttribute("vSrvcRequstVOList", vSrvcRequstVOList);
		log.info("srvcRqList -> vSrvcRequstVOList : " + vSrvcRequstVOList);

		return "srvcRq/mySrvcRqRejectList";
	};

	// 검색 목록 출력
	@PostMapping("/searchRqList")
	@ResponseBody
	public ArticlePage<V_SrvcRequstVO> searchRqList(@RequestBody(required = false) Map<String, Object> map,
			HttpServletRequest request) {

		userId = userIdChk(request);
		map.put("userId", userId);

		log.info("사이즈 map : " + map.toString());

		int size = (Integer.parseInt(map.get("size").toString()));
		map.put("size", size);

		List<V_SrvcRequstVO> vSrvcRequstVOList = this.srvcRequstService.srvcRqList(map);

		int total = this.srvcRequstService.getTotal(map);
		log.info("[srvcRequstController] total : " + total);

		String currentPage = map.get("currentPage").toString();
		String keyword = map.get("keyword").toString();

		ArticlePage<V_SrvcRequstVO> data = new ArticlePage<V_SrvcRequstVO>(total, Integer.parseInt(currentPage), size,
				vSrvcRequstVOList, keyword);

		String url = "/srvcRequst/searchRqList";
		data.setUrl(url);

		log.info("페이징 처리 : " + data);
		return data;
	}

	@PostMapping("/srvcRqNoAnswerList")
	@ResponseBody
	public ArticlePage<V_SrvcRequstVO> srvcRqNoAnswerList(@RequestBody(required = false) Map<String, Object> map,
			HttpServletRequest request) {

		userId = userIdChk(request);
		map.put("userId", userId);

		int size = (Integer.parseInt(map.get("size").toString()));
		map.put("size", size);

		List<V_SrvcRequstVO> vSrvcRequstVOList = this.srvcRequstService.srvcRqNoAnswerList(map);

		int total = this.srvcRequstService.getNoAnswerTotal(map);
		log.info("[srvcRequstController] total : " + total);

		String currentPage = map.get("currentPage").toString();
		String keyword = map.get("keyword").toString();

		ArticlePage<V_SrvcRequstVO> data = new ArticlePage<V_SrvcRequstVO>(total, Integer.parseInt(currentPage), size,
				vSrvcRequstVOList, keyword);

		String url = "/srvcRequst/srvcRqNoAnswerList";
		data.setUrl(url);

		log.info("페이징 처리 : " + data);
		return data;
	}

	@PostMapping("/srvcRqSuccessList")
	@ResponseBody
	public ArticlePage<V_SrvcRequstVO> srvcRqSuccessList(@RequestBody(required = false) Map<String, Object> map,
			HttpServletRequest request) {

		userId = userIdChk(request);
		map.put("userId", userId);

		int size = (Integer.parseInt(map.get("size").toString()));
		map.put("size", size);

		List<V_SrvcRequstVO> vSrvcRequstVOList = this.srvcRequstService.srvcRqSuccessList(map);
		int total = this.srvcRequstService.getSuccessTotal(map);

		log.info("[srvcRequstController] total : " + total);

		String currentPage = map.get("currentPage").toString();
		String keyword = map.get("keyword").toString();

		ArticlePage<V_SrvcRequstVO> data = new ArticlePage<V_SrvcRequstVO>(total, Integer.parseInt(currentPage), size,
				vSrvcRequstVOList, keyword);

		String url = "/srvcRequst/srvcRqSuccessList";
		data.setUrl(url);

		log.info("페이징 처리 : " + data);
		return data;
	}

	@PostMapping("/srvcRqRejectList")
	@ResponseBody
	public ArticlePage<V_SrvcRequstVO> srvcRqRejectList(@RequestBody(required = false) Map<String, Object> map,
			HttpServletRequest request) {

		userId = userIdChk(request);
		map.put("userId", userId);

		int size = (Integer.parseInt(map.get("size").toString()));
		map.put("size", size);

		List<V_SrvcRequstVO> vSrvcRequstVOList = this.srvcRequstService.srvcRqRejectList(map);

		int total = this.srvcRequstService.getRejectTotal(map);
		log.info("[srvcRequstController] total : " + total);

		String currentPage = map.get("currentPage").toString();
		String keyword = map.get("keyword").toString();

		ArticlePage<V_SrvcRequstVO> data = new ArticlePage<V_SrvcRequstVO>(total, Integer.parseInt(currentPage), size,
				vSrvcRequstVOList, keyword);

		String url = "/srvcRequst/srvcRqRejectList";
		data.setUrl(url);

		log.info("페이징 처리 : " + data);
		return data;
	}
	
	// 검색 목록 출력
		@PostMapping("/mySearchRqList")
		@ResponseBody
		public ArticlePage<V_SrvcRequstVO> mySearchRqList(@RequestBody(required = false) Map<String, Object> map,
				HttpServletRequest request) {

			userId = userIdChk(request);
			map.put("userId", userId);

			log.info("사이즈 map : " + map.toString());

			int size = (Integer.parseInt(map.get("size").toString()));
			map.put("size", size);

			List<V_SrvcRequstVO> vSrvcRequstVOList = this.srvcRequstService.srvcRqList(map);

			int total = this.srvcRequstService.getTotal(map);
			log.info("[srvcRequstController] total : " + total);

			String currentPage = map.get("currentPage").toString();
			String keyword = map.get("keyword").toString();

			ArticlePage<V_SrvcRequstVO> data = new ArticlePage<V_SrvcRequstVO>(total, Integer.parseInt(currentPage), size,
					vSrvcRequstVOList, keyword);

			String url = "/srvcRequst/mySearchRqList";
			data.setUrl(url);

			log.info("페이징 처리 : " + data);
			return data;
		}

		@PostMapping("/mySrvcRqNoAnswerList")
		@ResponseBody
		public ArticlePage<V_SrvcRequstVO> mySrvcRqNoAnswerList(@RequestBody(required = false) Map<String, Object> map,
				HttpServletRequest request) {

			userId = userIdChk(request);
			map.put("userId", userId);

			int size = (Integer.parseInt(map.get("size").toString()));
			map.put("size", size);

			List<V_SrvcRequstVO> vSrvcRequstVOList = this.srvcRequstService.srvcRqNoAnswerList(map);

			int total = this.srvcRequstService.getNoAnswerTotal(map);
			log.info("[srvcRequstController] total : " + total);

			String currentPage = map.get("currentPage").toString();
			String keyword = map.get("keyword").toString();

			ArticlePage<V_SrvcRequstVO> data = new ArticlePage<V_SrvcRequstVO>(total, Integer.parseInt(currentPage), size,
					vSrvcRequstVOList, keyword);

			String url = "/srvcRequst/mySrvcRqNoAnswerList";
			data.setUrl(url);

			log.info("페이징 처리 : " + data);
			return data;
		}

		@PostMapping("/mySrvcRqSuccessList")
		@ResponseBody
		public ArticlePage<V_SrvcRequstVO> mySrvcRqSuccessList(@RequestBody(required = false) Map<String, Object> map,
				HttpServletRequest request) {

			userId = userIdChk(request);
			map.put("userId", userId);

			int size = (Integer.parseInt(map.get("size").toString()));
			map.put("size", size);

			List<V_SrvcRequstVO> vSrvcRequstVOList = this.srvcRequstService.srvcRqSuccessList(map);
			int total = this.srvcRequstService.getSuccessTotal(map);

			log.info("[srvcRequstController] total : " + total);

			String currentPage = map.get("currentPage").toString();
			String keyword = map.get("keyword").toString();

			ArticlePage<V_SrvcRequstVO> data = new ArticlePage<V_SrvcRequstVO>(total, Integer.parseInt(currentPage), size,
					vSrvcRequstVOList, keyword);

			String url = "/srvcRequst/srvcRqSuccessList";
			data.setUrl(url);

			log.info("페이징 처리 : " + data);
			return data;
		}

		@PostMapping("/mySrvcRqRejectList")
		@ResponseBody
		public ArticlePage<V_SrvcRequstVO> mySrvcRqRejectList(@RequestBody(required = false) Map<String, Object> map,
				HttpServletRequest request) {

			userId = userIdChk(request);
			map.put("userId", userId);

			int size = (Integer.parseInt(map.get("size").toString()));
			map.put("size", size);

			List<V_SrvcRequstVO> vSrvcRequstVOList = this.srvcRequstService.srvcRqRejectList(map);

			int total = this.srvcRequstService.getRejectTotal(map);
			log.info("[srvcRequstController] total : " + total);

			String currentPage = map.get("currentPage").toString();
			String keyword = map.get("keyword").toString();

			ArticlePage<V_SrvcRequstVO> data = new ArticlePage<V_SrvcRequstVO>(total, Integer.parseInt(currentPage), size,
					vSrvcRequstVOList, keyword);

			String url = "/srvcRequst/mySrvcRqRejectList";
			data.setUrl(url);

			log.info("페이징 처리 : " + data);
			return data;
		}

	@GetMapping("/srvcRqDetail")
	public String srvcRqDetail(@RequestParam("srvcRequstNo") int srvcRequstNo, Model model) {

		vSrvcRequstVO.setSrvcRequstNo(srvcRequstNo);
		vSrvcRequstVO = this.srvcRequstService.srvcRqDetail(vSrvcRequstVO, userId);

		int sprviseAtchmnflNo = vSrvcRequstVO.getSprviseAtchmnflNo();
		List<SprviseAtchmnflVO> sprviseAtchmnflVOList = this.fileuploadService.getsprviseAtchmnfl(sprviseAtchmnflNo);

		model.addAttribute("vSrvcRequstVO", vSrvcRequstVO);

		return "srvcRq/srvcRqDetail";
	}

	// url:"/srvcRequst/processFn?srvcRequstNo="+srvcRequstNo
	@PostMapping("/processFn")
	@ResponseBody
	public Map<String, Object> processFn(@RequestParam int srvcRequstNo) {

		int res = 0;
		res = this.srvcRequstService.processFn(srvcRequstNo, userId);

		vSrvcRequstVO.setSrvcRequstNo(srvcRequstNo);
		vSrvcRequstVO = this.srvcRequstService.srvcRqDetail(vSrvcRequstVO, userId);

		Map<String, Object> processMap = new HashMap<String, Object>();
		log.info("[srvcRequstController] processFn -> vSrvcRequstVO " + vSrvcRequstVO);

		processMap.put("res", res);
		processMap.put("vSrvcRequstVO", vSrvcRequstVO);

		return processMap;
	}

	@PostMapping("/acceptRequst")
	public String acceptRequst(@RequestParam("srvcRequstNo") int srvcRequstNo) {
		int res = 0;

		Map<String, Object> acceptMap = new HashMap<String, Object>();
		acceptMap.put("srvcRequstNo", srvcRequstNo);

		res = this.srvcRequstService.acceptRequst(acceptMap, userId);

		return "redirect:/srvcRequst/srvcRqDetail?srvcRequstNo=" + srvcRequstNo;
	}

	@PostMapping("/rejectRequst")
	public String rejectRequst(@RequestParam("srvcRequstItyy") String srvcRequstItyy,
			@RequestParam("rejectSrvcRequstNo") String srvcRequstNo,
			@RequestParam("srvcRequstItyyInput") String srvcRequstItyyInput) {
		int res = 0;
		log.info("rejectRequst -> srvcRequstItyy : " + srvcRequstItyy);
		log.info("rejectRequst -> srvcRequstNo : " + srvcRequstNo);
		log.info("rejectRequst -> srvcRequstItyyInput : " + srvcRequstItyyInput);

		Map<String, Object> rejectMap = new HashMap<String, Object>();
		rejectMap.put("srvcRequstNo", srvcRequstNo);
		rejectMap.put("srvcRequstItyy", srvcRequstItyy);

		if (srvcRequstItyy.equals("기타")) {
			rejectMap.put("srvcRequstItyy", srvcRequstItyyInput);
		}

		log.info("거절 내용 : " + rejectMap.get("srvcRequstItyy"));

		res = this.srvcRequstService.rejectRequst(rejectMap, userId);

		return "redirect:/srvcRequst/srvcRqDetail?srvcRequstNo=" + srvcRequstNo;
	}

	@GetMapping("/srvcRqCreate")
	public String srvcRqCreate(String proId, Model model) {

		ProProflVO proProflVO = this.proProflService.detail(proId);

		model.addAttribute("proProflVO", proProflVO);

		return "srvcRq/srvcRqCreate";
	}

	@PostMapping("/srvcRqCreatePost")
	public String srvcRqCreatePost(@RequestParam("srvcRequstSj") String srvcRequstSj,
			@RequestParam("srvcRequstCn") String srvcRequstCn, @RequestParam("proId") String proId,
			@RequestParam("uploadFiles") List<MultipartFile> uploadFiles, HttpServletRequest request) {
		userId = userIdChk(request);
		log.info("srvcRqCreatePost -> srvcRequstSj : " + srvcRequstSj);
		log.info("srvcRqCreatePost -> srvcRequstCn : " + srvcRequstCn);
		log.info("srvcRqCreatePost -> proId : " + proId);

		SrvcRequstVO srvcRequstVO = new SrvcRequstVO();
		srvcRequstVO.setSrvcRequstSj(srvcRequstSj);
		srvcRequstVO.setSrvcRequstCn(srvcRequstCn);
		srvcRequstVO.setProId(proId);
		srvcRequstVO.setMberId(userId);

		log.info("[srvcRequstController] srvcRqCreatePost -> uploadFiles : " + uploadFiles.toString());

		int res = 0;

		res = this.srvcRequstService.srvcRqCreatePost(srvcRequstVO, uploadFiles);

		return "redirect:/srvcRequst/srvcRqList?mberCheck=mber";
	}

	@PostMapping("/srvcRqUpdatePost")
	public String srvcRqUpdatePost(@RequestParam Map<String, Object> srvcRqUpdateMap,
			@RequestParam("uploadFiles") List<MultipartFile> uploadFiles, HttpServletRequest request) {
		int res = 0;

		userId = userIdChk(request);

		res = this.srvcRequstService.srvcRqUpdatePost(srvcRqUpdateMap, uploadFiles, userId);

		return "redirect:/srvcRequst/srvcRqDetail?srvcRequstNo=" + srvcRqUpdateMap.get("srvcRequstNo");

	}

}