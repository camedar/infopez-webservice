<?php
if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Documento extends CI_Model {
	private $nombreTabla = "documento";

	public function convertirCharsDeURL($str) {
		$buscar = array("%2C","%20","%24");
		$remplazar = array(",", "%","%");
		return str_replace( $buscar, $remplazar, $str); 
	}

	public function limpiarTabla() {
		$sql = "DELETE FROM " . $this->nombreTabla;
		$query = $this->db->query($sql);
	}
	
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
				$where .= "LOWER(termino_general) LIKE '" . strtolower($value) . "%' OR ";
			}
			$where = substr( $where, 0, strlen($where) - 4);
		}

		$sql = "SELECT DISTINCT termino_general FROM " . $this->nombreTabla . " " . $where . " ORDER BY termino_general ASC";
		$result = $this->db->query($sql);

		return $result->result_array();
	}

	public function obtenerDescriptorDeTermGeneral( $termGeneral ) {
		$termGeneral_ = $this->convertirCharsDeURL( $termGeneral);
		$sql = "SELECT DISTINCT descriptor FROM " . $this->nombreTabla . " WHERE termino_general LIKE '" . $termGeneral_ . "' ORDER BY descriptor";

		$result = $this->db->query($sql);

		return $result->result_array();
	}

	public function obtenerDocsDeTermGeneral( $termGeneral ) {
		$termGeneral_ = $this->convertirCharsDeURL( $termGeneral);
		$sql = "SELECT titulo FROM " . $this->nombreTabla . " WHERE termino_general LIKE '" . $termGeneral_ . "' ORDER BY titulo";
		$result = $this->db->query($sql);

		return $result->result_array();
	}

	public function obtenerDocsDeDescriptor( $descriptor ) {
		$descriptor_ = $this->convertirCharsDeURL( $descriptor);
		$sql = "SELECT titulo,link FROM " . $this->nombreTabla . " WHERE descriptor LIKE '" . $descriptor_ . "' ORDER BY titulo";
		$result = $this->db->query($sql);

		return $result->result_array();
	}

	public function obtenerInfoDocsMapa(){
		$sql = "SELECT d.titulo,d.palabra_clave,dcm.latitud,dcm.longitud,dcm.lugar,td.nombre,e.nombre_comun,e.nombre_especie, d.link FROM documento d INNER JOIN tipo_documento td ON d.tipo_documento_id=td.id INNER JOIN documento_concentracion_metal dcm ON d.id=dcm.documento_id INNER JOIN especie e ON dcm.especie_id=e.id GROUP BY dcm.latitud,dcm.longitud";
		$result = $this->db->query($sql);

		return $result->result_array();
	}

	public function obtenerDocumentos($nombreEspecie,$idxPrimerRegistro,$limite){
		$sql = "SELECT d.id, d.revista, d.titulo, d.autores, d.resumen, d.ano_publicacion, d.ano, d.termino_general, d.descriptor, d.termino_especifico, d.palabra_clave, d.link, d.referencia,
			t.nombre AS tipo_documento FROM " . $this->nombreTabla . " d";
		$sql .= " INNER JOIN tipo_documento t ON d.tipo_documento_id = t.id";
		$sql .= " WHERE d.titulo LIKE '%" . $nombreEspecie . "%'";
		$sql .= " ORDER BY d.titulo LIMIT " . $idxPrimerRegistro . "," . $limite;
		$query = $this->db->query( $sql);

		return $query->result_array();
	}

	public function contarDocumentos(){
		$sql = "SELECT COUNT(1) AS nro_documentos FROM " . $this->nombreTabla;
		$query = $this->db->query($sql);

		return $query->result_array();
	}
}