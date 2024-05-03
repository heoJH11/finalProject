package kr.or.ddit.todaymeeting.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.chatting.service.MessageService;
import kr.or.ddit.todaymeeting.VChatRoom;
import kr.or.ddit.todaymeeting.service.TodayMeetingService;
import kr.or.ddit.util.ArticlePage3;
import kr.or.ddit.vo.TdmtngChSpMshgVO;
import kr.or.ddit.vo.TdmtngPrtcpntVO;
import kr.or.ddit.vo.TdmtngVO;
import kr.or.ddit.vo.UsersVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/todayMeeting")
@SuppressWarnings("unchecked")
public class TodayMeetingController {
	
	@Inject
	String uploadFolder;
	
	@Inject
	TodayMeetingService todayMeetingSerive;
	
	@Inject
	MessageService messageService;
	
	
	private String userId(HttpServletRequest request) {
		//세션값으로 아이디 가져오기
		      
		Object proSession = request.getSession().getAttribute("proSession");
		Object memSession = request.getSession().getAttribute("memSession");
		      
		   
		if(proSession !=null && proSession instanceof HashMap) {
			Object userId = ((HashMap<String, Object>)proSession).get("userId");
			System.out.println("proSession : "+userId);
		      
			return userId != null ? userId.toString() : null;
		}
		if(memSession !=null && memSession instanceof HashMap) {
			Object userId = ((HashMap<String, Object>)memSession).get("userId");
			System.out.println("memSession : " +userId);
		      
			return userId != null ? userId.toString() : null;

		}

		return "not";
	}
	
	@GetMapping("/calendar")
	public String cal() {
		return "todayMeeting/cal/calendar";
	}
	
	@GetMapping("/main")
	public String main(HttpServletRequest request, Model model) {
		
		String userId = userId(request);
		
		log.info("main : " + userId);
		
		model.addAttribute("userId", userId);
		
		return "todayMeeting/index";
	}
	
	@GetMapping("/create")
	public String create() {
		return "todayMeeting/create";
	}
	
	@ResponseBody
	@PostMapping("/listAjax")
	public ArticlePage3<TdmtngVO> listAjax(@RequestBody(required=false) Map<String,Object> map) {
	
		log.info("map : " + map);
		
		int size = 10;
		int total = this.todayMeetingSerive.getTotal(map);
		
		log.info("listAjax->total : " + total);
		
		map.put("total", total);
		
		log.info("map : " + map);
		
		List<TdmtngVO> tdmtngVOList = this.todayMeetingSerive.list(map);
		
		log.info("listAjax->tdmtngVOList : " + tdmtngVOList);
			
		String currentPage = map.get("currentPage").toString();	
		
		log.info(currentPage);

		String keyword = map.get("keyword").toString();
		log.info("listAjax->keyword : " + keyword);
		
		String selectColumn = map.get("selectColumn").toString();
		log.info("listAjax->selectColumn : " + selectColumn);

		ArticlePage3<TdmtngVO> data = new ArticlePage3<TdmtngVO>(total,
				Integer.parseInt(currentPage), size, tdmtngVOList, keyword, selectColumn);
		
		log.info("listAjax->data : " + data);
		
		return data;
	}


	// 내 이벤트 조회
	@GetMapping("/calendarList")
	@ResponseBody
	public List<Map<String, Object>> showAllEventInUpdate(String userId) throws Exception{
		
		log.info(userId);
		
		JSONObject jsonObj = new JSONObject();
		JSONArray jsonArr = new JSONArray();
		
		HashMap<String, Object> hash = new HashMap<>();
		List<TdmtngVO> list = todayMeetingSerive.findAll(userId);
		
		log.info("calList : " + list);
		
		for(TdmtngVO tdmtngcal : list) {
			hash.put("id", tdmtngcal.getTdmtngNo());
			hash.put("title", tdmtngcal.getTdmtngNm());
			hash.put("start", tdmtngcal.getTdmtngDt());
			
			jsonObj = new JSONObject(hash);
			jsonArr.add(jsonObj);
		}
		log.info("jsonArrCheck:{}",jsonArr);
		return jsonArr;
	}
	
