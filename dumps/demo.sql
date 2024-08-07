--
-- Database: `demo`
--

-- --------------------------------------------------------

--
-- Table structure for table `user_details`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `demo` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `demo`;

CREATE TABLE IF NOT EXISTS `user_details` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) DEFAULT NULL,
  `first_name` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) DEFAULT NULL,
  `gender` varchar(10) DEFAULT NULL,
  `status` tinyint(10) DEFAULT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=10001 ;

--
-- Dumping data for table `user_details`
--

INSERT INTO `user_details` (`user_id`, `username`, `first_name`, `last_name`, `gender`, `status`) VALUES
(1, 'rogers63', 'david', 'john', 'Female', 1),
(2, 'mike28', 'rogers', 'paul', 'Male', 1),
(3, 'rivera92', 'david', 'john', 'Male', 1),
(4, 'ross95', 'maria', 'sanders', 'Male', 1),
(5, 'paul85', 'morris', 'miller', 'Female', 1),
(6, 'smith34', 'daniel', 'michael', 'Female', 1),
(7, 'james84', 'sanders', 'paul', 'Female', 1),
(8, 'daniel53', 'mark', 'mike', 'Male', 1),
(9, 'brooks80', 'morgan', 'maria', 'Female', 1),
(10, 'morgan65', 'paul', 'miller', 'Female', 1);
