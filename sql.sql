USE gta5_gamemode_essential;

CREATE TABLE IF NOT EXISTS `jobs` (
  `job_id` int(11) NOT NULL AUTO_INCREMENT,
  `job_name` varchar(40) NOT NULL,
  `salary` int(11) NOT NULL DEFAULT '500',
  PRIMARY KEY (`job_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

INSERT INTO `jobs` (`job_id`, `job_name`, `salary`) VALUES (11, 'Ambulancier', 1200);

UPDATE users SET job = 11 WHERE identifier = 'steam:';
