# ************************************************************
# Sequel Pro SQL dump
# Version 4096
#
# http://www.sequelpro.com/
# http://code.google.com/p/sequel-pro/
#
# Host: 127.0.0.1 (MySQL 5.7.19)
# Database: eventmobile
# Generation Time: 2017-08-14 16:36:15 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table chat
# ------------------------------------------------------------

DROP TABLE IF EXISTS `chat`;

CREATE TABLE `chat` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `eid` mediumint(8) unsigned NOT NULL DEFAULT '1' COMMENT 'event id',
  `uid` mediumint(8) unsigned NOT NULL DEFAULT '1' COMMENT 'user id',
  `nick` char(20) NOT NULL DEFAULT '' COMMENT '昵称',
  `avatar` char(32) NOT NULL DEFAULT '' COMMENT '头像',
  `msg` text NOT NULL COMMENT 'Message',
  `create_at` int(10) unsigned NOT NULL COMMENT '注册时间',
  `update_at` int(10) unsigned NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

LOCK TABLES `chat` WRITE;
/*!40000 ALTER TABLE `chat` DISABLE KEYS */;

INSERT INTO `chat` (`id`, `eid`, `uid`, `nick`, `avatar`, `msg`, `create_at`, `update_at`)
VALUES
	(1,4,1000,'gen user','','hello~~~',1502634057,1502634057),
	(2,5,1002,'gen user','','hello~~~',1502634066,1502634066),
	(3,6,1002,'gen user','','hello~~~',1502634071,1502634071),
	(4,7,1002,'gen user','','hello~~~',1502634885,1502634885),
	(5,3,1002,'gen user','','hello~~~',1502634886,1502634886),
	(6,3,1000,'gen user','','hello~~~',1502634893,1502634893),
	(7,3,1000,'gen user','','asdfasdf',1502637318,1502637318),
	(8,3,1000,'gen user','','asdfaegaeg',1502637365,1502637365),
	(9,3,1000,'gen user','','asdfad',1502637412,1502637412),
	(10,3,1000,'gen user','','asdfasdf',1502637416,1502637416),
	(11,3,1000,'gen user','','111',1502637421,1502637421),
	(12,3,1000,'gen user','','asdfad',1502637772,1502637772),
	(13,3,1000,'gen user','','asdfasdf',1502637774,1502637774),
	(14,3,1000,'gen user','','asdf',1502637827,1502637827),
	(15,3,1000,'gen user','','asdfadf',1502637830,1502637830),
	(16,3,1000,'gen user','','111',1502637839,1502637839),
	(17,3,1000,'gen user','','1112123',1502637843,1502637843),
	(18,3,1000,'gen user','','123123',1502637847,1502637847),
	(19,3,1000,'gen user','','qeqweqwe',1502637850,1502637850),
	(20,3,1000,'gen user','','123123123',1502637860,1502637860),
	(21,3,1000,'gen user','','123',1502637960,1502637960),
	(22,3,1000,'gen user','','asdf',1502637963,1502637963),
	(23,3,1000,'gen user','','asdf',1502638035,1502638035),
	(24,3,1000,'gen user','','asdfasd',1502638041,1502638041),
	(25,3,1000,'gen user','','asdfasd',1502638074,1502638074),
	(26,3,1003,'admin','','asdfasdf',1502638158,1502638158),
	(27,3,1003,'admin','','asdfasdf',1502638160,1502638160),
	(28,3,1003,'admin','','hellele',1502638170,1502638170),
	(29,3,1000,'gen user','','你好',1502722510,1502722510),
	(30,3,1000,'gen user','','你好',1502722514,1502722514),
	(31,3,1000,'gen user','','这个是我刚刚发布的',1502722534,1502722534),
	(32,3,1000,'gen user','','kajlfkaj司法考试建档立卡放假啊杀戮空间的反馈拉经十东路快放假阿斯顿  俺老师可简单了父控件阿斯利康都放假 埃里克森江东父老空间啊示例的快放假 是控件福利卡就是地方了控件阿斯顿发 阿拉山口江东父老空间啊示例的快放假',1502722552,1502722552);

