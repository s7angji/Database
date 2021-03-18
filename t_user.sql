-- --------------------------------------------------------
-- 호스트:                          127.0.0.1
-- 서버 버전:                        8.0.22 - MySQL Community Server - GPL
-- 서버 OS:                        Win64
-- HeidiSQL 버전:                  11.2.0.6213
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- testdb 데이터베이스 구조 내보내기
CREATE DATABASE IF NOT EXISTS `testdb` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `testdb`;

-- 테이블 testdb.t_user 구조 내보내기
DROP TABLE IF EXISTS `t_user`;
CREATE TABLE IF NOT EXISTS `t_user` (
  `i_user` varchar(50) NOT NULL,
  `user_nm` varchar(50) NOT NULL,
  `user_age` varchar(50) NOT NULL,
  `email` varchar(50) DEFAULT NULL,
  `user_phone` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- 테이블 데이터 testdb.t_user:~14 rows (대략적) 내보내기
DELETE FROM `t_user`;
/*!40000 ALTER TABLE `t_user` DISABLE KEYS */;
INSERT INTO `t_user` (`i_user`, `user_nm`, `user_age`, `email`, `user_phone`) VALUES
	('1', '김태연', '31세', 'taeyeon@naver.com', '01012341234'),
	('2', '이순규', '29세', 'lee@naver.com', '010-1234-1234'),
	('2', '이순규', '29세', 'lee@naver.com', '010-1234-1234'),
	('2', '이순규', '29세', 'lee@naver.com', '010-1234-1234'),
	('2', '이순규', '29세', 'lee@naver.com', '010-1234-1234'),
	('2', '이순규', '29세', NULL, '010-1234-1234'),
	('2', '이순규', '29세', NULL, '010-1234-1234'),
	('2', '이순규', '29세', 'lee@daum.net', '010-1234-1234'),
	('1', '김태연', '31세', 'taeyeon@naver.com', '01012341234'),
	('2', '이순규', '29세', 'lee@naver.com', '010-1234-1234'),
	('2', '이순규', '29세', 'lee@naver.com', '010-1234-1234'),
	('2', '이순규', '29세', 'lee@naver.com', '010-1234-1234'),
	('2', '이순규', '29세', 'lee@naver.com', '010-1234-1234'),
	('2', '이순규', '29세', NULL, '010-1234-1234'),
	('2', '이순규', '29세', NULL, '010-1234-1234'),
	('2', '이순규', '29세', 'lee@daum.net', '010-1234-1234');
/*!40000 ALTER TABLE `t_user` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
