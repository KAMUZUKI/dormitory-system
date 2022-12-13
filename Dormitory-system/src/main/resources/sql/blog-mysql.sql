/*
 Navicat Premium Data Transfer

 Source Server         : localManager
 Source Server Type    : MySQL
 Source Server Version : 50727
 Source Host           : localhost:3306
 Source Schema         : studentsystem

 Target Server Type    : MySQL
 Target Server Version : 50727
 File Encoding         : 65001

 Date: 08/12/2022 15:33:44
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for academy
-- ----------------------------
DROP TABLE IF EXISTS `academy`;
CREATE TABLE `academy`  (
                            `id` int(5) NOT NULL AUTO_INCREMENT COMMENT ' 学院id',
                            `aname` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '学院名称',
                            PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of academy
-- ----------------------------
INSERT INTO `academy` VALUES (1, '计算机科学与工程学院');
INSERT INTO `academy` VALUES (2, '智能制造与机械工程学院');
INSERT INTO `academy` VALUES (3, '安全与环境工程学院 ');
INSERT INTO `academy` VALUES (4, '理学院');
INSERT INTO `academy` VALUES (5, '设计艺术学院 ');
INSERT INTO `academy` VALUES (6, '外国语学院');
INSERT INTO `academy` VALUES (7, '国际教育学院');
INSERT INTO `academy` VALUES (8, '\r\n材料科学与工程学院');
INSERT INTO `academy` VALUES (9, '\r\n电气与信息工程学院');
INSERT INTO `academy` VALUES (10, '\r\n土木与建筑工程学院');

-- ----------------------------
-- Table structure for leaveschool
-- ----------------------------
DROP TABLE IF EXISTS `leaveschool`;
CREATE TABLE `leaveschool`  (
                                `id` int(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
                                `sno` int(20) NOT NULL COMMENT '学生学号',
                                `sname` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '学生名字',
                                `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '学生手机号',
                                `purpose` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '学生离校原因',
                                `leaveTime` datetime NOT NULL COMMENT '离校时间',
                                `backTime` datetime NOT NULL COMMENT '返校时间',
                                `managerid` int(5) NOT NULL COMMENT '执行人id',
                                PRIMARY KEY (`id`) USING BTREE,
                                INDEX `sname`(`sname`) USING BTREE,
                                INDEX `lsphone`(`phone`) USING BTREE,
                                INDEX `lsmanager`(`managerid`) USING BTREE,
                                INDEX `sno`(`sno`) USING BTREE,
                                CONSTRAINT `lsmanager` FOREIGN KEY (`managerid`) REFERENCES `manager` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
                                CONSTRAINT `lsphone` FOREIGN KEY (`phone`) REFERENCES `student` (`phone`) ON DELETE CASCADE ON UPDATE CASCADE,
                                CONSTRAINT `sname` FOREIGN KEY (`sname`) REFERENCES `student` (`sname`) ON DELETE CASCADE ON UPDATE CASCADE,
                                CONSTRAINT `sno` FOREIGN KEY (`sno`) REFERENCES `student` (`sno`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 51 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of leaveschool
-- ----------------------------
INSERT INTO `leaveschool` VALUES (1, 46, '孙子异', '136-0416-9266', 'It collects process metrics such as CPU load, RAM usage, and a variety of other resources over SSH/SNMP. It is used while your ISPs do not allow direct connections, but allows establishing HTTP connec', '2021-06-15 00:05:27', '2002-01-10 03:58:43', 3);
INSERT INTO `leaveschool` VALUES (2, 50, '段詩涵', '160-6768-8783', 'Navicat is a multi-connections Database Administration tool allowing you to connect to MySQL, Oracle, PostgreSQL, SQLite, SQL Server, MariaDB and/or MongoDB databases, making database administration t', '2022-09-12 08:49:34', '2002-10-11 21:19:28', 1);
INSERT INTO `leaveschool` VALUES (3, 8, '蔡嘉伦', '196-8946-1423', 'What you get by achieving your goals is not as important as what you become by achieving your goals. Export Wizard allows you to export data from tables, collections, views, or query results to any av', '2011-11-29 11:46:25', '2001-02-16 18:22:54', 2);
INSERT INTO `leaveschool` VALUES (4, 8, '蔡嘉伦', '196-8946-1423', 'How we spend our days is, of course, how we spend our lives. SSH serves to prevent such vulnerabilities and allows you to access a remote server\'s shell without compromising security.', '2002-03-23 01:16:48', '2019-04-12 11:10:45', 10);
INSERT INTO `leaveschool` VALUES (5, 22, '宋子韬', '138-6246-6454', 'Remember that failure is an event, not a person. Actually it is just in an idea when feel oneself can achieve and cannot achieve.', '2019-01-18 19:31:46', '2001-07-26 00:36:10', 1);
INSERT INTO `leaveschool` VALUES (6, 6, '廖嘉伦', '142-3879-4302', 'To successfully establish a new connection to local/remote server - no matter via SSL, SSH or HTTP, set the database login information in the General tab. To start working with your server in Navicat,', '2004-12-20 05:00:55', '2016-05-16 01:01:23', 3);
INSERT INTO `leaveschool` VALUES (7, 36, '姚子韬', '135-9518-9084', 'In the middle of winter I at last discovered that there was in me an invincible summer. Navicat 15 has added support for the system-wide dark mode. Navicat Cloud could not connect and access your data', '2005-10-15 11:41:03', '2000-07-09 00:45:07', 8);
INSERT INTO `leaveschool` VALUES (8, 1, '金云熙', '755-831-6430', 'I may not have gone where I intended to go, but I think I have ended up where I needed to be. You will succeed because most people are lazy. You will succeed because most people are lazy. I will greet', '2011-09-27 21:21:16', '2019-07-30 09:01:41', 5);
INSERT INTO `leaveschool` VALUES (9, 27, '汪云熙', '165-9382-6307', 'Navicat allows you to transfer data from one database and/or schema to another with detailed analytical process.', '2012-03-08 02:15:38', '2004-01-19 18:55:26', 9);
INSERT INTO `leaveschool` VALUES (10, 44, '曾詩涵', '158-9432-9688', 'All the Navicat Cloud objects are located under different projects. You can share the project to other Navicat Cloud accounts for collaboration. What you get by achieving your goals is not as importan', '2002-09-05 01:24:55', '2011-12-30 10:36:50', 8);
INSERT INTO `leaveschool` VALUES (11, 42, '郭晓明', '755-0609-8796', 'Navicat is a multi-connections Database Administration tool allowing you to connect to MySQL, Oracle, PostgreSQL, SQLite, SQL Server, MariaDB and/or MongoDB databases, making database administration t', '2003-12-21 01:14:55', '2014-06-07 15:02:35', 3);
INSERT INTO `leaveschool` VALUES (12, 5, '谢秀英', '20-961-5988', 'The Navigation pane employs tree structure which allows you to take action upon the database and their objects through their pop-up menus quickly and easily. You must be the change you wish to see in ', '2018-01-21 03:38:26', '2009-07-10 13:01:57', 10);
INSERT INTO `leaveschool` VALUES (13, 27, '汪云熙', '165-9382-6307', 'After comparing data, the window shows the number of records that will be inserted, updated or deleted in the target. Anyone who has ever made anything of importance was disciplined.', '2007-01-17 16:53:09', '2003-04-29 07:05:49', 1);
INSERT INTO `leaveschool` VALUES (14, 5, '谢秀英', '20-961-5988', 'Navicat Monitor requires a repository to store alerts and metrics for historical analysis. HTTP Tunneling is a method for connecting to a server that uses the same protocol (http://) and the same port', '2010-08-18 18:24:08', '2004-09-20 03:39:45', 7);
INSERT INTO `leaveschool` VALUES (15, 27, '汪云熙', '165-9382-6307', 'To clear or reload various internal caches, flush tables, or acquire locks, control-click your connection in the Navigation pane and select Flush and choose the flush option. You must have the reload ', '2010-11-30 16:20:12', '2000-04-19 10:15:26', 1);
INSERT INTO `leaveschool` VALUES (16, 43, '崔子异', '141-4629-8815', 'I may not have gone where I intended to go, but I think I have ended up where I needed to be. Such sessions are also susceptible to session hijacking, where a malicious user takes over your session on', '2015-11-28 03:38:43', '2010-05-05 13:07:49', 3);
INSERT INTO `leaveschool` VALUES (17, 5, '谢秀英', '20-961-5988', 'Navicat provides powerful tools for working with queries: Query Editor for editing the query text directly, and Query Builder, Find Builder or Aggregate Builder for building queries visually.', '2018-02-25 13:07:23', '2008-05-22 20:04:11', 1);
INSERT INTO `leaveschool` VALUES (18, 50, '段詩涵', '160-6768-8783', 'Typically, it is employed as an encrypted version of Telnet. A man is not old until regrets take the place of dreams. The first step is as good as half over. You must be the change you wish to see in ', '2008-05-14 20:44:09', '2016-11-08 21:47:17', 3);
INSERT INTO `leaveschool` VALUES (19, 5, '谢秀英', '20-961-5988', 'It provides strong authentication and secure encrypted communications between two hosts, known as SSH Port Forwarding (Tunneling), over an insecure network.', '2009-05-24 13:08:15', '2007-02-06 18:21:06', 9);
INSERT INTO `leaveschool` VALUES (20, 15, '薛子异', '197-6708-3902', 'Navicat 15 has added support for the system-wide dark mode. The past has no power over the present moment. If the plan doesn’t work, change the plan, but never the goal.', '2003-10-29 23:56:35', '2015-02-12 21:30:25', 4);
INSERT INTO `leaveschool` VALUES (21, 21, '石安琪', '175-5761-1498', 'Navicat Cloud could not connect and access your databases. By which it means, it could only store your connection settings, queries, model files, and virtual group; your database passwords and data (e', '2010-04-21 09:34:56', '2015-08-18 14:36:12', 7);
INSERT INTO `leaveschool` VALUES (22, 15, '薛子异', '197-6708-3902', 'Always keep your eyes open. Keep watching. Because whatever you see can inspire you. Creativity is intelligence having fun. A comfort zone is a beautiful place, but nothing ever grows there.', '2010-12-16 03:02:50', '2005-04-01 21:31:13', 8);
INSERT INTO `leaveschool` VALUES (23, 9, '毛杰宏', '163-6829-7137', 'To open a query using an external editor, control-click it and select Open with External Editor. You can set the file path of an external editor in Preferences. After logged in the Navicat Cloud featu', '2013-02-02 22:39:36', '2000-09-24 08:08:54', 10);
INSERT INTO `leaveschool` VALUES (24, 40, '范岚', '187-6354-6829', 'Genius is an infinite capacity for taking pains. All journeys have secret destinations of which the traveler is unaware. Secure Sockets Layer(SSL) is a protocol for transmitting private documents via ', '2019-01-28 07:46:55', '2019-05-01 06:47:51', 10);
INSERT INTO `leaveschool` VALUES (25, 10, '邹睿', '28-3224-5069', 'If you wait, all that happens is you get older. Genius is an infinite capacity for taking pains. With its well-designed Graphical User Interface(GUI), Navicat lets you quickly and easily create, organ', '2018-03-09 14:11:59', '2009-07-23 16:06:04', 9);
INSERT INTO `leaveschool` VALUES (26, 26, '罗璐', '179-4543-5852', 'To successfully establish a new connection to local/remote server - no matter via SSL or SSH, set the database login information in the General tab.', '2004-02-20 23:04:37', '2002-04-08 06:06:34', 2);
INSERT INTO `leaveschool` VALUES (27, 23, '吴宇宁', '10-6077-8176', 'There is no way to happiness. Happiness is the way. Instead of wondering when your next vacation is, maybe you should set up a life you don’t need to escape from. After comparing data, the window sh', '2015-06-09 17:20:49', '2016-09-20 19:36:48', 7);
INSERT INTO `leaveschool` VALUES (28, 14, '陈璐', '769-003-8107', 'How we spend our days is, of course, how we spend our lives. The Main Window consists of several toolbars and panes for you to work on connections, database objects and advanced tools.', '2013-11-18 00:50:39', '2010-06-18 06:44:16', 8);
INSERT INTO `leaveschool` VALUES (29, 25, '郑杰宏', '755-0034-7204', 'The past has no power over the present moment. The Main Window consists of several toolbars and panes for you to work on connections, database objects and advanced tools.', '2007-12-13 18:48:07', '2013-07-05 10:43:30', 4);
INSERT INTO `leaveschool` VALUES (30, 46, '孙子异', '136-0416-9266', 'SSH serves to prevent such vulnerabilities and allows you to access a remote server\'s shell without compromising security.', '2017-05-01 10:53:55', '2002-05-25 21:28:05', 9);
INSERT INTO `leaveschool` VALUES (31, 25, '郑杰宏', '755-0034-7204', 'If the plan doesn’t work, change the plan, but never the goal. A man’s best friends are his ten fingers. The Synchronize to Database function will give you a full picture of all database differenc', '2001-03-03 21:16:51', '2022-08-31 18:25:38', 8);
INSERT INTO `leaveschool` VALUES (32, 26, '罗璐', '179-4543-5852', 'If your Internet Service Provider (ISP) does not provide direct access to its server, Secure Tunneling Protocol (SSH) / HTTP is another solution.', '2015-01-22 18:24:04', '2000-12-03 08:33:56', 6);
INSERT INTO `leaveschool` VALUES (33, 37, '龚子异', '769-6103-2410', 'Navicat Data Modeler is a powerful and cost-effective database design tool which helps you build high-quality conceptual, logical and physical data models. Champions keep playing until they get it rig', '2020-01-29 15:39:20', '2014-07-09 20:27:31', 4);
INSERT INTO `leaveschool` VALUES (34, 36, '姚子韬', '135-9518-9084', 'The Synchronize to Database function will give you a full picture of all database differences. All the Navicat Cloud objects are located under different projects. You can share the project to other Na', '2011-08-05 06:33:44', '2016-04-10 17:35:58', 6);
INSERT INTO `leaveschool` VALUES (35, 20, '许云熙', '20-134-6363', 'Flexible settings enable you to set up a custom key for comparison and synchronization. SQL Editor allows you to create and edit SQL text, prepare and execute selected queries.', '2015-07-25 10:07:20', '2022-09-20 14:58:15', 8);
INSERT INTO `leaveschool` VALUES (36, 9, '毛杰宏', '163-6829-7137', 'Navicat provides powerful tools for working with queries: Query Editor for editing the query text directly, and Query Builder, Find Builder or Aggregate Builder for building queries visually.', '2018-07-03 05:20:39', '2014-04-05 10:07:13', 4);
INSERT INTO `leaveschool` VALUES (37, 42, '郭晓明', '755-0609-8796', 'Success consists of going from failure to failure without loss of enthusiasm. You cannot save people, you can just love them. SSH serves to prevent such vulnerabilities and allows you to access a remo', '2011-11-17 22:11:59', '2007-07-23 07:25:33', 4);
INSERT INTO `leaveschool` VALUES (38, 20, '许云熙', '20-134-6363', 'Sometimes you win, sometimes you learn. SQL Editor allows you to create and edit SQL text, prepare and execute selected queries. It is used while your ISPs do not allow direct connections, but allows ', '2019-04-30 12:01:32', '2014-03-29 06:51:37', 7);
INSERT INTO `leaveschool` VALUES (39, 26, '罗璐', '179-4543-5852', 'If the Show objects under schema in navigation pane option is checked at the Preferences window, all database objects are also displayed in the pane.', '2016-05-25 08:17:49', '2005-05-21 19:15:45', 3);
INSERT INTO `leaveschool` VALUES (40, 42, '郭晓明', '755-0609-8796', 'Secure SHell (SSH) is a program to log in into another computer over a network, execute commands on a remote server, and move files from one machine to another. Creativity is intelligence having fun.', '2008-04-12 06:51:01', '2020-11-24 12:28:51', 5);
INSERT INTO `leaveschool` VALUES (41, 49, '武宇宁', '160-4774-5618', 'There is no way to happiness. Happiness is the way. The reason why a great man is great is that he resolves to be a great man.', '2021-05-25 19:09:47', '2004-07-30 07:46:28', 6);
INSERT INTO `leaveschool` VALUES (42, 11, '方云熙', '142-6546-7613', 'In the Objects tab, you can use the List List, Detail Detail and ER Diagram ER Diagram buttons to change the object view.', '2017-12-20 08:02:44', '2008-10-10 22:58:01', 1);
INSERT INTO `leaveschool` VALUES (43, 16, '韦云熙', '769-129-9363', 'The past has no power over the present moment. A query is used to extract data from the database in a readable format according to the user\'s request. To clear or reload various internal caches, flush', '2007-08-30 22:36:58', '2015-06-27 10:19:29', 6);
INSERT INTO `leaveschool` VALUES (44, 37, '龚子异', '769-6103-2410', 'Creativity is intelligence having fun. Monitored servers include MySQL, MariaDB and SQL Server, and compatible with cloud databases like Amazon RDS, Amazon Aurora, Oracle Cloud, Google Cloud and Micro', '2018-05-28 00:38:23', '2018-12-24 20:48:04', 10);
INSERT INTO `leaveschool` VALUES (45, 49, '武宇宁', '160-4774-5618', 'To start working with your server in Navicat, you should first establish a connection or several connections using the Connection window.', '2015-01-07 06:43:30', '2001-04-06 06:06:55', 10);
INSERT INTO `leaveschool` VALUES (46, 1, '金云熙', '755-831-6430', 'To successfully establish a new connection to local/remote server - no matter via SSL or SSH, set the database login information in the General tab.', '2019-10-26 15:48:33', '2004-06-06 01:18:59', 1);
INSERT INTO `leaveschool` VALUES (47, 12, '傅致远', '10-390-2043', 'Navicat Monitor requires a repository to store alerts and metrics for historical analysis. All journeys have secret destinations of which the traveler is unaware.', '2019-07-25 18:06:48', '2022-11-06 06:23:31', 4);
INSERT INTO `leaveschool` VALUES (48, 14, '陈璐', '769-003-8107', 'The Main Window consists of several toolbars and panes for you to work on connections, database objects and advanced tools. How we spend our days is, of course, how we spend our lives. To start workin', '2018-04-03 19:49:25', '2005-11-26 20:28:22', 9);
INSERT INTO `leaveschool` VALUES (49, 48, '范杰宏', '190-3419-7393', 'Such sessions are also susceptible to session hijacking, where a malicious user takes over your session once you have authenticated.', '2016-07-12 04:46:13', '2021-10-18 19:36:28', 6);
INSERT INTO `leaveschool` VALUES (50, 26, '罗璐', '179-4543-5852', 'To start working with your server in Navicat, you should first establish a connection or several connections using the Connection window.', '2019-08-16 09:02:02', '2014-09-01 07:25:41', 10);

-- ----------------------------
-- Table structure for manager
-- ----------------------------
DROP TABLE IF EXISTS `manager`;
CREATE TABLE `manager`  (
  `id` int(5) NOT NULL AUTO_INCREMENT COMMENT ' 管理id',
  `name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '管理名字',
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '管理手机号',
  `account` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '账号',
  `password` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '密码',
  `type` int(5) NOT NULL COMMENT '账号类型 0-全部权限  1-管理权限  2-查看权限',
  `status` binary(1) NOT NULL COMMENT '账号是否启用',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of manager
-- ----------------------------
INSERT INTO `manager` VALUES (1, '高子异', '20-925-6071', 'ziyg', '0cc175b9c0f1b6a831c399e269772661', 2, 0x31);
INSERT INTO `manager` VALUES (2, '李睿', '755-6062-4129', 'lir8', '0cc175b9c0f1b6a831c399e269772661', 1, 0x31);
INSERT INTO `manager` VALUES (3, '叶晓明', '164-5398-0588', 'xiy', '0cc175b9c0f1b6a831c399e269772661', 1, 0x31);
INSERT INTO `manager` VALUES (4, '赵致远', '28-087-6830', 'zhiyzhao', '0cc175b9c0f1b6a831c399e269772661', 1, 0x31);
INSERT INTO `manager` VALUES (5, '邵晓明', '20-397-6327', 'shaoxiaoming', '0cc175b9c0f1b6a831c399e269772661', 0, 0x31);
INSERT INTO `manager` VALUES (6, '林子韬', '187-2497-1678', 'zitaol', '0cc175b9c0f1b6a831c399e269772661', 1, 0x31);
INSERT INTO `manager` VALUES (7, '赵嘉伦', '20-5338-2264', 'zhao8', '0cc175b9c0f1b6a831c399e269772661', 2, 0x31);
INSERT INTO `manager` VALUES (8, '吴秀英', '185-3788-7960', 'xiuywu', '0cc175b9c0f1b6a831c399e269772661', 2, 0x31);
INSERT INTO `manager` VALUES (9, '曹宇宁', '175-1038-0339', 'caoyun331', '0cc175b9c0f1b6a831c399e269772661', 1, 0x31);
INSERT INTO `manager` VALUES (10, '许秀英', '190-4283-8021', 'xiuyixu327', '0cc175b9c0f1b6a831c399e269772661', 1, 0x31);

-- ----------------------------
-- Table structure for student
-- ----------------------------
DROP TABLE IF EXISTS `student`;
CREATE TABLE `student`  (
  `sno` int(20) NOT NULL AUTO_INCREMENT COMMENT '学号',
  `sname` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '名字',
  `age` int(11) NOT NULL COMMENT '年龄',
  `sex` bit(1) NOT NULL COMMENT '性别0女1男',
  `academy` int(5) NOT NULL COMMENT '学院id',
  `class` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '班级',
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '寝室住址',
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '手机号',
  PRIMARY KEY (`sno`) USING BTREE,
  INDEX `academyid`(`academy`) USING BTREE,
  INDEX `sname`(`sname`) USING BTREE,
  INDEX `phone`(`phone`) USING BTREE,
  CONSTRAINT `academyid` FOREIGN KEY (`academy`) REFERENCES `academy` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 51 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of student
-- ----------------------------
INSERT INTO `student` VALUES (1, '吴宇宁', 19, b'0', 9, '', '海淀区清河中街68号678号', '185-9212-0794');
INSERT INTO `student` VALUES (2, '方云熙', 27, b'1', 1, '', '福田区景田东一街341号', '755-0609-8796');
INSERT INTO `student` VALUES (3, '石安琪', 24, b'0', 5, '', '成华区二仙桥东三路811号', '160-4774-5618');
INSERT INTO `student` VALUES (4, '宋子韬', 22, b'0', 7, '', '浦东新区橄榄路336号', '141-1019-8043');
INSERT INTO `student` VALUES (5, '郭晓明', 25, b'0', 6, '', '东泰五街388号', '769-6103-2410');
INSERT INTO `student` VALUES (6, '蔡嘉伦', 25, b'0', 2, '', '福田区深南大道15号', '755-831-6430');
INSERT INTO `student` VALUES (7, '廖嘉伦', 25, b'1', 6, '', '越秀区中山二路46号', '20-961-5988');
INSERT INTO `student` VALUES (8, '郝晓明', 18, b'0', 5, '', '罗湖区田贝一路778号', '755-0034-7204');
INSERT INTO `student` VALUES (9, '薛子异', 19, b'1', 3, '', '东泰五街518号', '135-9518-9084');
INSERT INTO `student` VALUES (10, '崔子异', 25, b'1', 8, '', '海珠区江南西路899号', '142-6546-7613');
INSERT INTO `student` VALUES (11, '邵睿', 23, b'0', 3, '', '白云区机场路棠苑街五巷95号', '20-134-6363');
INSERT INTO `student` VALUES (12, '武宇宁', 20, b'0', 1, '', '成华区二仙桥东三路571号', '28-3224-5069');
INSERT INTO `student` VALUES (13, '范岚', 21, b'1', 1, '', '乐丰六路837号', '196-8946-1423');
INSERT INTO `student` VALUES (14, '龚宇宁', 25, b'1', 10, '', '天河区大信商圈大信南路289号', '760-748-6756');
INSERT INTO `student` VALUES (15, '胡子韬', 22, b'1', 6, '', '海淀区清河中街68号214号', '169-7425-0710');
INSERT INTO `student` VALUES (16, '谢秀英', 23, b'1', 10, '', '锦江区人民南路四段762号', '179-3348-1032');
INSERT INTO `student` VALUES (17, '郑杰宏', 22, b'1', 3, '', '浦东新区健祥路933号', '197-6708-3902');
INSERT INTO `student` VALUES (18, '许云熙', 24, b'1', 8, '', '西城区西長安街268号', '155-6288-4574');
INSERT INTO `student` VALUES (19, '陈璐', 20, b'0', 9, '', '成华区二仙桥东三路614号', '175-5761-1498');
INSERT INTO `student` VALUES (20, '程晓明', 21, b'0', 6, '', '珊瑚路579号', '769-129-9363');
INSERT INTO `student` VALUES (21, '郑杰宏', 26, b'0', 5, '', '朝阳区三里屯路13号', '10-430-2973');
INSERT INTO `student` VALUES (22, '段詩涵', 26, b'1', 2, '', '徐汇区虹桥路141号', '21-480-5409');
INSERT INTO `student` VALUES (23, '范杰宏', 20, b'1', 1, '', '东泰五街415号', '160-6768-8783');
INSERT INTO `student` VALUES (24, '毛杰宏', 20, b'1', 5, '', '东城区东单王府井东街619号', '165-9382-6307');
INSERT INTO `student` VALUES (25, '刘岚', 21, b'0', 8, '', '福田区深南大道882号', '141-4629-8815');
INSERT INTO `student` VALUES (26, '曾詩涵', 20, b'0', 5, '', '坑美十五巷562号', '769-003-8107');
INSERT INTO `student` VALUES (27, '邹睿', 20, b'1', 4, '', '东泰五街872号', '158-9432-9688');
INSERT INTO `student` VALUES (28, '吕云熙', 19, b'0', 4, '', '珊瑚路77号', '190-3419-7393');
INSERT INTO `student` VALUES (29, '曹睿', 28, b'0', 7, '', '天河区大信商圈大信南路154号', '163-6829-7137');
INSERT INTO `student` VALUES (30, '阎子韬', 19, b'0', 8, '', '珊瑚路562号', '769-9264-3207');
INSERT INTO `student` VALUES (31, '汪云熙', 30, b'1', 6, '', '罗湖区田贝一路192号', '179-4543-5852');
INSERT INTO `student` VALUES (32, '潘云熙', 27, b'1', 2, '', '浦东新区健祥路250号', '21-9072-2414');
INSERT INTO `student` VALUES (33, '许詩涵', 24, b'1', 9, '', '海淀区清河中街68号348号', '10-390-2043');
INSERT INTO `student` VALUES (34, '王晓明', 28, b'1', 1, '', '罗湖区清水河一路290号', '755-045-3541');
INSERT INTO `student` VALUES (35, '宋晓明', 18, b'1', 7, '', '海珠区江南西路762号', '138-6246-6454');
INSERT INTO `student` VALUES (36, '罗璐', 18, b'1', 1, '', '东城区东单王府井东街993号', '10-683-2080');
INSERT INTO `student` VALUES (37, '傅致远', 26, b'0', 10, '', '京华商圈华夏街434号', '760-8020-8858');
INSERT INTO `student` VALUES (38, '夏宇宁', 28, b'1', 10, '', '黄浦区淮海中路37号', '168-1521-0211');
INSERT INTO `student` VALUES (39, '邱安琪', 23, b'0', 4, '', '越秀区中山二路978号', '20-7643-3537');
INSERT INTO `student` VALUES (40, '钱致远', 29, b'1', 5, '', '房山区岳琉路132号', '136-0416-9266');
INSERT INTO `student` VALUES (41, '钟岚', 24, b'1', 4, '', '徐汇区虹桥路850号', '21-9247-7457');
INSERT INTO `student` VALUES (42, '姚子韬', 23, b'0', 8, '', '成华区玉双路6号274号', '142-3879-4302');
INSERT INTO `student` VALUES (43, '赵璐', 25, b'1', 2, '', '锦江区人民南路四段325号', '28-071-9260');
INSERT INTO `student` VALUES (44, '谭岚', 20, b'1', 3, '', '徐汇区虹桥路559号', '167-8581-9298');
INSERT INTO `student` VALUES (45, '龚子异', 30, b'1', 9, '', '龙岗区学园一巷409号', '755-915-8794');
INSERT INTO `student` VALUES (46, '韦云熙', 22, b'0', 1, '', '成华区二仙桥东三路465号', '28-989-9435');
INSERT INTO `student` VALUES (47, '金云熙', 24, b'0', 9, '', '徐汇区虹桥路115号', '187-6354-6829');
INSERT INTO `student` VALUES (48, '孙子异', 24, b'1', 5, '', '延庆区028县道417号', '10-6077-8176');
INSERT INTO `student` VALUES (49, '汪晓明', 27, b'1', 3, '', '紫马岭商圈中山五路832号', '760-0851-7618');
INSERT INTO `student` VALUES (50, '陈晓明', 23, b'0', 3, '', '海淀区清河中街68号298号', '10-568-0911');

-- ----------------------------
-- Table structure for visiter
-- ----------------------------
DROP TABLE IF EXISTS `visiter`;
CREATE TABLE `visiter`  (
  `id` int(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '来访名字',
  `phone` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '来访手机号',
  `purpose` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '来访目的',
  `createTime` datetime NOT NULL COMMENT '来访时间',
  `managerId` int(5) NOT NULL COMMENT '管理执行人id',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `managerid`(`managerId`) USING BTREE,
  CONSTRAINT `managerid` FOREIGN KEY (`managerId`) REFERENCES `manager` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 51 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of visiter
-- ----------------------------
INSERT INTO `visiter` VALUES (1, '陈安琪', '28-516-6952', 'In the middle of winter I at last discovered that there was in me an invincible summer. In the middle of winter I at last discovered that there was in me an invincible summer. To successfully establis', '2001-02-23 01:56:59', 9);
INSERT INTO `visiter` VALUES (2, '宋晓明', '154-2725-1837', 'You cannot save people, you can just love them. To connect to a database or schema, simply double-click it in the pane. After logged in the Navicat Cloud feature, the Navigation pane will be divided i', '2018-09-28 13:38:59', 9);
INSERT INTO `visiter` VALUES (3, '潘宇宁', '144-0593-9469', 'If the plan doesn’t work, change the plan, but never the goal. Navicat Monitor is a safe, simple and agentless remote server monitoring tool that is packed with powerful features to make your monito', '2020-02-20 16:53:02', 1);
INSERT INTO `visiter` VALUES (4, '罗杰宏', '154-4202-0724', 'If it scares you, it might be a good thing to try. The repository database can be an existing MySQL, MariaDB, PostgreSQL, SQL Server, or Amazon RDS instance.', '2005-02-09 00:56:52', 2);
INSERT INTO `visiter` VALUES (5, '宋岚', '10-6252-3040', 'HTTP Tunneling is a method for connecting to a server that uses the same protocol (http://) and the same port (port 80) as a web server does. Navicat Data Modeler is a powerful and cost-effective data', '2002-10-31 18:46:18', 10);
INSERT INTO `visiter` VALUES (6, '程睿', '142-7933-9854', 'The On Startup feature allows you to control what tabs appear when you launch Navicat. Sometimes you win, sometimes you learn. You cannot save people, you can just love them. A man is not old until re', '2015-02-26 04:39:48', 1);
INSERT INTO `visiter` VALUES (7, '沈岚', '136-1492-2928', 'After logged in the Navicat Cloud feature, the Navigation pane will be divided into Navicat Cloud and My Connections sections. If you wait, all that happens is you get older.', '2008-06-06 23:38:50', 2);
INSERT INTO `visiter` VALUES (8, '顾子韬', '148-1607-8101', 'Navicat Monitor requires a repository to store alerts and metrics for historical analysis. I will greet this day with love in my heart. Such sessions are also susceptible to session hijacking, where a', '2000-05-23 10:10:27', 5);
INSERT INTO `visiter` VALUES (9, '沈詩涵', '169-4401-8563', 'Import Wizard allows you to import data to tables/collections from CSV, TXT, XML, DBF and more. If opportunity doesn’t knock, build a door.', '2006-11-25 03:40:37', 8);
INSERT INTO `visiter` VALUES (10, '向云熙', '28-322-9404', 'To clear or reload various internal caches, flush tables, or acquire locks, control-click your connection in the Navigation pane and select Flush and choose the flush option. You must have the reload ', '2018-09-10 02:58:48', 8);
INSERT INTO `visiter` VALUES (11, '常睿', '187-4996-2734', 'You must be the change you wish to see in the world. Secure SHell (SSH) is a program to log in into another computer over a network, execute commands on a remote server, and move files from one machin', '2017-08-11 20:03:03', 1);
INSERT INTO `visiter` VALUES (12, '龚致远', '174-1312-3532', 'It provides strong authentication and secure encrypted communications between two hosts, known as SSH Port Forwarding (Tunneling), over an insecure network.', '2012-06-18 08:43:48', 3);
INSERT INTO `visiter` VALUES (13, '贾宇宁', '175-7487-5887', 'HTTP Tunneling is a method for connecting to a server that uses the same protocol (http://) and the same port (port 80) as a web server does.', '2004-09-01 00:39:44', 9);
INSERT INTO `visiter` VALUES (14, '常詩涵', '769-6924-9582', 'To get a secure connection, the first thing you need to do is to install OpenSSL Library and download Database Source. Optimism is the one quality more associated with success and happiness than any o', '2021-10-21 11:28:58', 1);
INSERT INTO `visiter` VALUES (15, '宋子韬', '760-3779-6222', 'It can also manage cloud databases such as Amazon Redshift, Amazon RDS, Alibaba Cloud. Features in Navicat are sophisticated enough to provide professional developers for all their specific needs, yet', '2010-10-03 03:06:27', 3);
INSERT INTO `visiter` VALUES (16, '毛震南', '183-9272-1851', 'To connect to a database or schema, simply double-click it in the pane. Actually it is just in an idea when feel oneself can achieve and cannot achieve.', '2014-05-20 05:57:30', 4);
INSERT INTO `visiter` VALUES (17, '戴致远', '769-181-6383', 'Export Wizard allows you to export data from tables, collections, views, or query results to any available formats. In other words, Navicat provides the ability for data in different databases and/or ', '2012-09-20 16:44:23', 3);
INSERT INTO `visiter` VALUES (18, '曹致远', '755-2853-0237', 'You cannot save people, you can just love them. How we spend our days is, of course, how we spend our lives.', '2000-08-10 05:43:59', 2);
INSERT INTO `visiter` VALUES (19, '程杰宏', '769-2631-8808', 'The repository database can be an existing MySQL, MariaDB, PostgreSQL, SQL Server, or Amazon RDS instance. The past has no power over the present moment. The reason why a great man is great is that he', '2014-03-12 11:49:46', 5);
INSERT INTO `visiter` VALUES (20, '林晓明', '156-2898-0259', 'A comfort zone is a beautiful place, but nothing ever grows there. It provides strong authentication and secure encrypted communications between two hosts, known as SSH Port Forwarding (Tunneling), ov', '2014-05-09 19:06:50', 10);
INSERT INTO `visiter` VALUES (21, '汤安琪', '20-685-2380', 'Anyone who has ever made anything of importance was disciplined. You cannot save people, you can just love them. You must be the change you wish to see in the world.', '2017-08-23 09:14:49', 5);
INSERT INTO `visiter` VALUES (22, '杜晓明', '755-7901-2345', 'You must be the change you wish to see in the world. A man is not old until regrets take the place of dreams. There is no way to happiness. Happiness is the way. A man is not old until regrets take th', '2004-05-08 00:06:07', 5);
INSERT INTO `visiter` VALUES (23, '韦秀英', '755-8489-8617', 'Monitored servers include MySQL, MariaDB and SQL Server, and compatible with cloud databases like Amazon RDS, Amazon Aurora, Oracle Cloud, Google Cloud and Microsoft Azure.', '2020-02-22 00:17:48', 5);
INSERT INTO `visiter` VALUES (24, '周宇宁', '10-3304-7637', 'Instead of wondering when your next vacation is, maybe you should set up a life you don’t need to escape from. Flexible settings enable you to set up a custom key for comparison and synchronization.', '2014-05-18 21:43:10', 9);
INSERT INTO `visiter` VALUES (25, '韦詩涵', '169-8211-3324', 'It is used while your ISPs do not allow direct connections, but allows establishing HTTP connections. If your Internet Service Provider (ISP) does not provide direct access to its server, Secure Tunne', '2006-06-02 04:41:22', 4);
INSERT INTO `visiter` VALUES (26, '石岚', '146-4995-8231', 'SQL Editor allows you to create and edit SQL text, prepare and execute selected queries. How we spend our days is, of course, how we spend our lives.', '2003-03-15 07:52:16', 8);
INSERT INTO `visiter` VALUES (27, '谭子异', '139-7004-4991', 'The Navigation pane employs tree structure which allows you to take action upon the database and their objects through their pop-up menus quickly and easily.', '2013-07-26 00:57:49', 4);
INSERT INTO `visiter` VALUES (28, '杜岚', '178-8613-0145', 'Navicat Monitor is a safe, simple and agentless remote server monitoring tool that is packed with powerful features to make your monitoring effective as possible.', '2004-01-13 16:04:19', 2);
INSERT INTO `visiter` VALUES (29, '董岚', '164-6729-9529', 'If the Show objects under schema in navigation pane option is checked at the Preferences window, all database objects are also displayed in the pane. It collects process metrics such as CPU load, RAM ', '2005-11-27 20:53:47', 10);
INSERT INTO `visiter` VALUES (30, '邓致远', '191-2570-4077', 'The Main Window consists of several toolbars and panes for you to work on connections, database objects and advanced tools. What you get by achieving your goals is not as important as what you become ', '2019-03-23 14:23:43', 9);
INSERT INTO `visiter` VALUES (31, '汪璐', '28-6464-8742', 'A query is used to extract data from the database in a readable format according to the user\'s request. To successfully establish a new connection to local/remote server - no matter via SSL or SSH, se', '2017-08-22 21:42:58', 10);
INSERT INTO `visiter` VALUES (32, '陶安琪', '188-9856-6483', 'To successfully establish a new connection to local/remote server - no matter via SSL, SSH or HTTP, set the database login information in the General tab.', '2008-02-21 01:55:35', 3);
INSERT INTO `visiter` VALUES (33, '于晓明', '20-0162-5272', 'It is used while your ISPs do not allow direct connections, but allows establishing HTTP connections. How we spend our days is, of course, how we spend our lives.', '2002-02-02 18:57:23', 8);
INSERT INTO `visiter` VALUES (34, '冯致远', '21-232-6111', 'Navicat Monitor can be installed on any local computer or virtual machine and does not require any software installation on the servers being monitored.', '2009-10-12 04:50:51', 10);
INSERT INTO `visiter` VALUES (35, '孙震南', '10-8446-5312', 'Always keep your eyes open. Keep watching. Because whatever you see can inspire you. In a Telnet session, all communications, including username and password, are transmitted in plain-text, allowing a', '2016-11-20 14:49:17', 9);
INSERT INTO `visiter` VALUES (36, '郝震南', '151-2046-4481', 'A man is not old until regrets take the place of dreams. To open a query using an external editor, control-click it and select Open with External Editor. You can set the file path of an external edito', '2021-07-20 23:55:06', 2);
INSERT INTO `visiter` VALUES (37, '杜秀英', '760-045-3140', 'Optimism is the one quality more associated with success and happiness than any other. You cannot save people, you can just love them. In a Telnet session, all communications, including username and p', '2004-11-28 22:55:08', 8);
INSERT INTO `visiter` VALUES (38, '严晓明', '10-054-3077', 'To clear or reload various internal caches, flush tables, or acquire locks, control-click your connection in the Navigation pane and select Flush and choose the flush option. You must have the reload ', '2020-07-24 21:37:57', 10);
INSERT INTO `visiter` VALUES (39, '薛璐', '134-5636-4905', 'HTTP Tunneling is a method for connecting to a server that uses the same protocol (http://) and the same port (port 80) as a web server does. To open a query using an external editor, control-click it', '2001-09-26 21:41:25', 8);
INSERT INTO `visiter` VALUES (40, '卢云熙', '28-3448-5118', 'Success consists of going from failure to failure without loss of enthusiasm. Export Wizard allows you to export data from tables, collections, views, or query results to any available formats.', '2015-02-25 12:53:12', 6);
INSERT INTO `visiter` VALUES (41, '方秀英', '760-559-3813', 'If it scares you, it might be a good thing to try. Monitored servers include MySQL, MariaDB and SQL Server, and compatible with cloud databases like Amazon RDS, Amazon Aurora, Oracle Cloud, Google Clo', '2001-06-18 15:51:52', 1);
INSERT INTO `visiter` VALUES (42, '曹岚', '138-3565-3278', 'Navicat Monitor can be installed on any local computer or virtual machine and does not require any software installation on the servers being monitored.', '2007-05-04 16:54:03', 4);
INSERT INTO `visiter` VALUES (43, '姚嘉伦', '20-8990-4767', 'With its well-designed Graphical User Interface(GUI), Navicat lets you quickly and easily create, organize, access and share information in a secure and easy way.', '2012-06-11 08:51:11', 1);
INSERT INTO `visiter` VALUES (44, '邱睿', '165-6804-4574', 'To connect to a database or schema, simply double-click it in the pane. You will succeed because most people are lazy. Such sessions are also susceptible to session hijacking, where a malicious user t', '2000-12-16 22:20:56', 4);
INSERT INTO `visiter` VALUES (45, '赵岚', '183-4093-6871', 'The Synchronize to Database function will give you a full picture of all database differences. Navicat Monitor requires a repository to store alerts and metrics for historical analysis.', '2018-07-30 14:41:32', 7);
INSERT INTO `visiter` VALUES (46, '罗宇宁', '21-7438-2874', 'A comfort zone is a beautiful place, but nothing ever grows there. To successfully establish a new connection to local/remote server - no matter via SSL, SSH or HTTP, set the database login informatio', '2014-02-14 20:47:49', 1);
INSERT INTO `visiter` VALUES (47, '苏安琪', '132-8941-5862', 'The Main Window consists of several toolbars and panes for you to work on connections, database objects and advanced tools. Success consists of going from failure to failure without loss of enthusiasm', '2009-06-08 13:21:04', 8);
INSERT INTO `visiter` VALUES (48, '朱安琪', '188-9537-6968', 'Navicat Monitor requires a repository to store alerts and metrics for historical analysis. In a Telnet session, all communications, including username and password, are transmitted in plain-text, allo', '2006-06-30 15:18:51', 10);
INSERT INTO `visiter` VALUES (49, '夏晓明', '167-8930-1846', 'Such sessions are also susceptible to session hijacking, where a malicious user takes over your session once you have authenticated. You cannot save people, you can just love them.', '2013-06-11 21:28:26', 7);
INSERT INTO `visiter` VALUES (50, '熊晓明', '157-0887-7192', 'You can select any connections, objects or projects, and then select the corresponding buttons on the Information Pane.', '2015-06-16 13:30:04', 6);

SET FOREIGN_KEY_CHECKS = 1;


-- 管理员登录
DROP PROCEDURE IF EXISTS login;
DELIMITER $$$
CREATE PROCEDURE login(
    username VARCHAR(40),
    pass VARCHAR(40)
)
BEGIN
    SELECT * FROM manager WHERE account=username AND PASSWORD=pass;
END $$$
DELIMITER ;

-- 添加来访者

DROP PROCEDURE IF EXISTS add_v;
DELIMITER $$$
CREATE PROCEDURE add_v(
    nname VARCHAR(20),
    pphone VARCHAR(40),
    ppurpose VARCHAR(255),
    mmanagerId INT(5)
)
BEGIN
    INSERT INTO visiter(NAME,phone,purpose,createTime,managerId) VALUES(nname,pphone,ppurpose,NOW(),mmanagerId);

END $$$
DELIMITER ;

-- 查看来访者信息


DROP PROCEDURE IF EXISTS select_v;
DELIMITER $$$
CREATE PROCEDURE select_v()
BEGIN
    SELECT * FROM visiter;
END $$$
DELIMITER ;


-- 查看学生信息

DROP PROCEDURE IF EXISTS select_s;
DELIMITER $$$
CREATE PROCEDURE select_s()
BEGIN
    SELECT * FROM student;
END $$$
DELIMITER ;

-- 添加学生信息

DROP PROCEDURE IF EXISTS add_s;
DELIMITER $$$
CREATE PROCEDURE add_s(
    ssname VARCHAR(20),
    ssage INT(11),
    ssex BIT(1),
    aaname VARCHAR(40),
    cclass VARCHAR(40),
    aaddress VARCHAR(255),
    pphone VARCHAR(20)
)
BEGIN
    DECLARE aid INT(5);
    SELECT id FROM academy WHERE aname=aaname INTO aid;
    INSERT INTO student(sname,age,sex,academy,class,address,phone) VALUES(ssname,ssage,ssex,aid,cclass,aaddress,pphone);
END $$$
DELIMITER ;

-- 开除学生信息
DROP PROCEDURE IF EXISTS delete_s;
DELIMITER $$$
CREATE PROCEDURE delete_s(
    ssno INT(20)
)
BEGIN
    DELETE FROM student WHERE sno=ssno;
END $$$
DELIMITER ;

-- 添加学生离校信息
DROP PROCEDURE IF EXISTS add_ls;
DELIMITER $$$
CREATE PROCEDURE add_ls(
    ssno INT(20),
    ppurpose VARCHAR(255),
    lleaveTime DATETIME,
    bbackTime DATETIME,
    mmanagerid INT(5)
)
BEGIN
    DECLARE ssname VARCHAR(20);
    DECLARE pphone VARCHAR(20);
    SELECT sname FROM student WHERE sno=ssno INTO ssname;
    SELECT phone FROM student WHERE sno=ssno INTO pphone;
    INSERT INTO leaveschool(sno,sname,phone,purpose,leaveTime,backTime,managerid) VALUES(ssno,ssname,pphone,ppurpose,lleaveTime,bbackTime,mmanagerid);
END $$$
DELIMITER ;



