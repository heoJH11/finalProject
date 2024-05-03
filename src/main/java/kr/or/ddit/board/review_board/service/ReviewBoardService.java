package kr.or.ddit.board.review_board.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.vo.SprviseAtchmnflVO;
import kr.or.ddit.vo.AftusBbscttAnswerVO;
import kr.or.ddit.vo.AftusBbscttVO;
import kr.or.ddit.vo.SrvcRequstVO;

public interface ReviewBoardService {
	
	//후기 조회
	public List<AftusBbscttVO> list(Map<String, Object> map);
	
	//후기 작성 가능한 완료 서비스 조회
	public List<SrvcRequstVO> listModal(String userId);
	
	//로그인한 회원 리뷰 조회
	public List<AftusBbscttVO> listMyReview(String userId);

	//후기 작성
	public int create(AftusBbscttVO aftusBbscttVO);

	public AftusBbscttVO detail(int aftusBbscttNo);

	public int delete(int aftusBbscttNo);

	public int createAjax(AftusBbscttVO aftusBbscttVO);

	public int update(AftusBbscttVO aftusBbscttVO);

	public int updateCnt(int aftusBbscttNo);

	public List<SprviseAtchmnflVO> fileList(int sprviseAtchmnflNo);

	public int fileDel(SprviseAtchmnflVO sprviseAtchmnflVO);

	public int getTotal(Map<String, Object> map);

	public List<AftusBbscttAnswerVO> aftusBbscttAnswerList(int aftusBbscttNo);

	public int aftusBbscttAnswerInsert(AftusBbscttAnswerVO aftusBbscttAnswerVO);

	public int aftusBbscttAnswerDelete(int aftusBbscttAnswerNo);

	public int aftusBbscttAnswerUpdate(AftusBbscttAnswerVO aftusBbscttAnswerVO);

	public List<AftusBbscttAnswerVO> ansAnsList(int ptAftusBbscttAnswerNo);

	public int ansAnsInt(AftusBbscttAnswerVO aftusBbscttAnswerVO);

	public int ansAnsCnt(int ptAftusBbscttAnswerNo);

	
	
}
