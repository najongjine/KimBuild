package com.open.ft;

import java.util.List;
import java.util.Properties;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.ehcache.EhCacheCacheManager;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.view.json.MappingJackson2JsonView;

import com.open.cmmn.service.CmmnService;
import com.open.cmmn.service.FileMngService;
import com.open.vo.BImgVO;
import com.open.vo.NoticeVO;

import egovframework.rte.fdl.property.EgovPropertyService;

/** 공지사항 게시판을 관리하는 컨트롤러 클래스를 정의한다.
 */
@Controller
public class FtMainController {

	@Resource(name = "cmmnService")
    protected CmmnService cmmnService;
	
	@Resource(name = "FileMngService")
    private FileMngService fileMngService;
    
	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;
	
	/** fileUploadProperties */
	@Resource(name = "fileUploadProperties")
	Properties fileUploadProperties;
	
	/**
	 * MappingJackson2JsonView.
	 */
	@Resource
	private MappingJackson2JsonView ajaxView;
	
	
    /** Program ID **/
    private final static String PROGRAM_ID = "Notice";

    /** folderPath **/
    private final static String folderPath = "/ft/main/";

	//@Resource(name = "beanValidator")
	//protected DefaultBeanValidator beanValidator;
	
    @Autowired
	private EhCacheCacheManager cacheManager;
    
	Logger log = Logger.getLogger(this.getClass());



	@SuppressWarnings("unchecked")
	@RequestMapping(folderPath +"main.do")
	public String view(@ModelAttribute("searchVO") NoticeVO searchVO, Model model, HttpServletRequest request) throws Exception {
		searchVO.setFirstIndex(0);
		searchVO.setRecordCountPerPage(4);
		/* 게시판 상세정보 */
		List<NoticeVO> noticeList= (List<NoticeVO>) cmmnService.selectList(searchVO, "Notice.selectList" );
		searchVO.setRecordCountPerPage(3);
		List<BImgVO> imgList1=(List<BImgVO>) cmmnService.selectList(searchVO, "BExample");
		List<BImgVO> imgList2=(List<BImgVO>) cmmnService.selectList(searchVO, "BReco");
		List<BImgVO> imgList3=(List<BImgVO>) cmmnService.selectList(searchVO, "BField");
		List<BImgVO> imgList4=(List<BImgVO>) cmmnService.selectList(searchVO, "BInte");
		model.addAttribute("noticeList", noticeList);
		model.addAttribute("imgList1", imgList1);
		model.addAttribute("imgList2", imgList2);
		model.addAttribute("imgList3", imgList3);
		model.addAttribute("imgList4", imgList4);
		return  "/ft/main";
	}

}

