CREATE TABLE vrstaSamouprava
(
  sifVrsteSamoup INT NOT NULL,
  nazVrsteSamoup VARCHAR(200) NOT NULL,
  PRIMARY KEY (sifVrsteSamoup),
  UNIQUE (nazVrsteSamoup)
);

CREATE TABLE vrstaIzbora
(
  sifVrsIzbora VARCHAR(10) NOT NULL,
  nazVrsIzbora VARCHAR(200) NOT NULL,
  PRIMARY KEY (sifVrsIzbora)
);

CREATE TABLE listic
(
  sifListic INT NOT NULL,
  nazListic VARCHAR(200) NOT NULL,
  sifVrsIzbora VARCHAR(10) NOT NULL,
  PRIMARY KEY (sifListic),
  FOREIGN KEY (sifVrsIzbora) REFERENCES vrstaIzbora(sifVrsIzbora)
);

CREATE TABLE glasackiListic
(
  serijskiBroj INT NOT NULL,
  zaokRbrListe INT,
  skenListica BYTEA,
  sifListic INT NOT NULL,
  PRIMARY KEY (serijskiBroj, sifListic),
  FOREIGN KEY (sifListic) REFERENCES listic(sifListic)
);

CREATE TABLE samouprava
(
  sifSamouprava INT NOT NULL,
  nazSamouprava VARCHAR(200) NOT NULL,
  sifVrsteSamoup INT NOT NULL,
  nadSamouprava_sifSamouprava INT,
  PRIMARY KEY (sifSamouprava),
  FOREIGN KEY (sifVrsteSamoup) REFERENCES vrstaSamouprava(sifVrsteSamoup),
  FOREIGN KEY (nadSamouprava_sifSamouprava) REFERENCES samouprava(sifSamouprava),
  UNIQUE (nazSamouprava)
);

CREATE TABLE mjesto
(
  sifMjesto INT NOT NULL,
  nazMjesto VARCHAR(200) NOT NULL,
  pbrMjesto CHAR(5) NOT NULL,
  sifSamouprava INT NOT NULL,
  PRIMARY KEY (sifMjesto),
  FOREIGN KEY (sifSamouprava) REFERENCES samouprava(sifSamouprava)
);

CREATE TABLE birackoMjesto
(
  sifBirMjesto INT NOT NULL,
  nazBirMjesto VARCHAR(200) NOT NULL,
  sifMjesto INT NOT NULL,
  sifSamouprava INT NOT NULL,
  PRIMARY KEY (sifBirMjesto),
  FOREIGN KEY (sifMjesto) REFERENCES mjesto(sifMjesto),
  FOREIGN KEY (sifSamouprava) REFERENCES samouprava(sifSamouprava)
);

CREATE TABLE birac
(
  OIB CHAR(11) NOT NULL,
  ime VARCHAR(25) NOT NULL,
  prezime VARCHAR(25) NOT NULL,
  datRodjenja DATE NOT NULL,
  vrijDolaska TIME,
  sifBirMjesto INT NOT NULL,
  PRIMARY KEY (OIB),
  FOREIGN KEY (sifBirMjesto) REFERENCES birackoMjesto(sifBirMjesto),
  CONSTRAINT chkSatMinDolazak CHECK (EXTRACT(HOUR from vrijDolaska) BETWEEN 9 AND 19)
);

CREATE TABLE seDajeNa
(
  sifListic INT NOT NULL,
  sifBirMjesto INT NOT NULL,
  PRIMARY KEY (sifListic, sifBirMjesto),
  FOREIGN KEY (sifListic) REFERENCES listic(sifListic),
  FOREIGN KEY (sifBirMjesto) REFERENCES birackoMjesto(sifBirMjesto)
);