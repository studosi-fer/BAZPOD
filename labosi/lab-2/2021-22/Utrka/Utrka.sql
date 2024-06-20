CREATE TABLE Mjesto
(
  PostanskiBroj CHAR(5) NOT NULL,
  NazivMjesto VARCHAR(80) NOT NULL,
  PRIMARY KEY (PostanskiBroj)
);

CREATE TABLE Kategorija
(
  OznakaKategorija VARCHAR(10) NOT NULL,
  OpisKategorija VARCHAR(80) NOT NULL,
  PRIMARY KEY (OznakaKategorija),
  UNIQUE (OpisKategorija)
);

CREATE TABLE Atletski_klub
(
  KraticaKlub VARCHAR(10) NOT NULL,
  NazivKlub VARCHAR(80) NOT NULL,
  GodinaOsnutka INT NOT NULL,
  PostanskiBroj VARCHAR(5) NOT NULL,
  PRIMARY KEY (KraticaKlub),
  FOREIGN KEY (PostanskiBroj) REFERENCES Mjesto(PostanskiBroj)
);

CREATE TABLE Utrka
(
  DatumOdrzavanja INT NOT NULL,
  KraticaKlub VARCHAR(10) NOT NULL,
  Startnina NUMERIC(5,2) NOT NULL,
  NazivUtrka VARCHAR(80) NOT NULL,
  PostanskiBroj VARCHAR(5) NOT NULL,
  OznakaKategorija VARCHAR(10) NOT NULL,
  PRIMARY KEY (DatumOdrzavanja, KraticaKlub),
  FOREIGN KEY (KraticaKlub) REFERENCES Atletski_klub(KraticaKlub),
  FOREIGN KEY (PostanskiBroj) REFERENCES Mjesto(PostanskiBroj),
  FOREIGN KEY (OznakaKategorija) REFERENCES Kategorija(OznakaKategorija)
);

CREATE TABLE Liga
(
  KraticaLiga VARCHAR(10) NOT NULL,
  NazivLiga VARCHAR(80) NOT NULL,
  PRIMARY KEY (KraticaLiga),
  UNIQUE (NazivLiga)
);

CREATE TABLE KlubLiga
(
  KraticaKlub VARCHAR(10) NOT NULL,
  KraticaLiga VARCHAR(10)  NOT NULL,
  DatumPocetak DATE NOT NULL,
  DatumKraj DATE NOT NULL CONSTRAINT chkKlubLigaDatum CHECK (DatumKraj>DatumPocetak),
  Bodovi INT NOT NULL CONSTRAINT chkBodoviKlubGodina CHECK(Bodovi>=0),
  PRIMARY KEY (KraticaKlub, KraticaLiga),
  FOREIGN KEY (KraticaKlub) REFERENCES Atletski_klub(KraticaKlub),
  FOREIGN KEY (KraticaLiga) REFERENCES Liga(KraticaLiga)
);

CREATE TABLE Osoba
(
  OIB CHAR(11) NOT NULL,
  Ime VARCHAR(20) NOT NULL,
  Prezime VARCHAR(20) NOT NULL,
  DatumRodjenja DATE NOT NULL,
  KraticaKlub VARCHAR(10),
  DatumPocetkaClanstva DATE,
  Trener_OIB VARCHAR(11),
  PRIMARY KEY (OIB),
  FOREIGN KEY (KraticaKlub) REFERENCES Atletski_klub(KraticaKlub),
  FOREIGN KEY (Trener_OIB) REFERENCES Osoba(OIB)
);

CREATE TABLE SudjelujeNa
(
  OIB VARCHAR(11) NOT NULL,
  DatumOdrzavanja INT NOT NULL,
  KraticaKlub VARCHAR(10) NOT NULL,
  VrijemeStart TIMESTAMP NOT NULL,
  VrijemeCilj TIMESTAMP NULL CONSTRAINT chkTrajanjeUtrke CHECK (VrijemeCilj>VrijemeStart),
  Plasman INT,
  PRIMARY KEY (OIB, DatumOdrzavanja, KraticaKlub),
  FOREIGN KEY (OIB) REFERENCES Osoba(OIB),
  FOREIGN KEY (DatumOdrzavanja, KraticaKlub) REFERENCES Utrka(DatumOdrzavanja, KraticaKlub)
);