package kr.or.ddit.admin.usersSearch.mapper;

import java.util.List;
import java.util.Map;

import kr.or.ddit.admin.usersSearch.vo.UsersVO;

public interface UsersSearchMapper {

	public int getTotal(Map<String, Object> map);

	public List<UsersVO> list(Map<String, Object> map);

	public UsersVO detail(String userId);

	public String getUserProfile(String userId);

	public int userDanger(String userId);

}
