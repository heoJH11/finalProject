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
public class OndyclVO {
	
	private int ondyclNo; //원데이클래스 번호
	private String ondyclNm; //원데이클래스 제목
	private String ondyclCn; //원데이클래스 내용
	private String ondyclRegistDt; //원데이클래스 등록일시
	private int ondyclPc; //원데이클래스 가격
	private int ondyclPsncpa; //원데이클래스 정원
	private String ondyclResvpa; //현재 예약인원
	private int ondyclDeType; //원데이클래스 삭제여부
	private Date ondyclDelDt; //원데이클래스 삭제일시
	private String ondyclThumbPhoto; //원데이클래스 썸네일 경로
	private String proId; //등록한 프로 아이디
	private int sprviseAtchmnflNo; //통합첨부파일번호
	private String ondyclAdres;
	private String ondyclDetailAdres;
	private String ondyclZip;
	private int rnum;
	
	private MultipartFile uploadProfile;
	private MultipartFile[] uploadFile;
	private String[] updFileName;
	
}
