package controllers;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;

import models.Post;

@WebServlet("/view_discussion_post.do")
public class ViewPostServlet extends HttpServlet {
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        Integer postId = Integer.parseInt(request.getParameter("postId"));

        Map<String, Object> post = Post.collectPostById(postId);
        request.setAttribute("post", post);

        request.getRequestDispatcher("view_discussion_post.jsp").forward(request, response);
    }
}
