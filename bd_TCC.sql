create database bd_tcc;
use bd_tcc;	

    
    /* TABELAS SEM CHAVES ESTRANGEIRAS*/
    
create table tbl_curso(
	id int primary key auto_increment,
	curso varchar(35) not null,
	turno enum( "manhã", "tarde", "noite") not null,
	semestre int not null,
	modalidade enum( "presencial", "hibrido", "ead") not null,
	coordenador varchar(200) not null,
	createAt datetime not null default CURRENT_TIMESTAMP,
	deletedAt datetime
);

create table tbl_type (
	id int primary key auto_increment,
	tipo enum("coordenador pedagógico", "secretaria", "coordenador de curso", "professor")
);




CREATE TABLE tbl_usuario (
	id INT PRIMARY KEY AUTO_INCREMENT,
	RM VARCHAR(15),
	CPF VARCHAR(11) NOT NULL,
	nome VARCHAR(50) NOT NULL,
	email VARCHAR(50) NOT NULL,
	senha VARCHAR(60) NOT NULL, -- bcrypt hash
	createdAt DATETIME DEFAULT CURRENT_TIMESTAMP,
	deletedAt DATETIME
);	

create table tbl_endereco(
	id int primary key auto_increment,
	CEP int not null,
	logradouro varchar(50) not null,
	bairro varchar(20) not null,
	cidade varchar(40) not null,
	numero varchar(10) not null,
	UF enum("AC","AL","AP",
	"AM","BA","CE","DF","ES","GO","MA",
	"MT","MS","MG","PA","PB","PR","PE",
	"PI","RJ","RN", "RS","RO","RR","SC",
	"SP", "SE","TO") not null,
	createAt datetime not null default CURRENT_TIMESTAMP,
	deletedAt datetime
);

create table tbl_responsavel(
	id int primary key auto_increment,
	CPF varchar(11) not null unique,
	nome varchar(50) not null,
	data_nasc date not null,
	estado_civil enum("Solteiro(a)", "Casado(a)",
	"Divorciado(a)","Viúvo(a)","Separado(a)"),
	email varchar(50) not null unique,
	telefone varchar(20) not null unique,
	createAt datetime not null default CURRENT_TIMESTAMP,
	deletedAt datetime
);

CREATE TABLE tbl_alergias (
	id int primary key auto_increment,
	alergias enum('sim','não') not null,
	tp_alergia varchar(200)
);

CREATE TABLE  tbl_diagnostica(
	id int primary key auto_increment,
	diagnostico ENUM('sim', 'não') not null,
	tp_diag VARCHAR(200)
);

CREATE TABLE tbl_deficiencias(
	id int primary key auto_increment,
	deficiencia ENUM('sim', 'não') not null,
	tp_defi VARCHAR(200)
);

CREATE TABLE tbl_restricoes(
	id int primary key auto_increment,
	restri_alimentar ENUM('sim', 'não') not null,
	tp_restricao VARCHAR(200)
);

CREATE TABLE tbl_dificuldades_educacionais (
	id int primary key auto_increment,
	dificuldades ENUM("sim","não") not null,
	tp_dificuldades varchar(200)
);

CREATE TABLE registros_aulas (
	id int primary key auto_increment,
	comentario varchar(1000) not null,
	id_professor int not null,
	createdAt datetime default current_timestamp,
	deletedAt datetime
);

CREATE TABLE tbl_medicamentos(
	id int primary key auto_increment,
	medicamento ENUM('sim', 'não') not null,
	tp_medi VARCHAR(200)
);

CREATE TABLE tbl_cirurgias(
	id int primary key auto_increment,
	internacao_cirurgia ENUM('sim', 'não') not null,
	tp_cirurgia VARCHAR(200)
);
    
    
    
    
    /* TABELAS COM CHAVES ESTRANGEIRAS */
create table tbl_cadastro_al(
	id int primary key auto_increment,
	ra varchar(15) not null unique,
	nome varchar(50) not null,
	data_nasc date not null,
	genero enum( "Feminino", "Masculino", "Não Binario", "Prefiro não informar", "Outros") not null,
	email varchar(50) not null unique,
	telefone varchar(15) not null unique,
	id_endereco int not null,
	createAt datetime not null default CURRENT_TIMESTAMP,
	deletedAt datetime ,
	foreign key (id_endereco) references tbl_endereco(id)
);

