CREATE DATABASE StaySafeIS

USE StaySafeIS
GO


CREATE TABLE Utilizador(--acrescentaria um username para o login
Id INTEGER NOT NULL IDENTITY(1,1),
Nome VARCHAR(MAX) NOT NULL,
PW VARCHAR(MAX) NOT NULL,
Email VARCHAR(MAX) NOT NULL,
Tipo VARCHAR(MAX) NOT NULL,
Fotografia VARBINARY(MAX) NOT NULL,--Opa acho que é só uma complicação não meteria ,nem tem a ver com o que estamos a ser avaliado
Estado VARCHAR(MAX) NOT NULL,
PRIMARY KEY(Id))

CREATE TABLE Paciente(
IDU INTEGER NOT NULL,
CodigoPac VARCHAR(MAX) NOT NULL,
Idade INTEGER NOT NULL,
Sexo VARCHAR(MAX) NOT NULL,
Estado VARCHAR(MAX) NOT NULL,
Risco BIT NOT NULL,
Morada VARCHAR(MAX) NOT NULL,
CodigoPostal VARCHAR(MAX) NOT NULL,
PRIMARY KEY(IDU),
FOREIGN KEY(IDU) REFERENCES Utilizador(Id))


CREATE TABLE Localizacao(--Queres fazer por mapa da google ?se calhar era melhor por distrito/concelho
IdC INTEGER NOT NULL,
Latitude FLOAT NOT NULL,
Longitude FLOAT NOT NULL,
Validado BIT NOT NULL,--O que é  que queres dizer com validado?
PRIMARY KEY(IdC),
FOREIGN KEY(IdC) REFERENCES Paciente(IDU))

CREATE TABLE Sintomas(
IDS INTEGER NOT NULL IDENTITY(1,1),
Sintoma VARCHAR(MAX) NOT NULL,
PRIMARY KEY(IDS))

CREATE TABLE RelSin(
Id INTEGER NOT NULL IDENTITY(1,1),
IdP INTEGER NOT NULL,
IdS INTEGER NOT NULL,
DataSintoma DATETIME2,
PRIMARY KEY(Id,IdP,IdS,DataSintoma),
FOREIGN KEY(IdP) REFERENCES Paciente(IDU),
FOREIGN KEY(IdS) REFERENCES Sintomas(IDS))

CREATE TABLE FatoresDeRisco(
Id INTEGER NOT NULL IDENTITY(1,1),
Fator VARCHAR(MAX) NOT NULL,
PRIMARY KEY(Id))

CREATE TABLE RelFact(
Id INTEGER NOT NULL IDENTITY(1,1),
IdF INTEGER NOT NULL,
IdP INTEGER NOT NULL,
Tempo VARCHAR(MAX) NOT NULL,
PRIMARY KEY(Id,IdF,IdP),
FOREIGN KEY(IdP) REFERENCES Paciente(IDU),
FOREIGN KEY(IdF) REFERENCES FatoresDeRisco(Id))

CREATE TABLE Distrito(
IdD INTEGER NOT NULL IDENTITY(1,1),
Nome VARCHAR(MAX) NOT NULL,
PRIMARY KEY(IdD))


CREATE TABLE Conselho(--btw escreve-se concelho xD
IdConselho INTEGER NOT NULL IDENTITY(1,1),
Nome VARCHAR(MAX) NOT NULL,
IdDist INTEGER NOT NULL,
PRIMARY KEY(IdConselho),
FOREIGN KEY(IdDist) REFERENCES Distrito(IdD))

CREATE TABLE RelCons(--a que se refere esta tabela?
DataRel DATETIME2 NOT NULL,
IdU INTEGER NOT NULL,
IdC INTEGER NOT NULL,
PRIMARY KEY(IdU,IdC,DataRel),
FOREIGN KEY(IdU) REFERENCES Utilizador(Id),
FOREIGN KEY(IdC) REFERENCES Conselho(IdConselho))


CREATE TABLE Notificacao(
Id INTEGER NOT NULL IDENTITY(1,1),
Mensagem VARCHAR(MAX) NOT NULL,
PRIMARY KEY(Id)
)



