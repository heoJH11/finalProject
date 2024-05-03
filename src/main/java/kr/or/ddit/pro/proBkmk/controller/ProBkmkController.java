package kr.or.ddit.pro.proBkmk.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.pro.proBkmk.service.ProBkmkService;
import kr.or.ddit.pro.proProfl.service.ProProflService;
import kr.or.ddit.vo.MberVO;
import kr.or.ddit.vo.ProBkmkVO;
import kr.or.ddit.vo.ProVO;
import lombok.extern.slf4j.Slf4j;

@RequestMapping("/proBkmk")
@Slf4j
@Controller
public class ProBkmkController {
	
	@Autowired
	ProBkmkService proBkmkService;
	
	@Autowired
	ProProflService proProflService;
	
	@GetMapping("/detail")
	public String detail(Model model, @ModelAttribute("mberVO") MberVO mberVO,HttpSession session) {
		 if (session.getAttribute("memSession") == null) {
		        // 로그인되어 있지 않은 경우 로그인 페이지로 리다이렉트 또는 다른 처리를 수행
		        return "redirect:/member/memberLogin";
		    } else {
		Map<String,Object> map = new HashMap<String, Object>();
		String memId = ((HashMap)(session.getAttribute("memSession"))).get("userId").toString();
		log.info("detail->memId : " +memId);
		
		List<ProBkmkVO> proBkmkVOList = this.proBkmkService.getFavInfo(memId);
		log.info("detail->proBkmkVO : " + proBkmkVOList);
		
		List<String> spcltyRealmCodeList = new ArrayList<>();
		for (ProBkmkVO proBkmkVO : proBkmkVOList) {
		    List<ProVO> bkmkVOList = proBkmkVO.getBkmkVOList();
		    for (ProVO bkmkVO : bkmkVOList) {
		        String spcltyRealmCode = bkmkVO.getSpcltyRealmCode();
		        String proBun = this.proProflService.getBunryu(spcltyRealmCode);
		        spcltyRealmCodeList.add(proBun);
		    }
		}
		log.info("detail->spcltyRealmCodeList : " + spcltyRealmCodeList);
		
		model.addAttribute("proBkmkVO", proBkmkVOList);
		model.addAttribute("spcltyCL",  spcltyRealmCodeList);
		return "proBkmk/detail";
	}
}

   @ResponseBody
   @PostMapping("/proBkmkCreate")
   public int proBkmkCreate(@RequestParam("proId") String proId, @RequestParam("mberId") String mberId) {
	   log.info("proBkmkCreate->proId : " + proId + ",proBkmkCreate->mberId : " + mberId);
	   int result = this.proBkmkService.proBkmkCreate(proId,mberId);
	   log.info("proBkmkCreate->result : " + result);
	   return result;
   }
   
   @ResponseBody
   @GetMapping("/proBkmkCheck")
   public String proBkmkCheck(@RequestParam("proId") String proId, @RequestParam("mberId") String mberId) {
	   log.info("proBkmkCheck->proId : " + proId + ",proBkmkCheck->mberId : " + mberId);
	   String proBkmkNo = this.proBkmkService.proBkmkCheck(proId,mberId);
	   log.info("proBkmkCheck->proBkmkNo : " + proBkmkNo);
	   return proBkmkNo;
   }
   
   @ResponseBody
   @PostMapping("/proBkmkDelete")
   public int proBkmkDelete(@RequestParam("proId") String proId, @RequestParam("mberId") String mberId) {
	   log.info("proBkmkDelete->proId : " + proId + ",proBkmkDelete->mberId : " + mberId);
	   int result = this.proBkmkService.proBkmkDelete(proId,mberId);
	   log.info("proBkmkDelete->result : " + result);
	   return result;
   }
	   
	   
}
