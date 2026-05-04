create database pericia_e_feminicidio;
use pericia_e_feminicidio;

create table instituto_criminal(
id_instituto int primary key auto_increment not null,
cnpj char(14) unique not null,
nome varchar(100) not null,
email VARCHAR(100) NOT NULL UNIQUE, -- EMAIL único
cadastrado_em DATETIME DEFAULT CURRENT_TIMESTAMP(),
atualizado_em DATETIME DEFAULT CURRENT_TIMESTAMP() ON UPDATE CURRENT_TIMESTAMP,
codigo_ativacao char(5) unique not null
);

INSERT INTO instituto_criminal (cnpj, nome, email, codigo_ativacao)
VALUES 
('12345678000111', 'Instituto de Criminalística de São Paulo', 'sp@instituto.br', 'ICSP1'),
('22345678000122', 'Instituto de Criminalística do Rio de Janeiro', 'rj@instituto.br', 'ICRJ2'),
('32345678000133', 'Instituto de Criminalística de Minas Gerais', 'mg@instituto.br', 'ICMG3');

create table instituto_endereco (
rua VARCHAR(100) NOT NULL,
numero VARCHAR(10) NOT NULL,
bairro VARCHAR(100) NOT NULL,
cep CHAR(8) NOT NULL,
estado CHAR(2) NOT NULL,
municipio VARCHAR(50) NOT NULL,
fk_instituto INT NOT NULL,
cadastrado_em DATETIME DEFAULT CURRENT_TIMESTAMP(),
atualizado_em DATETIME DEFAULT CURRENT_TIMESTAMP() ON UPDATE CURRENT_TIMESTAMP,
FOREIGN KEY (fk_instituto) REFERENCES instituto_criminal(id_instituto)
);

INSERT INTO instituto_endereco (rua, numero, bairro, cep, estado, municipio, fk_instituto)
VALUES
('Av. Doutor Arnaldo', '123', 'Cerqueira César', '01246000', 'SP', 'São Paulo', 1),
('Rua da Polícia', '45', 'Centro', '20010000', 'RJ', 'Rio de Janeiro', 2),
('Av. Amazonas', '900', 'Centro', '30180000', 'MG', 'Belo Horizonte', 3);

create table funcionario(
id_funcionario INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
nome VARCHAR(50) NOT NULL,
cpf CHAR(11) NOT NULL UNIQUE, 
telefone CHAR(11),
email VARCHAR(100) NOT NULL UNIQUE, -- EMAIL único
senha VARCHAR(100) NOT NULL,
cargo VARCHAR(100) NOT NULL,
situacao_funcionario BOOLEAN NOT NULL DEFAULT FALSE, -- ativo ou inativo
fk_instituto INT NOT NULL,
cadastrado_em DATETIME DEFAULT CURRENT_TIMESTAMP(),
atualizado_em DATETIME DEFAULT CURRENT_TIMESTAMP() ON UPDATE CURRENT_TIMESTAMP, 
CONSTRAINT check_cargo CHECK (cargo IN ('admin', 'diretor', 'perito', 'coordenador', 'assistente_tecnico')),
FOREIGN KEY (fk_instituto) REFERENCES instituto_criminal(id_instituto)
);

INSERT INTO funcionario (nome, cpf, telefone, email, senha, cargo, situacao_funcionario, fk_instituto)
VALUES
('Marcos Almeida', '11111111111', '11988887777', 'marcos@instituto.br', '123', 'perito', 1, 1),
('Juliana Rocha', '22222222222', '21977776666', 'juliana@instituto.br', '123', 'coordenador', 1, 2),
('Felipe Santos', '33333333333', '31966665555', 'felipe@instituto.br', '123', 'perito', 1, 3);

CREATE TABLE caso_feminicidio (
id_caso INT PRIMARY KEY AUTO_INCREMENT,
titulo VARCHAR(150) NOT NULL,
descricao varchar(255) not null,
categoria varchar(50),
constraint chkCategoria check (categoria in ('intimo', 'nao-intimo', 'familiar')),
estado varchar(100) not null,
cidade varchar(100) not null,
situacao varchar(50),
constraint chkCaso check (situacao in ('aberto', 'em_analise', 'laudo_emitido', 'finalizado')), 
dt_inicio DATE NOT NULL,
dt_fim DATE,
fk_perito INT,
FOREIGN KEY (fk_perito) REFERENCES funcionario(id_funcionario)
);

