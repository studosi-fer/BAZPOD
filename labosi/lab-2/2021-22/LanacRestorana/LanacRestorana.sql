CREATE TABLE JeloSastojak
(
  sifJeloSastojak INT NOT NULL,
  nazivJeloSastojak VARCHAR(100) NOT NULL,
  PRIMARY KEY (sifJeloSastojak)
);

CREATE TABLE KorakKuhanja
(
  rbrKoraka INT NOT NULL,
  opis VARCHAR(200) NOT NULL,
  sifJeloSastojak INT NOT NULL,
  PRIMARY KEY (rbrKoraka, sifJeloSastojak),
  FOREIGN KEY (sifJeloSastojak) REFERENCES JeloSastojak(sifJeloSastojak)
);

CREATE TABLE sadrzi
(
  kolicina NUMERIC(6,1) NOT NULL,
  jedinicaMjere VARCHAR(20) NOT NULL,
  sifJeloSastojak INT NOT NULL,
  sadrzisifJeloSastojak INT NOT NULL,
  PRIMARY KEY (sifJeloSastojak, sadrzisifJeloSastojak),
  FOREIGN KEY (sifJeloSastojak) REFERENCES JeloSastojak(sifJeloSastojak),
  FOREIGN KEY (sadrzisifJeloSastojak) REFERENCES JeloSastojak(sifJeloSastojak)
);

CREATE TABLE Restoran
(
  sifRestoran INT NOT NULL,
  nazivUlica VARCHAR(100) NOT NULL,
  nazivRestoran VARCHAR(100) NOT NULL,
  kucniBroj VARCHAR(20) NOT NULL,
  brojStolaca INT NOT NULL,
  chef CHAR(11) NOT NULL,
  PRIMARY KEY (sifRestoran),
  FOREIGN KEY (chef) REFERENCES Kuhar(OIB),
  UNIQUE (nazivRestoran),
  CONSTRAINT chkStolaca CHECK (brojStolaca>4)
);

CREATE TABLE Kuhar
(
  OIB CHAR(11) NOT NULL,
  ime VARCHAR(25) NOT NULL,
  prezime VARCHAR(25) NOT NULL,
  strucnaSprema VARCHAR(20) NOT NULL,
  zavrsioKuhSkolu CHAR(1) NOT NULL,
  sifRestoran INT NOT NULL,
  mentor_OIB CHAR(11),
  PRIMARY KEY (OIB),
  FOREIGN KEY (sifRestoran) REFERENCES Restoran(sifRestoran),
  FOREIGN KEY (mentor_OIB) REFERENCES Kuhar(OIB)
);

CREATE TABLE Jelovnik
(
  datumVrijediOd DATE NOT NULL,
  datumVrijediDo DATE,
  sifRestoran INT NOT NULL,
  PRIMARY KEY (datumVrijediOd, sifRestoran),
  FOREIGN KEY (sifRestoran) REFERENCES Restoran(sifRestoran)
);

CREATE TABLE znaKuhati
(
  OIB CHAR(11) NOT NULL,
  sifJeloSastojak INT NOT NULL,
  PRIMARY KEY (OIB, sifJeloSastojak),
  FOREIGN KEY (OIB) REFERENCES Kuhar(OIB),
  FOREIGN KEY (sifJeloSastojak) REFERENCES JeloSastojak(sifJeloSastojak)
);

CREATE TABLE sadrziJela
(
  datumVrijediOd DATE NOT NULL,
  sifRestoran INT NOT NULL,
  sifJeloSastojak INT NOT NULL,
  PRIMARY KEY (datumVrijediOd, sifRestoran, sifJeloSastojak),
  FOREIGN KEY (datumVrijediOd, sifRestoran) REFERENCES Jelovnik(datumVrijediOd, sifRestoran),
  FOREIGN KEY (sifJeloSastojak) REFERENCES JeloSastojak(sifJeloSastojak)
);


