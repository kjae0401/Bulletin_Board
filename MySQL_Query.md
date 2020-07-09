user table create SQL :
CREATE TABLE `jsp`.`bulletin_board_user` (
  `user_id` VARCHAR(20) NOT NULL,
  `user_password` VARCHAR(256) NOT NULL,
  `user_email` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`user_id`));

login SQL :
SELECT EXISTS (SELECT * FROM bulletin_board_user WHERE user_id=#{user_id} and user_password=#{user_password}) AS Result;

signup SQL :
INSERT INTO bulletin_board_user VALUE(#{signup_id}, #{signup_password}, #{signup_email});

post table create SQL :
CREATE TABLE `jsp`.`bulletin_board_post` (
  `post_index` INT NOT NULL AUTO_INCREMENT,
  `post_writter_id` VARCHAR(20) NOT NULL,
  `post_title` VARCHAR(255) NOT NULL,
  `post_contents` LONGTEXT NOT NULL,
  `post_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `post_view` INT UNSIGNED DEFAULT 0,
  `post_available` TINYINT DEFAULT 1,
  PRIMARY KEY (`post_index`));

post table set foreign key SQL :
VARCHAR(255) NOT NULL,
  `post_contents` LONGTEXT NOT NULL,
  `post_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `post_view` INT UNSIGNED DEFAULT 0,
  `post_available` TINYINT DEFAULT 1,
  PRIMARY KEY (`post_index`));

post list search SQL :
SELECT post_index, post_writter_id, post_title, post_time, post_view FROM bulletin_board_post WHERE post_available=1 ORDER BY post_index DESC Limit #{startIndex}, #{countPerPage};

post detail search SQL :
SELECT post_index, post_title, post_writter_id, post_time, post_view, post_contents FROM bulletin_board_post WHERE post_index=#{post_index} and post_available=1;

post detail view update SQL :
UPDATE bulletin_board_post SET post_view = post_view+1 WHERE post_index=#{post_index};

post write SQL :
INSERT INTO bulletin_board_post(post_writter_id, post_title, post_contents) VALUE(#{post_writter_id}, #{post_title}, #{post_contents});

post delete SQL :
UPDATE bulletin_board_post SET post_available=0 WHERE post_index=#{post_index};
