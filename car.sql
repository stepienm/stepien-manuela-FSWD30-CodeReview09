-- phpMyAdmin SQL Dump
-- version 4.7.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Erstellungszeit: 03. Feb 2018 um 18:05
-- Server-Version: 10.1.30-MariaDB
-- PHP-Version: 7.2.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Datenbank: `car`
--

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `additional_charge`
--

CREATE TABLE `additional_charge` (
  `additional_charge_id` int(11) NOT NULL,
  `fk_company_id` int(11) DEFAULT NULL,
  `fk_location_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `car`
--

CREATE TABLE `car` (
  `car_id` int(11) NOT NULL,
  `price` float DEFAULT NULL,
  `fk_location_id` int(11) DEFAULT NULL,
  `fk_company_id` int(11) DEFAULT NULL,
  `fk_reservation_id` int(11) DEFAULT NULL,
  `fk_insurance_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `company`
--

CREATE TABLE `company` (
  `company_id` int(11) NOT NULL,
  `fk_additional_id` int(11) DEFAULT NULL,
  `fk_car_id` int(11) DEFAULT NULL,
  `E_Mail` varchar(55) DEFAULT NULL,
  `address` varchar(55) DEFAULT NULL,
  `phone_number` varchar(55) DEFAULT NULL,
  `name` varchar(55) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `customer`
--

CREATE TABLE `customer` (
  `customer_id` int(11) NOT NULL,
  `first_name` varchar(55) DEFAULT NULL,
  `last_name` varchar(55) DEFAULT NULL,
  `phone_number` varchar(50) DEFAULT NULL,
  `address` varchar(55) DEFAULT NULL,
  `E_Mail` varchar(55) DEFAULT NULL,
  `fk_reservation_id` int(11) DEFAULT NULL,
  `driver_licence_number` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `insurance`
--

CREATE TABLE `insurance` (
  `insurance_id` int(11) NOT NULL,
  `insurance_type` varchar(55) DEFAULT NULL,
  `fk_car_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `invoice`
--

CREATE TABLE `invoice` (
  `invoice_id` int(11) NOT NULL,
  `fk_location` int(11) DEFAULT NULL,
  `fk_reservation` int(11) DEFAULT NULL,
  `invoice_date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `location`
--

CREATE TABLE `location` (
  `location_id` int(11) NOT NULL,
  `address` varchar(55) DEFAULT NULL,
  `pick_up` varchar(55) DEFAULT NULL,
  `drop_off` varchar(55) DEFAULT NULL,
  `country` varchar(55) DEFAULT NULL,
  `fk_additional_charge_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `reservation`
--

CREATE TABLE `reservation` (
  `reservation_id` int(11) NOT NULL,
  `fk_car_id` int(11) DEFAULT NULL,
  `fk_customer_id` int(11) DEFAULT NULL,
  `fk_invoice_id` int(11) DEFAULT NULL,
  `pick_up` date DEFAULT NULL,
  `pick_off` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Indizes der exportierten Tabellen
--

--
-- Indizes für die Tabelle `additional_charge`
--
ALTER TABLE `additional_charge`
  ADD PRIMARY KEY (`additional_charge_id`),
  ADD KEY `fk_company_id` (`fk_company_id`);

--
-- Indizes für die Tabelle `car`
--
ALTER TABLE `car`
  ADD PRIMARY KEY (`car_id`),
  ADD KEY `fk_insurance_id` (`fk_insurance_id`);

--
-- Indizes für die Tabelle `company`
--
ALTER TABLE `company`
  ADD PRIMARY KEY (`company_id`),
  ADD KEY `fk_car_id` (`fk_car_id`);

--
-- Indizes für die Tabelle `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`customer_id`);

--
-- Indizes für die Tabelle `insurance`
--
ALTER TABLE `insurance`
  ADD PRIMARY KEY (`insurance_id`);

--
-- Indizes für die Tabelle `invoice`
--
ALTER TABLE `invoice`
  ADD PRIMARY KEY (`invoice_id`) USING BTREE,
  ADD KEY `fk_location` (`fk_location`);

--
-- Indizes für die Tabelle `location`
--
ALTER TABLE `location`
  ADD PRIMARY KEY (`location_id`),
  ADD KEY `fk_additional_charge_id` (`fk_additional_charge_id`);

--
-- Indizes für die Tabelle `reservation`
--
ALTER TABLE `reservation`
  ADD PRIMARY KEY (`reservation_id`),
  ADD KEY `fk_customer_id` (`fk_customer_id`),
  ADD KEY `fk_invoice_id` (`fk_invoice_id`);

--
-- Constraints der exportierten Tabellen
--

--
-- Constraints der Tabelle `additional_charge`
--
ALTER TABLE `additional_charge`
  ADD CONSTRAINT `additional_charge_ibfk_1` FOREIGN KEY (`fk_company_id`) REFERENCES `company` (`company_id`);

--
-- Constraints der Tabelle `car`
--
ALTER TABLE `car`
  ADD CONSTRAINT `car_ibfk_1` FOREIGN KEY (`fk_insurance_id`) REFERENCES `insurance` (`insurance_id`),
  ADD CONSTRAINT `car_ibfk_2` FOREIGN KEY (`car_id`) REFERENCES `location` (`location_id`);

--
-- Constraints der Tabelle `company`
--
ALTER TABLE `company`
  ADD CONSTRAINT `company_ibfk_1` FOREIGN KEY (`fk_car_id`) REFERENCES `car` (`car_id`);

--
-- Constraints der Tabelle `invoice`
--
ALTER TABLE `invoice`
  ADD CONSTRAINT `invoice_ibfk_1` FOREIGN KEY (`fk_location`) REFERENCES `location` (`location_id`);

--
-- Constraints der Tabelle `location`
--
ALTER TABLE `location`
  ADD CONSTRAINT `location_ibfk_1` FOREIGN KEY (`fk_additional_charge_id`) REFERENCES `additional_charge` (`additional_charge_id`);

--
-- Constraints der Tabelle `reservation`
--
ALTER TABLE `reservation`
  ADD CONSTRAINT `reservation_ibfk_1` FOREIGN KEY (`fk_customer_id`) REFERENCES `customer` (`customer_id`),
  ADD CONSTRAINT `reservation_ibfk_2` FOREIGN KEY (`fk_customer_id`) REFERENCES `customer` (`customer_id`),
  ADD CONSTRAINT `reservation_ibfk_3` FOREIGN KEY (`fk_invoice_id`) REFERENCES `invoice` (`invoice_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
