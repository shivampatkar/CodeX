package models;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Map;
import java.util.LinkedHashMap;

import utils.DBConnect;

public class Reply {
    private Integer replyId;
    private Post post;            
    private Integer likeCount;
    private Integer dislikeCount;
    private Question question;

    Reply() {

    }

    public Reply(Post post, Question question) {
        this.post = post;
        this.question = question;
    }

    public Reply(Integer replyId) {
        
    }

    // Other methods

    public static int updateVote(Integer replyId, String voteType) {
        int newCount = 0;
        String column = "";
        String operation = "";
        String toggleQuery = "";
    
        if ("like".equals(voteType)) {
            column = "like_count";
            toggleQuery = "select like_count from replies where reply_id = ?";
        } else if ("dislike".equals(voteType)) {
            column = "dislike_count";
            toggleQuery = "select dislike_count from replies where reply_id = ?";
        } else if ("unlike".equals(voteType)) {
            column = "like_count";
            toggleQuery = "select like_count from replies where reply_id = ?";
        } else if ("undislike".equals(voteType)) {
            column = "dislike_count";
            toggleQuery = "select dislike_count from replies where reply_id = ?";
        }
    
        try {
            Connection con = DBConnect.getConnection();
    
            // Check the current count (like/dislike)
            int currentCount = 0;
            try (PreparedStatement ps = con.prepareStatement(toggleQuery)) {
                ps.setInt(1, replyId);
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        currentCount = rs.getInt(1);
                    }
                }
            }
    
            // Set the operation based on the current count
            if ("like".equals(voteType)) {
                if (currentCount == 0) {
                    operation = "like_count + 1";  // First click, increment like count
                } else if (currentCount == 1) {
                    operation = "like_count - 1";  // Second click, decrement like count (unlike)
                }
            } else if ("dislike".equals(voteType)) {
                if (currentCount == 0) {
                    operation = "dislike_count + 1";  // First click, increment dislike count
                } else if (currentCount == 1) {
                    operation = "dislike_count - 1";  // Second click, decrement dislike count (undislike)
                }
            } else if ("unlike".equals(voteType) && currentCount == 1) {
                operation = "like_count - 1";  // Second click, decrement like count (unlike)
            } else if ("undislike".equals(voteType) && currentCount == 1) {
                operation = "dislike_count - 1";  // Second click, decrement dislike count (undislike)
            }
    
            // If operation is not set properly, return 0 as default
            if (operation.isEmpty()) {
                System.out.println("Invalid operation: " + voteType);
                return 0;
            }
    
            // Update the like/dislike count
            String updateQuery = "update replies set " + column + " = " + operation + " where reply_id = ?";
            try (PreparedStatement ps = con.prepareStatement(updateQuery)) {
                ps.setInt(1, replyId);
                ps.executeUpdate();
            }
    
            // Get the updated like/dislike count
            String selectQuery = "select " + column + " from replies where reply_id = ?";
            try (PreparedStatement ps = con.prepareStatement(selectQuery)) {
                ps.setInt(1, replyId);
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        newCount = rs.getInt(1);
                    }
                }
            }
    
        } catch (SQLException e) {
            e.printStackTrace();
        }
    
        return newCount;
    }
    
   

    public static int getReplyCount(int postId) {
        int count = 0;
        String query = "select count(*) as reply_count from replies where question_id = (select question_id from questions where post_id = ?)";
        
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, postId);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                count = rs.getInt("reply_count");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return count;
    }
    
    public static ArrayList<Map<String, Object>> collectAllReplies(Integer questionPostId, String sort) {
        ArrayList<Map<String, Object>> replies = new ArrayList<>();
        String orderByClause = "order by p.post_date DESC"; // Default: Newest First
    
        if (sort != null) {
            switch (sort) {
                case "oldest":
                    orderByClause = "order by p.post_date asc";
                    break;
                case "most_liked":
                    orderByClause = "order by r.like_count desc";
                    break;
                case "newest":
                    orderByClause = "order by p.post_date desc";
                    break;
            }
        }
    
        try {
            Connection con = DBConnect.getConnection();
            String query = """
                select r.reply_id, r.like_count, r.dislike_count, 
                    pd.description, pd.pic_path as reply_pic, 
                    u.name as username, u.pic_path as user_profile_pic, 
                    p.post_date, p.user_id
                from replies r
                join posts p on r.post_id = p.post_id 
                join post_data pd on p.post_id = pd.post_id
                join users u on p.user_id = u.user_id  
                where r.question_id = (SELECT question_id FROM questions WHERE post_id = ?) 
                """ + orderByClause + ";";
    
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, questionPostId);
    
            ResultSet rs = ps.executeQuery();
    
            while (rs.next()) {
                Map<String, Object> replyData = new LinkedHashMap<>();
                replyData.put("reply_id", rs.getInt("reply_id"));
                replyData.put("like_count", rs.getInt("like_count"));
                replyData.put("dislike_count", rs.getInt("dislike_count"));
                replyData.put("description", rs.getString("description"));
                replyData.put("reply_pic", rs.getString("reply_pic"));
                replyData.put("username", rs.getString("username"));
                replyData.put("user_profile_pic", rs.getString("user_profile_pic"));
                replyData.put("post_date", rs.getTimestamp("post_date"));
                replyData.put("user_id", rs.getInt("user_id")); // <-- Added this line
    
                replies.add(replyData);
            }
    
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return replies;
    }
    


    public boolean saveReply() {
        boolean flag = false;
        String query = "insert into replies (post_id, question_id) values (?, ?)";

        try{
            Connection con = DBConnect.getConnection();
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, this.post.getPostId());  // Get post ID from the Post object
            ps.setInt(2, this.question.getQuestionId());

            int result = ps.executeUpdate();
            if(result > 0) {
                flag = true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return flag;
    }


    // Setter and getter 
    
    public Integer getReplyId() {
        return replyId;
    }
    public void setReplyId(Integer replyId) {
        this.replyId = replyId;
    }
    public Post getPost() {
        return post;
    }
    public void setPost(Post post) {
        this.post = post;
    }
    public Integer getLikeCount() {
        return likeCount;
    }
    public void setLikeCount(Integer likeCount) {
        this.likeCount = likeCount;
    }
    public Integer getDislikeCount() {
        return dislikeCount;
    }
    public void setDislikeCount(Integer dislikeCount) {
        this.dislikeCount = dislikeCount;
    }
    public Question getQuestion() {
        return question;
    }
    public void setQuestion(Question question) {
        this.question = question;
    }
    
    
}
