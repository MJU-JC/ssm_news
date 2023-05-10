-- phpMyAdmin SQL Dump
-- version 3.0.1.1
-- http://www.phpmyadmin.net
--
-- �������汾: 5.1.29
-- PHP �汾: 5.2.6

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";

-- --------------------------------------------------------

-- ----------------------------
-- Table structure for `admin`
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin` (
  `username` varchar(20) NOT NULL DEFAULT '',
  `password` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_admin
-- ----------------------------
INSERT INTO `admin` VALUES ('a', 'a'); 

CREATE TABLE IF NOT EXISTS `t_newsClass` (
  `newsClassId` int(11) NOT NULL AUTO_INCREMENT COMMENT '����id',
  `newsClassName` varchar(20)  NOT NULL COMMENT '��������',
  PRIMARY KEY (`newsClassId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS `t_news` (
  `newsId` int(11) NOT NULL AUTO_INCREMENT COMMENT '����id',
  `newsClassObj` int(11) NOT NULL COMMENT '�������',
  `newsTitle` varchar(50)  NOT NULL COMMENT '���ű���',
  `newsPhoto` varchar(60)  NOT NULL COMMENT '����ͼƬ',
  `content` varchar(5000)  NOT NULL COMMENT '��������',
  `comFrom` varchar(20)  NOT NULL COMMENT '������Դ',
  `hitNum` int(11) NOT NULL COMMENT '�������',
  `addTime` varchar(20)  NOT NULL COMMENT '���ʱ��',
  PRIMARY KEY (`newsId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS `t_userInfo` (
  `user_name` varchar(20)  NOT NULL COMMENT 'user_name',
  `password` varchar(20)  NOT NULL COMMENT '����',
  `name` varchar(20)  NOT NULL COMMENT '����',
  `sex` varchar(4)  NOT NULL COMMENT '�Ա�',
  `birthday` varchar(20)  NULL COMMENT '��������',
  `telephone` varchar(20)  NOT NULL COMMENT '��ϵ�绰',
  `email` varchar(40)  NULL COMMENT '�����ַ',
  `address` varchar(60)  NULL COMMENT '��ͥ��ַ',
  `photo` varchar(60)  NOT NULL COMMENT '��Ƭ',
  `memo` varchar(500)  NULL COMMENT '������Ϣ',
  PRIMARY KEY (`user_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `t_newsTag` (
  `tagId` int(11) NOT NULL AUTO_INCREMENT COMMENT '���id',
  `newsObj` int(11) NOT NULL COMMENT '���������',
  `userObj` varchar(20)  NOT NULL COMMENT '��ǵ��û�',
  `newsState` int(11) NOT NULL COMMENT '����״̬',
  `tagTime` varchar(30)  NOT NULL COMMENT '���ʱ��',
  PRIMARY KEY (`tagId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS `t_newsComment` (
  `commentId` int(11) NOT NULL AUTO_INCREMENT COMMENT '����id',
  `newsObj` int(11) NOT NULL COMMENT '��������',
  `userObj` varchar(20)  NOT NULL COMMENT '������',
  `content` varchar(100)  NOT NULL COMMENT '��������',
  `commentTime` varchar(30)  NOT NULL COMMENT '����ʱ��',
  PRIMARY KEY (`commentId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS `t_newsCollection` (
  `collectionId` int(11) NOT NULL AUTO_INCREMENT COMMENT '�ղ�id',
  `newsObj` int(11) NOT NULL COMMENT '���ղ�����',
  `userObj` varchar(20)  NOT NULL COMMENT '�ղ���',
  `collectTime` varchar(30)  NOT NULL COMMENT '�ղ�ʱ��',
  PRIMARY KEY (`collectionId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS `t_zambia` (
  `zambiaId` int(11) NOT NULL AUTO_INCREMENT COMMENT '��id',
  `newsObj` int(11) NOT NULL COMMENT '��������',
  `userObj` varchar(20)  NOT NULL COMMENT '�û�',
  `zambiaTime` varchar(20)  NOT NULL COMMENT '����ʱ��',
  PRIMARY KEY (`zambiaId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

ALTER TABLE t_news ADD CONSTRAINT FOREIGN KEY (newsClassObj) REFERENCES t_newsClass(newsClassId);
ALTER TABLE t_newsTag ADD CONSTRAINT FOREIGN KEY (newsObj) REFERENCES t_news(newsId);
ALTER TABLE t_newsTag ADD CONSTRAINT FOREIGN KEY (userObj) REFERENCES t_userInfo(user_name);
ALTER TABLE t_newsComment ADD CONSTRAINT FOREIGN KEY (newsObj) REFERENCES t_news(newsId);
ALTER TABLE t_newsComment ADD CONSTRAINT FOREIGN KEY (userObj) REFERENCES t_userInfo(user_name);
ALTER TABLE t_newsCollection ADD CONSTRAINT FOREIGN KEY (newsObj) REFERENCES t_news(newsId);
ALTER TABLE t_newsCollection ADD CONSTRAINT FOREIGN KEY (userObj) REFERENCES t_userInfo(user_name);
ALTER TABLE t_zambia ADD CONSTRAINT FOREIGN KEY (newsObj) REFERENCES t_news(newsId);
ALTER TABLE t_zambia ADD CONSTRAINT FOREIGN KEY (userObj) REFERENCES t_userInfo(user_name);


