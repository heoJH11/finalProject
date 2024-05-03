package kr.or.ddit.admin.usersSearch.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.admin.usersSearch.service.UsersSearchService;
import kr.or.ddit.admin.usersSearch.vo.UsersVO;
//import kr.or.ddit.util.ArticlePage;
import kr.or.ddit.util.ArticlePage2;
import lombok.extern.slf4j.Slf4j;


@Slf4j
@RequestMapping("/usersSearch")
@Controller
public class UsersSearchController {

	@Autowired 
	UsersSearchService usersSearchService;
	
	@GetMapping("/list")
	public String list(Model model,Map<String,Object>map,
			@RequestParam(value="currentPage", required=false, defaultValue="1")int currentPage,
			@RequestParam(value="keyword", required=false, defaultValue="1") String keyword,
			@RequestParam(value="searchKey", required=false,defaultValue="") String searchKey) {
		
		if(map!=null) {
			keyword = (String)map.get("keyword");
			searchKey = (String)map.get("searchKey");
			
			if(map.get("currentPage")==null) {
				map.put("currentPage",currentPage);
			}
		}else {
			map = new HashMap<String,Object>();
			map.put("keyword","");
			map.put("searchKey","");
			map.put("currentPage",1);
		}
		map.put("currentPage",currentPage);
		
		int total = this.usersSearchService.getTotal(map);
		log.info("list->total:"+total);//44
		int size = 10;
		
		List<UsersVO> usersVOList = this.usersSearchService.list(map);
		/*
		UsersVO(rnum=1, userId=테프로, userNm=홍길동, userPassword=123456, emplyrTy=ET02, secsnAt=1), 
		UsersVO(rnum=2, userId=테스트아이디2, userNm=홍길동2, userPassword=123456, emplyrTy=ET01, secsnAt=1), 
		UsersVO(rnum=3, userId=테스트아이디1, userNm=홍길동1, userPassword=123456, emplyrTy=ET01, secsnAt=1), 
		UsersVO(rnum=4, userId=테스트아이디, userNm=홍길동, userPassword=123456, emplyrTy=ET01, secsnAt=1), 
		UsersVO(rnum=5, userId=zzzzzz22, userNm=테스트용, userPassword=asdasd, emplyrTy=ET01, secsnAt=1)...]
		 */
		log.info("list->usersVOList:"+usersVOList);
		log.info("list->map:"+map);
		
		model.addAttribute("data",new ArticlePage2<UsersVO>(total
				,currentPage, size, usersVOList, keyword, "rightList", searchKey));
		
		return "usersSearch/list";
	}
	
	@ResponseBody
	@PostMapping("/listAjax")
	public ArticlePage2<UsersVO>listAjax(@RequestBody(required=false)Map<String,Object> map) throws ParseException {
		
		log.info("listAjax->map:"+map);
		
		String keyword = map.get("keyword").toString();
		String searchKey = map.get("searchKey").toString();
		int currentPage = Integer.parseInt(map.get("currentPage").toString());
		
		int total = this.usersSearchService.getTotal(map);
		log.info("listAjax->total"+total);
		
		int size = 10;
		
		List<UsersVO> usersVOList = this.usersSearchService.list(map);
		
		ArticlePage2<UsersVO> data = new ArticlePage2<UsersVO>(total
				,currentPage, size, usersVOList, keyword, "rightList", searchKey);
		
		String url = "/usersSearch/list";
		
		data.setUrl(url);
		
		return data;
	}
	
	@GetMapping("/detail")
	public String usersDetail(@RequestParam String userId, Model model) {
		log.info("detail->usersDetail:"+userId);
		
		UsersVO usersVO = this.usersSearchService.detail(userId);
		log.info("detail->usersVO:"+usersVO);
		
		model.addAttribute("usersVO", usersVO);
		
		return "usersSearch/detail";
	}
	
}
