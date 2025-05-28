package controllers;

import com.google.gson.Gson;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import models.User;

@WebServlet("/getUserDetails.do")
public class GetUserDetailsServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String json = "{\"error\":\"User not found\"}";

        Integer userId;
        try {
            userId = Integer.parseInt(request.getParameter("userId"));
        } catch (NumberFormatException e) {
            response.getWriter().write("{\"error\":\"Invalid userId format\"}");
            return;
        }


        User user = User.getUserDetailsById(userId);
        if (user != null) {
            json = new Gson().toJson(user);
        }

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8"); 
        
        try {
            PrintWriter out = response.getWriter(); 
            out.write(json);
        }catch(IOException e) {
            e.printStackTrace();
        }
    }
}
