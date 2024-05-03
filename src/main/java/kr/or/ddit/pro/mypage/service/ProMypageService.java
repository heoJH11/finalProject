package kr.or.ddit.pro.mypage.service;

import java.util.Map;

public interface ProMypageService {

	public int updProMbtlnum(Map<String, Object> map);

	public int updPW(Map<String, Object> map);

	public int updNcnm(Map<String, Object> map);

	public int updPhoto(Map<String, Object> map);

	public int photoDelete(String userId);

	public int updEmail(Map<String, Object> map);

	public int updNm(Map<String, Object> map);

	public int updAdres(Map<String, Object> map);
}
