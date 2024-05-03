package kr.or.ddit.member.mypage.service;

import java.util.Map;

public interface MemberMypageService {


	public int updPhoto(Map<String, Object> map);

	public int memberDelete(String userId);
	public int memberDelete2(String userId);
	public int memberDelete3(String userId);
	public int memberDelete4(String userId);

	public int photoDelete(String userId);

	public int updAdres(Map<String, Object> map);

	public int updMberMbtlnum(Map<String, Object> map);

	public int updPw(Map<String, Object> map);

	public int updNcnm(Map<String, Object> map);

	public int updEmail(Map<String, Object> map);

	public int updNm(Map<String, Object> map);

}
