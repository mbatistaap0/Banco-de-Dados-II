
CREATE DATABASE ExerciciosInner;
USE ExerciciosInner;

CREATE TABLE Funcionarios (
CodFuncionario INT AUTO_INCREMENT PRIMARY KEY,
CodigoD int,
PrimeiroNomeF varchar(40),
SegundoNomeF varchar(50),
UltimoNomeF varchar(30),
DataNasci datetime,
CPF varchar(11),
RG varchar(11),
Endereço varchar(70),
CEP varchar(9),
CidadeFuncionario varchar(60),
FoneF varchar(19),
FuncaoF varchar(20),
SalarioF numeric(15, 2),
CodDepartamento int);

CREATE TABLE Departamentos (
CodDepartamento INT AUTO_INCREMENT PRIMARY KEY,
Nome_Departamento varchar (40),
CodigoFuncionarioGerente int,
Localização varchar (50));

ALTER TABLE Funcionarios ADD C_Departamento INT REFERENCES Departamentos (CodDepartamento);
ALTER TABLE Departamentos ADD C_FuncionarioGerente INT REFERENCES Departamentos (CodDepartamento);

INSERT INTO Funcionarios (
PrimeiroNomeF,
SegundoNomeF,
UltimoNomeF,
DataNasci,
CPF,
RG,
Endereço,
CEP,
CidadeFuncionario,
FoneF,
FuncaoF,
SalarioF,
CodDepartamento)
values
('João', 'Silva', 'Pereira', '1990-05-15', '11111111111', '11111111', 'Rua dos Funcionários, 1', '11111-111', 'São Paulo', '1111111111', 'Supervisor', 9000.00, 1),
('Maria', 'Santos', 'Silva', '1985-08-20', '22222222222', '22222222', 'Avenida das Flores, 2', '22222-222', 'Rio de Janeiro', '2222222222', 'Gerente', 7000.00, 3),
('Pedro', '', 'Costa', '1992-02-10', '33333333333', '33333333', 'Travessa das Pedras, 3', '33333-333', 'São José dos Campos', '3333333333', 'Programador', 800.00, 5),
('Ana', 'Oliveira', 'Sousa', '1998-12-05', '44444444444', '44444444', 'Rua das Oliveiras, 4', '44444-444', 'Porto Alegre', '4444444444', 'Estagiária', 970.00, 2),
('Lucas', 'Gomes', 'Rodrigues', '1994-06-25', '55555555555', '55555555', 'Alameda dos Gomes, 5', '55555-555', 'Curitiba', '5555555555', 'Desenvolvedor', 6000.00, 4);

INSERT INTO Departamentos (
Nome_Departamento,
CodigoFuncionarioGerente,
Localização)
values
('Departamento A', 1, 'São Paulo'),
('Departamento B', 3, 'Rio de Janeiro'),
('Departamento Pessoal', 5,  'São José dos Campos'),
('Departamento D', 2, 'Porto Alegre'),
('Departamento E', 4, 'Curitiba');

-- 1 ---------------------------------------------------------------------------------------------------------------
SELECT 
	PrimeiroNomeF,
    SegundoNomeF,
    UltimoNomeF
FROM
    Funcionarios
ORDER BY
    SegundoNomeF;
    
-- 2 ---------------------------------------------------------------------------------------------------------------
SELECT *
FROM
    Funcionarios
ORDER BY
    CidadeFuncionario;

-- 3 ---------------------------------------------------------------------------------------------------------------
SELECT
    PrimeiroNomeF,
    SegundoNomeF,
    UltimoNomeF
FROM
	Funcionarios
WHERE
    SalarioF > 1000;

-- 4 ---------------------------------------------------------------------------------------------------------------
SELECT
	PrimeiroNomeF,
    DataNasci
FROM
	Funcionarios
ORDER BY
	DataNasci DESC,
    PrimeiroNomeF; 
    
-- 5 ---------------------------------------------------------------------------------------------------------------
SELECT
	UltimoNomeF,
    PrimeiroNomeF,
    SegundoNomeF,
    Endereço,
    CidadeFuncionario,
    FoneF
