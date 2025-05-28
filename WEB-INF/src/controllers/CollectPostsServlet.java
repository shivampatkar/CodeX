package controllers;

import com.google.gson.Gson;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import models.Post;

@WebServlet("/collect_posts.do")
public class CollectPostsServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String json = "expired";

        ArrayList<Map<String, Object>> posts = Post.collectAllPosts();
        if (posts == null) {
            posts = new ArrayList<>(); 
        }
        json = new Gson().toJson(posts);

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8"); 
        
        try (PrintWriter out = response.getWriter()) {
            out.write(json);
        } 
    }
}