CREATE PROCEDURE stp_CreateUtilizador @name VARCHAR(MAX), @pw VARCHAR(MAX), @email VARCHAR(MAX), @type VARCHAR(MAX), @foto VARBINARY(MAX), @state VARCHAR(MAX)
AS

INSERT INTO Utilizador(Nome,PW,Email,Tipo,Fotografia,Estado) VALUES(@name,@pw,@email,@type,@foto,@state)

GO

CREATE PROCEDURE stp_GetUtilizador @what VARCHAR(MAX), @idd INTEGER, @name VARCHAR(MAX)
AS

IF(@what = 'Id')

SELECT * FROM Utilizador WHERE Id = @idd

ELSE IF(@what = 'Name')

SELECT * FROM Utilizador WHERE Nome = @name

ELSE 

SELECT * FROM Paciente

GO

CREATE PROCEDURE stp_ValidarUtilizador @estado VARCHAR(MAX), @idd INTEGER
AS

UPDATE Utilizador SET Estado = @estado WHERE Id = @idd

GO

CREATE PROCEDURE stp_UpdateUtilizador @pw VARCHAR(MAX), @idd INTEGER
AS

UPDATE Utilizador SET PW = @pw WHERE Id = @idd

GO

CREATE PROCEDURE stp_CreatePaciente @idu INTEGER, @CP VARCHAR(MAX), @age INTEGER, @sex VARCHAR(MAX), @state VARCHAR(MAX), @risk BIT, @mor VARCHAR(MAX),@codepostal VARCHAR(MAX)
AS

INSERT INTO Paciente(IDU,CodigoPac,Idade,Sexo,Estado,Risco,Morada,CodigoPostal) VALUES (@idu,@CP,@age,@sex,@state,@risk,@mor,@codepostal)

GO


CREATE PROCEDURE stp_GetPaciente @what VARCHAR(MAX), @idu INTEGER, @value VARCHAR(MAX)
AS

IF(@what = 'IDU')

SELECT * FROM Paciente WHERE IDU = @idu

ELSE IF(@what = 'CodigoPac')

SELECT * FROM Paciente WHERE CodigoPac = @value

ELSE IF(@what = 'Sexo')

SELECT * FROM Paciente WHERE Sexo = @value

ELSE IF(@what = 'Estado')

SELECT * FROM Paciente WHERE Estado = @value

ELSE IF(@what = 'Risco')

SELECT * FROM Paciente WHERE Risco = 1

ELSE IF(@what = 'Nao Risco')

SELECT * FROM Paciente WHERE Risco = 0

ELSE IF(@what = 'CodigoPostal')

SELECT * FROM Paciente WHERE CodigoPostal = @value

ELSE 

SELECT * FROM Paciente

GO



CREATE PROCEDURE stp_UpdatePacienteEstado @what VARCHAR(MAX), @state VARCHAR(MAX),@risk BIT, @idu INTEGER
AS

UPDATE Paciente SET Estado = @state WHERE IDU = @idu

GO

CREATE PROCEDURE stp_UpdatePacienteMorada @what VARCHAR(MAX), @morada VARCHAR(MAX), @cp VARCHAR(MAX), @idu INT
AS

IF(@what = 'Morada')

UPDATE Paciente SET Morada = @morada WHERE IDU = @idu

ELSE IF(@what = 'CodigoPostal')

UPDATE Paciente SET CodigoPostal = @cp WHERE IDU = @idu

ELSE IF(@what = 'Both')

UPDATE Paciente SET Morada = @morada, CodigoPostal = @cp WHERE IDU = @idu

ELSE

RETURN -1

GO



CREATE PROCEDURE stp_CreateLocalizacao @idc INTEGER, @lat FLOAT, @long FLOAT, @val BIT
AS

INSERT INTO Localizacao(IdC,Latitude,Longitude,Validado) VALUES (@idc,@lat,@long,@val)

GO


