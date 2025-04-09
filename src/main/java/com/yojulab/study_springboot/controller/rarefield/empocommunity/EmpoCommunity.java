package com.yojulab.study_springboot.controller.rarefield.empocommunity;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;


@Controller
public class EmpoCommunity {
    
    // @RequestMapping(value = "/empo_community", method = RequestMethod.GET)
    // public ModelAndView empoCommunity(ModelAndView modelAndView){
    //     String viewName = "/WEB-INF/rarefield/views/empo/empo_community.jsp";
        
    //     modelAndView.setViewName(viewName);
    //     return modelAndView;
    // }

    @RequestMapping(value = "/empo_program", method = RequestMethod.GET)
    public ModelAndView empoProgram(ModelAndView modelAndView){
        String viewName = "empo/empo_program";

        modelAndView.setViewName(viewName);
        return modelAndView;
    }

    @RequestMapping(value = "/read", method = RequestMethod.GET)
    public ModelAndView empoCommunityRead(ModelAndView modelAndView){
        String viewName = "empo/empo_community_read";

        modelAndView.setViewName(viewName);
        return modelAndView;
    }

    // @RequestMapping(value = "/write",method = RequestMethod.GET)
    // public ModelAndView empoCommunityWrite(ModelAndView modelAndView){
    //     String viewName = "/WEB-INF/rarefield/views/empo/empo_community_write.jsp";

    //     modelAndView.setViewName(viewName);
    //     return modelAndView;
    // }

}
