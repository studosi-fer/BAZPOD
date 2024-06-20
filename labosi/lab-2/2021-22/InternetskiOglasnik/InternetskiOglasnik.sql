CREATE TABLE OSOBA
(
  OIBosoba CHAR(11) NOT NULL,
  email VARCHAR(40) NOT NULL,
  ime VARCHAR(40) NOT NULL,
  prezime VARCHAR(40) NOT NULL,
  PRIMARY KEY (OIBosoba),
  UNIQUE (email)
);

CREATE TABLE KUPAC
(
  datumRodjenja DATE NOT NULL,
  spol CHAR(1) NOT NULL,
  OIBosoba CHAR(11) NOT NULL,
  PRIMARY KEY (OIBosoba),
  FOREIGN KEY (OIBosoba) REFERENCES OSOBA(OIBosoba),
  CONSTRAINT chkSpol CHECK (spol in ('M', 'Z'))
);

CREATE TABLE GRAD
(
  nazivGrad VARCHAR(40) NOT NULL,
  pBr INT NOT NULL,
  PRIMARY KEY (pBr),
  UNIQUE (nazivGrad)
);

CREATE TABLE AGENCIJA
(
  nazivAgencija VARCHAR(40) NOT NULL,
  telefon VARCHAR(20) NOT NULL,
  idAgencija INT NOT NULL,
  adresaSjediste VARCHAR(100) NOT NULL,
  pBrSjediste INT NOT NULL,
  PRIMARY KEY (idAgencija),
  FOREIGN KEY (pBrSjediste) REFERENCES GRAD(pBr),
  UNIQUE (nazivAgencija)
);

CREATE TABLE KARAKTERISTIKA
(
  opisKarakteristika VARCHAR(500) NOT NULL,
  nazivKarakteristika VARCHAR(40) NOT NULL,
  idKarakteristika INT NOT NULL,
  PRIMARY KEY (idKarakteristika),
  UNIQUE (nazivKarakteristika)
);

CREATE TABLE VRSTA_NEKRETNINE
(
  idVrNekretnina INT NOT NULL,
  nazivVrNekretnina VARCHAR(40) NOT NULL,
  PRIMARY KEY (idVrNekretnina),
  UNIQUE (nazivVrNekretnina)
);

CREATE TABLE imaPodruznicu
(
  adresaPodruznica VARCHAR(100) NOT NULL,
  pBr INT NOT NULL,
  idAgencija INT NOT NULL,
  PRIMARY KEY (pBr, idAgencija),
  FOREIGN KEY (pBr) REFERENCES GRAD(pBr),
  FOREIGN KEY (idAgencija) REFERENCES AGENCIJA(idAgencija)
);

CREATE TABLE DJELATNIK
(
  datStrucIspit DATE,
  OIBosoba CHAR(11) NOT NULL,
  idAgencija INT NOT NULL,
  imaNadred_OIBosoba CHAR(11),
  PRIMARY KEY (OIBosoba),
  FOREIGN KEY (OIBosoba) REFERENCES OSOBA(OIBosoba),
  FOREIGN KEY (idAgencija) REFERENCES AGENCIJA(idAgencija),
  FOREIGN KEY (imaNadred_OIBosoba) REFERENCES DJELATNIK(OIBosoba)
);

CREATE TABLE OGLAS
(
  brPregleda INT NOT NULL,
  sifraOglas INT NOT NULL,
  nazivOglas VARCHAR(40) NOT NULL,
  opisOglas VARCHAR(500) NOT NULL,
  idAgencija INT NOT NULL,
  idVrNekretnina INT NOT NULL,
  OIBosoba CHAR(11) NOT NULL,
  PRIMARY KEY (sifraOglas, idAgencija),
  FOREIGN KEY (idAgencija) REFERENCES AGENCIJA(idAgencija),
  FOREIGN KEY (idVrNekretnina) REFERENCES VRSTA_NEKRETNINE(idVrNekretnina),
  FOREIGN KEY (OIBosoba) REFERENCES DJELATNIK(OIBosoba)
);

CREATE TABLE odrzava
(
  OIBosoba CHAR(11) NOT NULL,
  sifraOglas INT NOT NULL,
  idAgencija INT NOT NULL,
  PRIMARY KEY (OIBosoba, sifraOglas, idAgencija),
  FOREIGN KEY (OIBosoba) REFERENCES DJELATNIK(OIBosoba),
  FOREIGN KEY (sifraOglas, idAgencija) REFERENCES OGLAS(sifraOglas, idAgencija)
);

CREATE TABLE gleda
(
  ocjena INT,
  OIBosoba CHAR(11) NOT NULL,
  sifraOglas INT NOT NULL,
  idAgencija INT NOT NULL,
  PRIMARY KEY (OIBosoba, sifraOglas, idAgencija),
  FOREIGN KEY (OIBosoba) REFERENCES KUPAC(OIBosoba),
  FOREIGN KEY (sifraOglas, idAgencija) REFERENCES OGLAS(sifraOglas, idAgencija),
  CONSTRAINT chkOcjOglas CHECK (ocjena BETWEEN  1 and 5)
);

CREATE TABLE opisuje
(
  sifraOglas INT NOT NULL,
  idAgencija INT NOT NULL,
  idKarakteristika INT NOT NULL,
  PRIMARY KEY (sifraOglas, idAgencija, idKarakteristika),
  FOREIGN KEY (sifraOglas, idAgencija) REFERENCES OGLAS(sifraOglas, idAgencija),
  FOREIGN KEY (idKarakteristika) REFERENCES KARAKTERISTIKA(idKarakteristika)
);