package kr.or.ddit.admin.oneInqry.service;

import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.vo.OneInqryVO;
import kr.or.ddit.vo.UsersVO;

public interface OneInqryService {
	
	public UsersVO userChk(String userId);

	public List<OneInqryVO> searchList(Map<String, Object> map);

	public int getTotal(Map<String, Object> map);

	public List<OneInqryVO> oneInqryNoAnswerList(Map<String, Object> map);

	public int getNoAnswerTotal(Map<String, Object> map);

	public List<OneInqryVO> oneInqrySuccessList(Map<String, Object> map);

	public int getSuccessTotal(Map<String, Object> map);

	public int oneInqryCreatePost(OneInqryVO oneInqryVO, List<MultipartFile> uploadFiles);

	public OneInqryVO oneInqryDetail(OneInqryVO oneInqryVO, String userId);

	public int oneInqryUpdatePost(Map<String, Object> oneInqryUpdateMap, List<MultipartFile> uploadFiles,
			String userId);

	public int updateAnswer(Map<String, Object> updateParamMap, String userId);

	public int resignPro(Map<String, Object> map);

	public List<OneInqryVO> resignProList(Map<String, Object> map);

	public int getTotalResignPro(Map<String, Object> map);

	public int proSecssion(String proId);

}
