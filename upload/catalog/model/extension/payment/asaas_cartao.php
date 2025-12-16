<?php
class ModelExtensionPaymentAsaasCartao extends Model {
	public function getMethod($address, $total) {
		$this->load->language('extension/payment/asaas_cartao');
        $status = $this->config->get('asaas_cartao_status');

		$method_data = array();

		if ($status) {
			$method_data = array(
				'code'       => 'asaas_cartao',
				'title'      => $this->language->get('text_title'),
				'terms'      => '',
				'sort_order' => $this->config->get('asaas_cartao_sort_order')
			);
		}

		return $method_data;
	}
}