FROM
	Funcionarios
ORDER BY
	UltimoNomeF, PrimeiroNomeF, SegundoNomeF;

-- 6 ---------------------------------------------------------------------------------------------------------------
SELECT
	SUM(SalarioF) as TotalFolhaPag
FROM 
	Funcionarios;
-- 7 ---------------------------------------------------------------------------------------------------------------
SELECT 
    PrimeiroNomeF, 
    FuncaoF,
    Nome_Departamento 
FROM
	Funcionarios F
JOIN Departamentos D ON (F.CodDepartamento = D.CodDepartamento)
ORDER BY
	D.Nome_Departamento;

-- 8 ---------------------------------------------------------------------------------------------------------------
SELECT
	Nome_Departamento,
    PrimeiroNomeF
FROM
	Departamentos D
JOIN Funcionarios F ON (D.CodDepartamento = F.CodDepartamento)
ORDER BY
	D.Nome_Departamento;
	
    
-- 9 ---------------------------------------------------------------------------------------------------------------
SELECT
	D.Nome_Departamento,
	SUM(SalarioF) as SalarioPorDepartamento
FROM 
	Departamentos D
INNER JOIN Funcionarios F ON (D.CodDepartamento= F.CodDepartamento)
GROUP BY
	D.Nome_Departamento;

-- 10 ---------------------------------------------------------------------------------------------------------------
SELECT
	Nome_Departamento,
    PrimeiroNomeF
FROM
	Departamentos D
JOIN Funcionarios F ON (D.CodDepartamento = F.CodDepartamento)
WHERE 
	F.FuncaoF = 'Supervisor'
ORDER BY
	D.Nome_Departamento;
    
-- 11 ---------------------------------------------------------------------------------------------------------------

SELECT 
	COUNT(*) as QtdFuncionario
FROM
	Funcionarios;

-- 12 ---------------------------------------------------------------------------------------------------------------

SELECT
	AVG(SalarioF) as SalarioMedioF
FROM
	Funcionarios;
    
-- 13 ---------------------------------------------------------------------------------------------------------------
SELECT
	Nome_Departamento,
	MIN(SalarioF) as MenorSalario
FROM
	Funcionarios F 
INNER JOIN Departamentos D ON (F.CodDepartamento = D.CodDepartamento)
GROUP BY
	D.Nome_Departamento;

-- 14 ---------------------------------------------------------------------------------------------------------------
SELECT
	PrimeiroNomeF,
    SegundoNomeF,
    UltimoNomeF
FROM
	Funcionarios
WHERE
	SegundoNomeF IS NULL or SegundoNomeF = '';

-- 15 ---------------------------------------------------------------------------------------------------------------
SELECT 
	PrimeiroNomeF,
    Nome_Departamento
FROM 
	Funcionarios F
JOIN Departamentos D ON (D.CodDepartamento = F.CodFuncionario)
ORDER BY
	D.Nome_Departamento, F.PrimeiroNomeF;

-- 16 ---------------------------------------------------------------------------------------------------------------
SELECT
PrimeiroNomeF
FROM Funcionarios WHERE FuncaoF = 'Programador' and CidadeFuncionario = "São José dos Campos";
    
-- 17 ---------------------------------------------------------------------------------------------------------------
SELECT
	PrimeiroNomeF
FROM
	Funcionarios 
WHERE 
	Nome_Departamento = 
    (SELECT CodDepartamento FROM Departamentos WHERE Nome_Departamento ='Departamento Pessoal');

-- 18 -ERRADA--------------------------------------------------------------------------------------------------------------

SELECT
	CONCAT(PrimeiroNomeF, ' ', SegundoNomeF, ' ', UltimoNomeF) as NomeFuncionario,
    D.Nome_Departamento as NomeDepartamento
FROM
	Funcionarios F
JOIN Departamentos D ON (D.CodDepartamento = F.CodFuncionario)
WHERE
	SalarioF > (SELECT AVG(SalarioF) FROM Funcionarios)
ORDER BY
	NomeFuncionario;


