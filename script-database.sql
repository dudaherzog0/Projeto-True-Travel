-- Criando Database

CREATE DATABASE database_truetravel;
USE database_truetravel;

CREATE TABLE clientes (
  id_cliente INT PRIMARY KEY AUTO_INCREMENT,
  dt_cadastro DATE NOT NULL,
  nome_cliente VARCHAR(50) NOT NULL,
  cpf CHAR(11) NOT NULL,
  dt_nascimento DATE NOT NULL,
  UNIQUE (cpf)
) ENGINE=InnoDB; 
-- ENGINE=InooDB necessário para tornar as chaves primarias estrangeiras obrigatórias --

CREATE TABLE viagens (
  id_viagem INT PRIMARY KEY AUTO_INCREMENT,
  dt_ida DATE NOT NULL,
  dt_retorno DATE,
  origem VARCHAR(100) NOT NULL,
  destino VARCHAR(100) NOT NULL
) ENGINE=InnoDB;

CREATE TABLE produtos (
  id_produto INT PRIMARY KEY AUTO_INCREMENT,
  categoria VARCHAR(50) NOT NULL,
  fornecedor VARCHAR(50) NOT NULL
) ENGINE=InnoDB;

CREATE TABLE colaborador (
  id_colab INT PRIMARY KEY AUTO_INCREMENT,
  nome_colab VARCHAR(50) NOT NULL,
  cpf_colab CHAR(11) NOT NULL,
  dt_nasc DATE NOT NULL,
  dt_admissao DATE NOT NULL,
  dt_desligamento DATE,
  status VARCHAR(50) NOT NULL,
  UNIQUE (cpf_colab)
) ENGINE=InnoDB;

CREATE TABLE vendas (
  id_venda INT PRIMARY KEY AUTO_INCREMENT,
  id_viagem INT NOT NULL,
  id_colab INT NOT NULL,
  id_cliente INT NOT NULL,
  dt_venda DATE NOT NULL,
  valor DECIMAL(10,2) NOT NULL,
  comissao_colab DECIMAL(10,2) NOT NULL,
  comissao_ag DECIMAL(10,2) NOT NULL,
  FOREIGN KEY (id_viagem) REFERENCES viagens(id_viagem)
    ON DELETE RESTRICT 
    -- não permite exclusão de informações/tabelas necessarias para essa tabela --
    ON UPDATE CASCADE, 
    -- quando houver uma alteração de primary key na tabela de origem, trocara automaticamente na tabela referencia --
  FOREIGN KEY (id_colab) REFERENCES colaborador(id_colab)
    ON DELETE RESTRICT ON UPDATE CASCADE,
  FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente) 
) ENGINE=InnoDB;

