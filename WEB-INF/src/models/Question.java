package models;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import utils.DBConnect;

public class Question {
    private Integer questionId;
    private Post post;
    private String title;
    private Topic topic;

    public Question() {

    }

    public Question(Integer questionId) {
        this.questionId = questionId;
    }

    public Question(Post post, String title, Topic topic) {
        this.post = post;
        this.title = title;
        this.topic = topic;
    }

    public static Integer getQuestionIdByPostId(Integer postId) {
        Integer questionId = null;
        Connection con = DBConnect.getConnection();

        try {
            String query = "select question_id from questions where post_id = ?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, postId);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    questionId = rs.getInt("question_id");
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return questionId;
    }

    // save questions list
    public boolean save() {
        boolean flag = false;
        Connection con = DBConnect.getConnection();
        try {
            String query = "insert into questions (post_id, title, topic_id) values (?, ?, ?)";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, post.getPostId());
            ps.setString(2, title);
            ps.setInt(3, topic.getTopicId());
            flag = ps.executeUpdate() > 0;
            con.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return flag;
    }

    // ------------Setter and Getters -----------

    public Integer getQuestionId() {
        return questionId;
    }

    public void setQuestionId(Integer questionId) {
        this.questionId = questionId;
    }

    public Post getPost() {
        return post;
    }

    public void setPost(Post post) {
        this.post = post;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public Topic getTopic() {
        return topic;
    }

    public void setTopic(Topic topic) {
        this.topic = topic;
    }

}
