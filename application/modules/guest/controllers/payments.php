<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

/*
 * FusionInvoice
 * 
 * A free and open source web based invoicing system
 *
 * @package		FusionInvoice
 * @author		Jesse Terry
 * @copyright	Copyright (c) 2012 - 2013, Jesse Terry
 * @license		http://www.fusioninvoice.com/support/page/license-agreement
 * @link		http://www.fusioninvoice.com
 * 
 */

class Payments extends Guest_Controller {

	public function __construct()
	{
		parent::__construct();

		$this->load->model('payments/mdl_payments');
	}

	public function index($page = 0)
	{
        $this->mdl_payments->where('(payments.invoice_id IN (SELECT invoice_id FROM invoices WHERE client_id IN (' . implode(',', $this->user_clients) . ')))');
        $this->mdl_payments->paginate(site_url('guest/payments/index'), $page);
        $payments = $this->mdl_payments->result();
            
		$this->layout->set(
			array(
				'payments'			 => $payments,
				'filter_display'	 => TRUE,
				'filter_placeholder' => lang('filter_payments'),
				'filter_method'		 => 'filter_payments'
			)
		);
        
		$this->layout->buffer('content', 'guest/payments_index');
		$this->layout->render('layout_guest');
	}

}

?>