package kr.or.ddit.todaymeeting.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import kr.or.ddit.todaymeeting.VChatRoom;
import kr.or.ddit.vo.TdmtngChSpMshgVO;
import kr.or.ddit.vo.TdmtngPrtcpntVO;
import kr.or.ddit.vo.TdmtngVO;
import kr.or.ddit.vo.UsersVO;

public interface TodayMeetingMapper {
	
	//모임 캘린더 조회
	public List<TdmtngVO> findAll(String userId);
	
	//모임 캘린더 리스트 조회
	public List<TdmtngVO> list(Map<String, Object> map);
	
	//모임 상세 조회
	public TdmtngVO detail(int tdmtngNo);
	
	//모임 생성
	public int create(TdmtngVO tdmtngVO);
	
	//모임 수정
	public int update(TdmtngVO tdmtngVO);
	
	//모임 삭제
	public int delete(int tdmtngNo);

	public TdmtngPrtcpntVO selectMyChat(TdmtngPrtcpntVO tdmtngPrtcpntVO);
	
	public int getTotal(Map<String, Object> map);

	public int joinChat(TdmtngPrtcpntVO tdmtngPrtcpntVO);

	public int chatMemCount(int tdmtngNo);

	public List<TdmtngPrtcpntVO> chatMemList(int tdmtngNo);
	
	////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/**
	* 새로 추가
	* @param userId
	* @return
	*/
	public List<VChatRoom> myList(String userId);
	
	public VChatRoom join( @Param("tdmtngNo")int tdmtngNo ,
						   @Param("userId") String userId );

	public List<TdmtngChSpMshgVO> scrollTest(Map<String, Object> map);

	public int getTotalMsg(int tdmtngNo);

	public List<UsersVO> getUserInfo(String userId);

	public int updateFirstMSG(TdmtngVO tdmtngVO);
	
	

}
