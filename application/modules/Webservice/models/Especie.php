<?php
if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Especie extends CI_Model {
	var $nombreTabla = "especie";
	function __construct(){
		parent::__construct();
		$this->load->database();
	}

	public function insertar($datosArr) {
		$this->db->insert( $this->nombreTabla, $datosArr);
    	return $this->db->insert_id();
	}

	public function obtenerId( $nombre){
		$sql = "SELECT id FROM " . $this->nombreTabla . " WHERE nombre_especie = '" . $nombre . "'";
		$query = $this->db->query($sql);
		//var_dump($query);
		//return $query->result();
		return $query->result_array();
	}
}