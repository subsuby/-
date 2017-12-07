package com.bnk.plus.web.common;

import java.io.File;
import java.io.IOException;
import java.net.URLEncoder;

import javax.annotation.PostConstruct;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.PropertySource;
import org.springframework.context.annotation.PropertySources;
import org.springframework.core.env.Environment;
import org.springframework.core.io.FileSystemResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bnk.plus.commons.components.CoTopComponent;
import com.bnk.plus.config.AppConstBean;
import com.bnk.plus.entity.T2File;
import com.bnk.plus.service.common.persistence.commons.api.FileMapper;


@Controller
@PropertySources(value = {@PropertySource(value=AppConstBean.APP_CONFIG_PROPERTIES_PATH)})
public class ImageDownloadController extends CoTopComponent  {

	@Autowired FileMapper fileMapper;

	@Resource private Environment env;
	private String RESOURCE_PUBLIC_PATH_PREFIX;
	@PostConstruct
	public void setResourcePathPrefix(){
		RESOURCE_PUBLIC_PATH_PREFIX = env.getProperty("common.public_upload_real_path");
	}


	/**
	 * <pre>
	 * 함수명칭: imageViewByFileSeq
	 * 기 능:	/차량코드/차량고유번호/파일고유번호/이미지종류 순으로 입력시 이미지 표출
	 * 			imageType :
	 * 				1 - PC 이미지
	 * 				2 - PC 썸네일
	 * 				3 - 모바일 이미지
	 * 				4 - 모바일 썸네일
	 * 출 력:
	 * 입 력:
	 * 작성자: hk-lee
	 * 작성일자: 2017. 6. 1.
	 * 수정이력:
	 * 	2017.06.13 jy-seo
	 * 	  - 공통으로 responseEntity를 셋팅해주는 함수 추가
	 * 	  - 리스트에서 출력할 썸네일 이미지뷰 API 추가
	 * </pre>
	 */
	/*@ResponseBody
	@RequestMapping(value={"/11image/{carCode}/{carSeq}/{fileSeq}/{imageType}"}, method={RequestMethod.GET})
	public ResponseEntity<FileSystemResource> imageViewByFileSeq(
			@PathVariable("carCode") final String carCode,
			@PathVariable("carSeq") final String carSeq,
			@PathVariable("fileSeq") final String fileSeq,
			@PathVariable("imageType") final String imageType,
			HttpServletRequest req,
			HttpServletResponse res) throws IOException{

		T2File file = fileMapper.getFileInfo(fileSeq);
		return responseEntitySet(req, fileSeq+"_"+imageType, new Object[]{ carCode, carSeq, fileSeq, imageType, file.getFileExt()});
	}

	@ResponseBody
	@RequestMapping(value={"/11image/{carCode}/{carSeq}/{imageType}"}, method={RequestMethod.GET})
	public ResponseEntity<FileSystemResource> listItemThumImage(
			@PathVariable("carCode") final String carCode,
			@PathVariable("carSeq") final String carSeq,
			@PathVariable("imageType") final String imageType,
			HttpServletRequest req,
			HttpServletResponse res) throws IOException{

		T2File param = new T2File();
		param.setFileGroupId(carSeq);
		T2File file = fileMapper.getFirstFileInfoByGroupId(param);
		return responseEntitySet(req, file.getFileSeq()+"_"+imageType,
				new Object[]{ carCode, carSeq, file.getFileSeq(), imageType, file.getFileExt()});
	}


	public ResponseEntity<FileSystemResource> responseEntitySet(HttpServletRequest req, String origNm, Object[] arguments) throws IOException{
		FileSystemResource fileSystemResource = null;
		HttpStatus httpStatus = null;
		HttpHeaders responseHeaders = new HttpHeaders();

		String fullLogiPath = MessageFormat.format(RESOURCE_PUBLIC_PATH_PREFIX, arguments);

		File imageFile = new File(fullLogiPath);
		if(imageFile.exists() && imageFile.length() > 0){
			// PNG
			if (MediaType.IMAGE_PNG_VALUE.indexOf((String)arguments[4]) != -1){
				responseHeaders.setContentType(MediaType.IMAGE_PNG);
				httpStatus = HttpStatus.OK;
				fileSystemResource = new FileSystemResource(imageFile);
			}
			// JPEG
			else if (MediaType.IMAGE_JPEG_VALUE.indexOf((String)arguments[4]) != -1 || "jpg".equalsIgnoreCase((String)arguments[4])){
				responseHeaders.setContentType(MediaType.IMAGE_JPEG);
				httpStatus = HttpStatus.OK;
				fileSystemResource = new FileSystemResource(imageFile);
			}
			// GIF
			else if (MediaType.IMAGE_GIF_VALUE.indexOf((String)arguments[4]) != -1){
				responseHeaders.setContentType(MediaType.IMAGE_GIF);
				httpStatus = HttpStatus.OK;
				fileSystemResource = new FileSystemResource(imageFile);
			}
			// 이미지 타입이 아닐 경우
			else {
				httpStatus = HttpStatus.NOT_FOUND;
			}
			//파일 인코딩
			String downName = "";
			String browser = req.getHeader("User-Agent");
			if(browser.contains("MSIE") || browser.contains("Trident") || browser.contains("Chrome")){
				downName = URLEncoder.encode(origNm,"UTF-8").replaceAll("\\+", "%20");
			} else {
				downName = new String(origNm.getBytes("UTF-8"), "ISO-8859-1");
			}
			responseHeaders.add(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=" + downName + "." + arguments[4]);
			responseHeaders.add(HttpHeaders.CONTENT_LENGTH, Long.toString(fileSystemResource.contentLength()));
		}
		// 파일이 없을 경우 404 return
		else {
			httpStatus = HttpStatus.NOT_FOUND;
		}

		return new ResponseEntity<FileSystemResource>(fileSystemResource, responseHeaders, httpStatus);
	}*/

