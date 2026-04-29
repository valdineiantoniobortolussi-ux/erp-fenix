import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:financeiro/app/infra/infra_imports.dart';
import 'package:financeiro/app/data/model/model_imports.dart';
import 'package:intl/intl.dart';

class FinLancamentoPagarModel {
	int? id;
	int? idFornecedor;
	int? idBancoContaCaixa;
	int? idFinDocumentoOrigem;
	int? idFinNaturezaFinanceira;
	int? quantidadeParcela;
	double? valorAPagar;
	DateTime? dataLancamento;
	String? numeroDocumento;
	DateTime? primeiroVencimento;
	int? intervaloEntreParcelas;
	String? diaFixo;
	String? imagemDocumento;
	List<FinParcelaPagarModel>? finParcelaPagarModelList;
	FinDocumentoOrigemModel? finDocumentoOrigemModel;
	BancoContaCaixaModel? bancoContaCaixaModel;
	FinNaturezaFinanceiraModel? finNaturezaFinanceiraModel;
	ViewPessoaFornecedorModel? viewPessoaFornecedorModel;

	FinLancamentoPagarModel({
		this.id,
		this.idFornecedor,
		this.idBancoContaCaixa,
		this.idFinDocumentoOrigem,
		this.idFinNaturezaFinanceira,
		this.quantidadeParcela,
		this.valorAPagar,
		this.dataLancamento,
		this.numeroDocumento,
		this.primeiroVencimento,
		this.intervaloEntreParcelas,
		this.diaFixo,
		this.imagemDocumento,
		this.finParcelaPagarModelList,
		this.finDocumentoOrigemModel,
		this.bancoContaCaixaModel,
		this.finNaturezaFinanceiraModel,
		this.viewPessoaFornecedorModel,
	});

	static List<String> dbColumns = <String>[
		'id',
		'quantidade_parcela',
		'valor_a_pagar',
		'data_lancamento',
		'numero_documento',
		'primeiro_vencimento',
		'intervalo_entre_parcelas',
		'dia_fixo',
		'imagem_documento',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Quantidade Parcela',
		'Valor A Pagar',
		'Data Lancamento',
		'Numero Documento',
		'Primeiro Vencimento',
		'Intervalo Entre Parcelas',
		'Dia Fixo',
		'Imagem Documento',
	];

	FinLancamentoPagarModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idFornecedor = jsonData['idFornecedor'];
		idBancoContaCaixa = jsonData['idBancoContaCaixa'];
		idFinDocumentoOrigem = jsonData['idFinDocumentoOrigem'];
		idFinNaturezaFinanceira = jsonData['idFinNaturezaFinanceira'];
		quantidadeParcela = jsonData['quantidadeParcela'];
		valorAPagar = jsonData['valorAPagar']?.toDouble();
		dataLancamento = jsonData['dataLancamento'] != null ? DateTime.tryParse(jsonData['dataLancamento']) : null;
		numeroDocumento = jsonData['numeroDocumento'];
		primeiroVencimento = jsonData['primeiroVencimento'] != null ? DateTime.tryParse(jsonData['primeiroVencimento']) : null;
		intervaloEntreParcelas = jsonData['intervaloEntreParcelas'];
		diaFixo = jsonData['diaFixo'];
		imagemDocumento = jsonData['imagemDocumento'];
		finParcelaPagarModelList = (jsonData['finParcelaPagarModelList'] as Iterable?)?.map((m) => FinParcelaPagarModel.fromJson(m)).toList() ?? [];
		finDocumentoOrigemModel = jsonData['finDocumentoOrigemModel'] == null ? FinDocumentoOrigemModel() : FinDocumentoOrigemModel.fromJson(jsonData['finDocumentoOrigemModel']);
		bancoContaCaixaModel = jsonData['bancoContaCaixaModel'] == null ? BancoContaCaixaModel() : BancoContaCaixaModel.fromJson(jsonData['bancoContaCaixaModel']);
		finNaturezaFinanceiraModel = jsonData['finNaturezaFinanceiraModel'] == null ? FinNaturezaFinanceiraModel() : FinNaturezaFinanceiraModel.fromJson(jsonData['finNaturezaFinanceiraModel']);
		viewPessoaFornecedorModel = jsonData['viewPessoaFornecedorModel'] == null ? ViewPessoaFornecedorModel() : ViewPessoaFornecedorModel.fromJson(jsonData['viewPessoaFornecedorModel']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idFornecedor'] = idFornecedor != 0 ? idFornecedor : null;
		jsonData['idBancoContaCaixa'] = idBancoContaCaixa != 0 ? idBancoContaCaixa : null;
		jsonData['idFinDocumentoOrigem'] = idFinDocumentoOrigem != 0 ? idFinDocumentoOrigem : null;
		jsonData['idFinNaturezaFinanceira'] = idFinNaturezaFinanceira != 0 ? idFinNaturezaFinanceira : null;
		jsonData['quantidadeParcela'] = quantidadeParcela;
		jsonData['valorAPagar'] = valorAPagar;
		jsonData['dataLancamento'] = dataLancamento != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataLancamento!) : null;
		jsonData['numeroDocumento'] = numeroDocumento;
		jsonData['primeiroVencimento'] = primeiroVencimento != null ? DateFormat('yyyy-MM-ddT00:00:00').format(primeiroVencimento!) : null;
		jsonData['intervaloEntreParcelas'] = intervaloEntreParcelas;
		jsonData['diaFixo'] = diaFixo;
		jsonData['imagemDocumento'] = imagemDocumento;
		
