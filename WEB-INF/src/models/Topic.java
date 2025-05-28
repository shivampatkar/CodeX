package models;

import java.util.Date;

import utils.DBConnect;

import java.util.ArrayList;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class Topic {
    private Integer topicId;
    private String name;
    private Integer questionCount;
    private Integer openQuestions;
    private Date lastPost;
    private String description;

    // Constructors

    public Topic(){

    }

    public Topic(Integer topicId) {
        this.topicId = topicId;
    }

    public Topic(Integer topicId, String name) {
        this.topicId = topicId;
        this.name = name;
    }

    public Topic(Integer topicId, String name, Integer questionCount, Integer openQuestions, Date lastPost, String description) {
        this.topicId = topicId;
        this.name = name;
        this.questionCount = questionCount;
        this.openQuestions = openQuestions;
        this.lastPost = lastPost;
        this.description = description;
    }

    public void decrementQuestionCount(int topicId) {
        String query = "update topics set question_count = question_count - 1 where topic_id = ?";
        Connection conn = DBConnect.getConnection();
        try {
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setInt(1, topicId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // // Other methods

    // question conunt increase method
    public boolean updateQuestionCount() {
        boolean isUpdated = false;
        Connection con = DBConnect.getConnection();
        try {
            String query = "update topics set question_count = question_count + 1, last_post = NOW() where topic_id = ?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, topicId);
            isUpdated = ps.executeUpdate() > 0;
            con.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return isUpdated;
    }

    public static ArrayList<Topic> collectTopics() {
        ArrayList<Topic> topics = new ArrayList<>();
        
        Connection con = DBConnect.getConnection();
        try{
            String query = "select * from topics";

            PreparedStatement ps = con.prepareStatement(query);

            ResultSet rs = ps.executeQuery();

            while(rs.next()) {
                topics.add(
                    new Topic(
                        rs.getInt("topic_id"),
                        rs.getString("name"),
                        rs.getInt("question_count"),
                        rs.getInt("open_questions"),
                        rs.getTimestamp("last_post"),
                        rs.getString("description")
                        )
                    );
            }
            con.close();
        } catch(SQLException e) {
            e.printStackTrace();
        }
        return topics;
    }


    // Seeter and getter 

    public Integer getTopicId() {
        return topicId;
    }
    public void setTopicId(Integer topicId) {
        this.topicId = topicId;
    }
    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }
    public void setDescription(String description) {
        this.description = description;
    }
    public String getDescription() {
        return description;
    }
    public Integer getQuestionCount() {
        return questionCount;
    }
    public void setQuestionCount(Integer questionCount) {
        this.questionCount = questionCount;
    }
    public Integer getOpenQuestions() {
        return openQuestions;
    }
    public void setOpenQuestions(Integer openQuestions) {
        this.openQuestions = openQuestions;
    }
    public Date getLastPost() {
        return lastPost;
    }
    public void setLastPost(Date lastPost) {
        this.lastPost = lastPost;
    }

    

}
