CREATE TABLE tipo_documento (
id INT(3) AUTO_INCREMENT,
nombre VARCHAR(50) NOT NULL,
PRIMARY KEY (id)
);

CREATE TABLE pais (
id INT(3) AUTO_INCREMENT,
nombre VARCHAR (30) NOT NULL,
codigo VARCHAR(2) NOT NULL,
PRIMARY KEY (id)
);

CREATE TABLE especie (
id INT AUTO_INCREMENT,
nombre_especie VARCHAR (30) NOT NULL,
nombre_comun VARCHAR (30) NULL,
nombre_ingles VARCHAR (30) NULL,
PRIMARY KEY (id)
);

CREATE TABLE metal (
id INT AUTO_INCREMENT,
nombre VARCHAR(50) NOT NULL,
PRIMARY KEY (id)
);

CREATE TABLE documento (
id INT(8) AUTO_INCREMENT,
tipo_documento_id INT NULL,
revista VARCHAR(50) NULL,
titulo VARCHAR(50) NOT NULL,
autores VARCHAR(100) NULL,
resumen VARCHAR(500) NULL,
ano_publicacion VARCHAR(20) NOT NULL,
ano VARCHAR(20) NULL,
termino_general VARCHAR (30) NULL,
descriptor VARCHAR (50) NULL,
termino_especifico VARCHAR (50) NULL,
palabra_clave VARCHAR (100) NULL,
link VARCHAR (1024) NULL,
fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
fecha_actualizacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
PRIMARY KEY (id),
FOREIGN KEY (tipo_documento_id) REFERENCES tipo_documento (id)
);

CREATE TABLE documento_concentracion_metal(
id INT(8) AUTO_INCREMENT,
documento_id INT(8) NOT NULL,
metal_id INT (8) NULL,
pais_id INT NULL,
lugar VARCHAR(100) NULL,
matriz VARCHAR(50) NULL,
especie_id INT(8) NULL,
longitud DECIMAL (11,8) DEFAULT NULL,
latitud DECIMAL (11,8) DEFAULT NULL,
minimo VARCHAR (15) DEFAULT NULL,
maximo VARCHAR (15) DEFAULT NULL,
unidad VARCHAR (15) DEFAULT NULL,
PRIMARY KEY (id),
FOREIGN KEY (documento_id) REFERENCES documento (id),
FOREIGN KEY (metal_id) REFERENCES metal (id),
FOREIGN KEY (pais_id) REFERENCES pais (id),
FOREIGN KEY (especie_id) REFERENCES especie (id)
);

CREATE TABLE usuario (
id INT(8) AUTO_INCREMENT,
nombre_usuario VARCHAR(30) NOT NULL,
nombres VARCHAR(50) NOT NULL,
apellidos VARCHAR(50) NOT NULL,
email VARCHAR(100) NOT NULL,
clave VARCHAR(255) NOT NULL,
estado TINYINT NOT NULL DEFAULT 1,
fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
fecha_actualizacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
PRIMARY KEY (id)
);


INSERT INTO tipo_documento (nombre) VALUES ('Artículo científico');
INSERT INTO tipo_documento (nombre) VALUES ('Documento técnico');
INSERT INTO tipo_documento (nombre) VALUES ('Tesis de grado');
INSERT INTO tipo_documento (nombre) VALUES ('Tesis de grado - Maestría');

