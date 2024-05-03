package kr.or.ddit.admin.decl.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.vo.DongChartVO;
import kr.or.ddit.vo.LbrtyBbscttVO2;
import kr.or.ddit.vo.PunshVO;
import kr.or.ddit.vo.SntncDeclVO;
import kr.or.ddit.vo.UserDeclVO;
import kr.or.ddit.vo.UsersVO;


public interface DeclService {

	public List<SntncDeclVO> decllbrSelect(Map<String, Object> map);

	public LbrtyBbscttVO2 lbrtyBbscttVo(SntncDeclVO sntncDeclVO);

	public List<SntncDeclVO> declResnList(SntncDeclVO sntncDeclVO);

	public int declSet(int lbrtyBbscttNo);
	
	//유저 목록 조회
	public List<UsersVO> userList();
	//유저 신고 횟수 조회
	public int getDeclCount(String userId2);
	
	//해당 유저 상세 신고사항
	public List<UserDeclVO> userDeclList(String userId);

	public int userDeclSet(Map<String, Object> map);
	
	//해당 유저 제재 현황
	public List<PunshVO> declHistoryList(String userId);
	

}
