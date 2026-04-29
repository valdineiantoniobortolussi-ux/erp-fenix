import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:financeiro/app/infra/infra_imports.dart';
import 'package:financeiro/app/data/model/model_imports.dart';
import 'package:intl/intl.dart';

class FinChequeRecebidoModel {
	int? id;
	int? idCliente;
	String? cpf;
	String? cnpj;
	String? nome;
	String? codigoBanco;
	String? codigoAgencia;
	String? conta;
	int? numero;
	DateTime? dataEmissao;
	DateTime? bomPara;
	DateTime? dataCompensacao;
	double? valor;
	DateTime? custodiaData;
	double? custodiaTarifa;
	double? custodiaComissao;
	DateTime? descontoData;
	double? descontoTarifa;
	double? descontoComissao;
	double? valorRecebido;
	ViewPessoaClienteModel? viewPessoaClienteModel;

	FinChequeRecebidoModel({
		this.id,
		this.idCliente,
		this.cpf,
		this.cnpj,
		this.nome,
		this.codigoBanco,
		this.codigoAgencia,
		this.conta,
		this.numero,
		this.dataEmissao,
		this.bomPara,
		this.dataCompensacao,
		this.valor,
		this.custodiaData,
		this.custodiaTarifa,
		this.custodiaComissao,
		this.descontoData,
		this.descontoTarifa,
		this.descontoComissao,
		this.valorRecebido,
		this.viewPessoaClienteModel,
	});

	static List<String> dbColumns = <String>[
		'id',
		'cpf',
		'cnpj',
		'nome',
		'codigo_banco',
		'codigo_agencia',
		'conta',
		'numero',
		'data_emissao',
		'bom_para',
		'data_compensacao',
		'valor',
		'custodia_data',
		'custodia_tarifa',
		'custodia_comissao',
		'desconto_data',
		'desconto_tarifa',
		'desconto_comissao',
		'valor_recebido',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Cpf',
		'Cnpj',
		'Nome',
		'Codigo Banco',
		'Codigo Agencia',
		'Conta',
		'Numero',
		'Data Emissao',
		'Bom Para',
		'Data Compensacao',
		'Valor',
		'Custodia Data',
		'Custodia Tarifa',
		'Custodia Comissao',
		'Desconto Data',
		'Desconto Tarifa',
		'Desconto Comissao',
		'Valor Recebido',
	];

	FinChequeRecebidoModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idCliente = jsonData['idCliente'];
		cpf = jsonData['cpf'];
		cnpj = jsonData['cnpj'];
		nome = jsonData['nome'];
		codigoBanco = jsonData['codigoBanco'];
		codigoAgencia = jsonData['codigoAgencia'];
		conta = jsonData['conta'];
		numero = jsonData['numero'];
		dataEmissao = jsonData['dataEmissao'] != null ? DateTime.tryParse(jsonData['dataEmissao']) : null;
		bomPara = jsonData['bomPara'] != null ? DateTime.tryParse(jsonData['bomPara']) : null;
		dataCompensacao = jsonData['dataCompensacao'] != null ? DateTime.tryParse(jsonData['dataCompensacao']) : null;
		valor = jsonData['valor']?.toDouble();
		custodiaData = jsonData['custodiaData'] != null ? DateTime.tryParse(jsonData['custodiaData']) : null;
		custodiaTarifa = jsonData['custodiaTarifa']?.toDouble();
		custodiaComissao = jsonData['custodiaComissao']?.toDouble();
		descontoData = jsonData['descontoData'] != null ? DateTime.tryParse(jsonData['descontoData']) : null;
		descontoTarifa = jsonData['descontoTarifa']?.toDouble();
		descontoComissao = jsonData['descontoComissao']?.toDouble();
		valorRecebido = jsonData['valorRecebido']?.toDouble();
		viewPessoaClienteModel = jsonData['viewPessoaClienteModel'] == null ? ViewPessoaClienteModel() : ViewPessoaClienteModel.fromJson(jsonData['viewPessoaClienteModel']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idCliente'] = idCliente != 0 ? idCliente : null;
		jsonData['cpf'] = Util.removeMask(cpf);
		jsonData['cnpj'] = Util.removeMask(cnpj);
		jsonData['nome'] = nome;
		jsonData['codigoBanco'] = codigoBanco;
		jsonData['codigoAgencia'] = codigoAgencia;
		jsonData['conta'] = conta;
		jsonData['numero'] = numero;
		jsonData['dataEmissao'] = dataEmissao != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataEmissao!) : null;
		jsonData['bomPara'] = bomPara != null ? DateFormat('yyyy-MM-ddT00:00:00').format(bomPara!) : null;
		jsonData['dataCompensacao'] = dataCompensacao != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataCompensacao!) : null;
		jsonData['valor'] = valor;
		jsonData['custodiaData'] = custodiaData != null ? DateFormat('yyyy-MM-ddT00:00:00').format(custodiaData!) : null;
		jsonData['custodiaTarifa'] = custodiaTarifa;
		jsonData['custodiaComissao'] = custodiaComissao;
		jsonData['descontoData'] = descontoData != null ? DateFormat('yyyy-MM-ddT00:00:00').format(descontoData!) : null;
		jsonData['descontoTarifa'] = descontoTarifa;
		jsonData['descontoComissao'] = descontoComissao;
		jsonData['valorRecebido'] = valorRecebido;
		jsonData['viewPessoaClienteModel'] = viewPessoaClienteModel?.toJson;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idCliente = plutoRow.cells['idCliente']?.value;
		cpf = plutoRow.cells['cpf']?.value;
		cnpj = plutoRow.cells['cnpj']?.value;
		nome = plutoRow.cells['nome']?.value;
		codigoBanco = plutoRow.cells['codigoBanco']?.value;
		codigoAgencia = plutoRow.cells['codigoAgencia']?.value;
		conta = plutoRow.cells['conta']?.value;
		numero = plutoRow.cells['numero']?.value;
		dataEmissao = Util.stringToDate(plutoRow.cells['dataEmissao']?.value);
		bomPara = Util.stringToDate(plutoRow.cells['bomPara']?.value);
		dataCompensacao = Util.stringToDate(plutoRow.cells['dataCompensacao']?.value);
		valor = plutoRow.cells['valor']?.value?.toDouble();
		custodiaData = Util.stringToDate(plutoRow.cells['custodiaData']?.value);
		custodiaTarifa = plutoRow.cells['custodiaTarifa']?.value?.toDouble();
		custodiaComissao = plutoRow.cells['custodiaComissao']?.value?.toDouble();
		descontoData = Util.stringToDate(plutoRow.cells['descontoData']?.value);
		descontoTarifa = plutoRow.cells['descontoTarifa']?.value?.toDouble();
		descontoComissao = plutoRow.cells['descontoComissao']?.value?.toDouble();
		valorRecebido = plutoRow.cells['valorRecebido']?.value?.toDouble();
		viewPessoaClienteModel = ViewPessoaClienteModel();
		viewPessoaClienteModel?.nome = plutoRow.cells['viewPessoaClienteModel']?.value;
	}	

	FinChequeRecebidoModel clone() {
		return FinChequeRecebidoModel(
			id: id,
			idCliente: idCliente,
			cpf: cpf,
			cnpj: cnpj,
			nome: nome,
			codigoBanco: codigoBanco,
			codigoAgencia: codigoAgencia,
			conta: conta,
			numero: numero,
			dataEmissao: dataEmissao,
			bomPara: bomPara,
			dataCompensacao: dataCompensacao,
			valor: valor,
			custodiaData: custodiaData,
			custodiaTarifa: custodiaTarifa,
			custodiaComissao: custodiaComissao,
			descontoData: descontoData,
			descontoTarifa: descontoTarifa,
			descontoComissao: descontoComissao,
			valorRecebido: valorRecebido,
		);			
	}

	
}