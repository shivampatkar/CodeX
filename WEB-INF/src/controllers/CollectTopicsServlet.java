package controllers;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.annotation.WebServlet;

import models.Topic;

@WebServlet("/topics.do")
public class CollectTopicsServlet extends HttpServlet {
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        
       // ----######### Collect Topics ######------
        ArrayList<Topic> topics = Topic.collectTopics();
        request.setAttribute("topics", topics); 

        request.getRequestDispatcher("topics.jsp").forward(request, response);

    }
}