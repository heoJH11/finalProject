package kr.or.ddit.pro.proBkmk.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.or.ddit.vo.ProBkmkVO;

public interface ProBkmkMapper {
	
	public int proBkmkCreate(@Param("proId") String proId, @Param("mberId") String mberId);

	public String proBkmkCheck(@Param("proId") String proId, @Param("mberId") String mberId);

	public int proBkmkDelete(@Param("proId") String proId, @Param("mberId") String mberId);

	public List<ProBkmkVO> getFavInfo(String memId);
}
