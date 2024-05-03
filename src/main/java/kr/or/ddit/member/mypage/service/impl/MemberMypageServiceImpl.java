package kr.or.ddit.member.mypage.service.impl;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.member.mypage.mapper.MemberMypageMapper;
import kr.or.ddit.member.mypage.service.MemberMypageService;
import kr.or.ddit.vo.VMberUsersVO;

@Service
public class MemberMypageServiceImpl implements MemberMypageService {
	
	@Autowired
	MemberMypageMapper memberMypageMapper;

	@Override
	public int updPhoto(Map<String, Object> map) {
		return this.memberMypageMapper.updPhoto(map);
	}
	
	@Override
	public int memberDelete(String userId) {
		return this.memberMypageMapper.memberDelete(userId);
	}

	@Override
	public int memberDelete2(String userId) {
		return this.memberMypageMapper.memberDelete2(userId);
	}

	@Override
	public int memberDelete3(String userId) {
		return this.memberMypageMapper.memberDelete3(userId);
	}
	
	@Override
	public int memberDelete4(String userId) {
		return this.memberMypageMapper.memberDelete4(userId);
	}

	@Override
	public int photoDelete(String userId) {
		return this.memberMypageMapper.photoDelete(userId);
	}

	@Override
	public int updAdres(Map<String, Object> map) {
		return this.memberMypageMapper.updAdres(map);
	}

	@Override
	public int updMberMbtlnum(Map<String, Object> map) {
		return this.memberMypageMapper.updMberMbtlnum(map);
	}

	@Override
	public int updPw(Map<String, Object> map) {
		return this.memberMypageMapper.updPw(map);
	}

	@Override
	public int updNcnm(Map<String, Object> map) {
		return this.memberMypageMapper.updNcnm(map);
	}

	@Override
	public int updEmail(Map<String, Object> map) {
		return this.memberMypageMapper.updEmail(map);
	}

	@Override
	public int updNm(Map<String, Object> map) {
		return this.memberMypageMapper.updNm(map);
	}

}
