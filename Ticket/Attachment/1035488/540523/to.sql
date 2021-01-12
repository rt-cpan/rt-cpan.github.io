DROP TABLE IF EXISTS `service_one_click`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `service_one_click` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `database_name` varchar(64) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `database_name` (`database_name`),
  CONSTRAINT `service_one_click_fk_database_name` FOREIGN KEY (`database_name`) REFERENCES `service_database` (`name`) ON UPDATE CASCADE,
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

