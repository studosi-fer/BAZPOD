CREATE TABLE VrstaJedinice
(
  sifVrJedinica INT NOT NULL,
  nazVrJedinica VARCHAR(200) NOT NULL,
  PRIMARY KEY (sifVrJedinica),
  UNIQUE (nazVrJedinica)
);

CREATE TABLE IzbPovjerenstvo
(
  sifIP INT NOT NULL,
  datImenovanje DATE NOT NULL,
  PRIMARY KEY (sifIP)
);

CREATE TABLE VrClan
(
  sifVrClan VARCHAR(5) NOT NULL,
  nazVrClan VARCHAR(25) NOT NULL,
  PRIMARY KEY (sifVrClan)
);

CREATE TABLE Jedinica
(
  sifJedinica INT NOT NULL,
  NazJedinica VARCHAR(200) NOT NULL,
  sifVrJedinica INT NOT NULL,
  sifIP INT NOT NULL,
  NadJed_sifJedinica INT,
  PRIMARY KEY (sifJedinica),
  FOREIGN KEY (sifVrJedinica) REFERENCES VrstaJedinice(sifVrJedinica),
  FOREIGN KEY (sifIP) REFERENCES IzbPovjerenstvo(sifIP),
  FOREIGN KEY (NadJed_sifJedinica) REFERENCES Jedinica(sifJedinica),
  UNIQUE (NazJedinica)
);

CREATE TABLE Mjesto
(
  sifMjesto INT NOT NULL,
  postBroj INT NOT NULL CONSTRAINT chkPostBrojIP CHECK (postBroj >= 10000 AND postBroj <= 54000),
  nazMjesto VARCHAR(50) NOT NULL,
  sifJedinica INT NOT NULL,
  PRIMARY KEY (sifMjesto),
  FOREIGN KEY (sifJedinica) REFERENCES Jedinica(sifJedinica)
);

CREATE TABLE Stranka
(
  kratStranka VARCHAR(25) NOT NULL,
  nazStranka VARCHAR(200) NOT NULL,
  sifMjesto INT NOT NULL,
  PRIMARY KEY (kratStranka),
  FOREIGN KEY (sifMjesto) REFERENCES Mjesto(sifMjesto),
  UNIQUE (nazStranka)
);

CREATE TABLE Osoba
(
  OIB CHAR(11) NOT NULL,
  ime VARCHAR(25) NOT NULL,
  prezime VARCHAR(25) NOT NULL,
  datRodjenja DATE NOT NULL,
  kratStranka VARCHAR(25),
  sifIP INT NOT NULL,
  sifMjesto INT NOT NULL,
  sifVrClan VARCHAR(5) NOT NULL,
  PRIMARY KEY (OIB),
  FOREIGN KEY (kratStranka) REFERENCES Stranka(kratStranka),
  FOREIGN KEY (sifIP) REFERENCES IzbPovjerenstvo(sifIP),
  FOREIGN KEY (sifMjesto) REFERENCES Mjesto(sifMjesto),
  FOREIGN KEY (sifVrClan) REFERENCES VrClan(sifVrClan)
);

CREATE TABLE Naknada
(
  datRjesenje DATE NOT NULL,
  iznosNaknada INT NOT NULL,
  OIB CHAR(11) NOT NULL,
  PRIMARY KEY (datRjesenje, OIB),
  FOREIGN KEY (OIB) REFERENCES Osoba(OIB)
);

CREATE TABLE djeluje
(
  vlada_oporba INT NOT NULL,
  sifJedinica INT NOT NULL,
  kratStranka VARCHAR(25) NOT NULL,
  PRIMARY KEY (sifJedinica, kratStranka),
  FOREIGN KEY (sifJedinica) REFERENCES Jedinica(sifJedinica),
  FOREIGN KEY (kratStranka) REFERENCES Stranka(kratStranka)
);

