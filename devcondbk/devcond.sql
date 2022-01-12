-- --------------------------------------------------------
-- Servidor:                     127.0.0.1
-- Versão do servidor:           10.4.22-MariaDB - mariadb.org binary distribution
-- OS do Servidor:               Win64
-- HeidiSQL Versão:              11.3.0.6295
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

-- Copiando dados para a tabela devcond.areadisableddays: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `areadisableddays` DISABLE KEYS */;
/*!40000 ALTER TABLE `areadisableddays` ENABLE KEYS */;

-- Copiando dados para a tabela devcond.areas: ~3 rows (aproximadamente)
/*!40000 ALTER TABLE `areas` DISABLE KEYS */;
INSERT INTO `areas` (`id`, `allowed`, `title`, `cover`, `days`, `start_time`, `end_time`) VALUES
	(1, 1, 'Academia', 'gym.jpg', '1,2,4,5', '06:00:00', '14:00:00'),
	(2, 1, 'Piscina', 'pool.jpg', '1,2,3,4,5', '07:00:00', '23:00:00'),
	(3, 1, 'Churrasqueira', 'barbecue.jpg', '4,5,6', '09:00:00', '23:00:00');
/*!40000 ALTER TABLE `areas` ENABLE KEYS */;

-- Copiando dados para a tabela devcond.billets: ~2 rows (aproximadamente)
/*!40000 ALTER TABLE `billets` DISABLE KEYS */;
INSERT INTO `billets` (`id`, `id_unit`, `title`, `fileurl`) VALUES
	(1, 1, 'Dezembro 2021', '1_dez21.doc'),
	(2, 1, 'Janeiro 2022', '1_jan22.doc');
/*!40000 ALTER TABLE `billets` ENABLE KEYS */;

-- Copiando dados para a tabela devcond.docs: ~2 rows (aproximadamente)
/*!40000 ALTER TABLE `docs` DISABLE KEYS */;
INSERT INTO `docs` (`id`, `title`, `fileurl`) VALUES
	(1, 'Regras do Condominio', 'docs.txt'),
	(2, 'Financeiro 2021', 'docs1.txt');
/*!40000 ALTER TABLE `docs` ENABLE KEYS */;

-- Copiando dados para a tabela devcond.foundandlost: ~4 rows (aproximadamente)
/*!40000 ALTER TABLE `foundandlost` DISABLE KEYS */;
INSERT INTO `foundandlost` (`id`, `status`, `photo`, `description`, `where`, `datecreated`) VALUES
	(1, 'LOST', 'algo.jpg', 'Carteira Azul', 'Patio', '2022-01-12 10:02:20'),
	(2, 'RECOVERED', 'chave.jpg', 'Encontrado chave do celta prata', 'Recepcao', '2022-01-12 12:02:20'),
	(3, 'LOST', 'RB6LCVVEcKmzquSKrs79eoihmgsUgX5vNpMnoMcd.jpg', 'Foto de Carteira perdida', 'patio', '2022-01-12 00:00:00'),
	(4, 'LOST', 'dmHcD9Dldh5OZ9Cu90uzQZdNMrXLIKpSZ6SSyQxq.jpg', 'Pente perdido', 'lixeira', '2022-01-12 00:00:00');
/*!40000 ALTER TABLE `foundandlost` ENABLE KEYS */;

-- Copiando dados para a tabela devcond.migrations: ~2 rows (aproximadamente)
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
	(1, '2014_10_12_000000_create_users_table', 1),
	(2, '2019_12_14_000001_create_personal_access_tokens_table', 1);
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;

