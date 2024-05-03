package kr.or.ddit.vo;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;
@Getter
@Setter
@ToString
@NoArgsConstructor
public class ProVO {

	private String proId;
	private String proMbtlnum; //전화번호
	private String sexdstnTy; //성별
	private String email; //이메일
	private String proProflPhoto; //프로필사진
	private String spcltyRealmCode; //전문분야코드

	private MultipartFile uploadFile;
	
	//중첩된 자바빈
	private List<ProProflVO> proflVOList;
	
	//중첩된자바빈-프로즐겨찾기
	private List<UsersVO> userSeVOList;
	
	//중첩된자바빈-도시 코드->이름 
	private List<VCityVO> vCityVOList;
	
	//중첩된자바빈-도시 코드->이름 
	private List<SpcltyRealmVO> spcltyRealmVOList;
	
	//중첩된자바빈-프로찾기 프로정보
	private List<AdresVO> adresList;

}

