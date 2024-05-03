package kr.or.ddit.pro.proSearch.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.pro.proSearch.mapper.SearchProMapper;
import kr.or.ddit.pro.proSearch.service.SearchProService;
import kr.or.ddit.vo.AdresVO;
import kr.or.ddit.vo.ProVO;
import kr.or.ddit.vo.SpcltyRealmVO;

@Service
public class SearchProServiceImpl implements SearchProService {

	@Autowired
	SearchProMapper searchProMapper;
	
	@Override
	public List<ProVO> proList() {
		return this.searchProMapper.proList();
	}

	@Override
	public List<ProVO> proListPage(Map<String, Object> map) {
		return this.searchProMapper.proListPage(map);
	}

	@Override
	public int getTotal(Map<String, Object> map) {
		return this.searchProMapper.getTotal(map);
	}
	
	@Override
	public List<SpcltyRealmVO> spcltyB() {
		return this.searchProMapper.spcltyB();
	}
	
	@Override
	public List<AdresVO> aroundPro() {
		return this.searchProMapper.aroundPro();
	}

	@Override
	public List<ProVO> getMonthPro(Map<String, Object> map) {
		return this.searchProMapper.getMonthPro(map);
	}

	@Override
	public List<SpcltyRealmVO> spcltySec(String code) {
		return this.searchProMapper.spcltySec(code);
	}

	@Override
	public String spcltyNm(String code) {
		return this.searchProMapper.spcltyNm(code);
	}

	


}
