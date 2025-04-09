package com.yojulab.study_springboot.controller.sample;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.yojulab.study_springboot.utils.Commons;

import java.util.HashMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;

@Controller
@RequestMapping("/files")
public class FilesController {
    @Value("${remote.server.url}")
    private String remoteServerUrl;

    @Value("${root.file.folder}")
    private String rootFileFolder;

    @Autowired
    Commons commons;

    @RequestMapping(value = { "/form" }, method = RequestMethod.GET)
    public ModelAndView form(@RequestParam Map<String, Object> params, ModelAndView modelAndView) {
        String viewName = "/WEB-INF/sample/views/files/form.jsp";
        modelAndView.setViewName(viewName);
        return modelAndView;
    }

     @RequestMapping(value = { "/insert" }, method = RequestMethod.POST)
    public ModelAndView insert(
        @RequestParam(value="multipartFile", required=false) MultipartFile multipartFile,
        @RequestParam Map<String, Object> params, ModelAndView modelAndView) throws IOException {

        // 폴더 생성
        String storePath = "";
        
        Map<String, Object> attachfile = null;
        if (multipartFile != null && !multipartFile.isEmpty()){
            String fileUnique = commons.getUniqueSequence();
            // 실제 경로부분-------------
            storePath = Paths.get(rootFileFolder + fileUnique).toString();
            commons.makeFolder(storePath);
            String originalFilename = multipartFile.getOriginalFilename();
            String storePathFileName = storePath + File.separator + originalFilename;
            multipartFile.transferTo(new File(storePathFileName));
            // ---------------
            // 파일 저장 시 중복 유의
            attachfile = new HashMap<String, Object>();

            attachfile.put("FILE_UNIQUE", fileUnique);
            attachfile.put("FILE_NAME", originalFilename);
        }
        // 각 정보를 DB에 저장 필요

        modelAndView.addObject("title", params.get("title"));
        modelAndView.addObject("content", params.get("content"));

        modelAndView.addObject("remoteServerUrl", remoteServerUrl);
        modelAndView.addObject("storePath", storePath);
        modelAndView.addObject("attachfile", attachfile);

        String viewName = "/WEB-INF/sample/views/files/update.jsp";
        modelAndView.setViewName(viewName);
        return modelAndView;
    }

     @RequestMapping(value = { "/update" }, method = RequestMethod.POST)
    public ModelAndView update(@RequestParam(value="multipartFile", required=false) MultipartFile multipartFile,
            @RequestParam Map<String, Object> params, ModelAndView modelAndView) throws IOException {

        // 폴더 생성
        String storePath = "";
        
        Map attachfile = null;
        if (multipartFile != null && !multipartFile.isEmpty()){      // 값이 있다는 것은 수정 의미
            storePath = (String) params.get("storePath");
            String fileUnique = (String) params.get("fileUnique");

            commons.makeFolder(storePath);
            String originalFilename = multipartFile.getOriginalFilename();
            String storePathFileName = storePath + originalFilename;
            multipartFile.transferTo(new File(storePathFileName));
            // 파일 저장 시 중복 유의
            attachfile = new HashMap();

            attachfile.put("FILE_UNIQUE", fileUnique);
            attachfile.put("FILE_NAME", originalFilename);
        }
        // 각 정보를 DB와 비교 수정 필요

        modelAndView.addObject("title", params.get("title"));
        modelAndView.addObject("content", params.get("content"));

        modelAndView.addObject("remoteServerUrl", remoteServerUrl);
        modelAndView.addObject("storePath", storePath);
        modelAndView.addObject("attachfile", attachfile);

        String viewName = "/WEB-INF/sample/views/files/read.jsp";
        modelAndView.setViewName(viewName);
        return modelAndView;
    }

}
