package kr.or.ddit.chatting.mapper;

import java.util.List;
import java.util.Map;

import kr.or.ddit.chatting.vo.MessageVO;
import kr.or.ddit.todaymeeting.controller.TestVO;
import kr.or.ddit.vo.TdmtngChSpMshgVO;
import kr.or.ddit.vo.TdmtngVO;

public interface MessageMapper {

	public int insert(TdmtngChSpMshgVO message);
	
	public List<MessageVO> messageList(int roomNo);	

	public List<MessageVO> msgPaging(int roomNo);	
	
	String firstMsgDate(int msgNo);

	public List<TdmtngChSpMshgVO> roomMsgList(int tdmtngNo);
	
	public List<TdmtngChSpMshgVO> messageTest(TestVO testVO);

	public int getMsgCount(int roomNo);
	
	public List<TdmtngChSpMshgVO> scrollTest(Map<String , Object> map);

	public TdmtngVO firstMsg(TdmtngVO inviteMSG);
}
