package kr.or.ddit.util.echo;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import kr.or.ddit.alarm.vo.NtchDetailVO;
import kr.or.ddit.chatting.mapper.MessageMapper;
import kr.or.ddit.chatting.service.MessageService;
import kr.or.ddit.chatting.vo.MessageVO;
import kr.or.ddit.todaymeeting.VChatRoom;
import kr.or.ddit.todaymeeting.service.TodayMeetingService;
import kr.or.ddit.vo.TdmtngChSpMshgVO;
import kr.or.ddit.vo.TdmtngPrtcpntVO;
import kr.or.ddit.vo.TdmtngVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
@Slf4j
@Controller
@RequiredArgsConstructor
public class StompChatController {
	
	enum MessageType {
	
		ENTER , INVITE , MESSAGE;
	}
	
	@Inject
	private MessageService messageService;

	@Inject
	private MessageMapper MessageMapper;
	
	@Inject
	TodayMeetingService todayMeetingService;
	
	private final SimpMessagingTemplate template;
	
	@ResponseBody
	@PostMapping("/chat/messageList")
	public ModelMap messageListTest(@RequestParam("roomNo") int roomNo) throws JsonProcessingException {
		ModelMap modelMap = new ModelMap();

		List<MessageVO> messageList = this.messageService.messageList(roomNo);
	    ObjectMapper objp =  new ObjectMapper();
	    String myRoomChat = objp.writeValueAsString(messageList);
	    modelMap.addAttribute("messageList", messageList);
	    modelMap.addAttribute("myRoomChat", myRoomChat);

	    return modelMap;
	}
	
	@MessageMapping("/chat/invite")
	public void invite(TdmtngChSpMshgVO message) {

		message.setMessageType(MessageType.INVITE.toString());
		
		TdmtngVO inviteMSG = new TdmtngVO();
		
		inviteMSG.setUserId(message.getUserId());
		inviteMSG.setTdmtngNo(message.getTdmtngNo());
		
		inviteMSG = this.MessageMapper.firstMsg(inviteMSG);
		
		log.info("인바이트 메세지 : " + inviteMSG.getFirstMsg());
		
		if(inviteMSG.getFirstMsg().equals("T")) {
		
			log.info("입장 메세지 확인 : " + message);
			log.info("입장 메세지 확인 : " + message.getMessageType());
			
			
			message.setTdmtngChSpMsgCn(message.getUserNcnm() + "님이 모임에 가입하였습니다!<br> 환영해주세요");
			
			template.convertAndSend("/sub/chat/room/" + message.getTdmtngNo() , message);
			log.info("여기까지 오면 되는데1 : " + inviteMSG.getFirstMsg());
			log.info("여기까지 오면 되는데2 : " + message.getMessageType());
		}
			
	}
	
	@MessageMapping("/chat/enterK")
	public void enter(TdmtngChSpMshgVO message) {
		// 수신 영역
		message.setMessageType(MessageType.ENTER.toString());
		
		String str = "<div id='msgArea'>"+ message.getUserNcnm()+"님이 접속하였습니다 </div>";
		
		message.setTdmtngChSpMsgCn(str);

//		message.setTdmtngChSpMsgCn(message.getUserNcnm()+"님이 접속하였습니다<br/>");
		
		template.convertAndSend("/sub/chat/room/" + message.getTdmtngNo(), message);
			
	}
	@Transactional
	@MessageMapping("/chat/message")
	public void message(TdmtngChSpMshgVO message) {
		// 전송영역
		message.setMessageType(MessageType.MESSAGE.toString());
		
		log.info("채팅전송체크{} Before " + message);

		
		int result = this.messageService.insert(message);
		
		log.info("채팅전송체크{} After " + message);
		if(result > 0) {
			log.info("메세지 전송 성공 " + result);
			log.info("채팅전송체크{} Insert After" + message);
		} else {
			log.info("메세지 전송 실패 " + result);
		}
		
	    List<TdmtngChSpMshgVO> msgList = this.messageService.roomMsgList(message.getTdmtngNo());
	    
	    List<TdmtngPrtcpntVO> chatMemList = this.todayMeetingService.chatMemList(message.getTdmtngNo());
	    
	    for(TdmtngChSpMshgVO aa : msgList) {
	    	
	    	for(TdmtngPrtcpntVO bb : chatMemList) {
	    		
	    		if(aa.getUserId().equals(bb.getUserId())){
	    			
	    			if(bb.getMberProflPhoto() !=null) {
	    				
	    				message.setProflPhoto(bb.getMberProflPhoto());
	    				break;
	    			} 
	    			if(bb.getProProflPhoto() != null) {
	    				
	    				message.setProflPhoto(bb.getProProflPhoto());
	    				break;
	    			}
	    		}
	    	}
	    	
	    }

	    template.convertAndSend("/sub/chat/room/" + message.getTdmtngNo() , message);
	    log.info("msg getProflPhoto : " + message);
	    log.info("msg getProflPhoto template : " + template);
		
	}
	
///////////// 알람 기능 삭제되었음!!
	@MessageMapping("/alarm/get")
	public void alram(NtchDetailVO alarmInfo) {
		// 수신영역
		
		System.out.println("알람 수신 체크");
		
		template.convertAndSend("/sub/alarm/"+ alarmInfo.getUserId() , alarmInfo);

	}
	
	@MessageMapping("/alarm/send")
	public void alramSend(NtchDetailVO alarmInfo) {
		// 전송영역
		
		System.out.println("알람 전송 체크");
		
		template.convertAndSend("/sub/alarm/"+ alarmInfo.getUserId() , alarmInfo);

		System.out.println("알람 내용 : " + alarmInfo);
	}
	
}