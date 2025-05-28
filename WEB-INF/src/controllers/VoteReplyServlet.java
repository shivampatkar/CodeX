package controllers;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import models.Reply;

@WebServlet("/vote_reply.do")
public class VoteReplyServlet extends HttpServlet {
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        HttpSession session = request.getSession();
        String replyIdStr = request.getParameter("reply_id");
        String voteType = request.getParameter("voteType");

        System.out.println(replyIdStr);

        int replyId = Integer.parseInt(replyIdStr);
        Integer userVote = (Integer) session.getAttribute("vote_" + replyId);

        int newCount = 0;

        if (userVote == null) {
            // User hasn't voted yet
            if ("up".equals(voteType)) {
                newCount = Reply.updateVote(replyId, "like");
                session.setAttribute("vote_" + replyId, 1);
            } else if ("down".equals(voteType)) {
                newCount = Reply.updateVote(replyId, "dislike");
                session.setAttribute("vote_" + replyId, -1); 
            }
        } else if (userVote == 1 && "up".equals(voteType)) {
            // User clicked "like" again (remove like)
            newCount = Reply.updateVote(replyId, "unlike");
            session.removeAttribute("vote_" + replyId); // Remove the user's vote
        } else if (userVote == -1 && "down".equals(voteType)) {
            // User clicked "dislike" again (remove dislike)
            newCount = Reply.updateVote(replyId, "undislike");
            session.removeAttribute("vote_" + replyId); // Remove the user's vote
        } else if (userVote == 1 && "down".equals(voteType)) {
            // User switched from "like" to "dislike"
            newCount = Reply.updateVote(replyId, "switchLikeToDislike");
            session.setAttribute("vote_" + replyId, -1); // Update user's vote to dislike
        } else if (userVote == -1 && "up".equals(voteType)) {
            // User switched from "dislike" to "like"
            newCount = Reply.updateVote(replyId, "switchDislikeToLike");
            session.setAttribute("vote_" + replyId, 1); // Update user's vote to like
        }

        response.getWriter().write(String.valueOf(newCount));

    }
}