/*!40000 ALTER TABLE `chat` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table event
# ------------------------------------------------------------

DROP TABLE IF EXISTS `event`;

CREATE TABLE `event` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT 'EventID',
  `uid` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'userid',
  `nick` char(20) NOT NULL DEFAULT '' COMMENT '发布者昵称',
  `title` char(64) NOT NULL DEFAULT '' COMMENT 'Title',
  `description` text NOT NULL COMMENT 'Title',
  `avatar` char(64) NOT NULL DEFAULT '' COMMENT 'imgUrl',
  `location` char(32) NOT NULL DEFAULT '' COMMENT 'imgUrl',
  `organizer` char(32) NOT NULL DEFAULT '' COMMENT 'organizer',
  `category` char(32) NOT NULL DEFAULT '' COMMENT 'event category',
  `start` int(10) unsigned NOT NULL COMMENT 'event start time',
  `max` int(10) unsigned NOT NULL DEFAULT '30' COMMENT 'event max user count',
  `join` int(10) unsigned NOT NULL DEFAULT '1' COMMENT 'event max user count',
  `like` int(10) unsigned NOT NULL DEFAULT '1' COMMENT 'event max user count',
  `create_at` int(10) unsigned NOT NULL COMMENT '注册时间',
  `update_at` int(10) unsigned NOT NULL COMMENT '更新时间',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '状态-用于软删除',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

LOCK TABLES `event` WRITE;
/*!40000 ALTER TABLE `event` DISABLE KEYS */;

