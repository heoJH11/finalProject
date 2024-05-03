package kr.or.ddit.chatting.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.chatting.mapper.MessageMapper;
import kr.or.ddit.chatting.vo.MessageVO;
import kr.or.ddit.todaymeeting.controller.TestVO;
import kr.or.ddit.vo.TdmtngChSpMshgVO;
import kr.or.ddit.vo.TdmtngVO;
import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class MessageServiceImpl implements MessageService {

	@Autowired
	private  MessageMapper messageMapper;
	
	@Override
	public int insert(TdmtngChSpMshgVO message) {
		
		int result = this.messageMapper.insert(message);
		return result;
	}

	@Override
	public List<MessageVO> messageList(int roomNo) {
		return this.messageMapper.messageList(roomNo);
	}

	@Override
	public Map<Integer, List<MessageVO>> msgPaging(int roomNo) {
		return null;
	}

	@Override
	public List<TdmtngChSpMshgVO> roomMsgList(int tdmtngNo) {
		
		List<TdmtngChSpMshgVO> ll = this.messageMapper.roomMsgList(tdmtngNo);
		System.out.println("TdmtngChSpMshgVO 채팅방번호 : " + tdmtngNo);
		System.out.println("TdmtngChSpMshgVO list : " + ll);
		return this.messageMapper.roomMsgList(tdmtngNo);
	
	}
	
	@Override
	public List<TdmtngChSpMshgVO> messageTest(TestVO testVO){
		return this.messageMapper.messageTest(testVO);
		
	}

	@Override
	public int getMsgCount(int roomNo) {
		return this.messageMapper.getMsgCount(roomNo);
	}

	@Override
	public List<TdmtngChSpMshgVO> scroll(int tdmtngNo) {
		return null;
	}

	@Override
	public List<TdmtngChSpMshgVO> scrollTest(Map<String , Object> map) {
		return this.messageMapper.scrollTest(map);
	}

}
