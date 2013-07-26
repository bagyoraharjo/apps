SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";

DROP SCHEMA IF EXISTS adi_app1;
CREATE SCHEMA adi_app1;
USE adi_app1;

CREATE TABLE sessions (
  session_id varchar(40) COLLATE utf8_unicode_ci NOT NULL,
  ip_address varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  user_agent varchar(120) COLLATE utf8_unicode_ci DEFAULT NULL,
  last_activity int(11) NOT NULL,
  user_data longtext COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (session_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO sessions (session_id, ip_address, user_agent, last_activity, user_data) VALUES
('7fca71c9861d3eb85dead6f73ab37c7f', '::1', 'Mozilla/5.0 (Windows NT 6.1; rv:21.0) Gecko/20100101 Firefox/21.0', 1370594858, 'a:5:{s:9:"user_data";s:0:"";s:4:"name";s:0:"";s:5:"email";s:25:"adi.s.kurniawan@gmail.com";s:2:"id";s:1:"1";s:8:"loggedin";b:1;}');

CREATE TABLE settings (
  setting_id int(11) NOT NULL AUTO_INCREMENT,
  setting_key varchar(50) NOT NULL,
  setting_value longtext NOT NULL,
  PRIMARY KEY (setting_id),
  KEY setting_key (setting_key)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=15 ;

INSERT INTO settings (setting_id, setting_key, setting_value) VALUES
(1, 'default_language', 'indonesia'),
(2, 'date_format', 'm/d/Y'),
(3, 'currency_symbol', '$'),
(4, 'currency_symbol_placement', 'before'),
(5, 'invoices_due_after', '30'),
(6, 'quotes_expire_after', '15'),
(7, 'default_invoice_group', '1'),
(8, 'default_quote_group', '2'),
(9, 'default_invoice_template', 'default_invoice'),
(10, 'default_quote_template', 'default_quote'),
(11, 'thousands_separator', ','),
(12, 'decimal_point', '.'),
(13, 'cron_key', 'kgldjGXBTDFuym0C'),
(14, 'tax_rate_decimal_places', '2'),
(15, 'site_title', 'Aplikasi Percetakan'),
(16, 'site_quotes', 'Simpel dan Bermanfaat'),
(17, 'site_footer', 'Adi Kurniawan  2013 <br>Aplikasi Percetakan'),
(18, 'key_login', 'AppPercetakan32'),
(19, 'site_theme', 'flat-dot'),
(20, 'site_limit_small', '5'),
(21, 'site_limit_medium', '10');

CREATE TABLE people (
  person_id int(11) NOT NULL AUTO_INCREMENT,
  person_name varchar(100) NOT NULL,
  person_address_1 varchar(100) DEFAULT '',
  person_address_2 varchar(100) DEFAULT '',
  person_city varchar(45) DEFAULT '',
  person_state varchar(35) DEFAULT '',
  person_zip varchar(15) DEFAULT '',
  person_country varchar(35) DEFAULT '',
  person_phone varchar(20) DEFAULT '',
  person_fax varchar(20) DEFAULT '',
  person_mobile varchar(20) DEFAULT '',
  person_email varchar(100) DEFAULT '',
  person_web varchar(100) DEFAULT '',
  person_date_created datetime NOT NULL,
  person_date_modified datetime NOT NULL,
  PRIMARY KEY (person_id)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

INSERT INTO `people` (`person_name`) VALUES
('Adi Kurniawan'),
('Adi S Kurniawan'),
('Adi Setyadi Kurniawan');

CREATE TABLE organizations (
  organization_id int(11) NOT NULL AUTO_INCREMENT,
  organization_name varchar(100) NOT NULL,
  organization_address_1 varchar(100) DEFAULT '',
  organization_address_2 varchar(100) DEFAULT '',
  organization_city varchar(45) DEFAULT '',
  organization_state varchar(35) DEFAULT '',
  organization_zip varchar(15) DEFAULT '',
  organization_country varchar(35) DEFAULT '',
  organization_phone varchar(20) DEFAULT '',
  organization_fax varchar(20) DEFAULT '',
  organization_mobile varchar(20) DEFAULT '',
  organization_email varchar(100) DEFAULT '',
  organization_web varchar(100) DEFAULT '',
  organization_date_created datetime NOT NULL,
  organization_date_modified datetime NOT NULL,
  PRIMARY KEY (organization_id)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

INSERT INTO `organizations` (`organization_name`) VALUES
('XYZ');

CREATE TABLE employees (
  username varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  person_id int(11) NOT NULL,
  deleted int(1) NOT NULL DEFAULT '0',
  UNIQUE KEY username (username),
  KEY person_id (person_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO employees (`username`, `password`, `person_id`, `deleted`) VALUES
('admin', '21232f297a57a5a743894a0e4a801fc3', 1, 0);

CREATE TABLE suppliers (
  person_id int(11) NOT NULL,
  company_name varchar(255) NOT NULL,
  account_number varchar(255) DEFAULT NULL,
  deleted int(1) NOT NULL DEFAULT '0',
  UNIQUE KEY account_number (account_number),
  KEY person_id (person_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE supplies (
  supply_id int(5) NOT NULL AUTO_INCREMENT,
  unit_type_id int(10) NOT NULL,
  supply_name varchar(100) NOT NULL,
  stock int(10) NOT NULL,
  PRIMARY KEY (supply_id)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=5 ;

INSERT INTO supplies (supply_id, unit_type_id, supply_name, stock) VALUES
(1, 1, 'Kertas A4', 821),
(3, 2, 'Kertas Manila', 7),
(4, 2, 'Serbuk Kayu', 4);

CREATE TABLE printing_list (
  printing_list_id int(10) NOT NULL AUTO_INCREMENT,
  order_id varchar(20) NOT NULL,
  printing_type_id int(10) NOT NULL,
  PRIMARY KEY (printing_list_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

CREATE TABLE printing_types (
  printing_type_id int(5) NOT NULL AUTO_INCREMENT,
  printing_type varchar(100) NOT NULL,
  PRIMARY KEY (printing_type_id)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=6 ;

INSERT INTO printing_types (printing_type_id, printing_type) VALUES
(2, 'Sablon'),
(3, 'Kartu Nama'),
(4, 'Spanduk'),
(5, 'Baliho');

CREATE TABLE unit_types (
  unit_type_id int(10) NOT NULL AUTO_INCREMENT,
  unit_type varchar(50) NOT NULL,
  PRIMARY KEY (unit_type_id)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

INSERT INTO unit_types (unit_type_id, unit_type) VALUES
(1, 'rim'),
(2, 'lembar');

CREATE TABLE receipts (
  receipt_id varchar(20) NOT NULL,
  note_id varchar(20) NOT NULL,
  payment_date int(30) NOT NULL,
  PRIMARY KEY (receipt_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE customers (
  person_id int(5) NOT NULL AUTO_INCREMENT,
  company_name varchar(20) NOT NULL,
  PRIMARY KEY (person_id)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=34 ;

INSERT INTO customers (person_id, company_name) VALUES
(1, 'Individu'),
(2, 'Perusahaan');

CREATE TABLE orders (
  order_id varchar(20) NOT NULL,
  order_date varchar(30) NOT NULL,
  finish_date varchar(30) NOT NULL,
  person_id int(5) NOT NULL,
  total_price int(20) NOT NULL,
  printing_type varchar(100) NOT NULL,
  payment_status varchar(20) NOT NULL,
  PRIMARY KEY (order_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO orders (order_id, order_date, finish_date, person_id, total_price, printing_type, payment_status) VALUES
('PS00000001', '16 April 2013', '18 April 2013', 31, 150500, '5,', 'Lunas'),
('PS00000002', '01 March 2013', '02 April 2013', 33, 45900, '', 'Belum Bayar'),
('PS00000003', '06 April 2013', '09 April 2013', 33, 20000, '', 'Belum Bayar'),
('PS00000004', '16 April 2013', '20 April 2013', 33, 45900, '4,5,', 'Lunas');

CREATE TABLE orders_detail (
  order_detail_id int(10) NOT NULL AUTO_INCREMENT,
  order_id varchar(30) NOT NULL,
  supply_id int(10) NOT NULL,
  unit int(10) NOT NULL,
  PRIMARY KEY (order_detail_id)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=36 ;

INSERT INTO orders_detail (order_detail_id, order_id, supply_id, unit) VALUES
(7, 'PS00000002', 3, 1),
(8, 'PS00000002', 4, 2),
(16, 'PS00000003', 3, 1),
(29, 'PS00000004', 1, 3),
(31, 'PS00000001', 4, 2),
(32, 'PS00000001', 3, 1),
(33, 'PS00000001', 1, 5),
(34, 'PS00000001', 4, 2),
(35, 'PS00000001', 1, 5);

ALTER TABLE employees
  ADD CONSTRAINT employees_fk_1 FOREIGN KEY (person_id) REFERENCES people (person_id);

ALTER TABLE suppliers
  ADD CONSTRAINT suppliers_fk_1 FOREIGN KEY (person_id) REFERENCES people (person_id);

ALTER TABLE customers
  ADD CONSTRAINT customers_fk_1 FOREIGN KEY (person_id) REFERENCES people (person_id);


  CREATE TABLE clients (
  client_id int(11) NOT NULL AUTO_INCREMENT,
  client_date_created datetime NOT NULL,
  client_date_modified datetime NOT NULL,
  client_name varchar(100) NOT NULL,
  client_address_1 varchar(100) DEFAULT '',
  client_address_2 varchar(100) DEFAULT '',
  client_city varchar(45) DEFAULT '',
  client_state varchar(35) DEFAULT '',
  client_zip varchar(15) DEFAULT '',
  client_country varchar(35) DEFAULT '',
  client_phone varchar(20) DEFAULT '',
  client_fax varchar(20) DEFAULT '',
  client_mobile varchar(20) DEFAULT '',
  client_email varchar(100) DEFAULT '',
  client_web varchar(100) DEFAULT '',
  client_active int(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (client_id),
  KEY client_active (client_active)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

INSERT INTO clients (client_id, client_date_created, client_date_modified, client_name, client_address_1, client_address_2, client_city, client_state, client_zip, client_country, client_phone, client_fax, client_mobile, client_email, client_web, client_active) VALUES
(1, '2013-07-01 11:35:58', '2013-07-01 11:35:58', 'Fifi', '', '', '', '', '', '', '', '', '', '', '', 1);

CREATE TABLE client_custom (
  client_custom_id int(11) NOT NULL AUTO_INCREMENT,
  client_id int(11) NOT NULL,
  PRIMARY KEY (client_custom_id),
  KEY client_id (client_id)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

INSERT INTO client_custom (client_custom_id, client_id) VALUES
(1, 1);

CREATE TABLE client_notes (
  client_note_id int(11) NOT NULL AUTO_INCREMENT,
  client_id int(11) NOT NULL,
  client_note_date date NOT NULL,
  client_note longtext NOT NULL,
  PRIMARY KEY (client_note_id),
  KEY client_id (client_id,client_note_date)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

CREATE TABLE custom_fields (
  custom_field_id int(11) NOT NULL AUTO_INCREMENT,
  custom_field_table varchar(35) NOT NULL,
  custom_field_label varchar(64) NOT NULL,
  custom_field_column varchar(64) NOT NULL,
  PRIMARY KEY (custom_field_id),
  KEY custom_field_table (custom_field_table)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

CREATE TABLE email_templates (
  email_template_id int(11) NOT NULL AUTO_INCREMENT,
  email_template_title varchar(255) NOT NULL,
  email_template_body longtext NOT NULL,
  PRIMARY KEY (email_template_id)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

CREATE TABLE imports (
  import_id int(11) NOT NULL AUTO_INCREMENT,
  import_date datetime NOT NULL,
  PRIMARY KEY (import_id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

CREATE TABLE import_details (
  import_detail_id int(11) NOT NULL AUTO_INCREMENT,
  import_id int(11) NOT NULL,
  import_lang_key varchar(35) NOT NULL,
  import_table_name varchar(35) NOT NULL,
  import_record_id int(11) NOT NULL,
  PRIMARY KEY (import_detail_id),
  KEY import_id (import_id,import_record_id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

CREATE TABLE invoices (
  invoice_id int(11) NOT NULL AUTO_INCREMENT,
  user_id int(11) NOT NULL,
  client_id int(11) NOT NULL,
  invoice_group_id int(11) NOT NULL,
  invoice_date_created date NOT NULL,
  invoice_date_modified datetime NOT NULL,
  invoice_date_due date NOT NULL,
  invoice_number varchar(20) NOT NULL,
  invoice_terms longtext NOT NULL,
  invoice_url_key char(32) NOT NULL,
  PRIMARY KEY (invoice_id),
  UNIQUE KEY invoice_url_key (invoice_url_key),
  KEY user_id (user_id,client_id,invoice_group_id,invoice_date_created,invoice_date_due,invoice_number)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

CREATE TABLE invoices_recurring (
  invoice_recurring_id int(11) NOT NULL AUTO_INCREMENT,
  invoice_id int(11) NOT NULL,
  recur_start_date date NOT NULL,
  recur_end_date date NOT NULL,
  recur_frequency char(2) NOT NULL,
  recur_next_date date NOT NULL,
  PRIMARY KEY (invoice_recurring_id),
  KEY invoice_id (invoice_id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

CREATE TABLE invoice_amounts (
  invoice_amount_id int(11) NOT NULL AUTO_INCREMENT,
  invoice_id int(11) NOT NULL,
  invoice_item_subtotal decimal(10,2) DEFAULT '0.00',
  invoice_item_tax_total decimal(10,2) DEFAULT '0.00',
  invoice_tax_total decimal(10,2) DEFAULT '0.00',
  invoice_total decimal(10,2) DEFAULT '0.00',
  invoice_paid decimal(10,2) DEFAULT '0.00',
  invoice_balance decimal(10,2) DEFAULT '0.00',
  PRIMARY KEY (invoice_amount_id),
  KEY invoice_id (invoice_id),
  KEY invoice_paid (invoice_paid,invoice_balance)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

CREATE TABLE invoice_custom (
  invoice_custom_id int(11) NOT NULL AUTO_INCREMENT,
  invoice_id int(11) NOT NULL,
  PRIMARY KEY (invoice_custom_id),
  KEY invoice_id (invoice_id)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

CREATE TABLE invoice_groups (
  invoice_group_id int(11) NOT NULL AUTO_INCREMENT,
  invoice_group_name varchar(50) NOT NULL DEFAULT '',
  invoice_group_prefix varchar(10) NOT NULL DEFAULT '',
  invoice_group_next_id int(11) NOT NULL,
  invoice_group_left_pad int(2) NOT NULL DEFAULT '0',
  invoice_group_prefix_year int(1) NOT NULL DEFAULT '0',
  invoice_group_prefix_month int(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (invoice_group_id),
  KEY invoice_group_next_id (invoice_group_next_id),
  KEY invoice_group_left_pad (invoice_group_left_pad)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

INSERT INTO invoice_groups (invoice_group_id, invoice_group_name, invoice_group_prefix, invoice_group_next_id, invoice_group_left_pad, invoice_group_prefix_year, invoice_group_prefix_month) VALUES
(1, 'Invoice Default', '', 1, 0, 0, 0),
(2, 'Quote Default', 'QUO', 1, 0, 0, 0);

CREATE TABLE invoice_items (
  item_id int(11) NOT NULL AUTO_INCREMENT,
  invoice_id int(11) NOT NULL,
  item_tax_rate_id int(11) NOT NULL DEFAULT '0',
  item_date_added date NOT NULL,
  item_name varchar(100) NOT NULL,
  item_description longtext NOT NULL,
  item_quantity decimal(10,2) NOT NULL,
  item_price decimal(10,2) NOT NULL,
  item_order int(2) NOT NULL DEFAULT '0',
  PRIMARY KEY (item_id),
  KEY invoice_id (invoice_id,item_tax_rate_id,item_date_added,item_order)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

CREATE TABLE invoice_item_amounts (
  item_amount_id int(11) NOT NULL AUTO_INCREMENT,
  item_id int(11) NOT NULL,
  item_subtotal decimal(10,2) NOT NULL,
  item_tax_total decimal(10,2) NOT NULL,
  item_total decimal(10,2) NOT NULL,
  PRIMARY KEY (item_amount_id),
  KEY item_id (item_id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

CREATE TABLE invoice_tax_rates (
  invoice_tax_rate_id int(11) NOT NULL AUTO_INCREMENT,
  invoice_id int(11) NOT NULL,
  tax_rate_id int(11) NOT NULL,
  include_item_tax int(1) NOT NULL DEFAULT '0',
  invoice_tax_rate_amount decimal(10,2) NOT NULL,
  PRIMARY KEY (invoice_tax_rate_id),
  KEY invoice_id (invoice_id,tax_rate_id)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

CREATE TABLE merchant_responses (
  merchant_response_id int(11) NOT NULL AUTO_INCREMENT,
  invoice_id int(11) NOT NULL,
  merchant_response_date date NOT NULL,
  merchant_response_driver varchar(35) NOT NULL,
  merchant_response varchar(255) NOT NULL,
  merchant_response_reference varchar(255) NOT NULL,
  PRIMARY KEY (merchant_response_id),
  KEY merchant_response_date (merchant_response_date),
  KEY invoice_id (invoice_id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

CREATE TABLE payments (
  payment_id int(11) NOT NULL AUTO_INCREMENT,
  invoice_id int(11) NOT NULL,
  payment_method_id int(11) NOT NULL DEFAULT '0',
  payment_date date NOT NULL,
  payment_amount decimal(10,2) NOT NULL,
  payment_note longtext NOT NULL,
  PRIMARY KEY (payment_id),
  KEY invoice_id (invoice_id),
  KEY payment_method_id (payment_method_id),
  KEY payment_amount (payment_amount)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

CREATE TABLE payment_custom (
  payment_custom_id int(11) NOT NULL AUTO_INCREMENT,
  payment_id int(11) NOT NULL,
  PRIMARY KEY (payment_custom_id),
  KEY payment_id (payment_id)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

CREATE TABLE payment_methods (
  payment_method_id int(11) NOT NULL AUTO_INCREMENT,
  payment_method_name varchar(35) NOT NULL,
  PRIMARY KEY (payment_method_id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

CREATE TABLE quotes (
  quote_id int(11) NOT NULL AUTO_INCREMENT,
  invoice_id int(11) NOT NULL DEFAULT '0',
  user_id int(11) NOT NULL,
  client_id int(11) NOT NULL,
  invoice_group_id int(11) NOT NULL,
  quote_date_created date NOT NULL,
  quote_date_modified datetime NOT NULL,
  quote_date_expires date NOT NULL,
  quote_number varchar(20) NOT NULL,
  quote_url_key char(32) NOT NULL,
  PRIMARY KEY (quote_id),
  KEY user_id (user_id,client_id,invoice_group_id,quote_date_created,quote_date_expires,quote_number),
  KEY invoice_id (invoice_id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

CREATE TABLE quote_amounts (
  quote_amount_id int(11) NOT NULL AUTO_INCREMENT,
  quote_id int(11) NOT NULL,
  quote_item_subtotal decimal(10,2) NOT NULL,
  quote_item_tax_total decimal(10,2) NOT NULL,
  quote_tax_total decimal(10,2) NOT NULL,
  quote_total decimal(10,2) NOT NULL DEFAULT '0.00',
  PRIMARY KEY (quote_amount_id),
  KEY quote_id (quote_id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

CREATE TABLE quote_custom (
  quote_custom_id int(11) NOT NULL AUTO_INCREMENT,
  quote_id int(11) NOT NULL,
  PRIMARY KEY (quote_custom_id),
  KEY quote_id (quote_id)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

CREATE TABLE quote_items (
  item_id int(11) NOT NULL AUTO_INCREMENT,
  quote_id int(11) NOT NULL,
  item_tax_rate_id int(11) NOT NULL,
  item_date_added date NOT NULL,
  item_name varchar(100) NOT NULL,
  item_description longtext NOT NULL,
  item_quantity decimal(10,2) NOT NULL,
  item_price decimal(10,2) NOT NULL,
  item_order int(2) NOT NULL DEFAULT '0',
  PRIMARY KEY (item_id),
  KEY quote_id (quote_id,item_date_added,item_order),
  KEY item_tax_rate_id (item_tax_rate_id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

CREATE TABLE quote_item_amounts (
  item_amount_id int(11) NOT NULL AUTO_INCREMENT,
  item_id int(11) NOT NULL,
  item_subtotal decimal(10,2) NOT NULL,
  item_tax_total decimal(10,2) NOT NULL,
  item_total decimal(10,2) NOT NULL,
  PRIMARY KEY (item_amount_id),
  KEY item_id (item_id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

CREATE TABLE quote_tax_rates (
  quote_tax_rate_id int(11) NOT NULL AUTO_INCREMENT,
  quote_id int(11) NOT NULL,
  tax_rate_id int(11) NOT NULL,
  include_item_tax int(1) NOT NULL DEFAULT '0',
  quote_tax_rate_amount decimal(10,2) NOT NULL,
  PRIMARY KEY (quote_tax_rate_id),
  KEY quote_id (quote_id),
  KEY tax_rate_id (tax_rate_id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

CREATE TABLE tax_rates (
  tax_rate_id int(11) NOT NULL AUTO_INCREMENT,
  tax_rate_name varchar(25) NOT NULL,
  tax_rate_percent decimal(5,2) NOT NULL,
  PRIMARY KEY (tax_rate_id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

CREATE TABLE users (
  user_id int(11) NOT NULL AUTO_INCREMENT,
  user_type int(1) NOT NULL DEFAULT '0',
  user_date_created datetime NOT NULL,
  user_date_modified datetime NOT NULL,
  user_name varchar(100) DEFAULT '',
  user_company varchar(100) DEFAULT '',
  user_address_1 varchar(100) DEFAULT '',
  user_address_2 varchar(100) DEFAULT '',
  user_city varchar(45) DEFAULT '',
  user_state varchar(35) DEFAULT '',
  user_zip varchar(15) DEFAULT '',
  user_country varchar(35) DEFAULT '',
  user_phone varchar(20) DEFAULT '',
  user_fax varchar(20) DEFAULT '',
  user_mobile varchar(20) DEFAULT '',
  user_email varchar(100) NOT NULL,
  user_password varchar(60) NOT NULL,
  user_web varchar(100) DEFAULT '',
  user_psalt char(22) NOT NULL,
  PRIMARY KEY (user_id)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

INSERT INTO users (user_id, user_type, user_date_created, user_date_modified, user_name, user_company, user_address_1, user_address_2, user_city, user_state, user_zip, user_country, user_phone, user_fax, user_mobile, user_email, user_password, user_web, user_psalt) VALUES
(1, 1, '2013-07-01 11:34:56', '2013-07-01 11:34:56', 'Adi Kurniawan', '', '', '', '', '', '', '', '', '', '', 'adi.s.kurniawan@gmail.com', '$2a$10$4ea2d4392985bc22be40cuh./mTBodLovUDMPYJi168k3FEEOMwdm', '', '4ea2d4392985bc22be40c5');

CREATE TABLE user_clients (
  user_client_id int(11) NOT NULL AUTO_INCREMENT,
  user_id int(11) NOT NULL,
  client_id int(11) NOT NULL,
  PRIMARY KEY (user_client_id),
  KEY user_id (user_id,client_id)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

CREATE TABLE user_custom (
  user_custom_id int(11) NOT NULL AUTO_INCREMENT,
  user_id int(11) NOT NULL,
  PRIMARY KEY (user_custom_id),
  KEY user_id (user_id)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

CREATE TABLE versions (
  version_id int(11) NOT NULL AUTO_INCREMENT,
  version_date_applied varchar(14) NOT NULL,
  version_file varchar(45) NOT NULL,
  version_sql_errors int(2) NOT NULL,
  PRIMARY KEY (version_id),
  KEY version_date_applied (version_date_applied)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=30 ;

INSERT INTO versions (version_id, version_date_applied, version_file, version_sql_errors) VALUES
(1, '1372649654', '000_1.0.sql', 0),
(2, '1372649657', '001_1.0.1.sql', 0),
(3, '1372649657', '002_1.0.2.sql', 0),
(4, '1372649657', '003_1.0.3.sql', 0),
(5, '1372649658', '004_1.0.4.sql', 0),
(6, '1372649658', '005_1.0.5.sql', 0),
(7, '1372649658', '006_1.0.6.sql', 0),
(8, '1372649658', '007_1.0.7.sql', 0),
(9, '1372649658', '008_1.0.8.sql', 0),
(10, '1372649658', '009_1.0.9.sql', 0),
(11, '1372649658', '010_1.1.0.sql', 0),
(12, '1372649659', '011_1.1.1.sql', 0),
(13, '1372649659', '012_1.1.2.sql', 0),
(14, '1372649659', '013_1.1.3.sql', 0),
(15, '1372649660', '014_1.1.4.sql', 0),
(16, '1372649660', '015_1.1.5.sql', 0),
(17, '1372649660', '016_1.1.6.sql', 0),
(18, '1372649660', '017_1.1.7.sql', 0),
(19, '1372649660', '018_1.1.8.sql', 0),
(20, '1372649660', '019_1.1.9.sql', 0),
(21, '1372649661', '020_1.2.0.sql', 0),
(22, '1372649661', '021_1.2.1.sql', 0),
(23, '1372649661', '022_1.2.2.sql', 0),
(24, '1372649661', '023_1.2.3.sql', 0),
(25, '1372649661', '024_1.2.4.sql', 0),
(26, '1372649661', '025_1.2.5.sql', 0),
(27, '1372649661', '026_1.2.6.sql', 0),
(28, '1372649661', '027_1.2.7.sql', 0),
(29, '1372649661', '028_1.2.8.sql', 0);
