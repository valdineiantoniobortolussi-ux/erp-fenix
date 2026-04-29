import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:folha/app/infra/infra_imports.dart';
import 'package:folha/app/data/model/model_imports.dart';
import 'package:intl/intl.dart';

class FolhaLancamentoComissaoModel {
	int? id;
	int? idColaborador;
	String? competencia;
	DateTime? vencimento;
	double? baseCalculo;
	double? valorComissao;
	ViewPessoaColaboradorModel? viewPessoaColaboradorModel;

	FolhaLancamentoComissaoModel({
		this.id,
		this.idColaborador,
		this.competencia,
		this.vencimento,
		this.baseCalculo,
		this.valorComissao,
		this.viewPessoaColaboradorModel,
	});

	static List<String> dbColumns = <String>[
		'id',
		'competencia',
		'vencimento',
		'base_calculo',
		'valor_comissao',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Competencia',
		'Vencimento',
		'Base Calculo',
		'Valor Comissao',
	];

	FolhaLancamentoComissaoModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idColaborador = jsonData['idColaborador'];
		competencia = jsonData['competencia'];
		vencimento = jsonData['vencimento'] != null ? DateTime.tryParse(jsonData['vencimento']) : null;
		baseCalculo = jsonData['baseCalculo']?.toDouble();
		valorComissao = jsonData['valorComissao']?.toDouble();
		viewPessoaColaboradorModel = jsonData['viewPessoaColaboradorModel'] == null ? ViewPessoaColaboradorModel() : ViewPessoaColaboradorModel.fromJson(jsonData['viewPessoaColaboradorModel']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idColaborador'] = idColaborador != 0 ? idColaborador : null;
		jsonData['competencia'] = Util.removeMask(competencia);
		jsonData['vencimento'] = vencimento != null ? DateFormat('yyyy-MM-ddT00:00:00').format(vencimento!) : null;
		jsonData['baseCalculo'] = baseCalculo;
		jsonData['valorComissao'] = valorComissao;
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
		competencia = plutoRow.cells['competencia']?.value;
		vencimento = Util.stringToDate(plutoRow.cells['vencimento']?.value);
		baseCalculo = plutoRow.cells['baseCalculo']?.value?.toDouble();
		valorComissao = plutoRow.cells['valorComissao']?.value?.toDouble();
		viewPessoaColaboradorModel = ViewPessoaColaboradorModel();
		viewPessoaColaboradorModel?.nome = plutoRow.cells['viewPessoaColaboradorModel']?.value;
	}	

	FolhaLancamentoComissaoModel clone() {
		return FolhaLancamentoComissaoModel(
			id: id,
			idColaborador: idColaborador,
			competencia: competencia,
			vencimento: vencimento,
			baseCalculo: baseCalculo,
			valorComissao: valorComissao,
		);			
	}

	
}