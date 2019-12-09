<?php
if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class DocumentoConcentracionMetal extends CI_Model {
	var $nombreTabla = "documento_concentracion_metal";
	function __construct(){
		parent::__construct();
		$this->load->database();
	}

	public function insertar($datosArr) {
		$this->db->insert( $this->nombreTabla, $datosArr);
    	return $this->db->insert_id();
	}
}