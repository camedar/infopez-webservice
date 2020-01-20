<?php
if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Metal extends CI_Model {
	var $nombreTabla = "metal";
	function __construct(){
		parent::__construct();
		$this->load->database();
	}

	public function limpiarTabla() {
		$sql = "DELETE FROM " . $this->nombreTabla;
		$query = $this->db->query($sql);
	}

	public function insertar($datosArr) {
		$this->db->insert( $this->nombreTabla, $datosArr);
    	return $this->db->insert_id();
	}

	public function obtenerId( $nombre){
		$sql = "SELECT id FROM " . $this->nombreTabla . " WHERE nombre = '" . $nombre . "'";
		$query = $this->db->query($sql);
		//var_dump($query);
		//return $query->result();
		return $query->result_array();
	}

	public function obtenerMetales($nombre,$idxPrimerRegistro, $limite){
		$sql = "SELECT id, nombre FROM " . $this->nombreTabla . " WHERE nombre LIKE '%" . $nombre . "%' ORDER BY nombre LIMIT " . $idxPrimerRegistro . "," . $limite;
		$query = $this->db->query( $sql);

		return $query->result_array();
	}

	public function contarMetales(){
		$sql = "SELECT COUNT(1) AS nro_metales FROM " . $this->nombreTabla;
		$query = $this->db->query($sql);

		return $query->result_array();
	}


}