package kr.or.ddit.member.mypage.mapper;

import java.util.Map;

import kr.or.ddit.vo.VMberUsersVO;

public interface MemberMypageMapper {

	public int memberDelete(String userId);
	public int memberDelete2(String userId);
	public int memberDelete3(String userId);
	public int memberDelete4(String userId);

	public int photoDelete(String userId);

	public int updPhoto(Map<String, Object> map);
	
	public int updAdres(Map<String, Object> map);
	
	public int updMberMbtlnum(Map<String, Object> map);
	
	public int updPw(Map<String, Object> map);
	
	public int updNcnm(Map<String, Object> map);
	
	public int updEmail(Map<String, Object> map);
	
	public int updNm(Map<String, Object> map);

}
