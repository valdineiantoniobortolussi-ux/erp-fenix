import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:comissoes/app/infra/infra_imports.dart';
import 'package:comissoes/app/data/model/model_imports.dart';
import 'package:intl/intl.dart';

class ComissaoObjetivoModel {
	int? id;
	int? idComissaoPerfil;
	String? codigo;
	String? nome;
	String? descricao;
	double? taxaPagamento;
	double? valorPagamento;
	double? valorMeta;
	DateTime? dataInicio;
	DateTime? dataFim;
	ComissaoPerfilModel? comissaoPerfilModel;

	ComissaoObjetivoModel({
		this.id,
		this.idComissaoPerfil,
		this.codigo,
		this.nome,
		this.descricao,
		this.taxaPagamento,
		this.valorPagamento,
		this.valorMeta,
		this.dataInicio,
		this.dataFim,
		this.comissaoPerfilModel,
	});

	static List<String> dbColumns = <String>[
		'id',
		'codigo',
		'nome',
		'descricao',
		'taxa_pagamento',
		'valor_pagamento',
		'valor_meta',
		'data_inicio',
		'data_fim',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Codigo',
		'Nome',
		'Descricao',
		'Taxa Pagamento',
		'Valor Pagamento',
		'Valor Meta',
		'Data Inicio',
		'Data Fim',
	];

	ComissaoObjetivoModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idComissaoPerfil = jsonData['idComissaoPerfil'];
		codigo = jsonData['codigo'];
		nome = jsonData['nome'];
		descricao = jsonData['descricao'];
		taxaPagamento = jsonData['taxaPagamento']?.toDouble();
		valorPagamento = jsonData['valorPagamento']?.toDouble();
		valorMeta = jsonData['valorMeta']?.toDouble();
		dataInicio = jsonData['dataInicio'] != null ? DateTime.tryParse(jsonData['dataInicio']) : null;
		dataFim = jsonData['dataFim'] != null ? DateTime.tryParse(jsonData['dataFim']) : null;
		comissaoPerfilModel = jsonData['comissaoPerfilModel'] == null ? ComissaoPerfilModel() : ComissaoPerfilModel.fromJson(jsonData['comissaoPerfilModel']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idComissaoPerfil'] = idComissaoPerfil != 0 ? idComissaoPerfil : null;
		jsonData['codigo'] = codigo;
		jsonData['nome'] = nome;
		jsonData['descricao'] = descricao;
		jsonData['taxaPagamento'] = taxaPagamento;
		jsonData['valorPagamento'] = valorPagamento;
		jsonData['valorMeta'] = valorMeta;
		jsonData['dataInicio'] = dataInicio != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataInicio!) : null;
		jsonData['dataFim'] = dataFim != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataFim!) : null;
		jsonData['comissaoPerfilModel'] = comissaoPerfilModel?.toJson;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idComissaoPerfil = plutoRow.cells['idComissaoPerfil']?.value;
		codigo = plutoRow.cells['codigo']?.value;
		nome = plutoRow.cells['nome']?.value;
		descricao = plutoRow.cells['descricao']?.value;
		taxaPagamento = plutoRow.cells['taxaPagamento']?.value?.toDouble();
		valorPagamento = plutoRow.cells['valorPagamento']?.value?.toDouble();
		valorMeta = plutoRow.cells['valorMeta']?.value?.toDouble();
		dataInicio = Util.stringToDate(plutoRow.cells['dataInicio']?.value);
		dataFim = Util.stringToDate(plutoRow.cells['dataFim']?.value);
		comissaoPerfilModel = ComissaoPerfilModel();
		comissaoPerfilModel?.nome = plutoRow.cells['comissaoPerfilModel']?.value;
	}	

	ComissaoObjetivoModel clone() {
		return ComissaoObjetivoModel(
			id: id,
			idComissaoPerfil: idComissaoPerfil,
			codigo: codigo,
			nome: nome,
			descricao: descricao,
			taxaPagamento: taxaPagamento,
			valorPagamento: valorPagamento,
			valorMeta: valorMeta,
			dataInicio: dataInicio,
			dataFim: dataFim,
		);			
	}

	
}