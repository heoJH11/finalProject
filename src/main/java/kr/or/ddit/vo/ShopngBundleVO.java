package kr.or.ddit.vo;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;
@Getter
@Setter
@ToString
@NoArgsConstructor
public class ShopngBundleVO {
	private int shopngBundleNo;	//장바구니번호
	private String mberId;	//회원아이디
	private int ondyclSchdulNo;	//일정번호
	private int ondyclNo;	//원데이클래스 번호
	private int prdTotqy;	//총 수량
	private int prdPc;	//가격
	private String resveTy;	//구매상태 1구매완료/0구매전
}
