<?php
if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Documento extends CI_Model {
	private $nombreTabla = "documento";

	public function __construct(){
		parent::__construct();
		$this->load->database();
	}

	public function insertar($datosArr) {
		$this->db->insert( $this->nombreTabla, $datosArr);
    	return $this->db->insert_id();
	}

	public function listarTerminoGeneral( $filtroArr, $letraInicialArr) {
		$where = "";
		if(is_array( $letraInicialArr) && sizeof($letraInicialArr)) {
			$where = " WHERE ";
			foreach ($letraInicialArr as $key => $value) {
				$where .= "LOWER(termino_general) LIKE '" . $value . "%' OR ";
			}
			$where = substr( $where, 0, strlen($where) - 4);
		}

		$sql = "SELECT DISTINCT termino_general FROM " . $this->nombreTabla . " " . $where . " ORDER BY termino_general ASC";
		$result = $this->db->query($sql);

		return $result->result_array();
	}

	public function obtenerDescriptorDeTermGeneral( $termGeneral ) {
		$sql = "SELECT descriptor FROM " . $this->nombreTabla . " WHERE termino_general = '" . $termGeneral . "'";

		$result = $this->db->query($sql);

		return $result->result_array();
	}

	public function obtenerDocsDeTermGeneral( $termGeneral ) {
		$sql = "SELECT titulo FROM " . $this->nombreTabla . " WHERE termino_general = '" . $termGeneral . "'";
		$result = $this->db->query($sql);

		return $result->result_array();
	}
}