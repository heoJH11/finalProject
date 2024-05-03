package kr.or.ddit.chatting.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.chatting.vo.MessageVO;
import kr.or.ddit.todaymeeting.controller.TestVO;
import kr.or.ddit.vo.TdmtngChSpMshgVO;
import kr.or.ddit.vo.TdmtngVO;

public interface MessageService {

	int insert(TdmtngChSpMshgVO message);
	
	List<MessageVO> messageList(int roomNo);

	List<TdmtngChSpMshgVO> roomMsgList(int tdmtngNo);
	
	Map<Integer , List<MessageVO> > msgPaging(int roomNo);

	List<TdmtngChSpMshgVO> messageTest(TestVO testVO);
	
	int getMsgCount(int roomNo);
	
	List<TdmtngChSpMshgVO> scroll(int tdmtngNo);

	List<TdmtngChSpMshgVO> scrollTest(Map<String , Object> map);

	
}
