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

class Mdl_Quotes extends Response_Model {

    public $table               = 'quotes';
    public $primary_key         = 'quotes.quote_id';
    public $date_modified_field = 'quote_date_modified';

    public function default_select()
    {
        $this->db->select("
            SQL_CALC_FOUND_ROWS quote_custom.*,
            client_custom.*,
            user_custom.*,
            users.user_name, 
			users.user_company,
			users.user_address_1,
			users.user_address_2,
			users.user_city,
			users.user_state,
			users.user_zip,
			users.user_country,
			users.user_phone,
			users.user_fax,
			users.user_mobile,
			users.user_email,
			users.user_web,
			clients.*,
			quote_amounts.quote_amount_id,
			IFNULL(quote_amounts.quote_item_subtotal, '0.00') AS quote_item_subtotal,
			IFNULL(quote_amounts.quote_item_tax_total, '0.00') AS quote_item_tax_total,
			IFNULL(quote_amounts.quote_tax_total, '0.00') AS quote_tax_total,
			IFNULL(quote_amounts.quote_total, '0.00') AS quote_total,
			(CASE 
			WHEN (quotes.quote_date_expires > NOW() AND quotes.invoice_id = 0) THEN 'Open'
			WHEN (quotes.quote_date_expires <= NOW() AND quotes.invoice_id = 0) THEN 'Expired'
			WHEN (quotes.invoice_id <> 0) THEN 'Invoiced'
			ELSE 'Unknown' END) AS quote_status,
            invoices.invoice_number,
			quotes.*", FALSE);
    }

    public function default_order_by()
    {
        $this->db->order_by('quotes.quote_date_created DESC');
    }

    public function default_join()
    {
        $this->db->join('clients', 'clients.client_id = quotes.client_id');
        $this->db->join('users', 'users.user_id = quotes.user_id');
        $this->db->join('quote_amounts', 'quote_amounts.quote_id = quotes.quote_id', 'left');
        $this->db->join('invoices', 'invoices.invoice_id = quotes.invoice_id', 'left');
        $this->db->join('client_custom', 'client_custom.client_id = clients.client_id', 'left');
        $this->db->join('user_custom', 'user_custom.user_id = users.user_id', 'left');
        $this->db->join('quote_custom', 'quote_custom.quote_id = quotes.quote_id', 'left');
    }

    public function validation_rules()
    {
        return array(
            'client_name'        => array(
                'field' => 'client_name',
                'label' => lang('client'),
                'rules' => 'required'
            ),
            'quote_date_created' => array(
                'field' => 'quote_date_created',
                'label' => lang('quote_date'),
                'rules' => 'required'
            ),
            'invoice_group_id'   => array(
                'field' => 'invoice_group_id',
                'label' => lang('quote_group'),
                'rules' => 'required'
            ),
            'user_id'            => array(
                'field' => 'user_id',
                'label' => lang('user'),
                'rule'  => 'required'
            )
        );
    }

    public function validation_rules_save_quote()
    {
        return array(
            'quote_number'       => array(
                'field' => 'quote_number',
                'label' => lang('quote_number'),
                'rules' => 'required|is_unique[quotes.quote_number' . (($this->id) ? '.quote_id.' . $this->id : '') . ']'
            ),
            'quote_date_created' => array(
                'field' => 'quote_date_created',
                'label' => lang('date'),
                'rules' => 'required'
            ),
            'quote_date_expires'     => array(
                'field' => 'quote_date_expires',
                'label' => lang('due_date'),
                'rules' => 'required'
            )
        );
    }

    public function create($db_array = NULL)
    {
        $quote_id = parent::save(NULL, $db_array);

        // Create an quote amount record
        $db_array = array(
            'quote_id' => $quote_id
        );

        $this->db->insert('quote_amounts', $db_array);

        // Create the default quote tax record if applicable
        if ($this->mdl_settings->setting('default_quote_tax_rate'))
        {
            $db_array = array(
                'quote_id'              => $quote_id,
                'tax_rate_id'           => $this->mdl_settings->setting('default_quote_tax_rate'),
                'include_item_tax'      => $this->mdl_settings->setting('default_include_item_tax'),
                'quote_tax_rate_amount' => 0
            );

            $this->db->insert('quote_tax_rates', $db_array);
        }

        return $quote_id;
    }

    public function get_url_key()
    {
        $this->load->helper('string');
        return random_string('unique');
    }

    /**
     * Copies quote items, tax rates, etc from source to target
     * @param int $source_id
     * @param int $target_id
     */
    public function copy_quote($source_id, $target_id)
    {
        $this->load->model('quotes/mdl_quote_items');

        $quote_items = $this->mdl_quote_items->where('quote_id', $source_id)->get()->result();

        foreach ($quote_items as $quote_item)
        {
            $db_array = array(
                'quote_id'         => $target_id,
                'item_tax_rate_id' => $quote_item->item_tax_rate_id,
                'item_name'        => $quote_item->item_name,
                'item_description' => $quote_item->item_description,
                'item_quantity'    => $quote_item->item_quantity,
                'item_price'       => $quote_item->item_price,
                'item_order'       => $quote_item->item_order
            );

            $this->mdl_quote_items->save($target_id, NULL, $db_array);
        }

        $quote_tax_rates = $this->mdl_quote_tax_rates->where('quote_id', $source_id)->get()->result();

        foreach ($quote_tax_rates as $quote_tax_rate)
        {
            $db_array = array(
                'quote_id'              => $target_id,
                'tax_rate_id'           => $quote_tax_rate->tax_rate_id,
                'include_item_tax'      => $quote_tax_rate->include_item_tax,
                'quote_tax_rate_amount' => $quote_tax_rate->quote_tax_rate_amount
            );

            $this->mdl_quote_tax_rates->save($target_id, NULL, $db_array);
        }
    }

    public function db_array()
    {
        $db_array = parent::db_array();

        // Get the client id for the submitted quote
        $this->load->model('clients/mdl_clients');
        $db_array['client_id'] = $this->mdl_clients->client_lookup($db_array['client_name']);
        unset($db_array['client_name']);

        $db_array['quote_date_created'] = date_to_mysql($db_array['quote_date_created']);
        $db_array['quote_date_expires']     = $this->get_date_due($db_array['quote_date_created']);
        $db_array['quote_number']       = $this->get_quote_number($db_array['invoice_group_id']);

        // Generate the unique url key
        $db_array['quote_url_key'] = $this->get_url_key();

        return $db_array;
    }

    public function get_quote_number($invoice_group_id)
    {
        $this->load->model('invoice_groups/mdl_invoice_groups');
        return $this->mdl_invoice_groups->generate_invoice_number($invoice_group_id);
    }

    public function get_date_due($quote_date_created)
    {
        $quote_date_expires = new DateTime($quote_date_created);
        $quote_date_expires->add(new DateInterval('P' . $this->mdl_settings->setting('quotes_expire_after') . 'D'));
        return $quote_date_expires->format('Y-m-d');
    }

    public function delete($quote_id)
    {
        parent::delete($quote_id);

        $this->load->helper('orphan');
        delete_orphans();
    }

    public function is_open()
    {
        $this->filter_where('quote_date_expires > NOW()');
        $this->filter_where('quotes.invoice_id', 0);
        return $this;
    }

    public function is_expired()
    {
        $this->filter_where('quote_date_expires <= NOW()');
        $this->filter_where('quotes.invoice_id', 0);
        return $this;
    }

    public function is_invoiced()
    {
        $this->filter_where('quotes.invoice_id <>', 0);
        return $this;
    }

    public function by_client($client_id)
    {
        $this->filter_where('quotes.client_id', $client_id);
        return $this;
    }

}

?>