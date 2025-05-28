create database tdf;

use tdf;

create table users (
    user_id int not null auto_increment primary key,
    name char(50) not null,
    email char(255) not null unique,
    password char(255) not null,
    created_at timestamp not null,
    about_me varchar(2000) not null,
    dob date not null,
    gender char(1) not null,
    contact char(10) not null,
    country_id int not null,
    pic_path char(255) not null,
    status_id int not null default 2,
    activation_code char(100),
    user_type_id int not null default 3,
    question_count int not null default 0, 
    reply_count int not null default 0,
    constraint fk_users_countries foreign key (country_id) references countries(country_id),
    constraint fk_users_status foreign key (status_id) references status(status_id),
    constraint fk_users_user_types foreign key (user_type_id) references user_types(user_type_id)
);

alter table users 
modify about_me varchar(2000) null,
modify contact char(10) null;

create table topics (
    topic_id int not null auto_increment primary key,
    name char(30) not null,
    question_count int not null default 0,
    open_questions int not null default 0,
    last_post datetime
);

insert into topics (name) values
('java'), ('javascript'), ('python'), ('c/c++'), ('dsa'),
('system design'), ('frontend'), ('backend'), ('databases'),
('apis'), ('sorting & searching'), ('recursion'), ('stacks & queues'),
('dynamic programming'), ('graphs'), ('multithreading'),
('web development'), ('mobile development'), ('networking'),
('cybersecurity'), ('ai/ml'), ('data structures'), ('algorithms');


create table posts (
    post_id int not null auto_increment primary key,
    user_id int not null,
    post_date datetime not null,
    description varchar(5000) not null,
    post_type boolean not null,  -- 0 for question, 1 for reply
    spam_count int not null default 0,
    status_id int not null default 2,
    constraint fk_posts_users foreign key (user_id) references users(user_id),
    constraint fk_posts_status foreign key (status_id) references status(status_id)
);

create table questions (
    question_id int not null auto_increment primary key,
    post_id int not null,
    title char(150) not null,
    topic_id int not null,
    constraint fk_questions_posts foreign key (post_id) references posts(post_id),
    constraint fk_questions_topics foreign key (topic_id) references topics(topic_id)
);

create table replies (
    reply_id int not null auto_increment primary key,
    post_id int not null,
    like_count int not null default 0,
    dislike_count int not null default 0,
    question_id int not null,
    constraint fk_replies_posts foreign key (post_id) references posts(post_id),
    constraint fk_replies_questions foreign key (question_id) references questions(question_id)
);

create table post_data (
    post_data_id int not null auto_increment primary key,
    post_id int not null,
    description varchar(1000),
    pic_path char(150),
    constraint fk_post_data_posts foreign key (post_id) references posts(post_id)
);

create table wishlist (
    wishlist_id int not null auto_increment primary key,
    post_id int not null,
    reply_id int,
    user_id int not null,
    constraint fk_wishlist_posts foreign key (post_id) references posts(post_id),
    constraint fk_wishlist_replies foreign key (reply_id) references replies(reply_id),
    constraint fk_wishlist_users foreign key (user_id) references users(user_id)
);

create table moderators (
    moderator_id int not null auto_increment primary key,
    user_id int not null,
    topic_id int not null,
    timezone char(15) not null,
    status_id int not null,
    constraint fk_moderators_users foreign key (user_id) references users(user_id),
    constraint fk_moderators_topics foreign key (topic_id) references topics(topic_id),
    constraint fk_moderators_status foreign key (status_id) references status(status_id)
);

