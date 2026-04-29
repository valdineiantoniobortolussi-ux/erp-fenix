import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:financeiro/app/infra/infra_imports.dart';
import 'package:financeiro/app/data/model/model_imports.dart';
import 'package:intl/intl.dart';
import 'package:financeiro/app/data/domain/domain_imports.dart';

class FinExtratoContaBancoModel {
	int? id;
	int? idBancoContaCaixa;
	String? mesAno;
	String? mes;
	String? ano;
	DateTime? dataMovimento;
	DateTime? dataBalancete;
	String? historico;
	String? documento;
	double? valor;
	String? conciliado;
	String? observacao;
	BancoContaCaixaModel? bancoContaCaixaModel;

	FinExtratoContaBancoModel({
		this.id,
		this.idBancoContaCaixa,
		this.mesAno,
		this.mes,
		this.ano,
		this.dataMovimento,
		this.dataBalancete,
		this.historico,
		this.documento,
		this.valor,
		this.conciliado,
		this.observacao,
		this.bancoContaCaixaModel,
	});

	static List<String> dbColumns = <String>[
		'id',
		'mes_ano',
		'mes',
		'ano',
		'data_movimento',
		'data_balancete',
		'historico',
		'documento',
		'valor',
		'conciliado',
		'observacao',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Mes Ano',
		'Mes',
		'Ano',
		'Data Movimento',
		'Data Balancete',
		'Historico',
		'Documento',
		'Valor',
		'Conciliado',
		'Observacao',
	];

	FinExtratoContaBancoModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idBancoContaCaixa = jsonData['idBancoContaCaixa'];
		mesAno = jsonData['mesAno'];
		mes = jsonData['mes'];
		ano = jsonData['ano'];
		dataMovimento = jsonData['dataMovimento'] != null ? DateTime.tryParse(jsonData['dataMovimento']) : null;
		dataBalancete = jsonData['dataBalancete'] != null ? DateTime.tryParse(jsonData['dataBalancete']) : null;
		historico = jsonData['historico'];
		documento = jsonData['documento'];
		valor = jsonData['valor']?.toDouble();
		conciliado = FinExtratoContaBancoDomain.getConciliado(jsonData['conciliado']);
		observacao = jsonData['observacao'];
		bancoContaCaixaModel = jsonData['bancoContaCaixaModel'] == null ? BancoContaCaixaModel() : BancoContaCaixaModel.fromJson(jsonData['bancoContaCaixaModel']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idBancoContaCaixa'] = idBancoContaCaixa != 0 ? idBancoContaCaixa : null;
		jsonData['mesAno'] = mesAno;
		jsonData['mes'] = mes;
		jsonData['ano'] = ano;
		jsonData['dataMovimento'] = dataMovimento != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataMovimento!) : null;
		jsonData['dataBalancete'] = dataBalancete != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataBalancete!) : null;
		jsonData['historico'] = historico;
		jsonData['documento'] = documento;
		jsonData['valor'] = valor;
		jsonData['conciliado'] = FinExtratoContaBancoDomain.setConciliado(conciliado);
		jsonData['observacao'] = observacao;
		jsonData['bancoContaCaixaModel'] = bancoContaCaixaModel?.toJson;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idBancoContaCaixa = plutoRow.cells['idBancoContaCaixa']?.value;
		mesAno = plutoRow.cells['mesAno']?.value;
		mes = plutoRow.cells['mes']?.value;
		ano = plutoRow.cells['ano']?.value;
		dataMovimento = Util.stringToDate(plutoRow.cells['dataMovimento']?.value);
		dataBalancete = Util.stringToDate(plutoRow.cells['dataBalancete']?.value);
		historico = plutoRow.cells['historico']?.value;
		documento = plutoRow.cells['documento']?.value;
		valor = plutoRow.cells['valor']?.value?.toDouble();
		conciliado = plutoRow.cells['conciliado']?.value != '' ? plutoRow.cells['conciliado']?.value : 'S';
		observacao = plutoRow.cells['observacao']?.value;
		bancoContaCaixaModel = BancoContaCaixaModel();
		bancoContaCaixaModel?.nome = plutoRow.cells['bancoContaCaixaModel']?.value;
	}	

	FinExtratoContaBancoModel clone() {
		return FinExtratoContaBancoModel(
			id: id,
			idBancoContaCaixa: idBancoContaCaixa,
			mesAno: mesAno,
			mes: mes,
			ano: ano,
			dataMovimento: dataMovimento,
			dataBalancete: dataBalancete,
			historico: historico,
			documento: documento,
			valor: valor,
			conciliado: conciliado,
			observacao: observacao,
		);			
	}

	
}