INSERT INTO pais(nombre,codigo) VALUES('Antigua and Barbuda','AG');
INSERT INTO pais(nombre,codigo) VALUES('Argentina','AR');
INSERT INTO pais(nombre,codigo) VALUES('Armenia','AM');
INSERT INTO pais(nombre,codigo) VALUES('Aruba','AW');
INSERT INTO pais(nombre,codigo) VALUES('Australia','AU');
INSERT INTO pais(nombre,codigo) VALUES('Austria','AT');
INSERT INTO pais(nombre,codigo) VALUES('Azerbaijan','AZ');
INSERT INTO pais(nombre,codigo) VALUES('Bahrain','BH');
INSERT INTO pais(nombre,codigo) VALUES('Bahamas','BS');
INSERT INTO pais(nombre,codigo) VALUES('Bangladesh','BD');
INSERT INTO pais(nombre,codigo) VALUES('Barbados','BB');
INSERT INTO pais(nombre,codigo) VALUES('Belarus','BY');
INSERT INTO pais(nombre,codigo) VALUES('Belgium','BE');
INSERT INTO pais(nombre,codigo) VALUES('Belize','BZ');
INSERT INTO pais(nombre,codigo) VALUES('Benin','BJ');
INSERT INTO pais(nombre,codigo) VALUES('Bermuda','BM');
INSERT INTO pais(nombre,codigo) VALUES('Bhutan','BT');
INSERT INTO pais(nombre,codigo) VALUES('Bolivia, Plurinational State of','BO');
INSERT INTO pais(nombre,codigo) VALUES('Bonaire, Sint Eustatius and Saba','BQ');
INSERT INTO pais(nombre,codigo) VALUES('Bosnia and Herzegovina','BA');
INSERT INTO pais(nombre,codigo) VALUES('Botswana','BW');
INSERT INTO pais(nombre,codigo) VALUES('Bouvet Island','BV');
INSERT INTO pais(nombre,codigo) VALUES('Brazil','BR');
INSERT INTO pais(nombre,codigo) VALUES('British Indian Ocean Territory','IO');
INSERT INTO pais(nombre,codigo) VALUES('Brunei Darussalam','BN');
INSERT INTO pais(nombre,codigo) VALUES('Bulgaria','BG');
INSERT INTO pais(nombre,codigo) VALUES('Burkina Faso','BF');
INSERT INTO pais(nombre,codigo) VALUES('Burundi','BI');
INSERT INTO pais(nombre,codigo) VALUES('Cambodia','KH');
INSERT INTO pais(nombre,codigo) VALUES('Cameroon','CM');
INSERT INTO pais(nombre,codigo) VALUES('Canada','CA');
INSERT INTO pais(nombre,codigo) VALUES('Cape Verde','CV');
INSERT INTO pais(nombre,codigo) VALUES('Cayman Islands','KY');
INSERT INTO pais(nombre,codigo) VALUES('Central African Republic','CF');
INSERT INTO pais(nombre,codigo) VALUES('Chad','TD');
INSERT INTO pais(nombre,codigo) VALUES('Chile','CL');
INSERT INTO pais(nombre,codigo) VALUES('China','CN');
INSERT INTO pais(nombre,codigo) VALUES('Christmas Island','CX');
INSERT INTO pais(nombre,codigo) VALUES('Cocos (Keeling) Islands','CC');
INSERT INTO pais(nombre,codigo) VALUES('Colombia','CO');
INSERT INTO pais(nombre,codigo) VALUES('Comoros','KM');
INSERT INTO pais(nombre,codigo) VALUES('Congo','CG');
INSERT INTO pais(nombre,codigo) VALUES('Congo, the Democratic Republic of the','CD');
INSERT INTO pais(nombre,codigo) VALUES('Cook Islands','CK');
INSERT INTO pais(nombre,codigo) VALUES('Costa Rica','CR');
INSERT INTO pais(nombre,codigo) VALUES('Costa de Marfil','CI');
INSERT INTO pais(nombre,codigo) VALUES('Croatia','HR');
INSERT INTO pais(nombre,codigo) VALUES('Cuba','CU');
INSERT INTO pais(nombre,codigo) VALUES('Curaçao','CW');
INSERT INTO pais(nombre,codigo) VALUES('Cyprus','CY');
INSERT INTO pais(nombre,codigo) VALUES('Czech Republic','CZ');
INSERT INTO pais(nombre,codigo) VALUES('Denmark','DK');
INSERT INTO pais(nombre,codigo) VALUES('Djibouti','DJ');
INSERT INTO pais(nombre,codigo) VALUES('Dominica','DM');
INSERT INTO pais(nombre,codigo) VALUES('Dominican Republic','DO');
INSERT INTO pais(nombre,codigo) VALUES('Ecuador','EC');
INSERT INTO pais(nombre,codigo) VALUES('Egypt','EG');
INSERT INTO pais(nombre,codigo) VALUES('El Salvador','SV');
INSERT INTO pais(nombre,codigo) VALUES('Equatorial Guinea','GQ');
INSERT INTO pais(nombre,codigo) VALUES('Eritrea','ER');
INSERT INTO pais(nombre,codigo) VALUES('Estonia','EE');
INSERT INTO pais(nombre,codigo) VALUES('Ethiopia','ET');
INSERT INTO pais(nombre,codigo) VALUES('Falkland Islands (Malvinas)','FK');
INSERT INTO pais(nombre,codigo) VALUES('Faroe Islands','FO');
INSERT INTO pais(nombre,codigo) VALUES('Fiji','FJ');
INSERT INTO pais(nombre,codigo) VALUES('Finland','FI');
INSERT INTO pais(nombre,codigo) VALUES('France','FR');
INSERT INTO pais(nombre,codigo) VALUES('French Guiana','GF');
INSERT INTO pais(nombre,codigo) VALUES('French Polynesia','PF');
INSERT INTO pais(nombre,codigo) VALUES('French Southern Territories','TF');
INSERT INTO pais(nombre,codigo) VALUES('Gabon','GA');
INSERT INTO pais(nombre,codigo) VALUES('Gambia','GM');
INSERT INTO pais(nombre,codigo) VALUES('Georgia','GE');
INSERT INTO pais(nombre,codigo) VALUES('Germany','DE');
INSERT INTO pais(nombre,codigo) VALUES('Ghana','GH');
INSERT INTO pais(nombre,codigo) VALUES('Gibraltar','GI');
INSERT INTO pais(nombre,codigo) VALUES('Greece','GR');
INSERT INTO pais(nombre,codigo) VALUES('Greenland','GL');
INSERT INTO pais(nombre,codigo) VALUES('Grenada','GD');
INSERT INTO pais(nombre,codigo) VALUES('Guadeloupe','GP');
INSERT INTO pais(nombre,codigo) VALUES('Guam','GU');
INSERT INTO pais(nombre,codigo) VALUES('Guatemala','GT');
INSERT INTO pais(nombre,codigo) VALUES('Guernsey','GG');
INSERT INTO pais(nombre,codigo) VALUES('Guinea','GN');
INSERT INTO pais(nombre,codigo) VALUES('Guinea-Bissau','GW');
INSERT INTO pais(nombre,codigo) VALUES('Guyana','GY');
INSERT INTO pais(nombre,codigo) VALUES('Haiti','HT');
INSERT INTO pais(nombre,codigo) VALUES('Heard Island and McDonald Islands','HM');
INSERT INTO pais(nombre,codigo) VALUES('Holy See (Vatican City State)','VA');
INSERT INTO pais(nombre,codigo) VALUES('Honduras','HN');
INSERT INTO pais(nombre,codigo) VALUES('Hong Kong','HK');
INSERT INTO pais(nombre,codigo) VALUES('Hungary','HU');
INSERT INTO pais(nombre,codigo) VALUES('Iceland','IS');
INSERT INTO pais(nombre,codigo) VALUES('India','IN');
INSERT INTO pais(nombre,codigo) VALUES('Indonesia','ID');
INSERT INTO pais(nombre,codigo) VALUES('Iran, Islamic Republic of','IR');
INSERT INTO pais(nombre,codigo) VALUES('Iraq','IQ');
INSERT INTO pais(nombre,codigo) VALUES('Ireland','IE');
INSERT INTO pais(nombre,codigo) VALUES('Isle of Man','IM');
INSERT INTO pais(nombre,codigo) VALUES('Israel','IL');
INSERT INTO pais(nombre,codigo) VALUES('Italy','IT');
INSERT INTO pais(nombre,codigo) VALUES('Jamaica','JM');
INSERT INTO pais(nombre,codigo) VALUES('Japan','JP');
INSERT INTO pais(nombre,codigo) VALUES('Jersey','JE');
INSERT INTO pais(nombre,codigo) VALUES('Jordan','JO');
INSERT INTO pais(nombre,codigo) VALUES('Kazakhstan','KZ');
INSERT INTO pais(nombre,codigo) VALUES('Kenya','KE');
INSERT INTO pais(nombre,codigo) VALUES('Kiribati','KI');
INSERT INTO pais(nombre,codigo) VALUES('Korea, Democratic People''s Republic of','KP');
INSERT INTO pais(nombre,codigo) VALUES('Korea, Republic of','KR');
INSERT INTO pais(nombre,codigo) VALUES('Kuwait','KW');
INSERT INTO pais(nombre,codigo) VALUES('Kyrgyzstan','KG');
INSERT INTO pais(nombre,codigo) VALUES('Lao People''s Democratic Republic','LA');
INSERT INTO pais(nombre,codigo) VALUES('Latvia','LV');
INSERT INTO pais(nombre,codigo) VALUES('Lebanon','LB');
INSERT INTO pais(nombre,codigo) VALUES('Lesotho','LS');
INSERT INTO pais(nombre,codigo) VALUES('Liberia','LR');
INSERT INTO pais(nombre,codigo) VALUES('Libya','LY');
INSERT INTO pais(nombre,codigo) VALUES('Liechtenstein','LI');
INSERT INTO pais(nombre,codigo) VALUES('Lithuania','LT');
INSERT INTO pais(nombre,codigo) VALUES('Luxembourg','LU');
INSERT INTO pais(nombre,codigo) VALUES('Macao','MO');
INSERT INTO pais(nombre,codigo) VALUES('Macedonia, the Former Yugoslav Republic of','MK');
INSERT INTO pais(nombre,codigo) VALUES('Madagascar','MG');
INSERT INTO pais(nombre,codigo) VALUES('Malawi','MW');
INSERT INTO pais(nombre,codigo) VALUES('Malaysia','MY');
INSERT INTO pais(nombre,codigo) VALUES('Maldives','MV');
INSERT INTO pais(nombre,codigo) VALUES('Mali','ML');
INSERT INTO pais(nombre,codigo) VALUES('Malta','MT');
INSERT INTO pais(nombre,codigo) VALUES('Marshall Islands','MH');
INSERT INTO pais(nombre,codigo) VALUES('Martinique','MQ');
INSERT INTO pais(nombre,codigo) VALUES('Mauritania','MR');
INSERT INTO pais(nombre,codigo) VALUES('Mauritius','MU');
INSERT INTO pais(nombre,codigo) VALUES('Mayotte','YT');
INSERT INTO pais(nombre,codigo) VALUES('Mexico','MX');
INSERT INTO pais(nombre,codigo) VALUES('Micronesia, Federated States of','FM');
INSERT INTO pais(nombre,codigo) VALUES('Moldova, Republic of','MD');
INSERT INTO pais(nombre,codigo) VALUES('Monaco','MC');
INSERT INTO pais(nombre,codigo) VALUES('Mongolia','MN');
INSERT INTO pais(nombre,codigo) VALUES('Montenegro','ME');
INSERT INTO pais(nombre,codigo) VALUES('Montserrat','MS');
INSERT INTO pais(nombre,codigo) VALUES('Morocco','MA');
INSERT INTO pais(nombre,codigo) VALUES('Mozambique','MZ');
INSERT INTO pais(nombre,codigo) VALUES('Myanmar','MM');
INSERT INTO pais(nombre,codigo) VALUES('Namibia','NA');
INSERT INTO pais(nombre,codigo) VALUES('Nauru','NR');
INSERT INTO pais(nombre,codigo) VALUES('Nepal','NP');
INSERT INTO pais(nombre,codigo) VALUES('Netherlands','NL');
INSERT INTO pais(nombre,codigo) VALUES('New Caledonia','NC');
INSERT INTO pais(nombre,codigo) VALUES('New Zealand','NZ');
INSERT INTO pais(nombre,codigo) VALUES('Nicaragua','NI');
INSERT INTO pais(nombre,codigo) VALUES('Niger','NE');
INSERT INTO pais(nombre,codigo) VALUES('Nigeria','NG');
INSERT INTO pais(nombre,codigo) VALUES('Niue','NU');
INSERT INTO pais(nombre,codigo) VALUES('Norfolk Island','NF');
INSERT INTO pais(nombre,codigo) VALUES('Northern Mariana Islands','MP');
INSERT INTO pais(nombre,codigo) VALUES('Norway','NO');
INSERT INTO pais(nombre,codigo) VALUES('Oman','OM');
INSERT INTO pais(nombre,codigo) VALUES('Pakistan','PK');
INSERT INTO pais(nombre,codigo) VALUES('Palau','PW');
INSERT INTO pais(nombre,codigo) VALUES('Palestine, State of','PS');
INSERT INTO pais(nombre,codigo) VALUES('Panama','PA');
INSERT INTO pais(nombre,codigo) VALUES('Papua New Guinea','PG');
INSERT INTO pais(nombre,codigo) VALUES('Paraguay','PY');
INSERT INTO pais(nombre,codigo) VALUES('Peru','PE');
INSERT INTO pais(nombre,codigo) VALUES('Philippines','PH');
INSERT INTO pais(nombre,codigo) VALUES('Pitcairn','PN');
INSERT INTO pais(nombre,codigo) VALUES('Poland','PL');
INSERT INTO pais(nombre,codigo) VALUES('Portugal','PT');
INSERT INTO pais(nombre,codigo) VALUES('Puerto Rico','PR');
INSERT INTO pais(nombre,codigo) VALUES('Qatar','QA');
INSERT INTO pais(nombre,codigo) VALUES('Réunion','RE');
INSERT INTO pais(nombre,codigo) VALUES('Romania','RO');
INSERT INTO pais(nombre,codigo) VALUES('Russian Federation','RU');
INSERT INTO pais(nombre,codigo) VALUES('Rwanda','RW');
INSERT INTO pais(nombre,codigo) VALUES('Saint Barthélemy','BL');
INSERT INTO pais(nombre,codigo) VALUES('Saint Helena, Ascension and Tristan da Cunha','SH');
INSERT INTO pais(nombre,codigo) VALUES('Saint Kitts and Nevis','KN');
INSERT INTO pais(nombre,codigo) VALUES('Saint Lucia','LC');
INSERT INTO pais(nombre,codigo) VALUES('Saint Martin (French part)','MF');
INSERT INTO pais(nombre,codigo) VALUES('Saint Pierre and Miquelon','PM');
INSERT INTO pais(nombre,codigo) VALUES('Saint Vincent and the Grenadines','VC');
INSERT INTO pais(nombre,codigo) VALUES('Samoa','WS');
INSERT INTO pais(nombre,codigo) VALUES('San Marino','SM');
INSERT INTO pais(nombre,codigo) VALUES('Sao Tome and Principe','ST');
INSERT INTO pais(nombre,codigo) VALUES('Saudi Arabia','SA');
INSERT INTO pais(nombre,codigo) VALUES('Senegal','SN');
INSERT INTO pais(nombre,codigo) VALUES('Serbia','RS');
INSERT INTO pais(nombre,codigo) VALUES('Seychelles','SC');
INSERT INTO pais(nombre,codigo) VALUES('Sierra Leone','SL');
INSERT INTO pais(nombre,codigo) VALUES('Singapore','SG');
INSERT INTO pais(nombre,codigo) VALUES('Sint Maarten (Dutch part)','SX');
INSERT INTO pais(nombre,codigo) VALUES('Slovakia','SK');
INSERT INTO pais(nombre,codigo) VALUES('Slovenia','SI');
INSERT INTO pais(nombre,codigo) VALUES('Solomon Islands','SB');
INSERT INTO pais(nombre,codigo) VALUES('Somalia','SO');
INSERT INTO pais(nombre,codigo) VALUES('South Africa','ZA');
INSERT INTO pais(nombre,codigo) VALUES('South Georgia and the South Sandwich Islands','GS');
INSERT INTO pais(nombre,codigo) VALUES('South Sudan','SS');
INSERT INTO pais(nombre,codigo) VALUES('Spain','ES');
INSERT INTO pais(nombre,codigo) VALUES('Sri Lanka','LK');
INSERT INTO pais(nombre,codigo) VALUES('Sudan','SD');
INSERT INTO pais(nombre,codigo) VALUES('Suriname','SR');
INSERT INTO pais(nombre,codigo) VALUES('Svalbard and Jan Mayen','SJ');
INSERT INTO pais(nombre,codigo) VALUES('Swaziland','SZ');
INSERT INTO pais(nombre,codigo) VALUES('Sweden','SE');
INSERT INTO pais(nombre,codigo) VALUES('Switzerland','CH');
INSERT INTO pais(nombre,codigo) VALUES('Syrian Arab Republic','SY');
INSERT INTO pais(nombre,codigo) VALUES('Taiwan, Province of China','TW');
INSERT INTO pais(nombre,codigo) VALUES('Tajikistan','TJ');
INSERT INTO pais(nombre,codigo) VALUES('Tanzania, United Republic of','TZ');
INSERT INTO pais(nombre,codigo) VALUES('Thailand','TH');
INSERT INTO pais(nombre,codigo) VALUES('Timor-Leste','TL');
INSERT INTO pais(nombre,codigo) VALUES('Togo','TG');
INSERT INTO pais(nombre,codigo) VALUES('Tokelau','TK');
INSERT INTO pais(nombre,codigo) VALUES('Tonga','TO');
INSERT INTO pais(nombre,codigo) VALUES('Trinidad and Tobago','TT');
INSERT INTO pais(nombre,codigo) VALUES('Tunisia','TN');
INSERT INTO pais(nombre,codigo) VALUES('Turkey','TR');
INSERT INTO pais(nombre,codigo) VALUES('Turkmenistan','TM');
INSERT INTO pais(nombre,codigo) VALUES('Turks and Caicos Islands','TC');
INSERT INTO pais(nombre,codigo) VALUES('Tuvalu','TV');
INSERT INTO pais(nombre,codigo) VALUES('Uganda','UG');
INSERT INTO pais(nombre,codigo) VALUES('Ukraine','UA');
INSERT INTO pais(nombre,codigo) VALUES('United Arab Emirates','AE');
INSERT INTO pais(nombre,codigo) VALUES('United Kingdom','GB');
INSERT INTO pais(nombre,codigo) VALUES('United States','US');
INSERT INTO pais(nombre,codigo) VALUES('United States Minor Outlying Islands','UM');
INSERT INTO pais(nombre,codigo) VALUES('Uruguay','UY');
INSERT INTO pais(nombre,codigo) VALUES('Uzbekistan','UZ');
INSERT INTO pais(nombre,codigo) VALUES('Vanuatu','VU');
INSERT INTO pais(nombre,codigo) VALUES('Venezuela, Bolivarian Republic of','VE');
INSERT INTO pais(nombre,codigo) VALUES('Viet Nam','VN');
INSERT INTO pais(nombre,codigo) VALUES('Virgin Islands, British','VG');
INSERT INTO pais(nombre,codigo) VALUES('Virgin Islands, U.S.','VI');
INSERT INTO pais(nombre,codigo) VALUES('Wallis and Futuna','WF');
INSERT INTO pais(nombre,codigo) VALUES('Western Sahara','EH');
INSERT INTO pais(nombre,codigo) VALUES('Yemen','YE');
INSERT INTO pais(nombre,codigo) VALUES('Zambia','ZM');
INSERT INTO pais(nombre,codigo) VALUES('Zimbabwe','ZW');

