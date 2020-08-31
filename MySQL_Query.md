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
  `post_index` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `post_writter_id` VARCHAR(20) NOT NULL,
  `post_title` VARCHAR(255) NOT NULL,
  `post_contents` LONGTEXT NOT NULL,
  `post_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `post_view` INT UNSIGNED DEFAULT 0,
  `post_available` TINYINT DEFAULT 1,
  PRIMARY KEY (`post_index`));

post table set foreign key SQL :
ALTER TABLE bulletin_board_post
	ADD CONSTRAINT writter_id
	FOREIGN KEY (post_writter_id)
	REFERENCES bulletin_board_user(user_id)
	ON UPDATE CASCADE
	ON DELETE RESTRICT

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

post contents update SQL :
UPDATE bulletin_board_post SET post_contents=#{post_contents} WHERE post_index=#{post_index};

post comment table create SQL : 
CREATE TABLE `jsp`.`bulletin_board_comment` (
  'comment_index` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `comment_post_index` INT UNSIGNED NOT NULL,
  `comment_writter_id` VARCHAR(20) NULL,
  `comment_contents` LONGTEXT NULL,
  `comment_time` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `comment_available` TINYINT 1;

post comment writter foreign key set SQL :
ALTER TABLE bulletin_board_comment
	ADD CONSTRAINT comment_id
	FOREIGN KEY (comment_writter_id)
	REFERENCES bulletin_board_user(user_id)
	ON UPDATE CASCADE
	ON DELETE RESTRICT;

post comment index foreign key set SQL :
ALTER TABLE `jsp`.`bulletin_board_comment` 
ADD INDEX `comment_post_index_idx` (`comment_index` ASC) VISIBLE;
;
ALTER TABLE `jsp`.`bulletin_board_comment` 
ADD CONSTRAINT `comment_post_index`
  FOREIGN KEY (`comment_index`)
  REFERENCES `jsp`.`bulletin_board_post` (`post_index`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

post comment write SQL :
INSERT INTO bulletin_board_comment(comment_post_index, comment_writter_id, comment_contents) VALUES(#{comment_post_index}, #{comment_writter_id}, #{comment_contents});

post detail comment SQL :
SELECT comment_index, comment_writter_id, comment_contents, comment_time FROM bulletin_board_comment WHERE comment_available=1 AND comment_post_index=#{post_index} order by comment_index asc;

post comment delete SQL :
UPDATE bulletin_board_comment SET comment_available=0 WHERE comment_index=#{comment_index};

find id SQL :
SELECT user_id FROM bulletin_board_user WHERE user_email=#{query_data};

find pwd -> id, email check SQL :
SELECT EXISTS (SELECT * FROM bulletin_board_user WHERE user_id=#{input_id} and user_email=#{input_email}) AS Result;

find pwd -> pwd change SQL :
UPDATE bulletin_board_user SET user_password=#{input_pwd} WHERE user_id=#{user_id};

MyBaits User_SQL.xml (id="login_query") -> 로그인과, 비밀번호 변경 시 정보 체크하는 부분에서 사용. 추후 관련 메소드 명 및 id 변경 예정-> id_pwd_check로 통합

MyBatis User_SQL.xml (id="find_pwd_page_last_action") -> 비밀번호를 변경하는 쿼리이므로 비밀번호 변경에 관련된 비밀번호 찾기와 정보 수정 부분에서의 비밀번호 변경에서 요구하는바 추후 메소드 명 및 id 변경 예정-> change_pwd_action으로 통합

email change SQL :
UPDATE bulletin_board_user SET user_email=#{change_input_email} WHERE user_id=#{user_id};
