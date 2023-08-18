CREATE DATABASE escolinha;
USE escolinha;

--
-- PROJETO DESENVOLVIDO EM SALA DE AULA PARA A DISCPLINA DE 'BANCO DE DADOS'
-- Produzido por 'Denise Azure' & 'Pedro Gil'
-- y lovi u bananinha <3
--

-- TRACOLO.

-- * MNEMÔNICOS UTILIZADOS * --
-- cd  -> código | nm  -> nome   | ds  -> descrição
-- nr  -> número | vl  -> valor  | id  -> identificador
-- hr  -> hora   | dt  -> data   | lc  -> local
-- sl  -> sala   | tb  -> tabela | end -> endereço

-- * ABREVIAÇÔES UTILIZADAS * --
-- [PRE] -> Presencial | [EAD] -> Ensino a Distância | [HIB] -> Híbrido
-- [F] -> Feminino     | [M] -> Masculino            | [NB] -> Não-binário
-- [LAB] -> Laboratório
-- [MAT] -> Matutino   | [VES] -> Vespertino         | [INT] -> Integral
-- [NOT] -> Noturno

CREATE TABLE tb_curso (
    cd_curso INT(11) PRIMARY KEY NOT NULL AUTO_INCREMENT,
    nm_curso VARCHAR(50) NOT NULL,
    ds_curso VARCHAR(100),
    ds_horarios ENUM('MAT', 'VES', 'INT', 'NOT'),
    ds_local VARCHAR(100) NOT NULL,
    end_logradouro VARCHAR(20),
    end_nome VARCHAR(100),
    end_numero INT,
    end_bairro VARCHAR(100),
    end_cidade VARCHAR(100),
    end_estado CHAR(2) DEFAULT 'SP',
    end_pais CHAR(2) DEFAULT 'BR',
    vl_curso DOUBLE(5, 2) NOT NULL,
    ds_modalidade ENUM('PRE', 'EAD', 'HIB') NOT NULL,
    nm_coordenador VARCHAR(100),
    id_chamada INT(11)
) ENGINE = innodb;

CREATE TABLE tb_chamada (
    cd_chamada INT(11) PRIMARY KEY NOT NULL AUTO_INCREMENT,
    hr_chamada TIME NOT NULL,
    lc_chamada ENUM('Sala', 'LAB') NOT NULL,
    dt_chamada DATE NOT NULL,
    id_disciplina INT(11),
    id_professor INT(11),
    id_turma INT(11)
) ENGINE = innodb;

CREATE TABLE tb_professor (
    cd_professor INT(11) PRIMARY KEY NOT NULL AUTO_INCREMENT,
    nm_professor VARCHAR(50) NOT NULL,
    dt_nascimento DATE,
    nr_rm INT(5) NOT NULL,
    ds_email VARCHAR(100),
    ds_sexo ENUM('M', 'F', 'NB') NOT NULL,
    ds_nacionalidade CHAR(2) DEFAULT 'BR'
) ENGINE = innodb;

CREATE TABLE tb_disciplina (
    cd_disciplina INT(11) PRIMARY KEY NOT NULL AUTO_INCREMENT,
    nm_disciplina VARCHAR(50) NOT NULL,
    ds_disciplina VARCHAR(100),
    sl_disciplina VARCHAR(20),
    id_professor INT(11)
) ENGINE = innodb;

CREATE TABLE tb_avaliacao (
    cd_avaliacao INT(11) PRIMARY KEY NOT NULL AUTO_INCREMENT,
    dt_avaliacao DATE NOT NULL,
    hr_avaliacao TIME,
    lc_avaliacao ENUM('Sala', 'LAB') NOT NULL,
    id_curso INT(11)
) ENGINE = innodb;

CREATE TABLE tb_turma (
    cd_turma INT(11) PRIMARY KEY NOT NULL AUTO_INCREMENT,
    nm_turma VARCHAR(50) NOT NULL,
    hr_aula TIME,
    ds_modulo VARCHAR(20) NOT NULL,
    id_aluno INT(11),
    id_curso INT(11)
) ENGINE = innodb;
-- id_aluno: SELECIONAR REPRESENTANTE DE TURMA

CREATE TABLE tb_aluno (
    cd_aluno INT(11) PRIMARY KEY NOT NULL AUTO_INCREMENT,
    nm_aluno VARCHAR(50) NOT NULL,
    dt_nascimento DATE,
    nr_rm INT(5) NOT NULL,
    ds_email VARCHAR(100),
    ds_sexo ENUM('M', 'F', 'NB') NOT NULL,
    ds_nacionalidade VARCHAR(100),
    id_turma INT(11)
) ENGINE = innodb;

CREATE TABLE tb_gremio (
    cd_gremio INT(11) PRIMARY KEY NOT NULL AUTO_INCREMENT,
    nm_gremio VARCHAR(50) NOT NULL,
    dt_inicio DATE,
    dt_fim DATE,
    nm_supervisor VARCHAR(100) NOT NULL,
    rm_pres INT(5) NOT NULL,
    rm_cult INT(5) NOT NULL,
    rm_esp INT(5) NOT NULL,
    rm_fin INT(5) NOT NULL,
    rm_sec INT(5) NOT NULL
) ENGINE = innodb;

