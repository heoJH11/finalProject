package kr.or.ddit.chatting.vo;

import java.util.List;

import kr.or.ddit.vo.UsersVO;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
@NoArgsConstructor
public class AllChatRoomViewVO {

	private int roomNo;
	private String roomName;
	private String createDate;
	
	private String userId;
	
	private List<UsersVO> userVO;

}
