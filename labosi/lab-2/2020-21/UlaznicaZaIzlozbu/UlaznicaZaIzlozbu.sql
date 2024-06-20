CREATE TABLE KORISNIK
(
  eMail VARCHAR(50) NOT NULL,
  Ime VARCHAR(25) NOT NULL,
  Prezime VARCHAR(25) NOT NULL,
  datumRegistracija DATE NOT NULL,
  lozinka VARCHAR(25) NOT NULL,
  sifKorisnik INT NOT NULL,
  PRIMARY KEY (sifKorisnik),
  UNIQUE (eMail)
);

CREATE TABLE DRZAVA
(
  ISOOznaka CHAR(2) NOT NULL,
  nazDrzava VARCHAR(100) NOT NULL,
  PRIMARY KEY (ISOOznaka),
  UNIQUE (nazDrzava)
);

CREATE TABLE MJESTO
(
  sifMjesto INT NOT NULL,
  postOzn INT,
  nazMjesto VARCHAR(100) NOT NULL,
  ISOOznaka CHAR(2) NOT NULL,
  PRIMARY KEY (sifMjesto),
  FOREIGN KEY (ISOOznaka) REFERENCES DRZAVA(ISOOznaka)
);

CREATE TABLE VRUSTANOVA
(
  sifVrUst INT NOT NULL,
  nazVrUst VARCHAR(200) NOT NULL,
  PRIMARY KEY (sifVrUst),
  UNIQUE (nazVrUst)
);

CREATE TABLE USTANOVA
(
  sifUstanova INT NOT NULL,
  uriUstanova VARCHAR(100),
  nazUstanova VARCHAR(200) NOT NULL,
  sifMjesto INT NOT NULL,
  sifVrUst INT NOT NULL,
  PRIMARY KEY (sifUstanova),
  FOREIGN KEY (sifMjesto) REFERENCES MJESTO(sifMjesto),
  FOREIGN KEY (sifVrUst) REFERENCES VRUSTANOVA(sifVrUst),
  UNIQUE (uriUstanova)
);

CREATE TABLE IZLOZBA
(
  sifIzlozba INT NOT NULL,
  nazIzlozba VARCHAR(200) NOT NULL,
  opisIzlozba VARCHAR(500) NOT NULL,
  uriIzlozba VARCHAR(100) NOT NULL,
  sifUstanova INT NOT NULL,
  PRIMARY KEY (sifIzlozba),
  FOREIGN KEY (sifUstanova) REFERENCES USTANOVA(sifUstanova),
  UNIQUE (uriIzlozba)
);

CREATE TABLE izlUstPostavlja
(
  sifUstanova INT NOT NULL,
  sifIzlozba INT NOT NULL,
  PRIMARY KEY (sifUstanova, sifIzlozba),
  FOREIGN KEY (sifUstanova) REFERENCES USTANOVA(sifUstanova),
  FOREIGN KEY (sifIzlozba) REFERENCES IZLOZBA(sifIzlozba)
);

CREATE TABLE TERMINRAZGL
(
  sifIzlozba INT NOT NULL,
  datumSatMinTermin TIMESTAMP NOT NULL,
  cijenaUlaznica NUMERIC(6, 2) NOT NULL,
  maxBrUlaznica INT NOT NULL,
  PRIMARY KEY (datumSatMinTermin, sifIzlozba),
  FOREIGN KEY (sifIzlozba) REFERENCES IZLOZBA(sifIzlozba)
);

CREATE TABLE KUPNJA
(
  rbrKupnja INT NOT NULL,
  datumKupnja DATE NOT NULL,
  ukupanIznos NUMERIC(6, 2) NOT NULL,
  postoPopust NUMERIC(6, 2) NOT NULL,
  kodZaPopust INT,
  sifKorisnik INT NOT NULL,
  PRIMARY KEY (rbrKupnja, sifKorisnik),
  FOREIGN KEY (sifKorisnik) REFERENCES KORISNIK(sifKorisnik),
  CONSTRAINT chkPostoPopust CHECK (postoPopust BETWEEN 0.00 AND 100.00),
  CONSTRAINT chkKodIPopust CHECK ((kodZaPopust IS NOT NULL AND postoPopust > 0) OR (kodZaPopust IS NULL AND postoPopust = 0))
);

CREATE TABLE kupnjaTermin
(
  brojUlaznica INT NOT NULL,
  datumSatMinTermin TIMESTAMP NOT NULL,
  sifIzlozba INT NOT NULL,
  rbrKupnja INT NOT NULL,
  sifKorisnik INT NOT NULL,
  PRIMARY KEY (datumSatMinTermin, sifIzlozba, rbrKupnja, sifKorisnik),
  FOREIGN KEY (datumSatMinTermin, sifIzlozba) REFERENCES TERMINRAZGL(datumSatMinTermin, sifIzlozba),
  FOREIGN KEY (rbrKupnja, sifKorisnik) REFERENCES KUPNJA(rbrKupnja, sifKorisnik)
);


