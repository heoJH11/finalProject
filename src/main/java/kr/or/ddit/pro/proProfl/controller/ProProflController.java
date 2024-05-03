package kr.or.ddit.pro.proProfl.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.pro.proProfl.service.ProProflService;
import kr.or.ddit.util.ArticlePage;
import kr.or.ddit.util.ArticlePage5;
import kr.or.ddit.vo.BcityVO;
import kr.or.ddit.vo.CommonCdDetailVO;
import kr.or.ddit.vo.ProProflVO;
import kr.or.ddit.vo.ReviewVO;
import kr.or.ddit.vo.SprviseAtchmnflVO;
import kr.or.ddit.vo.UserDeclVO;
import kr.or.ddit.vo.VCityVO;
import kr.or.ddit.vo.VProUsersVO;
import kr.or.ddit.vo.VPrtfolioVO;
import lombok.extern.slf4j.Slf4j;

@RequestMapping("/proProfl")
@Slf4j
@Controller
public class ProProflController {
   
   @Autowired   
   ProProflService proProflService;
   
   @GetMapping("/create")
   public String create(Model model, @ModelAttribute("proProflVO") ProProflVO proProflVO,HttpSession session) {
      
      Map<String,Object> map = new HashMap<String, Object>();
      List<BcityVO> bcityVOList = this.proProflService.list(map);
      
      String proId = ((HashMap) (session.getAttribute("proSession"))).get("userId").toString();
      log.info("create->proId : " + proId);
	  VProUsersVO vProUsersVO = this.proProflService.getProInfo(proId);
	  log.info("create->vProUsersVO : " + vProUsersVO);
	   
	  String spcltyRealmCode = vProUsersVO.getSpcltyRealmCode();
	  String proBun = this.proProflService.getBunryu(spcltyRealmCode);
	  log.info("create->proBun : " + proBun);
      
      model.addAttribute("bcityVOList",bcityVOList);
      model.addAttribute("vProUsersVO", vProUsersVO);
	  model.addAttribute("proBun",proBun);
      
      return "proProfl/create";
   }
   
   @GetMapping("/brtcList")
   @ResponseBody
   public List<VCityVO> getBrtcList(@RequestParam("bcityNm") String bcityNm){
	   List<VCityVO> brtcList = this.proProflService.getBrtcList(bcityNm);
	   return brtcList;
   }
   
   @GetMapping("/getProId")
   @ResponseBody
   public ProProflVO getProId(@RequestParam("sessionId") String sessionId) {
		/* log.info("sessionId : " + sessionId); */
	   ProProflVO proProflVO = proProflService.getProId(sessionId);
	   return proProflVO;
   }
   
   @PostMapping("/createPost")
   public String createPost(@RequestParam("bcityNm") String bcityNm,
						    @RequestParam("brtcNm") String brtcNm,
						    Model model,
						    ProProflVO proProflVO) {
	   String bcityCode = this.proProflService.bcCode(bcityNm);
	   String brtcCode = this.proProflService.btCode(bcityNm,brtcNm);
	   
	// proProflVO 객체에 bcCode와 brtcCode 값을 설정
	   proProflVO.setBcityCode(bcityCode);
	   proProflVO.setBrtcCode(brtcCode);
	   /*
	   ProProflVO(proId=protest100, proProflOnLiIntrcn=안녕하세요~, proProflContactPosblTime=9:00~13:00
	   , proProflReqForm=메, proProflHist=메, bcityCode=25, brtcCode=25020)
	    */
	   log.info("createPost->proProflVO : " + proProflVO);
	  
       int result = this.proProflService.createPost(proProflVO);
       log.info("createPost->result : " + result);
      
       return "redirect:/proProfl/detail?proId="+proProflVO.getProId();
}
   
   
   @GetMapping("/detail")
   public String detail(@RequestParam("proId") String proId, Model model,Map<String,Object> map) {
	   log.info("detail->proId : " + proId);
	   int srvcCount = this.proProflService.getSrvcCount(proId);
	   int revCount = this.proProflService.getRevCount(proId);
	   int bkmkCount = this.proProflService.getBkmkCount(proId);
	   
	   ProProflVO proProflVO = this.proProflService.detail(proId);
	   log.info("detail->proProflVO : " + proProflVO);
	   
	   //ATCHMNFL_NO : 1
	   List<VPrtfolioVO> prtTumbVOList = this.proProflService.prtTumb(proId);
	   log.info("detail->prtTumbVOList : " + prtTumbVOList);
	   
	   
	   VProUsersVO vProUsersVO = this.proProflService.getProInfo(proId);
	   log.info("detail->vProUsersVO : " + vProUsersVO);
	   
	   //동균 신고로 인해 추가
	   List<CommonCdDetailVO> comCdList = this.proProflService.declComCdDeSelect(); 
	   log.info("detail-> comCdList: " + comCdList);
	   model.addAttribute("comCdList", comCdList);
	   //동균 신고로 인해 추가 끝
	   
	   String spcltyRealmCode = vProUsersVO.getSpcltyRealmCode();
	   String proBun = this.proProflService.getBunryu(spcltyRealmCode);
	   log.info("detail->proBun : " + proBun);
	   
	   model.addAttribute("proProflVO", proProflVO);
	   model.addAttribute("VPrtfolioVO", prtTumbVOList);
	   model.addAttribute("vProUsersVO", vProUsersVO);
	   model.addAttribute("proBun",proBun);
	   model.addAttribute("srvcCount",srvcCount);
	   model.addAttribute("revCount",revCount);
	   model.addAttribute("bkmkCount",bkmkCount);
	   
	   return "proProfl/detail";
	   
   }
   
