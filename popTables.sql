-- Populando tabela Clientes


insert into Cliente (Nome, CPF, telefone, email, datanascimento) 
VALUES 
	('Samantha Cormier', '69257053360', '28004-5810', 'Burley_Collier50@yahoo.com', '1983-03-05T12:38:53.821'),
	('Ian Streich MD', '59493774713', '23613-5085', 'Regan.Jones90@yahoo.com', '1944-09-10T08:55:00.234'),
	('Mrs. Jesse Toy V', '68620124128', '41526-7666', 'Wyatt68@gmail.com', '1995-02-01T23:06:06.214'),
	('Tyler Kihn', '24154929216', '74857-1454', 'Kaylin32@yahoo.com', '1984-04-03T22:14:11.813'),
	('Santiago Collier', '37837712032', '70520-1770', 'Boyd_Lesch@gmail.com', '2005-07-13T18:48:39.612'),
	('Christina Fahey', '83676971474', '18343-6855', 'Meggie_Jast@hotmail.com', '2003-04-11T16:00:44.828'),
	('Mack Lindgren', '28251968489', '29101-1928', 'Weston_Goyette@yahoo.com', '1967-08-18T12:21:08.064'),
	('Miss Nicolas Sawayn', '51843412448', '99644-9195', 'Francisca_Prohaska@hotmail.com', '1952-08-09T09:39:59.573'),
	('Vincent Kihn', '56429339324', '70279-3768', 'Tyrese22@gmail.com', '2004-07-17T09:10:52.362'),
	('Lynda Deckow', '58880580899', '93787-5802', 'Alfred64@hotmail.com', '1975-12-01T15:26:02.105');
	
select * from Cliente;


-- Populando tabela Veiculo

insert into Veiculo (placa, marca, modelo, ano, combustivel, Cliente_idCliente)
VALUES
	('BB34MJQ', 'Rolls Royce', 'Ranchero', '2016', 'alcool', '1'),
	('RD43ZEJ', 'Land Rover', 'Civic', '2017', 'gasolina', '2'),
	('QH94VFH', 'Mazda', 'Colorado', '2011', 'gasolina', '3'),
	('MH78JZX', 'Ferrari', 'Charger', '1997', 'alcool', '4'),
	('WW53HYC', 'Bugatti', 'Model 3', '2008', 'gasolina', '5'),
	('CX08FFC', 'Hyundai', 'Alpine', '1995', 'alcool', '6'),
	('AK08KQX', 'Audi', 'A8', '2012', 'alcool', '7'),
	('JL04NKD', 'Volvo', '911', '1984', 'alcool', '8'),
	('UX85VHT', 'Kia', 'Spyder', '2006', 'gasolina', '9'),
	('CK88VYA', 'Dodge', 'F-150', '1986', 'gasolina', '10');
    
    
select * from Veiculo;


-- Populando tabela Equipe

insert into Equipe
VALUES
	(1,'Funilaria'),
    (2,'Mecanica'),
    (3,'Eletrica');
    
select * from Equipe;

-- Populando tabela Mecanico

ALTER TABLE `mecanica`.`Mecanico` 
CHANGE COLUMN `idMecanico` `idMecanico` INT NOT NULL AUTO_INCREMENT ;

