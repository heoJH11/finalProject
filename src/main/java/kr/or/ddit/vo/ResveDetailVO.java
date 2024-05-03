package kr.or.ddit.vo;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@NoArgsConstructor
public class ResveDetailVO {
	private int resveNo; //구매번호(예약번호)
	private int ondyclSchdulNo; //원데이클래스 일정번호
	private int ondyclNo; //원데이클래스번호
	private int resveTotqy; //총 수량
	private int resveTpprice; //총 구매 가격
}
