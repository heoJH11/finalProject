package kr.or.ddit.admin.decl.controller;

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

import kr.or.ddit.admin.decl.service.DeclService;
import kr.or.ddit.vo.LbrtyBbscttVO2;
import kr.or.ddit.vo.PunshVO;
import kr.or.ddit.vo.SntncDeclVO;
import kr.or.ddit.vo.UserDeclVO;
import kr.or.ddit.vo.UsersVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/decl")
@Controller
public class DeclController {
	@Autowired
	DeclService declService;
	
	//페이징 처리
	@GetMapping("/userdecl")
	public String userdecl(Model model, Map<String,Object> map, HttpServletRequest request,
			@RequestParam(value="currentPage",required=false,defaultValue="1") int currentPage) {
		
		map.put("currentPage", currentPage);
		List<SntncDeclVO> lbrbbsList = this.declService.decllbrSelect(map);
		log.info("lbrbbs-> lbrbbsList : " + lbrbbsList);
		model.addAttribute("lbrbbsList",lbrbbsList);
		
		return "decl/userdecl";
	}
	
	@GetMapping("/lbrbbs")
	public String lbrbbs(Model model, Map<String,Object> map, HttpServletRequest request,
			@RequestParam(value="currentPage",required=false,defaultValue="1") int currentPage) {
		
		map.put("currentPage", currentPage);
		List<SntncDeclVO> lbrbbsList = this.declService.decllbrSelect(map);
		log.info("lbrbbs-> lbrbbsList : " + lbrbbsList);
		model.addAttribute("lbrbbsList",lbrbbsList);
		
		return "decl/lbrbbs";
	}
	
	@ResponseBody
	@PostMapping("/ajaxList")
	public List<SntncDeclVO> ajaxList(Map<String,Object> map) {
		
		List<SntncDeclVO> lbrbbsList = this.declService.decllbrSelect(map);
		log.info("lbrbbs-> lbrbbsList : " + lbrbbsList);
		
		return lbrbbsList;
	}
	
	@ResponseBody
	@PostMapping("/selectList")
	public LbrtyBbscttVO2 selectList(@RequestBody SntncDeclVO sntncDeclVO) {
		log.info("selectList-> sntncDeclVO : " + sntncDeclVO);
		
		LbrtyBbscttVO2 selectVo = this.declService.lbrtyBbscttVo(sntncDeclVO);
		log.info("selectList-> selectList : " + selectVo);
		
		return selectVo;
	}
	
	@ResponseBody
	@PostMapping("/declResnList")
	public List<SntncDeclVO> declResnList(@RequestBody SntncDeclVO sntncDeclVO) {
		log.info("declResnList-> sntncDeclVO : " + sntncDeclVO);
		
		List<SntncDeclVO> declResnList = this.declService.declResnList(sntncDeclVO);
		log.info("declResnList-> declResnList : " + declResnList);
		
		return declResnList;
	}
	
	@ResponseBody
	@GetMapping("/declSet")
	public int declSet(int lbrtyBbscttNo) {
		log.info("declSet-> lbrtyBbscttNo : " + lbrtyBbscttNo);
		
		int result = 0;
		result = this.declService.declSet(lbrtyBbscttNo);
		log.info("declSet-> result : " + result);
		
		return result;
	}
	
	
	@ResponseBody
	@GetMapping("/userList")
	public List<UsersVO> userList() {
		
		List<UsersVO> userList = this.declService.userList();
		log.info("userIist-> userList : " + userList);
		
		return userList;
	}
	
	@ResponseBody
	@PostMapping("/getDeclCount")
	public int getDeclCount(String userId2) {
		log.info("userId2 : " + userId2);
		int count = 0;
		count = this.declService.getDeclCount(userId2);
		if(count==0) {
			return 0;
		}
		
		log.info("getDeclCount-> count : " + count);
		
		return count;
	}
	
	@ResponseBody
	@PostMapping("/userDeclList")
	public List<UserDeclVO> userDeclList(String userId) {
		log.info("userId : " + userId);
		List<UserDeclVO> userDeclList = this.declService.userDeclList(userId);
		log.info("userDeclList-> userDeclList : " + userDeclList);
		
		return userDeclList;
	}
	
	@ResponseBody
	@PostMapping("/userDeclSet")
	public int userDeclSet(@RequestBody Map<String, Object> map) {
		log.info("userDeclSet -> map : " + map);
		int result = 0;
		result = this.declService.userDeclSet(map);
		log.info("userDeclSet-> result : " + result);
		
		return result;
	}
	
	@ResponseBody
	@PostMapping("/declHistoryList")
	public List<PunshVO> declHistoryList(String userId) {
		log.info("declHistoryList -> userId : " + userId);
		List<PunshVO> hisoryList = null;
		hisoryList = this.declService.declHistoryList(userId);
		log.info("declHistoryList-> hisoryList : " + hisoryList);
		
		return hisoryList;
	}
	
	// 검색 목록 출력
	/*
	 * @ResponseBody
	 * 
	 * @PostMapping("/ajaxLbList") public ArticlePage<LbrtyBbscttVO2>
	 * ajaxLbList(@RequestBody(required = false) Map<String, Object> map,
	 * HttpServletRequest request) { log.info("ajaxLbList -> map : " + map);
	 * 
	 * // map : {"keyword : "","currentPage":1}
	 * 
	 * List<LbrtyBbscttVO2> ajaxLbList =
	 * this.lbrtyBbscttService.lbrtyBbscttListPage(map);
	 * log.info("ajaxLbList -> ajaxLbList : " + ajaxLbList);
	 * 
	 * int total = this.lbrtyBbscttService.getTotal(map);
	 * log.info("ajaxLbList -> total : " + total);
	 * 
	 * int size = 10;
	 * 
	 * String currentPage = map.get("currentPage").toString(); String keyword =
	 * map.get("keyword").toString(); log.info("ajaxLbList -> currentPage : " +
	 * total); log.info("ajaxLbList -> keyword : " + total);
	 * 
	 * ArticlePage<LbrtyBbscttVO2> data = new ArticlePage<LbrtyBbscttVO2>(total,
	 * Integer.parseInt(currentPage), size, ajaxLbList, keyword);
	 * 
	 * String url = "/decl/lbrbbs"; data.setUrl(url);
	 * 
	 * return data;
	 * 
	 * }
	 */
}