insert into Mecanico (Nome, especialidade, disponibilidade, endereco, telefone, email, Equipe_idEquipe)
VALUES 
	('Miss Melody Welch', 'Mecanica', true, '9719 Ernie Prairie', '23402-4904', 'Alvah.Schowalter75@gmail.com', '1'),
	('Tami Abbott', 'Funilaria', false, '8349 Dare Extensions', '92331-2742', 'Fausto_Walker91@hotmail.com', '2'),
	('Mr. Sophie OHara', 'Funilaria', true, '93758 Rasheed Flat', '69179-7688', 'Harvey_Tillman@hotmail.com', '1'),
	('Cindy Hintz', 'Funilaria', false, '684 Kemmer Glens', '14762-0359', 'Minnie_Hammes@hotmail.com', '1'),
	('Mrs. Kristen Tromp', 'Mecanica', true, '983 Casimir Union', '77591-2741', 'Ford9@yahoo.com', '3'),
	('Arthur Kshlerin', 'Funilaria', false, '72209 Blaise Mills', '66329-6350', 'Floyd92@hotmail.com', '3'),
	('Rosa Schulist', 'Mecanica', true, '07423 Zachary Center', '52440-8630', 'Brain.Satterfield@yahoo.com', '2'),
	('Melba Beer', 'Mecanica', true, '56777 Jones Burg', '61725-8582', 'Cody_Littel73@hotmail.com', '3'),
	('Yvette OReilly', 'Funilaria', false, '924 Lexi Curve', '68754-3319', 'Mable_Bartell38@yahoo.com', '2'),
	('Joshua Jenkins', 'Mecanica', false, '56457 Lelah Crescent', '69592-0370', 'Rene.Mohr@hotmail.com', '3');

select * from Mecanico;

-- Populando tabela Servicos
ALTER TABLE `mecanica`.`Servicos` 
CHANGE COLUMN `idServicos` `idServicos` INT NOT NULL AUTO_INCREMENT ;
ALTER TABLE `mecanica`.`Servicos` 
CHANGE COLUMN `duracao` `duracao` INT NULL DEFAULT NULL ;

insert into Servicos
VALUES 
	(1,'Troca de pecas','Manutencao',100,1),
    (2,'Manutencao eletrica','Eletrico',50,1),
    (3,'Funilaria e Pintura','Funilaria e pintura',1000,5);


desc Servicos;
select * from Servicos;

-- Populando tabela Pecas
ALTER TABLE `mecanica`.`Pecas` 
CHANGE COLUMN `idPecas` `idPecas` INT NOT NULL AUTO_INCREMENT ;
ALTER TABLE `mecanica`.`Pecas` 
ADD COLUMN `Nome` VARCHAR(45) NULL AFTER `idPecas`,
CHANGE COLUMN `idPecas` `idPecas` INT NOT NULL AUTO_INCREMENT ,
CHANGE COLUMN `descricao` `descricao` VARCHAR(255) NULL DEFAULT NULL ;


insert into Pecas
VALUES
	(1,'Carburador','Carbura alguma coisa','CarboMax',60.5),
    (2,'Amortecedor','Amortecimento', 'VaiMacil', 150.9),
    (3,'Morceguinho','Quem tem Celta entende','Batman',120.4),
    (4,'Tinta automotiva', 'Tinta automotiva','FaberCastel',200),
    (5,'Lanterna','Lanterna automotiva','Green Lampadas',45);

desc Pecas;
select * from Pecas;


-- Populando tabela ordemServico
ALTER TABLE `mecanica`.`ordemServico` 
CHANGE COLUMN `idordemServico` `idordemServico` INT NOT NULL AUTO_INCREMENT ;

insert into ordemServico (idordemServico,descricao,dataEmissao,Equipe_idEquipe,Veiculo_idVeiculo,Veiculo_Cliente_idCliente)
VALUES 
	('Manutencao mecanica',curdate(),1,1,1);


select * from ordemServico;

-- populando tabela Pecasutilizadas

insert into PecasUtilizadas
values
	(1,2,1),
    (2,2,1);

select * from ServicosExecutados;

-- populando tabela servicosExecutados
insert into ServicosExecutados
values
(1,2,null);

-- Seleciona as pecas utilizadas para o serviço
select OS.descricao, PU.pecas_idPecas,PE.valor as 'Valor unitario'
from ordemServico OS 
inner join PecasUtilizadas PU
inner join Pecas PE
where OS.idordemServico = PU.ordemServico_idordemServico and PU.Pecas_idPecas = PE.idPecas;


Select ROUND(SUM(PE.valor),2) as Total 
from Pecas PE
inner join PecasUtilizadas PU
inner join ordemServico OS
where PU.Pecas_idPecas = PE.idPecas and OS.idordemServico = 2;


select * from PecasUtilizadas;

select * from Pecas;


