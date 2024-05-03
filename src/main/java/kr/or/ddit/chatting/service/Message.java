package kr.or.ddit.chatting.service;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@NoArgsConstructor
public class Message {
	
	private int startRowNum;
	
	private int endRowNum;
	
	private int rowCount;

}
