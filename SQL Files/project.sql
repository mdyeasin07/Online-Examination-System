SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

--
-- Database: `project`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `leaderboard`()
    NO SQL
select q.quizname,s.score,s.totalscore,st.name,s.mail from score s,student st,quiz q 
where s.mail=st.mail and q.quizid=s.quizid order by score DESC$$

DELIMITER ;

--
-- Table structure for table `dept`
--

CREATE TABLE IF NOT EXISTS `dept` (
  `dept_id` int(11) NOT NULL,
  `dept_name` varchar(3) DEFAULT NULL,
  PRIMARY KEY (`dept_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `dept`
--

INSERT INTO `dept` (`dept_id`, `dept_name`) VALUES
(1, 'CSE'),
(2, 'EEE'),
(3, 'TEX');

--
-- Table structure for table `questions`
--

CREATE TABLE IF NOT EXISTS `questions` (
  `qs` varchar(200) NOT NULL,
  `op1` varchar(30) NOT NULL,
  `op2` varchar(30) NOT NULL,
  `op3` varchar(30) NOT NULL,
  `answer` varchar(30) NOT NULL,
  `quizid` int(11) NOT NULL,
  UNIQUE KEY `qs` (`qs`),
  KEY `quizid` (`quizid`),
  KEY `quizid_2` (`quizid`),
  KEY `quizid_3` (`quizid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `questions`
--

INSERT INTO `questions` (`qs`, `op1`, `op2`, `op3`, `answer`, `quizid`) VALUES
('/ Assume that integers take 4 bytes.<br>  #include<iostream> <br>    using namespace std; <br>       class Test  { <br>   static int i;<br>    int j;<br>  }; <br>    int Test::i; <br>    int main() { ', '1', '2', '3', '4', 5),
('C primiarily developed as..', 'General purpose language', 'Data processing language D.', 'None of the above.', 'System programming language  ', 4),
('C programs converted into machine language with the help of..', 'An Editor  ', 'An operating system', ' None of these.', 'A compiler  ', 4),
('No. of consonant in english language is..', '20', '22', '28', '21', 6),
('No. of vowels in english language is..', '3', '4', '7', '5', 6),
('Total no of letters in english language is..', '23', '24', '25', '26', 6),
('When a copy constructor may be called?', 'When an object of the class is', 'When an object of the class is', 'When an object is constructed ', 'All of the above', 5),
('Which of the following functions must use reference.', 'Assignment operator function', 'Destructor', 'Parameterized constructor', 'Copy Constructor', 5),
('Which of the following is FALSE about references in C++', 'References cannot be NULL', 'A reference must be initialize', 'Once a reference is created, i', 'References cannot refer to con', 5),
('Which of the following operators cannot be overloaded', '. (Member Access or Dot operat', '?: (Ternary or Conditional Ope', ':: (Scope Resolution Operator)', 'All of the above', 5),
('Which of the followings is/are automatically added to every class, if we do not write our own.', 'Copy Constructor', 'Assignment Operator', 'A constructor without any para', 'All of the above', 5),
('Who is the father of C language?', 'Bjarne Stroustrup', 'James A. Gosling  ', 'Dr. E.F. Codd', 'Dennis Ritchie  ', 4);

--
-- Table structure for table `quiz`
--

CREATE TABLE IF NOT EXISTS `quiz` (
  `quizid` int(11) NOT NULL AUTO_INCREMENT,
  `quizname` varchar(20) NOT NULL,
  `date_created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `mail` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`quizid`),
  KEY `mail` (`mail`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=7 ;

--
-- Dumping data for table `quiz`
--

INSERT INTO `quiz` (`quizid`, `quizname`, `date_created`, `mail`) VALUES
(4, 'c quiz', '2022-04-25 16:13:50', 'yeasin@gmail.com'),
(5, 'c++ quiz', '2022-04-25 16:17:13', 'yeasin1@gmail.com'),
(6, 'english', '2022-04-25 17:04:12', 'yeasin2@gmail.com');

--
-- Triggers `quiz`
--
DROP TRIGGER IF EXISTS `ondeleteqs`;
DELIMITER //
CREATE TRIGGER `ondeleteqs` AFTER DELETE ON `quiz`
 FOR EACH ROW delete from questions where questions.quizid=old.quizid
//
DELIMITER ;

--
-- Table structure for table `score`
--

CREATE TABLE IF NOT EXISTS `score` (
  `slno` int(11) NOT NULL AUTO_INCREMENT,
  `score` int(11) NOT NULL,
  `quizid` int(11) NOT NULL,
  `mail` varchar(30) DEFAULT NULL,
  `totalscore` int(11) DEFAULT NULL,
  `remark` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`slno`),
  KEY `quizid` (`quizid`),
  KEY `mail` (`mail`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=15 ;


--
-- Triggers `score`
--
DROP TRIGGER IF EXISTS `remarks`;
DELIMITER //
CREATE TRIGGER `remarks` BEFORE INSERT ON `score`
 FOR EACH ROW set NEW.remark = if(NEW.score = 0, 'bad', 'good')
//
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `staff`
--

CREATE TABLE IF NOT EXISTS `staff` (
  `staffid` varchar(10) NOT NULL,
  `name` varchar(20) NOT NULL,
  `mail` varchar(30) NOT NULL,
  `phno` varchar(10) NOT NULL,
  `gender` varchar(1) NOT NULL,
  `DOB` varchar(10) NOT NULL,
  `pw` varchar(200) NOT NULL,
  `dept` varchar(3) DEFAULT NULL,
  PRIMARY KEY (`mail`),
  UNIQUE KEY `mail` (`mail`,`phno`),
  UNIQUE KEY `staffid` (`staffid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `staff`
--

INSERT INTO `staff` (`staffid`, `name`, `mail`, `phno`, `gender`, `DOB`, `pw`, `dept`) VALUES
('201', 'yeasin', 'yeasin@gmail.com', '01624269321', 'M', '2000-01-01', '123', 'CSE'),
('202', 'yeasin'2, 'yeasin1@gmail.com', '01724269321', 'M', '2001-01-01', '1234', 'CSE'),
('203', 'yeasin3', 'yeasin2@gmail.com', '01824269321', 'M', '2002-01-01', '12345', 'TEX');

-- --------------------------------------------------------

--
-- Table structure for table `student`
--

CREATE TABLE IF NOT EXISTS `student` (
  `usn` varchar(10) NOT NULL,
  `name` varchar(20) NOT NULL,
  `mail` varchar(30) NOT NULL,
  `phno` varchar(10) NOT NULL,
  `gender` varchar(1) NOT NULL,
  `DOB` varchar(10) NOT NULL,
  `pw` varchar(200) NOT NULL,
  `dept` varchar(3) DEFAULT NULL,
  PRIMARY KEY (`mail`),
  UNIQUE KEY `mail` (`mail`),
  UNIQUE KEY `phno` (`phno`),
  UNIQUE KEY `usn` (`usn`),
  KEY `dept` (`dept`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Constraints for table `quiz`
--
ALTER TABLE `quiz`
  ADD CONSTRAINT `quiz_ibfk_1` FOREIGN KEY (`mail`) REFERENCES `staff` (`mail`) ON DELETE CASCADE;

--
-- Constraints for table `score`
--
ALTER TABLE `score`
  ADD CONSTRAINT `score_ibfk_1` FOREIGN KEY (`quizid`) REFERENCES `quiz` (`quizid`) ON DELETE CASCADE,
  ADD CONSTRAINT `score_ibfk_2` FOREIGN KEY (`mail`) REFERENCES `student` (`mail`) ON DELETE CASCADE ON UPDATE CASCADE;

