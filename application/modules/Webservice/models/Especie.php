<?php
if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Especie extends CI_Model {
	var $nombreTabla = "especie";
	function __construct(){
		parent::__construct();
		$this->load->database();
	}

	public function convertirCharsDeURL($str) {
		$buscar = array("%2C", "%20");
		$remplazar = array(",","%");
		return str_replace( $buscar, $remplazar, $str); 
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

	public function especiesAutoCompletar($iniciales) {
		$iniciales_ = $this->convertirCharsDeURL($iniciales);
		$sql = "SELECT id, nombre_especie AS opcion, nombre_especie, nombre_comun FROM " . $this->nombreTabla . " WHERE LOWER(nombre_especie) LIKE '" . strtolower($iniciales) . "%'";
		$sql .= " UNION SELECT id, nombre_comun AS opcion, nombre_especie, nombre_comun FROM " . $this->nombreTabla . " WHERE LOWER(nombre_comun) LIKE '" . strtolower($iniciales) . "%'";
		$query = $this->db->query( $sql);

		return $query->result_array();
	}

	public function obtenerEspecieConId( $id, $columnasArr){
		if(is_array($columnasArr) && sizeof($columnasArr)>0) {
			$sql = "SELECT * FROM " . $this->nombreTabla . " WHERE id = '" . $id . "'";
			$this->db->select(implode(",", $columnasArr));
			$this->db->where( "id", $id);
			$query = $this->db->get($this->nombreTabla);
			return $query->result_array();
		}
		return null;
	}

	public function obtenerEspecies($nombreEspecie,$idxPrimerRegistro,$limite){
		$sql = "SELECT id, nombre_especie, nombre_comun FROM " . $this->nombreTabla . " WHERE nombre_especie LIKE '%" . $nombreEspecie . "%' ORDER BY nombre_especie LIMIT " . $idxPrimerRegistro . "," . $limite;
		$query = $this->db->query( $sql);

		return $query->result_array();
	}

	public function contarEspecies(){
		$sql = "SELECT COUNT(1) AS nro_especies FROM " . $this->nombreTabla;
		$query = $this->db->query($sql);

		return $query->result_array();
	}
}