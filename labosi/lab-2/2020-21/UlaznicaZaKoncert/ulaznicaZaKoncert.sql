
DROP TABLE ULAZNICA;
DROP TABLE SJEDALO;
DROP TABLE SEKTOR;
DROP TABLE IZVEDBA;
DROP TABLE GLAZBZANR;
DROP TABLE KONCERT;
DROP TABLE DVORANA;
DROP TABLE ZANR;
DROP TABLE USTANOVA;
DROP TABLE VRUSTANOVA;
DROP TABLE MJESTO;


CREATE TABLE MJESTO
(
  sifMjesto INT NOT NULL,
  postOzn INT,
  nazMjesto VARCHAR(100) NOT NULL,
  PRIMARY KEY (sifMjesto)
);

CREATE TABLE ZANR
(
  sifZanr INT NOT NULL,
  nazZanr VARCHAR(50) NOT NULL,
  PRIMARY KEY (sifZanr),
  UNIQUE (nazZanr)
);

CREATE TABLE KONCERT
(
  sifKoncert INT NOT NULL,
  nazKoncert VARCHAR(200) NOT NULL,
  opisKoncert VARCHAR(500) NOT NULL,
  URIKoncert VARCHAR(100) NOT NULL,
  PRIMARY KEY (sifKoncert),
  UNIQUE (URIKoncert)
);

CREATE TABLE VRUSTANOVA
(
  sifVrUst INT NOT NULL,
  nazVrUst VARCHAR(200) NOT NULL,
  PRIMARY KEY (sifVrUst),
  UNIQUE (nazVrUst)
);

CREATE TABLE glazbZanr
(
  sifZanr INT NOT NULL,
  sifKoncert INT NOT NULL,
  PRIMARY KEY (sifZanr, sifKoncert),
  FOREIGN KEY (sifZanr) REFERENCES ZANR(sifZanr),
  FOREIGN KEY (sifKoncert) REFERENCES KONCERT(sifKoncert)
);

CREATE TABLE USTANOVA
(
  sifUstanova INT NOT NULL,
  URIUstanova VARCHAR(100) NOT NULL,
  nazUstanova VARCHAR(200) NOT NULL,
  sifMjesto INT NOT NULL,
  sifVrUst INT NOT NULL,
  PRIMARY KEY (sifUstanova),
  FOREIGN KEY (sifMjesto) REFERENCES MJESTO(sifMjesto),
  FOREIGN KEY (sifVrUst) REFERENCES VRUSTANOVA(sifVrUst),
  UNIQUE (URIUstanova)
);

CREATE TABLE DVORANA
(
  oznDvorana CHAR(5) NOT NULL,
  nazDvorana VARCHAR(100) NOT NULL,
  sifUstanova INT NOT NULL,
  PRIMARY KEY (oznDvorana),
  FOREIGN KEY (sifUstanova) REFERENCES USTANOVA(sifUstanova)
);

CREATE TABLE SEKTOR
(
  rbrSektor INT NOT NULL,
  nazSektor VARCHAR(25) NOT NULL,
  oznDvorana CHAR(5) NOT NULL,
  PRIMARY KEY (rbrSektor, oznDvorana),
  FOREIGN KEY (oznDvorana) REFERENCES DVORANA(oznDvorana)
);

CREATE TABLE IZVEDBA
(
  datumSatMinPoc TIMESTAMP NOT NULL,
  sifKoncert INT NOT NULL,
  oznDvorana CHAR(5) NOT NULL,
  PRIMARY KEY (datumSatMinPoc, sifKoncert),
  FOREIGN KEY (sifKoncert) REFERENCES KONCERT(sifKoncert),
  FOREIGN KEY (oznDvorana) REFERENCES DVORANA(oznDvorana),
  CONSTRAINT uniqueIzvedba UNIQUE(oznDvorana, datumSatMinPoc)
);

CREATE TABLE SJEDALO
(
  sifSjedalo INT NOT NULL,
  rbrRed INT NOT NULL,
  rbrStupac INT NOT NULL,
  rbrSektor INT NOT NULL,
  oznDvorana CHAR(5) NOT NULL,
  PRIMARY KEY (sifSjedalo),
  FOREIGN KEY (rbrSektor, oznDvorana) REFERENCES SEKTOR(rbrSektor, oznDvorana),
  CONSTRAINT chkRbrRed CHECK (rbrRed BETWEEN 1 AND 50),
  CONSTRAINT chkRbrStupac CHECK (rbrStupac BETWEEN 1 AND 50)
);

CREATE TABLE ULAZNICA
(
  serBroj INT NOT NULL,
  cijena DECIMAL(7,2) NOT NULL,
  sifSjedalo INT NOT NULL,
  datumSatMinPoc TIMESTAMP NOT NULL,
  sifKoncert INT NOT NULL,
  PRIMARY KEY (serBroj),
  FOREIGN KEY (sifSjedalo) REFERENCES SJEDALO(sifSjedalo),
  FOREIGN KEY (datumSatMinPoc, sifKoncert) REFERENCES IZVEDBA(datumSatMinPoc, sifKoncert),
  CONSTRAINT uniqueUlaznica UNIQUE(sifSjedalo, datumSatMinPoc),
  CONSTRAINT chkCijena CHECK (cijena > 0.00)
);