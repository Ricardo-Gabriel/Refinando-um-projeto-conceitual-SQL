-- Criando um banco de dados para E-commerce 
CREATE DATABASE IF NOT EXISTS ecommerceV3;
USE ecommerceV3;

SET FOREIGN_KEY_CHECKS=0;
SET FOREIGN_KEY_CHECKS=1;

-- Tabela de Clientes
CREATE TABLE IF NOT EXISTS Cliente (
  idCliente INT NOT NULL AUTO_INCREMENT,
  Nome VARCHAR(50) NOT NULL,
  TipoCliente ENUM('PF', 'PJ') NOT NULL,
  Identificacao VARCHAR(45) NOT NULL,
  Endereco VARCHAR(100),
  Contato VARCHAR(45),
  DataNascimento DATE,
  PRIMARY KEY (idCliente),
  UNIQUE (Identificacao)
);

-- Tabela de Formas de Pagamento
CREATE TABLE IF NOT EXISTS FormaPagamento (
  idFormaPagamento INT NOT NULL AUTO_INCREMENT,
  Tipo ENUM('Credito', 'Debito', 'Dois cartões') NOT NULL,
  ChavePix ENUM('cpf', 'celular', 'email', 'chavealeatoria') NOT NULL,
  Boleto FLOAT,
  PRIMARY KEY (idFormaPagamento)
);

-- Tabela de Relação entre Clientes e Formas de Pagamento
CREATE TABLE IF NOT EXISTS ClientePagamento (
  id INT NOT NULL AUTO_INCREMENT,
  Cliente_idCliente INT NOT NULL,
  FormaPagamento_idFormaPagamento INT NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (Cliente_idCliente) REFERENCES Cliente (idCliente),
  FOREIGN KEY (FormaPagamento_idFormaPagamento) REFERENCES FormaPagamento (idFormaPagamento)
);

-- Tabela de Entregas
CREATE TABLE IF NOT EXISTS Entrega (
  idEntrega INT NOT NULL AUTO_INCREMENT,
  Status ENUM('Aprovado', 'Recusado', 'Em processamento') NOT NULL,
  CodRastreio VARCHAR(45),
  PRIMARY KEY (idEntrega)
);

-- Tabela de Relação entre Entregas e Pedidos
CREATE TABLE IF NOT EXISTS EntregaPedido (
  Entrega_idEntrega INT NOT NULL,
  Pedido_idPedido INT NOT NULL,
  PRIMARY KEY (Entrega_idEntrega, Pedido_idPedido),
  FOREIGN KEY (Entrega_idEntrega) REFERENCES Entrega (idEntrega),
  FOREIGN KEY (Pedido_idPedido) REFERENCES Pedido (idPedido)
);

-- Tabela de Vendedores
CREATE TABLE IF NOT EXISTS Vendedor (
  idVendedor INT NOT NULL AUTO_INCREMENT,
  Nome VARCHAR(50) NOT NULL,
  TipoVendedor ENUM('PF', 'PJ') NOT NULL,
  Identificacao VARCHAR(45) NOT NULL,
  Contato VARCHAR(45),
  PRIMARY KEY (idVendedor),
  UNIQUE (Identificacao)
);

-- Tabela de Relação entre Produtos e Vendedores
CREATE TABLE IF NOT EXISTS ProdutoVendedor (
  id INT NOT NULL AUTO_INCREMENT,
  Produto_idProduto INT NOT NULL,
  Vendedor_idVendedor INT NOT NULL,
  Quantidade INT,
  PRIMARY KEY (id),
  FOREIGN KEY (Produto_idProduto) REFERENCES Produto (idProduto),
  FOREIGN KEY (Vendedor_idVendedor) REFERENCES Vendedor (idVendedor)
);

-- Tabela de Produtos
CREATE TABLE IF NOT EXISTS Produto (
  idProduto INT NOT NULL AUTO_INCREMENT,
  Categoria ENUM('eletronicos', 'vestimentas', 'eletrodomesticos', 'Kids') NOT NULL,
  Descricao VARCHAR(45),
  Valor FLOAT NOT NULL,
  Pnome VARCHAR(20),
  Codigo VARCHAR(20),
  PRIMARY KEY (idProduto)
);

-- Tabela de Relação entre Produtos e Fornecedores
CREATE TABLE IF NOT EXISTS ProdutoFornecedor (
  id INT NOT NULL AUTO_INCREMENT,
  Produto_idProduto INT NOT NULL,
  Fornecedor_idFornecedor INT NOT NULL,
  Quantidade INT,
  PRIMARY KEY (id),
  FOREIGN KEY (Produto_idProduto) REFERENCES Produto (idProduto),
  FOREIGN KEY (Fornecedor_idFornecedor) REFERENCES Fornecedor (idFornecedor)
);

