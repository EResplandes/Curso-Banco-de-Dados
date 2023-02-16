CREATE DATABASE IF NOT EXISTS db_faculdade CHARSET utf8mb4 COLLATE utf8mb4_general_ci;

USE db_faculdade;

CREATE TABLE IF NOT EXISTS tipo_telefone (
	cod_tipo INT(4) AUTO_INCREMENT,
    tipo_telefone VARCHAR(8) NOT NULL UNIQUE,
PRIMARY KEY (cod_tipo)
)AUTO_INCREMENT = 1000;

CREATE TABLE IF NOT EXISTS tipo_logradouro (
	cod_tipo_logadouro INT(4) AUTO_INCREMENT,
    tipo_logadouro VARCHAR(11) NOT NULL,
PRIMARY KEY (cod_tipo_logadouro)
)AUTO_INCREMENT = 1000;

CREATE TABLE IF NOT EXISTS turno (
	cod_turno INT(4) AUTO_INCREMENT,
    nome_turno VARCHAR(10) NOT NULL UNIQUE,
PRIMARY KEY (cod_turno)
)AUTO_INCREMENT = 1000;

CREATE TABLE IF NOT EXISTS departamento (
	cod_departamento INT(4) AUTO_INCREMENT,
    nome_departamento VARCHAR(20) NOT NULL UNIQUE,
PRIMARY KEY (cod_departamento)
)AUTO_INCREMENT = 1000;

CREATE TABLE IF NOT EXISTS professor (
	cod_professor INT(4) AUTO_INCREMENT,
    nome_professor VARCHAR(20) NOT NULL,
    sobrenome_professor VARCHAR(50) NOT NULL,
    status BOOLEAN NOT NULL,
    cod_departamento INT (4) NOT NULL,
PRIMARY KEY (cod_professor),
CONSTRAINT fk_cod_departamento FOREIGN KEY (cod_departamento) REFERENCES departamento (cod_departamento)
)AUTO_INCREMENT = 1000;

CREATE TABLE IF NOT EXISTS disciplina (
	cod_disciplina INT(4) AUTO_INCREMENT,
    nome_disciplina VARCHAR(20) NOT NULL UNIQUE,
    carga_horaria INT(4) NOT NULL,
    descricao VARCHAR(50) NOT NULL,
    num_alunos INT(4),
    cod_departamento INT(4),
PRIMARY KEY (cod_disciplina),
CONSTRAINT fk_cod_departamento_d FOREIGN KEY (cod_departamento) REFERENCES departamento (cod_departamento)
)AUTO_INCREMENT = 1000;

CREATE TABLE IF NOT EXISTS professor_disciplina (
	cod_professor INT(4),
    cod_disciplina INT(4),
PRIMARY KEY (cod_professor, cod_disciplina),
CONSTRAINT fk_cod_professor FOREIGN KEY (cod_professor) REFERENCES professor (cod_professor),
CONSTRAINT fk_cod_disciplina_pd FOREIGN KEY (cod_disciplina) REFERENCES disciplina (cod_disciplina)
);

CREATE TABLE IF NOT EXISTS depende (
	cod_disciplina INT(4),
PRIMARY KEY (cod_disciplina),
CONSTRAINT fk_cod_disciplina_d FOREIGN KEY (cod_disciplina) REFERENCES disciplina (cod_disciplina)
);

CREATE TABLE IF NOT EXISTS curso (
	cod_curso INT(4) AUTO_INCREMENT,
    nome_curso VARCHAR(30) NOT NULL UNIQUE,
    cod_departamento INT(4),
PRIMARY KEY (cod_curso),
CONSTRAINT fk_cod_departamento_c FOREIGN KEY (cod_departamento) REFERENCES departamento (cod_departamento)
)AUTO_INCREMENT = 1000;

CREATE TABLE IF NOT EXISTS curso_disciplina (
	cod_curso INT(4),
    cod_disciplina INT(4),
PRIMARY KEY (cod_curso, cod_disciplina),
CONSTRAINT fk_cod_curso_d FOREIGN KEY (cod_curso) REFERENCES curso (cod_curso),
CONSTRAINT fk_cod_disciplina_d1 FOREIGN KEY (cod_disciplina) REFERENCES disciplina (cod_disciplina) 
);

