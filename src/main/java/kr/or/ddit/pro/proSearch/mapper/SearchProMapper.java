package kr.or.ddit.pro.proSearch.mapper;

import java.util.List;
import java.util.Map;

import kr.or.ddit.vo.AdresVO;
import kr.or.ddit.vo.ProVO;
import kr.or.ddit.vo.SpcltyRealmVO;

public interface SearchProMapper {


	public List<ProVO> proList();

	public List<ProVO> proListPage(Map<String, Object> map);

	public int getTotal(Map<String, Object> map);

	public List<SpcltyRealmVO> spcltyB();

	public List<AdresVO> aroundPro();
	
	public List<ProVO> getMonthPro(Map<String, Object> map);

	public List<SpcltyRealmVO> spcltySec(String code);

	public String spcltyNm(String code);

}
