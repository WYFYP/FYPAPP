
### mysql 命令


docker run --name mysql -p 3306:3306 -e MYSQL\_ROOT\_PASSWORD=123456 -d mysql
docker start --name mysql -p 3306:3306 -e MYSQL\_ROOT\_PASSWORD=123456 -d mysql
### TP5 

php think   build   --module    name

###php直接启动


php -S  127.0.0.1:8888  router.php

iptables -I INPUT 3 -p tcp -m tcp --dport 8888 -j ACCEPT 

### 用户表

```SQL

SET FOREIGN_KEY_CHECKS=0;
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '用户id',
  `username` char(20) NOT NULL DEFAULT '' COMMENT '用户名',
  `password` char(32) NOT NULL DEFAULT '' COMMENT '密码',
  `nickname` char(20) NOT NULL DEFAULT '' COMMENT '昵称',
  `create_at` int(10) unsigned NOT NULL COMMENT '注册时间',
  `update_at` int(10) unsigned NOT NULL COMMENT '更新时间',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '状态-用于软删除',
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=1000 DEFAULT CHARSET=utf8;


```


``` event 表
SET FOREIGN_KEY_CHECKS=0;
DROP TABLE IF EXISTS `event`;
CREATE TABLE `event` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT 'EventID',
  `uid` mediumint(8) unsigned NOT NULL DEFAULT 0 COMMENT 'userid',
  `nick` char(20) NOT NULL DEFAULT '' COMMENT '发布者昵称',
  `title` char(64) NOT NULL DEFAULT '' COMMENT 'Title',
  `description` text(256) NOT NULL  COMMENT 'description',
  `avatar` char(64) NOT NULL DEFAULT '' COMMENT 'imgUrl',
  `location` char(32) NOT NULL DEFAULT '' COMMENT 'imgUrl',
  `organizer` char(32) NOT NULL DEFAULT '' COMMENT 'organizer',
  `category` char(32) NOT NULL DEFAULT '' COMMENT 'event category',  
  `start` int(10) unsigned NOT NULL COMMENT 'event start time',

  `max` int(10) unsigned NOT NULL DEFAULT 30 COMMENT 'event max user count',
  `join` int(10) unsigned NOT NULL DEFAULT 1 COMMENT 'event max user count',
  `like` int(10) unsigned NOT NULL DEFAULT 1 COMMENT 'event max user count',
  
  `close` tinyint(1) DEFAULT NULL COMMENT 'Event Close',

  `create_at` int(10) unsigned NOT NULL COMMENT '注册时间',
  `update_at` int(10) unsigned NOT NULL COMMENT '更新时间',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '状态-用于软删除',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

```


```User Follow 表
SET FOREIGN_KEY_CHECKS=0;
DROP TABLE IF EXISTS `follow`;
CREATE TABLE `follow` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT 'follow ID',
  `fuid` mediumint(8) unsigned NOT NULL DEFAULT 1 COMMENT 'follow user id',
  `buid` mediumint(8) unsigned NOT NULL DEFAULT 1 COMMENT '被follow user id',
  `create_at` int(10) unsigned NOT NULL COMMENT '注册时间',
  `update_at` int(10) unsigned NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

```


```` 状态表



CREATE TABLE `state` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Favorite ID',
  `eid` mediumint(8) unsigned NOT NULL DEFAULT '1' COMMENT 'event id',
  `uid` mediumint(8) unsigned NOT NULL DEFAULT '1' COMMENT 'user id',
  `like` boolean  DEFAULT '1' COMMENT 'like/unlike',
  `join` boolean  DEFAULT '1' COMMENT 'join/unjoin',
  `chat` boolean  DEFAULT '1' COMMENT 'in/out',
  `create_at` int(10) unsigned NOT NULL COMMENT '注册时间',
  `update_at` int(10) unsigned NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

````

SET FOREIGN_KEY_CHECKS=0;
DROP TABLE IF EXISTS `chat`;
CREATE TABLE `chat` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `eid` mediumint(8) unsigned NOT NULL DEFAULT 1 COMMENT 'event id',
  `uid` mediumint(8) unsigned NOT NULL DEFAULT 1 COMMENT 'user id',
  `msg` text NOT NULL COMMENT 'Message',
  `avatar` text NOT NULL COMMENT 'avatar',
  `username` char(20) NOT NULL DEFAULT '' COMMENT '用户名',
  `create_at` int(10) unsigned NOT NULL COMMENT '注册时间',
  `update_at` int(10) unsigned NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8