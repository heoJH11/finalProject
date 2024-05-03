package kr.or.ddit.vo;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@NoArgsConstructor
public class OndyclSchdulVO {

	private int ondyclSchdulNo; //원데이클래스 일정번호
	private int ondyclNo; //원데이클래스 글번호
	private String ondyclSchdulDe; //원데이클래스 일정 날짜("20240303")
	private String ondyclSchdulBeginTime; //원데이클래스 시작시간("15:00") 
	private String ondyclSchdulEndTime; //원데이클래스 종료시간("21:00")
}

