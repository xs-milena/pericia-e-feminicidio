create database pericia_e_feminicidio;
use pericia_e_feminicidio;

/*
TABELAS:
- INVESTIGACAO - informações sobre a investigação
- CASO_CRIMINAL - infromações sobre o caso criminal
- VÍTIMA - informações sobre a vítima
- SUSPEITO - informações sobre o suspeito
- VESTÍGIO - informações sobre o vestígio encontrado na cena do crime
- LAUDO PERICIAL - informações sobre a documentação do crime
*/

create table investigacao (
id_investigacao int primary key auto_increment,
tipo_pericia varchar(50)
constraint chkTipo_pericia check (tipo_pericia in ('local de crime', 'necroscópica', 'laboratorial', 'digital', 'odontolegal')),
perito_responsavel varchar(100),
dt_inicio date,
dt_fim date,
situacao varchar(50),
constraint chkInvestigacao check (situacao in ('arquivado', 'em andamento', 'concluído'))
);

create table caso_feminicidio (
id_caso int primary key auto_increment,
tipo_crime varchar(50),
constraint chkTipo_crime check (tipo_crime in ('tentativa', 'feminicidio')),
categoria varchar(50),
constraint chkCategoria check (categoria in ('intímo', 'nao-intimo', 'familiar')),
dt_ocorrencia date,
estado varchar(100),
cidade varchar(100),
situacao varchar(50),
constraint chkCaso_feminicidio check (situacao in ('arquivado', 'em andamento', 'concluído'))
);