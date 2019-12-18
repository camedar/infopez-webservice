<?php
if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Pais extends CI_Model {
	var $nombreTabla = "pais";
	function __construct(){
		parent::__construct();
		$this->load->database();
	}

	public function obtenerId( $nombre){
		$this->db->where( "nombre", strtolower($nombre));
		$query = $this->db->get($this->nombreTabla);
		return $query->result_array();
	}
}