INSERT INTO caso_feminicidio (titulo, descricao, categoria, estado, cidade, situacao, dt_inicio, dt_fim, fk_perito)
VALUES
('Caso 001', 'Análise inicial de cena de crime', 'intimo', 'SP', 'São Paulo', 'aberto', '2026-01-10', NULL, 1),
('Caso 002', 'Investigação de possível feminicídio familiar', 'familiar', 'RJ', 'Rio de Janeiro', 'em_analise', '2026-01-12', NULL, 2),
('Caso 003', 'Perícia completa em local de crime', 'nao-intimo', 'MG', 'Belo Horizonte', 'laudo_emitido', '2026-01-15', '2026-01-20', 3);

CREATE TABLE etapa_do_caso (
id_etapa INT PRIMARY KEY AUTO_INCREMENT,
fk_caso INT not null,
fk_funcionario INT not null,
etapa varchar(100) not null,
constraint chkInvestigacao check (etapa in ('isolamento_cena', 'registro_fotografico', 'coleta_vestigios', 'exame_externo_corpo', 'iml', 'analise_laboratorial')),
situacao varchar(50) not null,
constraint chkSituacaoInvestigacao check (situacao in ('pendente', 'em_andamento', 'concluido')), 
dt_inicio DATE,
dt_fim DATE,
FOREIGN KEY (fk_caso) REFERENCES caso_feminicidio(id_caso),
FOREIGN KEY (fk_funcionario) REFERENCES funcionario(id_funcionario)
);


INSERT INTO etapa_do_caso (fk_caso, fk_funcionario, etapa, situacao, dt_inicio, dt_fim)
VALUES
(1, 1, 'isolamento_cena', 'concluido', '2026-01-10', '2026-01-10'),
(2, 2, 'coleta_vestigios', 'em_andamento', '2026-01-12', NULL),
(3, 3, 'analise_laboratorial', 'concluido', '2026-01-15', '2026-01-18');


CREATE TABLE evidencia (
id_evidencia INT PRIMARY KEY AUTO_INCREMENT not null,
fk_caso INT,
tipo_evidencia varchar(100) not null,
constraint chkEvidencia check (tipo_evidencia in ('biologica', 'digital', 'fisica', 'documental')),
descricao varchar(255),
caminho_arquivo VARCHAR(255), 
dt_coleta DATE,
FOREIGN KEY (fk_caso) REFERENCES caso_feminicidio(id_caso)
);

INSERT INTO evidencia (fk_caso, tipo_evidencia, descricao, caminho_arquivo, dt_coleta)
VALUES
(1, 'biologica', 'Amostras de sangue no local', '/evidencias/caso1.png', '2026-01-10'),
(2, 'fisica', 'Objeto metálico encontrado', '/evidencias/caso2.png', '2026-01-12'),
(3, 'documental', 'Relatório pericial completo', '/evidencias/caso3.pdf', '2026-01-16');

CREATE TABLE laudo_pericial (
id_laudo INT PRIMARY KEY AUTO_INCREMENT not null,
fk_caso INT NOT NULL,
fk_perito INT NOT NULL,
descricao_cena varchar(255),
metodologia varchar(255),
analises varchar(255),
conclusao varchar(255),
caminho_pdf VARCHAR(255),
dt_emissao DATE NOT NULL,
situacao varchar(50) not null,
constraint chkLaudo check (situacao in ('rascunho', 'finalizado')), 
FOREIGN KEY (fk_caso) REFERENCES caso_feminicidio(id_caso),
FOREIGN KEY (fk_perito) REFERENCES funcionario(id_funcionario)
);

INSERT INTO laudo_pericial (fk_caso, fk_perito, descricao_cena, metodologia, analises, conclusao, caminho_pdf, dt_emissao, situacao)
VALUES
(1, 1, 'Cena preservada parcialmente', 'Análise visual e coleta', 'Sem vestígios conclusivos', 'Caso em investigação', '/laudos/laudo1.pdf', '2026-01-11', 'rascunho'),
(2, 2, 'Cena com múltiplos vestígios', 'Coleta e comparação forense', 'Indícios fortes encontrados', 'Requer aprofundamento', '/laudos/laudo2.pdf', '2026-01-14', 'rascunho'),
(3, 3, 'Análise laboratorial completa', 'DNA e perícia digital', 'Compatível com suspeito', 'Caso concluído com evidências sólidas', '/laudos/laudo3.pdf', '2026-01-20', 'finalizado');