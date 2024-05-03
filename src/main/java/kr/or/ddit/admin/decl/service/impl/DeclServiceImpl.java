package kr.or.ddit.admin.decl.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.ddit.admin.decl.mapper.DeclMapper;
import kr.or.ddit.admin.decl.service.DeclService;
import kr.or.ddit.vo.DongChartVO;
import kr.or.ddit.vo.LbrtyBbscttVO2;
import kr.or.ddit.vo.PunshVO;
import kr.or.ddit.vo.SntncDeclVO;
import kr.or.ddit.vo.UserDeclVO;
import kr.or.ddit.vo.UsersVO;
import lombok.extern.slf4j.Slf4j;


@Slf4j
@Service
public class DeclServiceImpl implements DeclService {
	@Autowired
	DeclMapper declMapper; 
	
	
	@Override
	public List<SntncDeclVO> decllbrSelect(Map<String, Object> map) {
		return this.declMapper.decllbrSelect(map);
	}


	@Override
	public LbrtyBbscttVO2 lbrtyBbscttVo(SntncDeclVO sntncDeclVO) {
		// TODO Auto-generated method stub
		return this.declMapper.lbrtyBbscttVo(sntncDeclVO);
	}


	@Override
	public List<SntncDeclVO> declResnList(SntncDeclVO sntncDeclVO) {
		return this.declMapper.declResnList(sntncDeclVO);
	}

	
	@Transactional
	@Override
	public int declSet(int lbrtyBbscttNo) {
		int result = 0;
		// 이곳에서 두가지 실행
		// 1번 해당 게시글 삭제 여부가 1로 업데이가 되면서
		result = this.declMapper.declSet1(lbrtyBbscttNo);
		log.info("1번째 결과 값 : " + result);
		// 2번 신고에 대한 처리를 완료로 뜨게 해야된다.(DECL_PROCESS_AT = 1)
		result += this.declMapper.declSet2(lbrtyBbscttNo);
		log.info("2번째 결과 값 : " + result);
		result += this.declMapper.declSet3(lbrtyBbscttNo);
		log.info("3번째 결과 값 : " + result);
		 
		return result;
	}


	@Override
	public List<UsersVO> userList() {
		return this.declMapper.userList();
	}


	@Override
	public int getDeclCount(String userId2) {
		return this.declMapper.getDeclCount(userId2);
	}


	@Override
	public List<UserDeclVO> userDeclList(String userId) {
		return this.declMapper.userDeclList(userId);
	}

	@Transactional
	@Override
	public int userDeclSet(Map<String, Object> map) {
		int result = 0;
		result += this.declMapper.userDeclSet(map);
		result += this.declMapper.declProcessAtSet(map);
		
		return result;
		
	}


	@Override
	public List<PunshVO> declHistoryList(String userId) {
		return this.declMapper.declHistoryList(userId);
	}



}
