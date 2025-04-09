package com.yojulab.study_springboot.controller.sample;

import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import java.util.ArrayList;
import java.util.Arrays;
import org.springframework.beans.factory.annotation.Autowired;

@Controller
@RequestMapping("/charts")
public class ChartsController {
    @Autowired
    private Gson gson;

    //http://127.0.0.1:8080/charts/statistics
    @RequestMapping(value = { "/statistics" }, method = RequestMethod.GET)
    public ModelAndView form(@RequestParam Map<String, Object> params, ModelAndView modelAndView) {
        
        // Create the data as an ArrayList of ArrayList
        ArrayList barData = new ArrayList<>();
        // Add rows to the barData ArrayList
        barData.add(Arrays.asList("Category", "Value"));
        barData.add(Arrays.asList("Category A", 10));
        barData.add(Arrays.asList("Category B", 20));
        barData.add(Arrays.asList("Category C", 15));

        // Convert the ArrayList to a JSON string
        modelAndView.addObject("barDataJson", gson.toJson(barData));
        String viewName = "/WEB-INF/sample/views/charts/charts_google_various.jsp";
        modelAndView.setViewName(viewName);
        return modelAndView;
    }

}
