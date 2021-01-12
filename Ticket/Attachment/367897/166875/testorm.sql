-- phpMyAdmin SQL Dump
-- version 2.10.1
-- http://www.phpmyadmin.net
-- 
-- Host: mysql4.pace.co.uk
-- Generation Time: Oct 04, 2007 at 03:42 PM
-- Server version: 4.1.22
-- PHP Version: 4.3.11

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";

-- 
-- Database: `testorm`
-- 

-- --------------------------------------------------------

-- 
-- Table structure for table `data`
-- 

CREATE TABLE `data` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(40) collate utf8_unicode_ci NOT NULL default '''''',
  `value` int(11) NOT NULL default '0',
  `when` timestamp NOT NULL default CURRENT_TIMESTAMP,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

-- 
-- Table structure for table `_ORM_refs`
-- 

CREATE TABLE `_ORM_refs` (
  `class` varchar(45) collate utf8_unicode_ci NOT NULL default '',
  `prop` varchar(45) collate utf8_unicode_ci NOT NULL default '',
  `ref_class` varchar(45) collate utf8_unicode_ci NOT NULL default '',
  PRIMARY KEY  (`class`,`prop`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
