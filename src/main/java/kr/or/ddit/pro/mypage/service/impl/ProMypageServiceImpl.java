package kr.or.ddit.pro.mypage.service.impl;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.pro.mypage.mapper.ProMypageMapper;
import kr.or.ddit.pro.mypage.service.ProMypageService;

@Service
public class ProMypageServiceImpl implements ProMypageService {
	
	@Autowired
	ProMypageMapper proMypageMapper;

	@Override
	public int updProMbtlnum(Map<String, Object> map) {
		return this.proMypageMapper.updProMbtlnum(map);
	}

	@Override
	public int updPW(Map<String, Object> map) {
		return this.proMypageMapper.updPW(map);
	}

	@Override
	public int updNcnm(Map<String, Object> map) {
		return this.proMypageMapper.updNcnm(map);
	}

	@Override
	public int updPhoto(Map<String, Object> map) {
		return this.proMypageMapper.updPhoto(map);
	}

	@Override
	public int photoDelete(String userId) {
		return this.proMypageMapper.photoDelete(userId);
	}

	@Override
	public int updEmail(Map<String, Object> map) {
		return this.proMypageMapper.updEmail(map);
	}

	@Override
	public int updNm(Map<String, Object> map) {
		return this.proMypageMapper.updNm(map);
	}

	@Override
	public int updAdres(Map<String, Object> map) {
		return this.proMypageMapper.updAdres(map);
	}
}
