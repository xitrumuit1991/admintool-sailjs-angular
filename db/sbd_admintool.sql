/*
 Navicat Premium Data Transfer

 Source Server         : localhost u=root p=null
 Source Server Type    : MySQL
 Source Server Version : 50548
 Source Host           : localhost:3306
 Source Schema         : sbd_admintool

 Target Server Type    : MySQL
 Target Server Version : 50548
 File Encoding         : 65001

 Date: 10/02/2018 10:05:28
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for group
-- ----------------------------
DROP TABLE IF EXISTS `group`;
CREATE TABLE `group` (
  `id` varchar(36) COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8_unicode_ci,
  `permissionList` text COLLATE utf8_unicode_ci,
  `status` int(11) DEFAULT NULL,
  `createdBy` text COLLATE utf8_unicode_ci,
  `updatedBy` text COLLATE utf8_unicode_ci,
  `createdAt` datetime DEFAULT NULL,
  `updatedAt` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of group
-- ----------------------------
BEGIN;
INSERT INTO `group` VALUES ('06a74c31-9ec5-484b-9737-ea11b31c27b4', 'admin', 'admin group', '[\"/admin/group/delete\",\"/admin/group/findone\",\"/admin/group/find\",\"/admin/group/create\",\"/admin/group/update\",\"/admin/page/admin\",\"/admin/page/analytic\",\"/admin/user/delete\",\"/admin/user/findone\",\"/admin/user/find\",\"/admin/user/create\",\"/admin/user/update\"]', 1, NULL, 'f3c70203-0ece-44b9-a662-0bd4c30d19ac', '2018-01-20 15:43:02', '2018-02-06 14:27:40');
INSERT INTO `group` VALUES ('6a390fe0-69c7-4b9d-b719-94aed3aaa04d', 'analyticManager', 'analyticManager', '[\"/admin/page/analytic\"]', 1, 'f3c70203-0ece-44b9-a662-0bd4c30d19ac', NULL, '2018-02-06 14:27:21', '2018-02-06 14:27:21');
INSERT INTO `group` VALUES ('789ca284-9e4e-4e83-8eea-c9dabcaf51f7', 'adminManager', 'adminManager', '[\"/admin/group/delete\",\"/admin/group/findone\",\"/admin/group/find\",\"/admin/group/create\",\"/admin/group/update\",\"/admin/page/admin\",\"/admin/user/delete\",\"/admin/user/findone\",\"/admin/user/find\",\"/admin/user/create\",\"/admin/user/update\"]', 1, 'f3c70203-0ece-44b9-a662-0bd4c30d19ac', NULL, '2018-02-06 14:27:06', '2018-02-06 14:27:06');
COMMIT;

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` varchar(36) CHARACTER SET utf8 NOT NULL,
  `isAdmin` int(2) DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `phone` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `password` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `avatar` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `belongGroup` text COLLATE utf8_unicode_ci,
  `status` int(11) DEFAULT NULL,
  `createdBy` text COLLATE utf8_unicode_ci,
  `updatedBy` text COLLATE utf8_unicode_ci,
  `createdAt` datetime DEFAULT NULL,
  `updatedAt` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of user
-- ----------------------------
BEGIN;
INSERT INTO `user` VALUES ('0b40b7bd-affb-4db4-90ba-80c42b911b8c', 1, 'admin', NULL, '5a1760628ea739e61d9bb798b50542d5', 'admin@gmail.com', NULL, NULL, 1, NULL, NULL, '2018-02-10 10:01:58', '2018-02-10 10:01:58');
INSERT INTO `user` VALUES ('59fa509b-7018-41fa-adba-1dbebc9b5e0d', 1, 'nguyentvk', 'abc', '25f9e794323b453885f5181f1b624d0b', 'nguyentvk@mail.com', 'img/avatar5.png', NULL, 1, NULL, NULL, '2018-01-20 15:33:10', '2018-02-07 18:31:38');
INSERT INTO `user` VALUES ('6169a387-846b-4cc6-92ae-e534c34b6849', 1, 'duybq', NULL, 'd2a450d9d7aba17bda391f22946952ec', 'duybq@mail.com', NULL, NULL, 1, NULL, NULL, '2018-02-10 10:01:58', '2018-02-10 10:01:58');
INSERT INTO `user` VALUES ('854e10c9-9d3e-42c1-9c5a-f508bb14d07c', 1, 'superadmin', NULL, '79728042b80030ffce520978843e8185', 'superadmin@mail.com', NULL, NULL, 1, NULL, NULL, '2018-02-10 10:01:58', '2018-02-10 10:01:58');
INSERT INTO `user` VALUES ('89ab8e7f-9a35-485a-9a7f-367605a4feec', 1, 'admin', NULL, '25f9e794323b453885f5181f1b624d0b', 'admin@mail.com', NULL, NULL, 1, NULL, NULL, '2018-01-20 15:36:24', '2018-01-20 15:36:24');
INSERT INTO `user` VALUES ('a1556c60-605a-4fe4-a1a2-2eafb4e89b44', 1, 'admin', '0987654321', '25f9e794323b453885f5181f1b624d0b', 'email@email.com', 'avatar', NULL, 1, NULL, NULL, '2018-01-20 15:33:10', '2018-01-20 15:33:10');
INSERT INTO `user` VALUES ('c6f6ab23-610b-4b94-9105-d8853d6da1a7', 0, 'testadmin@gmail.com', '3252543', '25f9e794323b453885f5181f1b624d0b', 'testadmin@gmail.com', NULL, '[\"789ca284-9e4e-4e83-8eea-c9dabcaf51f7\"]', 1, 'test@gmail.com', NULL, '2018-02-06 14:28:25', '2018-02-06 14:28:25');
INSERT INTO `user` VALUES ('df807fad-3e73-4128-b721-45f6cc234317', 0, 'nguyen', '23424154325', '25f9e794323b453885f5181f1b624d0b', 'nguyen@gmail.com', NULL, '[\"06a74c31-9ec5-484b-9737-ea11b31c27b4\"]', 1, 'nguyentvk@mail.com', NULL, '2018-02-06 12:16:01', '2018-02-06 14:22:10');
INSERT INTO `user` VALUES ('f3c70203-0ece-44b9-a662-0bd4c30d19ac', 0, 'testanalytic@gmail.com', '3254235432', '25f9e794323b453885f5181f1b624d0b', 'testanalytic@gmail.com', NULL, '[\"6a390fe0-69c7-4b9d-b719-94aed3aaa04d\",\"789ca284-9e4e-4e83-8eea-c9dabcaf51f7\"]', 1, 'nguyentvk@mail.com', NULL, '2018-02-06 13:05:42', '2018-02-06 20:44:06');
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
