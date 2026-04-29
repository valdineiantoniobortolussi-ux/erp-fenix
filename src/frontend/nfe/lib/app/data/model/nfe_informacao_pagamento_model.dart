import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:nfe/app/infra/infra_imports.dart';
import 'package:nfe/app/data/domain/domain_imports.dart';

class NfeInformacaoPagamentoModel {
	int? id;
	int? idNfeCabecalho;
	String? indicadorPagamento;
	String? meioPagamento;
	double? valor;
	String? tipoIntegracao;
	String? cnpjOperadoraCartao;
	String? bandeira;
	String? numeroAutorizacao;
	double? troco;

	NfeInformacaoPagamentoModel({
		this.id,
		this.idNfeCabecalho,
		this.indicadorPagamento,
		this.meioPagamento,
		this.valor,
		this.tipoIntegracao,
		this.cnpjOperadoraCartao,
		this.bandeira,
		this.numeroAutorizacao,
		this.troco,
	});

	static List<String> dbColumns = <String>[
		'id',
		'indicador_pagamento',
		'meio_pagamento',
		'valor',
		'tipo_integracao',
		'cnpj_operadora_cartao',
		'bandeira',
		'numero_autorizacao',
		'troco',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Indicador Pagamento',
		'Meio Pagamento',
		'Valor',
		'Tipo Integracao',
		'Cnpj Operadora Cartao',
		'Bandeira',
		'Numero Autorizacao',
		'Troco',
	];

	NfeInformacaoPagamentoModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idNfeCabecalho = jsonData['idNfeCabecalho'];
		indicadorPagamento = NfeInformacaoPagamentoDomain.getIndicadorPagamento(jsonData['indicadorPagamento']);
		meioPagamento = NfeInformacaoPagamentoDomain.getMeioPagamento(jsonData['meioPagamento']);
		valor = jsonData['valor']?.toDouble();
		tipoIntegracao = NfeInformacaoPagamentoDomain.getTipoIntegracao(jsonData['tipoIntegracao']);
		cnpjOperadoraCartao = jsonData['cnpjOperadoraCartao'];
		bandeira = NfeInformacaoPagamentoDomain.getBandeira(jsonData['bandeira']);
		numeroAutorizacao = jsonData['numeroAutorizacao'];
		troco = jsonData['troco']?.toDouble();
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idNfeCabecalho'] = idNfeCabecalho != 0 ? idNfeCabecalho : null;
		jsonData['indicadorPagamento'] = NfeInformacaoPagamentoDomain.setIndicadorPagamento(indicadorPagamento);
		jsonData['meioPagamento'] = NfeInformacaoPagamentoDomain.setMeioPagamento(meioPagamento);
		jsonData['valor'] = valor;
		jsonData['tipoIntegracao'] = NfeInformacaoPagamentoDomain.setTipoIntegracao(tipoIntegracao);
		jsonData['cnpjOperadoraCartao'] = Util.removeMask(cnpjOperadoraCartao);
		jsonData['bandeira'] = NfeInformacaoPagamentoDomain.setBandeira(bandeira);
		jsonData['numeroAutorizacao'] = numeroAutorizacao;
		jsonData['troco'] = troco;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idNfeCabecalho = plutoRow.cells['idNfeCabecalho']?.value;
		indicadorPagamento = plutoRow.cells['indicadorPagamento']?.value != '' ? plutoRow.cells['indicadorPagamento']?.value : 'AAA';
		meioPagamento = plutoRow.cells['meioPagamento']?.value != '' ? plutoRow.cells['meioPagamento']?.value : 'AAA';
		valor = plutoRow.cells['valor']?.value?.toDouble();
		tipoIntegracao = plutoRow.cells['tipoIntegracao']?.value != '' ? plutoRow.cells['tipoIntegracao']?.value : 'AAA';
		cnpjOperadoraCartao = plutoRow.cells['cnpjOperadoraCartao']?.value;
		bandeira = plutoRow.cells['bandeira']?.value != '' ? plutoRow.cells['bandeira']?.value : 'AAA';
		numeroAutorizacao = plutoRow.cells['numeroAutorizacao']?.value;
		troco = plutoRow.cells['troco']?.value?.toDouble();
	}	

	NfeInformacaoPagamentoModel clone() {
		return NfeInformacaoPagamentoModel(
			id: id,
			idNfeCabecalho: idNfeCabecalho,
			indicadorPagamento: indicadorPagamento,
			meioPagamento: meioPagamento,
			valor: valor,
			tipoIntegracao: tipoIntegracao,
			cnpjOperadoraCartao: cnpjOperadoraCartao,
			bandeira: bandeira,
			numeroAutorizacao: numeroAutorizacao,
			troco: troco,
		);			
	}

	
}