-- Tabela de Fornecedores
CREATE TABLE IF NOT EXISTS Fornecedor (
  idFornecedor INT NOT NULL AUTO_INCREMENT,
  RazaoSocial VARCHAR(45),
  CNPJ CHAR(14) NOT NULL,
  Localizacao VARCHAR(45),
  Contato CHAR(45) NOT NULL,
  NomeFantasia VARCHAR(45),
  PRIMARY KEY (idFornecedor),
  UNIQUE (CNPJ),
  UNIQUE (RazaoSocial)
);



-- Tabela de Estoque
CREATE TABLE IF NOT EXISTS Estoque (
  idEstoque INT NOT NULL AUTO_INCREMENT,
  Local VARCHAR(45) NOT NULL,
  PRIMARY KEY (idEstoque)
);

-- Tabela de Relação entre Produtos e Estoques
CREATE TABLE IF NOT EXISTS ProdutoEstoque (
  id INT NOT NULL AUTO_INCREMENT,
  Produto_idProduto INT NOT NULL,
  Estoque_idEstoque INT NOT NULL,
  Localizacao VARCHAR(100),
  PRIMARY KEY (id),
  FOREIGN KEY (Produto_idProduto) REFERENCES Produto (idProduto),
  FOREIGN KEY (Estoque_idEstoque) REFERENCES Estoque (idEstoque)
);

-- Tabela de Pedidos
CREATE TABLE IF NOT EXISTS Pedido (
  idPedido INT NOT NULL AUTO_INCREMENT,
  StatusPedido ENUM('Em andamento', 'Em processamento', 'enviado', 'entregue') NULL DEFAULT 'Em processamento',
  Descricao VARCHAR(45),
  Cliente_idCliente INT NOT NULL,
  Frete FLOAT,
  PRIMARY KEY (idPedido),
  FOREIGN KEY (Cliente_idCliente) REFERENCES Cliente (idCliente)
);

-- Tabela de Relação entre Produtos e Pedidos
CREATE TABLE IF NOT EXISTS ProdutoPedido (
  id INT NOT NULL AUTO_INCREMENT,
  Produto_idProduto INT NOT NULL,
  Pedido_idPedido INT NOT NULL,
  Quantidade INT NOT NULL,
  Status ENUM('disponivel', 'sem estoque') NULL DEFAULT 'disponivel',
  PRIMARY KEY (id),
  FOREIGN KEY (Produto_idProduto) REFERENCES Produto (idProduto),
  FOREIGN KEY (Pedido_idPedido) REFERENCES Pedido (idPedido)
);

-- Dados ficticios

-- Inserindo dados fictícios na tabela Cliente
INSERT INTO Cliente (Nome, TipoCliente, Identificacao, Endereco, Contato, DataNascimento)
VALUES
  ('Jose Silva', 'PF', '12487967845', 'Rua da casa, 321', 'jose@email.com', '1950-06-20'),
  ('João Silva', 'PF', '12345678901', 'Rua A, 123', 'joao@eemail.com', '1990-04-18'),
  ('Empresa 1', 'PJ', '12345678901234', 'Av. das empresas, 789', 'empresa@email.com', NULL);

-- Inserindo dados fictícios na tabela FormaPagamento
INSERT INTO FormaPagamento (Tipo, ChavePix, Boleto)
VALUES
  ('Credito', 'cpf', NULL),
  ('Debito', 'celular', NULL),
  ('Dois cartões', 'email', NULL);

-- Inserindo dados fictícios na tabela Vendedor
INSERT INTO Vendedor (Nome, TipoVendedor, Identificacao, Contato)
VALUES
  ('Maria Oliveira', 'PF', '98765432101', 'maria@example.com'),
  ('Empresa XYZ', 'PJ', '98765432101234', 'empresa@example.com'),
  ('Steve Stamm', 'PF', '71952150411', 'Myrtis_Hintz@yahoo.com'),
  ('Olivia Jaskolski', 'PF', '91939583695', 'Dean.Predovic@yahoo.com'),
  ('Wilbur Runte', 'PF', '62266845996', 'Dolores.Bogan@hotmail.com'),
  ('Kevin Witting', 'PF', '50685109178', 'Devante_Upton@yahoo.com'),
  ('Miss Roxanne Nikolaus I', 'PF', '85794269296', 'Nickolas.Yundt@hotmail.com'),
  ('Santos Larson', 'PF', '82252471831', 'Elva_Bahringer@yahoo.com'),
  ('Dominic Heaney', 'PF', '15426325704', 'Lauretta_White@hotmail.com'),
  ('Rick Herman', 'PF', '73296590249', 'Sabrina_Christiansen@gmail.com'),
  ('Wilma Kreiger', 'PF', '29651111329', 'Asa38@hotmail.com'),
  ('Noel Rempel', 'PF', '26189452887', 'Braeden96@hotmail.com'),
  ('Sandra Schneider', 'Pj', '28734671209335', 'Heidi90@yahoo.com'),
  ('Miss Willie Kulas IV', 'Pj', '31780271458486', 'Matilda9@hotmail.com'),
  ('Erik Keeling', 'Pj', '12841620607915', 'Joan.Feil@hotmail.com'),
  ('Lucia Tremblay', 'Pj', '23789629090690', 'Lavinia16@yahoo.com'),
  ('Dr. Roman Lebsack', 'Pj', '19358660819134', 'Mose16@hotmail.com'),
  ('Lee Ebert', 'Pj', '65727262171693', 'Marlen97@gmail.com'),
  ('Calvin Schmitt', 'Pj', '13549044624441', 'Elvera.Koepp@yahoo.com'),
  ('Dr. Darryl Schumm', 'Pj', '16725552033904', 'Deon_Brakus@yahoo.com'),
  ('Lindsey Pagac', 'Pj', '11074886078316', 'Zander_Pollich64@yahoo.com'),
  ('Eula Connelly', 'Pj', '53301493709621', 'Lilian.Sawayn@hotmail.com');

