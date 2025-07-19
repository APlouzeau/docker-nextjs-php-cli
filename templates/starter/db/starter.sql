-- Base de données starter template
--
CREATE DATABASE IF NOT EXISTS `{{DB_NAME}}` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `{{DB_NAME}}`;

-- --------------------------------------------------------

--
-- Structure de la table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `idUser` int(11) NOT NULL AUTO_INCREMENT,
  `firstName` varchar(50) NOT NULL,
  `lastName` varchar(50) NOT NULL,
  `role` varchar(50) NOT NULL DEFAULT 'user',
  `mail` varchar(50) NOT NULL,
  `nickName` varchar(50) NOT NULL,
  `password` varchar(60) DEFAULT NULL,
  `wallet` decimal(10,2) NOT NULL DEFAULT 0.00,
  `address` varchar(100) DEFAULT NULL,
  `address_2` varchar(50) DEFAULT NULL,
  `address_3` varchar(50) DEFAULT NULL,
  `zip` int(11) DEFAULT NULL,
  `city` varchar(50) DEFAULT NULL,
  `country` varchar(50) DEFAULT NULL,
  `dateInscription` datetime NOT NULL DEFAULT current_timestamp(),
  `isVerified` int(1) NOT NULL DEFAULT 0,
  `verifyToken` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`idUser`),
  UNIQUE KEY `mail` (`mail`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `posts`
--

DROP TABLE IF EXISTS `posts`;
CREATE TABLE IF NOT EXISTS `posts` (
  `idPost` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `content` text NOT NULL,
  `userId` int(11) NOT NULL,
  `createdAt` datetime NOT NULL DEFAULT current_timestamp(),
  `updatedAt` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `status` varchar(20) NOT NULL DEFAULT 'published',
  PRIMARY KEY (`idPost`),
  KEY `userId` (`userId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Données d'exemple pour `users`
--

INSERT INTO `users` (`idUser`, `firstName`, `lastName`, `role`, `mail`, `nickName`, `password`, `isVerified`) VALUES
(1, 'Admin', 'User', 'admin', 'admin@example.com', 'admin', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 1),
(2, 'John', 'Doe', 'user', 'john@example.com', 'johndoe', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 1);

-- --------------------------------------------------------

--
-- Données d'exemple pour `posts`
--

INSERT INTO `posts` (`idPost`, `title`, `content`, `userId`) VALUES
(1, 'Welcome to the starter template!', 'This is your first post. You can edit or delete it, or create new ones.', 1),
(2, 'Getting started', 'This template includes user authentication, basic CRUD operations, and a clean architecture.', 1),
(3, 'My first post', 'Hello world! This is a post from a regular user.', 2);

-- --------------------------------------------------------

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `posts`
--
ALTER TABLE `posts`
  ADD CONSTRAINT `posts_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `users` (`idUser`) ON DELETE CASCADE ON UPDATE CASCADE;

COMMIT;
