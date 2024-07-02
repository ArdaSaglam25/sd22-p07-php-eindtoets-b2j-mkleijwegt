-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Gegenereerd op: 24 jun 2024 om 15:17
-- Serverversie: 10.4.32-MariaDB
-- PHP-versie: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `school`
--

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `course`
--

CREATE TABLE `course` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` varchar(255) NOT NULL,
  `minimum_age` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Gegevens worden geëxporteerd voor tabel `course`
--

INSERT INTO `course` (`id`, `name`, `description`, `minimum_age`) VALUES
(1, 'Rekenen', 'Reken les', 8),
(2, 'Tekenen', 'Leren tekenen', 6),
(3, 'Wiskunde', 'Wiskunde les', 11),
(4, 'Aardrijkskunde', 'Aardrijkskunde', 10),
(5, 'Nederlands', 'Les Nederlands', 4),
(6, 'Engels', 'Engels les', 9);

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `doctrine_migration_versions`
--

CREATE TABLE `doctrine_migration_versions` (
  `version` varchar(191) NOT NULL,
  `executed_at` datetime DEFAULT NULL,
  `execution_time` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Gegevens worden geëxporteerd voor tabel `doctrine_migration_versions`
--

INSERT INTO `doctrine_migration_versions` (`version`, `executed_at`, `execution_time`) VALUES
('DoctrineMigrations\\Version20240624112458', '2024-06-24 13:25:05', 19),
('DoctrineMigrations\\Version20240624121709', '2024-06-24 14:17:15', 10),
('DoctrineMigrations\\Version20240624121758', '2024-06-24 14:18:02', 12),
('DoctrineMigrations\\Version20240624121913', '2024-06-24 14:19:16', 53),
('DoctrineMigrations\\Version20240624121953', '2024-06-24 14:19:56', 88);

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `messenger_messages`
--

CREATE TABLE `messenger_messages` (
  `id` bigint(20) NOT NULL,
  `body` longtext NOT NULL,
  `headers` longtext NOT NULL,
  `queue_name` varchar(190) NOT NULL,
  `created_at` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)',
  `available_at` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)',
  `delivered_at` datetime DEFAULT NULL COMMENT '(DC2Type:datetime_immutable)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `school_group`
--

CREATE TABLE `school_group` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `year` int(11) NOT NULL,
  `teacher` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Gegevens worden geëxporteerd voor tabel `school_group`
--

INSERT INTO `school_group` (`id`, `name`, `year`, `teacher`) VALUES
(1, 'B1H', 1, 'M Auerbach'),
(2, 'B1J', 1, 'S Bechoe'),
(3, 'B1K', 1, 'K Mooijman'),
(4, 'B1L', 1, 'T Mooijman'),
(5, 'B1M', 1, 'M Wagenaar'),
(6, 'B1P', 1, 'F Dasci'),
(7, 'B2H', 2, 'P Hennekam'),
(8, 'B2J', 2, 'M van der Linden'),
(9, 'B2K', 2, 'J de Jong'),
(10, 'B2L', 2, 'M Auerbach');

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `student`
--

CREATE TABLE `student` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `age` int(11) NOT NULL,
  `school_group_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Gegevens worden geëxporteerd voor tabel `student`
--

INSERT INTO `student` (`id`, `name`, `age`, `school_group_id`) VALUES
(1, 'Manja De Vries', 12, 2),
(4, 'Benjamin Eccel', 14, 2),
(5, 'Fatima Gurcu', 10, 2),
(6, 'Zelda Williams', 9, 3),
(7, 'Steven Stroom', 7, 3),
(8, 'Rozemarijn Plof', 9, 4),
(9, 'Fleur Kleur', 11, 4),
(10, 'Stanley Stekker', 8, 5),
(11, 'Bas Bos', 13, 6),
(12, 'Keer Kleur', 15, 6),
(13, 'Dawid Kaprol', 18, 1);

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `student_course`
--

