package kr.or.ddit.vo;

import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class AftusBbscttVO {
	
	private int rnum;
	private int aftusBbscttNo;			// 게시글코드(번호)
	private String aftusBbscttSj;		// 게시글제목
	private String aftusBbscttCn;		// 게시글 내용
	@DateTimeFormat(pattern="yyyy-MM-dd'T'HH:mm")
	private String aftusBbscttWrDt;		// 게시글 작성일
	private int aftusBbscttRdcnt;		// 게시글 조회수
	private int sprviseAtchmnflNo;		// 통합첨부파일 번호
	private int srvcRequstNo;			// 서비스 요청번호
	private String userId;				// 회원 아이디
	private String UserNcnm;			// 회원 닉네임
	private String mberProflPhoto;		// 회원 프로필 사진
	private String proId;
	
	private MultipartFile[] uploadFile;
	
	private List<SprviseAtchmnflVO> sprviseAtchmnflVO;
}
