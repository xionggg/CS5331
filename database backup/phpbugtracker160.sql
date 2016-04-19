-- phpMyAdmin SQL Dump
-- version 4.0.10deb1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Apr 19, 2016 at 11:47 PM
-- Server version: 5.5.41-0ubuntu0.14.04.1
-- PHP Version: 5.5.9-1ubuntu4.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `phpbugtracker160`
--

-- --------------------------------------------------------

--
-- Table structure for table `phpbt_attachment`
--

CREATE TABLE IF NOT EXISTS `phpbt_attachment` (
  `attachment_id` int(10) unsigned NOT NULL DEFAULT '0',
  `bug_id` int(10) unsigned NOT NULL DEFAULT '0',
  `file_name` char(255) NOT NULL DEFAULT '',
  `bytes` longblob,
  `description` char(255) NOT NULL DEFAULT '',
  `file_size` bigint(20) unsigned NOT NULL DEFAULT '0',
  `mime_type` char(30) NOT NULL DEFAULT '',
  `created_by` int(10) unsigned NOT NULL DEFAULT '0',
  `created_date` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`attachment_id`),
  KEY `bug_id_attachment` (`bug_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `phpbt_attachment_seq`
--

CREATE TABLE IF NOT EXISTS `phpbt_attachment_seq` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `phpbt_auth_group`
--

CREATE TABLE IF NOT EXISTS `phpbt_auth_group` (
  `group_id` int(10) unsigned NOT NULL DEFAULT '0',
  `group_name` varchar(80) NOT NULL DEFAULT '',
  `locked` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `created_by` int(10) unsigned NOT NULL DEFAULT '0',
  `created_date` bigint(20) unsigned NOT NULL DEFAULT '0',
  `last_modified_by` int(10) unsigned NOT NULL DEFAULT '0',
  `last_modified_date` bigint(20) unsigned NOT NULL DEFAULT '0',
  `is_role` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `phpbt_auth_group`
--

INSERT INTO `phpbt_auth_group` (`group_id`, `group_name`, `locked`, `created_by`, `created_date`, `last_modified_by`, `last_modified_date`, `is_role`) VALUES
(1, 'Admin', 1, 0, 0, 0, 0, 0),
(2, 'User', 1, 0, 0, 0, 0, 0),
(3, 'Developer', 0, 0, 0, 0, 0, 0),
(4, 'Manager', 0, 0, 0, 0, 0, 0),
(5, 'Guest', 1, 0, 0, 0, 0, 1),
(6, 'User', 1, 0, 0, 0, 0, 1),
(7, 'Reporter', 1, 0, 0, 0, 0, 1),
(8, 'Assignee', 1, 0, 0, 0, 0, 1),
(9, 'Owner', 1, 0, 0, 0, 0, 1);

-- --------------------------------------------------------

--
-- Table structure for table `phpbt_auth_group_seq`
--

CREATE TABLE IF NOT EXISTS `phpbt_auth_group_seq` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=10 ;

--
-- Dumping data for table `phpbt_auth_group_seq`
--

INSERT INTO `phpbt_auth_group_seq` (`id`) VALUES
(9);

-- --------------------------------------------------------

--
-- Table structure for table `phpbt_auth_perm`
--

CREATE TABLE IF NOT EXISTS `phpbt_auth_perm` (
  `perm_id` int(10) unsigned NOT NULL DEFAULT '0',
  `perm_name` varchar(80) NOT NULL DEFAULT '',
  `created_by` int(10) unsigned NOT NULL DEFAULT '0',
  `created_date` bigint(20) unsigned NOT NULL DEFAULT '0',
  `last_modified_by` int(10) unsigned NOT NULL DEFAULT '0',
  `last_modified_date` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`perm_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `phpbt_auth_perm`
--

INSERT INTO `phpbt_auth_perm` (`perm_id`, `perm_name`, `created_by`, `created_date`, `last_modified_by`, `last_modified_date`) VALUES
(1, 'Admin', 0, 0, 0, 0),
(2, 'AddBug', 0, 0, 0, 0),
(3, 'EditAssignment', 0, 0, 0, 0),
(4, 'Assignable', 0, 0, 0, 0),
(5, 'EditBug', 0, 0, 0, 0),
(6, 'CloseBug', 0, 0, 0, 0),
(7, 'CommentBug', 0, 0, 0, 0),
(8, 'EditPriority', 0, 0, 0, 0),
(9, 'EditStatus', 0, 0, 0, 0),
(10, 'EditSeverity', 0, 0, 0, 0),
(11, 'EditResolution', 0, 0, 0, 0),
(12, 'EditProject', 0, 0, 0, 0),
(13, 'EditComponent', 0, 0, 0, 0),
(14, 'ManageBug', 0, 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `phpbt_auth_user`
--

CREATE TABLE IF NOT EXISTS `phpbt_auth_user` (
  `user_id` int(10) unsigned NOT NULL DEFAULT '0',
  `login` char(40) NOT NULL DEFAULT '',
  `first_name` char(40) NOT NULL DEFAULT '',
  `last_name` char(40) NOT NULL DEFAULT '',
  `email` char(60) NOT NULL DEFAULT '',
  `password` char(40) NOT NULL DEFAULT '',
  `active` tinyint(3) unsigned NOT NULL DEFAULT '1',
  `bug_list_fields` text,
  `created_by` int(10) unsigned NOT NULL DEFAULT '0',
  `created_date` bigint(20) unsigned NOT NULL DEFAULT '0',
  `last_modified_by` int(10) unsigned NOT NULL DEFAULT '0',
  `last_modified_date` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `login` (`login`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `phpbt_auth_user`
--

INSERT INTO `phpbt_auth_user` (`user_id`, `login`, `first_name`, `last_name`, `email`, `password`, `active`, `bug_list_fields`, `created_by`, `created_date`, `last_modified_by`, `last_modified_date`) VALUES
(0, 'Anonymous User', 'Anonymous', 'User', '', '', 0, NULL, 0, 0, 0, 0),
(1, 'admin@admin.com', 'System', 'Admin', 'admin@admin.com', 'admin', 1, NULL, 0, 0, 0, 0),
(2, 'manager@manager.com', 'man', 'man', 'manager@manager.com', 'manager', 1, NULL, 1, 1426176210, 1, 1426176210),
(3, 'dev@dev.com', 'dev', 'dev', 'dev@dev.com', 'developer', 1, NULL, 1, 1426442497, 1, 1426442497),
(4, 'user@user.com', 'user', 'user', 'user@user.com', 'user', 1, NULL, 1, 1426442688, 1, 1426442688);

-- --------------------------------------------------------

--
-- Table structure for table `phpbt_auth_user_seq`
--

CREATE TABLE IF NOT EXISTS `phpbt_auth_user_seq` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

--
-- Dumping data for table `phpbt_auth_user_seq`
--

INSERT INTO `phpbt_auth_user_seq` (`id`) VALUES
(1),
(2),
(3),
(4);

-- --------------------------------------------------------

--
-- Table structure for table `phpbt_bookmark`
--

CREATE TABLE IF NOT EXISTS `phpbt_bookmark` (
  `user_id` int(10) unsigned NOT NULL DEFAULT '0',
  `bug_id` int(10) unsigned NOT NULL DEFAULT '0',
  KEY `bug_id_bookmark` (`bug_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `phpbt_bug`
--

CREATE TABLE IF NOT EXISTS `phpbt_bug` (
  `bug_id` int(10) unsigned NOT NULL DEFAULT '0',
  `title` varchar(100) NOT NULL DEFAULT '',
  `description` text NOT NULL,
  `url` varchar(255) NOT NULL DEFAULT '',
  `severity_id` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `priority` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `status_id` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `resolution_id` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `database_id` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `site_id` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `assigned_to` int(10) unsigned NOT NULL DEFAULT '0',
  `created_by` int(10) unsigned NOT NULL DEFAULT '0',
  `created_date` bigint(20) unsigned NOT NULL DEFAULT '0',
  `last_modified_by` int(10) unsigned NOT NULL DEFAULT '0',
  `last_modified_date` bigint(20) unsigned NOT NULL DEFAULT '0',
  `project_id` int(10) unsigned NOT NULL DEFAULT '0',
  `version_id` int(10) unsigned NOT NULL DEFAULT '0',
  `component_id` int(10) unsigned NOT NULL DEFAULT '0',
  `os_id` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `browser_string` varchar(255) NOT NULL DEFAULT '',
  `close_date` bigint(20) unsigned NOT NULL DEFAULT '0',
  `closed_in_version_id` int(10) unsigned NOT NULL DEFAULT '0',
  `to_be_closed_in_version_id` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`bug_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `phpbt_bug_cc`
--

CREATE TABLE IF NOT EXISTS `phpbt_bug_cc` (
  `bug_id` int(10) unsigned NOT NULL DEFAULT '0',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0',
  `created_by` int(10) unsigned NOT NULL DEFAULT '0',
  `created_date` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`bug_id`,`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `phpbt_bug_dependency`
--

CREATE TABLE IF NOT EXISTS `phpbt_bug_dependency` (
  `bug_id` int(10) unsigned NOT NULL DEFAULT '0',
  `depends_on` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`bug_id`,`depends_on`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `phpbt_bug_group`
--

CREATE TABLE IF NOT EXISTS `phpbt_bug_group` (
  `bug_id` int(10) unsigned NOT NULL DEFAULT '0',
  `group_id` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`bug_id`,`group_id`),
  KEY `group_id` (`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `phpbt_bug_history`
--

CREATE TABLE IF NOT EXISTS `phpbt_bug_history` (
  `bug_id` int(10) unsigned NOT NULL DEFAULT '0',
  `changed_field` varchar(30) NOT NULL DEFAULT '',
  `old_value` varchar(255) NOT NULL DEFAULT '',
  `new_value` varchar(255) NOT NULL DEFAULT '',
  `created_by` int(10) unsigned NOT NULL DEFAULT '0',
  `created_date` bigint(20) unsigned NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `phpbt_bug_seq`
--

CREATE TABLE IF NOT EXISTS `phpbt_bug_seq` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `phpbt_bug_vote`
--

CREATE TABLE IF NOT EXISTS `phpbt_bug_vote` (
  `user_id` int(10) unsigned NOT NULL DEFAULT '0',
  `bug_id` int(10) unsigned NOT NULL DEFAULT '0',
  `created_date` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`user_id`,`bug_id`),
  KEY `bug_id` (`bug_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `phpbt_comment`
--

CREATE TABLE IF NOT EXISTS `phpbt_comment` (
  `comment_id` int(10) unsigned NOT NULL DEFAULT '0',
  `bug_id` int(10) unsigned NOT NULL DEFAULT '0',
  `comment_text` text NOT NULL,
  `created_by` int(10) unsigned NOT NULL DEFAULT '0',
  `created_date` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`comment_id`),
  KEY `bug_id_comment` (`bug_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `phpbt_comment_seq`
--

CREATE TABLE IF NOT EXISTS `phpbt_comment_seq` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `phpbt_component`
--

CREATE TABLE IF NOT EXISTS `phpbt_component` (
  `component_id` int(10) unsigned NOT NULL DEFAULT '0',
  `project_id` int(10) unsigned NOT NULL DEFAULT '0',
  `component_name` varchar(30) NOT NULL DEFAULT '',
  `component_desc` text NOT NULL,
  `owner` int(10) unsigned NOT NULL DEFAULT '0',
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `sort_order` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `created_by` int(10) unsigned NOT NULL DEFAULT '0',
  `created_date` bigint(20) unsigned NOT NULL DEFAULT '0',
  `last_modified_by` int(10) unsigned NOT NULL DEFAULT '0',
  `last_modified_date` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`component_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `phpbt_component`
--

INSERT INTO `phpbt_component` (`component_id`, `project_id`, `component_name`, `component_desc`, `owner`, `active`, `sort_order`, `created_by`, `created_date`, `last_modified_by`, `last_modified_date`) VALUES
(1, 1, 'test component', 'test component', 0, 1, 0, 1, 1426176329, 1, 1426176329),
(2, 2, '2', '2', 0, 1, 0, 1, 1426176715, 1, 1426176715);

-- --------------------------------------------------------

--
-- Table structure for table `phpbt_component_seq`
--

CREATE TABLE IF NOT EXISTS `phpbt_component_seq` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `phpbt_component_seq`
--

INSERT INTO `phpbt_component_seq` (`id`) VALUES
(1),
(2),
(3);

-- --------------------------------------------------------

--
-- Table structure for table `phpbt_configuration`
--

CREATE TABLE IF NOT EXISTS `phpbt_configuration` (
  `varname` char(40) NOT NULL DEFAULT '',
  `varvalue` char(255) NOT NULL DEFAULT '',
  `description` char(255) NOT NULL DEFAULT '',
  `vartype` char(20) NOT NULL DEFAULT '',
  PRIMARY KEY (`varname`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `phpbt_configuration`
--

INSERT INTO `phpbt_configuration` (`varname`, `varvalue`, `description`, `vartype`) VALUES
('ADMIN_EMAIL', 'phpbt@app4.com', 'The email address used in correspondence from the bug tracker', 'string'),
('ATTACHMENT_MAX_SIZE', '2097152', 'Maximum size (in bytes) of an attachment. This will not override the settings in php.ini if php.ini has a lower limit.', 'string'),
('ATTACHMENT_PATH', 'attachments', 'Sub-dir of the INSTALLPATH - Needs to be writeable by the web process', 'string'),
('BUG_ASSIGNED', '3', 'The status to assign a bug when it is assigned.', 'multi'),
('BUG_PROMOTED', '2', 'The status to assign a bug when it is promoted (if enabled).', 'multi'),
('BUG_REOPENED', '6', 'The status to assign a bug when it is reopened.', 'multi'),
('BUG_UNCONFIRMED', '1', 'The status to assign a bug when it is first submitted.', 'multi'),
('CVS_WEB', 'http://cvs.sourceforge.net/cgi-bin/viewcvs.cgi/phpbt/phpbt/', 'Location of your cvs web interface (see format_comments() in bug.php)', 'string'),
('DATE_FORMAT', 'Y-m-d', 'See the <a href="http://www.php.net/date" target="_new">date page</a> in the PHP manual for more info', 'string'),
('DB_VERSION', '20', 'Database Version <b>Warning:</b> Changing this might make things go horribly wrong, so do not change it.', 'mixed'),
('EMAIL_DISABLED', '0', 'Whether to disable all mail sent from the system', 'bool'),
('EMAIL_IS_LOGIN', '1', 'Whether to use email addresses as logins', 'bool'),
('ENCRYPT_PASS', '0', 'Whether to store passwords encrypted.  <b>Warning:</b> Changing this after users have been created will result in their being unable to login.', 'bool'),
('FORCE_LOGIN', '0', 'Force users to login before being able to use the bug tracker', 'bool'),
('HIDE_EMAIL', '1', 'Should email addresses be hidden for those not logged in?', 'bool'),
('INSTALL_URL', 'https://app4.com/', 'The base URL of the phpBugTracker installation', 'string'),
('JPGRAPH_PATH', '', 'If not in the include path.  This is the file path on the web server, not a URL.', 'string'),
('LANGUAGE', 'en', 'The language file to use for warning and error messages', 'multi'),
('MASK_EMAIL', '1', 'Should email addresses have . changed to ''dot'' and @ change to ''at''?', 'bool'),
('MAX_USER_VOTES', '5', 'The maximum number of votes a user can cast across all bugs (Set to 0 to have no limit)', 'string'),
('NEW_ACCOUNTS_DISABLED', '0', 'Only admins can create new user accounts - newaccount.php is disabled', 'bool'),
('NEW_ACCOUNTS_GROUP', 'User', 'The group assigned to new user accounts', 'string'),
('PROMOTE_VOTES', '5', 'The number of votes required to promote a bug from Unconfirmed to New (Set to 0 to disable promotions by voting)', 'string'),
('RECALL_LOGIN', '0', 'Enable use of cookies to store username between logins', 'bool'),
('SEND_MIME_EMAIL', '1', 'Whether to use MIME quoted-printable encoded emails or not', 'bool'),
('SHOW_PROJECT_SUMMARIES', '1', 'Itemize bug stats by project on the home page', 'bool'),
('STRICT_UPDATING', '0', 'Only the bug reporter, bug owner, managers, and admins can change a bug', 'bool'),
('STYLE', 'default', 'The CSS file to use (color scheme)', 'multi'),
('THEME', 'default', 'Which set of templates to use', 'multi'),
('TIME_FORMAT', 'g:i A', 'See the <a href="http://www.php.net/date" target="_new">date page</a> in the PHP manual for more info', 'string'),
('USE_JPGRAPH', '0', 'Whether to show some reports as images', 'bool'),
('USE_PRIORITY_COLOR', '1', 'Should the query list use the priority colors as the field background color', 'bool'),
('USE_PRIORITY_COLOR_LINE', '0', 'Should the query list use the priority colors as the row background color', 'bool'),
('USE_SEVERITY_COLOR', '1', 'Should the query list use the severity colors as the field background color', 'bool'),
('USE_SEVERITY_COLOR_LINE', '0', 'Should the query list use the severity colors as the row background color (like SourceForge)', 'bool');

-- --------------------------------------------------------

--
-- Table structure for table `phpbt_database_server`
--

CREATE TABLE IF NOT EXISTS `phpbt_database_server` (
  `database_id` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `database_name` varchar(40) NOT NULL DEFAULT '',
  `sort_order` tinyint(3) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`database_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `phpbt_database_server`
--

INSERT INTO `phpbt_database_server` (`database_id`, `database_name`, `sort_order`) VALUES
(1, 'dfs', 0),
(2, 'ffdsa', 0);

-- --------------------------------------------------------

--
-- Table structure for table `phpbt_database_server_seq`
--

CREATE TABLE IF NOT EXISTS `phpbt_database_server_seq` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `phpbt_database_server_seq`
--

INSERT INTO `phpbt_database_server_seq` (`id`) VALUES
(1),
(2);

-- --------------------------------------------------------

--
-- Table structure for table `phpbt_group_perm`
--

CREATE TABLE IF NOT EXISTS `phpbt_group_perm` (
  `group_id` int(10) unsigned NOT NULL DEFAULT '0',
  `perm_id` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`group_id`,`perm_id`),
  KEY `perm_id` (`perm_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `phpbt_group_perm`
--

INSERT INTO `phpbt_group_perm` (`group_id`, `perm_id`) VALUES
(1, 1),
(3, 2),
(3, 3),
(4, 3),
(3, 4),
(3, 5),
(7, 5),
(3, 6),
(4, 6),
(9, 6),
(3, 7),
(4, 7),
(7, 7),
(8, 7),
(9, 7),
(3, 8),
(8, 8),
(9, 8),
(3, 9),
(8, 9),
(9, 9),
(3, 10),
(9, 10),
(3, 11),
(8, 11),
(9, 11),
(3, 12),
(4, 12),
(3, 13),
(4, 13),
(9, 13),
(3, 14),
(4, 14);

-- --------------------------------------------------------

--
-- Table structure for table `phpbt_os`
--

CREATE TABLE IF NOT EXISTS `phpbt_os` (
  `os_id` int(10) unsigned NOT NULL DEFAULT '0',
  `os_name` char(30) NOT NULL DEFAULT '',
  `sort_order` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `regex` char(40) NOT NULL DEFAULT '',
  PRIMARY KEY (`os_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `phpbt_os`
--

INSERT INTO `phpbt_os` (`os_id`, `os_name`, `sort_order`, `regex`) VALUES
(1, 'N/A', 1, '');

-- --------------------------------------------------------

--
-- Table structure for table `phpbt_os_seq`
--

CREATE TABLE IF NOT EXISTS `phpbt_os_seq` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=32 ;

--
-- Dumping data for table `phpbt_os_seq`
--

INSERT INTO `phpbt_os_seq` (`id`) VALUES
(31);

-- --------------------------------------------------------

--
-- Table structure for table `phpbt_priority`
--

CREATE TABLE IF NOT EXISTS `phpbt_priority` (
  `priority_id` int(10) unsigned NOT NULL DEFAULT '0',
  `priority_name` varchar(30) NOT NULL DEFAULT '',
  `priority_desc` text NOT NULL,
  `sort_order` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `priority_color` varchar(10) NOT NULL DEFAULT '#FFFFFF',
  PRIMARY KEY (`priority_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `phpbt_priority`
--

INSERT INTO `phpbt_priority` (`priority_id`, `priority_name`, `priority_desc`, `sort_order`, `priority_color`) VALUES
(1, 'Low', 'Fix if possible', 1, '#dadada'),
(2, 'Medium Low', 'Must fix before final', 2, '#dad0d0'),
(3, 'Medium', 'Fix before next milestone (alpha, beta, etc.)', 3, '#dac0c0'),
(4, 'Medium High', 'Fix as soon as possible', 4, '#dab0b0'),
(5, 'High', 'Fix immediately', 5, '#ff9999');

-- --------------------------------------------------------

--
-- Table structure for table `phpbt_priority_seq`
--

CREATE TABLE IF NOT EXISTS `phpbt_priority_seq` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=6 ;

--
-- Dumping data for table `phpbt_priority_seq`
--

INSERT INTO `phpbt_priority_seq` (`id`) VALUES
(5);

-- --------------------------------------------------------

--
-- Table structure for table `phpbt_project`
--

CREATE TABLE IF NOT EXISTS `phpbt_project` (
  `project_id` int(10) unsigned NOT NULL DEFAULT '0',
  `project_name` varchar(30) NOT NULL DEFAULT '',
  `project_desc` text NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `created_by` int(10) unsigned NOT NULL DEFAULT '0',
  `created_date` bigint(20) unsigned NOT NULL DEFAULT '0',
  `last_modified_by` int(10) unsigned NOT NULL DEFAULT '0',
  `last_modified_date` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`project_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `phpbt_project`
--

INSERT INTO `phpbt_project` (`project_id`, `project_name`, `project_desc`, `active`, `created_by`, `created_date`, `last_modified_by`, `last_modified_date`) VALUES
(1, 'test project', 'test project', 1, 1, 1426176329, 0, 0),
(2, '2', '2', 1, 1, 1426176715, 0, 0),
(3, '1', '1', 1, 1, 1426176783, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `phpbt_project_group`
--

CREATE TABLE IF NOT EXISTS `phpbt_project_group` (
  `project_id` int(10) unsigned NOT NULL DEFAULT '0',
  `group_id` int(10) unsigned NOT NULL DEFAULT '0',
  `created_by` int(10) unsigned NOT NULL DEFAULT '0',
  `created_date` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`project_id`,`group_id`),
  KEY `group_id` (`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `phpbt_project_perm`
--

CREATE TABLE IF NOT EXISTS `phpbt_project_perm` (
  `project_id` int(11) NOT NULL DEFAULT '0',
  `user_id` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `phpbt_project_seq`
--

CREATE TABLE IF NOT EXISTS `phpbt_project_seq` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `phpbt_project_seq`
--

INSERT INTO `phpbt_project_seq` (`id`) VALUES
(1),
(2),
(3);

-- --------------------------------------------------------

--
-- Table structure for table `phpbt_resolution`
--

CREATE TABLE IF NOT EXISTS `phpbt_resolution` (
  `resolution_id` int(10) unsigned NOT NULL DEFAULT '0',
  `resolution_name` varchar(30) NOT NULL DEFAULT '',
  `resolution_desc` text NOT NULL,
  `sort_order` tinyint(3) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`resolution_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `phpbt_resolution`
--

INSERT INTO `phpbt_resolution` (`resolution_id`, `resolution_name`, `resolution_desc`, `sort_order`) VALUES
(1, 'Fixed', 'Bug was eliminated', 1),
(2, 'Not a bug', 'It''s not a bug -- it''s a feature!', 2),
(3, 'Won''t Fix', 'This bug will stay', 3),
(4, 'Deferred', 'We''ll get around to it later', 4),
(5, 'Works for me', 'Can''t replicate the bug', 5),
(6, 'Duplicate', '', 6);

-- --------------------------------------------------------

--
-- Table structure for table `phpbt_resolution_seq`
--

CREATE TABLE IF NOT EXISTS `phpbt_resolution_seq` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=7 ;

--
-- Dumping data for table `phpbt_resolution_seq`
--

INSERT INTO `phpbt_resolution_seq` (`id`) VALUES
(6);

-- --------------------------------------------------------

--
-- Table structure for table `phpbt_saved_query`
--

CREATE TABLE IF NOT EXISTS `phpbt_saved_query` (
  `saved_query_id` int(10) unsigned NOT NULL DEFAULT '0',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0',
  `saved_query_name` varchar(40) NOT NULL DEFAULT '',
  `saved_query_string` text NOT NULL,
  PRIMARY KEY (`saved_query_id`,`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `phpbt_severity`
--

CREATE TABLE IF NOT EXISTS `phpbt_severity` (
  `severity_id` int(10) unsigned NOT NULL DEFAULT '0',
  `severity_name` varchar(30) NOT NULL DEFAULT '',
  `severity_desc` text NOT NULL,
  `sort_order` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `severity_color` varchar(10) NOT NULL DEFAULT '#FFFFFF',
  PRIMARY KEY (`severity_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `phpbt_severity`
--

INSERT INTO `phpbt_severity` (`severity_id`, `severity_name`, `severity_desc`, `sort_order`, `severity_color`) VALUES
(1, 'Unassigned', 'Default bug creation', 1, '#dadada'),
(2, 'Idea', 'Ideas for further development', 2, '#dad0d0'),
(3, 'Feature Request', 'Requests for specific features', 3, '#dacaca'),
(4, 'Annoyance', 'Cosmetic problems or bugs not affecting performance', 4, '#dac0c0'),
(5, 'Content', 'Non-functional related bugs, such as text content', 5, '#dababa'),
(6, 'Significant', 'A bug affecting the intended performance of the product', 6, '#dab0b0'),
(7, 'Critical', 'A bug severe enough to prevent the release of the product', 7, '#ff9999');

-- --------------------------------------------------------

--
-- Table structure for table `phpbt_severity_seq`
--

CREATE TABLE IF NOT EXISTS `phpbt_severity_seq` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=9 ;

--
-- Dumping data for table `phpbt_severity_seq`
--

INSERT INTO `phpbt_severity_seq` (`id`) VALUES
(7),
(8);

-- --------------------------------------------------------

--
-- Table structure for table `phpbt_site`
--

CREATE TABLE IF NOT EXISTS `phpbt_site` (
  `site_id` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `site_name` varchar(50) NOT NULL DEFAULT '',
  `sort_order` tinyint(3) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`site_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `phpbt_site`
--

INSERT INTO `phpbt_site` (`site_id`, `site_name`, `sort_order`) VALUES
(0, 'N/A', 1),
(5, 'hello', 0);

-- --------------------------------------------------------

--
-- Table structure for table `phpbt_site_seq`
--

CREATE TABLE IF NOT EXISTS `phpbt_site_seq` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=6 ;

--
-- Dumping data for table `phpbt_site_seq`
--

INSERT INTO `phpbt_site_seq` (`id`) VALUES
(4),
(5);

-- --------------------------------------------------------

--
-- Table structure for table `phpbt_status`
--

CREATE TABLE IF NOT EXISTS `phpbt_status` (
  `status_id` int(10) unsigned NOT NULL DEFAULT '0',
  `status_name` varchar(30) NOT NULL DEFAULT '',
  `status_desc` text NOT NULL,
  `sort_order` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `bug_open` tinyint(1) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`status_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `phpbt_status`
--

INSERT INTO `phpbt_status` (`status_id`, `status_name`, `status_desc`, `sort_order`, `bug_open`) VALUES
(1, 'New Report', 'Newly submitted report.', 1, 1),
(2, 'Reviewed', 'Module owner has looked at report, properly categorized it.', 2, 1),
(3, 'Assigned', 'Assigned to a developer.', 3, 1),
(4, 'Needs QA', 'Set by engineer with a resolution, needs to be verified.', 4, 1),
(5, 'Verified', 'The resolution is confirmed by the reporter', 5, 1),
(6, 'Reopened', 'Closed but opened again for further inspection', 6, 1),
(7, 'Closed', 'The bug is officially squashed.', 7, 0);

-- --------------------------------------------------------

--
-- Table structure for table `phpbt_status_seq`
--

CREATE TABLE IF NOT EXISTS `phpbt_status_seq` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=10 ;

--
-- Dumping data for table `phpbt_status_seq`
--

INSERT INTO `phpbt_status_seq` (`id`) VALUES
(7),
(8),
(9);

-- --------------------------------------------------------

--
-- Table structure for table `phpbt_user_group`
--

CREATE TABLE IF NOT EXISTS `phpbt_user_group` (
  `user_id` int(10) unsigned NOT NULL DEFAULT '0',
  `group_id` int(10) unsigned NOT NULL DEFAULT '0',
  `created_by` int(10) unsigned NOT NULL DEFAULT '0',
  `created_date` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`user_id`,`group_id`),
  KEY `group_id` (`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `phpbt_user_group`
--

INSERT INTO `phpbt_user_group` (`user_id`, `group_id`, `created_by`, `created_date`) VALUES
(1, 1, 0, 0),
(2, 4, 1, 1426442533),
(3, 3, 1, 1426442497),
(4, 2, 1, 1426442688);

-- --------------------------------------------------------

--
-- Table structure for table `phpbt_user_perm`
--

CREATE TABLE IF NOT EXISTS `phpbt_user_perm` (
  `user_id` int(10) unsigned NOT NULL DEFAULT '0',
  `perm_id` int(10) unsigned NOT NULL DEFAULT '0',
  `created_by` int(10) unsigned NOT NULL DEFAULT '0',
  `created_date` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`user_id`,`perm_id`),
  KEY `perm_id` (`perm_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `phpbt_user_pref`
--

CREATE TABLE IF NOT EXISTS `phpbt_user_pref` (
  `user_id` int(11) NOT NULL DEFAULT '0',
  `email_notices` tinyint(1) NOT NULL DEFAULT '1',
  `saved_queries` tinyint(1) NOT NULL DEFAULT '1',
  `def_results` int(11) NOT NULL DEFAULT '20',
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `phpbt_user_pref`
--

INSERT INTO `phpbt_user_pref` (`user_id`, `email_notices`, `saved_queries`, `def_results`) VALUES
(0, 1, 1, 20),
(1, 1, 1, 20),
(2, 0, 1, 20),
(3, 0, 1, 20),
(4, 0, 1, 20);

-- --------------------------------------------------------

--
-- Table structure for table `phpbt_version`
--

CREATE TABLE IF NOT EXISTS `phpbt_version` (
  `version_id` int(10) unsigned NOT NULL DEFAULT '0',
  `project_id` int(10) unsigned NOT NULL DEFAULT '0',
  `version_name` char(30) NOT NULL DEFAULT '',
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `sort_order` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `created_by` int(10) unsigned NOT NULL DEFAULT '0',
  `created_date` bigint(20) unsigned NOT NULL DEFAULT '0',
  `last_modified_by` int(10) unsigned NOT NULL DEFAULT '0',
  `last_modified_date` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`version_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `phpbt_version`
--

INSERT INTO `phpbt_version` (`version_id`, `project_id`, `version_name`, `active`, `sort_order`, `created_by`, `created_date`, `last_modified_by`, `last_modified_date`) VALUES
(1, 1, '1', 1, 0, 1, 1426176329, 0, 0),
(2, 2, '2', 1, 0, 1, 1426176715, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `phpbt_version_seq`
--

CREATE TABLE IF NOT EXISTS `phpbt_version_seq` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `phpbt_version_seq`
--

INSERT INTO `phpbt_version_seq` (`id`) VALUES
(1),
(2),
(3);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
