import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:contabil/app/infra/infra_imports.dart';
import 'package:contabil/app/data/model/model_imports.dart';
import 'package:intl/intl.dart';
import 'package:contabil/app/data/domain/domain_imports.dart';

class ContabilContaModel {
	int? id;
	int? idPlanoConta;
	int? idPlanoContaRefSped;
	int? idContabilConta;
	String? classificacao;
	String? tipo;
	String? descricao;
	DateTime? dataInclusao;
	String? situacao;
	String? natureza;
	String? patrimonioResultado;
	String? livroCaixa;
	String? dfc;
	String? codigoEfd;
	String? ordem;
	String? codigoReduzido;
	PlanoContaModel? planoContaModel;
	PlanoContaRefSpedModel? planoContaRefSpedModel;

	ContabilContaModel({
		this.id,
		this.idPlanoConta,
		this.idPlanoContaRefSped,
		this.idContabilConta,
		this.classificacao,
		this.tipo,
		this.descricao,
		this.dataInclusao,
		this.situacao,
		this.natureza,
		this.patrimonioResultado,
		this.livroCaixa,
		this.dfc,
		this.codigoEfd,
		this.ordem,
		this.codigoReduzido,
		this.planoContaModel,
		this.planoContaRefSpedModel,
	});

	static List<String> dbColumns = <String>[
		'id',
		'id_contabil_conta',
		'classificacao',
		'tipo',
		'descricao',
		'data_inclusao',
		'situacao',
		'natureza',
		'patrimonio_resultado',
		'livro_caixa',
		'dfc',
		'codigo_efd',
		'ordem',
		'codigo_reduzido',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Id Contabil Conta',
		'Classificacao',
		'Tipo',
		'Descricao',
		'Data Inclusao',
		'Situacao',
		'Natureza',
		'Patrimonio Resultado',
		'Livro Caixa',
		'Dfc',
		'Codigo Efd',
		'Ordem',
		'Codigo Reduzido',
	];

	ContabilContaModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idPlanoConta = jsonData['idPlanoConta'];
		idPlanoContaRefSped = jsonData['idPlanoContaRefSped'];
		idContabilConta = jsonData['idContabilConta'];
		classificacao = jsonData['classificacao'];
		tipo = ContabilContaDomain.getTipo(jsonData['tipo']);
		descricao = jsonData['descricao'];
		dataInclusao = jsonData['dataInclusao'] != null ? DateTime.tryParse(jsonData['dataInclusao']) : null;
		situacao = ContabilContaDomain.getSituacao(jsonData['situacao']);
		natureza = ContabilContaDomain.getNatureza(jsonData['natureza']);
		patrimonioResultado = ContabilContaDomain.getPatrimonioResultado(jsonData['patrimonioResultado']);
		livroCaixa = ContabilContaDomain.getLivroCaixa(jsonData['livroCaixa']);
		dfc = ContabilContaDomain.getDfc(jsonData['dfc']);
		codigoEfd = jsonData['codigoEfd'];
		ordem = jsonData['ordem'];
		codigoReduzido = jsonData['codigoReduzido'];
		planoContaModel = jsonData['planoContaModel'] == null ? PlanoContaModel() : PlanoContaModel.fromJson(jsonData['planoContaModel']);
		planoContaRefSpedModel = jsonData['planoContaRefSpedModel'] == null ? PlanoContaRefSpedModel() : PlanoContaRefSpedModel.fromJson(jsonData['planoContaRefSpedModel']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idPlanoConta'] = idPlanoConta != 0 ? idPlanoConta : null;
		jsonData['idPlanoContaRefSped'] = idPlanoContaRefSped != 0 ? idPlanoContaRefSped : null;
		jsonData['idContabilConta'] = idContabilConta;
		jsonData['classificacao'] = classificacao;
		jsonData['tipo'] = ContabilContaDomain.setTipo(tipo);
		jsonData['descricao'] = descricao;
		jsonData['dataInclusao'] = dataInclusao != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataInclusao!) : null;
		jsonData['situacao'] = ContabilContaDomain.setSituacao(situacao);
		jsonData['natureza'] = ContabilContaDomain.setNatureza(natureza);
		jsonData['patrimonioResultado'] = ContabilContaDomain.setPatrimonioResultado(patrimonioResultado);
		jsonData['livroCaixa'] = ContabilContaDomain.setLivroCaixa(livroCaixa);
		jsonData['dfc'] = ContabilContaDomain.setDfc(dfc);
		jsonData['codigoEfd'] = codigoEfd;
		jsonData['ordem'] = ordem;
		jsonData['codigoReduzido'] = codigoReduzido;
		jsonData['planoContaModel'] = planoContaModel?.toJson;
		jsonData['planoContaRefSpedModel'] = planoContaRefSpedModel?.toJson;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idPlanoConta = plutoRow.cells['idPlanoConta']?.value;
		idPlanoContaRefSped = plutoRow.cells['idPlanoContaRefSped']?.value;
		idContabilConta = plutoRow.cells['idContabilConta']?.value;
		classificacao = plutoRow.cells['classificacao']?.value;
		tipo = plutoRow.cells['tipo']?.value != '' ? plutoRow.cells['tipo']?.value : 'Sintética';
		descricao = plutoRow.cells['descricao']?.value;
		dataInclusao = Util.stringToDate(plutoRow.cells['dataInclusao']?.value);
		situacao = plutoRow.cells['situacao']?.value != '' ? plutoRow.cells['situacao']?.value : 'Ativa';
		natureza = plutoRow.cells['natureza']?.value != '' ? plutoRow.cells['natureza']?.value : 'Credora';
		patrimonioResultado = plutoRow.cells['patrimonioResultado']?.value != '' ? plutoRow.cells['patrimonioResultado']?.value : 'Patrimonio';
		livroCaixa = plutoRow.cells['livroCaixa']?.value != '' ? plutoRow.cells['livroCaixa']?.value : 'Sim';
		dfc = plutoRow.cells['dfc']?.value != '' ? plutoRow.cells['dfc']?.value : 'Não participa';
		codigoEfd = plutoRow.cells['codigoEfd']?.value;
		ordem = plutoRow.cells['ordem']?.value;
		codigoReduzido = plutoRow.cells['codigoReduzido']?.value;
		planoContaModel = PlanoContaModel();
		planoContaModel?.nome = plutoRow.cells['planoContaModel']?.value;
		planoContaRefSpedModel = PlanoContaRefSpedModel();
		planoContaRefSpedModel?.codCtaRef = plutoRow.cells['planoContaRefSpedModel']?.value;
	}	

	ContabilContaModel clone() {
		return ContabilContaModel(
			id: id,
			idPlanoConta: idPlanoConta,
			idPlanoContaRefSped: idPlanoContaRefSped,
			idContabilConta: idContabilConta,
			classificacao: classificacao,
			tipo: tipo,
			descricao: descricao,
			dataInclusao: dataInclusao,
			situacao: situacao,
			natureza: natureza,
			patrimonioResultado: patrimonioResultado,
			livroCaixa: livroCaixa,
			dfc: dfc,
			codigoEfd: codigoEfd,
			ordem: ordem,
			codigoReduzido: codigoReduzido,
		);			
	}

	
}
