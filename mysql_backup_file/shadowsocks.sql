SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS  `free_user`;
CREATE TABLE `free_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `port` int(11) NOT NULL,
  `passwd` varchar(16) NOT NULL,
  `encrypt_method` varchar(32) NOT NULL DEFAULT 'chacha20',
  `udp_relay` tinyint(1) NOT NULL DEFAULT '1',
  `group` varchar(32) NOT NULL,
  `enable` tinyint(1) NOT NULL DEFAULT '1',
  `pid` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_port` (`port`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='免费用户';

DROP TABLE IF EXISTS  `node_free`;
CREATE TABLE `node_free` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `address` varchar(32) NOT NULL,
  `area` varchar(32) DEFAULT NULL,
  `group` varchar(32) DEFAULT NULL,
  `remark` varchar(32) DEFAULT NULL,
  `order` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='免费节点';

SET FOREIGN_KEY_CHECKS = 1;

