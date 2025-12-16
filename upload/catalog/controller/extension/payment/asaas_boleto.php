<?php
class ControllerExtensionPaymentAsaasBoleto extends Controller {
	public function index() {
		$this->load->language('extension/payment/asaas_boleto');

		$data['modo'] = $this->config->get('asaas_boleto_mode');
		$data['text_loading'] = $this->language->get('text_loading');
		$data['button_confirm'] = $this->language->get('button_confirm');

		return $this->load->view('extension/payment/asaas_boleto', $data);
	}

	public function confirm() {
		$this->load->language('extension/payment/asaas_boleto');
		$json = array();
		if (isset($this->session->data['payment_method']['code']) && $this->session->data['payment_method']['code'] == 'asaas_boleto') {
			$this->load->model('checkout/order');
			require_once(DIR_SYSTEM . 'library/asaas/asaas_api.php');
			$order_info = $this->model_checkout_order->getOrder($this->session->data['order_id']);
			$custom = $order_info['custom_field'];

			if ($this->config->get('asaas_boleto_mode')) {
			$mode = false;
		    } else {
			$mode = true;
		    }

			$asaas = new AsaasApi($this->config->get('asaas_boleto_api_key'), $mode);

			$getcustomer = $asaas->getCustomer($order_info['email']);

			foreach ($custom as $key => $value) {
				if ($this->config->get('asaas_boleto_doc') == $key && !empty($value)) {
                   $doc = $value;
				} 
				
				if ($this->config->get('asaas_boleto_doc1') == $key && !empty($value)) {
				   $doc = $value;
				}
			}

			if ($getcustomer['totalCount']) {
				$cid = $getcustomer['data'][0]['id'];
			} else {
				$customer = $asaas->createCustomer([
				"name" => $order_info['payment_firstname'] . ' ' . $order_info['payment_lastname'],
				"cpfCnpj" => $asaas->onlyNumbe($doc),
				"phone" => $asaas->onlyNumbe($order_info['telephone']),
				"mobilePhone" => $asaas->onlyNumbe($order_info['telephone']),
				"notificationDisabled" => true,
				"email" => $order_info['email']
				]);
				$cid = $customer['id'];
			}

			$payment = $asaas->createPayment([
			"customer" => $cid,
			"billingType" => "BOLETO",
			"value" => $order_info['total'],
			"dueDate" => date('Y-m-d', strtotime('+3 days')),
			"description" => "Pedido " . $order_info['order_id'],
			"externalReference"	=> $order_info['order_id'],
			//"callback" => array("successUrl" => HTTPS_SERVER . "index.php?route=checkout/success")
			]);

            $comment = "";

			if (isset($payment['id'])) {
			$this->cadId($payment['id'], $order_info['order_id']);
		    $comment .= "Pagamento ID: " . $payment['id'] . "\n";
		    $comment .= "Link do Boleto: <a href='" . $payment['bankSlipUrl'] . "' class='label label-info' target='_blank'> VER 2ª via boleto </a> \n";
		    $this->model_checkout_order->addOrderHistory($this->session->data['order_id'], $this->config->get('asaas_boleto_order_status_id'), $comment);
		    $json['redirect'] = $this->url->link('checkout/success');
			} else {
			$json['redirect2'] = $this->url->link('checkout/failure');
			}

			if (isset($payment['errors'])) {
			$this->log->write('Pedido Nº ' . $order_info['order_id'] . ' - ERROR: ' . $payment['errors'][0]['description']);
            $json['warning'] = $payment['errors'][0]['description'];
			}
		}

		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));	
	}

	private function cadId($id, $order_id) {
		$order_query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "asaas_callback` WHERE order_id = '" . (int)$order_id . "'");
		if ($order_query->num_rows) {
		} else {
    	$this->db->query("INSERT INTO `" . DB_PREFIX . "asaas_callback` SET order_id = '" . (int)$order_id . "', pay_id = '" . $this->db->escape($id) . "', type = 'BOLETO', date_create = NOW()");
		}
	}

}