-- Copiando dados para a tabela devcond.personal_access_tokens: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `personal_access_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `personal_access_tokens` ENABLE KEYS */;

-- Copiando dados para a tabela devcond.reservations: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `reservations` DISABLE KEYS */;
/*!40000 ALTER TABLE `reservations` ENABLE KEYS */;

-- Copiando dados para a tabela devcond.unitpeoples: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `unitpeoples` DISABLE KEYS */;
INSERT INTO `unitpeoples` (`id`, `id_unit`, `name`, `birthdate`) VALUES
	(1, 2, 'Walter', '2002-01-12'),
	(3, 2, 'Deia', '2002-01-01');
/*!40000 ALTER TABLE `unitpeoples` ENABLE KEYS */;

-- Copiando dados para a tabela devcond.unitpets: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `unitpets` DISABLE KEYS */;
INSERT INTO `unitpets` (`id`, `id_unit`, `name`, `race`) VALUES
	(1, 2, 'Linda', 'Vira-Lata');
/*!40000 ALTER TABLE `unitpets` ENABLE KEYS */;

-- Copiando dados para a tabela devcond.units: ~4 rows (aproximadamente)
/*!40000 ALTER TABLE `units` DISABLE KEYS */;
INSERT INTO `units` (`id`, `name`, `id_owner`) VALUES
	(1, 'APT 100', 1),
	(2, 'APT 101', 1),
	(3, 'APT 200', 0),
	(4, 'APT 201', 0);
/*!40000 ALTER TABLE `units` ENABLE KEYS */;

-- Copiando dados para a tabela devcond.unitvehicles: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `unitvehicles` DISABLE KEYS */;
INSERT INTO `unitvehicles` (`id`, `id_unit`, `title`, `color`, `plate`) VALUES
	(1, 2, 'Nivus', 'Monstone', 'FSZ-0C74');
/*!40000 ALTER TABLE `unitvehicles` ENABLE KEYS */;

-- Copiando dados para a tabela devcond.users: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` (`id`, `name`, `email`, `cpf`, `password`) VALUES
	(1, 'Walter', 'walter.mudesto@hotmail.com', '12345678901', '$2y$10$oaSxbgBH7TQYbjyaaKKauO8YQEqsqcyLdrLFgisK3uqzmZyVC8udy');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;

-- Copiando dados para a tabela devcond.walllikes: ~1 rows (aproximadamente)
/*!40000 ALTER TABLE `walllikes` DISABLE KEYS */;
INSERT INTO `walllikes` (`id`, `id_wall`, `id_user`) VALUES
	(1, 1, 1);
/*!40000 ALTER TABLE `walllikes` ENABLE KEYS */;

-- Copiando dados para a tabela devcond.walls: ~2 rows (aproximadamente)
/*!40000 ALTER TABLE `walls` DISABLE KEYS */;
INSERT INTO `walls` (`id`, `title`, `body`, `datecreated`) VALUES
	(1, 'Falta Energia', 'Energia Enel, ira regilar as luzes as 17 horas', '2021-12-20 15:00:00'),
	(2, 'Alerta Geral a todos', 'Fiquem atento ficaremos com falta durante todo o dia', '2021-12-20 17:00:00');
/*!40000 ALTER TABLE `walls` ENABLE KEYS */;

-- Copiando dados para a tabela devcond.warnings: ~3 rows (aproximadamente)
/*!40000 ALTER TABLE `warnings` DISABLE KEYS */;
INSERT INTO `warnings` (`id`, `id_unit`, `title`, `status`, `datecreated`, `photos`) VALUES
	(1, 2, 'Meu vizinho ligando a furadeira', 'IN_REVIEW', '2022-01-12', 'foto1.jpg,foto2.jpg'),
	(2, 2, 'Vizinho chato via API', 'IN_REVIEW', '2022-01-12', ''),
	(3, 2, 'Vizinho com foto', 'IN_REVIEW', '2022-01-12', 'rfG8CLyOkmfRE5RsuNQp7G0eKe74UMRCrbksUrEG.jpg,rfG8CLyOkmfRE5RsuNQp7G0eKe74UMRCrbksUrEG.jpg');
/*!40000 ALTER TABLE `warnings` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