INSERT INTO metal(nombre) VALUES('Antimonio');
INSERT INTO metal(nombre) VALUES('Arsenico');
INSERT INTO metal(nombre) VALUES('Bismuto');
INSERT INTO metal(nombre) VALUES('Cadmio');
INSERT INTO metal(nombre) VALUES('Cadmio ');
INSERT INTO metal(nombre) VALUES('Cobre');
INSERT INTO metal(nombre) VALUES('Cobre total');
INSERT INTO metal(nombre) VALUES('Cromo');
INSERT INTO metal(nombre) VALUES('Hierro');
INSERT INTO metal(nombre) VALUES('Hierro total');
INSERT INTO metal(nombre) VALUES('Manganeso');
INSERT INTO metal(nombre) VALUES('Mercurio');
INSERT INTO metal(nombre) VALUES('Mercurio Total');
INSERT INTO metal(nombre) VALUES('Metilmercurio');
INSERT INTO metal(nombre) VALUES('Niquel');
INSERT INTO metal(nombre) VALUES('Plata');
INSERT INTO metal(nombre) VALUES('Plomo');
INSERT INTO metal(nombre) VALUES('Plomo ');
INSERT INTO metal(nombre) VALUES('Vapor de mercurio');
INSERT INTO metal(nombre) VALUES('Zinc');

