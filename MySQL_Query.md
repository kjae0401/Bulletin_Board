CREATE TABLE `jsp`.`bulletin_board_user` (
  `user_id` VARCHAR(20) NOT NULL,
  `user_password` VARCHAR(256) NOT NULL,
  `user_email` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`user_id`));

login SQL
SELECT EXISTS (SELECT * FROM bulletin_board_user WHERE user_id=#{user_id} and user_password=#{user_password}) AS Result;