INSERT INTO `event` (`id`, `uid`, `nick`, `title`, `description`, `avatar`, `location`, `organizer`, `category`, `start`, `max`, `join`, `like`, `create_at`, `update_at`, `status`)
VALUES
	(1,1000,'gen user','','No Description','/static/img/user.jpg','','','sports',1502728535,30,1,2,1502022747,1502728535,0),
	(2,1000,'gen user','asdlkflakjsdflkh','jhkjhk','/static/img/user.jpg','kjhkjh','khkjh','sports',1502728491,30,0,2,1502022760,1502728491,0),
	(3,1000,'gen user','asdlkflakjsdflkh','jhkjhk','/static/img/user.jpg','kjhkjh','khkjh','sports',1502728498,30,28,23,1502022764,1502728498,0),
	(4,1000,'gen user','asdjkf','jh','/static/img/user.jpg','hkjhk','hkjhkj','sports',1502728518,30,0,0,1502022782,1502728518,0),
	(5,1000,'gen user','asdfas77a7sd7f7a7sdf','ihjkh','/static/img/user.jpg','89','khiuh','sports',1502728503,30,0,0,1502022802,1502728503,0),
	(6,1000,'gen user','asdfjalkejg123123','No Description','/static/img/user.jpg','asdfaf香港kjsldf','发布者hello','workshop',1502728522,14,0,0,1502373806,1502728522,0),
	(7,1000,'gen user','asdfjalkejg123123','No Description','/static/img/user.jpg','asdfaf香港kjsldf','发布者hello','workshop',1502727720,14,0,0,1502373807,1502727720,0),
	(8,1000,'gen user','asdfjalkejg123123','No Description','/static/img/user.jpg','asdfaf香港kjsldf','发布者hello','workshop',1502728526,14,0,0,1502373807,1502728526,0),
	(9,1000,'gen user','asdfjalkejg123123','No Description','/static/img/user.jpg','asdfaf香港kjsldf','发布者hello','workshop',1502373808,14,1,1,1502373808,1502373808,0),
	(10,1000,'gen user','asdfjalkejg123123','No Description','/static/img/user.jpg','asdfaf香港kjsldf','发布者hello','workshop',1502373808,14,1,1,1502373808,1502373808,0),
	(11,1000,'gen user','asdfjalkejg123123','No Description','/static/img/user.jpg','asdfaf香港kjsldf','发布者hello','workshop',1502373809,14,1,1,1502373809,1502373809,0),
	(12,1000,'gen user','asdfjalkejg123123','No Description','/static/img/user.jpg','asdfaf香港kjsldf','发布者hello','workshop',1502373809,14,1,1,1502373809,1502373809,0),
	(13,1000,'gen user','asdfjalkejg123123','No Description','/static/img/user.jpg','asdfaf香港kjsldf','发布者hello','workshop',1502373809,14,1,1,1502373809,1502373809,0),
	(14,1000,'gen user','asdfjalkejg123123','No Description','/static/img/user.jpg','asdfaf香港kjsldf','发布者hello','workshop',1502373810,14,1,1,1502373810,1502373810,0),
	(15,1000,'gen user','asdfjalkejg123123','No Description','/static/img/user.jpg','asdfaf香港kjsldf','发布者hello','workshop',1502373810,14,1,1,1502373810,1502373810,0),
	(16,1000,'gen user','asdfjalkejg123123','No Description','/static/img/user.jpg','asdfaf香港kjsldf','发布者hello','workshop',1502373811,14,1,1,1502373811,1502373811,0),
	(17,1000,'gen user','asdfjalkejg123123','No Description','/static/img/user.jpg','asdfaf香港kjsldf','发布者hello','workshop',1502373811,14,1,1,1502373811,1502373811,0),
	(18,1000,'gen user','asdfjalkejg123123','No Description','/static/img/user.jpg','asdfaf香港kjsldf','发布者hello','workshop',1502728406,14,1,1,1502373811,1502728406,0),
	(19,1000,'gen user','asdfjalkejg123123','No Description','/static/img/user.jpg','asdfaf香港kjsldf','发布者hello','workshop',1502373812,14,1,1,1502373812,1502373812,0),
	(20,1000,'gen user','asdfjalkejg123123','No Description','/static/img/user.jpg','asdfaf香港kjsldf','发布者hello','workshop',1502373812,14,1,1,1502373812,1502373812,0),
	(21,1000,'gen user','asdfjalkejg123123','No Description','/static/img/user.jpg','asdfaf香港kjsldf','发布者hello','workshop',1502373812,14,1,1,1502373812,1502373812,0),
	(22,1000,'gen user','asdfjalkejg123123','No Description','/static/img/user.jpg','asdfaf香港kjsldf','发布者hello','workshop',1502373813,14,1,1,1502373813,1502373813,0),
	(23,1000,'gen user','asdfjalkejg123123','No Description','/static/img/user.jpg','asdfaf香港kjsldf','发布者hello','workshop',1502373813,14,1,1,1502373813,1502373813,0),
	(24,1000,'gen user','asdfjalkejg123123','No Description','/static/img/user.jpg','asdfaf香港kjsldf','发布者hello','workshop',1502373814,14,1,1,1502373814,1502373814,0),
	(25,1000,'gen user','asdfjalkejg123123','No Description','/static/img/user.jpg','asdfaf香港kjsldf','发布者hello','workshop',1502373814,14,1,1,1502373814,1502373814,0),
	(26,1000,'gen user','asdfjalkejg123123','No Description','/static/img/user.jpg','asdfaf香港kjsldf','发布者hello','workshop',1502373815,14,1,1,1502373815,1502373815,0),
	(27,1000,'gen user','asdfjalkejg123123','No Description','/static/img/user.jpg','asdfaf香港kjsldf','发布者hello','workshop',1502373815,14,1,1,1502373815,1502373815,0),
	(28,1000,'gen user','asdfjalkejg123123','No Description','/static/img/user.jpg','asdfaf香港kjsldf','发布者hello','workshop',1502373815,14,1,1,1502373815,1502373815,0),
	(29,1002,'gen user','','No Description','/static/img/user.jpg','','','',1502633950,30,1,1,1502633950,1502633950,0),
	(30,1002,'gen user','','No Description','/static/img/user.jpg','','','',1502633960,30,1,1,1502633960,1502633960,0),
	(31,1002,'gen user','','No Description','/static/img/user.jpg','','','',1502633960,30,1,1,1502633960,1502633960,0),
	(32,1002,'gen user','','No Description','/static/img/user.jpg','','','',1502633961,30,1,1,1502633961,1502633961,0),
	(33,1000,'gen user','asdfjalkejg123123','No Description','/static/img/user.jpg','asdfaf香港kjsldf','发布者hello','workshop',1502723789,14,1,1,1502723789,1502723789,0),
	(34,1000,'gen user','asdfjalkejg123123','No Description','/static/img/user.jpg','asdfaf香港kjsldf','发布者hello','workshop',1502723790,14,1,1,1502723790,1502723790,0),
	(35,1000,'gen user','asdfjalkejg123123','No Description','/static/img/user.jpg','asdfaf香港kjsldf','发布者hello','workshop',1502723790,14,1,1,1502723790,1502723790,0);

