package kr.or.ddit.admin.oneInqry.mapper;

import java.util.List;
import java.util.Map;

import kr.or.ddit.vo.OneInqryVO;

public interface OneInqryMapper {

	public List<OneInqryVO> searchList(Map<String, Object> map);
	
	public List<OneInqryVO> oneInqryNoAnswerList(Map<String, Object> map);
	
	public List<OneInqryVO> oneInqrySuccessList(Map<String, Object> map);
	
	public int getTotal(Map<String, Object> map);
	
	public int getNoAnswerTotal(Map<String, Object> map);
	
	public int getSuccessTotal(Map<String, Object> map);

	public int oneInqryCreatePost(Map<String, Object> oneInqryInfoMap);

	public OneInqryVO oneInqryDetail(OneInqryVO oneInqryVO);

	public int oneInqryUpdatePost(OneInqryVO oneInqryVO);
	
	public String userType(String userId);

	public int updateAnswer(Map<String, Object> updateParamMap);

	public int resignPro(Map<String, Object> map);

	public int getTotalResignPro(Map<String, Object> map);

	public List<OneInqryVO> resignProList(Map<String, Object> map);

	public int proSecssion(String proId);
	

}
