CREATE DATABASE pericia_e_feminicidio;
USE pericia_e_feminicidio;

CREATE TABLE instituto_criminal (
id_instituto INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
cnpj CHAR(14) UNIQUE NOT NULL,
nome VARCHAR(100) NOT NULL,
email VARCHAR(100) NOT NULL UNIQUE,
codigo_ativacao CHAR(5) UNIQUE NOT NULL,
cep CHAR(14) NOT NULL,
cadastrado_em DATETIME DEFAULT CURRENT_TIMESTAMP(),
atualizado_em DATETIME DEFAULT CURRENT_TIMESTAMP() ON UPDATE CURRENT_TIMESTAMP
);

INSERT INTO instituto_criminal (cnpj, nome, email, codigo_ativacao, cep)
VALUES 
('12345678000111', 'Instituto de Criminalística de São Paulo', 'sp@instituto.br', 'ICSP1', 18708330),
('32345678000133', 'Instituto de Criminalística de Minas Gerais', 'mg@instituto.br', 'ICMG3', 38701626);


CREATE TABLE funcionario (
id_funcionario INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
nome VARCHAR(50) NOT NULL,
cpf CHAR(11) NOT NULL UNIQUE,
telefone CHAR(11),
email VARCHAR(100) NOT NULL UNIQUE,
senha VARCHAR(100) NOT NULL,
cargo VARCHAR(100) NOT NULL,
situacao_funcionario BOOLEAN NOT NULL DEFAULT TRUE,
fk_instituto INT NOT NULL,
cadastrado_em DATETIME DEFAULT CURRENT_TIMESTAMP(),
atualizado_em DATETIME DEFAULT CURRENT_TIMESTAMP() ON UPDATE CURRENT_TIMESTAMP,
CONSTRAINT check_cargo CHECK (cargo IN ('diretor', 'coordenador', 'perito criminal', 'auxiliar tecnico')),
FOREIGN KEY (fk_instituto) REFERENCES instituto_criminal(id_instituto)
);

INSERT INTO funcionario (nome, cpf, telefone, email, senha, cargo, situacao_funcionario, fk_instituto)
VALUES
('Marcos Almeida', '11111111111', '11988887777', 'marcos@instituto.br', '123', 'perito criminal', 1, 1),
('Juliana Rocha', '22222222222', '31977776666', 'juliana@instituto.br', '123', 'coordenador', 1, 2),
('Felipe Santos', '33333333333', '31966665555', 'felipe@instituto.br', '123', 'perito criminal', 1, 2);

select * from funcionario;

CREATE TABLE caso_feminicidio (
id_caso INT PRIMARY KEY AUTO_INCREMENT,
titulo VARCHAR(150) NOT NULL,
descricao VARCHAR(255) NOT NULL,
categoria VARCHAR(50),
CONSTRAINT chkCategoria CHECK (
categoria IN ('intimo', 'nao-intimo', 'familiar')),
estado VARCHAR(100) NOT NULL,
cidade VARCHAR(100) NOT NULL,
situacao VARCHAR(50),
CONSTRAINT chkCaso CHECK (situacao IN ('aberto', 'em analise', 'laudo emitido', 'finalizado')),
dt_inicio DATE NOT NULL,
dt_fim DATE,
fk_funcionario INT,
fk_instituto INT NOT NULL,
cadastrado_em DATETIME DEFAULT CURRENT_TIMESTAMP(),
atualizado_em DATETIME DEFAULT CURRENT_TIMESTAMP() ON UPDATE CURRENT_TIMESTAMP,
FOREIGN KEY (fk_instituto) REFERENCES instituto_criminal(id_instituto),
FOREIGN KEY (fk_funcionario) REFERENCES funcionario(id_funcionario)
);

-- 5 CASOS SP

