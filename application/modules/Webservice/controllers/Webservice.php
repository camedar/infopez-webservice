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

    public function convertirCoordenadas($CoordArr) {
    	$negativo = false;
    	$grados = floatval($CoordArr[0]);
    	$minutos = floatval($CoordArr[1]);
    	$segundos = floatval($CoordArr[2]);
    	$sentido = $CoordArr[3];

    	if($sentido == 'O' || $sentido == 'S') {
    		$negativo = true;
    	}

    	$coordenadaReal = ( ( ( $segundos / 60 ) + $minutos ) / 60 ) + $grados;

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
		$idDoc= "";
		foreach ($sheetData as $key => $fila) {
			if($titulos){
				$titulos = false;
				continue;
			}
			// Genera Id de la tabla metal
			$buscarMetal = $this->Metal->obtenerId($fila['W']);
			$idMetal = 0;
			if(sizeof($buscarMetal) > 0){
				$idMetal = $buscarMetal[0]['id'];
			} else {
				$idMetal = $this->Metal->insertar(
					array(
						"nombre" => $fila['W']
					)
				);
			}
			// Genera id de la tabla especie
			$buscarEspecie = $this->Especie->obtenerId($fila['T']);
			$idEspecie = 0;
			if(sizeof($buscarEspecie) > 0){
				$idEspecie = $buscarEspecie[0]['id'];
			} else {
				if($fila['T'] != "") {
					$idEspecie = $this->Especie->insertar(
						array(
							"nombre_especie" => $fila['T'],
							"nombre_comun" => $fila['U'],
							"nombre_ingles" => $fila['V'],
							"minimo" => utf8_encode($fila['X']),
							"maximo" => utf8_encode($fila['Y']),
							"unidad" => utf8_encode($fila['Z']),
						)
					);
				} else {
					$idEspecie = null;
				}
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

			if($idDoc != $fila['A']){
				$idDoc = $fila['A'];
				// insertar en table documento
				$datos = array();
				$datos['tipo_documento_id'] = $tipoDocumentoId;
				$datos['revista'] = $fila['C'];
				$datos['titulo']  = $fila['D'];
				$datos['autores'] = $fila['E'];
				$datos['resumen'] = $fila['F'];
				$datos['ano_publicacion'] = $fila['G'];
				$datos['ano'] = ($fila['I']);
				$datos['termino_general'] = $fila['AA'];
				$datos['descriptor'] = $fila['AB'];
				$datos['termino_especifico'] = $fila['AC'];
				$datos['palabra_clave'] = $fila['AD'];
				$datos['link'] = $fila['AE'];
				$datos['referencia'] = $fila['AF'];

				$documento_id = $this->Documento->insertar( $datos);
			}

			$datos = array();
			$longitud = $this->convertirCoordenadas(
				array( $fila['K'], $fila['L'], $fila['M'], $fila['N'])
			);
			$latitud = $this->convertirCoordenadas(
				array( $fila['O'], $fila['P'], $fila['Q'], $fila['R'])
			);
			$datos['documento_id'] = $documento_id;
			$datos['metal_id'] = $idMetal;
			$datos['pais_id'] = $idPais;
			$datos['lugar'] = $fila['J'];
			$datos['matriz'] = $fila['S'];
			$datos['especie_id'] = $idEspecie;
			$datos['longitud'] = $longitud;
			$datos['latitud'] = $latitud;

			$documentoConcentracionMetalID = $this->DocumentoConcentracionMetal->insertar( $datos);
		}
    }

    /**
     * /tesauro/termino_general/[letra_inicio_palabra]
     * /tesauro/descriptor/[termino_general]
  	 * 
     */
    public function tesauro() {
    	$this->load->model("Documento");
		$servicio = $this->uri->segment(3);

    	if($servicio === "termino_general") {
    		$letraInicio = $this->uri->segment(4);
    		$letraInicio = $letraInicio!=""?array($letraInicio):null;
    		$terminosGeneralesArr = $this->Documento->listarTerminoGeneral( null, $letraInicio);
    		echo json_encode($terminosGeneralesArr);
    	} else if($servicio === "descriptor") {
    		$filtro = $this->uri->segment(4);
    		$terminosGeneralesArr = $this->Documento->obtenerDescriptorDeTermGeneral($filtro);
    		echo json_encode($terminosGeneralesArr);
    	} else if($servicio === "documento") {
    		$filtro = $this->uri->segment(4);
    		$terminosGeneralesArr = $this->Documento->obtenerDocsDeDescriptor($filtro);
    		echo json_encode($terminosGeneralesArr);
    	}
    }

    public function calculadora() {
    	$this->load->model("MetalDosisRefOral");
    	$servicio = $this->uri->segment(3);
    	if($servicio === "traer_metales_dosis_ref_oral") {
    		$metalesDosisRefOral = $this->MetalDosisRefOral->listarMetalesDosis();
    		echo json_encode($metalesDosisRefOral);
    	} else if($servicio === "hacer_calculo") {
    		$id = 1;
    		
    		$requestData = json_decode(file_get_contents('php://input'), true);
    		$peso = $requestData['peso'];
    		$edad = $requestData['edad'];
    		$frecuencia = $requestData['frecuencia'];
    		$consumo = $requestData['consumo'];
    		$metalId = $requestData['metal'];
    		$metalesDosisRefOral = "";
    		if($metalId){
    			$metalesDosisRefOral = $this->MetalDosisRefOral->consultarMetalDosis($metalId);
    			$EF = 52.143 * $frecuencia;
    			$ED = $edad;
    			$FIR = $consumo / 1000;
    			$RFD = $metalesDosisRefOral['RFD'];
    			$BW = $peso;
    			$AT = $EF * $ED;
    		}

    		echo json_encode("1089");
    	}
    }
} 