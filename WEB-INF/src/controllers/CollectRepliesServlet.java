package controllers;

import com.google.gson.Gson;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import models.Reply;

@WebServlet("/collect_replies.do")
public class CollectRepliesServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String json = "expired";

        try {
            int postId = Integer.parseInt(request.getParameter("post_id"));
            String sort = request.getParameter("sort");

            if (sort == null || sort.isEmpty()) {
                sort = "newest"; 
            }

            ArrayList<Map<String, Object>> replies = Reply.collectAllReplies(postId, sort);
            int replyCount = Reply.getReplyCount(postId);

            if (replies == null) {
                replies = new ArrayList<>();
            }

            Map<String, Object> result = new LinkedHashMap<>();
            result.put("replyCount", replyCount);
            result.put("replies", replies);

            json = new Gson().toJson(result);
        } catch (Exception e) {
            json = "error";
        }

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        PrintWriter out = response.getWriter();
        out.write(json);
        out.close();
    }
}