INSERT INTO caso_feminicidio 
(titulo, descricao, categoria, estado, cidade, situacao, dt_inicio, dt_fim, fk_funcionario, fk_instituto)
VALUES
('Caso SP 001', 'Análise inicial da cena do crime', 'intimo', 'SP', 'São Paulo', 'aberto', '2026-01-10', NULL, 1, 1),
('Caso SP 002', 'Coleta de vestígios em residência', 'familiar', 'SP', 'Campinas', 'em analise', '2026-01-12', NULL, 1, 1),
('Caso SP 003', 'Investigação em área urbana', 'nao-intimo', 'SP', 'Santos', 'laudo emitido', '2026-01-15', '2026-01-20', 1, 1),
('Caso SP 004', 'Análise laboratorial de evidências', 'intimo', 'SP', 'Ribeirão Preto', 'finalizado', '2026-01-18', '2026-01-25', 1, 1),
('Caso SP 005', 'Perícia em crime doméstico', 'familiar', 'SP', 'Sorocaba', 'em analise', '2026-01-22', NULL, 1, 1);

-- 6 CASOS MG

INSERT INTO caso_feminicidio (titulo, descricao, categoria, estado, cidade, situacao, dt_inicio, dt_fim, fk_funcionario, fk_instituto)
VALUES
('Caso MG 001', 'Perícia inicial em cena de crime residencial', 'intimo', 'MG', 'Belo Horizonte', 'aberto', '2026-02-01', NULL, 3, 2),
('Caso MG 002', 'Coleta de vestígios em ambiente familiar', 'familiar', 'MG', 'Uberlândia', 'em analise', '2026-02-03', NULL, 3, 2),
('Caso MG 003', 'Análise de evidências físicas em local urbano', 'nao-intimo', 'MG', 'Contagem', 'laudo emitido', '2026-02-05', '2026-02-10', 3, 2),
('Caso MG 004', 'Investigação pericial em área rural isolada', 'intimo', 'MG', 'Juiz de Fora', 'finalizado', '2026-02-07', '2026-02-15', 3, 2),
('Caso MG 005', 'Exame de vestígios biológicos e DNA', 'familiar', 'MG', 'Betim', 'em analise', '2026-02-09', NULL, 3, 2),
('Caso MG 006', 'Perícia documental e análise complementar do caso', 'nao-intimo', 'MG', 'Montes Claros', 'aberto', '2026-02-12', NULL, 3, 2);

CREATE TABLE etapa_do_caso (
id_etapa INT PRIMARY KEY AUTO_INCREMENT,
fk_caso INT NOT NULL,
fk_funcionario INT NOT NULL,
etapa VARCHAR(100) NOT NULL,
CONSTRAINT chkInvestigacao CHECK (etapa IN ('isolamento da cena','registro fotografico','coleta de vestigios','exame externo do corpo','iml','analise laboratorial')),
situacao VARCHAR(50) NOT NULL,
CONSTRAINT chkSituacaoInvestigacao CHECK (situacao IN ('pendente', 'em andamento', 'concluido')),
dt_inicio DATE,
dt_fim DATE,
cadastrado_em DATETIME DEFAULT CURRENT_TIMESTAMP(),
atualizado_em DATETIME DEFAULT CURRENT_TIMESTAMP() ON UPDATE CURRENT_TIMESTAMP,
FOREIGN KEY (fk_caso) REFERENCES caso_feminicidio(id_caso),
FOREIGN KEY (fk_funcionario) REFERENCES funcionario(id_funcionario)
);

INSERT INTO etapa_do_caso (fk_caso, fk_funcionario, etapa, situacao, dt_inicio, dt_fim)
VALUES
(1, 1, 'isolamento da cena', 'concluido', '2026-01-10', '2026-01-10'),
(2, 1, 'coleta de vestigios', 'em andamento', '2026-01-12', NULL),
(3, 1, 'analise laboratorial', 'concluido', '2026-01-15', '2026-01-18'),

