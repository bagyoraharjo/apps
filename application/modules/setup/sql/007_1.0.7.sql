ALTER TABLE `quotes` ADD `invoice_id` INT NOT NULL AFTER `quote_id` ,
ADD INDEX ( `invoice_id` );