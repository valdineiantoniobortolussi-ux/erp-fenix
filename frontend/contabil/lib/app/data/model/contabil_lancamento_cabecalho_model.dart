import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:contabil/app/infra/infra_imports.dart';
import 'package:contabil/app/data/model/model_imports.dart';
import 'package:intl/intl.dart';
import 'package:contabil/app/data/domain/domain_imports.dart';

class ContabilLancamentoCabecalhoModel {
	int? id;
	int? idContabilLote;
	DateTime? dataLancamento;
	DateTime? dataInclusao;
	String? tipo;
	String? liberado;
	double? valor;
	List<ContabilLancamentoDetalheModel>? contabilLancamentoDetalheModelList;
	ContabilLoteModel? contabilLoteModel;

	ContabilLancamentoCabecalhoModel({
		this.id,
		this.idContabilLote,
		this.dataLancamento,
		this.dataInclusao,
		this.tipo,
		this.liberado,
		this.valor,
		this.contabilLancamentoDetalheModelList,
		this.contabilLoteModel,
	});

	static List<String> dbColumns = <String>[
		'id',
		'data_lancamento',
		'data_inclusao',
		'tipo',
		'liberado',
		'valor',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Data Lancamento',
		'Data Inclusao',
		'Tipo',
		'Liberado',
		'Valor',
	];

	ContabilLancamentoCabecalhoModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idContabilLote = jsonData['idContabilLote'];
		dataLancamento = jsonData['dataLancamento'] != null ? DateTime.tryParse(jsonData['dataLancamento']) : null;
		dataInclusao = jsonData['dataInclusao'] != null ? DateTime.tryParse(jsonData['dataInclusao']) : null;
		tipo = ContabilLancamentoCabecalhoDomain.getTipo(jsonData['tipo']);
		liberado = ContabilLancamentoCabecalhoDomain.getLiberado(jsonData['liberado']);
		valor = jsonData['valor']?.toDouble();
		contabilLancamentoDetalheModelList = (jsonData['contabilLancamentoDetalheModelList'] as Iterable?)?.map((m) => ContabilLancamentoDetalheModel.fromJson(m)).toList() ?? [];
		contabilLoteModel = jsonData['contabilLoteModel'] == null ? ContabilLoteModel() : ContabilLoteModel.fromJson(jsonData['contabilLoteModel']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idContabilLote'] = idContabilLote != 0 ? idContabilLote : null;
		jsonData['dataLancamento'] = dataLancamento != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataLancamento!) : null;
		jsonData['dataInclusao'] = dataInclusao != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataInclusao!) : null;
		jsonData['tipo'] = ContabilLancamentoCabecalhoDomain.setTipo(tipo);
		jsonData['liberado'] = ContabilLancamentoCabecalhoDomain.setLiberado(liberado);
		jsonData['valor'] = valor;
		
		var contabilLancamentoDetalheModelLocalList = []; 
		for (ContabilLancamentoDetalheModel object in contabilLancamentoDetalheModelList ?? []) { 
			contabilLancamentoDetalheModelLocalList.add(object.toJson); 
		}
		jsonData['contabilLancamentoDetalheModelList'] = contabilLancamentoDetalheModelLocalList;
		jsonData['contabilLoteModel'] = contabilLoteModel?.toJson;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idContabilLote = plutoRow.cells['idContabilLote']?.value;
		dataLancamento = Util.stringToDate(plutoRow.cells['dataLancamento']?.value);
		dataInclusao = Util.stringToDate(plutoRow.cells['dataInclusao']?.value);
		tipo = plutoRow.cells['tipo']?.value != '' ? plutoRow.cells['tipo']?.value : 'UDVC=Um Débito para Vários Créditos';
		liberado = plutoRow.cells['liberado']?.value != '' ? plutoRow.cells['liberado']?.value : 'Sim';
		valor = plutoRow.cells['valor']?.value?.toDouble();
		contabilLancamentoDetalheModelList = [];
		contabilLoteModel = ContabilLoteModel();
		contabilLoteModel?.descricao = plutoRow.cells['contabilLoteModel']?.value;
	}	

	ContabilLancamentoCabecalhoModel clone() {
		return ContabilLancamentoCabecalhoModel(
			id: id,
			idContabilLote: idContabilLote,
			dataLancamento: dataLancamento,
			dataInclusao: dataInclusao,
			tipo: tipo,
			liberado: liberado,
			valor: valor,
			contabilLancamentoDetalheModelList: contabilLancamentoDetalheModelListClone(contabilLancamentoDetalheModelList!),
		);			
	}

	contabilLancamentoDetalheModelListClone(List<ContabilLancamentoDetalheModel> contabilLancamentoDetalheModelList) { 
		List<ContabilLancamentoDetalheModel> resultList = [];
		for (var contabilLancamentoDetalheModel in contabilLancamentoDetalheModelList) {
			resultList.add(
				ContabilLancamentoDetalheModel(
					id: contabilLancamentoDetalheModel.id,
					idContabilLancamentoCab: contabilLancamentoDetalheModel.idContabilLancamentoCab,
					idContabilConta: contabilLancamentoDetalheModel.idContabilConta,
					idContabilHistorico: contabilLancamentoDetalheModel.idContabilHistorico,
					tipo: contabilLancamentoDetalheModel.tipo,
					valor: contabilLancamentoDetalheModel.valor,
					historico: contabilLancamentoDetalheModel.historico,
				)
			);
		}
		return resultList;
	}

	
}