package kr.or.ddit.board.pro_story.service;

import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartHttpServletRequest;

import kr.or.ddit.board.pro_story.vo.GoodPointVO;
import kr.or.ddit.board.pro_story.vo.ProStoryBbscttVO;

public interface ProStoryService {
	
	// 게시글 리스트
	public List<ProStoryBbscttVO> storyList();
	
	public List<ProStoryBbscttVO> getPage(Map<String, Object> searchParam);
	
	public int getTotal();

	// 게시글쓰기
	public int insert(ProStoryBbscttVO proStoryBbscttVO , MultipartHttpServletRequest multi);
	
	// 게시글 선택
	public ProStoryBbscttVO getStory(int storyNo);
	
	// 게시글 수정
	public int updateStory(ProStoryBbscttVO proStoryBbscttVO , MultipartHttpServletRequest multi);
	
	// 게시글 삭제
	public int deleteStory(String userId , int storyNo);
	
	// 게시글 조회수
	public int getStoryCount(int storyNo);

	// 게시글 좋아요
	public ProStoryBbscttVO updateGood(GoodPointVO goodPointVO);

	// 게시글 좋아요 취소
	public ProStoryBbscttVO goodRemove(GoodPointVO goodPointVO);

	// 좋아요 했는지 체크
	public int getGoodCheck(GoodPointVO goodPointVO);
	
	public List<ProStoryBbscttVO> getPageTest(Map<String, Object> map);
	
	// 메인페이지 추천수 정렬
	public List<ProStoryBbscttVO> getWeekRecommend();	

}
