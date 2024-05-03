package kr.or.ddit.vo;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class VOndyclProUsersVO {
	private String proId;	//아이디	
	private String proMbtlnum;	//전화번호	
	private String sexdstnTy;	//성별
	private String email;	//이메일
	private String proProflPhoto;	//프사
	private String spcltyRealmCode;	//전문분야코드
	private int ondyclNo;		//원데이클래스 글번호
	private String ondyclNm;	//제목
	private String ondyclCn;	//내용
	private String ondyclRegistDt;	//등록일자
	private int ondyclPc;	//가격
	private int ondyclPsncpa;	//정원
	private String ondyclResvpa; //현재 예약인원
	private int ondyclDelType;	//삭제여부
	private String ondyclDelDt;	//삭제날짜
	private String ondyclThumbPhoto;	//썸네일
	private int sprviseAtchmnflNo; //통합첨부파일번호
	private String userNm;	//프로이름
	private String emplyrTy;	//사용자 코드
	private int secsnAt;	//탈퇴여부
	private String userNcnm;	//닉네임
	private int ondyclSchdulNo;	//클래스 스케줄번호
	private String ondyclSchdulDe; //시작날짜
	private String ondyclSchdulBeginTime; //시작시간
	private String ondyclSchdulEndTime; //종료시간
	private int adresNo; //프로 주소번호
	private String adres;	//프로 주소
	private String detailAdres;	//프로 상세주소
	private String zip;	//프로 우편번호
	private String spcltyRealmNm;	//프로 전문분야
	private String ptprtSpcltyRealmCode;	//전문분야 상위코드
	private String ondyclAdres;
	private String ondyclDetailAdres;
	private String ondyclZip;
	private int ondyclReNo;		//리뷰 번호
	private String ondyclReCn;	//리뷰 내용
	private Date ondyclReWrDt;	//작성일자
	private String mberNcnm;	//작성자 닉네임
	private String mberId;	//작성자 아이디
	private int ondyclReScore;	//리뷰 별점
	private String changePwCk;

	
	
	private String canclAt; //취소여부
	private int rnum;
	private boolean dayCheck; //원데이클래스 날짜 지났는지 확인
	private boolean peopleCheck; //원데이클래스 정원 확인
	
}