	@ResponseBody
	@RequestMapping(value={"/mycar/img/{fileSeq}"}, method={RequestMethod.GET})
	public ResponseEntity<FileSystemResource> myCarImageView(
			@PathVariable("fileSeq") final String fileSeq,
			HttpServletRequest req, HttpServletResponse res) throws Exception{
		if(isEmpty(fileSeq)) {
			throw new Exception("Sorry we cannot process your request.");
		}
		T2File file = fileMapper.getFileInfo(fileSeq);
		if(file == null) {
			throw new Exception("Sorry we cannot process your request.");
		}
		return responseEntitySet(req, file.getOrigNm(), file);
	}

	public ResponseEntity<FileSystemResource> responseEntitySet(HttpServletRequest req, String origNm, T2File file) throws IOException{
		FileSystemResource fileSystemResource = null;
		HttpStatus httpStatus = null;
		HttpHeaders responseHeaders = new HttpHeaders();

		String logiPath = file.getLogiPath();
		String logiNm = file.getLogiNm();
		String ext = file.getFileExt();
		String fullLogiPath = logiPath + "/" + logiNm + "." + ext;

		File imageFile = new File(fullLogiPath);
		if(imageFile.exists() && imageFile.length() > 0){
			// PNG
			if (MediaType.IMAGE_PNG_VALUE.indexOf(ext) != -1){
				responseHeaders.setContentType(MediaType.IMAGE_PNG);
				httpStatus = HttpStatus.OK;
				fileSystemResource = new FileSystemResource(imageFile);
			}
			// JPEG
			else if (MediaType.IMAGE_JPEG_VALUE.indexOf(ext) != -1 || "jpg".equalsIgnoreCase(ext)){
				responseHeaders.setContentType(MediaType.IMAGE_JPEG);
				httpStatus = HttpStatus.OK;
				fileSystemResource = new FileSystemResource(imageFile);
			}
			// GIF
			else if (MediaType.IMAGE_GIF_VALUE.indexOf(ext) != -1){
				responseHeaders.setContentType(MediaType.IMAGE_GIF);
				httpStatus = HttpStatus.OK;
				fileSystemResource = new FileSystemResource(imageFile);
			}
			// 이미지 타입이 아닐 경우
			else {
				httpStatus = HttpStatus.NOT_FOUND;
			}
			//파일 인코딩
			String downName = "";
			String browser = req.getHeader("User-Agent");
			if(browser.contains("MSIE") || browser.contains("Trident") || browser.contains("Chrome")){
				downName = URLEncoder.encode(origNm,"UTF-8").replaceAll("\\+", "%20");
			} else {
				downName = new String(origNm.getBytes("UTF-8"), "ISO-8859-1");
			}
			responseHeaders.add(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=" + downName + "." + ext);
			responseHeaders.add(HttpHeaders.CONTENT_LENGTH, Long.toString(fileSystemResource.contentLength()));
		}
		// 파일이 없을 경우 404 return
		else {
			httpStatus = HttpStatus.NOT_FOUND;
		}

		return new ResponseEntity<FileSystemResource>(fileSystemResource, responseHeaders, httpStatus);
	}

}