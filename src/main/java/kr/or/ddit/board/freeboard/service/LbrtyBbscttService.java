package kr.or.ddit.board.freeboard.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.vo.CommonCdDetailVO;
import kr.or.ddit.vo.LbrtyBbscttAnswerVO;
import kr.or.ddit.vo.LbrtyBbscttAnswerVO2;
import kr.or.ddit.vo.LbrtyBbscttVO;
import kr.or.ddit.vo.LbrtyBbscttVO2;
import kr.or.ddit.vo.SntncDeclVO;
import kr.or.ddit.vo.SprviseAtchmnfl;

public interface LbrtyBbscttService {

	public List<LbrtyBbscttVO2> lbrtyBbscttList();

	public LbrtyBbscttVO lbrtyBbscttDetail(int lbrtyBbscttNo);

	public int lbrtyBbscttDelete(LbrtyBbscttVO lbrtyBbscttVO);
	
	public int lbrtyBbscttInsert(LbrtyBbscttVO lbrtyBbscttVO);

	public List<LbrtyBbscttAnswerVO> lbrtyBbscttAnswerList(String lbrtyBbscttNo);

	public int lbrtyBbscttAnswerInsert(LbrtyBbscttAnswerVO lbrtyBbscttAnswerVO);

	public int lbrtyBbscttAnswerDelete(LbrtyBbscttAnswerVO lbrtyBbscttAnswerVO);

	public int lbrtyBbscttAnswerUpdate(LbrtyBbscttAnswerVO lbrtyBbscttAnswerVO);

	public int lbrtyBbscttUpdate(LbrtyBbscttVO lbrtyBbscttVO);

	public List<LbrtyBbscttAnswerVO2> ansAnsList(LbrtyBbscttAnswerVO lbrtyBbscttAnswerVO);

	public int ansAnsInt(LbrtyBbscttAnswerVO lbrtyBbscttAnswerVO);

	public int ansAnsCnt(LbrtyBbscttAnswerVO lbrtyBbscttAnswerVO);

	public List<SprviseAtchmnfl> sprviseAtchmnflDetail(int sprviseAtchmnflNo);

	public int fileDel(SprviseAtchmnfl sprviseAtchmnfl);

	public List<SprviseAtchmnfl> detailfileList(String sprviseAtchmnflNo);

	public List<LbrtyBbscttVO2> lbrtyBbscttListPage(Map<String, Object> map);

	public int getTotal(Map<String, Object> map);

	public int declInsert(SntncDeclVO sntncDeclVO);

	public List<CommonCdDetailVO> declComCdDeSelect();

	public int cntUp(int lbrtyBbscttNo);

}
