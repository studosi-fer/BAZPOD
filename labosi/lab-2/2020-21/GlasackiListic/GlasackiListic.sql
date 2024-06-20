/*
DROP TABLE VrstaJedinice;
DROP TABLE VrIzbor;
DROP TABLE Lista;
DROP TABLE Osoba;
DROP TABLE Listic;
DROP TABLE Kandidat;
DROP TABLE Sadrzi;
DROP TABLE BirackoMjesto;
DROP TABLE Jedinica;
DROP TABLE Naselje;
DROP TABLE Stranka;
DROP TABLE Raspolaze;
DROP TABLE JePredlagac;
*/

CREATE TABLE VrstaJedinice
(
  sifVrJedinica INT NOT NULL,
  nazVrJedinica VARCHAR(200) NOT NULL,
  PRIMARY KEY (sifVrJedinica),
  UNIQUE (nazVrJedinica)
);

CREATE TABLE VrIzbor
(
  sifVrIzbor INT NOT NULL,
  nazVrIzbor VARCHAR(200) NOT NULL,
  PRIMARY KEY (sifVrIzbor)
);

CREATE TABLE Lista
(
  sifLista INT NOT NULL,
  nazLista VARCHAR(200) NOT NULL,
  PRIMARY KEY (sifLista)
);

CREATE TABLE Osoba
(
  OIB CHAR(11) NOT NULL,
  ime VARCHAR(25) NOT NULL,
  prezime VARCHAR(25) NOT NULL,
  PRIMARY KEY (OIB)
);

CREATE TABLE Listic
(
  sifListic INT NOT NULL,
  nazListic VARCHAR(100) NOT NULL,
  sifVrIzbor INT NOT NULL,
  PRIMARY KEY (sifListic),
  FOREIGN KEY (sifVrIzbor) REFERENCES VrIzbor(sifVrIzbor)
);

CREATE TABLE Kandidat
(
  rbrKandidat INT NOT NULL,
  sifLista INT NOT NULL,
  OIB CHAR(11) NOT NULL,
  PRIMARY KEY (rbrKandidat, sifLista),
  FOREIGN KEY (sifLista) REFERENCES Lista(sifLista),
  FOREIGN KEY (OIB) REFERENCES Osoba(OIB)
);

CREATE TABLE Sadrzi
(
  sifListic INT NOT NULL,
  sifLista INT NOT NULL,
  PRIMARY KEY (sifListic, sifLista),
  FOREIGN KEY (sifListic) REFERENCES Listić(sifListic),
  FOREIGN KEY (sifLista) REFERENCES Lista(sifLista)
);

CREATE TABLE BirackoMjesto
(
  sifBM INT NOT NULL,
  nazBM VARCHAR(200) NOT NULL,
  sifJedinica INT NOT NULL,
  sifNaselje INT NOT NULL,
  PRIMARY KEY (sifBM),
  FOREIGN KEY (sifJedinica) REFERENCES Jedinica(sifJedinica),
  FOREIGN KEY (sifNaselje) REFERENCES Naselje(sifNaselje)
);

CREATE TABLE Jedinica
(
  sifJedinica INT NOT NULL,
  NazJedinica VARCHAR(200) NOT NULL,
  sifVrJedinica INT NOT NULL,
  NadJed_sifJedinica INT,
  PRIMARY KEY (sifJedinica),
  FOREIGN KEY (sifVrJedinica) REFERENCES VrstaJedinice(sifVrJedinica),
  FOREIGN KEY (NadJed_sifJedinica) REFERENCES Jedinica(sifJedinica),
  UNIQUE (NazJedinica)
);

CREATE TABLE Naselje
(
  sifNaselje INT NOT NULL,
  postBroj INT NOT NULL,
  nazNaselje VARCHAR(100) NOT NULL,
  sifJedinica INT NOT NULL,
  PRIMARY KEY (sifNaselje),
  FOREIGN KEY (sifJedinica) REFERENCES Jedinica(sifJedinica),
  CONSTRAINT chkPostBroj CHECK (postBroj >= 10000 AND postBroj < 60000)
);

CREATE TABLE Stranka
(
  kratStranka VARCHAR(10) NOT NULL,
  nazStranka VARCHAR(200) NOT NULL,
  sifNaselje INT NOT NULL,
  PRIMARY KEY (kratStranka),
  FOREIGN KEY (sifNaselje) REFERENCES Naselje(sifNaselje),
  UNIQUE (nazStranka)
);

CREATE TABLE Raspolaze
(
  sifBM INT NOT NULL,
  sifListic INT NOT NULL,
  PRIMARY KEY (sifBM, sifListic),
  FOREIGN KEY (sifBM) REFERENCES BirackoMjesto(sifBM),
  FOREIGN KEY (sifListic) REFERENCES Listić(sifListic)
);

CREATE TABLE JePredlagac
(
  sifLista INT NOT NULL,
  kratStranka VARCHAR(10) NOT NULL,
  PRIMARY KEY (sifLista, kratStranka),
  FOREIGN KEY (sifLista) REFERENCES Lista(sifLista),
  FOREIGN KEY (kratStranka) REFERENCES Stranka(kratStranka)
);