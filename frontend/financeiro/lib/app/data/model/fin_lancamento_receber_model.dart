import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:financeiro/app/infra/infra_imports.dart';
import 'package:financeiro/app/data/model/model_imports.dart';
import 'package:intl/intl.dart';

class FinLancamentoReceberModel {
	int? id;
	int? idCliente;
	int? idBancoContaCaixa;
	int? idFinDocumentoOrigem;
	int? idFinNaturezaFinanceira;
	int? quantidadeParcela;
	double? valorAReceber;
	DateTime? dataLancamento;
	String? numeroDocumento;
	DateTime? primeiroVencimento;
	double? taxaComissao;
	double? valorComissao;
	int? intervaloEntreParcelas;
	String? diaFixo;
	List<FinParcelaReceberModel>? finParcelaReceberModelList;
	FinDocumentoOrigemModel? finDocumentoOrigemModel;
	BancoContaCaixaModel? bancoContaCaixaModel;
	FinNaturezaFinanceiraModel? finNaturezaFinanceiraModel;
	ViewPessoaClienteModel? viewPessoaClienteModel;

	FinLancamentoReceberModel({
		this.id,
		this.idCliente,
		this.idBancoContaCaixa,
		this.idFinDocumentoOrigem,
		this.idFinNaturezaFinanceira,
		this.quantidadeParcela,
		this.valorAReceber,
		this.dataLancamento,
		this.numeroDocumento,
		this.primeiroVencimento,
		this.taxaComissao,
		this.valorComissao,
		this.intervaloEntreParcelas,
		this.diaFixo,
		this.finParcelaReceberModelList,
		this.finDocumentoOrigemModel,
		this.bancoContaCaixaModel,
		this.finNaturezaFinanceiraModel,
		this.viewPessoaClienteModel,
	});

	static List<String> dbColumns = <String>[
		'id',
		'quantidade_parcela',
		'valor_a_receber',
		'data_lancamento',
		'numero_documento',
		'primeiro_vencimento',
		'taxa_comissao',
		'valor_comissao',
		'intervalo_entre_parcelas',
		'dia_fixo',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Quantidade Parcela',
		'Valor A Receber',
		'Data Lancamento',
		'Numero Documento',
		'Primeiro Vencimento',
		'Taxa Comissao',
		'Valor Comissao',
		'Intervalo Entre Parcelas',
		'Dia Fixo',
	];

	FinLancamentoReceberModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idCliente = jsonData['idCliente'];
		idBancoContaCaixa = jsonData['idBancoContaCaixa'];
		idFinDocumentoOrigem = jsonData['idFinDocumentoOrigem'];
		idFinNaturezaFinanceira = jsonData['idFinNaturezaFinanceira'];
		quantidadeParcela = jsonData['quantidadeParcela'];
		valorAReceber = jsonData['valorAReceber']?.toDouble();
		dataLancamento = jsonData['dataLancamento'] != null ? DateTime.tryParse(jsonData['dataLancamento']) : null;
		numeroDocumento = jsonData['numeroDocumento'];
		primeiroVencimento = jsonData['primeiroVencimento'] != null ? DateTime.tryParse(jsonData['primeiroVencimento']) : null;
		taxaComissao = jsonData['taxaComissao']?.toDouble();
		valorComissao = jsonData['valorComissao']?.toDouble();
		intervaloEntreParcelas = jsonData['intervaloEntreParcelas'];
		diaFixo = jsonData['diaFixo'];
		finParcelaReceberModelList = (jsonData['finParcelaReceberModelList'] as Iterable?)?.map((m) => FinParcelaReceberModel.fromJson(m)).toList() ?? [];
		finDocumentoOrigemModel = jsonData['finDocumentoOrigemModel'] == null ? FinDocumentoOrigemModel() : FinDocumentoOrigemModel.fromJson(jsonData['finDocumentoOrigemModel']);
		bancoContaCaixaModel = jsonData['bancoContaCaixaModel'] == null ? BancoContaCaixaModel() : BancoContaCaixaModel.fromJson(jsonData['bancoContaCaixaModel']);
		finNaturezaFinanceiraModel = jsonData['finNaturezaFinanceiraModel'] == null ? FinNaturezaFinanceiraModel() : FinNaturezaFinanceiraModel.fromJson(jsonData['finNaturezaFinanceiraModel']);
		viewPessoaClienteModel = jsonData['viewPessoaClienteModel'] == null ? ViewPessoaClienteModel() : ViewPessoaClienteModel.fromJson(jsonData['viewPessoaClienteModel']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idCliente'] = idCliente != 0 ? idCliente : null;
		jsonData['idBancoContaCaixa'] = idBancoContaCaixa != 0 ? idBancoContaCaixa : null;
		jsonData['idFinDocumentoOrigem'] = idFinDocumentoOrigem != 0 ? idFinDocumentoOrigem : null;
		jsonData['idFinNaturezaFinanceira'] = idFinNaturezaFinanceira != 0 ? idFinNaturezaFinanceira : null;
		jsonData['quantidadeParcela'] = quantidadeParcela;
		jsonData['valorAReceber'] = valorAReceber;
		jsonData['dataLancamento'] = dataLancamento != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataLancamento!) : null;
		jsonData['numeroDocumento'] = numeroDocumento;
		jsonData['primeiroVencimento'] = primeiroVencimento != null ? DateFormat('yyyy-MM-ddT00:00:00').format(primeiroVencimento!) : null;
		jsonData['taxaComissao'] = taxaComissao;
		jsonData['valorComissao'] = valorComissao;
		jsonData['intervaloEntreParcelas'] = intervaloEntreParcelas;
		jsonData['diaFixo'] = diaFixo;
		
