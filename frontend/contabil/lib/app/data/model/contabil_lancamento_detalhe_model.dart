import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:contabil/app/data/model/model_imports.dart';
import 'package:contabil/app/data/domain/domain_imports.dart';

class ContabilLancamentoDetalheModel {
	int? id;
	int? idContabilLancamentoCab;
	int? idContabilConta;
	int? idContabilHistorico;
	String? tipo;
	double? valor;
	String? historico;
	ContabilHistoricoModel? contabilHistoricoModel;
	ContabilContaModel? contabilContaModel;

	ContabilLancamentoDetalheModel({
		this.id,
		this.idContabilLancamentoCab,
		this.idContabilConta,
		this.idContabilHistorico,
		this.tipo,
		this.valor,
		this.historico,
		this.contabilHistoricoModel,
		this.contabilContaModel,
	});

	static List<String> dbColumns = <String>[
		'id',
		'tipo',
		'valor',
		'historico',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Tipo',
		'Valor',
		'Historico',
	];

	ContabilLancamentoDetalheModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idContabilLancamentoCab = jsonData['idContabilLancamentoCab'];
		idContabilConta = jsonData['idContabilConta'];
		idContabilHistorico = jsonData['idContabilHistorico'];
		tipo = ContabilLancamentoDetalheDomain.getTipo(jsonData['tipo']);
		valor = jsonData['valor']?.toDouble();
		historico = jsonData['historico'];
		contabilHistoricoModel = jsonData['contabilHistoricoModel'] == null ? ContabilHistoricoModel() : ContabilHistoricoModel.fromJson(jsonData['contabilHistoricoModel']);
		contabilContaModel = jsonData['contabilContaModel'] == null ? ContabilContaModel() : ContabilContaModel.fromJson(jsonData['contabilContaModel']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idContabilLancamentoCab'] = idContabilLancamentoCab != 0 ? idContabilLancamentoCab : null;
		jsonData['idContabilConta'] = idContabilConta != 0 ? idContabilConta : null;
		jsonData['idContabilHistorico'] = idContabilHistorico != 0 ? idContabilHistorico : null;
		jsonData['tipo'] = ContabilLancamentoDetalheDomain.setTipo(tipo);
		jsonData['valor'] = valor;
		jsonData['historico'] = historico;
		jsonData['contabilHistoricoModel'] = contabilHistoricoModel?.toJson;
		jsonData['contabilContaModel'] = contabilContaModel?.toJson;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idContabilLancamentoCab = plutoRow.cells['idContabilLancamentoCab']?.value;
		idContabilConta = plutoRow.cells['idContabilConta']?.value;
		idContabilHistorico = plutoRow.cells['idContabilHistorico']?.value;
		tipo = plutoRow.cells['tipo']?.value != '' ? plutoRow.cells['tipo']?.value : 'Débito';
		valor = plutoRow.cells['valor']?.value?.toDouble();
		historico = plutoRow.cells['historico']?.value;
		contabilHistoricoModel = ContabilHistoricoModel();
		contabilHistoricoModel?.descricao = plutoRow.cells['contabilHistoricoModel']?.value;
		contabilContaModel = ContabilContaModel();
		contabilContaModel?.descricao = plutoRow.cells['contabilContaModel']?.value;
	}	

	ContabilLancamentoDetalheModel clone() {
		return ContabilLancamentoDetalheModel(
			id: id,
			idContabilLancamentoCab: idContabilLancamentoCab,
			idContabilConta: idContabilConta,
			idContabilHistorico: idContabilHistorico,
			tipo: tipo,
			valor: valor,
			historico: historico,
		);			
	}

	
}