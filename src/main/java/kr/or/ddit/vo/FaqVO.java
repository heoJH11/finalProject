package kr.or.ddit.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class FaqVO {
	private int faqNo;
	private String faqQestn;
	private String faqAnswer;
	private String mngrId;
}