CREATE TABLE `student_course` (
  `student_id` int(11) NOT NULL,
  `course_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Gegevens worden geëxporteerd voor tabel `student_course`
--

INSERT INTO `student_course` (`student_id`, `course_id`) VALUES
(1, 1),
(1, 2),
(1, 3),
(1, 4),
(1, 5),
(1, 6),
(4, 5),
(5, 2),
(5, 5),
(6, 2),
(7, 2),
(8, 2),
(10, 2),
(11, 5),
(12, 2),
(13, 2),
(13, 3);

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `email` varchar(180) NOT NULL,
  `roles` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '(DC2Type:json)' CHECK (json_valid(`roles`)),
  `password` varchar(255) NOT NULL,
  `firstname` varchar(255) NOT NULL,
  `lastname` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Gegevens worden geëxporteerd voor tabel `user`
--

INSERT INTO `user` (`id`, `email`, `roles`, `password`, `firstname`, `lastname`) VALUES
(4, 'admin@school.nl', '[\"ROLE_ADMIN\"]', '$2y$13$Qc.b.z4dIIHUZdUuIbLG3.Ac1Ee9LiBF2zE8foMdrynCqUqWuu8i2', 'Admin', 'Admin'),
(5, 'user@school.nl', '[]', '$2y$13$SMHDr1GA5wXpgPcDzGI4i.QAgwdFbzNED834P6lr8elmKCsSnTYLS', 'Dawid', 'User');

--
-- Indexen voor geëxporteerde tabellen
--

--
-- Indexen voor tabel `course`
--
ALTER TABLE `course`
  ADD PRIMARY KEY (`id`);

--
-- Indexen voor tabel `doctrine_migration_versions`
--
ALTER TABLE `doctrine_migration_versions`
  ADD PRIMARY KEY (`version`);

--
-- Indexen voor tabel `messenger_messages`
--
ALTER TABLE `messenger_messages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_75EA56E0FB7336F0` (`queue_name`),
  ADD KEY `IDX_75EA56E0E3BD61CE` (`available_at`),
  ADD KEY `IDX_75EA56E016BA31DB` (`delivered_at`);

--
-- Indexen voor tabel `school_group`
--
ALTER TABLE `school_group`
  ADD PRIMARY KEY (`id`);

--
-- Indexen voor tabel `student`
--
ALTER TABLE `student`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_B723AF3312ED03` (`school_group_id`);

--
-- Indexen voor tabel `student_course`
--
ALTER TABLE `student_course`
  ADD PRIMARY KEY (`student_id`,`course_id`),
  ADD KEY `IDX_98A8B739CB944F1A` (`student_id`),
  ADD KEY `IDX_98A8B739591CC992` (`course_id`);

--
-- Indexen voor tabel `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UNIQ_IDENTIFIER_EMAIL` (`email`);

--
-- AUTO_INCREMENT voor geëxporteerde tabellen
--

--
-- AUTO_INCREMENT voor een tabel `course`
--
ALTER TABLE `course`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT voor een tabel `messenger_messages`
--
ALTER TABLE `messenger_messages`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT voor een tabel `school_group`
--
ALTER TABLE `school_group`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT voor een tabel `student`
--
ALTER TABLE `student`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT voor een tabel `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Beperkingen voor geëxporteerde tabellen
--

--
-- Beperkingen voor tabel `student`
--
ALTER TABLE `student`
  ADD CONSTRAINT `FK_B723AF3312ED03` FOREIGN KEY (`school_group_id`) REFERENCES `school_group` (`id`);

--
-- Beperkingen voor tabel `student_course`
--
ALTER TABLE `student_course`
  ADD CONSTRAINT `FK_98A8B739591CC992` FOREIGN KEY (`course_id`) REFERENCES `course` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_98A8B739CB944F1A` FOREIGN KEY (`student_id`) REFERENCES `student` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
