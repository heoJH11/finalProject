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
public class SetleVO {
	private int setleNo; //결제번호
	private int resveNo; //구매번호
	private Date setleDt; //결제일
	private String canclAt; //취소여부
	private Date canclDt; //취소일시
	private String setleMnCode; //결제수단코드
}