-- Inserindo dados fictícios na tabela Produto
INSERT INTO Produto (Categoria, Descricao, Valor, Pnome, Codigo)
VALUES
  ('eletronicos', 'Smartphone', 1000.00, 'Smartphone 123', 'SP123'),
  ('vestimentas', 'Camiseta', 30.00, 'Camiseta Azul', 'CZ01');

-- Inserindo dados fictícios na tabela Fornecedor
INSERT INTO Fornecedor (RazaoSocial, CNPJ, Localizacao, Contato, NomeFantasia)
VALUES
  ('Fornecedor A', '12345678901230', 'Rua X, 789', 'fornecedorA@example.com', 'FornA Ltda.'),
  ('Fornecedor B', '98765432101230', 'Av. Y, 456', 'fornecedorB@example.com', 'FornB Ltda.');

-- Inserindo dados fictícios na tabela Estoque
INSERT INTO Estoque (Local)
VALUES
  ('São Paulo'),
  ('Rio de Janeiro');

-- Inserindo dados fictícios na tabela Pedido
INSERT INTO Pedido (StatusPedido, Descricao, Cliente_idCliente, Frete)
VALUES
  ('Em andamento', 'Pedido de Eletrônicos', 1, 20.00),
  ('enviado', 'Pedido de Vestimentas', 2, 15.00);

-- Inserindo dados fictícios na tabela ProdutoPedido
INSERT INTO ProdutoPedido (Produto_idProduto, Pedido_idPedido, Quantidade)
VALUES
  (1, 1, 2),
  (2, 1, 5),
  (2, 2, 3);

-- Inserindo dados fictícios na tabela ProdutoVendedor
INSERT INTO ProdutoVendedor (Produto_idProduto, Vendedor_idVendedor, Quantidade)
VALUES
  (1, 1, 10),
  (1, 2, 15),
  (2, 2, 20);

-- Inserindo dados fictícios na tabela ProdutoFornecedor
INSERT INTO ProdutoFornecedor (Produto_idProduto, Fornecedor_idFornecedor, Quantidade)
VALUES
  (1, 1, 50),
  (1, 2, 30),
  (2, 1, 100);
  
  -- Consulta 1: Quantos pedidos foram feitos por cada cliente?
SELECT c.Nome, COUNT(p.idPedido) AS NumeroPedidos
FROM Cliente c
LEFT JOIN Pedido p ON c.idCliente = p.Cliente_idCliente
GROUP BY c.idCliente;

-- Consulta 2: Algum vendedor também é fornecedor?
SELECT v.Nome AS NomeVendedor, f.NomeFantasia AS NomeFornecedor
FROM Vendedor v
INNER JOIN ProdutoVendedor pv ON v.idVendedor = pv.Vendedor_idVendedor
INNER JOIN ProdutoFornecedor pf ON pv.Produto_idProduto = pf.Produto_idProduto
INNER JOIN Fornecedor f ON pf.Fornecedor_idFornecedor = f.idFornecedor;

-- Consulta 3: Relação de produtos fornecedores e estoques:
SELECT p.Descricao AS Produto, f.RazaoSocial AS Fornecedor, e.Local AS Estoque, pf.Quantidade AS QuantidadeNoEstoque
FROM ProdutoFornecedor pf
INNER JOIN Produto p ON pf.Produto_idProduto = p.idProduto
INNER JOIN Fornecedor f ON pf.Fornecedor_idFornecedor = f.idFornecedor
INNER JOIN ProdutoEstoque pe ON pf.Produto_idProduto = pe.Produto_idProduto
INNER JOIN Estoque e ON pe.Estoque_idEstoque = e.idEstoque;

-- Consulta 4: Relação de nomes dos fornecedores e nomes dos produtos:
SELECT f.RazaoSocial AS Fornecedor, p.Descricao AS Produto
FROM ProdutoFornecedor pf
INNER JOIN Fornecedor f ON pf.Fornecedor_idFornecedor = f.idFornecedor
INNER JOIN Produto p ON pf.Produto_idProduto = p.idProduto;