-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : mar. 14 mai 2024 à 01:21
-- Version du serveur : 10.4.28-MariaDB
-- Version de PHP : 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `my_vet`
--

-- --------------------------------------------------------

--
-- Structure de la table `aide_animale`
--

CREATE TABLE `aide_animale` (
  `id_aide` int(11) NOT NULL,
  `id_veterinaire` int(11) NOT NULL,
  `id_analyse` int(11) NOT NULL,
  `conseils` varchar(1000) NOT NULL,
  `datea` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `analyse`
--

CREATE TABLE `analyse` (
  `id_analyse` int(11) NOT NULL,
  `id_user` int(11) NOT NULL,
  `nom_animale` varchar(50) NOT NULL,
  `pfp_animal` varchar(255) NOT NULL,
  `date_nai` date NOT NULL,
  `race` enum('Berger','Bouledogue','Caniche','Husky','Doberman','Malinois','pitbull','persan','siamois','maine_coon','british_shorthair','bengal','scottish_fold','abyssin','ragdoll','perroquet','canari','perruche','calopsitte','inséparable','cockatiel','ara','gris_du_gabon','tourterelle','pigeon') NOT NULL,
  `type` enum('chien','chat','oiseau') NOT NULL,
  `sexe` enum('male','female') NOT NULL,
  `corpulence` enum('Maigre','Un peu maigre','Normale','Léger surpoids','Surpoids') NOT NULL,
  `symptomes` varchar(1000) NOT NULL,
  `Maladie_possible` varchar(100) NOT NULL,
  `date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Déchargement des données de la table `analyse`
--

INSERT INTO `analyse` (`id_analyse`, `id_user`, `nom_animale`, `pfp_animal`, `date_nai`, `race`, `type`, `sexe`, `corpulence`, `symptomes`, `Maladie_possible`, `date`) VALUES
(74, 17, 'Olga', '66428c6709c0f7.94246519_Snapchat-679045815.jpg', '2024-05-11', 'Berger', 'chien', 'female', 'Normale', 'Fiévre-Pneumonie-gingivostomatite', 'Caliciviorse', '2024-05-13 23:55:51');

-- --------------------------------------------------------

--
-- Structure de la table `comments`
--

CREATE TABLE `comments` (
  `id_comments` int(11) NOT NULL,
  `id_user` int(11) NOT NULL,
  `id_veterinaire` int(11) NOT NULL,
  `comment` varchar(1000) NOT NULL,
  `date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Déchargement des données de la table `comments`
--

INSERT INTO `comments` (`id_comments`, `id_user`, `id_veterinaire`, `comment`, `date`) VALUES
(14, 17, 21, 'ddd', '2024-05-13 19:36:24'),
(15, 17, 22, 'fggg', '2024-05-13 19:36:35'),
(16, 17, 21, 'hi', '2024-05-13 23:59:48');

-- --------------------------------------------------------

--
-- Structure de la table `stars`
--

CREATE TABLE `stars` (
  `id_star` int(11) NOT NULL,
  `id_user` int(11) NOT NULL,
  `id_veterinaire` int(11) NOT NULL,
  `rateIndex` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Déchargement des données de la table `stars`
--

INSERT INTO `stars` (`id_star`, `id_user`, `id_veterinaire`, `rateIndex`) VALUES
(17, 17, 21, 5),
(18, 17, 22, 2),
(19, 18, 21, 4),
(20, 18, 22, 4);

-- --------------------------------------------------------

--
-- Structure de la table `users`
--

CREATE TABLE `users` (
  `id_user` int(11) NOT NULL,
  `nom` varchar(100) NOT NULL,
  `prenom` varchar(100) NOT NULL,
  `email` varchar(50) NOT NULL,
  `pfp_profile` varchar(255) DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `telephone` varchar(10) NOT NULL,
  `address` varchar(50) NOT NULL,
  `date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Déchargement des données de la table `users`
--

INSERT INTO `users` (`id_user`, `nom`, `prenom`, `email`, `pfp_profile`, `password`, `telephone`, `address`, `date`) VALUES
(17, 'Debz', 'Anis', 'anissannabi2@gmail.com', '66428d606da966.42500166_Capture d’écran (5014).png', '$2y$10$4F4z7IgocpSdH7xD03gfqOxwlsT7XGe0uBB0QMTvjCkrlxkNqAljy', '0696566905', 'AADL SIDI ACHOUR ANNABA W02 numero 52', '2024-05-08 23:22:57'),
(18, 'Mallem', 'Djamal', 'mallem@gmail.com', NULL, '$2y$10$pESlv5T.RIiNgu4DLwdupOCTPVvoAJxqB2M/G4evRYqk.MIT4jLp2', '0696566909', 'AADL SIDI ACHOUR ANNABA W02 numero 52', '2024-05-13 17:14:34');

-- --------------------------------------------------------

--
-- Structure de la table `veterinaire`
--

CREATE TABLE `veterinaire` (
  `id_veterinaire` int(11) NOT NULL,
  `nom` varchar(100) NOT NULL,
  `prenom` varchar(100) NOT NULL,
  `email` varchar(50) NOT NULL,
  `pfp_profile` varchar(255) DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `telephone` varchar(10) NOT NULL,
  `address` varchar(100) NOT NULL,
  `type` enum('Vétérinaire généraliste','Vétérinaire spécialiste') NOT NULL,
  `specialite` enum('Chirurgie des petits animaux','Médecine des tissus mous','Médecine dentaire vétérinaire','Médecine des grands animaux','Maladies infectieuses','/') NOT NULL,
  `jour_d` varchar(50) DEFAULT NULL,
  `jour_f` varchar(50) DEFAULT NULL,
  `heur_d` varchar(50) DEFAULT NULL,
  `heur_f` varchar(50) DEFAULT NULL,
  `date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Déchargement des données de la table `veterinaire`
--

INSERT INTO `veterinaire` (`id_veterinaire`, `nom`, `prenom`, `email`, `pfp_profile`, `password`, `telephone`, `address`, `type`, `specialite`, `jour_d`, `jour_f`, `heur_d`, `heur_f`, `date`) VALUES
(21, 'Debz', 'Kheireddine', 'khairo@gmail.com', NULL, '$2y$10$JRu20YlqkeQ/I.9kUGcUxOfXU2B5a.EQ4S25O.e6Kcx0IXmej8pMG', '0696566905', 'AADL SIDI ACHOUR ANNABA W02 numero 52', 'Vétérinaire spécialiste', 'Maladies infectieuses', 'Samedi', 'Mecredi', '09:00', '17:00', '2024-05-13 15:08:36'),
(22, 'Maoui', 'Hatem', 'maoui@gmail.com', NULL, '$2y$10$QojvkoWBk9r5BUB5fA5RY.4ZKo655yztyHIQ9K96Dm5nx8QpMlzQ.', '0795337579', 'LA COLONE ANNABA', 'Vétérinaire spécialiste', 'Chirurgie des petits animaux', NULL, NULL, NULL, NULL, '2024-05-13 17:10:31');

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `aide_animale`
--
ALTER TABLE `aide_animale`
  ADD PRIMARY KEY (`id_aide`),
  ADD KEY `fk_analyse_aide` (`id_analyse`),
  ADD KEY `fk_vet_aide` (`id_veterinaire`);

--
-- Index pour la table `analyse`
--
ALTER TABLE `analyse`
  ADD PRIMARY KEY (`id_analyse`),
  ADD KEY `fk_users_analyse` (`id_user`);

--
-- Index pour la table `comments`
--
ALTER TABLE `comments`
  ADD PRIMARY KEY (`id_comments`),
  ADD KEY `fk_user_comment` (`id_user`),
  ADD KEY `fk_veterinaire_comment` (`id_veterinaire`);

--
-- Index pour la table `stars`
--
ALTER TABLE `stars`
  ADD PRIMARY KEY (`id_star`),
  ADD KEY `fk_user_stars` (`id_user`),
  ADD KEY `fk_vet_stars` (`id_veterinaire`);

--
-- Index pour la table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id_user`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `telephone` (`telephone`);

--
-- Index pour la table `veterinaire`
--
ALTER TABLE `veterinaire`
  ADD PRIMARY KEY (`id_veterinaire`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `telephone` (`telephone`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `aide_animale`
--
ALTER TABLE `aide_animale`
  MODIFY `id_aide` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT pour la table `analyse`
--
ALTER TABLE `analyse`
  MODIFY `id_analyse` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=75;

--
-- AUTO_INCREMENT pour la table `comments`
--
ALTER TABLE `comments`
  MODIFY `id_comments` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT pour la table `stars`
--
ALTER TABLE `stars`
  MODIFY `id_star` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT pour la table `users`
--
ALTER TABLE `users`
  MODIFY `id_user` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT pour la table `veterinaire`
--
ALTER TABLE `veterinaire`
  MODIFY `id_veterinaire` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `aide_animale`
--
ALTER TABLE `aide_animale`
  ADD CONSTRAINT `fk_analyse_aide` FOREIGN KEY (`id_analyse`) REFERENCES `analyse` (`id_analyse`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_vet_aide` FOREIGN KEY (`id_veterinaire`) REFERENCES `veterinaire` (`id_veterinaire`) ON DELETE CASCADE;

--
-- Contraintes pour la table `analyse`
--
ALTER TABLE `analyse`
  ADD CONSTRAINT `fk_users_analyse` FOREIGN KEY (`id_user`) REFERENCES `users` (`id_user`) ON DELETE CASCADE;

--
-- Contraintes pour la table `comments`
--
ALTER TABLE `comments`
  ADD CONSTRAINT `fk_user_comment` FOREIGN KEY (`id_user`) REFERENCES `users` (`id_user`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_veterinaire_comment` FOREIGN KEY (`id_veterinaire`) REFERENCES `veterinaire` (`id_veterinaire`) ON DELETE CASCADE;

--
-- Contraintes pour la table `stars`
--
ALTER TABLE `stars`
  ADD CONSTRAINT `fk_user_stars` FOREIGN KEY (`id_user`) REFERENCES `users` (`id_user`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_vet_stars` FOREIGN KEY (`id_veterinaire`) REFERENCES `veterinaire` (`id_veterinaire`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
