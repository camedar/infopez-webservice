<?php
defined('BASEPATH') OR exit('No direct script access allowed');

use PhpOffice\PhpSpreadsheet\IOFactory;

class Webservice extends MX_Controller {

	var $nroRegistrosPorPagina = 20;

    function __construct() {
        parent::__construct();
        $this->load->helper('path');
        $this->load->helper('url');
    }

    public function obtenerIdxPrimerRegistro($pagina){
    	return ($pagina-1) * $this->nroRegistrosPorPagina;
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
        set_time_limit(500);
    	error_reporting(E_ALL & ~E_NOTICE & ~E_WARNING);
    	$this->load->model(array("Documento", "TipoDocumento", "DocumentoConcentracionMetal", "Pais", "Especie", "Metal"));
        // Limpiar tablas
        $this->DocumentoConcentracionMetal->limpiarTabla();
        $this->Documento->limpiarTabla();
        $this->Metal->limpiarTabla();
        $this->Especie->limpiarTabla();
        // Carga de archivo
    	$rutaDir = "assets/documentos/";
    	$archivo = $_FILES['file']['name'];
    	$mimeType = mime_content_type($_FILES['file']['tmp_name']);
    	$ext = pathinfo( $archivo, PATHINFO_EXTENSION);
    	$nombrArchivoStr = date('YmdHis') . "." . $ext;
    	$archivoRuta = $rutaDir . $nombrArchivoStr;//basename( $archivo);
//    	if($mimeType !== "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" && $mimeType !== "application/vnd.ms-excel") {
//    		die( json_encode(array( "tipo" => "error", "mensaje" => "Tipo de documento no soportado $mimeType!")) );
//    	}
    	if(!move_uploaded_file( $_FILES['file']['tmp_name'], $archivoRuta)) {
    		die ( json_encode(array( "tipo" => "error", "mensaje" => "No se pudo subir el archivo correctamente!")) );
    	}

		//$helper->log('Loading file ' . pathinfo($archivoRuta, PATHINFO_BASENAME) . ' using IOFactory to identify the format');
		$spreadsheet = IOFactory::load($archivoRuta);
		$sheetData = $spreadsheet->getActiveSheet()->toArray(null, true, true, true);
		$i = 0;
		$titulos = true;
		$idDoc= "";

		$verificacionTitulos = array(
			"Registro",
		    "Tipo de documento",
		    "Revista",
		    "Titulo",
		    "Autores",
		    "Resumen",
		    "Año (Publicación)",
		    "Pais",
		    "Año",
		    "Lugar",
		    "Grados (Latitud)",
		    "Minutos (Latitud)",
		    "Segundos (Latitud)",
		    "Orientación (Latitud)",
		    "Grados (Longitud)",
		    "Minutos (Longitud)",
		    "Segundos(Longitud)",
		    "Orientación (Longitud)",
		    "Matriz",
		    "Especie",
		    "Nombre comun",
		    "Nombre inglés",
		    "Metal ",
		    "Concentración Mínima",
		    "Concentración Máxima",
		    "Unidades de concentración",
		    "Termino General",
		    "Descriptores",
		    "Termino Específico",
		    "Palabra Clave ",
		    "Link",
		    "Referencia"
		);

		$columnasFaltantes = array_diff( $verificacionTitulos, $sheetData[1]);
		$columnasSobrantes = array_diff( $sheetData[1], $verificacionTitulos);
		if(sizeof($columnasSobrantes) > 0 || sizeof($columnasFaltantes) > 0){
			die ( json_encode(array( "tipo" => "error", "mensaje" => "El estructura del archivo no es válida, verifique número de columnas y títulos!")) );
		}

		foreach ($sheetData as $key => $fila) {
			if($titulos || $fila['A'] == ""){
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
			$latitud = $this->convertirCoordenadas(
				array( $fila['K'], $fila['L'], $fila['M'], $fila['N'])
			);
			$longitud = $this->convertirCoordenadas(
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

		echo json_encode(array( "tipo" => "info", "mensaje" => "El archivo $archivo fue cargado correctamente!"));
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
    	$this->load->model( array("MetalDosisRefOral", "Especie") );
    	$servicio = $this->uri->segment(3);
    	if($servicio === "traer_metales_dosis_ref_oral") {
    		$metalesDosisRefOral = $this->MetalDosisRefOral->listarMetalesDosis();
    		echo json_encode($metalesDosisRefOral);
    	} else if($servicio === "hacer_calculo") {
    		$id = 1;
    		
    		$requestData = json_decode(file_get_contents('php://input'), true);
    		$especieId = $requestData['especie_id'];
    		$peso = $requestData['peso'];
    		$edad = $requestData['edad'];
    		$frecuencia = $requestData['frecuencia'];
    		$consumo = $requestData['consumo'];
    		$metalId = $requestData['metal'];
    		$metalesDosisRefOral = "";

    		$THQ = "-";
    		if($metalId){
    			$metalesDosisRefOral = $this->MetalDosisRefOral->consultarMetalDosis($metalId);
    			$concentracionMaxima = $this->Especie->obtenerEspecieConId( $especieId, array("maximo"));
    			$EF = 52.143 * $frecuencia;
    			$ED = $edad;
    			$FIR = $consumo / 1000;
    			$MC = $concentracionMaxima[0]['maximo'];
    			$RFD = $metalesDosisRefOral[0]['RFD'];
    			$BW = $peso;
    			$AT = $EF * $ED;

    			$THQ = ( ($EF * $ED * $FIR * $MC) / ($RFD * $BW * $AT) ) * (0.01);
    		}

    		echo json_encode($THQ);
    	} else if($servicio === "especies") {
    		$this->load->model("Especie");
    		$iniciales = $this->uri->segment(4);
    		$coincidencias = $this->Especie->especiesAutoCompletar( $iniciales);

    		echo json_encode($coincidencias);
    	}
    }

    public function mapa(){
    	$servicio = $this->uri->segment(3);
    	$this->load->model("documento");

    	if($servicio === "traer_docs_coord") {
    		$puntosInfo = $this->documento->obtenerInfoDocsMapa();
    		echo json_encode($puntosInfo);
    	}
    }

    public function especies() {
    	$servicio = $this->uri->segment(3);
    	$this->load->model("Especie");

    	if( $servicio === "traer_especies"){
    		$pagina = $this->uri->segment(4);
    		$filtro = $this->uri->segment(5);

    		$especiesArr = $this->Especie->obtenerEspecies( $filtro, $this->obtenerIdxPrimerRegistro($pagina), $this->nroRegistrosPorPagina);
    		$nroEspcies = $this->Especie->contarEspecies();

    		echo json_encode( 
    			array(
    				"total_registros" => intval($nroEspcies[0]['nro_especies']),
    				"registros_por_pagina" => $this->nroRegistrosPorPagina,
    				"pagina" => intval($pagina),
    				"especies" => $especiesArr
    			)
    		);

    	}
    }

    public function metales() {
    	$servicio = $this->uri->segment(3);
    	$this->load->model("Metal");

    	if( $servicio === "traer_metales"){
    		$pagina = $this->uri->segment(4);
    		$filtro = $this->uri->segment(5);

    		$metalesArr = $this->Metal->obtenerMetales( $filtro, $this->obtenerIdxPrimerRegistro($pagina), $this->nroRegistrosPorPagina);
    		$nroMetales = $this->Metal->contarMetales();

    		echo json_encode( 
    			array(
    				"total_registros" => intval($nroMetales[0]['nro_metales']),
    				"registros_por_pagina" => $this->nroRegistrosPorPagina,
    				"pagina" => intval($pagina),
    				"metales" => $metalesArr
    			)
    		);

    	}
    }

    public function metaldosisreforal() {
    	$servicio = $this->uri->segment(3);
    	$this->load->model("MetalDosisRefOral");

    	if( $servicio === "traer_metales"){
    		$pagina = $this->uri->segment(4);
    		$filtro = $this->uri->segment(5);

    		$metalesArr = $this->MetalDosisRefOral->obtenerMetalesDosis( $filtro, $this->obtenerIdxPrimerRegistro($pagina), $this->nroRegistrosPorPagina);
    		$nroMetales = $this->MetalDosisRefOral->contarMetalesDosis();

    		echo json_encode( 
    			array(
    				"total_registros" => intval($nroMetales[0]['nro_metales']),
    				"registros_por_pagina" => $this->nroRegistrosPorPagina,
    				"pagina" => intval($pagina),
    				"metales" => $metalesArr
    			)
    		);

    	}
    }

    public function documento() {
    	$servicio = $this->uri->segment(3);
    	$this->load->model("Documento");

    	if( $servicio === "traer_documentos"){
    		$pagina = $this->uri->segment(4);
    		$filtro = $this->uri->segment(5);

    		$documentosArr = $this->Documento->obtenerDocumentos( $filtro, $this->obtenerIdxPrimerRegistro($pagina), $this->nroRegistrosPorPagina);
    		$nroDocumentos = $this->Documento->contarDocumentos();

    		echo json_encode(
    			array(
    				"total_registros" => intval( $nroDocumentos[0]['nro_documentos']),
    				"registros_por_pagina" => $this->nroRegistrosPorPagina,
    				"pagina" => intval( $pagina),
    				"documentos" => $documentosArr
    			)
    		);

    	}
    }
} 