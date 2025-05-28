package controllers;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.annotation.WebServlet;

import models.User;

@WebServlet("/edit_profile.do")
public class EditProfileServlet extends HttpServlet {
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        HttpSession session = request.getSession();
        User sessionUser = (User) session.getAttribute("user");

        String nextPage = "index.do";

        if (sessionUser != null) {

            User user = User.getUserDetailsById(sessionUser.getUserId());

            session.setAttribute("user", user);

            request.setAttribute("user", user);
            nextPage = "edit_profile.jsp";
        }

        request.getRequestDispatcher(nextPage).forward(request, response);
    }
}
