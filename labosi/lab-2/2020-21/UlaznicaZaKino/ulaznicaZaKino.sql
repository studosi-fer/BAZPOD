CREATE TABLE MJESTO
(
  sifMjesto INT NOT NULL,
  postOzn INT,
  nazMjesto VARCHAR(100) NOT NULL,
  PRIMARY KEY (sifMjesto)
);

CREATE TABLE KINO
(
  sifKino INT NOT NULL,
  URIKino VARCHAR(100) NOT NULL,
  nazKino VARCHAR(200) NOT NULL,
  sifMjesto INT NOT NULL,
  PRIMARY KEY (sifKino),
  FOREIGN KEY (sifMjesto) REFERENCES MJESTO(sifMjesto),
  UNIQUE (URIKino)
);

CREATE TABLE ZANR
(
  sifZanr INT NOT NULL,
  nazZanr VARCHAR(50) NOT NULL,
  PRIMARY KEY (sifZanr),
  UNIQUE (nazZanr)
);

CREATE TABLE FILM
(
  sifFilm INT NOT NULL,
  nazFilm VARCHAR(200) NOT NULL,
  opisFilm VARCHAR(500) NOT NULL,
  datumPremijera DATE NOT NULL,
  IMDBOcjena NUMERIC(3, 1) NOT NULL,
  PRIMARY KEY (sifFilm), 
  CONSTRAINT chkDatumPremijera CHECK (datumPremijera BETWEEN CURRENT_DATE - '100 YEARS'::INTERVAL and CURRENT_DATE + '1 YEAR'::INTERVAL)
);

CREATE TABLE DVORANA
(
  sifDvorana INT NOT NULL,
  nazDvorana VARCHAR(100) NOT NULL,
  sifKino INT NOT NULL,
  PRIMARY KEY (sifDvorana),
  FOREIGN KEY (sifKino) REFERENCES KINO(sifKino)
);

CREATE TABLE SJEDALO
(
  sifSjedalo INT NOT NULL,
  rbrRed INT NOT NULL,
  rbrStupac INT NOT NULL,
  sifDvorana INT NOT NULL,
  PRIMARY KEY (sifSjedalo),
  FOREIGN KEY (sifDvorana) REFERENCES DVORANA(sifDvorana), 
  CONSTRAINT chkRbrRed CHECK (rbrRed >= 1 AND rbrRed <= 50),
  CONSTRAINT chkRbrStupac CHECK (rbrStupac >= 1 AND rbrStupac <= 50)
);

CREATE TABLE filmZanr
(
  sifZanr INT NOT NULL,
  sifFilm INT NOT NULL,
  PRIMARY KEY (sifZanr, sifFilm),
  FOREIGN KEY (sifZanr) REFERENCES ZANR(sifZanr),
  FOREIGN KEY (sifFilm) REFERENCES FILM(sifFilm)
);

CREATE TABLE nadZanr
(
  sifZanr_1 INT NOT NULL,
  nadZanrsifZanr_2 INT NOT NULL,
  PRIMARY KEY (sifZanr_1, nadZanrsifZanr_2),
  FOREIGN KEY (sifZanr_1) REFERENCES ZANR(sifZanr),
  FOREIGN KEY (nadZanrsifZanr_2) REFERENCES ZANR(sifZanr)
);

CREATE TABLE IZVEDBA
(
  datumSatMinPoc TIMESTAMP NOT NULL,
  sifDvorana INT NOT NULL,
  sifFilm INT NOT NULL,
  PRIMARY KEY (datumSatMinPoc, sifDvorana),
  FOREIGN KEY (sifDvorana) REFERENCES DVORANA(sifDvorana),
  FOREIGN KEY (sifFilm) REFERENCES FILM(sifFilm),
  CONSTRAINT uniqueIzvedba UNIQUE (datumSatMinPoc, sifFilm)
);

CREATE TABLE sjedIzvedba
(
  cijena NUMERIC(5, 2) NOT NULL,
  sifSjedalo INT NOT NULL,
  datumSatMinPoc TIMESTAMP NOT NULL,
  sifDvorana INT NOT NULL,
  PRIMARY KEY (sifSjedalo, datumSatMinPoc, sifDvorana),
  FOREIGN KEY (sifSjedalo) REFERENCES SJEDALO(sifSjedalo),
  FOREIGN KEY (datumSatMinPoc, sifDvorana) REFERENCES IZVEDBA(datumSatMinPoc, sifDvorana)
);