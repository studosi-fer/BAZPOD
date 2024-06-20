/*
DROP TABLE VrstaSamouprava;
DROP TABLE BirackoMjesto;
DROP TABLE Samouprava;
DROP TABLE Mjesto;
DROP TABLE Birac;
DROP TABLE Ulica;
DROP TABLE KućniBroj;
*/


CREATE TABLE VrstaSamouprava
(
  sifVrSamouprava INT NOT NULL,
  nazVrSamouprava VARCHAR(200) NOT NULL,
  PRIMARY KEY (sifVrSamouprava),
  UNIQUE (nazVrSamouprava)
);

CREATE TABLE Samouprava
(
  sifSamouprava INT NOT NULL,
  nazSamouprava VARCHAR(200) NOT NULL,
  sifVrSamouprava INT NOT NULL,
  NadSU_sifSamouprava INT,
  PRIMARY KEY (sifSamouprava),
  FOREIGN KEY (sifVrSamouprava) REFERENCES VrstaSamouprava(sifVrSamouprava),
  FOREIGN KEY (NadSU_sifSamouprava) REFERENCES Samouprava(sifSamouprava),
  UNIQUE (nazSamouprava)
);

CREATE TABLE BirackoMjesto
(
  sifBM INT NOT NULL,
  nazBM VARCHAR(200) NOT NULL,
  sifSamouprava INT NOT NULL,
  sifKBr INT NOT NULL,
  sifUlica INT NOT NULL,
  sifMjesto INT NOT NULL,
  PRIMARY KEY (sifBM),
  FOREIGN KEY (sifSamouprava) REFERENCES Samouprava(sifSamouprava),
  FOREIGN KEY (sifKBr, sifUlica, sifMjesto) REFERENCES KućniBroj(sifKBr, sifUlica, sifMjesto)
);

CREATE TABLE Mjesto
(
  sifMjesto INT NOT NULL,
  postBroj CHAR(5) NOT NULL,
  nazMjesto VARCHAR(50) NOT NULL,
  sifSamouprava INT NOT NULL,
  PRIMARY KEY (sifMjesto),
  FOREIGN KEY (sifSamouprava) REFERENCES Samouprava(sifSamouprava),
  CONSTRAINT chkPostBroj CHECK (SUBSTRING(postBroj, 1, 1) IN ('1','2','3','4','5'))
);

CREATE TABLE Ulica
(
  sifUlica INT NOT NULL,
  nazUlica VARCHAR(200) NOT NULL,
  sifMjesto INT NOT NULL,
  PRIMARY KEY (sifUlica, sifMjesto),
  FOREIGN KEY (sifMjesto) REFERENCES Mjesto(sifMjesto)
);

CREATE TABLE KućniBroj
(
  sifKBr INT NOT NULL,
  oznKBr VARCHAR(20) NOT NULL,
  sifUlica INT NOT NULL,
  sifMjesto INT NOT NULL,
  sifBM INT NOT NULL,
  PRIMARY KEY (sifKBr, sifUlica, sifMjesto),
  FOREIGN KEY (sifUlica, sifMjesto) REFERENCES Ulica(sifUlica, sifMjesto),
  FOREIGN KEY (sifBM) REFERENCES BirackoMjesto(sifBM)
);

CREATE TABLE Birac
(
  OIB CHAR(11) NOT NULL,
  ime VARCHAR(25) NOT NULL,
  prezime VARCHAR(25) NOT NULL,
  datRod DATE NOT NULL,
  sifKBr INT NOT NULL,
  sifUlica INT NOT NULL,
  sifMjesto INT NOT NULL,
  PRIMARY KEY (OIB),
  FOREIGN KEY (sifKBr, sifUlica, sifMjesto) REFERENCES KućniBroj(sifKBr, sifUlica, sifMjesto)
);
