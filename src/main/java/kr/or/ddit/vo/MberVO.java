package kr.or.ddit.vo;

import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@NoArgsConstructor
public class MberVO {
	private String mberId;
	private String mberMbtlnum;
	private String sexdstnTy;
	private String email;
	private String mberProflPhoto;
	private String userNcnm;
	private String mberNcnm;
	
	private MultipartFile uploadFile;
}
