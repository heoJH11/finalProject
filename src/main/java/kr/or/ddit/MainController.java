package kr.or.ddit;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.fasterxml.jackson.core.JsonProcessingException;

import kr.or.ddit.board.pro_story.service.ProStoryService;
import kr.or.ddit.board.pro_story.vo.ProStoryBbscttVO;
import kr.or.ddit.manage.service.ManageService;
import kr.or.ddit.onedayclass.service.OnedayClassService;
import kr.or.ddit.pro.proProfl.service.ProProflService;
import kr.or.ddit.pro.proSearch.service.SearchProService;
import kr.or.ddit.vo.BcityVO;
import kr.or.ddit.vo.DongChartVO;
import kr.or.ddit.vo.DongChartVO2;
import kr.or.ddit.vo.DongChartVO3;
import kr.or.ddit.vo.OndyclVO;
import kr.or.ddit.vo.ProVO;
import kr.or.ddit.vo.SpcltyRealmVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class MainController {
	
	@Autowired
	ManageService manageService;
	
	@Autowired
	ProStoryService proStoryService;
	
	@Autowired
	SearchProService searchProService;
	
	@Autowired
	ProProflService proProflService;
	
	@Autowired
	OnedayClassService onedayClassService;
	
	@GetMapping("/main")
	public String main(Model model) throws JsonProcessingException {
		
		DongChartVO2 dongVO2 = this.manageService.test2();
		log.info("dongVO2 : " + dongVO2);
		
		DongChartVO3 dongVO3 = this.manageService.test3();
		log.info("dongVO3 : " + dongVO3);
		
		model.addAttribute("dongVO2",dongVO2);
		model.addAttribute("dongVO3",dongVO3);
		
		
		Map<String,Object> map = new HashMap<String, Object>();
		List<BcityVO> bcityVOList = this.proProflService.list(map);
		List<SpcltyRealmVO> spcltyBList = this.searchProService.spcltyB();
		List<ProVO> monthProList = this.searchProService.getMonthPro(map);
		List<OndyclVO> ondyclVOList = this.onedayClassService.getOndyclRank();
		ProVO proVO = monthProList.get(0); // 리스트의 첫 번째 요소를 가져옴
		String proId = proVO.getProId();
	
		int srvcCount = this.proProflService.getSrvcCount(proId);
		int revCount = this.proProflService.getRevCount(proId);
		int bkmkCount = this.proProflService.getBkmkCount(proId);
		
		/* 프로이야기 추천수 기준 가져오기 새로 추가 */
		List<ProStoryBbscttVO> getRecommendList = this.proStoryService.getWeekRecommend();
		/* 프로이야기 추천수 기준 가져오기 새로 추가*/

		log.info("main->bcityVOList" + bcityVOList);
		log.info("main->spcltyBList" + spcltyBList);
		log.info("main->monthProList" + monthProList);
		log.info("main->getRecommendList" + getRecommendList);
		
		model.addAttribute("ondyclVOList",ondyclVOList);
		model.addAttribute("bcityVOList",bcityVOList);
		model.addAttribute("spcltyBList",spcltyBList);
		model.addAttribute("monthProList",monthProList);
		model.addAttribute("srvcCount",srvcCount);
		model.addAttribute("revCount",revCount);
		model.addAttribute("bkmkCount",bkmkCount);
		model.addAttribute("getRecommendList",getRecommendList);
		
		return "main";
	}
	

	
}