		var finParcelaReceberModelLocalList = []; 
		for (FinParcelaReceberModel object in finParcelaReceberModelList ?? []) { 
			finParcelaReceberModelLocalList.add(object.toJson); 
		}
		jsonData['finParcelaReceberModelList'] = finParcelaReceberModelLocalList;
		jsonData['finDocumentoOrigemModel'] = finDocumentoOrigemModel?.toJson;
		jsonData['bancoContaCaixaModel'] = bancoContaCaixaModel?.toJson;
		jsonData['finNaturezaFinanceiraModel'] = finNaturezaFinanceiraModel?.toJson;
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
		idBancoContaCaixa = plutoRow.cells['idBancoContaCaixa']?.value;
		idFinDocumentoOrigem = plutoRow.cells['idFinDocumentoOrigem']?.value;
		idFinNaturezaFinanceira = plutoRow.cells['idFinNaturezaFinanceira']?.value;
		quantidadeParcela = plutoRow.cells['quantidadeParcela']?.value;
		valorAReceber = plutoRow.cells['valorAReceber']?.value?.toDouble();
		dataLancamento = Util.stringToDate(plutoRow.cells['dataLancamento']?.value);
		numeroDocumento = plutoRow.cells['numeroDocumento']?.value;
		primeiroVencimento = Util.stringToDate(plutoRow.cells['primeiroVencimento']?.value);
		taxaComissao = plutoRow.cells['taxaComissao']?.value?.toDouble();
		valorComissao = plutoRow.cells['valorComissao']?.value?.toDouble();
		intervaloEntreParcelas = plutoRow.cells['intervaloEntreParcelas']?.value;
		diaFixo = plutoRow.cells['diaFixo']?.value;
		finParcelaReceberModelList = [];
		finDocumentoOrigemModel = FinDocumentoOrigemModel();
		finDocumentoOrigemModel?.sigla = plutoRow.cells['finDocumentoOrigemModel']?.value;
		bancoContaCaixaModel = BancoContaCaixaModel();
		bancoContaCaixaModel?.nome = plutoRow.cells['bancoContaCaixaModel']?.value;
		finNaturezaFinanceiraModel = FinNaturezaFinanceiraModel();
		finNaturezaFinanceiraModel?.descricao = plutoRow.cells['finNaturezaFinanceiraModel']?.value;
		viewPessoaClienteModel = ViewPessoaClienteModel();
		viewPessoaClienteModel?.nome = plutoRow.cells['viewPessoaClienteModel']?.value;
	}	

	FinLancamentoReceberModel clone() {
		return FinLancamentoReceberModel(
			id: id,
			idCliente: idCliente,
			idBancoContaCaixa: idBancoContaCaixa,
			idFinDocumentoOrigem: idFinDocumentoOrigem,
			idFinNaturezaFinanceira: idFinNaturezaFinanceira,
			quantidadeParcela: quantidadeParcela,
			valorAReceber: valorAReceber,
			dataLancamento: dataLancamento,
			numeroDocumento: numeroDocumento,
			primeiroVencimento: primeiroVencimento,
			taxaComissao: taxaComissao,
			valorComissao: valorComissao,
			intervaloEntreParcelas: intervaloEntreParcelas,
			diaFixo: diaFixo,
			finParcelaReceberModelList: finParcelaReceberModelListClone(finParcelaReceberModelList!),
		);			
	}

	finParcelaReceberModelListClone(List<FinParcelaReceberModel> finParcelaReceberModelList) { 
		List<FinParcelaReceberModel> resultList = [];
		for (var finParcelaReceberModel in finParcelaReceberModelList) {
			resultList.add(
				FinParcelaReceberModel(
					id: finParcelaReceberModel.id,
					idFinLancamentoReceber: finParcelaReceberModel.idFinLancamentoReceber,
					idFinChequeRecebido: finParcelaReceberModel.idFinChequeRecebido,
					idFinStatusParcela: finParcelaReceberModel.idFinStatusParcela,
					idFinTipoRecebimento: finParcelaReceberModel.idFinTipoRecebimento,
					numeroParcela: finParcelaReceberModel.numeroParcela,
					dataEmissao: finParcelaReceberModel.dataEmissao,
					dataVencimento: finParcelaReceberModel.dataVencimento,
					dataRecebimento: finParcelaReceberModel.dataRecebimento,
					descontoAte: finParcelaReceberModel.descontoAte,
					valor: finParcelaReceberModel.valor,
					taxaJuro: finParcelaReceberModel.taxaJuro,
					taxaMulta: finParcelaReceberModel.taxaMulta,
					taxaDesconto: finParcelaReceberModel.taxaDesconto,
					valorJuro: finParcelaReceberModel.valorJuro,
					valorMulta: finParcelaReceberModel.valorMulta,
					valorDesconto: finParcelaReceberModel.valorDesconto,
					emitiuBoleto: finParcelaReceberModel.emitiuBoleto,
					boletoNossoNumero: finParcelaReceberModel.boletoNossoNumero,
					valorRecebido: finParcelaReceberModel.valorRecebido,
					historico: finParcelaReceberModel.historico,
				)
			);
		}
		return resultList;
	}

	
}