<?php
if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Usuario extends CI_Model {
	var $nombreTabla = "usuario";
	function __construct(){
		parent::__construct();
		$this->load->database();
	}
}