CREATE TABLE IF NOT EXISTS turma (
	cod_turma INT(4) AUTO_INCREMENT,
    num_aluno INT(4),
    dt_inicio DATE NOT NULL,
    dt_fim DATE NOT NULL,
	cod_turno INT(4),
    cod_curso INT(4),
PRIMARY KEY (cod_turma),
CONSTRAINT fk_cod_turno_t FOREIGN KEY (cod_turno) REFERENCES turno (cod_turno),
CONSTRAINT fk_cod_curso_t FOREIGN KEY (cod_curso) REFERENCES curso (cod_curso)
)AUTO_INCREMENT = 1000;

CREATE TABLE IF NOT EXISTS endereco (
	cod_endereco INT(4) AUTO_INCREMENT,
    nome_rua VARCHAR(50) NOT NULL,
    numero_casa INT(4) NOT NULL,
    complemento VARCHAR(20),
    CEP INT(9) NOT NULL,
    cod_tipo_logadouro INT(4),
PRIMARY KEY (cod_endereco),
CONSTRAINT cod_tipo_logadouro FOREIGN KEY (cod_tipo_logadouro) REFERENCES tipo_logradouro (cod_tipo_logadouro)
)AUTO_INCREMENT = 1000;

CREATE TABLE IF NOT EXISTS aluno (
	RA INT(4) AUTO_INCREMENT,
    nome_aluno VARCHAR(20) NOT NULL,
    sobrenome_aluno VARCHAR(20) NOT NULL,
    dt_nascimento DATE NOT NULL,
    CPF INT(11) NOT NULL UNIQUE,
    RG INT(7) NOT NULL,
    status BOOLEAN NOT NULL,
    sexo ENUM ('f', 'm') NOT NULL,
    nome_pai VARCHAR(50),
    nome_mae VARCHAR(50) NOT NULL,
    email VARCHAR(50) NOT NULL UNIQUE,
    whatsapp INT(11) NOT NULL,
	cod_curso INT(4),
    cod_turma INT(4),
    cod_endereco INT(4),
PRIMARY KEY (RA),
CONSTRAINT fk_cod_curso_a FOREIGN KEY (cod_curso) REFERENCES curso (cod_curso),
CONSTRAINT fk_cod_turma_a FOREIGN KEY (cod_turma) REFERENCES turma (cod_turma),
CONSTRAINT fk_cod_endereco_a FOREIGN KEY (cod_endereco) REFERENCES endereco (cod_endereco)
)AUTO_INCREMENT = 1000;

CREATE TABLE IF NOT EXISTS telefone (
	cod_telefone INT(4) AUTO_INCREMENT,
    num_telefone INT(11) NOT NULL,
    cod_tipo INT(4) NOT NULL,
    RA INT(4),
PRIMARY KEY (cod_telefone),
CONSTRAINT fk_cod_ra FOREIGN KEY (RA) REFERENCES aluno (RA)
)AUTO_INCREMENT = 1000;

CREATE TABLE IF NOT EXISTS historico (
	cod_historico INT(4) AUTO_INCREMENT,
    dt_inicio DATE NOT NULL,
    dt_fim DATE NOT NULL,
    RA INT(4),
PRIMARY KEY (cod_historico),
CONSTRAINT fk_cod_ra_h FOREIGN KEY (RA) REFERENCES aluno (RA)
)AUTO_INCREMENT = 1000;

CREATE TABLE IF NOT EXISTS aluno_disciplina (
	RA INT(4),
    cod_disciplina INT(4),
PRIMARY KEY (RA, cod_disciplina),
CONSTRAINT fk_cod_ra_ad FOREIGN KEY (RA) REFERENCES aluno (RA),
CONSTRAINT fk_cod_disciplina_ad FOREIGN KEY (cod_disciplina) REFERENCES disciplina (cod_disciplina)
);

CREATE TABLE IF NOT EXISTS disciplina_historico (
	cod_historico INT(4),
    cod_disciplina INT(4),
    nota FLOAT (4,2),
    frequencia INT(4),
PRIMARY KEY (cod_historico, cod_disciplina),
CONSTRAINT cod_historico FOREIGN KEY (cod_historico) REFERENCES historico (cod_historico),
CONSTRAINT cod_disciplina FOREIGN KEY (cod_disciplina) REFERENCES disciplina (cod_disciplina)
);