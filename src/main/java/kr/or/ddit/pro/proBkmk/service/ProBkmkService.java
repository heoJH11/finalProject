package kr.or.ddit.pro.proBkmk.service;

import java.util.List;

import org.springframework.stereotype.Service;

import kr.or.ddit.vo.ProBkmkVO;

@Service
public interface ProBkmkService {
	
	//즐겨찾기
	public int proBkmkCreate(String proId, String mberId);
	//즐겨찾기 확인
	public String proBkmkCheck(String proId, String mberId);
	//즐겨찾기 삭제
	public int proBkmkDelete(String proId, String mberId);
	//즐겨찾기 목록
	public List<ProBkmkVO> getFavInfo(String memId);


}