CREATE PROCEDURE stp_GetLocalizacao @idc INTEGER
AS

SELECT * FROM Localizacao WHERE IdC = @idc

GO

CREATE PROCEDURE stp_UpdateLocalizacao @idc INTEGER, @val BIT
AS

UPDATE Localizacao SET Validado = @val WHERE IdC = @idc

GO

CREATE PROCEDURE stp_CreateSintomas @sint VARCHAR(MAX)
AS

INSERT INTO Sintomas(Sintoma) VALUES (@sint)

GO

CREATE PROCEDURE stp_GetSintomas
AS

SELECT * FROM Sintomas

GO

CREATE PROCEDURE stp_CreateRelSin @idp INTEGER, @ids INTEGER, @DS DATETIME2
AS

INSERT INTO RelSin(IdP,IdS,DataSintoma) VALUES (@idp,@ids,@DS)

GO

CREATE PROCEDURE stp_GetRelSin @idp INTEGER
AS

IF(@idp IS NOT NULL AND @idp <> 0)

SELECT * FROM RelSin WHERE IdP = @idp

ELSE

SELECT * FROM RelSin

GO

CREATE PROCEDURE stp_CreateFatoresDeRisco @fator VARCHAR(MAX)
AS

INSERT INTO FatoresDeRisco(Fator) VALUES (@fator)

GO

CREATE PROCEDURE stp_GetFatoresDeRisco
AS

SELECT * FROM FatoresDeRisco

GO

CREATE PROCEDURE stp_CreateRelFact @idf INTEGER, @idp INTEGER, @time VARCHAR(MAX)
AS

INSERT INTO RelFact(IdF,IdP,Tempo) VALUES (@idf,@idp,@time)

GO

CREATE PROCEDURE stp_GetRelFact @idp INTEGER
AS

IF(@idp IS NOT NULL AND @idp <> 0)

SELECT * FROM RelFact WHERE IdP = @idp

ELSE

SELECT * FROM RelFact

GO

CREATE PROCEDURE stp_CreateDistrito @name VARCHAR(MAX)
AS

INSERT INTO Distrito(Nome) VALUES (@name)

GO

CREATE PROCEDURE stp_GetDistrito
AS

SELECT * FROM Distrito

GO



CREATE PROCEDURE stp_CreateConselho @name VARCHAR(MAX), @idd INTEGER
AS

INSERT INTO Conselho(Nome,IdDist) VALUES (@name,@idd)

GO

CREATE PROCEDURE stp_GetConselho @what VARCHAR(MAX), @value INT
AS

IF(@what = 'IdConselho')

SELECT * FROM Conselho WHERE IdConselho = @value

ELSE IF(@what = 'IdDist')

SELECT * FROM Conselho WHERE IdDist = @value

ELSE

SELECT * FROM Conselho

GO

CREATE PROCEDURE stp_CreateRelCons @idu INTEGER, @idc INTEGER, @date DATETIME2
AS

INSERT INTO RelCons(IdU,IdC,DataRel) VALUES(@idu,@idc,@date)

GO



CREATE PROCEDURE stp_GetRelCons @idu INTEGER
AS

IF(@idu IS NOT NULL AND @idu <> 0)

SELECT * FROM RelCons WHERE IdU = @idu

ELSE

SELECT * FROM RelCons

GO


CREATE PROCEDURE stp_CreateNotificacao @mess VARCHAR(MAX)
AS

INSERT INTO Notificacao(Mensagem) VALUES (@mess)

GO


CREATE PROCEDURE stp_DeleteNotificacao @id INTEGER
AS

DELETE FROM Notificacao WHERE Id = @id

GO

CREATE PROCEDURE stp_GetNotificacao
AS

SELECT * FROM Notificacao

GO



CREATE LOGIN AnonimoSSIS WITH PASSWORD = 'IS123'
CREATE LOGIN PacienteSSIS WITH PASSWORD = 'IS456'
CREATE LOGIN AssistenteSSIS WITH PASSWORD = 'IS789'
CREATE LOGIN AdministradorSSIS WITH PASSWORD = 'IS000'

