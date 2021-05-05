/*
 Navicat Premium Data Transfer

 Source Server         : 192.168.1.88
 Source Server Type    : MySQL
 Source Server Version : 80018
 Source Host           : 192.168.1.88:3306
 Source Schema         : sme_api

 Target Server Type    : MySQL
 Target Server Version : 80018
 File Encoding         : 65001

 Date: 07/01/2020 16:59:43
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for c3p0
-- ----------------------------
DROP TABLE IF EXISTS `c3p0`;
CREATE TABLE `c3p0`  (
  `a` char(1) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for config
-- ----------------------------
DROP TABLE IF EXISTS `config`;
CREATE TABLE `config`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `config_type` int(11) UNSIGNED NOT NULL,
  `description` tinytext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `key` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `value` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `created_date` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
  `updated_date` datetime(0) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(0),
  `created_user` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `updated_user` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `Config_Unique_columns`(`config_type`, `key`) USING BTREE,
  CONSTRAINT `FK_config_configType` FOREIGN KEY (`config_type`) REFERENCES `config_type` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 21 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of config
-- ----------------------------
INSERT INTO `config` VALUES (1, 3, '', 'hotline', 'hotline_support_nim', '2020-01-07 16:54:48', NULL, 'system', '');
INSERT INTO `config` VALUES (2, 3, '', 'skype', 'skype_support_nim', '2020-01-07 16:54:48', NULL, 'system', '');
INSERT INTO `config` VALUES (3, 3, '', 'support_mail', 'email_support_nim', '2020-01-07 16:54:48', NULL, 'system', '');
INSERT INTO `config` VALUES (4, 3, '', 'portal_link', 'https://server_name_portal_nim', '2020-01-07 16:54:48', NULL, 'system', '');
INSERT INTO `config` VALUES (5, 4, 'Minimum memory(G)', 'vm_min_memory', '1', '2020-01-07 16:55:01', NULL, 'system', '');
INSERT INTO `config` VALUES (6, 4, 'Minimum core', 'vm_min_core', '1', '2020-01-07 16:55:01', NULL, 'system', '');
INSERT INTO `config` VALUES (7, 4, 'Minimum disk size(G)', 'vm_min_disk_size', '20', '2020-01-07 16:55:01', NULL, 'system', '');
INSERT INTO `config` VALUES (8, 4, 'Maximum memory(G)', 'vm_max_memory', '32', '2020-01-07 16:55:01', NULL, 'system', '');
INSERT INTO `config` VALUES (9, 4, 'Maximum core', 'vm_max_core', '16', '2020-01-07 16:55:01', NULL, 'system', '');
INSERT INTO `config` VALUES (10, 4, 'Maximum disk size(G)', 'vm_max_disk_size', '500', '2020-01-07 16:55:01', NULL, 'system', '');
INSERT INTO `config` VALUES (11, 5, 'Full name 1', 'full_name_1', '', '2020-01-07 16:55:12', NULL, 'system', '');
INSERT INTO `config` VALUES (12, 5, 'Email 1', 'email_1', '', '2020-01-07 16:55:12', NULL, 'system', '');
INSERT INTO `config` VALUES (13, 5, 'Skype 1', 'skype_1', '', '2020-01-07 16:55:12', NULL, 'system', '');
INSERT INTO `config` VALUES (14, 5, 'Phone number 1', 'phone_number_1', '', '2020-01-07 16:55:12', NULL, 'system', '');
INSERT INTO `config` VALUES (15, 5, 'Full name 2', 'full_name_2', '', '2020-01-07 16:55:12', NULL, 'system', '');
INSERT INTO `config` VALUES (16, 5, 'Email 2', 'email_2', '', '2020-01-07 16:55:12', NULL, 'system', '');
INSERT INTO `config` VALUES (17, 5, 'Skype 2', 'skype_2', '', '2020-01-07 16:55:12', NULL, 'system', '');
INSERT INTO `config` VALUES (18, 5, 'Phone number 2', 'phone_number_2', '', '2020-01-07 16:55:12', NULL, 'system', '');
INSERT INTO `config` VALUES (19, 6, 'Backup/Restore timeout in minute', 'request_timeout_minute', '240', '2020-01-07 16:55:29', NULL, 'system', '');
INSERT INTO `config` VALUES (20, 6, 'Backup/Restore checking status interval in minute', 'request_interval_minute', '30', '2020-01-07 16:55:29', NULL, 'system', '');

-- ----------------------------
-- Table structure for config_type
-- ----------------------------
DROP TABLE IF EXISTS `config_type`;
CREATE TABLE `config_type`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` tinytext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `type` tinyint(2) UNSIGNED NOT NULL DEFAULT 0 COMMENT '1: vStorage Config',
  `created_date` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
  `updated_date` datetime(0) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(0),
  `created_user` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `updated_user` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `type`(`type`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of config_type
-- ----------------------------
INSERT INTO `config_type` VALUES (1, 'vStorage Config', 1, '2020-01-07 16:54:25', NULL, 'system', '');
INSERT INTO `config_type` VALUES (2, 'Root Account Config', 2, '2020-01-07 16:54:25', NULL, 'system', '');
INSERT INTO `config_type` VALUES (3, 'Mail Config', 3, '2020-01-07 16:54:25', NULL, 'system', '');
INSERT INTO `config_type` VALUES (4, 'VM Config', 4, '2020-01-07 16:54:25', NULL, 'system', '');
INSERT INTO `config_type` VALUES (5, 'Support Config', 5, '2020-01-07 16:54:25', NULL, 'system', '');
INSERT INTO `config_type` VALUES (6, 'Backup-Restore Config', 6, '2020-01-07 16:54:25', NULL, 'system', '');

-- ----------------------------
-- Table structure for configuration
-- ----------------------------
DROP TABLE IF EXISTS `configuration`;
CREATE TABLE `configuration`  (
  `cfg_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `service_id` int(11) NOT NULL,
  `cfg_key` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `cfg_value` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `backend` int(11) NULL DEFAULT NULL,
  `cfg_type` tinyint(2) NOT NULL DEFAULT 0,
  PRIMARY KEY (`cfg_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;


-- ----------------------------
-- Table structure for draft_recipient
-- ----------------------------
DROP TABLE IF EXISTS `draft_recipient`;
CREATE TABLE `draft_recipient`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `msg_rec_id` int(11) UNSIGNED NOT NULL,
  `recipient_group` tinytext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `recipient_user_id` tinytext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `created_date` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `msg_rec_id`(`msg_rec_id`) USING BTREE,
  CONSTRAINT `FK_draft_recipient_message` FOREIGN KEY (`msg_rec_id`) REFERENCES `message_recipient` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for message
-- ----------------------------
DROP TABLE IF EXISTS `message`;
CREATE TABLE `message`  (
  `mgs_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `mgs_subject` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `mgs_content` mediumtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `created_date` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
  `created_by` tinytext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT 'user login',
  PRIMARY KEY (`mgs_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for message_recipient
-- ----------------------------
DROP TABLE IF EXISTS `message_recipient`;
CREATE TABLE `message_recipient`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `msg_id` int(11) UNSIGNED NOT NULL,
  `recipient_group` tinytext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `recipient_user_id` tinytext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `msg_type` tinytext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `created_date` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
  `msg_status` tinyint(1) UNSIGNED NULL DEFAULT 1 COMMENT '0: viewed, 1: new',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `msg_id`(`msg_id`) USING BTREE,
  CONSTRAINT `FK_message_recipient_message` FOREIGN KEY (`msg_id`) REFERENCES `message` (`mgs_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

SET FOREIGN_KEY_CHECKS = 1;