	@GetMapping("/detail")
	public String detail(HttpServletRequest request, int tdmtngNo
			, Model model) {
		log.info("detail -> tdmtngNo : " + tdmtngNo);
		
		String sessionId = userId(request);
		
		TdmtngVO tdmtngVO = todayMeetingSerive.detail(tdmtngNo);	
		
		log.info("detail -> tdmtngVO : " + tdmtngVO);
		
		int count = this.todayMeetingSerive.chatMemCount(tdmtngNo);
		
		log.info("chatMemCount -> count : " + count);
		
		model.addAttribute("sessionId", sessionId);
		model.addAttribute("tdmtngVO", tdmtngVO);
		model.addAttribute("chatMemCount", count);
		
		return "todayMeeting/detail";
	}
	
	@ResponseBody
	@PostMapping("/create")
	public int create(HttpServletRequest request, TdmtngVO tdmtngVO) {
		
		String userId = userId(request);
		
		tdmtngVO.setUserId(userId);

		log.info("create -> tdmtngVO : " + tdmtngVO);
				
		int result = this.todayMeetingSerive.create(tdmtngVO);
		
		log.info("tdmtngVO -> result : " + result);
		log.info("tdmtngVO -> result : " + tdmtngVO.getTdmtngNo());
		
		return tdmtngVO.getTdmtngNo();
	}

	
	@PostMapping("/update")
	public String update(TdmtngVO tdmtngVO) {
		log.info("update -> tdmtngVO : " + tdmtngVO);
		
		int result = this.todayMeetingSerive.update(tdmtngVO);
		
		log.info("tdmtngVO -> result : " + result);
		
		//redirect : 새로운 URL요청
		return "redirect:/todayMeeting/detail?tdmtngNo="+tdmtngVO.getTdmtngNo();
	}
	
	@GetMapping("/delete")
	public String delete(int tdmtngNo) {
		log.info("delete -> tdmtngno : " + tdmtngNo);
		
		int result = this.todayMeetingSerive.delete(tdmtngNo);
		
		log.info("delete -> result : " + result);
		
		return "todayMeeting/index";
	}
	
	
	//내 채팅 불러오기
	@ResponseBody
	@PostMapping("/selectMyChat")
	public TdmtngPrtcpntVO selectMyChat (@RequestBody TdmtngPrtcpntVO tdmtngPrtcpntVO) {

		
		log.info("selectMyChat -> tdmtngPrtcpntVO : " + tdmtngPrtcpntVO);
		
		tdmtngPrtcpntVO = this.todayMeetingSerive.selectMyChat(tdmtngPrtcpntVO);
		
		log.info("selectMyChat -> tdmtngPrtcpntVO : " + tdmtngPrtcpntVO);
		
		return tdmtngPrtcpntVO;
	}
	
	//채팅 참여(INSERT)
	@ResponseBody
	@PostMapping("/joinChat")
	public int joinChat(HttpServletRequest request, int tdmtngNo, TdmtngPrtcpntVO tdmtngPrtcpntVO) {
		//Unknown return value type: java.lang.Integer 에러 : @ResponseBody를 안 해줘서..
		
		log.info("joinChat -> tdmtngNo : " + tdmtngNo);
		
		String userId = userId(request);
		
		tdmtngPrtcpntVO.setUserId(userId);
		tdmtngPrtcpntVO.setTdmtngNo(tdmtngNo);
		
		log.info("joinChat -> tdmtngPrtcpntVO : " + tdmtngPrtcpntVO);
		
		int result = this.todayMeetingSerive.joinChat(tdmtngPrtcpntVO);
		
		log.info("joinChat -> result : " + result);
		
		return result;
	}
	
	//채팅방 멤버 리스트
	@ResponseBody
	@PostMapping("/chatMemList")
	public List<TdmtngPrtcpntVO> chatMemList(int tdmtngNo) {
		
		log.info("chatMemList -> tdmtngNo : " + tdmtngNo);
		
		List<TdmtngPrtcpntVO> chatMemList = this.todayMeetingSerive.chatMemList(tdmtngNo);
		
		log.info("chatMemList -> chatMemList : " + chatMemList);
		
		return chatMemList;
	}

