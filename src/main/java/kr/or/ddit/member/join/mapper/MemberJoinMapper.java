package kr.or.ddit.member.join.mapper;

import java.util.Map;

import kr.or.ddit.vo.AdresVO;
import kr.or.ddit.vo.UsersVO;
import kr.or.ddit.vo.VMberUsersVO;
import kr.or.ddit.vo.VProUsersVO;

public interface MemberJoinMapper {

	public int emailCk(String email);

	public int idCk(String userId);

	public int ncnmCk(String userNcnm);

	public UsersVO memberLogin(Map<String, Object> userMap);

	public int memberInsert(Map<String, Object> map);

	public VMberUsersVO getProfile(Map<String, Object> userMap);

	public UsersVO pwSearch(VMberUsersVO vMberUsersVO);

	public UsersVO idSearch(VMberUsersVO vMberUsersVO);

	public int updatePw(Map<String, Object> map);

	public VProUsersVO idSearch2(VMberUsersVO vMberUsersVO);

	public String pwSearch2(VMberUsersVO vMberUsersVO);

	public AdresVO getAdres(Map<String, Object> map);

}
