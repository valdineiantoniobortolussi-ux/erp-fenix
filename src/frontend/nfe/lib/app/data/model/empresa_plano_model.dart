import 'dart:convert';
import 'package:nfe/app/data/model/model_imports.dart';
import 'package:intl/intl.dart';

class EmpresaPlanoModel {
	int? id;
	int? idErpTipoPlano;
	int? idEmpresa;
	DateTime? dataInicio;
	DateTime? dataFim;
	double? valorPago;
	String? idPagamentoPlataforma;
	String? statusPagamentoPlataforma;
	ErpTipoPlanoModel? erpTipoPlanoModel;

	EmpresaPlanoModel({
		this.id,
		this.idErpTipoPlano,
		this.idEmpresa,
		this.dataInicio,
		this.dataFim,
		this.valorPago,
		this.idPagamentoPlataforma,
		this.statusPagamentoPlataforma,
		this.erpTipoPlanoModel,
	});

	static List<String> dbColumns = <String>[
		'id',
		'data_inicio',
		'data_fim',
		'valor_pago',
		'id_pagamento_plataforma',
		'status_pagamento_plataforma',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Data Inicio',
		'Data Fim',
		'Valor Pago',
		'Id Pagamento Plataforma',
		'Status Pagamento Plataforma',
	];

	EmpresaPlanoModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idErpTipoPlano = jsonData['idErpTipoPlano'];
		idEmpresa = jsonData['idEmpresa'];
		dataInicio = jsonData['dataInicio'] != null ? DateTime.tryParse(jsonData['dataInicio']) : null;
		dataFim = jsonData['dataFim'] != null ? DateTime.tryParse(jsonData['dataFim']) : null;
		valorPago = jsonData['valorPago']?.toDouble();
		idPagamentoPlataforma = jsonData['idPagamentoPlataforma'];
		statusPagamentoPlataforma = jsonData['statusPagamentoPlataforma'];
		erpTipoPlanoModel = jsonData['erpTipoPlanoModel'] == null ? ErpTipoPlanoModel() : ErpTipoPlanoModel.fromJson(jsonData['erpTipoPlanoModel']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idErpTipoPlano'] = idErpTipoPlano != 0 ? idErpTipoPlano : null;
		jsonData['idEmpresa'] = idEmpresa != 0 ? idEmpresa : null;
		jsonData['dataInicio'] = dataInicio != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataInicio!) : null;
		jsonData['dataFim'] = dataFim != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataFim!) : null;
		jsonData['valorPago'] = valorPago;
		jsonData['idPagamentoPlataforma'] = idPagamentoPlataforma;
		jsonData['statusPagamentoPlataforma'] = statusPagamentoPlataforma;
		jsonData['erpTipoPlanoModel'] = erpTipoPlanoModel?.toJson;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}
	
}