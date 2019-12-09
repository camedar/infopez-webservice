<?php
defined('BASEPATH') OR exit('No direct script access allowed');

use PhpOffice\PhpSpreadsheet\IOFactory;

class Webservice extends MX_Controller {

    function __construct() {
        parent::__construct();
        $this->load->helper('path');
        $this->load->helper('url');
    }

    public function remplazarCharEspeciales($texto) {
    	return str_replace( 
    		array("á","é","í","ó","ú","ñ","Á","É","Í","Ó","Ú","Ñ"," "), 
    		"%", 
    		$texto);
    }

    public function convertirCoordenadas($texto) {
    	$negativo = false;
    	// 10°21'54''N
    	// 75°06'58"O
    	// 75°35′57″O
    	$texto_ = str_replace( array("''",'"', '″'), ":",$texto);
    	$texto_ = str_replace( array("°","'"), ":", $texto_);
    	$coordenadaselemsArr = explode( ":", $texto_);
    	
    	if($coordenadaselemsArr[3] == 'O' || $coordenadaselemsArr[3] == 'S') {
    		$negativo = true;
    	}

    	$coordenadaReal = ( ( ( floatval($coordenadaselemsArr[2]) / 60 ) + floatval($coordenadaselemsArr[1]) ) / 60 ) + floatval($coordenadaselemsArr[0]);

    	if($negativo){
    		$coordenadaReal *= -1;
    	}

    	return $coordenadaReal;

    }

    public function carga_archivo() {
    	$this->load->model(array("Documento", "TipoDocumento", "DocumentoConcentracionMetal", "Pais", "Especie", "Metal"));
    	$nombre_archivo = $this->uri->segment(3);
        $inputFileName = 'assets/documentos/' . $nombre_archivo;
		//$helper->log('Loading file ' . pathinfo($inputFileName, PATHINFO_BASENAME) . ' using IOFactory to identify the format');
		$spreadsheet = IOFactory::load($inputFileName);
		$sheetData = $spreadsheet->getActiveSheet()->toArray(null, true, true, true);
		$i = 0;
		$titulos = true;
		foreach ($sheetData as $key => $fila) {
			if($titulos){
				$titulos = false;
				continue;
			}
			// Genera Id de la tabla metal
			$buscarMetal = $this->Metal->obtenerId($fila['Q']);
			$idMetal = 0;
			if(sizeof($buscarMetal) > 0){
				$idMetal = $buscarMetal[0]['id'];
			} else {
				$idMetal = $this->Metal->insertar(
					array(
						"nombre" => $fila['Q']
					)
				);
			}
			// Genera id de la tabla especie
			$buscarEspecie = $this->Especie->obtenerId($fila['N']);
			$idEspecie = 0;
			if(sizeof($buscarEspecie) > 0){
				$idEspecie = $buscarEspecie[0]['id'];
			} else {
				$idEspecie = $this->Especie->insertar(
					array(
						"nombre_especie" => $fila['N'],
						"nombre_comun" => $fila['O'],
						"nombre_ingles" => $fila['P'],
					)
				);
			}

			// Genera id de la tabla pais
			$buscarPais = $this->Pais->obtenerId($this->remplazarCharEspeciales($fila['H']));
			$idPais = sizeof($buscarPais)>0?$buscarPais[0]['id']:null;

			// Genera Id de Tipo de documento
			$buscarTipoDoc = $this->TipoDocumento->obtenerId($this->remplazarCharEspeciales($fila['B']));
			$tipoDocumentoId = 0;
			if(sizeof($buscarTipoDoc) > 0){
				$tipoDocumentoId = $buscarTipoDoc[0]['id'];
			} else {
				$tipoDocumentoId = $this->TipoDocumento->insertar(
					array(
						"nombre" => $fila['B']
					)
				);
			}

			// insertar en table documento
			$datos = array();
			$datos['tipo_documento_id'] = $tipoDocumentoId;
			$datos['revista'] = $fila['C'];
			$datos['titulo']  = $fila['D'];
			$datos['autores'] = $fila['E'];
			$datos['resumen'] = $fila['F'];
			$datos['ano_publicacion'] = $fila['G'];
			$datos['ano'] = $fila['I'];
			$datos['termino_general'] = $fila['U'];
			$datos['descriptor'] = $fila['V'];
			$datos['termino_especifico'] = $fila['W'];
			$datos['palabra_clave'] = $fila['X'];
			$datos['link'] = $fila['Y'];

			$documento_id = $this->Documento->insertar( $datos);

			$datos = array();
			$longitud = $this->convertirCoordenadas($fila['L']);
			$latitud = $this->convertirCoordenadas($fila['K']);
			$datos['documento_id'] = $documento_id;
			$datos['metal_id'] = $idMetal;
			$datos['pais_id'] = $idPais;
			$datos['lugar'] = $fila['J'];
			$datos['matriz'] = $fila['M'];
			$datos['especie_id'] = $idEspecie;
			$datos['longitud'] = $longitud;
			$datos['latitud'] = $latitud;
			$datos['minimo'] = $fila['R'];
			$datos['maximo'] = $fila['S'];
			$datos['unidad'] = $fila['T'];

			$documentoConcentracionMetalID = $this->DocumentoConcentracionMetal->insertar( $datos);
		}

		
    }
} 