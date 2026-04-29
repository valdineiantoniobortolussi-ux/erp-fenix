import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:vendas/app/data/model/model_imports.dart';
import 'package:vendas/app/data/domain/domain_imports.dart';

class VendaFreteModel {
	int? id;
	int? idVendaCabecalho;
	int? idTransportadora;
	String? responsavel;
	int? conhecimento;
	String? placa;
	String? ufPlaca;
	int? seloFiscal;
	double? quantidadeVolume;
	String? marcaVolume;
	String? especieVolume;
	double? pesoBruto;
	double? pesoLiquido;
	ViewPessoaTransportadoraModel? viewPessoaTransportadoraModel;

	VendaFreteModel({
		this.id,
		this.idVendaCabecalho,
		this.idTransportadora,
		this.responsavel,
		this.conhecimento,
		this.placa,
		this.ufPlaca,
		this.seloFiscal,
		this.quantidadeVolume,
		this.marcaVolume,
		this.especieVolume,
		this.pesoBruto,
		this.pesoLiquido,
		this.viewPessoaTransportadoraModel,
	});

	static List<String> dbColumns = <String>[
		'id',
		'responsavel',
		'conhecimento',
		'placa',
		'uf_placa',
		'selo_fiscal',
		'quantidade_volume',
		'marca_volume',
		'especie_volume',
		'peso_bruto',
		'peso_liquido',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Responsavel',
		'Conhecimento',
		'Placa',
		'Uf Placa',
		'Selo Fiscal',
		'Quantidade Volume',
		'Marca Volume',
		'Especie Volume',
		'Peso Bruto',
		'Peso Liquido',
	];

	VendaFreteModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idVendaCabecalho = jsonData['idVendaCabecalho'];
		idTransportadora = jsonData['idTransportadora'];
		responsavel = VendaFreteDomain.getResponsavel(jsonData['responsavel']);
		conhecimento = jsonData['conhecimento'];
		placa = jsonData['placa'];
		ufPlaca = VendaFreteDomain.getUfPlaca(jsonData['ufPlaca']);
		seloFiscal = jsonData['seloFiscal'];
		quantidadeVolume = jsonData['quantidadeVolume']?.toDouble();
		marcaVolume = jsonData['marcaVolume'];
		especieVolume = jsonData['especieVolume'];
		pesoBruto = jsonData['pesoBruto']?.toDouble();
		pesoLiquido = jsonData['pesoLiquido']?.toDouble();
		viewPessoaTransportadoraModel = jsonData['viewPessoaTransportadoraModel'] == null ? ViewPessoaTransportadoraModel() : ViewPessoaTransportadoraModel.fromJson(jsonData['viewPessoaTransportadoraModel']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idVendaCabecalho'] = idVendaCabecalho != 0 ? idVendaCabecalho : null;
		jsonData['idTransportadora'] = idTransportadora != 0 ? idTransportadora : null;
		jsonData['responsavel'] = VendaFreteDomain.setResponsavel(responsavel);
		jsonData['conhecimento'] = conhecimento;
		jsonData['placa'] = placa;
		jsonData['ufPlaca'] = VendaFreteDomain.setUfPlaca(ufPlaca);
		jsonData['seloFiscal'] = seloFiscal;
		jsonData['quantidadeVolume'] = quantidadeVolume;
		jsonData['marcaVolume'] = marcaVolume;
		jsonData['especieVolume'] = especieVolume;
		jsonData['pesoBruto'] = pesoBruto;
		jsonData['pesoLiquido'] = pesoLiquido;
		jsonData['viewPessoaTransportadoraModel'] = viewPessoaTransportadoraModel?.toJson;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idVendaCabecalho = plutoRow.cells['idVendaCabecalho']?.value;
		idTransportadora = plutoRow.cells['idTransportadora']?.value;
		responsavel = plutoRow.cells['responsavel']?.value != '' ? plutoRow.cells['responsavel']?.value : '1-Emitente';
		conhecimento = plutoRow.cells['conhecimento']?.value;
		placa = plutoRow.cells['placa']?.value;
		ufPlaca = plutoRow.cells['ufPlaca']?.value != '' ? plutoRow.cells['ufPlaca']?.value : 'AC';
		seloFiscal = plutoRow.cells['seloFiscal']?.value;
		quantidadeVolume = plutoRow.cells['quantidadeVolume']?.value?.toDouble();
		marcaVolume = plutoRow.cells['marcaVolume']?.value;
		especieVolume = plutoRow.cells['especieVolume']?.value;
		pesoBruto = plutoRow.cells['pesoBruto']?.value?.toDouble();
		pesoLiquido = plutoRow.cells['pesoLiquido']?.value?.toDouble();
		viewPessoaTransportadoraModel = ViewPessoaTransportadoraModel();
		viewPessoaTransportadoraModel?.nome = plutoRow.cells['viewPessoaTransportadoraModel']?.value;
	}	

	VendaFreteModel clone() {
		return VendaFreteModel(
			id: id,
			idVendaCabecalho: idVendaCabecalho,
			idTransportadora: idTransportadora,
			responsavel: responsavel,
			conhecimento: conhecimento,
			placa: placa,
			ufPlaca: ufPlaca,
			seloFiscal: seloFiscal,
			quantidadeVolume: quantidadeVolume,
			marcaVolume: marcaVolume,
			especieVolume: especieVolume,
			pesoBruto: pesoBruto,
			pesoLiquido: pesoLiquido,
		);			
	}

	
}