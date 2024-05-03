package kr.or.ddit.chatting.vo;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@NoArgsConstructor
public class ChatRelayVO {

	private int roomNo;			// 채팅방 번호
	private String userId;		// 유저아이디
	
	public ChatRelayVO(int roomNo , String userId) {
		this.roomNo = roomNo;
		this.userId = userId;
	}
}
