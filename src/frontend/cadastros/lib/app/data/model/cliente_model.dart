import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:cadastros/app/infra/infra_imports.dart';
import 'package:cadastros/app/data/model/model_imports.dart';
import 'package:intl/intl.dart';

class ClienteModel {
	int? id;
	int? idPessoa;
	int? idTabelaPreco;
	DateTime? desde;
	DateTime? dataCadastro;
	double? taxaDesconto;
	double? limiteCredito;
	String? observacao;
	TabelaPrecoModel? tabelaPrecoModel;

	ClienteModel({
		this.id,
		this.idPessoa,
		this.idTabelaPreco,
		this.desde,
		this.dataCadastro,
		this.taxaDesconto,
		this.limiteCredito,
		this.observacao,
		this.tabelaPrecoModel,
	});

	static List<String> dbColumns = <String>[
		'id',
		'desde',
		'data_cadastro',
		'taxa_desconto',
		'limite_credito',
		'observacao',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Desde',
		'Data Cadastro',
		'Taxa Desconto',
		'Limite Credito',
		'Observacao',
	];

	ClienteModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idPessoa = jsonData['idPessoa'];
		idTabelaPreco = jsonData['idTabelaPreco'];
		desde = jsonData['desde'] != null ? DateTime.tryParse(jsonData['desde']) : null;
		dataCadastro = jsonData['dataCadastro'] != null ? DateTime.tryParse(jsonData['dataCadastro']) : null;
		taxaDesconto = jsonData['taxaDesconto']?.toDouble();
		limiteCredito = jsonData['limiteCredito']?.toDouble();
		observacao = jsonData['observacao'];
		tabelaPrecoModel = jsonData['tabelaPrecoModel'] == null ? TabelaPrecoModel() : TabelaPrecoModel.fromJson(jsonData['tabelaPrecoModel']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idPessoa'] = idPessoa != 0 ? idPessoa : null;
		jsonData['idTabelaPreco'] = idTabelaPreco != 0 ? idTabelaPreco : null;
		jsonData['desde'] = desde != null ? DateFormat('yyyy-MM-ddT00:00:00').format(desde!) : null;
		jsonData['dataCadastro'] = dataCadastro != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataCadastro!) : null;
		jsonData['taxaDesconto'] = taxaDesconto;
		jsonData['limiteCredito'] = limiteCredito;
		jsonData['observacao'] = observacao;
		jsonData['tabelaPrecoModel'] = tabelaPrecoModel?.toJson;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idPessoa = plutoRow.cells['idPessoa']?.value;
		idTabelaPreco = plutoRow.cells['idTabelaPreco']?.value;
		desde = Util.stringToDate(plutoRow.cells['desde']?.value);
		dataCadastro = Util.stringToDate(plutoRow.cells['dataCadastro']?.value);
		taxaDesconto = plutoRow.cells['taxaDesconto']?.value?.toDouble();
		limiteCredito = plutoRow.cells['limiteCredito']?.value?.toDouble();
		observacao = plutoRow.cells['observacao']?.value;
		tabelaPrecoModel = TabelaPrecoModel();
		tabelaPrecoModel?.nome = plutoRow.cells['tabelaPrecoModel']?.value;
	}	

	ClienteModel clone() {
		return ClienteModel(
			id: id,
			idPessoa: idPessoa,
			idTabelaPreco: idTabelaPreco,
			desde: desde,
			dataCadastro: dataCadastro,
			taxaDesconto: taxaDesconto,
			limiteCredito: limiteCredito,
			observacao: observacao,
		);			
	}

	
}