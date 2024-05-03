package kr.or.ddit.pro.proProfl.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

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


public interface ProProflMapper {

	
	public List<BcityVO> list(Map<String, Object> map);
	
	public List<VCityVO> getBrtcList(String bcityNm);

	public int createPost(ProProflVO proProflVO);

	public String bcCode(String bcityNm);

	public String btCode(@Param("bcityNm")String bcityNm,@Param("brtcNm")String brtcNm);

	public ProProflVO detail(String proId);

	public VProUsersVO getProInfo(String proId);

	public ProProflVO getProId(String sessionId);

	public List<VPrtfolioVO> prtTumb(String proId);

	public List<SprviseAtchmnflVO> portfolioPicture(String sprviseAtchmnflNo);

	public int modify(ProProflVO proProflVO);

	public String getBcityNm(String bcityCode);

	public String getBrtcNm(String brtcCode);

	public String getBunryu(String spcltyRealmCode);

	public int getSrvcCount(String proId);

	public int getRevCount(String proId);
	
	public int getBkmkCount(String proId);
	
	public List<ReviewVO> getReview(Map<String, Object> map);
	public int getRevCnt2(Map<String, Object> map);
	
	
	//동균 신고로 인해 추가
	public List<CommonCdDetailVO> declComCdDeSelect();

	public int declInsert(UserDeclVO userDeclVO);

	public int declUpdate(UserDeclVO userDeclVO);
	////동균 신고로 인해 추가 끝









}
