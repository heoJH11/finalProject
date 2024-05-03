package kr.or.ddit.admin.notice.mapper;

import java.util.List;
import java.util.Map;

import kr.or.ddit.admin.notice.vo.NoticeVO;
import kr.or.ddit.vo.SprviseAtchmnflVO;

public interface NoticeMapper {

	public List<NoticeVO> getAllNoticeList();

	public NoticeVO detail(int noticeNo);

	public int update(NoticeVO noticeVO);

	public int delete(NoticeVO noticeVO);

	public int createPost(NoticeVO noticeVO);

	public int getTotal(Map<String, Object> map);

	public List<NoticeVO> list(Map<String, Object> map);

	public int insertSprvise(SprviseAtchmnflVO sprviseAtchmnflVO);

	public int increaseViewCount(int noticeNo);

	public NoticeVO sprviseAtchmnflVO(int noticeNo);

	

}
