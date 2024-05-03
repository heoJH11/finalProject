package kr.or.ddit.alarm.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import kr.or.ddit.alarm.service.AlarmService;
import lombok.extern.slf4j.Slf4j;
@Slf4j
@SuppressWarnings({"unchecked", "unused"})
@Controller
public class AlarmController extends TextWebSocketHandler {
	
//	@Autowired
	private AlarmService alarmService;
	
	//로그인 한 인원 전체
	private List<WebSocketSession> sessions = new ArrayList<WebSocketSession>();
	
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
			sessions.add(session);
//			String senderId = userId(session);
	}
	
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
			sessions.remove(session);
	}
	
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		
		for(WebSocketSession test : sessions) {
			
			String   msg = message.getPayload();
			String[] str = msg.split(",");
			
		}
		
	}
	
	private String currentUserId(WebSocketSession session) {
		
		Map<String,Object> httpSession =  session.getAttributes();
		
		return "";
	}
	
	private String userId(HttpServletRequest request) {
		
		Object proSession = request.getSession().getAttribute("proSession");
		Object memSession = request.getSession().getAttribute("memSession");
		Object admSession = request.getSession().getAttribute("admSession");
		
//			String aa = ((HashMap)(request.getSession().getAttribute("proSession"))).get("userId").toString();
		
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
		return "not found";
	}
	

}
