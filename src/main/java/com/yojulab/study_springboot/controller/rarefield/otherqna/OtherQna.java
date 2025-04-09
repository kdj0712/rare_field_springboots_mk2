package com.yojulab.study_springboot.controller.rarefield.otherqna;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;


@Controller
public class OtherQna {
    @RequestMapping(value = "/other_QnA_main", method = RequestMethod.GET)
    public ModelAndView otherQnaMain(ModelAndView modelAndView){
        String viewName = "other/other_QnA_main";

        modelAndView.setViewName(viewName);
        return modelAndView;
    }

    @RequestMapping(value = "/other_notice", method = RequestMethod.GET)
    public ModelAndView otherQnaNotice(ModelAndView modelAndView){
        String viewName = "other/other_notice";

        modelAndView.setViewName(viewName);
        return modelAndView;
    }

}
