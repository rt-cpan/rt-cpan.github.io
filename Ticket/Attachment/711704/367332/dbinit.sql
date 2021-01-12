DROP TABLE IF EXISTS countries;
CREATE TABLE countries (
  country_id int NOT NULL auto_increment,
  iso_alpha2_code varchar(2) NOT NULL,
  name_en varchar(255) NOT NULL default 'english name',
  name_ru varchar(255) NOT NULL default 'русское название',
  name_de varchar(255) NOT NULL default 'de_name',
  PRIMARY KEY (country_id),
  KEY idx_iso_code (iso_alpha2_code)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE utf8_general_ci;


INSERT INTO countries (iso_alpha2_code, name_de, name_en, name_ru) VALUES ('AC','Ascension Island','Inseln Ascension','Остров Вознесения');
INSERT INTO countries (iso_alpha2_code, name_de, name_en, name_ru) VALUES ('HT','Haïti','Haiti','Гаити');
INSERT INTO countries (iso_alpha2_code, name_de, name_en, name_ru) VALUES ('ZA','Südafrika','South Africa','Южная Африка');