CREATE TABLE tb_matricula (
    cd_matricula INT(11) PRIMARY KEY NOT NULL AUTO_INCREMENT,
    hr_aula TIME,
    id_aluno INT(11),
    id_escola INT(11),
    id_disciplina INT(11),
    id_turma INT(11)
) ENGINE = innodb;

CREATE TABLE tb_funcionario (
    cd_funcionario INT(11) PRIMARY KEY NOT NULL AUTO_INCREMENT,
    nr_rm INT(5) NOT NULL,
    nm_nome VARCHAR(100) NOT NULL,
    dt_nasc DATE,
    nr_cpf INT(11),
    ds_funcao VARCHAR(100) NOT NULL,
    vl_salario DOUBLE(5, 2),
    nr_escolinha INT(5) ZEROFILL
) ENGINE = innodb;

CREATE TABLE tb_escola (
    cd_escola INT(11) PRIMARY KEY NOT NULL AUTO_INCREMENT,
    nm_escola VARCHAR(50) NOT NULL,
    nr_escolinha INT(5),
    ds_logradouro VARCHAR(100),
    nm_rua VARCHAR(50),
    nm_diretor VARCHAR(100) NOT NULL,
    nr_rua INT(11),
    ds_pais CHAR(2) DEFAULT 'BR'
) ENGINE = innodb;

-- * FOREIGN KEYS * --

    -- TABLE: tb_curso
        ALTER TABLE tb_curso
        ADD CONSTRAINT fk_chamada 
        FOREIGN KEY (id_chamada) 
        REFERENCES tb_chamada (cd_chamada);

    -- TABLE: tb_chamada
        ALTER TABLE tb_chamada 
        ADD CONSTRAINT fk_disciplina 
        FOREIGN KEY (id_disciplina) 
        REFERENCES tb_disciplina (cd_disciplina);

        ALTER TABLE tb_chamada 
        ADD CONSTRAINT fk_professor 
        FOREIGN KEY (id_professor) 
        REFERENCES tb_professor (cd_professor);

    -- TABLE: tb_disciplina
        ALTER TABLE tb_disciplina 
        ADD CONSTRAINT fk_prof 
        FOREIGN KEY (id_professor) 
        REFERENCES tb_professor (cd_professor);

    -- TABLE: tb_avaliacao
        ALTER TABLE tb_avaliacao 
        ADD CONSTRAINT fk_curso 
        FOREIGN KEY (id_curso) 
        REFERENCES tb_curso (cd_curso);

    -- TABLE: tb_turma
        ALTER TABLE tb_turma 
        ADD CONSTRAINT fk_aluno 
        FOREIGN KEY (id_aluno) 
        REFERENCES tb_aluno (cd_aluno);

        ALTER TABLE tb_turma 
        ADD CONSTRAINT fk_guanabara 
        FOREIGN KEY (id_curso) 
        REFERENCES tb_curso (cd_curso);

    -- TABLE: tb_aluno
        ALTER TABLE tb_aluno 
        ADD CONSTRAINT fk_turma 
        FOREIGN KEY (id_turma) 
        REFERENCES tb_turma (cd_turma);

    -- TABLE: tb_matricula
        ALTER TABLE tb_matricula 
        ADD CONSTRAINT fk_estudante 
        FOREIGN KEY (id_aluno) 
        REFERENCES tb_aluno (cd_aluno);

        ALTER TABLE tb_matricula 
        ADD CONSTRAINT fk_escola 
        FOREIGN KEY (id_escola) 
        REFERENCES tb_escola (cd_escola);

        ALTER TABLE tb_matricula 
        ADD CONSTRAINT fk_disc 
        FOREIGN KEY (id_disciplina) 
        REFERENCES tb_disciplina (cd_disciplina);

        ALTER TABLE tb_matricula 
        ADD CONSTRAINT fk_classe 
        FOREIGN KEY (id_turma) 
        REFERENCES tb_turma (cd_turma);

    -- INSERT in TABLE: tb_professor
        INSERT INTO tb_professor VALUES 
            (null, 'Elisangêla Acidente de Carnaval', '1991-11-28', 18523, 'cupido.acidental@mail.com', 2, 'BR'),
            (null, 'Malungo do Parabuains', '1010-10-10', 14526, 'parabuains@mail.com', 1, 'AO'),
            (null, 'Yuri Que Ama o Reveillon', '2000-01-01', 85634, 'fest_@mail.com', 3, 'BR'), 
            (null, 'Diácono da Fé Estrita', '1949-01-21', 66677, 'omni.fe@mail.com', 3, 'BR'), 
            (null, 'Juan Xenofóbico', '2001-03-21', 69696, 'odeio_brasileiros@mail.com', 1, 'AR'), 
            (null, 'Estou Com Preguiça', '1589-11-28', 45638, 'pregu@mail.com', 2, 'BR'), 
            (null, 'Liu Ming do Pastel de Flango', '1999-12-19', 44444, 'pastel.flango@mail.com', 2, 'CN'), 
            (null, 'Jose Que Tem Medo de Brasileiros', '1864-12-22', 55555, 'eles_queimam_criancas@mail.com', 3, 'PY'), 
            (null, 'Leandrinho Xequirimbalas', '1998-06-17', 88888, 'xequirimbalas@mail.com', 1, 'BR'), 
            (null, 'Calanguinho Venha Cá', '6666-06-06', 99999, 'comendo.calangos@mail.com', 2, 'BR');

    -- PS: Não precisa de todas, né?