package kr.or.ddit.vo;


import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@NoArgsConstructor
public class TdmtngChSpMshgVO {

	private int    tdmtngChSpMsgNo;					// 메세지 번호
	private String tdmtngChSpMsgTrnsmisDt;			// 메세지 전송날짜(연월일시분초)
	private String dayWeek;							// 메세지 전송날짜(요일)
	private String tdmtngChSpMsgCn;					// 메세지 내용
	private int    tdmtngChSpMsgCnfirmAt;			// 메세지 체크 여부
	private String userId;							// 메세지 보낸 유저아이디
	private String userNcnm;						// 메세지 보낸 유저닉네임
	private int    tdmtngNo;						// 채팅방번호

	private String messageType;

	private String proflPhoto;

}
