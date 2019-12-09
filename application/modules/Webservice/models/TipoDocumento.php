<?php
if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class TipoDocumento extends CI_Model {
	var $nombreTabla = "tipo_documento";
	function __construct(){
		parent::__construct();
		$this->load->database();
	}

	public function insertar($datosArr) {
		$this->db->insert( $this->nombreTabla, $datosArr);
    	return $this->db->insert_id();
	}

	public function obtenerId( $nombre){
		$sql = "SELECT id FROM " . $this->nombreTabla . " WHERE nombre LIKE '" . $nombre . "'";
		$query = $this->db->query($sql);
		//var_dump($query);
		//return $query->result();
		return $query->result_array();
	}
}