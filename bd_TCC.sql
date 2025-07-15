create database bd_tcc;
use bd_tcc;
drop database bd_tcc;

#Guilherme 
create table tbl_cadastro_aluno(
id int primary key auto_increment,
RM varchar(7) not null unique,
nome varchar(50) not null,
data_nasc date not null,
genero enum( "Feminino", "Masculino", "Não Binario", "Prefiro não informar", "Outros") not null,
email varchar(50) not null unique,
telefone varchar(15) not null unique,
id_curso int, 
id_responsavel int,
id_endereco int, 
createAt datetime not null default CURRENT_TIMESTAMP,	
deletedAt datetime,
foreign key (id_responsavel) references tbl_responsavel(id),
foreign key (id_endereco) references tbl_endereco(id),
foreign key (id_curso) references tbl_curso(id)
);
drop table tbl_cadastro_aluno;
select * from tbl_cadastro_aluno;	

create table tbl_curso_prof(
id_professor int,
id_curso int,
foreign key (id_professor) references tbl_usuario(id),
foreign key (id_curso) references tbl_curso(id)
);
drop table tbl_curso_prof;

drop table tbl_cadastro_aluno;

#Kenny
create table tbl_curso(
id int primary key auto_increment,
curso varchar(35) not null,
turno enum( "manhã", "tarde", "noite") not null,
semestre int not null,
modalidade enum( "presencial", "hibrido", "ead") not null,
createAt datetime not null default CURRENT_TIMESTAMP,
deletedAt datetime 
);
drop table tbl_curso;

create table tbl_type (
id int primary key auto_increment,
tipo enum("coordenador_pedagogico", "secretaria", "coordenador_curso", "professor")
);

select * from tbl_type;
drop table tbl_type;

                            
                            
                            
CREATE TABLE tbl_usuario (
  id INT PRIMARY KEY AUTO_INCREMENT,
  CPF VARCHAR(11) NOT NULL ,
  nome VARCHAR(50) NOT NULL,
  email VARCHAR(50) NOT NULL ,
  senha VARCHAR(60) NOT NULL, -- bcrypt hash
  id_tipo int,
  createdAt DATETIME DEFAULT CURRENT_TIMESTAMP,
  deletedAt DATETIME,
  foreign key (id_tipo) references tbl_type(id)
);

select * from tbl_usuario;

drop table tbl_usuario;

#Guilherme
#create table tbl_login_professor(
#id int primary key auto_increment,
#RM int(7) unique,
#CPF varchar(11) not null unique,
#nome varchar(50) not null,
#email varchar(50) not null unique,
#senha varchar(20) not null,
#createAt datetime not null default CURRENT_TIMESTAMP,
#deletedAt datetime 
#);
#select * from tbl_login_professor;

#truncate table tbl_login_professor;
#drop table tbl_login_professor;

#Kenny
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
drop table tbl_endereco;

#Guilherme
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
select * from tbl_responsavel;
drop table tbl_responsavel;

#Kenny 
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
    foreign key (id_medicamentos) references tbl_medicamentos(id),
    foreign key (id_cirurgias) references tbl_cirurgias(id),
    foreign key (id_restricoes) references tbl_restricoes(id),
    foreign key (id_deficiencias) references tbl_deficiencias(id),
    foreign key (id_diagnostico) references tbl_diagnostica(id),
    foreign key (id_alergias) references tbl_alergias(id)
);
drop table tbl_dadosMedicos;

#Guilherme 
CREATE TABLE tbl_alergias (
	id int primary key auto_increment,
	alergias enum('sim','não') not null,
	tp_alergia varchar(200)
);
select * from tbl_alergias;
insert into tbl_alergias value(default, 'não', default);

drop table tbl_alergias;

#Kenny
CREATE TABLE  tbl_diagnostica(
	id int primary key,
    diagnostico ENUM('sim', 'não') not null,
    tp_diag VARCHAR(200)
);
drop table tbl_diagnostica;
    
#Guilherme
CREATE TABLE tbl_deficiencias(
	id int primary key auto_increment,
    deficiencia ENUM('sim', 'não') not null,
    tp_defi VARCHAR(200)
);
select * from tbl_deficiencias;	

drop table tbl_deficiencias;
 
 #Kenny
CREATE TABLE tbl_restricoes(
	id int primary key,
    restri_alimentar ENUM('sim', 'não') not null,
    tp_restricao VARCHAR(150)
);
drop table tbl_restricoes;

#Guilherme 
CREATE TABLE tbl_cirurgias(
	id int primary key auto_increment,
    internacao_cirurgia ENUM('sim', 'não') not null,
    tp_cirurgia VARCHAR(200)
);

select * from tbl_cirurgias;	
drop table tbl_cirurgias;
    
#Kenny
CREATE TABLE tbl_medicamentos(
	id int primary key auto_increment,
    medicamento ENUM('sim', 'não') not null,
    tp_medi VARCHAR(200)
);	
drop table tbl_medicamentos;
    
select * from tbl_cadastro_aluno;
truncate table tbl_cadastro_aluno;	