<?php
class ModelExtensionPaymentAsaasBoleto extends Model {
	public function getMethod($address, $total) {
		$this->load->language('extension/payment/asaas_boleto');
        $status = $this->config->get('asaas_boleto_status');

		$method_data = array();

		if ($status) {
			$method_data = array(
				'code'       => 'asaas_boleto',
				'title'      => $this->language->get('text_title'),
				'terms'      => '',
				'sort_order' => $this->config->get('asaas_boleto_sort_order')
			);
		}

		return $method_data;
	}
}