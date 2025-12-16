<?php
class ControllerExtensionPaymentAsaasBoleto extends Controller {
	private $error = array();

	public function index() {
		$this->load->language('extension/payment/asaas_boleto');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('setting/setting');
		$this->createDbCallback();

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			$this->model_setting_setting->editSetting('asaas_boleto', $this->request->post);

			$this->session->data['success'] = $this->language->get('text_success');

			$this->response->redirect($this->url->link('extension/extension', 'token=' . $this->session->data['token'] . '&type=payment', true));
		}

		$data['heading_title'] = $this->language->get('heading_title');

		$data['text_edit'] = $this->language->get('text_edit');
		$data['text_enabled'] = $this->language->get('text_enabled');
		$data['text_disabled'] = $this->language->get('text_disabled');
		$data['text_all_zones'] = $this->language->get('text_all_zones');
		$data['text_sand'] = $this->language->get('text_sand');
		$data['text_prod'] = $this->language->get('text_prod');
		$data['text_none'] = $this->language->get('text_none');

		$data['entry_key'] = $this->language->get('entry_key');
		$data['entry_wb'] = $this->language->get('entry_wb');
		$data['entry_mode'] = $this->language->get('entry_mode');
		$data['entry_doc'] = $this->language->get('entry_doc');
		$data['entry_doc1'] = $this->language->get('entry_doc1');
		$data['entry_total'] = $this->language->get('entry_total');
		$data['entry_order_status'] = $this->language->get('entry_order_status');
		$data['entry_order_status2'] = $this->language->get('entry_order_status2');
		$data['entry_order_status3'] = $this->language->get('entry_order_status3');
		$data['entry_order_status4'] = $this->language->get('entry_order_status4');
		$data['entry_order_status5'] = $this->language->get('entry_order_status5');
		$data['entry_geo_zone'] = $this->language->get('entry_geo_zone');
		$data['entry_status'] = $this->language->get('entry_status');
		$data['entry_sort_order'] = $this->language->get('entry_sort_order');

		$data['help_total'] = $this->language->get('help_total');

		$data['button_save'] = $this->language->get('button_save');
		$data['button_cancel'] = $this->language->get('button_cancel');

		if (isset($this->error['warning'])) {
			$data['error_warning'] = $this->error['warning'];
		} else {
			$data['error_warning'] = '';
		}

		if (isset($this->error['key'])) {
			$data['error_key'] = $this->error['key'];
		} else {
			$data['error_key'] = '';
		}

