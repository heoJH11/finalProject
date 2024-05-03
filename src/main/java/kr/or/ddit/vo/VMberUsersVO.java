package kr.or.ddit.vo;

import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class VMberUsersVO {
	private String mberId;
	private String mberMbtlnum;
	private String sexdstnTy;
	private String email;
	private String mberProflPhoto;
	private String userNm;
	private String userPassword;
	private String emplyrTy;
	private int secsnAt;
	private String userNcnm;
	private String userId;
	private String changePwCk;
	
	private MultipartFile uploadFile;
}