(6, 3, 'isolamento da cena', 'concluido', '2026-02-01', '2026-02-01'),
(7, 3, 'coleta de vestigios', 'em andamento', '2026-02-03', NULL),
(8, 3, 'analise laboratorial', 'concluido', '2026-02-05', '2026-02-08');

CREATE TABLE evidencia (
id_evidencia INT PRIMARY KEY AUTO_INCREMENT,
fk_caso INT,
tipo_evidencia VARCHAR(100) NOT NULL,
CONSTRAINT chkEvidencia CHECK (tipo_evidencia IN ('biologica', 'digital', 'fisica', 'documental')),
descricao VARCHAR(255),
caminho_arquivo VARCHAR(255),
dt_coleta DATE,
cadastrado_em DATETIME DEFAULT CURRENT_TIMESTAMP(),
atualizado_em DATETIME DEFAULT CURRENT_TIMESTAMP() ON UPDATE CURRENT_TIMESTAMP,
FOREIGN KEY (fk_caso) REFERENCES caso_feminicidio(id_caso)
);

INSERT INTO evidencia (fk_caso, tipo_evidencia, descricao, caminho_arquivo, dt_coleta)
VALUES
(1, 'biologica', 'Amostras de sangue', '/evidencias/sp1.png', '2026-01-10'),
(2, 'fisica', 'Objeto encontrado', '/evidencias/sp2.png', '2026-01-12'),
(3, 'documental', 'Relatório inicial', '/evidencias/sp3.pdf', '2026-01-15'),

(6, 'biologica', 'DNA coletado', '/evidencias/mg1.png', '2026-02-01'),
(7, 'fisica', 'Arma branca', '/evidencias/mg2.png', '2026-02-03'),
(8, 'documental', 'Laudo preliminar', '/evidencias/mg3.pdf', '2026-02-05');

CREATE TABLE laudo_pericial (
fk_caso INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
fk_funcionario INT NOT NULL,
descricao_cena VARCHAR(255),
metodologia VARCHAR(255),
analises VARCHAR(255),
conclusao VARCHAR(255),
caminho_pdf VARCHAR(255),
dt_emissao DATE NOT NULL,
situacao VARCHAR(50) NOT NULL,
cadastrado_em DATETIME DEFAULT CURRENT_TIMESTAMP(),
atualizado_em DATETIME DEFAULT CURRENT_TIMESTAMP() ON UPDATE CURRENT_TIMESTAMP,
CONSTRAINT chkLaudo CHECK (situacao IN ('rascunho', 'finalizado')),
FOREIGN KEY (fk_caso) REFERENCES caso_feminicidio(id_caso),
FOREIGN KEY (fk_funcionario) REFERENCES funcionario(id_funcionario)
);

INSERT INTO laudo_pericial (fk_caso, fk_funcionario, descricao_cena, metodologia, analises, conclusao, caminho_pdf, dt_emissao, situacao)
VALUES
(1, 1, 'Cena parcial', 'Análise visual', 'Sem conclusões', 'Em investigação', '/laudos/sp1.pdf', '2026-01-11', 'rascunho'),
(3, 1, 'Cena urbana', 'Coleta forense', 'Indícios fortes', 'Requer análise', '/laudos/sp3.pdf', '2026-01-16', 'rascunho'),
(4, 1, 'DNA analisado', 'Laboratório', 'Compatível', 'Caso concluído', '/laudos/sp4.pdf', '2026-01-20', 'finalizado'),

(6, 3, 'Cena MG inicial', 'Inspeção', 'Sem conclusão', 'Em andamento', '/laudos/mg1.pdf', '2026-02-02', 'rascunho'),
(8, 3, 'Evidências físicas', 'Coleta e comparação', 'Indícios fortes', 'Requer aprofundamento', '/laudos/mg3.pdf', '2026-02-06', 'rascunho'),
(9, 3, 'DNA analisado', 'Laboratório forense', 'Compatível com suspeito', 'Caso finalizado', '/laudos/mg4.pdf', '2026-02-10', 'finalizado');
