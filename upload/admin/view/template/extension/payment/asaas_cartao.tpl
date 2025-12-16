<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
        <button type="submit" form="form-asaas-cartao" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
        <a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>" class="btn btn-default"><i class="fa fa-reply"></i></a></div>
      <h1><?php echo $heading_title; ?></h1>
      <ul class="breadcrumb">
        <?php foreach ($breadcrumbs as $breadcrumb) { ?>
        <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
        <?php } ?>
      </ul>
    </div>
  </div>
  <div class="container-fluid">
    <?php if ($error_warning) { ?>
    <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
      <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>
    <?php } ?>
    <div class="panel panel-default">
      <div class="panel-heading">
        <h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $text_edit; ?></h3>
      </div>
      <div class="panel-body">
        <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-asaas-cartao" class="form-horizontal">
         <div class="form-group">
            <label class="col-sm-2 control-label" for="input-mode"><?php echo $entry_mode; ?></label>
            <div class="col-sm-10">
              <select name="asaas_cartao_mode" id="input-status" class="form-control">
                <?php if ($asaas_cartao_mode) { ?>
                <option value="1" selected="selected"><?php echo $text_prod; ?></option>
                <option value="0"><?php echo $text_sand; ?></option>
                <?php } else { ?>
                <option value="1"><?php echo $text_prod; ?></option>
                <option value="0" selected="selected"><?php echo $text_sand; ?></option>
                <?php } ?>
              </select>
            </div>
          </div>
          <div class="form-group required">
            <label class="col-sm-2 control-label" for="input-key"><?php echo $entry_key; ?></label>
            <div class="col-sm-10">
              <input type="text" name="asaas_cartao_api_key" value="<?php echo $asaas_cartao_api_key; ?>" placeholder="<?php echo $entry_key; ?>" id="input-key" class="form-control" />
            <?php if ($error_key) { ?>
              <div class="text-danger"><?php echo $error_key; ?></div>
            <?php } ?>
            </div>
          </div>
          <div class="form-group required">
		        <label class="col-sm-2 control-label"><?php echo $entry_doc; ?></label>
			      <div class="col-sm-10">
			        <select name="asaas_cartao_doc" id="input-doc" class="form-control">
				        <option value=""><?php echo $text_none; ?></option>
				        <?php foreach($custom_fields as $custom_field) { ?>
				        <?php if ($custom_field['location'] == 'account') { ?>
					      <?php if ($asaas_cartao_doc == $custom_field['custom_field_id']) { ?>
					      <option value="<?php echo $custom_field['custom_field_id']; ?>" selected><?php echo $custom_field['name']; ?></option>
					      <?php } else { ?>
					      <option value="<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></option>
					      <?php } ?>
					      <?php } ?><?php } ?>
			        </select>
			        <?php if ($error_doc) { ?>
                <div class="text-danger"><?php echo $error_doc; ?></div>
              <?php } ?>	 
			      </div>
		      </div>
          <div class="form-group">
		        <label class="col-sm-2 control-label"><?php echo $entry_doc1; ?></label>
			      <div class="col-sm-10">
			        <select name="asaas_cartao_doc1" id="input-doc1" class="form-control">
				        <option value=""><?php echo $text_none; ?></option>
				        <?php foreach($custom_fields as $custom_field) { ?>
				        <?php if ($custom_field['location'] == 'account') { ?>
					      <?php if ($asaas_cartao_doc1 == $custom_field['custom_field_id']) { ?>
					      <option value="<?php echo $custom_field['custom_field_id']; ?>" selected><?php echo $custom_field['name']; ?></option>
					      <?php } else { ?>
					      <option value="<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></option>
					      <?php } ?>
					      <?php } ?><?php } ?>
			        </select>
			      </div>
		      </div>
          <div class="form-group required">
		        <label class="col-sm-2 control-label"><?php echo $entry_number; ?></label>
			      <div class="col-sm-10">
			        <select name="asaas_cartao_number" id="input-number" class="form-control">
				        <option value=""><?php echo $text_none; ?></option>
				        <?php foreach($custom_fields as $custom_field) { ?>
				        <?php if ($custom_field['location'] == 'address') { ?>
					      <?php if ($asaas_cartao_number == $custom_field['custom_field_id']) { ?>
					      <option value="<?php echo $custom_field['custom_field_id']; ?>" selected><?php echo $custom_field['name']; ?></option>
					      <?php } else { ?>
					      <option value="<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></option>
					      <?php } ?>
					      <?php } ?><?php } ?>
			        </select>
			        <?php if ($error_number) { ?>
                <div class="text-danger"><?php echo $error_number; ?></div>
              <?php } ?>	 
			      </div>
		      </div>
          <div class="form-group">
            <label class="col-sm-2 control-label" for="input-parc"><?php echo $entry_parc; ?></label>
            <div class="col-sm-10">
              <input type="text" name="asaas_cartao_parc" value="<?php echo $asaas_cartao_parc; ?>" placeholder="<?php echo $entry_parc; ?>" id="input-parc" class="form-control" />
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-2 control-label" for="input-parc1"><?php echo $entry_parc1; ?></label>
            <div class="col-sm-10">
              <input type="text" name="asaas_cartao_parc1" value="<?php echo $asaas_cartao_parc1; ?>" placeholder="<?php echo $entry_parc1; ?>" id="input-parc1" class="form-control" />
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-2 control-label" for="input-juros"><?php echo $entry_juros; ?></label>
            <div class="col-sm-10">
              <input type="text" name="asaas_cartao_juros" value="<?php echo $asaas_cartao_juros; ?>" placeholder="<?php echo $entry_juros; ?>" id="input-juros" class="form-control" />
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-2 control-label" for="input-order-status"><?php echo $entry_order_status; ?></label>
            <div class="col-sm-10">
              <select name="asaas_cartao_order_status_id" id="input-order-status" class="form-control">
                <?php foreach ($order_statuses as $order_status) { ?>
                <?php if ($order_status['order_status_id'] == $asaas_cartao_order_status_id) { ?>
                <option value="<?php echo $order_status['order_status_id']; ?>" selected="selected"><?php echo $order_status['name']; ?></option>
                <?php } else { ?>
                <option value="<?php echo $order_status['order_status_id']; ?>"><?php echo $order_status['name']; ?></option>
                <?php } ?>
                <?php } ?>
              </select>
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-2 control-label" for="input-order-status2"><?php echo $entry_order_status2; ?></label>
            <div class="col-sm-10">
              <select name="asaas_cartao_order_status_id2" id="input-order-status2" class="form-control">
                <?php foreach ($order_statuses as $order_status) { ?>
                <?php if ($order_status['order_status_id'] == $asaas_cartao_order_status_id2) { ?>
                <option value="<?php echo $order_status['order_status_id']; ?>" selected="selected"><?php echo $order_status['name']; ?></option>
                <?php } else { ?>
                <option value="<?php echo $order_status['order_status_id']; ?>"><?php echo $order_status['name']; ?></option>
                <?php } ?>
                <?php } ?>
              </select>
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-2 control-label" for="input-order-status3"><?php echo $entry_order_status3; ?></label>
            <div class="col-sm-10">
              <select name="asaas_cartao_order_status_id3" id="input-order-status3" class="form-control">
                <?php foreach ($order_statuses as $order_status) { ?>
                <?php if ($order_status['order_status_id'] == $asaas_cartao_order_status_id3) { ?>
                <option value="<?php echo $order_status['order_status_id']; ?>" selected="selected"><?php echo $order_status['name']; ?></option>
                <?php } else { ?>
                <option value="<?php echo $order_status['order_status_id']; ?>"><?php echo $order_status['name']; ?></option>
                <?php } ?>
                <?php } ?>
              </select>
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-2 control-label" for="input-order-status4"><?php echo $entry_order_status4; ?></label>
            <div class="col-sm-10">
              <select name="asaas_cartao_order_status_id4" id="input-order-status4" class="form-control">
                <?php foreach ($order_statuses as $order_status) { ?>
                <?php if ($order_status['order_status_id'] == $asaas_cartao_order_status_id4) { ?>
                <option value="<?php echo $order_status['order_status_id']; ?>" selected="selected"><?php echo $order_status['name']; ?></option>
                <?php } else { ?>
                <option value="<?php echo $order_status['order_status_id']; ?>"><?php echo $order_status['name']; ?></option>
                <?php } ?>
                <?php } ?>
              </select>
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-2 control-label" for="input-order-status5"><?php echo $entry_order_status5; ?></label>
            <div class="col-sm-10">
              <select name="asaas_cartao_order_status_id5" id="input-order-status5" class="form-control">
                <?php foreach ($order_statuses as $order_status) { ?>
                <?php if ($order_status['order_status_id'] == $asaas_cartao_order_status_id5) { ?>
                <option value="<?php echo $order_status['order_status_id']; ?>" selected="selected"><?php echo $order_status['name']; ?></option>
                <?php } else { ?>
                <option value="<?php echo $order_status['order_status_id']; ?>"><?php echo $order_status['name']; ?></option>
                <?php } ?>
                <?php } ?>
              </select>
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-2 control-label" for="input-status"><?php echo $entry_status; ?></label>
            <div class="col-sm-10">
              <select name="asaas_cartao_status" id="input-status" class="form-control">
                <?php if ($asaas_cartao_status) { ?>
                <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                <option value="0"><?php echo $text_disabled; ?></option>
                <?php } else { ?>
                <option value="1"><?php echo $text_enabled; ?></option>
                <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                <?php } ?>
              </select>
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-2 control-label" for="input-sort-order"><?php echo $entry_sort_order; ?></label>
            <div class="col-sm-10">
              <input type="text" name="asaas_cartao_sort_order" value="<?php echo $asaas_cartao_sort_order; ?>" placeholder="<?php echo $entry_sort_order; ?>" id="input-sort-order" class="form-control" />
            </div>
          </div>
        </form>
      </div>
    </div>
  </div>
</div>
<?php echo $footer; ?>