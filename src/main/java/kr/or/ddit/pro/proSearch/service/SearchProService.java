package kr.or.ddit.pro.proSearch.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import kr.or.ddit.vo.AdresVO;
import kr.or.ddit.vo.ProVO;
import kr.or.ddit.vo.SpcltyRealmVO;

@Service
public interface SearchProService {
	
	//프로전체 리스트 
	public List<ProVO> proList();
	
	//프로 리스트 검색, 페이징
	public List<ProVO> proListPage(Map<String, Object> map);

	//페이징 토탈
	public int getTotal(Map<String, Object> map);
	
	//서비스 대분류
	public List<SpcltyRealmVO> spcltyB();
	
	//서비스 하위분류
	public List<SpcltyRealmVO> spcltySec(String code);
	
	//내주변 프로
	public List<AdresVO> aroundPro();
	
	//이달의 프로
	public List<ProVO> getMonthPro(Map<String, Object> map);
	
	//서비스 이름
	public String spcltyNm(String code);



}
