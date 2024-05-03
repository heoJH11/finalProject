package kr.or.ddit.vo;

import java.util.Date;

import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@NoArgsConstructor
public class VOndyclSchdulVO {
	private int ondyclNo;	//클래스 번호
	private String ondyclNm;	//클래스 제목
	private String ondyclCn;	//클래스 내용
	private Date ondyclRegistDt;	//클래스 생성일자
	private int ondyclPc;	//클래스 가격
	private int ondyclPsncpa;	//클래스 정원
	private String ondyclResvpa; //현재 예약인원
	private int ondyclDelType;	//클래스 삭제여부
	private Date ondyclDelDt;	//클래스 삭제일시
	private String ondyclThumbPhoto;	//클래스 썸네일
	private String proId;	//작성자 아이디
	private int sprviseAtchmnflNo;	//첨부파일번호
	private int ondyclSchdulNo;	//클래스 스케줄번호
	private String ondyclSchdulDe;	//클래스 일자
	private String ondyclSchdulBeginTime;	//클래스 시작시간
	private String ondyclSchdulEndTime;	//클래스 종료시간
	private String ondyclAdres;
	private String ondyclDetailAdres;
	private String ondyclZip;
	private int rnum;
	
	private boolean peopleCheck;
	private boolean dayCheck;
	private MultipartFile uploadProfile;
	private MultipartFile[] uploadFile;
}
