<?php
defined('BASEPATH') OR exit('No direct script access allowed');

use PhpOffice\PhpSpreadsheet\IOFactory;

class Webservice extends MX_Controller {

    function __construct() {
        parent::__construct();
        $this->load->helper('path');
    }

    public function index() {
        $inputFileName = 'assets/documentos/consolidado.xlsx';
		//$helper->log('Loading file ' . pathinfo($inputFileName, PATHINFO_BASENAME) . ' using IOFactory to identify the format');
		$spreadsheet = IOFactory::load($inputFileName);
		$sheetData = $spreadsheet->getActiveSheet()->toArray(null, true, true, true);
		echo print_r($sheetData[1]);
    }
} 