CREATE USER Anonimo FROM LOGIN AnonimoSSIS
CREATE USER Paciente FROM LOGIN PacienteSSIS
CREATE USER Assistente FROM LOGIN AssistenteSSIS
CREATE USER Administrador FROM LOGIN AdministradorSSIS


-- Premissões

-- Anonimo

GRANT SELECT ON Utilizador TO Anonimo
GRANT INSERT ON Utilizador TO Anonimo
GRANT INSERT ON Paciente TO Anonimo

GRANT EXECUTE ON stp_CreateUtilizador TO Anonimo
GRANT EXECUTE ON stp_GetUtilizador TO Anonimo
GRANT EXECUTE ON stp_CreatePaciente TO Anonimo


-- Paciente

GRANT SELECT ON Utilizador TO Paciente
GRANT UPDATE ON Utilizador TO Paciente
GRANT SELECT ON Paciente TO Paciente
GRANT UPDATE ON Paciente TO Paciente
GRANT INSERT ON Localizacao TO Paciente
GRANT SELECT ON Localizacao TO Paciente
GRANT SELECT ON Sintomas TO Paciente
GRANT INSERT ON RelSin TO Paciente
GRANT SELECT ON RelSin TO Paciente
GRANT SELECT ON FatoresDeRisco TO Paciente
GRANT INSERT ON RelFact TO Paciente
GRANT SELECT ON RelFact TO Paciente
GRANT SELECT ON Distrito TO Paciente
GRANT SELECT ON Conselho TO Paciente
GRANT SELECT ON RelCons TO Paciente
GRANT INSERT ON RelCons TO Paciente
GRANT INSERT ON Notificacao TO Paciente
GRANT DELETE ON Notificacao TO Paciente
GRANT SELECT ON Notificacao TO Paciente

GRANT EXECUTE ON stp_GetUtilizador TO Paciente
GRANT EXECUTE ON stp_UpdateUtilizador TO Paciente
GRANT EXECUTE ON stp_GetPaciente TO Paciente
GRANT EXECUTE ON stp_UpdatePacienteMorada TO Paciente
GRANT EXECUTE ON stp_CreateLocalizacao TO Paciente
GRANT EXECUTE ON stp_GetLocalizacao TO Paciente
GRANT EXECUTE ON stp_GetSintomas TO Paciente
GRANT EXECUTE ON stp_CreateRelSin TO Paciente
GRANT EXECUTE ON stp_GetRelSin TO Paciente
GRANT EXECUTE ON stp_GetFatoresDeRisco TO Paciente
GRANT EXECUTE ON stp_CreateRelFact TO Paciente
GRANT EXECUTE ON stp_GetRelFact TO Paciente
GRANT EXECUTE ON stp_GetDistrito TO Paciente
GRANT EXECUTE ON stp_GetConselho TO Paciente
GRANT EXECUTE ON stp_CreateRelCons TO Paciente
GRANT EXECUTE ON stp_GetRelCons TO Paciente
GRANT EXECUTE ON stp_CreateNotificacao TO Paciente
GRANT EXECUTE ON stp_DeleteNotificacao TO Paciente
GRANT EXECUTE ON stp_GetNotificacao TO Paciente

-- Assistente

GRANT SELECT ON Utilizador TO Assistente
GRANT UPDATE ON Utilizador TO Assistente
GRANT SELECT ON Paciente TO Assistente
GRANT UPDATE ON Paciente TO Assistente
GRANT SELECT ON Localizacao TO Assistente
GRANT SELECT ON Sintomas TO Assistente
GRANT SELECT ON RelSin TO Assistente
GRANT SELECT ON FatoresDeRisco TO Assistente
GRANT SELECT ON RelFact TO Assistente
GRANT SELECT ON Distrito TO Assistente
GRANT SELECT ON Conselho TO Assistente
GRANT SELECT ON RelCons TO Assistente


