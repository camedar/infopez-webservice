<?php
if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Usuario extends CI_Model {
	var $nombreTabla = "usuario";
	function __construct(){
		parent::__construct();
		$this->load->database();
	}

	public function obtenerUsuarioContrasena( $email, $password, $columnasArr){
		if(is_array($columnasArr) && sizeof($columnasArr)>0) {
			$this->db->select(implode(",", $columnasArr));
			$this->db->where( "email", $email);
			$this->db->where( "clave", $password);
			$query = $this->db->get($this->nombreTabla);
			return $query->result_array();
		}
	}

	public function obtenerUsuarioAdmin($columnasArr){
		if(is_array($columnasArr) && sizeof($columnasArr)>0) {
			$this->db->select(implode(",", $columnasArr));
			$this->db->where( "nombre_usuario", 'admin');
			$query = $this->db->get($this->nombreTabla);
			return $query->result_array();
		}
	}
	
}