		if (isset($this->error['doc'])) {
			$data['error_doc'] = $this->error['doc'];
		} else {
			$data['error_doc'] = '';
		}

		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], true)
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_extension'),
			'href' => $this->url->link('extension/extension', 'token=' . $this->session->data['token'] . '&type=payment', true)
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('heading_title'),
			'href' => $this->url->link('extension/payment/asaas_boleto', 'token=' . $this->session->data['token'], true)
		);

		$data['action'] = $this->url->link('extension/payment/asaas_boleto', 'token=' . $this->session->data['token'], true);

		$data['cancel'] = $this->url->link('extension/extension', 'token=' . $this->session->data['token'] . '&type=payment', true);
		
		if (isset($this->request->post['asaas_boleto_api_key'])) {
			$data['asaas_boleto_api_key'] = $this->request->post['asaas_boleto_api_key'];
		} else {
			$data['asaas_boleto_api_key'] = $this->config->get('asaas_boleto_api_key');
		}

		if (!empty($this->config->get('asaas_boleto_api_key'))) {
            $data['show'] = true;
		} else {
		    $data['show'] = false;
		}

		if (isset($this->request->post['asaas_boleto_order_status_id'])) {
			$data['asaas_boleto_order_status_id'] = $this->request->post['asaas_boleto_order_status_id'];
		} else {
			$data['asaas_boleto_order_status_id'] = $this->config->get('asaas_boleto_order_status_id');
		}

		if (isset($this->request->post['asaas_boleto_order_status_id2'])) {
			$data['asaas_boleto_order_status_id2'] = $this->request->post['asaas_boleto_order_status_id2'];
		} else {
			$data['asaas_boleto_order_status_id2'] = $this->config->get('asaas_boleto_order_status_id2');
		}

		if (isset($this->request->post['asaas_boleto_order_status_id3'])) {
			$data['asaas_boleto_order_status_id3'] = $this->request->post['asaas_boleto_order_status_id3'];
		} else {
			$data['asaas_boleto_order_status_id3'] = $this->config->get('asaas_boleto_order_status_id3');
		}

		if (isset($this->request->post['asaas_boleto_order_status_id4'])) {
			$data['asaas_boleto_order_status_id4'] = $this->request->post['asaas_boleto_order_status_id4'];
		} else {
			$data['asaas_boleto_order_status_id4'] = $this->config->get('asaas_boleto_order_status_id4');
		}

		if (isset($this->request->post['asaas_boleto_order_status_id5'])) {
			$data['asaas_boleto_order_status_id5'] = $this->request->post['asaas_boleto_order_status_id5'];
		} else {
			$data['asaas_boleto_order_status_id5'] = $this->config->get('asaas_boleto_order_status_id5');
		}

		if (isset($this->request->post['asaas_boleto_mode'])) {
			$data['asaas_boleto_mode'] = $this->request->post['asaas_boleto_mode'];
		} else {
			$data['asaas_boleto_mode'] = $this->config->get('asaas_boleto_mode');
		}

		$this->load->model('localisation/order_status');

		$data['order_statuses'] = $this->model_localisation_order_status->getOrderStatuses();

		if (isset($this->request->post['asaas_boleto_status'])) {
			$data['asaas_boleto_status'] = $this->request->post['asaas_boleto_status'];
		} else {
			$data['asaas_boleto_status'] = $this->config->get('asaas_boleto_status');
		}

		if (isset($this->request->post['asaas_wb'])) {
			$data['asaas_wb'] = $this->request->post['asaas_wb'];
		} elseif(!empty($this->config->get('asaas_wb'))) {
			$data['asaas_wb'] = $this->config->get('asaas_wb');
		} else {
			$data['asaas_wb'] = uniqid();
		}

		if (isset($this->request->post['asaas_boleto_sort_order'])) {
			$data['asaas_boleto_sort_order'] = $this->request->post['asaas_boleto_sort_order'];
		} else {
			$data['asaas_boleto_sort_order'] = $this->config->get('asaas_boleto_sort_order');
		}

		if (isset($this->request->post['asaas_boleto_doc'])) {
			$data['asaas_boleto_doc'] = $this->request->post['asaas_boleto_doc'];
		} else {
			$data['asaas_boleto_doc'] = $this->config->get('asaas_boleto_doc');
		}

		if (isset($this->request->post['asaas_boleto_doc1'])) {
			$data['asaas_boleto_doc1'] = $this->request->post['asaas_boleto_doc1'];
		} else {
			$data['asaas_boleto_doc1'] = $this->config->get('asaas_boleto_doc1');
		}

		$this->load->model('customer/custom_field');
		
        $data['custom_fields'] = $this->model_customer_custom_field->getCustomFields();

		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('extension/payment/asaas_boleto', $data));
	}

	protected function validate() {
		if (!$this->user->hasPermission('modify', 'extension/payment/asaas_boleto')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		if (empty($this->request->post['asaas_boleto_api_key'])) {
			$this->error['key'] = $this->language->get('error_key');
		}

		if (!isset($this->request->post['asaas_boleto_doc']) || $this->request->post['asaas_boleto_doc'] == 0 ) {
			$this->error['doc'] = $this->language->get('error_doc');
		}

		return !$this->error;
	}

	public function createDbCallback() {
        $this->db->query("CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "asaas_callback` (
        `order_id` int(11) NOT NULL AUTO_INCREMENT,
		`pay_id` varchar(255) NOT NULL,
		`type` varchar(30) NOT NULL,
        `date_create` datetime NOT NULL,
        PRIMARY KEY (`order_id`)
        ) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3; ");
    }
}