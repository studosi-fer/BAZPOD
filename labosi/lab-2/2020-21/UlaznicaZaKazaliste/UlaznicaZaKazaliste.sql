CREATE TABLE MJESTO
(
  sifMjesto INT NOT NULL,
  postOzn INT,
  nazMjesto VARCHAR(100) NOT NULL,
  PRIMARY KEY (sifMjesto)
);

CREATE TABLE KAZALISTE
(
  sifKazaliste INT NOT NULL,
  URIKazaliste VARCHAR(100) NOT NULL,
  nazKazaliste VARCHAR(200) NOT NULL,
  sifMjesto INT NOT NULL,
  PRIMARY KEY (sifKazaliste),
  FOREIGN KEY (sifMjesto) REFERENCES MJESTO(sifMjesto),
  UNIQUE (URIKazaliste)
);

CREATE TABLE KATEGORIJA
(
  sifKategorija INT NOT NULL,
  nazKategorija VARCHAR(50) NOT NULL,
  PRIMARY KEY (sifKategorija),
  UNIQUE (nazKategorija)
);

CREATE TABLE PREDSTAVA
(
  sifPredstava INT NOT NULL,
  nazPredstava VARCHAR(200) NOT NULL,
  opisPredstava VARCHAR(500) NOT NULL,
  URIPredstava VARCHAR(100) NOT NULL,
  datumPremijere DATE NOT NULL,
  sifKategorija INT NOT NULL,
  sifKazaliste INT NOT NULL,
  PRIMARY KEY (sifPredstava),
  FOREIGN KEY (sifKategorija) REFERENCES KATEGORIJA(sifKategorija),
  FOREIGN KEY (sifKazaliste) REFERENCES KAZALISTE(sifKazaliste),
  UNIQUE (URIPredstava),
  CONSTRAINT chkDatumPremijera CHECK (datumPremijere BETWEEN CURRENT_DATE - '50 YEARS'::INTERVAL and CURRENT_DATE + '1 YEAR'::INTERVAL)
);

CREATE TABLE DVORANA
(
  oznDvorana CHAR(4) NOT NULL,
  nazDvorana VARCHAR(100) NOT NULL,
  sifKazaliste INT NOT NULL,
  PRIMARY KEY (oznDvorana),
  FOREIGN KEY (sifKazaliste) REFERENCES KAZALISTE(sifKazaliste)
);

CREATE TABLE SEKTOR
(
  rbrSektor INT NOT NULL,
  nazSektor VARCHAR(25) NOT NULL,
  oznDvorana CHAR(4) NOT NULL,
  PRIMARY KEY (rbrSektor, oznDvorana),
  FOREIGN KEY (oznDvorana) REFERENCES DVORANA(oznDvorana)
);

CREATE TABLE IZVEDBA
(
  datumSatMinPoc TIMESTAMP NOT NULL,
  sifPredstava INT NOT NULL,
  oznDvorana CHAR(4) NOT NULL,
  PRIMARY KEY (datumSatMinPoc, sifPredstava),
  FOREIGN KEY (sifPredstava) REFERENCES PREDSTAVA(sifPredstava),
  FOREIGN KEY (oznDvorana) REFERENCES DVORANA(oznDvorana),
  UNIQUE (datumSatMinPoc, oznDvorana)
);

CREATE TABLE SJEDALO
(
  sifSjedalo INT NOT NULL,
  rbrRed INT NOT NULL,
  rbrStupac INT NOT NULL,
  rbrSektor INT NOT NULL,
  oznDvorana CHAR(4) NOT NULL,
  PRIMARY KEY (sifSjedalo),
  FOREIGN KEY (rbrSektor, oznDvorana) REFERENCES SEKTOR(rbrSektor, oznDvorana),
  CONSTRAINT chkRbrRed CHECK (rbrRed >= 1 AND rbrRed <= 50),
  CONSTRAINT chkRbrStupac CHECK (rbrStupac >= 1 AND rbrStupac <= 50)
);

CREATE TABLE sjedIzvedba
(
  cijena NUMERIC(5, 2) NOT NULL,
  sifSjedalo INT NOT NULL,
  datumSatMinPoc TIMESTAMP NOT NULL,
  sifPredstava INT NOT NULL,
  PRIMARY KEY (sifSjedalo, datumSatMinPoc, sifPredstava),
  FOREIGN KEY (sifSjedalo) REFERENCES SJEDALO(sifSjedalo),
  FOREIGN KEY (datumSatMinPoc, sifPredstava) REFERENCES IZVEDBA(datumSatMinPoc, sifPredstava)
);