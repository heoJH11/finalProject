package kr.or.ddit.onedayclass.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.vo.BcityVO;
import kr.or.ddit.vo.BrtcVO;
import kr.or.ddit.vo.BundleOndyclVO;
import kr.or.ddit.vo.MberVO;
import kr.or.ddit.vo.OndyclReviewVO;
import kr.or.ddit.vo.OndyclVO;
import kr.or.ddit.vo.ReviewMberVO;
import kr.or.ddit.vo.ShopngBundleVO;
import kr.or.ddit.vo.SpcltyRealmVO;
import kr.or.ddit.vo.SprviseAtchmnflVO;
import kr.or.ddit.vo.UserNcnmMberPhotoVO;
import kr.or.ddit.vo.VOndyclProUsersVO;
import kr.or.ddit.vo.VOndyclSchdulVO;

public interface OnedayClassService {

	public List<VOndyclProUsersVO> vOndyclProUsersVOList();

	public int countOndycl();

	public String getCodeNm(String codeCd);

	public List<VOndyclProUsersVO> searchClass(Map<String, Object> searchMap);

	public List<SpcltyRealmVO> category();

	public List<BcityVO> getBcity();

	public List<BrtcVO> brtcSelect(String bcityCode);

	public VOndyclProUsersVO detail(String ondyclNo);

	public int getAttachNo();

	public int addSprviseAtchmnfl(SprviseAtchmnflVO sprviseAtchmnflVO);

	public int createOndycl(Map<String, Object> map);

	public List<SprviseAtchmnflVO> fileList(String ondyclNo);

	public int getInsertClNum();

	public int deleteClass(String classNO);

	public int updateOndycl(VOndyclSchdulVO vOndyclSchdulVO);

	public int buyClass(Map<String, Object> map);

	public List<VOndyclProUsersVO> memberOndyclList(Map<String, Object> map);

	public int countMberMyClass(Map<String, Object> map);

	public List<VOndyclProUsersVO> proMyClassList(Map<String, Object> map);

	public int countProMyClass(Map<String, Object> map);

	public int resveCheck(Map<String, Object> mberOndyclMap);

	public int mberClassCancel(Map<String, Object> map);

	public String mberReviewTitle(int ondyclNo);

	public int createReview(OndyclReviewVO ondyclReviewVO);

	public List<ReviewMberVO> reviewList(int ondyclNo);

	public List<BundleOndyclVO> mberShoppingCart(Map<String, Object> map);

	public int countShoppingCart(Map<String, Object> map);

	public int putShoppingCart(ShopngBundleVO shopngBundleVO);

	public int classBundleCk(Map<String, Object> mberOndyclMap);

	public VOndyclSchdulVO priceCk(int ondyclNo);

	public int delBundle(Map<String, Object> map);

	public int buyBundle(Map<String, Object> map);

	public int getTotalPrice(Map<String, Object> map);

	public double getTotalStar(Map<String, Object> map);

	public int getTotalUser(Map<String, Object> map);

	public int getMonthTotalUser(Map<String, Object> map);

	public int getMonthTotalPrice(Map<String, Object> map);

	public List<UserNcnmMberPhotoVO> getBuyer(String ondyclNo);

	public List<OndyclVO> getOndyclRank();

	public String getPeopleCheck(int ondyclNo);

}
