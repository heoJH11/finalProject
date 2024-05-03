package kr.or.ddit.admin.decl.mapper;

import java.util.List;
import java.util.Map;

import kr.or.ddit.vo.LbrtyBbscttVO2;
import kr.or.ddit.vo.PunshVO;
import kr.or.ddit.vo.SntncDeclVO;
import kr.or.ddit.vo.UserDeclVO;
import kr.or.ddit.vo.UsersVO;

public interface DeclMapper {

	public List<SntncDeclVO> decllbrSelect(Map<String, Object> map);

	public LbrtyBbscttVO2 lbrtyBbscttVo(SntncDeclVO sntncDeclVO);

	public List<SntncDeclVO> declResnList(SntncDeclVO sntncDeclVO);

	public int declSet1(int lbrtyBbscttNo);

	public int declSet2(int lbrtyBbscttNo);

	public List<UsersVO> userList();

	public int getDeclCount(String userId2);

	public List<UserDeclVO> userDeclList(String userId);

	public int userDeclSet(Map<String, Object> map);

	public int declProcessAtSet(Map<String, Object> map);

	public List<PunshVO> declHistoryList(String userId);

	public int declSet3(int lbrtyBbscttNo);

}
