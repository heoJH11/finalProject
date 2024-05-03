package kr.or.ddit.chatting.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.todaymeeting.service.TodayMeetingService;
import kr.or.ddit.vo.TdmtngVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@SuppressWarnings({ "unused", "unchecked" })
@RequestMapping("/todayChat")
public class TodayChat {
	
	@Inject
	String uploadFolder;
	
	@Inject
	TodayMeetingService todayMeetingSerive;
	
	@GetMapping("/calendar")
	public String cal() {
		return "todayChat/cal/calendar";
	}
	
	@GetMapping("/main")
	public String main() {
		return "todayChat/index";
	}
	@GetMapping("/create")
	public String create() {
		return "todayChat/create";
	}

	private String userId(HttpServletRequest request) {
		//세션값으로 아이디 가져오기
			
			Object proSession = request.getSession().getAttribute("proSession");
			Object memSession = request.getSession().getAttribute("memSession");
			Object admSession = request.getSession().getAttribute("admSession");
			
//				String aa = ((HashMap)(request.getSession().getAttribute("proSession"))).get("userId").toString();
			
			if(proSession !=null && proSession instanceof HashMap) {
				Object userId = ((HashMap<String, Object>)proSession).get("userId");
				System.out.println("proSession"+userId);
				
				return userId != null ? userId.toString() : null;
			}
			if(memSession !=null && memSession instanceof HashMap) {
				Object userId = ((HashMap<String, Object>)memSession).get("userId");
				System.out.println("memSession" +userId);
				
				return userId != null ? userId.toString() : null;

			}
			if(admSession !=null && admSession instanceof HashMap) {
				Object userId = ((HashMap<String, Object>)admSession).get("userId");
				System.out.println("admSession" +userId);
				
				return userId != null ? userId.toString() : null;

			}
			return "not";
		}
	
	@GetMapping("/list")
	public List<TdmtngVO> listchat(HttpServletRequest request){
		
		userId(request);
		
		List<TdmtngVO> chatList = this.todayMeetingSerive.findAll(userId(request));
		System.out.println("list 확인 : " + chatList);
		return chatList;
		
	}
	
	@ResponseBody
	@PostMapping("/listAjax")
	public List<TdmtngVO> listAjax(@RequestBody(required=false) Map<String,Object> map) {
	
		
		log.info("map : " + map);
	
		List<TdmtngVO> tdmtngVOList = this.todayMeetingSerive.list(map);
		log.info("list->tdmtngVOList : " + tdmtngVOList);
		
		return tdmtngVOList;
	}


	// 내 이벤트 조회
	@GetMapping("/calendarList")
	@ResponseBody
	public List<Map<String, Object>> showAllEventInUpdate() throws Exception{
		
		JSONObject jsonObj = new JSONObject();
		JSONArray jsonArr = new JSONArray();
		
		HashMap<String, Object> hash = new HashMap<>();
		String userId = "a002";
		List<TdmtngVO> list = todayMeetingSerive.findAll(userId);
		
		log.info("calList : " + list);
		
		for(TdmtngVO tdmtngcal : list) {
			hash.put("id", tdmtngcal.getTdmtngNo());
			hash.put("title", tdmtngcal.getTdmtngNm());
			hash.put("start", tdmtngcal.getTdmtngDt());
//			hash.put("todayMeetngCode", schedule.getTodayMeetngCode());
			
			jsonObj = new JSONObject(hash);
			jsonArr.add(jsonObj);
		}
		log.info("jsonArrCheck:{}",jsonArr);
		return jsonArr;
	}
	
	@GetMapping("/detail")
	public String detail(int tdmtngNo
			, Model model) {
		log.info("detail -> tdmtngNo : " + tdmtngNo);
		
		TdmtngVO tdmtngVO = todayMeetingSerive.detail(tdmtngNo);
		
		
		log.info("detail -> tdmtngVO : " + tdmtngVO);

		model.addAttribute("tdmtngVO", tdmtngVO);
		
		return "todayChat/detail";
	}
	
	@PostMapping("/create")
	public String create(TdmtngVO tdmtngVO) {
		log.info("create -> tdmtngVO : " + tdmtngVO);
		
		tdmtngVO.setUserId("a002");
		
		int result = this.todayMeetingSerive.create(tdmtngVO);
		
		log.info("tdmtngVO -> result : " + result);
	
		//redirect : 새로운 URL요청
		return "redirect:/todayChat/detail?tdmtngNo="+tdmtngVO.getTdmtngNo();
	}
	
	@PostMapping("/update")
	public String update(TdmtngVO tdmtngVO) {
		log.info("update -> tdmtngVO : " + tdmtngVO);
		
		int result = this.todayMeetingSerive.update(tdmtngVO);
		
		log.info("tdmtngVO -> result : " + result);
		
		//redirect : 새로운 URL요청
		return "redirect:/todayChat/detail?tdmtngNo="+tdmtngVO.getTdmtngNo();
	}
	
	@GetMapping("/delete")
	public String delete(int tdmtngNo) {
		log.info("delete -> tdmtngno : " + tdmtngNo);
		
		int result = this.todayMeetingSerive.delete(tdmtngNo);
		
		return "todayChat/index";
	}
	
	@PostMapping("/join")
	public String join(int tdmtngNo) {
		
		return "todayChat/join";
	}
	

	
}
