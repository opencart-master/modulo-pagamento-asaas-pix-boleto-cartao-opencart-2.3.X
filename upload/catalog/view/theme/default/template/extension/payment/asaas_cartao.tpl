	<style>
        .panel {
            margin-top: 40px;
        }
        .credit-card-box .panel-title {
            display: inline;
            font-weight: bold;
        }
        .credit-card-box .form-control {
            height: 44px;
            font-size: 16px;
        }
        .credit-card-box .btn {
            font-size: 18px;
            padding: 10px 20px;
        }
        .credit-card-box .input-group-addon {
            background: #fff;
            border-left: 0;
            border-right: 0;
        }
        .borda {
            border:#ccc solid 1px; 
            border-radius: 5px;
            padding: 15px;
        }

        .card-flag {
            width: 40px;
            height: 20px;
            object-fit: contain;
            display: none;
        }
    </style>

<div class="col-sm-12">
        <?php if (!$modo) { ?>
        <div class="alert alert-info alert-dismissible"><i class="fa fa-exclamation-circle"></i> Atenção: você está em ambiente sandbox!</div>
        <?php } else { ?>
		<div class="alert alert-info alert-dismissible"><i class="fa fa-exclamation-circle"></i> Atenção: os dados do cartão precisam ser os mesmo do titular da conta!</div>
        <?php } ?>
		<div id="apireturn"></div>     
    </div>

<div class="container">
    <div class="col-md-6 col-md-offset-3">
        <div id="apireturn"></div>
        <div class="borda">
            
                <form id="payment-form">
                      <fieldset id="payment">
    <legend><center><h4>Dados do Cartão de Crédito</h4></center></legend>
                    <div class="form-group">
                        <label for="card_name">Nome Impresso no Cartão</label>
                        <input type="text" class="form-control" id="card_name" name="card_name" placeholder="Como aparece no cartão" required>
                    </div>
                    <div class="form-group">
                        <label for="card_number">Número do Cartão</label>
                         <div class="input-group">
                         <input type="text" class="form-control" id="card_number" name="card_number" maxlength="19" placeholder="0000 0000 0000 0000" required>
                         <span class="input-group-addon"><img id="card_flag" class="card-flag" src="" alt="Bandeira"></span>
                         </div>
                    </div>
                    <div class="row">
                        <div class="col-xs-4 form-group">
                            <label for="card_expiry">Validade Mês</label>
                            <input type="text" class="form-control" id="card_expiry" name="card_expiry" maxlength="2" placeholder="MM" required>
                        </div>
						<div class="col-xs-4 form-group">
                            <label for="card_expiry">Validade Ano</label>
                            <input type="text" class="form-control" id="card_expiry1" name="card_expiry1" maxlength="4" placeholder="AAAA" required>
                        </div>
                        <div class="col-xs-4 form-group">
                            <label for="card_cvv">CVV</label>
                            <input type="text" class="form-control" id="card_cvv" name="card_cvv" maxlength="4" placeholder="CVV" required>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="installments">Parcelas</label>
                        <select class="form-control" id="installments" name="installments" required>
                            <option value="">Selecione</option>
							<?php foreach($parc as $parcela) { ?>
                            <option value="<?php echo $parcela['parcelas']; ?>:<?php echo $parcela['preco']; ?>"><?php echo $parcela['parcelas']; ?>X - <?php echo $parcela['valor_parcela']; ?> 
                            <?php if ($parcela['tem_juros']) { ?> com juros <?php } else { ?> sem juros <?php } ?>
                            </option>
                            <?php } ?>
                        </select>
                    </div>

                    <!-- Valor da compra -->
                    <div class="form-group">
                        <label for="amount">Valor da Compra</label>
                        <input type="text" class="form-control" id="amount" name="amount" value="<?php echo $vtotal; ?>" readonly>
                    </div>
  
            <input type="button" value="<?php echo $button_confirm; ?>" id="button-confirm" class="btn btn-success btn-block" data-loading-text="<?php echo $text_loading; ?>" />
    </fieldset>
                </form>
          </div>
    </div>
</div>


<script type="text/javascript"><!--
$('#button-confirm').on('click', function() {
	$.ajax({
		url: 'index.php?route=extension/payment/asaas_cartao/confirm',
        type: 'post',
		data: $("#payment-form").serialize(),
		dataType: 'json',
		beforeSend: function() {
			$('#button-confirm').button('loading');
		},
		complete: function() {
			$('#button-confirm').button('reset');
		},
		success: function(json) {
            
            $('.alert-danger').remove();
			$('#button-confirm').button('reset');
			$('.text-danger').remove();
            $('#payment input').parent().removeClass('has-error');
            $('#payment select').parent().removeClass('has-error');
			
		    if (json['error']) {
			for (i in json['error']) {
			var eu = i;
			for (v in json['val']) {
			var vc = v;
			    if(eu === vc){
		        $('#payment input[name=\''+json['val'][v]+'\']').after('<div class="text-danger">' + json['error'][i] + '</div>');
		        $('#payment select[name=\''+json['val'][v]+'\']').after('<div class="text-danger">' + json['error'][i] + '</div>');
				$('#payment input[name=\''+json['val'][v]+'\']').parent().addClass('has-error');
                $('#payment select[name=\''+json['val'][v]+'\']').parent().addClass('has-error');
				} 
	    	}
	    	}
			}

            if (json['warning']) {
				$('#apireturn').after('<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> ' + json['warning'] + '</div>');
                $('#card_cvv').val("");
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

<script>
$(document).ready(function(){
    $('#card_name').on('input', function() {
       this.value = this.value.toUpperCase();
    });

    $('#card_number').on('input', function() {
        this.value = this.value.replace(/\D/g, '').replace(/(\d{4})(?=\d)/g, '$1 ');
    });
    
    $('#card_expiry').on('input', function() {
        this.value = this.value.replace(/\D/g, '').substr(0, 2);
    });

    $('#card_expiry1').on('input', function() {
        this.value = this.value.replace(/\D/g, '').substr(0, 4);
    });

    $('#card_cvv').on('input', function() {
        this.value = this.value.replace(/\D/g, '').substr(0, 4);
    });
});
</script>

<script>
$(document).ready(function(){
    const bandeiras = {
        visa: /^4/,
        mastercard: /^(5[1-5]|2[2-7])/,
        amex: /^3[47]/,
        diners: /^3(?:0[0-5]|[68])/,
        elo: /^(4011|4312|4389|4514|4576|5041|5067|5090|6277|6362|6504|6505|6507|6509|6516|6550)/,
        hipercard: /^(6062|3841)/,
        discover: /^6(?:011|5)/,
        aura: /^50/
    };

    function detectarBandeira(numero) {
        numero = numero.replace(/\D/g, '');
        for (const [bandeira, regex] of Object.entries(bandeiras)) {
            if (regex.test(numero)) return bandeira;
        }
        return null;
    }

    $('#card_number').on('input', function() {
        let numero = $(this).val().replace(/\D/g, '');
        $(this).val(numero.replace(/(\d{4})(?=\d)/g, '$1 ')); // máscara simples

        let bandeira = detectarBandeira(numero);
        let img = $('#card_flag');

        if (bandeira) {
            img.attr('src', 'https://raw.githubusercontent.com/aaronfagan/svg-credit-card-payment-icons/c2df917e4879ecba8e84a85c947ee7ee9dc5747d/flat-rounded/' + bandeira + '.svg');
            img.show();
        } else {
            img.hide();
        }
    });
});
</script>