import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:folha/app/infra/infra_imports.dart';
import 'package:folha/app/data/model/model_imports.dart';
import 'package:intl/intl.dart';
import 'package:folha/app/data/domain/domain_imports.dart';

class FolhaRescisaoModel {
	int? id;
	int? idColaborador;
	DateTime? dataDemissao;
	DateTime? dataPagamento;
	String? motivo;
	String? motivoEsocial;
	DateTime? dataAvisoPrevio;
	int? diasAvisoPrevio;
	String? comprovouNovoEmprego;
	String? dispensouEmpregado;
	double? pensaoAlimenticia;
	double? pensaoAlimenticiaFgts;
	double? fgtsValorRescisao;
	double? fgtsSaldoBanco;
	double? fgtsComplementoSaldo;
	String? fgtsCodigoAfastamento;
	String? fgtsCodigoSaque;
	ViewPessoaColaboradorModel? viewPessoaColaboradorModel;

	FolhaRescisaoModel({
		this.id,
		this.idColaborador,
		this.dataDemissao,
		this.dataPagamento,
		this.motivo,
		this.motivoEsocial,
		this.dataAvisoPrevio,
		this.diasAvisoPrevio,
		this.comprovouNovoEmprego,
		this.dispensouEmpregado,
		this.pensaoAlimenticia,
		this.pensaoAlimenticiaFgts,
		this.fgtsValorRescisao,
		this.fgtsSaldoBanco,
		this.fgtsComplementoSaldo,
		this.fgtsCodigoAfastamento,
		this.fgtsCodigoSaque,
		this.viewPessoaColaboradorModel,
	});

	static List<String> dbColumns = <String>[
		'id',
		'data_demissao',
		'data_pagamento',
		'motivo',
		'motivo_esocial',
		'data_aviso_previo',
		'dias_aviso_previo',
		'comprovou_novo_emprego',
		'dispensou_empregado',
		'pensao_alimenticia',
		'pensao_alimenticia_fgts',
		'fgts_valor_rescisao',
		'fgts_saldo_banco',
		'fgts_complemento_saldo',
		'fgts_codigo_afastamento',
		'fgts_codigo_saque',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Data Demissao',
		'Data Pagamento',
		'Motivo',
		'Motivo Esocial',
		'Data Aviso Previo',
		'Dias Aviso Previo',
		'Comprovou Novo Emprego',
		'Dispensou Empregado',
		'Pensao Alimenticia',
		'Pensao Alimenticia Fgts',
		'Fgts Valor Rescisao',
		'Fgts Saldo Banco',
		'Fgts Complemento Saldo',
		'Fgts Codigo Afastamento',
		'Fgts Codigo Saque',
	];

	FolhaRescisaoModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idColaborador = jsonData['idColaborador'];
		dataDemissao = jsonData['dataDemissao'] != null ? DateTime.tryParse(jsonData['dataDemissao']) : null;
		dataPagamento = jsonData['dataPagamento'] != null ? DateTime.tryParse(jsonData['dataPagamento']) : null;
		motivo = jsonData['motivo'];
		motivoEsocial = jsonData['motivoEsocial'];
		dataAvisoPrevio = jsonData['dataAvisoPrevio'] != null ? DateTime.tryParse(jsonData['dataAvisoPrevio']) : null;
		diasAvisoPrevio = jsonData['diasAvisoPrevio'];
		comprovouNovoEmprego = FolhaRescisaoDomain.getComprovouNovoEmprego(jsonData['comprovouNovoEmprego']);
		dispensouEmpregado = FolhaRescisaoDomain.getDispensouEmpregado(jsonData['dispensouEmpregado']);
		pensaoAlimenticia = jsonData['pensaoAlimenticia']?.toDouble();
		pensaoAlimenticiaFgts = jsonData['pensaoAlimenticiaFgts']?.toDouble();
		fgtsValorRescisao = jsonData['fgtsValorRescisao']?.toDouble();
		fgtsSaldoBanco = jsonData['fgtsSaldoBanco']?.toDouble();
		fgtsComplementoSaldo = jsonData['fgtsComplementoSaldo']?.toDouble();
		fgtsCodigoAfastamento = jsonData['fgtsCodigoAfastamento'];
		fgtsCodigoSaque = jsonData['fgtsCodigoSaque'];
		viewPessoaColaboradorModel = jsonData['viewPessoaColaboradorModel'] == null ? ViewPessoaColaboradorModel() : ViewPessoaColaboradorModel.fromJson(jsonData['viewPessoaColaboradorModel']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idColaborador'] = idColaborador != 0 ? idColaborador : null;
		jsonData['dataDemissao'] = dataDemissao != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataDemissao!) : null;
		jsonData['dataPagamento'] = dataPagamento != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataPagamento!) : null;
		jsonData['motivo'] = motivo;
		jsonData['motivoEsocial'] = motivoEsocial;
		jsonData['dataAvisoPrevio'] = dataAvisoPrevio != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataAvisoPrevio!) : null;
		jsonData['diasAvisoPrevio'] = diasAvisoPrevio;
		jsonData['comprovouNovoEmprego'] = FolhaRescisaoDomain.setComprovouNovoEmprego(comprovouNovoEmprego);
		jsonData['dispensouEmpregado'] = FolhaRescisaoDomain.setDispensouEmpregado(dispensouEmpregado);
		jsonData['pensaoAlimenticia'] = pensaoAlimenticia;
		jsonData['pensaoAlimenticiaFgts'] = pensaoAlimenticiaFgts;
		jsonData['fgtsValorRescisao'] = fgtsValorRescisao;
		jsonData['fgtsSaldoBanco'] = fgtsSaldoBanco;
		jsonData['fgtsComplementoSaldo'] = fgtsComplementoSaldo;
		jsonData['fgtsCodigoAfastamento'] = fgtsCodigoAfastamento;
		jsonData['fgtsCodigoSaque'] = fgtsCodigoSaque;
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
		dataDemissao = Util.stringToDate(plutoRow.cells['dataDemissao']?.value);
		dataPagamento = Util.stringToDate(plutoRow.cells['dataPagamento']?.value);
		motivo = plutoRow.cells['motivo']?.value;
		motivoEsocial = plutoRow.cells['motivoEsocial']?.value;
		dataAvisoPrevio = Util.stringToDate(plutoRow.cells['dataAvisoPrevio']?.value);
		diasAvisoPrevio = plutoRow.cells['diasAvisoPrevio']?.value;
		comprovouNovoEmprego = plutoRow.cells['comprovouNovoEmprego']?.value != '' ? plutoRow.cells['comprovouNovoEmprego']?.value : 'Sim';
		dispensouEmpregado = plutoRow.cells['dispensouEmpregado']?.value != '' ? plutoRow.cells['dispensouEmpregado']?.value : 'Sim';
		pensaoAlimenticia = plutoRow.cells['pensaoAlimenticia']?.value?.toDouble();
		pensaoAlimenticiaFgts = plutoRow.cells['pensaoAlimenticiaFgts']?.value?.toDouble();
		fgtsValorRescisao = plutoRow.cells['fgtsValorRescisao']?.value?.toDouble();
		fgtsSaldoBanco = plutoRow.cells['fgtsSaldoBanco']?.value?.toDouble();
		fgtsComplementoSaldo = plutoRow.cells['fgtsComplementoSaldo']?.value?.toDouble();
		fgtsCodigoAfastamento = plutoRow.cells['fgtsCodigoAfastamento']?.value;
		fgtsCodigoSaque = plutoRow.cells['fgtsCodigoSaque']?.value;
		viewPessoaColaboradorModel = ViewPessoaColaboradorModel();
		viewPessoaColaboradorModel?.nome = plutoRow.cells['viewPessoaColaboradorModel']?.value;
	}	

	FolhaRescisaoModel clone() {
		return FolhaRescisaoModel(
			id: id,
			idColaborador: idColaborador,
			dataDemissao: dataDemissao,
			dataPagamento: dataPagamento,
			motivo: motivo,
			motivoEsocial: motivoEsocial,
			dataAvisoPrevio: dataAvisoPrevio,
			diasAvisoPrevio: diasAvisoPrevio,
			comprovouNovoEmprego: comprovouNovoEmprego,
			dispensouEmpregado: dispensouEmpregado,
			pensaoAlimenticia: pensaoAlimenticia,
			pensaoAlimenticiaFgts: pensaoAlimenticiaFgts,
			fgtsValorRescisao: fgtsValorRescisao,
			fgtsSaldoBanco: fgtsSaldoBanco,
			fgtsComplementoSaldo: fgtsComplementoSaldo,
			fgtsCodigoAfastamento: fgtsCodigoAfastamento,
			fgtsCodigoSaque: fgtsCodigoSaque,
		);			
	}

	
}