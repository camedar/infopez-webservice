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
}