package kr.or.ddit.chatting.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.annotation.PostConstruct;
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
import org.springframework.web.bind.annotation.SessionAttributes;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import kr.or.ddit.chatting.service.ChatService;
import kr.or.ddit.chatting.service.MessageService;
import kr.or.ddit.chatting.vo.AllChatRoomViewVO;
import kr.or.ddit.chatting.vo.ChatRelayVO;
import kr.or.ddit.chatting.vo.ChatRoomVO;
import kr.or.ddit.chatting.vo.MessageVO;
import kr.or.ddit.vo.UsersVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
//@Controller
//@SessionAttributes("memSession")
//@RequestMapping("/chat")
//@SuppressWarnings("rawtypes")
public class ChatController2 {
	
	@Autowired
	public ChatService chatService;
	
	@Autowired
	private MessageService messageService;
	List<ChatRoomVO> allRoomList;
	
	List<AllChatRoomViewVO> myRoomList;
	// 첫 실행시 모든 유저 리스트를 가져옴
	@PostConstruct
	private void init() {
		getUser();
		System.out.println(getUser());
		allRoomList();
	}
	
	@ModelAttribute("memSession")
	public UsersVO getUser() {
		System.out.println("세션테스트");
		System.out.println("세션테스트");
		return new UsersVO();
	}
	
	@GetMapping("/sidebar")
	public String chatFormTest() {
		System.out.println("채팅폼페이지 이동?;");
		return "/chat/kakaotalk_clone-master/index";
	}
	
	@GetMapping("/main")
	public String chatHome(Model model , HttpServletRequest request) {
		List<ChatRoomVO> allRoomList = this.allRoomList;
		HttpSession session = request.getSession();
		String userId = ((HashMap) (session.getAttribute("memSession"))).get("userId").toString();
		
//		List<AllChatRoomViewVO> myRoomList = myRoomList(userId);
		List<ChatRelayVO> myRoomUserId = new ArrayList<ChatRelayVO>();
		
		for (AllChatRoomViewVO room : myRoomList) {
		    myRoomUserId = chatService.myRoomId(room.getRoomNo()); // 방 번호로 참가중인 아이디 조회
		    List<UsersVO> joinUserIdList = new ArrayList<>();
		    for (ChatRelayVO relay : myRoomUserId) {
		        UsersVO userInfo = chatService.joinUserInfo(relay.getUserId()); // 아이디로 유저 정보 조회
		        joinUserIdList.add(userInfo);
		    }
		    room.setUserVO(joinUserIdList); // 방의 유저 리스트에 추가
		}
		System.out.println("xptmxm" + getUser());
		model.addAttribute("myRoomUserId" ,myRoomUserId );
		model.addAttribute("allRoomList" , allRoomList);
		model.addAttribute("myRoomList", myRoomList);
		log.info("main 페이지 이동 성공{}");
		return "chat/chatForm";
	}

	// 모든 채팅방
	private List<ChatRoomVO> allRoomList(){
		this.allRoomList = this.chatService.roomList();
		return allRoomList;
	}
	
	// 내가 참가한 채팅방 가져오기
//	private List<AllChatRoomViewVO> myRoomList(String userId){
//		myRoomList = this.chatService.myRoomList(userId);
//		return myRoomList;
//	}
	// 채팅방 이동
	@RequestMapping("/choice")
	public String chatForm(Model model ,HttpServletRequest request) {
		
		String userId = ((HashMap) (request.getSession().getAttribute("memSession"))).get("userId").toString();
		
		model.addAttribute("allRoomList" , this.allRoomList);
		
		log.info("chat form페이지 이동 성공 {}");
		return "chat/choice";
	}
	
	@ResponseBody
	@GetMapping("/joinRoom")
	public String joinRoom(@RequestBody int roomNo , HttpServletRequest request) {
		
		String userId = ((HashMap) (request.getSession().getAttribute("memSession"))).get("userId").toString();
		
		ChatRelayVO chatRelayVO = new ChatRelayVO(roomNo, userId);
		
		int result = this.chatService.joinRoom(chatRelayVO);

		insertResult("채팅방 입장 완료 : " , result);
		System.out.println("리턴되는 값이 뭐지" + result + "\n"+ chatRelayVO);
		return "redirect:join";
		}
	@ResponseBody
	@PostMapping("/joinCheck")
	public int joinCheck(@RequestBody int roomNo , HttpServletRequest request) {

		String userId = ((HashMap) (request.getSession().getAttribute("memSession"))).get("userId").toString();
		ChatRelayVO chatRelayVO = new ChatRelayVO(roomNo, userId);
		
		int result = this.chatService.joinCheck(chatRelayVO);
		System.out.println("채팅방 참가 체크 result : " + result);
		return result;
		
	}
	
	String userId(HttpServletRequest request) {
		return ((HashMap) (request.getSession().getAttribute("memSession"))).get("userId").toString();
	}
	
	@ResponseBody
	@PostMapping("/createRoom")
	public String createRoom(@RequestBody String roomName , HttpServletRequest request) {
		
		String userId = ((HashMap) (request.getSession().getAttribute("memSession"))).get("userId").toString();
		ChatRoomVO chatRoomVO = new ChatRoomVO(roomName, userId);
		
		int result = this.chatService.createRoom(chatRoomVO);
		insertResult("createRoom테스트 : " ,result);
		if(result > 0) {
			allRoomList();
		}
		System.out.println("여기로 오나");
		return "success";
		
	}
	
	public void insertResult (String testName ,int result) {
		System.out.println();
		if(result > 0) {
			log.info(testName + " 성공 " + result);
			System.out.println("insert 성공!! insert result -> " + result);
			return;
		} else {
			log.info(testName + " 실패 " + result);
			System.out.println("insert 실패 insert result -> " + result);
			return;
		}
	}
	@GetMapping("/join")
	public String findRoomsById(Model model, @RequestParam("roomNo")int roomNo , HttpServletRequest request) throws JsonProcessingException{
		HttpSession session = request.getSession();
		String userId = ((HashMap) (session.getAttribute("memSession"))).get("userId").toString();
		AllChatRoomViewVO myList = this.chatService.roomByRoomNo2(roomNo);
		// 방 번호로 해당 방을 가져온다 -> 내방을 가져온다
		log.info("myList 방 번호로 해당 방을 가져온다 -> 내방을 가져온다 " + myList);

		List<ChatRelayVO> chatRelayVO = this.chatService.myRoomId(roomNo);
		
		// 해당 방의 유저를 확인한다
		for (ChatRelayVO chatRoom : chatRelayVO) {
		    List<UsersVO> userInfo = this.chatService.userInfo(chatRoom.getUserId()); // 해당 방에 속한 사용자 정보를 가져옴
		    System.out.println("userInfo " + userInfo);
		    System.out.println("테스트2");

		    if (myList.getUserVO() == null) { // userVO 리스트가 null인 경우 새로운 리스트로 초기화
		    	myList.setUserVO(new ArrayList<>());
		    }

		    if (userInfo != null) { // userInfo가 null이 아닌 경우에만 추가
		    	myList.getUserVO().addAll(userInfo); // 가져온 사용자 정보를 myList에 추가
		    }
		    System.out.println("myList " + myList);
		}
		myList.setUserId(userId);
		
		ObjectMapper objp =  new ObjectMapper();
		
		String userVO = objp.writeValueAsString(myList.getUserVO());
		
		String myRoom = objp.writeValueAsString(myList);
		// 아이디로 유저 정보를 가져온다
		model.addAttribute("userVO" , userVO);
		model.addAttribute("myList" , myRoom);
		return "chat/message";
	}
}
