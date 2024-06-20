/*
DROP TABLE IMENOVANJE;
DROP TABLE OSOBATERMIN;
DROP TABLE TERMIN;
DROP TABLE osoba;
DROP TABLE birackomjesto;
DROP TABLE naselje;
DROP TABLE jedinica;
DROP TABLE vrjedinica;
DROP TABLE funkcija;
*/

CREATE TABLE VRJEDINICA
(
  sifVrJedinica INT NOT NULL,
  nazVrJedinica VARCHAR(200) NOT NULL,
  PRIMARY KEY (sifVrJedinica),
  UNIQUE (nazVrJedinica)
);

CREATE TABLE FUNKCIJA
(
  sifFun INT NOT NULL,
  nazFun VARCHAR(25) NOT NULL,
  PRIMARY KEY (sifFun),
  UNIQUE (nazFun)
);

CREATE TABLE JEDINICA
(
  sifJedinica INT NOT NULL,
  nazJedinica VARCHAR(200) NOT NULL,
  sifVrJedinica INT NOT NULL,
  nadJed_sifJedinica INT,
  PRIMARY KEY (sifJedinica),
  FOREIGN KEY (sifVrJedinica) REFERENCES VRJEDINICA(sifVrJedinica),
  FOREIGN KEY (nadJed_sifJedinica) REFERENCES JEDINICA(sifJedinica),
  UNIQUE (nazJedinica)
);


CREATE TABLE NASELJE
(
  sifNaselje INT NOT NULL,
  nazNaselje VARCHAR(100) NOT NULL,
  postOzn INT NOT NULL,
  sifJedinica INT NOT NULL,
  PRIMARY KEY (sifNaselje),
  FOREIGN KEY (sifJedinica) REFERENCES JEDINICA(sifJedinica)
);

CREATE TABLE BIRACKOMJESTO
(
  sifBM INT NOT NULL,
  nazBM VARCHAR(200) NOT NULL,
  sifJedinica INT NOT NULL,
  sifNaselje INT NOT NULL,
  PRIMARY KEY (sifBM),
  FOREIGN KEY (sifJedinica) REFERENCES JEDINICA(sifJedinica),
  FOREIGN KEY (sifNaselje) REFERENCES NASELJE(sifNaselje)
);

CREATE TABLE OSOBA
(
  OIB CHAR(11) NOT NULL,
  ime VARCHAR(25) NOT NULL,
  prezime VARCHAR(25) NOT NULL,
  sifNaselje INT NOT NULL,
  PRIMARY KEY (OIB),
  FOREIGN KEY (sifNaselje) REFERENCES NASELJE(sifNaselje)
);
CREATE TABLE IMENOVANJE
(
  brImenovanje INT NOT NULL,
  datImenovanje DATE NOT NULL,
  sifBM INT NOT NULL,
  sifFun INT NOT NULL,
  OIB CHAR(11) NOT NULL,
  PRIMARY KEY (brImenovanje),
  FOREIGN KEY (sifBM) REFERENCES BIRACKOMJESTO(sifBM),
  FOREIGN KEY (sifFun) REFERENCES FUNKCIJA(sifFun),
  FOREIGN KEY (OIB) REFERENCES OSOBA(OIB),
  CONSTRAINT osobaBmSamoJednom UNIQUE(sifBM, OIB) 
);

CREATE TABLE TERMIN
(
  satMinPocetak TIME NOT NULL,
  satMinKraj TIME NOT NULL,
  sifBM INT NOT NULL,
  PRIMARY KEY (satMinPocetak, sifBM),
  FOREIGN KEY (sifBM) REFERENCES BIRACKOMJESTO(sifBM),
  CONSTRAINT uniqueTermin UNIQUE(satMinKraj, sifBM),
  CONSTRAINT chkSatMinPocetakKraj CHECK (satMinPocetak < satMinKraj AND 
  satMinPocetak BETWEEN '07:00'::TIME and '19:00'::TIME AND
  satMinKraj    BETWEEN '07:00'::TIME and '19:00'::TIME  )
);

CREATE TABLE osobaTermin
(
  satMinPocetak TIME NOT NULL,
  sifBM INT NOT NULL,
  OIB CHAR(11) NOT NULL,
  PRIMARY KEY (satMinPocetak, sifBM, OIB),
  FOREIGN KEY (satMinPocetak, sifBM) REFERENCES TERMIN(satMinPocetak, sifBM),
  FOREIGN KEY (OIB) REFERENCES OSOBA(OIB)
);