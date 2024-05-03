package kr.or.ddit.vo;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class TdmtngVO {
	
	private int rnum;
	private int tdmtngNo;
	private String tdmtngNm;
	@DateTimeFormat(pattern="yyyy-MM-dd'T'HH:mm")
	private String tdmtngCreatDt;
	//Field error in object 'tdmtngVO' on field 'tdmtngDt': rejected value [2024-03-14]; codes [typeMismatch.tdmtngVO.tdmtngDt,typeMismatch.tdmtngDt,typeMismatch.java.util.Date,typeMismatch]; arguments [org.springframework.context.support.DefaultMessageSourceResolvable: codes [tdmtngVO.tdmtngDt,tdmtngDt]; arguments []; default message [tdmtngDt]]; default message [Failed to convert property value of type 'java.lang.String' to required type 'java.util.Date' for property 'tdmtngDt'; nested exception is org.springframework.core.convert.ConversionFailedException: Failed to convert from type [java.lang.String] to type [java.util.Date] for value '2024-03-14'; nested exception is java.lang.IllegalArgumentException]]
	//DateTimeFormat을 안 해줬음
	@DateTimeFormat(pattern="yyyy-MM-dd'T'HH:mm")
	private String tdmtngDt;
	private String tdmtngCn;
	private String userId;
	private String tdmtngThumbPhoto;
	private int tdmtngMax;
	private String UserNcnm;
	private String mberProflPhoto;
	private String proProflPhoto;
	
	private String firstMsg;
	
	private MultipartFile uploadFile;

	
}
