CREATE DATABASE IF NOT EXISTS example;

USE example;

DROP TABLE IF EXISTS `Table_Example`;
CREATE TABLE `Table_Example` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `Table_Example` WRITE;
INSERT INTO `Table_Example` VALUES (1,'Hello World!');
UNLOCK TABLES;