	@ResponseBody
	@PostMapping("/join")
	public VChatRoom join(@RequestParam("tdmtngNo") int tdmtngNo , HttpServletRequest request , Model model) {
		
		log.info("detail -> tdmtngNo : " + tdmtngNo);
		
		VChatRoom joinRoom = this.todayMeetingSerive.join(tdmtngNo , userId(request));
		
		List<TdmtngPrtcpntVO> chatMemList = this.todayMeetingSerive.chatMemList(tdmtngNo);
		
		for(TdmtngPrtcpntVO test : chatMemList) {
			
			if(joinRoom.getUserId().equals(test.getUserId())){
			
				if(test.getMberProflPhoto() != null) {

					joinRoom.setProflPhoto(test.getMberProflPhoto());
					
				} else {
					
					joinRoom.setProflPhoto(test.getProProflPhoto());
				}
				
			}
		
		}
		
		for(UsersVO userImg : joinRoom.getUserInfo()) {
			    	
			    	for(TdmtngPrtcpntVO bb : chatMemList) {
			    		
			    		if(userImg.getUserId().equals(bb.getUserId())){
			    			
			    			if(bb.getMberProflPhoto() !=null) {
			    				
			    				userImg.setProflPhoto(bb.getMberProflPhoto());
			    				break;
			    			} 
			    			if(bb.getProProflPhoto() != null) {
			    				
			    				userImg.setProflPhoto(bb.getProProflPhoto());
			    				break;
			    			}
			    		}
			    	
			    }
		}
		
		model.addAttribute("joinRoom", joinRoom);
		log.info("detail After -> joinRoom : " + joinRoom);
		return joinRoom;
	}
	
	@ResponseBody
	@PostMapping("/myList")
	public ResponseEntity<List<VChatRoom>> myList(HttpServletRequest request) {
	    
		List<VChatRoom> myList = this.todayMeetingSerive.myList(userId(request));
	    
	    System.out.println("내방 리스트 : " + myList);
	    
	    return ResponseEntity.ok().body(myList);
	}
	@ResponseBody
	@PostMapping("/msgList")
	public Map<String, Object> roomMsg(@RequestParam("tdmtngNo") int tdmtngNo, HttpServletRequest request){
		
	    Map<String, Object> roomInfo = new HashMap<>();

	    VChatRoom joinRoom = this.todayMeetingSerive.join(tdmtngNo , userId(request));
	    
	    List<TdmtngChSpMshgVO> msgList = this.messageService.roomMsgList(tdmtngNo);
	    
	    List<TdmtngPrtcpntVO> chatMemList = this.todayMeetingSerive.chatMemList(tdmtngNo);
	    
	    for(TdmtngChSpMshgVO aa : msgList) {
	    	
	    	for(TdmtngPrtcpntVO bb : chatMemList) {
	    		
	    		if(aa.getUserId().equals(bb.getUserId())){
	    			
	    			if(bb.getMberProflPhoto() !=null) {
	    				
	    				aa.setProflPhoto(bb.getMberProflPhoto());
	    				break;
	    			} 
	    			if(bb.getProProflPhoto() != null) {
	    				
	    				aa.setProflPhoto(bb.getProProflPhoto());
	    				break;
	    			}
	    		}
	    	}
	    	
	    }
	    roomInfo.put("msgList", msgList);
	    roomInfo.put("joinRoom", joinRoom);
	    
	    System.out.println("해당 방 : " + joinRoom);
	    System.out.println("메세지 리스트: " + msgList);
	    return roomInfo;
	}
	
	@ResponseBody
	@PostMapping("/scroll")
	public Map<String, Object> scroll(@RequestParam("tdmtngNo") int tdmtngNo , @RequestParam("startRn") int startRn , HttpServletRequest request){
		
		System.out.println("startRn 체크 (BEFORE): " + startRn);
		Map<String , Object> roomInfo = new HashMap<String, Object>();
		
		VChatRoom joinRoom = this.todayMeetingSerive.join(tdmtngNo , userId(request));
		
		System.out.println("startRn 체크(AFTER) : " + startRn);
		
		if(startRn == 0) {
			System.out.println("tdmtngNo " + tdmtngNo);
			System.out.println("startRn " + startRn);
			startRn = this.messageService.getMsgCount(tdmtngNo);
			//return null;
		} else {
			System.out.println("tdmtngNo " + tdmtngNo);
			System.out.println("startRn " + startRn);
		}
		
		roomInfo.put("tdmtngNo",tdmtngNo );
		roomInfo.put("startRn",startRn );
		log.info("test : " + startRn);
		List<TdmtngChSpMshgVO> list = this.messageService.scrollTest(roomInfo);
		for(TdmtngChSpMshgVO asd : list) {
			log.info("메세지목록 : " + asd);
		}
		roomInfo.put("joinRoom", joinRoom);
		roomInfo.put("msgList" , list);
		return roomInfo;
		
	}

}
