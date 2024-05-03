package kr.or.ddit.board.pro_story.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import kr.or.ddit.board.pro_story.vo.GoodPointVO;
import kr.or.ddit.board.pro_story.vo.ProStoryBbscttVO;

public interface ProStoryMapper {

	// 게시글 리스트
	public List<ProStoryBbscttVO> storyList();

	// 게시글 선택
	public ProStoryBbscttVO getStory(int storyNo);

	// 게시글쓰기
	public int insert(ProStoryBbscttVO proStoryBbscttVO);
	
	// 게시글 수정
	public int updateStory(ProStoryBbscttVO proStoryBbscttVO);
	
	// 게시글 삭제
	public int deleteStory(@Param("proId") String userId , @Param("proStoryBbscttNo") int storyNo);
	
	// 게시글 조회수
	public int getStoryCount(@Param("proStoryBbscttNo") int storyNo);
	
	// 게시글 좋아요 수
	public ProStoryBbscttVO goodCount(ProStoryBbscttVO psbcttVO);

	// 게시글 좋아요
	public int goodSave(GoodPointVO goodPointVO);
	// 좋아요 -> 게시판에 반영
	public int goodUp(ProStoryBbscttVO psbcttVO);
	
	// 게시글 좋아요 취소
	public int goodRemove(GoodPointVO goodPointVO);
	// 좋아요 취소 -> 게시판에 반영
	public int goodDown(ProStoryBbscttVO psbcttVO);

	// 게시글 전체수
	public int getTotal();
	
	// 페이징 -> 더보기
	public List<ProStoryBbscttVO> getPage(Map<String, Object> searchParam);

	// 좋아요 했는지 체크
	public int getGoodCheck(GoodPointVO goodPointVO);

	// 페이징 일반 페이징으로
	public List<ProStoryBbscttVO> getPageTest(Map<String, Object> map);

	// 일주일내 추천수 상위 4개 게시물
	public List<ProStoryBbscttVO> getWeekRecommend();
	
}