package kr.or.ddit.pro.prtFolio.mapper;

import kr.or.ddit.vo.PrtfolioVO;
import kr.or.ddit.vo.SprviseAtchmnflVO;

public interface PrtfolioMapper {

	public int createPost(PrtfolioVO prtfolioVO);

	public int insertSprvise(SprviseAtchmnflVO sprviseAtchmnflVO);

	public int deletePrt(int sprviseAtchmnflNo);

}
