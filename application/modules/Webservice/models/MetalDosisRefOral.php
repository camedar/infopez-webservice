<?php
if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Metaldosisreforal extends CI_Model {
	private $nombreTabla = "metal_dosis_ref_oral";

	public function convertirCharsDeURL($str) {
		$buscar = array("%2C");
		$remplazar = array(",");
		return str_replace( $buscar, $remplazar, $str); 
	}

	public function __construct(){
		parent::__construct();
		$this->load->database();
	}

	public function insertar($datosArr) {
		$this->db->insert( $this->nombreTabla, $datosArr);
    	return $this->db->insert_id();
	}

	public function listarMetalesDosis() {
		$sql = "SELECT id,nombre_metal, simbolo_metal, RFD FROM " . $this->nombreTabla . " ORDER BY nombre_metal ASC";
		$result = $this->db->query($sql);

		return $result->result_array();
	}

	public function consultarMetalDosis($id) {
		$sql = "SELECT id,nombre_metal, simbolo_metal, RFD FROM " . $this->nombreTabla . " WHERE id =  ". $id . " ORDER BY nombre_metal ASC";
		$result = $this->db->query($sql);

		return $result->result_array();
	}

	public function obtenerMetalesDosis($nombre,$idxPrimerRegistro, $limite){
		$sql = "SELECT id,nombre_metal, simbolo_metal, RFD FROM " . $this->nombreTabla . " WHERE nombre_metal LIKE '%" . $nombre . "%' ORDER BY nombre_metal LIMIT " . $idxPrimerRegistro . "," . $limite;
		$query = $this->db->query( $sql);

		return $query->result_array();
	}

	public function contarMetalesDosis(){
		$sql = "SELECT COUNT(1) AS nro_metales FROM " . $this->nombreTabla;
		$query = $this->db->query($sql);

		return $query->result_array();
	}
}