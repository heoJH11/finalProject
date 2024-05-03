package kr.or.ddit.vo;

import java.util.Date;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;
@Getter
@Setter
@ToString
@NoArgsConstructor
public class SntncDeclVO {
	private int    rnum;
	private int declNo;
	private String declResn;
	private String declDetailCn;
	private String userId;
	private String userId2;
	private int declProcessAt;
	private String declProcessResult;
	private Date declRceptDe;
	private int sprviseAtchmnflNo;
	private int punshNo;
	private int declBbscttNo;
	private int declAnswerNo;
	private String declTarget;
	private int count;
}
