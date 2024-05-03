package kr.or.ddit.pro.proProfl.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.ddit.pro.proProfl.mapper.ProProflMapper;
import kr.or.ddit.pro.proProfl.service.ProProflService;
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
import lombok.extern.slf4j.Slf4j;

@Service
public class ProProflServiceImpl implements ProProflService {
	
	@Autowired
	ProProflMapper proProflMapper;

	@Override
	public List<BcityVO> list(Map<String, Object> map) {
		return proProflMapper.list(map);
	}
	@Override
	public List<VCityVO> getBrtcList(String bcityNm) {
		return proProflMapper.getBrtcList(bcityNm);
	}

	@Override
	public int createPost(ProProflVO proProflVO) {
	   return proProflMapper.createPost(proProflVO);
	}

	@Override
	public ProProflVO detail(String proId) {
		return proProflMapper.detail(proId);
	}

	@Override
	public String bcCode(String bcityNm) {
		return proProflMapper.bcCode(bcityNm);
	}

	@Override
	public String btCode(String bcityNm,String brtcNm) {
		return this.proProflMapper.btCode(bcityNm,brtcNm);
	}
	@Override
	public VProUsersVO getProInfo(String proId) {
		return this.proProflMapper.getProInfo(proId);
	}
	@Override
	public ProProflVO getProId(String sessionId) {
		return this.proProflMapper.getProId(sessionId);
	}

	@Override
	public List<VPrtfolioVO> prtTumb(String proId) {
		return this.proProflMapper.prtTumb(proId);
	}
	@Override
	public List<SprviseAtchmnflVO> portfolioPicture(String sprviseAtchmnflNo) {
		return this.proProflMapper.portfolioPicture(sprviseAtchmnflNo);
	}
	@Override
	public int modify(ProProflVO proProflVO) {
		return this.proProflMapper.modify(proProflVO);
	}
	@Override
	public String getBcityNm(String bcityCode) {
		return this.proProflMapper.getBcityNm(bcityCode);
	}
	@Override
	public String getBrtcNm(String brtcCode) {
		return this.proProflMapper.getBrtcNm(brtcCode);
	}
	@Override
	public String getBunryu(String spcltyRealmCode) {
		return this.proProflMapper.getBunryu(spcltyRealmCode);
	}
	@Override
	public int getSrvcCount(String proId) {
		return this.proProflMapper.getSrvcCount(proId);
	}
	@Override
	public int getRevCount(String proId) {
		return this.proProflMapper.getRevCount(proId);
	}
	@Override
	public int getRevCnt2(Map<String, Object> map) {
		return this.proProflMapper.getRevCnt2(map);
	}
	@Override
	public int getBkmkCount(String proId) {
		return this.proProflMapper.getBkmkCount(proId);
	}
	@Override
	public List<ReviewVO> getReview(Map<String, Object> map) {
		return this.proProflMapper.getReview(map);
	}
	//동균 신고 추가
	@Override
	public List<CommonCdDetailVO> declComCdDeSelect() {
		return this.proProflMapper.declComCdDeSelect();
	}
	
	@Transactional
	@Override
	public int declInsert(UserDeclVO userDeclVO) {
		
		int result = 0;
		result += this.proProflMapper.declInsert(userDeclVO);
		result += this.proProflMapper.declUpdate(userDeclVO);
		
		return result;
		
		
	}
	//동균 신고 끝








}
