package kr.or.ddit.chatting.service;

import java.util.LinkedList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.chatting.mapper.ChatMapper;
import kr.or.ddit.chatting.vo.AllChatRoomViewVO;
import kr.or.ddit.chatting.vo.ChatRelayVO;
import kr.or.ddit.chatting.vo.ChatRoomVO;
import kr.or.ddit.vo.UsersVO;
@Service
public class ChatServiceImpl implements ChatService{

	@Autowired
	public ChatMapper chatMapper;
	
	public List<AllChatRoomViewVO> allRoom(){
		
		LinkedList<AllChatRoomViewVO> allRoom = new LinkedList<AllChatRoomViewVO>();
		
		return allRoom;
	}
	
	
	@Override
	public List<ChatRoomVO> roomList() {
		return this.chatMapper.roomList();
	}

	@Override
	public List<AllChatRoomViewVO> myRoomList(String userId) {
		return this.chatMapper.myRoomList(userId);
	}
	
//	@Override
//	public List<AllChatRoomViewVO> myRoomList(String userId) {
//		return this.chatMapper.myRoomList(userId);
//	}

	@Override
	public int joinCheck(ChatRelayVO chatRelayVO) {
		return this.chatMapper.joinCheck(chatRelayVO);
	}

	@Override
	public int joinRoom(ChatRelayVO chatRelayVO) {
		return this.chatMapper.joinRoom(chatRelayVO);
	}

	@Override
	public List<ChatRelayVO> myRoomId(int roomNo) {
		return this.chatMapper.myRoomId(roomNo);
	}

	@Override
	public List<UsersVO> userInfo(String userId) {
		return this.chatMapper.userInfo(userId);
	}

	@Override
	public UsersVO joinUserInfo(String userId) {
		return this.chatMapper.joinUserInfo(userId);
	}

	@Override
	public List<AllChatRoomViewVO> roomByRoomNo(int roomNo) {
		return this.chatMapper.roomByRoomNo(roomNo);
	}

	@Override
	public AllChatRoomViewVO roomByRoomNo2(int roomNo) {
		return this.chatMapper.roomByRoomNo2(roomNo);
	}

	@Override
	public AllChatRoomViewVO myRoomListTest(String userId, int roomNo) {
		return this.chatMapper.myRoomListTest(userId, roomNo);
	}

	@Override
	public int createRoom(ChatRoomVO chatRoomVO) {
		System.out.println(chatRoomVO);
		return this.chatMapper.createRoom(chatRoomVO);
	}

}