CREATE TABLE vendas_prod (
  id_venda INT NOT NULL,
  id_produto INT NOT NULL,
  qtd_produto INT NOT NULL,
  valor_uni DECIMAL(10,2) NOT NULL,
  valor_total DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (id_venda, id_produto),
  FOREIGN KEY (id_venda) REFERENCES vendas(id_venda)
    ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (id_produto) REFERENCES produtos(id_produto)
    ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;
CREATE TABLE remuneracao (
    id_salario INT PRIMARY KEY AUTO_INCREMENT,
    data DATE NOT NULL,
    id_colab INT NOT NULL,
    salario DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (id_colab) 
        REFERENCES colaborador(id_colab)
        ON DELETE RESTRICT 
        ON UPDATE CASCADE
) ENGINE=InnoDB;

-- Populando Database

INSERT INTO colaborador 
(nome_colab, cpf_colab, dt_nasc, dt_admissao, status)
VALUES
('Ana Souza', '11111111111', '1990-05-10', '2020-01-10', 'Ativo'),
('Bruno Lima', '22222222222', '1988-03-22', '2020-06-15', 'Ativo'),
('Carla Mendes', '33333333333', '1985-11-02', '2021-02-01', 'Ativo'),
('Diego Rocha', '44444444444', '1982-07-19', '2022-04-10', 'Ativo');

INSERT INTO produtos (categoria, fornecedor)
VALUES
('Passagem Aérea', 'LATEM'),
('Hotel', 'Book'),
('Seguro Viagem', 'Assist Carde'),
('Traslado', 'Ubar Travel'),
('Aluguel de Carro', 'Localize');

DELIMITER $$

CREATE PROCEDURE gerar_clientes()
BEGIN
  DECLARE i INT DEFAULT 1;
  WHILE i <= 100 DO
    INSERT INTO clientes (dt_cadastro, nome_cliente, cpf, dt_nascimento)
    VALUES (DATE_ADD('2019-01-01', INTERVAL FLOOR(RAND()*365) DAY), CONCAT('Cliente ', i), LPAD(i, 11, '0'), '1985-05-20');
    SET i = i + 1;
  END WHILE;
END$$

DROP PROCEDURE IF EXISTS gerar_vendas_com_metas$$
CREATE PROCEDURE gerar_vendas_com_metas()
BEGIN
    DECLARE v_ano INT DEFAULT 2020;
    DECLARE v_mes INT;
    DECLARE v_id_colab INT;
    DECLARE v_soma_colab DECIMAL(10,2);
    DECLARE v_meta_individual DECIMAL(10,2);
    DECLARE v_id_viagem INT;
    DECLARE v_id_venda_gerada INT;
    DECLARE v_dt_venda DATE;
    DECLARE v_dt_ida DATE;
    DECLARE v_dt_admissao DATE;
    DECLARE v_valor_venda DECIMAL(10,2);
    DECLARE v_dias INT;

    WHILE v_ano <= 2025 DO
        SET v_mes = 1;
        WHILE v_mes <= 12 DO
            
            SET v_id_colab = 1;
            WHILE v_id_colab <= 4 DO
                
                SELECT dt_admissao INTO v_dt_admissao FROM colaborador WHERE id_colab = v_id_colab;
                SET v_soma_colab = 0;
                
                -- Ajuste da Meta: 80k por pessoa para a loja bater > 300k total
                -- Adicionamos um RAND para variar entre 75k e 85k
                SET v_meta_individual = 75000 + (RAND() * 10000); 

                WHILE v_soma_colab < v_meta_individual DO
                    SET v_dt_venda = STR_TO_DATE(CONCAT(v_ano, '-', v_mes, '-', FLOOR(1 + RAND()*28)), '%Y-%m-%d');
                    
                    IF v_dt_venda >= v_dt_admissao THEN
                        SET v_dt_ida = DATE_ADD(v_dt_venda, INTERVAL 180 DAY);
                        SET v_dias = FLOOR(3 + RAND()*10);
                        
                        INSERT INTO viagens (dt_ida, dt_retorno, origem, destino)
                        VALUES (v_dt_ida, DATE_ADD(v_dt_ida, INTERVAL v_dias DAY), 'São Paulo', 
                                ELT(FLOOR(1 + RAND()*4), 'Cancún', 'Paris', 'Gramado', 'Lisboa'));
                        
                        SET v_id_viagem = LAST_INSERT_ID();
                        SET v_valor_venda = 6000 + (RAND() * 8000); -- Vendas um pouco maiores
                        
                        INSERT INTO vendas (id_viagem, id_colab, id_cliente, dt_venda, valor, comissao_colab, comissao_ag)
                        VALUES (v_id_viagem, v_id_colab, FLOOR(1 + RAND()*100), v_dt_venda, v_valor_venda, v_valor_venda * 0.02, v_valor_venda * 0.10);
                        
                        SET v_id_venda_gerada = LAST_INSERT_ID();
                        SET v_soma_colab = v_soma_colab + v_valor_venda;

                        INSERT INTO vendas_prod VALUES (v_id_venda_gerada, 1, 1, v_valor_venda * 0.6, v_valor_venda * 0.6);
                        INSERT INTO vendas_prod VALUES (v_id_venda_gerada, 2, v_dias, (v_valor_venda * 0.3)/v_dias, v_valor_venda * 0.3);
                        INSERT INTO vendas_prod VALUES (v_id_venda_gerada, 3, 1, v_valor_venda * 0.1, v_valor_venda * 0.1);
                    ELSE
                        SET v_soma_colab = v_meta_individual + 1; -- Sai do loop se não admitido
                    END IF;
                END WHILE;
                SET v_id_colab = v_id_colab + 1;
            END WHILE;
            SET v_mes = v_mes + 1;
        END WHILE;
        SET v_ano = v_ano + 1;
    END WHILE;
END$$

DELIMITER ;

CALL gerar_clientes();
CALL gerar_vendas_com_metas();