		var finParcelaPagarModelLocalList = []; 
		for (FinParcelaPagarModel object in finParcelaPagarModelList ?? []) { 
			finParcelaPagarModelLocalList.add(object.toJson); 
		}
		jsonData['finParcelaPagarModelList'] = finParcelaPagarModelLocalList;
		jsonData['finDocumentoOrigemModel'] = finDocumentoOrigemModel?.toJson;
		jsonData['bancoContaCaixaModel'] = bancoContaCaixaModel?.toJson;
		jsonData['finNaturezaFinanceiraModel'] = finNaturezaFinanceiraModel?.toJson;
		jsonData['viewPessoaFornecedorModel'] = viewPessoaFornecedorModel?.toJson;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idFornecedor = plutoRow.cells['idFornecedor']?.value;
		idBancoContaCaixa = plutoRow.cells['idBancoContaCaixa']?.value;
		idFinDocumentoOrigem = plutoRow.cells['idFinDocumentoOrigem']?.value;
		idFinNaturezaFinanceira = plutoRow.cells['idFinNaturezaFinanceira']?.value;
		quantidadeParcela = plutoRow.cells['quantidadeParcela']?.value;
		valorAPagar = plutoRow.cells['valorAPagar']?.value?.toDouble();
		dataLancamento = Util.stringToDate(plutoRow.cells['dataLancamento']?.value);
		numeroDocumento = plutoRow.cells['numeroDocumento']?.value;
		primeiroVencimento = Util.stringToDate(plutoRow.cells['primeiroVencimento']?.value);
		intervaloEntreParcelas = plutoRow.cells['intervaloEntreParcelas']?.value;
		diaFixo = plutoRow.cells['diaFixo']?.value;
		imagemDocumento = plutoRow.cells['imagemDocumento']?.value;
		finParcelaPagarModelList = [];
		finDocumentoOrigemModel = FinDocumentoOrigemModel();
		finDocumentoOrigemModel?.sigla = plutoRow.cells['finDocumentoOrigemModel']?.value;
		bancoContaCaixaModel = BancoContaCaixaModel();
		bancoContaCaixaModel?.nome = plutoRow.cells['bancoContaCaixaModel']?.value;
		finNaturezaFinanceiraModel = FinNaturezaFinanceiraModel();
		finNaturezaFinanceiraModel?.descricao = plutoRow.cells['finNaturezaFinanceiraModel']?.value;
		viewPessoaFornecedorModel = ViewPessoaFornecedorModel();
		viewPessoaFornecedorModel?.nome = plutoRow.cells['viewPessoaFornecedorModel']?.value;
	}	

	FinLancamentoPagarModel clone() {
		return FinLancamentoPagarModel(
			id: id,
			idFornecedor: idFornecedor,
			idBancoContaCaixa: idBancoContaCaixa,
			idFinDocumentoOrigem: idFinDocumentoOrigem,
			idFinNaturezaFinanceira: idFinNaturezaFinanceira,
			quantidadeParcela: quantidadeParcela,
			valorAPagar: valorAPagar,
			dataLancamento: dataLancamento,
			numeroDocumento: numeroDocumento,
			primeiroVencimento: primeiroVencimento,
			intervaloEntreParcelas: intervaloEntreParcelas,
			diaFixo: diaFixo,
			imagemDocumento: imagemDocumento,
			finParcelaPagarModelList: finParcelaPagarModelListClone(finParcelaPagarModelList!),
		);			
	}

	finParcelaPagarModelListClone(List<FinParcelaPagarModel> finParcelaPagarModelList) { 
		List<FinParcelaPagarModel> resultList = [];
		for (var finParcelaPagarModel in finParcelaPagarModelList) {
			resultList.add(
				FinParcelaPagarModel(
					id: finParcelaPagarModel.id,
					idFinLancamentoPagar: finParcelaPagarModel.idFinLancamentoPagar,
					idFinChequeEmitido: finParcelaPagarModel.idFinChequeEmitido,
					idFinStatusParcela: finParcelaPagarModel.idFinStatusParcela,
					idFinTipoPagamento: finParcelaPagarModel.idFinTipoPagamento,
					numeroParcela: finParcelaPagarModel.numeroParcela,
					dataEmissao: finParcelaPagarModel.dataEmissao,
					dataVencimento: finParcelaPagarModel.dataVencimento,
					dataPagamento: finParcelaPagarModel.dataPagamento,
					descontoAte: finParcelaPagarModel.descontoAte,
					valor: finParcelaPagarModel.valor,
					taxaJuro: finParcelaPagarModel.taxaJuro,
					taxaMulta: finParcelaPagarModel.taxaMulta,
					taxaDesconto: finParcelaPagarModel.taxaDesconto,
					valorJuro: finParcelaPagarModel.valorJuro,
					valorMulta: finParcelaPagarModel.valorMulta,
					valorDesconto: finParcelaPagarModel.valorDesconto,
					valorPago: finParcelaPagarModel.valorPago,
					historico: finParcelaPagarModel.historico,
				)
			);
		}
		return resultList;
	}

	
}