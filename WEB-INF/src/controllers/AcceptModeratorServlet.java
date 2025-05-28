package controllers;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import java.io.IOException;

import models.User;

@WebServlet("/accept_moderator.do")
public class AcceptModeratorServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String email = request.getParameter("email");
        String code = request.getParameter("code");
        
        if (email != null && code != null) {
            User user = new User();
            boolean success = user.acceptModeratorRole(email, code);
            
            if (success) {
                response.sendRedirect("moderator_accepted.jsp");
            } else {
                response.sendRedirect("invalid_code.jsp");
            }
        } else {
            response.sendRedirect("invalid_request.jsp");
        }
    }
}