GRANT EXECUTE ON stp_GetUtilizador TO Assistente
GRANT EXECUTE ON stp_UpdateUtilizador TO Assistente
GRANT EXECUTE ON stp_GetPaciente TO Assistente
GRANT EXECUTE ON stp_UpdatePacienteEstado TO Assistente
GRANT EXECUTE ON stp_GetLocalizacao TO Assistente
GRANT EXECUTE ON stp_GetSintomas TO Assistente
GRANT EXECUTE ON stp_GetRelSin TO Assistente
GRANT EXECUTE ON stp_GetFatoresDeRisco TO Assistente
GRANT EXECUTE ON stp_GetRelFact TO Assistente
GRANT EXECUTE ON stp_GetDistrito TO Assistente
GRANT EXECUTE ON stp_GetConselho TO Assistente
GRANT EXECUTE ON stp_GetRelCons TO Assistente


-- Administrador

GRANT SELECT ON Utilizador TO Administrador
GRANT UPDATE ON Utilizador TO Administrador
GRANT SELECT ON Paciente TO Administrador
GRANT SELECT ON Localizacao TO Administrador
GRANT UPDATE ON Localizacao TO Administrador
GRANT INSERT ON Sintomas TO Administrador
GRANT SELECT ON Sintomas TO Administrador
GRANT SELECT ON RelSin TO Administrador
GRANT INSERT ON FatoresDeRisco TO Administrador
GRANT SELECT ON FatoresDeRisco TO Administrador
GRANT SELECT ON RelFact TO Administrador
GRANT INSERT ON Distrito TO Administrador
GRANT SELECT ON Distrito TO Administrador
GRANT INSERT ON Conselho TO Administrador
GRANT SELECT ON Conselho TO Administrador
GRANT SELECT ON RelCons TO Administrador


GRANT EXECUTE ON stp_GetUtilizador TO Administrador
GRANT EXECUTE ON stp_UpdateUtilizador TO Administrador
GRANT EXECUTE ON stp_GetPaciente TO Administrador
GRANT EXECUTE ON stp_GetLocalizacao TO Administrador
GRANT EXECUTE ON stp_UpdateLocalizacao TO Administrador
GRANT EXECUTE ON stp_CreateSintomas TO Administrador
GRANT EXECUTE ON stp_GetSintomas TO Administrador
GRANT EXECUTE ON stp_GetRelSin TO Administrador
GRANT EXECUTE ON stp_CreateFatoresDeRisco TO Administrador
GRANT EXECUTE ON stp_GetFatoresDeRisco TO Administrador
GRANT EXECUTE ON stp_GetRelFact TO Administrador
GRANT EXECUTE ON stp_CreateDistrito TO Administrador
GRANT EXECUTE ON stp_GetDistrito TO Administrador
GRANT EXECUTE ON stp_CreateConselho TO Administrador
GRANT EXECUTE ON stp_GetConselho TO Administrador
GRANT EXECUTE ON stp_GetRelCons TO Administrador
GRANT EXECUTE ON stp_ValidarUtilizador TO Administrador

INSERT INTO Sintomas(Sintoma) VALUES ('Corrimento')
INSERT INTO Sintomas(Sintoma) VALUES ('Cansaço')
INSERT INTO Sintomas(Sintoma) VALUES ('Diarreia')
INSERT INTO Sintomas(Sintoma) VALUES ('Congestão')
INSERT INTO Sintomas(Sintoma) VALUES ('Contacto')

INSERT INTO FatoresDeRisco(Fator) VALUES('Tabagismo')
INSERT INTO FatoresDeRisco(Fator) VALUES('Hipertenção')
INSERT INTO FatoresDeRisco(Fator) VALUES('Diabetes')
INSERT INTO FatoresDeRisco(Fator) VALUES('Colestrol/Triglicerideos')



CREATE PROCEDURE stp_UpdateEstadoUtilizador @id INTEGER, @estado VARCHAR(MAX)
AS

UPDATE Utilizador SET Estado = @estado WHERE Id = @id


GO


GRANT UPDATE ON Utilizador to Paciente
GRANT EXECUTE ON stp_UpdateEstadoUtilizador to Paciente


