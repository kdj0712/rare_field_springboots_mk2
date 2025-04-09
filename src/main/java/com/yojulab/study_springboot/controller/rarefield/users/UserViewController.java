package com.yojulab.study_springboot.controller.rarefield.users;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;


@Controller
public class UserViewController {
    @RequestMapping(value = "/user_login", method = RequestMethod.GET)
    public ModelAndView userLogin(ModelAndView modelAndView){
        String viewName = "users/user_login";

        modelAndView.setViewName(viewName);
        return modelAndView;
    }

    @RequestMapping(value = "/user_join", method = RequestMethod.GET)
    public ModelAndView userJoin(ModelAndView modelAndView){
        String viewName = "users/user_join";

        modelAndView.setViewName(viewName);
        return modelAndView;
    }

    @RequestMapping(value = "/user_infosearch", method = RequestMethod.GET)
    public ModelAndView userInforsearch(ModelAndView modelAndView){
        String viewName = "users/user_infosearch";

        modelAndView.setViewName(viewName);
        return modelAndView;
    }

    @RequestMapping(value = "/user_mypage", method = RequestMethod.GET)
    public ModelAndView userMypage(ModelAndView modelAndView){
        String viewName = "users/user_mypage";
        modelAndView.setViewName(viewName);
        return modelAndView;
    }
    
}
