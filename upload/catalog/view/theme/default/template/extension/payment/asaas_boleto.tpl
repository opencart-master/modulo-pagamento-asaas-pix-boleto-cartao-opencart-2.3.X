<div class="col-sm-12">
        <?php if (!$modo) { ?>
        <div class="alert alert-info alert-dismissible"><i class="fa fa-exclamation-circle"></i> Atenção: você está em ambiente sandbox!</div>
        <?php } ?>
		<div id="apireturn"></div>     
    </div>
<div class="buttons">
  <div class="pull-right">
    <input type="button" value="<?php echo $button_confirm; ?>" id="button-confirm" class="btn btn-primary" data-loading-text="<?php echo $text_loading; ?>" />
  </div>
</div>
<script type="text/javascript"><!--
$('#button-confirm').on('click', function() {
	$.ajax({
		url: 'index.php?route=extension/payment/asaas_boleto/confirm',
		dataType: 'json',
		beforeSend: function() {
			$('#button-confirm').button('loading');
		},
		complete: function() {
			$('#button-confirm').button('reset');
		},
		success: function(json) {
			if (json['warning']) {
				$('#apireturn').after('<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> ' + json['warning'] + '</div>');
				setInterval(function(){
                location = json['redirect2'];
                }, 6000);
			}

			if (json['redirect']) {
				location = json['redirect'];	
			}
		},
		error: function(xhr, ajaxOptions, thrownError) {
			alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
		}
	});
});
//--></script>