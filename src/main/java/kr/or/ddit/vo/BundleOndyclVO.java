package kr.or.ddit.vo;

import lombok.Data;

@Data
public class BundleOndyclVO {
	private int shopngBundleNo;	//장바구니번호
	private String mberId;	//회원아이디
	private int ondyclSchdulNo;	//일정번호
	private int ondyclNo;	//원데이클래스 번호
	private int prdTotqy;	//총 수량
	private int prdPc;	//가격
	private String resveTy;	//구매상태 1구매완료/0구매전
	private int rnum;
	private String ondyclSchdulDe; //원데이클래스 일정 날짜("20240303")
	private String ondyclSchdulBeginTime; //원데이클래스 시작시간("15:00") 
	private String ondyclSchdulEndTime; //원데이클래스 종료시간("21:00")
	private String ondyclNm; //원데이클래스 제목
	private String ondyclCn; //원데이클래스 내용
	private String ondyclRegistDt; //원데이클래스 등록일시
	private int ondyclPc; //원데이클래스 가격
	private int ondyclPsncpa; //원데이클래스 정원
	private String ondyclResvpa; //현재 예약인원
	private int ondyclDelType; //원데이클래스 삭제여부
	private String ondyclDelDt; //원데이클래스 삭제일시
	private String ondyclThumbPhoto; //원데이클래스 썸네일 경로
	private String proId; //등록한 프로 아이디
	private String userNcnm;
	private int sprviseAtchmnflNo; //통합첨부파일번호
	private String ondyclAdres;
	private String ondyclDetailAdres;
	private String ondyclZip;
	
	private boolean peopleCheck;
	private boolean dayCheck;
}