CREATE TABLE tbl_dadosMedicos(
	id int primary key auto_increment,
	sexo ENUM('feminino', 'masculino'),
	tp_sangue ENUM('A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'),
	peso DECIMAL(5,2),
	altura DECIMAL(4,2),
	gravidez ENUM('sim', 'não') not null,
	idade INT not null,
	alcool ENUM('sim', 'não') not null,
	fumo ENUM('sim', 'não') not null,
	drogas ENUM('sim', 'não') not null,    
	obs VARCHAR(200),
	laudo VARCHAR(2083),
	id_alergias int not null,
	id_diagnostico int not null,
	id_deficiencias int not null,
	id_restricoes int not null,
	id_cirurgias int not null,
	id_medicamentos int not null,
	id_aluno int,
	id_dificuldades int,
	foreign key (id_aluno) references tbl_cadastro_al(id),
	foreign key (id_medicamentos) references tbl_medicamentos(id),
	foreign key (id_cirurgias) references tbl_cirurgias(id),
	foreign key (id_restricoes) references tbl_restricoes(id),
	foreign key (id_deficiencias) references tbl_deficiencias(id),
	foreign key (id_diagnostico) references tbl_diagnostica(id),
	foreign key (id_alergias) references tbl_alergias(id),
	foreign key (id_dificuldades) references tbl_dificuldades_educacionais(id)
); 
    
	
    
    /*N-Ns*/
    
CREATE TABLE juncao_al_responsaveis(
	id_aluno int not null,
	id_responsaveis int not null,
	foreign key (id_aluno) references tbl_cadastro_al(id),
	foreign key (id_responsaveis) references tbl_responsavel(id)
);

CREATE TABLE juncao_al_curso(
	id_aluno int not null,
	id_curso int not null,
	foreign key (id_aluno) references tbl_cadastro_al(id),
	foreign key (id_curso) references tbl_curso(id)
);

create table juncao_curso_user(
	id_curso int not null,
	id_user int not null,
	foreign key (id_curso) references tbl_curso(id),
	foreign key (id_user) references tbl_usuario(id)
);

create table juncao_type_user(
	id_type int not null,
	id_user int not null,
	foreign key (id_type) references tbl_type(id),
	foreign key (id_user) references tbl_usuario(id)
);

create table juncao_registros_user(
	id_registro_aula int not null,
	id_user int not null,
	foreign key (id_registro_aula) references registros_aulas(id),
	foreign key (id_user) references tbl_usuario(id)
);

create table juncao_registros_al(
	id_registro_aula int not null,
	id_aluno int not null,
	foreign key (id_registro_aula) references registros_aulas(id),
	foreign key (id_aluno) references tbl_cadastro_al(id)
);
    
    
    /*SELECTs*/
    #SELECT * FROM tbl_al_curso WHERE id_aluno =  AND deletedAt IS NULL;
select * from juncao_al_curso;
select * from juncao_al_responsaveis;
select * from juncao_curso_user;
select * from juncao_registros_al;
select * from juncao_registros_user;
select * from juncao_type_user;
select * from registros_aulas;
select * from tbl_alergias;
select * from tbl_cadastro_al;
select * from tbl_cirurgias;
select * from tbl_curso;
select * from tbl_dadosMedicos;
select * from tbl_deficiencias;
select * from tbl_diagnostica;
select * from tbl_endereco;
select * from tbl_medicamentos;
select * from tbl_responsavel;
select * from tbl_resticoes;
select * from tbl_type;
select * from tbl_usuario;

    
    
    /* DROPS*/
drop database bd_tcc;
#adicionar
drop table juncao_al_curso;
drop table juncao_al_responsavel;
drop table juncao_curso_user;
drop table juncao_registros_al;
drop table juncao_registros_user;
drop table juncao_type_user;
drop table tbl_medicamentos;
drop table tbl_cirurgias;
drop table tbl_restricoes;
drop table tbl_deficiencias;
drop table tbl_diagnostica;
drop table tbl_alergias;
drop table tbl_dadosMedicos;
drop table tbl_responsavel;
drop table tbl_endereco;
drop table tbl_usuario;
drop table tbl_type;
drop table tbl_cadastro_al;
drop table tbl_curso;
drop table registros_aulas;  