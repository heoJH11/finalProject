package kr.or.ddit.chatting.service;

import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
@SuppressWarnings("unchecked")
public class MessageController {
	
	final int PAGE_ROW_COUNT = 10;
	
	@Autowired
	private MessageService messageService;

	public String messageList(HttpServletRequest request , HttpSession session) {
		
		int pageNum = 1;
		
		String strPageNum = request.getParameter("pageNum");
		
		if(strPageNum != null) {
			pageNum = Integer.parseInt(strPageNum);
		}

		int startRowNum = 0 + (pageNum - 1) * PAGE_ROW_COUNT;
		
		int endRowNum = pageNum * PAGE_ROW_COUNT;
		
		int rowCount = PAGE_ROW_COUNT;

		String keyword = request.getParameter("keyword");
	
		String encode = URLEncoder.encode(keyword);
	
		Message msg = new Message();
	
		msg.setStartRowNum(startRowNum);
		msg.setEndRowNum(endRowNum);
		msg.setRowCount(rowCount);
		
		ArrayList<Message> list = null;
		
		int totalRow = 0;
		Object proSession = request.getSession().getAttribute("proSession");
		Object memSession = request.getSession().getAttribute("memSession");
		Object admSession = request.getSession().getAttribute("admSession");
		
		
		// 매번 작성해야함
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

		// 로그인 하면 내 방에 해당하는 메세지의 내역을 불러온다
//		list = this.messageService.messageList(roomNo);
			
			
		
		return "";
	}
	
	String userId(HttpServletRequest request) {
		
		Object proSession = request.getSession().getAttribute("proSession");
		Object memSession = request.getSession().getAttribute("memSession");
		Object admSession = request.getSession().getAttribute("admSession");
		
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