INSERT INTO especie (nombre_comun,nombre_especie,nombre_ingles) VALUES('Egretta thula ','Garceta Nevada','snowy egret');
INSERT INTO especie (nombre_comun,nombre_especie,nombre_ingles) VALUES('Homo sapiens sapiens','Humanos ','Human');
INSERT INTO especie (nombre_comun,nombre_especie,nombre_ingles) VALUES('Pangasius hypophthalmus','Panga','Striped catfish');
INSERT INTO especie (nombre_comun,nombre_especie,nombre_ingles) VALUES('Pseudoplatystoma fasciatum','Bagre Rayado','Barred sorubim');
INSERT INTO especie (nombre_comun,nombre_especie,nombre_ingles) VALUES('Pimelodus clarias maculatus','Barbul','Mandi');
INSERT INTO especie (nombre_comun,nombre_especie,nombre_ingles) VALUES('Curimata cerasina','Bocachico','');
INSERT INTO especie (nombre_comun,nombre_especie,nombre_ingles) VALUES('Aire','Aire','Air');
INSERT INTO especie (nombre_comun,nombre_especie,nombre_ingles) VALUES('Sedimentos','Sedimentos','Sediment');
INSERT INTO especie (nombre_comun,nombre_especie,nombre_ingles) VALUES('Eichhornia crassipes','Jacinto de Agua','');
INSERT INTO especie (nombre_comun,nombre_especie,nombre_ingles) VALUES('Prochilodus reticulatus magdalenae ','Bocachico','Magdalena River prochilodus');
INSERT INTO especie (nombre_comun,nombre_especie,nombre_ingles) VALUES('Prochilodus reticulatus magdalenae','Bocachico','Magdalena River prochilodus');
INSERT INTO especie (nombre_comun,nombre_especie,nombre_ingles) VALUES('Curimata mivartii','Cachava, Sardina, Vizcana','');
INSERT INTO especie (nombre_comun,nombre_especie,nombre_ingles) VALUES('Triportheus magdalenae ','Arenca','');
INSERT INTO especie (nombre_comun,nombre_especie,nombre_ingles) VALUES('Curimata magdalenae','Campaniz, Capaniza, Madre de Bocachico, Viejita','');
INSERT INTO especie (nombre_comun,nombre_especie,nombre_ingles) VALUES('Andinoacara pulcher ','Mojarra Azul','Blue acara');
INSERT INTO especie (nombre_comun,nombre_especie,nombre_ingles) VALUES('Caquetaia kraussii','Mojarra Anzuelera,Mojarra de río, Chancha, Bocón','');
INSERT INTO especie (nombre_comun,nombre_especie,nombre_ingles) VALUES('Hoplias malabaricus','Bululu, Dientón, Guabina, Mocho, Moncholo,  Perraloca, Rivolo','Trahira');
INSERT INTO especie (nombre_comun,nombre_especie,nombre_ingles) VALUES('Plagioscion surinamensis','','');
INSERT INTO especie (nombre_comun,nombre_especie,nombre_ingles) VALUES('Lixiviados','','');
INSERT INTO especie (nombre_comun,nombre_especie,nombre_ingles) VALUES('Callinectes sapidus - Callinectes bocourti','Cangrejo Azul, Jaiba azul','');
INSERT INTO especie (nombre_comun,nombre_especie,nombre_ingles) VALUES('Pimelodus sp.','Nicuro','Bloch''s catfish');
INSERT INTO especie (nombre_comun,nombre_especie,nombre_ingles) VALUES('Suelo','Suelo','Soil');
INSERT INTO especie (nombre_comun,nombre_especie,nombre_ingles) VALUES('Bos primigenius taurus','Carne de res','Meet');
INSERT INTO especie (nombre_comun,nombre_especie,nombre_ingles) VALUES('Agua','Agua','Water');
INSERT INTO especie (nombre_comun,nombre_especie,nombre_ingles) VALUES('Inia humlboldtiana','Delfin Rosado del Orinoco','pink river dolphin');
INSERT INTO especie (nombre_comun,nombre_especie,nombre_ingles) VALUES('Inia geoffrensis','Delfin Rosado del Amazonas','pink river dolphin');
INSERT INTO especie (nombre_comun,nombre_especie,nombre_ingles) VALUES('Oreochromis niloticus ','Tilapia del Nilo','Nile tilapia');
INSERT INTO especie (nombre_comun,nombre_especie,nombre_ingles) VALUES('Lactuca sativa','Lechuga "Coolguard"','Lettuce "Coolguard"');
INSERT INTO especie (nombre_comun,nombre_especie,nombre_ingles) VALUES('Apium graveolens','Apio "Tall Utah"','Celery "Tall Utah"');
INSERT INTO especie (nombre_comun,nombre_especie,nombre_ingles) VALUES('Brassica oleracea var. italica','Repollo híbrido Delus','Cabbage "Delus"');
INSERT INTO especie (nombre_comun,nombre_especie,nombre_ingles) VALUES('Sus scrofa domesticus','Carne de cerdo','Pig');
INSERT INTO especie (nombre_comun,nombre_especie,nombre_ingles) VALUES('Oreochromis aureus','Mojarra Roja','');
INSERT INTO especie (nombre_comun,nombre_especie,nombre_ingles) VALUES('Gallus gallus domesticus','Pollo, Gallina','Chicken');
INSERT INTO especie (nombre_comun,nombre_especie,nombre_ingles) VALUES('Material en suspensión','','');
INSERT INTO especie (nombre_comun,nombre_especie,nombre_ingles) VALUES('Crassostrea rhizophorae','Ostión de Manglar','');
INSERT INTO especie (nombre_comun,nombre_especie,nombre_ingles) VALUES('Isognomon alatus','Ostra plana','The flat tree oyster');
INSERT INTO especie (nombre_comun,nombre_especie,nombre_ingles) VALUES('Cathorops spixii','Chivo mapalé, Chivo mapale','Madamango sea catfish');
INSERT INTO especie (nombre_comun,nombre_especie,nombre_ingles) VALUES('Ariopsis bonillai','Chivo cabezón, Cazón','New Granada sea catfish');
INSERT INTO especie (nombre_comun,nombre_especie,nombre_ingles) VALUES('Rhandia wagne ','Barbudo','');
INSERT INTO especie (nombre_comun,nombre_especie,nombre_ingles) VALUES('Thunnus','Atun enlatado','Tuna');
INSERT INTO especie (nombre_comun,nombre_especie,nombre_ingles) VALUES('Mugil cephalus','Lisa rayada','Flathead grey mullet');
INSERT INTO especie (nombre_comun,nombre_especie,nombre_ingles) VALUES('Mugil incilis','Lisa, Zoquito','Parassi mullet');
INSERT INTO especie (nombre_comun,nombre_especie,nombre_ingles) VALUES('Triportheus magdalenae','Arenca','');
INSERT INTO especie (nombre_comun,nombre_especie,nombre_ingles) VALUES('Opisthonema oglinum','Machuelo, Sabodta','Atlantic thread herring');
INSERT INTO especie (nombre_comun,nombre_especie,nombre_ingles) VALUES('Sciades herzbergi','Bagre Guatero','Pemecou sea catfish');
INSERT INTO especie (nombre_comun,nombre_especie,nombre_ingles) VALUES('Gerres cinereus','Mojarra Blanca','Yellow fin mojarra');
INSERT INTO especie (nombre_comun,nombre_especie,nombre_ingles) VALUES('Eugerres plumieri','Mojarra de Salina, Mojarra Rayada','Striped mojarra');
INSERT INTO especie (nombre_comun,nombre_especie,nombre_ingles) VALUES('Haemulon steindachneri','Bocacolorá, Coroncoro, Ronco basto, Uachi','Chere-chere grunt');
INSERT INTO especie (nombre_comun,nombre_especie,nombre_ingles) VALUES('Archosargus rhomboidalis','Sargo amarillo','Western Atlantic seabream');
INSERT INTO especie (nombre_comun,nombre_especie,nombre_ingles) VALUES('Oligoplites saliens','Caspin, Macarela, Meona, Siete cueros, Zapatero','Castin leatherjacket');
INSERT INTO especie (nombre_comun,nombre_especie,nombre_ingles) VALUES('Dactylopterus volitans','Volador','Flying gurnard');
INSERT INTO especie (nombre_comun,nombre_especie,nombre_ingles) VALUES('Chloroscombrus chrysurus','Casabito, Dulcina, Espejo, Hojita, Panchita','Atlantic bumper');
INSERT INTO especie (nombre_comun,nombre_especie,nombre_ingles) VALUES('Cynoscion jamaicensis','Melito, Curvinatica, Corvineta salmón ','Jamaica weakfish');
INSERT INTO especie (nombre_comun,nombre_especie,nombre_ingles) VALUES('Caranx hippos','Jurel, Jurel aleta amarilla','Blue runner');
INSERT INTO especie (nombre_comun,nombre_especie,nombre_ingles) VALUES('Elops saurus','Macabi','Ladyfish');
INSERT INTO especie (nombre_comun,nombre_especie,nombre_ingles) VALUES('Lutjanus synagris','Pargo, Pargo Chino, Pargo rayado, Pargo rayao','Lane snapper');
INSERT INTO especie (nombre_comun,nombre_especie,nombre_ingles) VALUES('Centropomus undecimalis','Robalo, Robalo carita larga','Common snook');
INSERT INTO especie (nombre_comun,nombre_especie,nombre_ingles) VALUES('Trichiurus lepturus','Correa, Sable','Largehead hairtail');
INSERT INTO especie (nombre_comun,nombre_especie,nombre_ingles) VALUES('Caquetaia kraussi','Mojarra Amarilla','False Basketmouth');
INSERT INTO especie (nombre_comun,nombre_especie,nombre_ingles) VALUES('Leporinus muyscorum','Sardina','');
INSERT INTO especie (nombre_comun,nombre_especie,nombre_ingles) VALUES('Sorubim cuspicaudus','Bagre Blanquillo, Bagre Blanco','Trans-Andean shovelnose catfish');
INSERT INTO especie (nombre_comun,nombre_especie,nombre_ingles) VALUES('Plasgioscion surinamensis','','');
INSERT INTO especie (nombre_comun,nombre_especie,nombre_ingles) VALUES('Eremophilus mutisii ','Capitán de la Sabana','');
INSERT INTO especie (nombre_comun,nombre_especie,nombre_ingles) VALUES('Pseudoplatystoma orinocoense ','Bagre, Surubi','');
INSERT INTO especie (nombre_comun,nombre_especie,nombre_ingles) VALUES('Pimelodus grosskopfii  ','Capaz','');
INSERT INTO especie (nombre_comun,nombre_especie,nombre_ingles) VALUES('Oryza sativa','Arroz','Rice');
INSERT INTO especie (nombre_comun,nombre_especie,nombre_ingles) VALUES('Sus scrofa domesticus ','Carne de cerdo','Pig');
INSERT INTO especie (nombre_comun,nombre_especie,nombre_ingles) VALUES('Ageneiosus pardalis','Doncella','');
INSERT INTO especie (nombre_comun,nombre_especie,nombre_ingles) VALUES('Anas platyrhynchos domesticus ','Pato','Duck');
INSERT INTO especie (nombre_comun,nombre_especie,nombre_ingles) VALUES('Myleus sp','Viejito','');
INSERT INTO especie (nombre_comun,nombre_especie,nombre_ingles) VALUES('Barbus sp ','Barbudo','');
INSERT INTO especie (nombre_comun,nombre_especie,nombre_ingles) VALUES('Oryza sativa ','Arroz','Rice');
INSERT INTO especie (nombre_comun,nombre_especie,nombre_ingles) VALUES('Diplodus sp','Mojarra Lora','');
INSERT INTO especie (nombre_comun,nombre_especie,nombre_ingles) VALUES('Cynopotamus magdalenae','Chango','');
INSERT INTO especie (nombre_comun,nombre_especie,nombre_ingles) VALUES('Gallus gallus domesticus ','Pollo, Gallina','Chicken');
INSERT INTO especie (nombre_comun,nombre_especie,nombre_ingles) VALUES('Lebiasina bimaculata','Guavina','Twospot lebiasina');
INSERT INTO especie (nombre_comun,nombre_especie,nombre_ingles) VALUES('Trachyliopterus insignis','Tapa olla ','');
INSERT INTO especie (nombre_comun,nombre_especie,nombre_ingles) VALUES('Pseudoplatystoma sp ','Doncella','');
INSERT INTO especie (nombre_comun,nombre_especie,nombre_ingles) VALUES('Plagioscion sp ','Pacora','');
INSERT INTO especie (nombre_comun,nombre_especie,nombre_ingles) VALUES('Sedimentos ','Sedimentos','Sediment');
INSERT INTO especie (nombre_comun,nombre_especie,nombre_ingles) VALUES('Pseudoplatystoma sp','Doncella','');
INSERT INTO especie (nombre_comun,nombre_especie,nombre_ingles) VALUES('Anas platyrhynchos domesticus','Pato','Duck');
INSERT INTO especie (nombre_comun,nombre_especie,nombre_ingles) VALUES('Barbus sp','Barbudo','');
INSERT INTO especie (nombre_comun,nombre_especie,nombre_ingles) VALUES('Plagioscion sp','Pacora','');
INSERT INTO especie (nombre_comun,nombre_especie,nombre_ingles) VALUES('Agua ','Agua','Water');
INSERT INTO especie (nombre_comun,nombre_especie,nombre_ingles) VALUES('Trichogaster pectoralis','Barbona','');
INSERT INTO especie (nombre_comun,nombre_especie,nombre_ingles) VALUES('Diplodus sp ','Mojarra Lora','');
INSERT INTO especie (nombre_comun,nombre_especie,nombre_ingles) VALUES('Dendrocygna sp','Pisingo','Duck');
INSERT INTO especie (nombre_comun,nombre_especie,nombre_ingles) VALUES('Myleus sp ','Viejito','');
INSERT INTO especie (nombre_comun,nombre_especie,nombre_ingles) VALUES('Pollo','Gallus ','');
INSERT INTO especie (nombre_comun,nombre_especie,nombre_ingles) VALUES(' Myleus sp ','Viejito','');
