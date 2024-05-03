package kr.or.ddit.vo;

import java.util.Date;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;
@Getter
@Setter
@ToString
@NoArgsConstructor
public class ResveVO {
	private int resveNo; //구매번호
	private int resveTotqy; //구매 총수량
	private int resveTpprice; //구매 총 가격
	private Date resveDt; //예약 일시
	private String mberId; //회원 아이디
}
