package controllers;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import models.Post;
import models.User;
import models.Topic;

@WebServlet("/delete_post.do")
public class DeletePostServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int postId = Integer.parseInt(request.getParameter("postId"));

        response.setContentType("application/json");
        PrintWriter out = response.getWriter();

        try {
            Post post = new Post();
            Integer userId = post.getUserIdByPostId(postId);

            Integer topicId = post.getTopicIdByPostId(postId);

            post.deletePost(postId);

            User user = new User();
            user.decrementQuestionCount(userId);

            Topic topic = new Topic();
            topic.decrementQuestionCount(topicId);

            out.print("{\"success\": true, \"message\": \"Post deleted successfully.\"}");
        } catch (Exception e) {
            e.printStackTrace();
            out.print("{\"success\": false, \"message\": \"An unexpected error occurred.\"}");
        } finally {
            out.flush();
        }
    }
}
