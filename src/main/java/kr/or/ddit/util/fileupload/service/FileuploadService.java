package kr.or.ddit.util.fileupload.service;

import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.vo.SprviseAtchmnflVO;

public interface FileuploadService {

	public int fileUpload(List<MultipartFile> uploadFiles, String addPath, String userId, int res);
	
	public List<SprviseAtchmnflVO> getsprviseAtchmnfl(int sprviseAtchmnflNo);

	public int updateFileupload(Map<String, Object> updateFileuploadMap);

	public int newFileUpload(List<MultipartFile> uploadFiles, String addPath, String userId, int res, String sprviseAtchmnflNo);
}
