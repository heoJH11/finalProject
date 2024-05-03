package kr.or.ddit.util.fileupload.mapper;

import java.util.List;
import java.util.Map;

import kr.or.ddit.vo.SprviseAtchmnflVO;


public interface FileuploadMapper {

	public int fileupload(Map<String, Object> fileMap);

	public List<SprviseAtchmnflVO> getsprviseAtchmnfl(int sprviseAtchmnflNo);

	public int updateFileupload(Map<String, Object> updateFileuploadMap);

	public int newFileupload(SprviseAtchmnflVO sprviseAtchmnflVO);
}
