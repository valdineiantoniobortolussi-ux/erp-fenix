import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:estoque/app/infra/infra_imports.dart';
import 'package:estoque/app/data/model/model_imports.dart';
import 'package:intl/intl.dart';
import 'package:estoque/app/data/domain/domain_imports.dart';

class EstoqueReajusteCabecalhoModel {
	int? id;
	int? idColaborador;
	DateTime? dataReajuste;
	double? taxa;
	String? tipoReajuste;
	String? justificativa;
	List<EstoqueReajusteDetalheModel>? estoqueReajusteDetalheModelList;
	ViewPessoaColaboradorModel? viewPessoaColaboradorModel;

	EstoqueReajusteCabecalhoModel({
		this.id,
		this.idColaborador,
		this.dataReajuste,
		this.taxa,
		this.tipoReajuste,
		this.justificativa,
		this.estoqueReajusteDetalheModelList,
		this.viewPessoaColaboradorModel,
	});

	static List<String> dbColumns = <String>[
		'id',
		'data_reajuste',
		'taxa',
		'tipo_reajuste',
		'justificativa',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Data Reajuste',
		'Taxa',
		'Tipo Reajuste',
		'Justificativa',
	];

	EstoqueReajusteCabecalhoModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idColaborador = jsonData['idColaborador'];
		dataReajuste = jsonData['dataReajuste'] != null ? DateTime.tryParse(jsonData['dataReajuste']) : null;
		taxa = jsonData['taxa']?.toDouble();
		tipoReajuste = EstoqueReajusteCabecalhoDomain.getTipoReajuste(jsonData['tipoReajuste']);
		justificativa = jsonData['justificativa'];
		estoqueReajusteDetalheModelList = (jsonData['estoqueReajusteDetalheModelList'] as Iterable?)?.map((m) => EstoqueReajusteDetalheModel.fromJson(m)).toList() ?? [];
		viewPessoaColaboradorModel = jsonData['viewPessoaColaboradorModel'] == null ? ViewPessoaColaboradorModel() : ViewPessoaColaboradorModel.fromJson(jsonData['viewPessoaColaboradorModel']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idColaborador'] = idColaborador != 0 ? idColaborador : null;
		jsonData['dataReajuste'] = dataReajuste != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataReajuste!) : null;
		jsonData['taxa'] = taxa;
		jsonData['tipoReajuste'] = EstoqueReajusteCabecalhoDomain.setTipoReajuste(tipoReajuste);
		jsonData['justificativa'] = justificativa;
		
		var estoqueReajusteDetalheModelLocalList = []; 
		for (EstoqueReajusteDetalheModel object in estoqueReajusteDetalheModelList ?? []) { 
			estoqueReajusteDetalheModelLocalList.add(object.toJson); 
		}
		jsonData['estoqueReajusteDetalheModelList'] = estoqueReajusteDetalheModelLocalList;
		jsonData['viewPessoaColaboradorModel'] = viewPessoaColaboradorModel?.toJson;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idColaborador = plutoRow.cells['idColaborador']?.value;
		dataReajuste = Util.stringToDate(plutoRow.cells['dataReajuste']?.value);
		taxa = plutoRow.cells['taxa']?.value?.toDouble();
		tipoReajuste = plutoRow.cells['tipoReajuste']?.value != '' ? plutoRow.cells['tipoReajuste']?.value : 'Aumentar';
		justificativa = plutoRow.cells['justificativa']?.value;
		estoqueReajusteDetalheModelList = [];
		viewPessoaColaboradorModel = ViewPessoaColaboradorModel();
		viewPessoaColaboradorModel?.nome = plutoRow.cells['viewPessoaColaboradorModel']?.value;
	}	

	EstoqueReajusteCabecalhoModel clone() {
		return EstoqueReajusteCabecalhoModel(
			id: id,
			idColaborador: idColaborador,
			dataReajuste: dataReajuste,
			taxa: taxa,
			tipoReajuste: tipoReajuste,
			justificativa: justificativa,
			estoqueReajusteDetalheModelList: estoqueReajusteDetalheModelListClone(estoqueReajusteDetalheModelList!),
		);			
	}

	estoqueReajusteDetalheModelListClone(List<EstoqueReajusteDetalheModel> estoqueReajusteDetalheModelList) { 
		List<EstoqueReajusteDetalheModel> resultList = [];
		for (var estoqueReajusteDetalheModel in estoqueReajusteDetalheModelList) {
			resultList.add(
				EstoqueReajusteDetalheModel(
					id: estoqueReajusteDetalheModel.id,
					idEstoqueReajusteCabecalho: estoqueReajusteDetalheModel.idEstoqueReajusteCabecalho,
					idProduto: estoqueReajusteDetalheModel.idProduto,
					valorOriginal: estoqueReajusteDetalheModel.valorOriginal,
					valorReajuste: estoqueReajusteDetalheModel.valorReajuste,
				)
			);
		}
		return resultList;
	}

	
}