	//리뷰 목록 페이징
	@ResponseBody
	@PostMapping("/reviewPage")
	public ArticlePage5<ReviewVO> reviewPage(Model model,@RequestBody(required=false) Map<String,Object> map, HttpServletRequest request){
		int size = 5;
		map.put("size",size);
		
		log.info("reviewList -> map : " + map);
		
		List<ReviewVO> reviewList = this.proProflService.getReview(map);
		
		log.info("reviewPage -> reviewList : " + reviewList);
		
		int total = this.proProflService.getRevCnt2(map);
		log.info("reviewList -> reviewTotal : " + total);
		
		String currentPage = map.get("currentPage").toString();
		String keyword = "";
		String proId = map.get("proId").toString();
		log.info("reviewPage -> currentPage : " + currentPage);
		log.info("reviewPage -> keyword : " + keyword);
		log.info("reviewPage -> proId : " + proId);
		
		ArticlePage5<ReviewVO> data = new ArticlePage5<ReviewVO>(total, Integer.parseInt(currentPage),size,reviewList,keyword,proId);
		
		String url = "/proProfl/detail";
		data.setUrl(url);
		
		return data;
	}

   
//   //proProfl/portfolioPicture
   @ResponseBody
   @PostMapping("/portfolioPicture")
   public List<SprviseAtchmnflVO>  portfolioPicture(@RequestParam("sprviseAtchmnflNo")String sprviseAtchmnflNo,Model model){
	   log.info("sprviseAtchmnflNo : " + sprviseAtchmnflNo);
	   
	   List<SprviseAtchmnflVO> sprviseAtchmnflVOList = this.proProflService.portfolioPicture(sprviseAtchmnflNo);
	   log.info("sprviseAtchmnflVOList : " + sprviseAtchmnflVOList);
	   
	   return sprviseAtchmnflVOList;
   }
   
   @ResponseBody
   @PostMapping("/getNm")
   public Map<String, String> getNm(@RequestParam("bcityCode") String bcityCode,
		    				  @RequestParam("brtcCode") String brtcCode){
	   Map<String, String> map = new HashMap<>();
	   String bcityNm = this.proProflService.getBcityNm(bcityCode);
	   String brtcNm = this.proProflService.getBrtcNm(brtcCode);
	   log.info("bcityNm : " + bcityNm + ", brtcNm : "+ brtcNm);
	   map.put("bcityNm", bcityNm);
	   map.put("brtcNm", brtcNm);
	   
	   return map;
   }
   
   @GetMapping("/modify")
   public String modify(@RequestParam("proId") String proId,Model model) {
	   ProProflVO proProflVO = this.proProflService.detail(proId);
	   Map<String,Object> map = new HashMap<String, Object>();
	   List<BcityVO> bcityVOList = this.proProflService.list(map);
	      
	   model.addAttribute("bcityVOList",bcityVOList);
	   model.addAttribute("proProflVO", proProflVO);
	   log.info("modify->proProflVO : " + proProflVO);
	   
	   return "proProfl/modify";
   }
   
   @GetMapping("/modifyProfl")
   public String modifyProfl(@RequestParam("bcityNm") String bcityNm,
		    				 @RequestParam("brtcNm") String brtcNm,
		    				 @RequestParam("proId") String proId,Model model,ProProflVO proProflVO) {
	   log.info("modifyProfl->bcityNm : " + bcityNm + ",brtcNm : " + brtcNm);
	   String bcityCode = this.proProflService.bcCode(bcityNm);
	   String brtcCode = this.proProflService.btCode(bcityNm, brtcNm);
	   proProflVO.setBcityCode(bcityCode);
	   proProflVO.setBrtcCode(brtcCode);


	   log.info("modifyProfl->proProflVO : " + proProflVO);
	   
	   int result = this.proProflService.modify(proProflVO);
		model.addAttribute("proProflVO", proProflVO);
		log.info("modifyProfl2->proProflVO : " + proProflVO);
		
		return "redirect:/proProfl/detail?proId="+proProflVO.getProId();
   }
   
   //동균 신고로 인해 추가 
   @ResponseBody
   @PostMapping("/declInsert")
   public int declInsert(@RequestBody UserDeclVO userDeclVO) {
	   int result = 0;
	   
	   log.info("declInsert -> userDeclVO : " + userDeclVO);
	   result = this.proProflService.declInsert(userDeclVO);
	   log.info("declInsert -> result : " + result);
	   
	   
	   return result;
   }
   //동균 신고로 인해 추가 끝
   
}