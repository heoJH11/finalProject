package kr.or.ddit.chatting.mapper;

import java.util.List;

import kr.or.ddit.chatting.vo.AllChatRoomViewVO;
import kr.or.ddit.chatting.vo.ChatRelayVO;
import kr.or.ddit.chatting.vo.ChatRoomVO;
import kr.or.ddit.vo.UsersVO;

public interface ChatMapper {

	public List<ChatRoomVO> roomList();
	
//	public List<ChatRoomVO> myRoomList(String userId);
	
	public List<AllChatRoomViewVO> myRoomList(String userId);

	public int joinCheck(ChatRelayVO chatRelayVO);

	public int joinRoom(ChatRelayVO chatRelayVO);

	public List<ChatRelayVO> myRoomId(int roomNo);

	public List<UsersVO> userInfo(String userId);

	public UsersVO joinUserInfo(String userId);

	public List<AllChatRoomViewVO> roomByRoomNo(int roomNo);

	public AllChatRoomViewVO roomByRoomNo2(int roomNo);
	
	public AllChatRoomViewVO myRoomListTest(String userId, int roomNo);

	public int createRoom(ChatRoomVO chatRoomVO);
}
