package com.yojulab.study_springboot.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/setCurrentPage")
public class SetCurrentPageServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String currentPage = request.getParameter("currentPage");
        session.setAttribute("currentPage", Integer.parseInt(currentPage)); // 정수로 변환하여 저장
        response.setStatus(HttpServletResponse.SC_OK);
    }
}