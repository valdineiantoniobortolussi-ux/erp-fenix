import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:tributacao/app/data/model/model_imports.dart';
import 'package:tributacao/app/data/domain/domain_imports.dart';

class TributIssModel {
	int? id;
	int? idTributOperacaoFiscal;
	String? modalidadeBaseCalculo;
	String? codigoTributacao;
	int? itemListaServico;
	double? porcentoBaseCalculo;
	double? aliquotaPorcento;
	double? aliquotaUnidade;
	double? valorPrecoMaximo;
	double? valorPautaFiscal;
	TributOperacaoFiscalModel? tributOperacaoFiscalModel;

	TributIssModel({
		this.id,
		this.idTributOperacaoFiscal,
		this.modalidadeBaseCalculo,
		this.codigoTributacao,
		this.itemListaServico,
		this.porcentoBaseCalculo,
		this.aliquotaPorcento,
		this.aliquotaUnidade,
		this.valorPrecoMaximo,
		this.valorPautaFiscal,
		this.tributOperacaoFiscalModel,
	});

	static List<String> dbColumns = <String>[
		'id',
		'modalidade_base_calculo',
		'codigo_tributacao',
		'item_lista_servico',
		'porcento_base_calculo',
		'aliquota_porcento',
		'aliquota_unidade',
		'valor_preco_maximo',
		'valor_pauta_fiscal',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Modalidade Base Calculo',
		'Codigo Tributacao',
		'Item Lista Servico',
		'Porcento Base Calculo',
		'Aliquota Porcento',
		'Aliquota Unidade',
		'Valor Preco Maximo',
		'Valor Pauta Fiscal',
	];

	TributIssModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idTributOperacaoFiscal = jsonData['idTributOperacaoFiscal'];
		modalidadeBaseCalculo = TributIssDomain.getModalidadeBaseCalculo(jsonData['modalidadeBaseCalculo']);
		codigoTributacao = TributIssDomain.getCodigoTributacao(jsonData['codigoTributacao']);
		itemListaServico = jsonData['itemListaServico'];
		porcentoBaseCalculo = jsonData['porcentoBaseCalculo']?.toDouble();
		aliquotaPorcento = jsonData['aliquotaPorcento']?.toDouble();
		aliquotaUnidade = jsonData['aliquotaUnidade']?.toDouble();
		valorPrecoMaximo = jsonData['valorPrecoMaximo']?.toDouble();
		valorPautaFiscal = jsonData['valorPautaFiscal']?.toDouble();
		tributOperacaoFiscalModel = jsonData['tributOperacaoFiscalModel'] == null ? TributOperacaoFiscalModel() : TributOperacaoFiscalModel.fromJson(jsonData['tributOperacaoFiscalModel']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idTributOperacaoFiscal'] = idTributOperacaoFiscal != 0 ? idTributOperacaoFiscal : null;
		jsonData['modalidadeBaseCalculo'] = TributIssDomain.setModalidadeBaseCalculo(modalidadeBaseCalculo);
		jsonData['codigoTributacao'] = TributIssDomain.setCodigoTributacao(codigoTributacao);
		jsonData['itemListaServico'] = itemListaServico;
		jsonData['porcentoBaseCalculo'] = porcentoBaseCalculo;
		jsonData['aliquotaPorcento'] = aliquotaPorcento;
		jsonData['aliquotaUnidade'] = aliquotaUnidade;
		jsonData['valorPrecoMaximo'] = valorPrecoMaximo;
		jsonData['valorPautaFiscal'] = valorPautaFiscal;
		jsonData['tributOperacaoFiscalModel'] = tributOperacaoFiscalModel?.toJson;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idTributOperacaoFiscal = plutoRow.cells['idTributOperacaoFiscal']?.value;
		modalidadeBaseCalculo = plutoRow.cells['modalidadeBaseCalculo']?.value != '' ? plutoRow.cells['modalidadeBaseCalculo']?.value : '0-Valor Operação';
		codigoTributacao = plutoRow.cells['codigoTributacao']?.value != '' ? plutoRow.cells['codigoTributacao']?.value : 'Normal';
		itemListaServico = plutoRow.cells['itemListaServico']?.value;
		porcentoBaseCalculo = plutoRow.cells['porcentoBaseCalculo']?.value?.toDouble();
		aliquotaPorcento = plutoRow.cells['aliquotaPorcento']?.value?.toDouble();
		aliquotaUnidade = plutoRow.cells['aliquotaUnidade']?.value?.toDouble();
		valorPrecoMaximo = plutoRow.cells['valorPrecoMaximo']?.value?.toDouble();
		valorPautaFiscal = plutoRow.cells['valorPautaFiscal']?.value?.toDouble();
		tributOperacaoFiscalModel = TributOperacaoFiscalModel();
		tributOperacaoFiscalModel?.descricao = plutoRow.cells['tributOperacaoFiscalModel']?.value;
	}	

	TributIssModel clone() {
		return TributIssModel(
			id: id,
			idTributOperacaoFiscal: idTributOperacaoFiscal,
			modalidadeBaseCalculo: modalidadeBaseCalculo,
			codigoTributacao: codigoTributacao,
			itemListaServico: itemListaServico,
			porcentoBaseCalculo: porcentoBaseCalculo,
			aliquotaPorcento: aliquotaPorcento,
			aliquotaUnidade: aliquotaUnidade,
			valorPrecoMaximo: valorPrecoMaximo,
			valorPautaFiscal: valorPautaFiscal,
		);			
	}

	
}