import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:financeiro/app/infra/infra_imports.dart';
import 'package:financeiro/app/data/model/model_imports.dart';
import 'package:intl/intl.dart';
import 'package:financeiro/app/data/domain/domain_imports.dart';

class FinFechamentoCaixaBancoModel {
	int? id;
	int? idBancoContaCaixa;
	DateTime? dataFechamento;
	String? mesAno;
	String? mes;
	String? ano;
	double? saldoAnterior;
	double? recebimentos;
	double? pagamentos;
	double? saldoConta;
	double? chequeNaoCompensado;
	double? saldoDisponivel;
	BancoContaCaixaModel? bancoContaCaixaModel;

	FinFechamentoCaixaBancoModel({
		this.id,
		this.idBancoContaCaixa,
		this.dataFechamento,
		this.mesAno,
		this.mes,
		this.ano,
		this.saldoAnterior,
		this.recebimentos,
		this.pagamentos,
		this.saldoConta,
		this.chequeNaoCompensado,
		this.saldoDisponivel,
		this.bancoContaCaixaModel,
	});

	static List<String> dbColumns = <String>[
		'id',
		'data_fechamento',
		'mes_ano',
		'mes',
		'ano',
		'saldo_anterior',
		'recebimentos',
		'pagamentos',
		'saldo_conta',
		'cheque_nao_compensado',
		'saldo_disponivel',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Data Fechamento',
		'Mes Ano',
		'Mes',
		'Ano',
		'Saldo Anterior',
		'Recebimentos',
		'Pagamentos',
		'Saldo Conta',
		'Cheque Nao Compensado',
		'Saldo Disponivel',
	];

	FinFechamentoCaixaBancoModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idBancoContaCaixa = jsonData['idBancoContaCaixa'];
		dataFechamento = jsonData['dataFechamento'] != null ? DateTime.tryParse(jsonData['dataFechamento']) : null;
		mesAno = jsonData['mesAno'];
		mes = FinFechamentoCaixaBancoDomain.getMes(jsonData['mes']);
		ano = FinFechamentoCaixaBancoDomain.getAno(jsonData['ano']);
		saldoAnterior = jsonData['saldoAnterior']?.toDouble();
		recebimentos = jsonData['recebimentos']?.toDouble();
		pagamentos = jsonData['pagamentos']?.toDouble();
		saldoConta = jsonData['saldoConta']?.toDouble();
		chequeNaoCompensado = jsonData['chequeNaoCompensado']?.toDouble();
		saldoDisponivel = jsonData['saldoDisponivel']?.toDouble();
		bancoContaCaixaModel = jsonData['bancoContaCaixaModel'] == null ? BancoContaCaixaModel() : BancoContaCaixaModel.fromJson(jsonData['bancoContaCaixaModel']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idBancoContaCaixa'] = idBancoContaCaixa != 0 ? idBancoContaCaixa : null;
		jsonData['dataFechamento'] = dataFechamento != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataFechamento!) : null;
		jsonData['mesAno'] = mesAno;
		jsonData['mes'] = FinFechamentoCaixaBancoDomain.setMes(mes);
		jsonData['ano'] = FinFechamentoCaixaBancoDomain.setAno(ano);
		jsonData['saldoAnterior'] = saldoAnterior;
		jsonData['recebimentos'] = recebimentos;
		jsonData['pagamentos'] = pagamentos;
		jsonData['saldoConta'] = saldoConta;
		jsonData['chequeNaoCompensado'] = chequeNaoCompensado;
		jsonData['saldoDisponivel'] = saldoDisponivel;
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
		dataFechamento = Util.stringToDate(plutoRow.cells['dataFechamento']?.value);
		mesAno = plutoRow.cells['mesAno']?.value;
		mes = plutoRow.cells['mes']?.value != '' ? plutoRow.cells['mes']?.value : 'AAA';
		ano = plutoRow.cells['ano']?.value != '' ? plutoRow.cells['ano']?.value : 'AAA';
		saldoAnterior = plutoRow.cells['saldoAnterior']?.value?.toDouble();
		recebimentos = plutoRow.cells['recebimentos']?.value?.toDouble();
		pagamentos = plutoRow.cells['pagamentos']?.value?.toDouble();
		saldoConta = plutoRow.cells['saldoConta']?.value?.toDouble();
		chequeNaoCompensado = plutoRow.cells['chequeNaoCompensado']?.value?.toDouble();
		saldoDisponivel = plutoRow.cells['saldoDisponivel']?.value?.toDouble();
		bancoContaCaixaModel = BancoContaCaixaModel();
		bancoContaCaixaModel?.nome = plutoRow.cells['bancoContaCaixaModel']?.value;
	}	

	FinFechamentoCaixaBancoModel clone() {
		return FinFechamentoCaixaBancoModel(
			id: id,
			idBancoContaCaixa: idBancoContaCaixa,
			dataFechamento: dataFechamento,
			mesAno: mesAno,
			mes: mes,
			ano: ano,
			saldoAnterior: saldoAnterior,
			recebimentos: recebimentos,
			pagamentos: pagamentos,
			saldoConta: saldoConta,
			chequeNaoCompensado: chequeNaoCompensado,
			saldoDisponivel: saldoDisponivel,
		);			
	}

	
}