create table countries (
    country_id int not null auto_increment primary key,
    name char(50) not null,
    flag char(50) not null
);
alter table countries modify flag varchar(255) ;
INSERT INTO countries (name, flag) VALUES
('United States', 'https://flagcdn.com/w40/us.png'),
('India', 'https://flagcdn.com/w40/in.png'),
('China', 'https://flagcdn.com/w40/cn.png'),
('United Kingdom', 'https://flagcdn.com/w40/gb.png'),
('Germany', 'https://flagcdn.com/w40/de.png'),
('France', 'https://flagcdn.com/w40/fr.png'),
('Japan', 'https://flagcdn.com/w40/jp.png'),
('Brazil', 'https://flagcdn.com/w40/br.png'),
('Canada', 'https://flagcdn.com/w40/ca.png'),
('Australia', 'https://flagcdn.com/w40/au.png'),
('Italy', 'https://flagcdn.com/w40/it.png'),
('South Korea', 'https://flagcdn.com/w40/kr.png'),
('Russia', 'https://flagcdn.com/w40/ru.png'),
('Mexico', 'https://flagcdn.com/w40/mx.png'),
('Netherlands', 'https://flagcdn.com/w40/nl.png'),
('Saudi Arabia', 'https://flagcdn.com/w40/sa.png'),
('Spain', 'https://flagcdn.com/w40/es.png'),
('Turkey', 'https://flagcdn.com/w40/tr.png'),
('Switzerland', 'https://flagcdn.com/w40/ch.png'),
('Sweden', 'https://flagcdn.com/w40/se.png'),
('Argentina', 'https://flagcdn.com/w40/ar.png'),
('South Africa', 'https://flagcdn.com/w40/za.png'),
('Belgium', 'https://flagcdn.com/w40/be.png'),
('Norway', 'https://flagcdn.com/w40/no.png'),
('Thailand', 'https://flagcdn.com/w40/th.png'),
('United Arab Emirates', 'https://flagcdn.com/w40/ae.png'),
('Poland', 'https://flagcdn.com/w40/pl.png'),
('Indonesia', 'https://flagcdn.com/w40/id.png'),
('Malaysia', 'https://flagcdn.com/w40/my.png'),
('Vietnam', 'https://flagcdn.com/w40/vn.png'),
('Philippines', 'https://flagcdn.com/w40/ph.png'),
('Singapore', 'https://flagcdn.com/w40/sg.png'),
('Egypt', 'https://flagcdn.com/w40/eg.png'),
('Denmark', 'https://flagcdn.com/w40/dk.png'),
('Ireland', 'https://flagcdn.com/w40/ie.png'),
('Greece', 'https://flagcdn.com/w40/gr.png'),
('New Zealand', 'https://flagcdn.com/w40/nz.png'),
('Portugal', 'https://flagcdn.com/w40/pt.png'),
('Hungary', 'https://flagcdn.com/w40/hu.png'),
('Finland', 'https://flagcdn.com/w40/fi.png'),
('Czech Republic', 'https://flagcdn.com/w40/cz.png'),
('Israel', 'https://flagcdn.com/w40/il.png'),
('Chile', 'https://flagcdn.com/w40/cl.png'),
('Austria', 'https://flagcdn.com/w40/at.png'),
('Colombia', 'https://flagcdn.com/w40/co.png'),
('Romania', 'https://flagcdn.com/w40/ro.png'),
('Pakistan', 'https://flagcdn.com/w40/pk.png'),
('Bangladesh', 'https://flagcdn.com/w40/bd.png'),
('Nigeria', 'https://flagcdn.com/w40/ng.png');


create table status (
    status_id int not null auto_increment primary key,
    name char(25) not null
);

alter table status add category char(25);
insert into status (status_id, name, category) values
-- User Statuses
(0, 'Inactive', 'user'),    -- Default for new users until activation
(1, 'Active', 'user'),      -- Verified users
(2, 'Banned', 'user'),      -- Permanently banned users
(3, 'Suspended', 'user'),   -- Temporarily blocked users
(4, 'Deactivated', 'user'), -- User-initiated deactivation

-- Post Statuses
(5, 'Published', 'post'),   -- Default for new posts (visible to all)
(6, 'Hidden', 'post'),      -- Removed or flagged posts
(7, 'Reported', 'post'),    -- Marked as spam or inappropriate
(8, 'Deleted', 'post');     -- Admin removed the post

insert into status (name, category) values ('Active', 'user'),('Inactive', 'user'), ('Banned', 'user'), ('Deactivated', 'user'),('Published', 'post'),('Hidden', 'post'), ('Reported', 'post'), ('Deleted', 'post');

create table user_types (
    user_type_id int not null auto_increment primary key,
    type char(25) not null
);

insert into user_types (user_type_id, type) values 
(1, 'admin'),
(2, 'moderator'),
(3, 'user');