/*!40000 ALTER TABLE `event` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table follow
# ------------------------------------------------------------

DROP TABLE IF EXISTS `follow`;

CREATE TABLE `follow` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT 'follow ID',
  `fuid` mediumint(8) unsigned NOT NULL DEFAULT '1' COMMENT 'follow user id',
  `buid` mediumint(8) unsigned NOT NULL DEFAULT '1' COMMENT '被follow user id',
  `create_at` int(10) unsigned NOT NULL COMMENT '注册时间',
  `update_at` int(10) unsigned NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;



# Dump of table state
# ------------------------------------------------------------

DROP TABLE IF EXISTS `state`;

CREATE TABLE `state` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Favorite ID',
  `eid` mediumint(8) unsigned NOT NULL DEFAULT '1' COMMENT 'event id',
  `uid` mediumint(8) unsigned NOT NULL DEFAULT '1' COMMENT 'user id',
  `like` tinyint(1) DEFAULT '0' COMMENT 'like/unlike',
  `join` tinyint(1) DEFAULT '0' COMMENT 'join/unjoin',
  `chat` tinyint(1) DEFAULT '0' COMMENT 'in/out',
  `create_at` int(10) unsigned NOT NULL COMMENT '注册时间',
  `update_at` int(10) unsigned NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

LOCK TABLES `state` WRITE;
/*!40000 ALTER TABLE `state` DISABLE KEYS */;

INSERT INTO `state` (`id`, `eid`, `uid`, `like`, `join`, `chat`, `create_at`, `update_at`)
VALUES
	(1,3,1000,1,0,1,1502631341,1502728498),
	(2,15,1000,0,0,0,1502632172,1502632172),
	(3,12,1000,0,0,1,1502632620,1502632620),
	(4,28,1000,0,0,0,1502632949,1502632949),
	(5,3,1003,1,1,1,1502638138,1502638138),
	(6,29,1000,1,1,1,1502638196,1502638196),
	(7,31,1000,1,0,1,1502638209,1502638209),
	(8,32,1000,0,0,1,1502720180,1502720180),
	(9,30,1000,0,0,1,1502720199,1502720199),
	(10,1,1000,1,1,1,1502726286,1502728535),
	(11,2,1000,1,0,1,1502726290,1502728491),
	(12,4,1000,1,0,1,1502727433,1502728518),
	(13,5,1000,1,0,1,1502727528,1502728503),
	(14,6,1000,1,0,1,1502727563,1502728522),
	(15,7,1000,1,1,1,1502727705,1502727705),
	(16,8,1000,1,0,0,1502727740,1502728526),
	(17,18,1000,0,0,1,1502728389,1502728406);

/*!40000 ALTER TABLE `state` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table user
# ------------------------------------------------------------

DROP TABLE IF EXISTS `user`;

CREATE TABLE `user` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '用户id',
  `username` char(20) NOT NULL DEFAULT '' COMMENT '用户名',
  `password` char(32) NOT NULL DEFAULT '' COMMENT '密码',
  `nickname` char(20) NOT NULL DEFAULT '' COMMENT '昵称',
  `avatar` char(32) NOT NULL DEFAULT '' COMMENT '头像',
  `create_at` int(10) unsigned NOT NULL COMMENT '注册时间',
  `update_at` int(10) unsigned NOT NULL COMMENT '更新时间',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '状态-用于软删除',
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;

INSERT INTO `user` (`id`, `username`, `password`, `nickname`, `avatar`, `create_at`, `update_at`, `status`)
VALUES
	(1000,'root','4297f44b13955235245b2497399d7a93','gen user','',1502633553,1502633553,0),
	(1003,'admin','4297f44b13955235245b2497399d7a93','admin','',1502638093,1502638093,0);

/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;



/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
