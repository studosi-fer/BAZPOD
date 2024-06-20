CREATE TABLE Proizvodjac
(
  sifProizvodjac INT NOT NULL,
  nazProizvodjac VARCHAR(80) NOT NULL,
  PRIMARY KEY (sifProizvodjac)
);

CREATE TABLE Model
(
  sifModel INT NOT NULL,
  nazModel VARCHAR(80) NOT NULL,
  sifProizvodjac INT NOT NULL,
  PRIMARY KEY (sifModel, sifProizvodjac),
  FOREIGN KEY (sifProizvodjac) REFERENCES Proizvodjac(sifProizvodjac)
);

CREATE TABLE Vlasnik
(
  sifOsoba INT NOT NULL,
  prezOsoba VARCHAR(20) NOT NULL,
  imeOsoba VARCHAR(20) NOT NULL,
  OIB VARCHAR(11) NOT NULL,
  PRIMARY KEY (sifOsoba),
  UNIQUE (OIB)
);

CREATE TABLE Rad
(
  sifRad INT NOT NULL,
  nazRad VARCHAR(80) NOT NULL,
  PRIMARY KEY (sifRad)
);

CREATE TABLE CijenaRad
(
  datCijenaRad DATE NOT NULL,
  iznosCijenaRad NUMERIC(5,2) NOT NULL,
  datKrajCijRad DATE,
  sifRad INT NOT NULL,
  PRIMARY KEY (datCijenaRad, sifRad),
  FOREIGN KEY (sifRad) REFERENCES Rad(sifRad),
  CONSTRAINT chkTrajanjeCijRad CHECK (datcijenarad < datkrajcijrad)
);

CREATE TABLE Materijal
(
  sifMat INT NOT NULL,
  nazMat VARCHAR(80) NOT NULL,
  PRIMARY KEY (sifMat)
);

CREATE TABLE CijenaMat
(
  datCijenaMat DATE NOT NULL,
  iznosCijenaMat NUMERIC (5,2) NOT NULL,
  datKrajCijMat DATE,
  sifMat INT NOT NULL,
  PRIMARY KEY (datCijenaMat, sifMat),
  FOREIGN KEY (sifMat) REFERENCES Materijal(sifMat),
  CONSTRAINT chkTrajanjeCijMat CHECK (datcijenamat < datkrajcijmat)
);

CREATE TABLE zamjMat
(
  sifMat_1 INT NOT NULL,
  zamjMatsifMat_2 INT NOT NULL,
  PRIMARY KEY (sifMat_1, zamjMatsifMat_2),
  FOREIGN KEY (sifMat_1) REFERENCES Materijal(sifMat),
  FOREIGN KEY (zamjMatsifMat_2) REFERENCES Materijal(sifMat), 
  CONSTRAINT chkZamjmat CHECK (sifmat_1 <> zamjmatsifmat_2)
);

CREATE TABLE Bicikl
(
  kodBicikl INT NOT NULL,
  slikaBicikl BYTEA NOT NULL,
  sifModel INT NOT NULL,
  sifProizvodjac INT NOT NULL,
  sifOsoba INT NOT NULL,
  PRIMARY KEY (kodBicikl),
  FOREIGN KEY (sifModel, sifProizvodjac) REFERENCES Model(sifModel, sifProizvodjac),
  FOREIGN KEY (sifOsoba) REFERENCES Vlasnik(sifOsoba)
);

CREATE TABLE RadniNalog
(
  datVrijemePrijem TIMESTAMP NOT NULL,
  datVrijemeZavrs TIMESTAMP NOT NULL,
  UkCijena NUMERIC (5,2),
  kodBicikl INT NOT NULL,
  PRIMARY KEY (datVrijemePrijem, kodBicikl),
  FOREIGN KEY (kodBicikl) REFERENCES Bicikl(kodBicikl),
  CONSTRAINT chkTrajanjeServis CHECK (datvrijemeprijem < datvrijemezavrs)
);

CREATE TABLE radi
(
  datVrijemePrijem TIMESTAMP NOT NULL,
  kodBicikl INT NOT NULL,
  sifRad INT NOT NULL,
  PRIMARY KEY (datVrijemePrijem, kodBicikl, sifRad),
  FOREIGN KEY (datVrijemePrijem, kodBicikl) REFERENCES RadniNalog(datVrijemePrijem, kodBicikl),
  FOREIGN KEY (sifRad) REFERENCES Rad(sifRad)
);

CREATE TABLE ugradjuje
(
  sifMat INT NOT NULL,
  datVrijemePrijem TIMESTAMP NOT NULL,
  kodBicikl INT NOT NULL,
  PRIMARY KEY (sifMat, datVrijemePrijem, kodBicikl),
  FOREIGN KEY (sifMat) REFERENCES Materijal(sifMat),
  FOREIGN KEY (datVrijemePrijem, kodBicikl) REFERENCES RadniNalog(datVrijemePrijem, kodBicikl)
);
