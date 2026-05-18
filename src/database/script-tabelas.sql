CREATE DATABASE pericia_e_feminicidio;
USE pericia_e_feminicidio;

CREATE TABLE usuario (
id_usuario INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
nome VARCHAR(255) NOT NULL,
cpf CHAR(11) NOT NULL UNIQUE,
email VARCHAR(100) NOT NULL UNIQUE,
senha VARCHAR(100) NOT NULL,
tipo_usuario VARCHAR(5) DEFAULT 'comum'
);

INSERT INTO usuario (nome, cpf, email, senha, tipo_usuario)
VALUES 
('Milena Amorim', '12345678901', 'milena@gmail.com', 'milena123', 'admin')
;

CREATE TABLE quiz_reflexao (
id_resposta INT PRIMARY KEY AUTO_INCREMENT,
id_tentativa INT,
fk_usuario INT,
pergunta INT,
alternativa VARCHAR(20),
FOREIGN KEY (fk_usuario) REFERENCES usuario(id_usuario)
);

CREATE TABLE quiz_pericia (
id_tentativa INT PRIMARY KEY AUTO_INCREMENT,
fk_usuario INT,
acertos INT,
erros INT,
total_questoes INT,
FOREIGN KEY (fk_usuario) REFERENCES usuario(id_usuario)
);
