package kr.or.ddit.chatting.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.annotation.PostConstruct;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.lang.Nullable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
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
import retrofit2.http.GET;

@Slf4j
//@Controller
//@RequestMapping("/chat")
@SuppressWarnings({ "unchecked" , "unused"})
public class ChatController {
	
	@PostConstruct
	private void init() { allRoomList(); };

	@Autowired
	private ChatService chatService;
	
	@Autowired
	private MessageService messageService;
	
	private List<ChatRoomVO> allRoomList;
	
	private List<AllChatRoomViewVO> myRoomList;
	
	private HttpSession session;

	private String userId(HttpServletRequest request) {
	//세션값으로 아이디 가져오기
		
		Object proSession = request.getSession().getAttribute("proSession");
		Object memSession = request.getSession().getAttribute("memSession");
		Object admSession = request.getSession().getAttribute("admSession");
		
//			String aa = ((HashMap)(request.getSession().getAttribute("proSession"))).get("userId").toString();
		
		if(proSession !=null && proSession instanceof HashMap) {
			Object userId = ((HashMap<String, Object>)proSession).get("userId");
			System.out.println("proSession : "+ userId);
			
			return userId != null ? userId.toString() : null;
		}
		if(memSession !=null && memSession instanceof HashMap) {
			Object userId = ((HashMap<String, Object>)memSession).get("userId");
			System.out.println("memSession : " + userId);
			
			return userId != null ? userId.toString() : null;

		}
		if(admSession !=null && admSession instanceof HashMap) {
			Object userId = ((HashMap<String, Object>)admSession).get("userId");
			System.out.println("admSession : " + userId);
			
			return userId != null ? userId.toString() : null;

		}
		return "not";
	}
	
	public List<ChatRoomVO> allRoomList(){
		// 전체방 리스트 가져오기
		return this.allRoomList = this.chatService.roomList();
	}
	
	@Nullable
	public List<AllChatRoomViewVO> myRoomList(String userId){
		// 아이디로 리스트 가져오기
		return this.myRoomList = this.chatService.myRoomList(userId);
	}
	
	private List<MessageVO> messageList (int roomNo){
		// 메세지 리스트 가져오기
		return this.messageService.messageList(roomNo);
		
	}
	
	@GetMapping("/main")		// 채팅 메인
	public String chatHome(Model model , HttpServletRequest request) {
		
		userId(request);
		
		List<ChatRoomVO> allRoomList = this.allRoomList;
		this.myRoomList = myRoomList(userId(request));
		
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
		
		model.addAttribute("myRoomList", myRoomList);
		model.addAttribute("allRoomList", allRoomList);
		model.addAttribute("myRoomUserId", myRoomUserId);
		
		return "main";
		
	}
	
	@GetMapping("/join")
	public String join(Model model ,@RequestParam int roomNo , HttpServletRequest request) throws JsonProcessingException {
		// 방참가
		AllChatRoomViewVO myList = this.chatService.roomByRoomNo2(roomNo);
		
		List<ChatRelayVO> chatRelayVO = this.chatService.myRoomId(roomNo);
		
		for (ChatRelayVO chatRoom : chatRelayVO) {
		    List<UsersVO> userInfo = this.chatService.userInfo(chatRoom.getUserId()); // 해당 방에 속한 사용자 정보를 가져옴

		    if (myList.getUserVO() == null) { myList.setUserVO(new ArrayList<>()); }
		    	// userVO 리스트가 null인 경우 새로운 리스트로 초기화

		    if (userInfo != null) { 					// userInfo가 null이 아닌 경우에만 추가
		    	myList.getUserVO().addAll(userInfo);	// 가져온 사용자 정보를 myList에 추가
		    }
		    System.out.println("myList " + myList);
		}
		myList.setUserId(userId(request));

		ObjectMapper objp =  new ObjectMapper();
		
		String myRoom = objp.writeValueAsString(myList);
		String userVO = objp.writeValueAsString(myList.getUserVO());
		String roomMessageJson = objp.writeValueAsString(messageList(roomNo));
		
		model.addAttribute("userVO" , userVO);
		model.addAttribute("myList" , myRoom);
		model.addAttribute("roomMessage" , messageList(roomNo));
		model.addAttribute("roomMessageJson" ,roomMessageJson);
		
		return "chat/messagetest";
		
	}
	
	@GetMapping("/leave")
	public String leave() {
		// 방나가기
		return "chat/leave";
		
	}
	
	@GetMapping("/make")
	public String make(String roomName) {
		// 방생성
		return "chat/make";
		
	}
	
	@GetMapping("/move")
	public String move(int roomNo) {
		// 방이동
		return "chat/move";
		
	}
	@ResponseBody @PostMapping("/check")
	public int check(@RequestParam int roomNo , HttpServletRequest request) {

		ChatRelayVO chatRelayVO = new ChatRelayVO(roomNo, userId(request));
		
		return this.chatService.joinCheck(chatRelayVO);
	}
	
}