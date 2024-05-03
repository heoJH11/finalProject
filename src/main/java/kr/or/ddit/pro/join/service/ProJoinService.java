package kr.or.ddit.pro.join.service;

import java.time.LocalDate;
import java.util.Date;
import java.util.List;
import java.util.Map;

import kr.or.ddit.vo.AdresVO;
import kr.or.ddit.vo.SpcltyRealmVO;
import kr.or.ddit.vo.UsersVO;
import kr.or.ddit.vo.VMberUsersVO;
import kr.or.ddit.vo.VOndyclProUsersVO;
import kr.or.ddit.vo.VProUsersVO;

public interface ProJoinService {

	public int emailCk(String email);

	public int idCk(String userId);

	public int ncnmCk(String userNcnm);

	public void certifiedPhoneNumber(String mberMbtlnum, String numStr);

	public UsersVO proLogin(Map<String, Object> userMap);

	public int proInsert(Map<String, Object> map);

	public VProUsersVO getProfile(Map<String, Object> userMap);

	public UsersVO idSearch(VProUsersVO vProUsersVO);

	public UsersVO pwSearch(VProUsersVO vProUsersVO);

	public int updatePw(Map<String, Object> map);

	public VMberUsersVO idSearch2(VProUsersVO vProUsersVO);

	public String pwSearch2(VProUsersVO vProUsersVO);

	public AdresVO getAdres(Map<String, Object> userMap);

	public String proSRCode(String spcltyRealmCode);

	public List<SpcltyRealmVO> selectCode();

	public List<SpcltyRealmVO> codeSelect(String code);
	
	//관리자
	public UsersVO admLogin(Map<String, Object> userMap);
	//관리자 users 불러오기
	public UsersVO adminVO(String userId);

	public List<VOndyclProUsersVO> proMyClassList(String proId);

	public int countProMyClass(String proId);
	
	//동균 신고 처리 추가 부분
	//프로 제재종료일 불러오기
	public Date getUserEndDt(String userId);
	//동균 신고 처리 추가 끝

}
