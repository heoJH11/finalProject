package kr.or.ddit.pro.proProfl.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import kr.or.ddit.vo.AdresVO;
import kr.or.ddit.vo.BcityVO;
import kr.or.ddit.vo.CommonCdDetailVO;
import kr.or.ddit.vo.ProProflVO;
import kr.or.ddit.vo.ReviewVO;
import kr.or.ddit.vo.SprviseAtchmnflVO;
import kr.or.ddit.vo.UserDeclVO;
import kr.or.ddit.vo.VCityVO;
import kr.or.ddit.vo.VProUsersVO;
import kr.or.ddit.vo.VPrtfolioVO;

@Service
public interface ProProflService {
	//광역시 리스트 받아오기
	public List<BcityVO> list(Map<String, Object> map);
	//선택한 광역시의 시군구 받아오기
	public List<VCityVO> getBrtcList(String bcityNm);
	//광역시 코드 가져오기
	public String bcCode(String bcityNm);
	//시군구 코드 가져오기
	public String btCode(String bcityNm,String brtcNm);
	//프로프로필 넣기
	public int createPost(ProProflVO proProflVO);
	//프로프로필 보기
	public ProProflVO detail(String proId);
	//프로 정보 가져오기
	public VProUsersVO getProInfo(String proId);
	//프로필을 가지고있는 프로아이디 
	public ProProflVO getProId(String sessionId);
	//포트폴리오 썸네일 데려오기
	public List<VPrtfolioVO> prtTumb(String proId);
	//포트폴리오 데려오기
	public List<SprviseAtchmnflVO> portfolioPicture(String sprviseAtchmnflNo);
	//프로 프로필 수정하기
	public int modify(ProProflVO proProflVO);
	//프로필 지역 코드->이름
	public String getBcityNm(String bcityCode);
	public String getBrtcNm(String brtcCode);
	//프로 분류
	public String getBunryu(String spcltyRealmCode);
	
	//고용,리뷰,즐찾 수 
	public int getSrvcCount(String proId);
	public int getRevCount(String proId);
	public int getBkmkCount(String proId);
	
	//리뷰
	public List<ReviewVO> getReview(Map<String, Object> map);
	//리뷰토탈수
	public int getRevCnt2(Map<String, Object> map);

	
	//동균 신고
	//동균 신고 유형
	public List<CommonCdDetailVO> declComCdDeSelect();
	
	//동균 신고 하기
	public int declInsert(UserDeclVO userDeclVO);
	//동균 신고 끝



}
