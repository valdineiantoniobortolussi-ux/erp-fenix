import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:cte/app/infra/infra_imports.dart';
import 'package:intl/intl.dart';
import 'package:cte/app/data/domain/domain_imports.dart';

class CteAereoModel {
	int? id;
	int? idCteCabecalho;
	int? numeroMinuta;
	int? numeroConhecimento;
	DateTime? dataPrevistaEntrega;
	String? idEmissor;
	String? idInternaTomador;
	String? tarifaClasse;
	String? tarifaCodigo;
	double? tarifaValor;
	String? cargaDimensao;
	String? cargaInformacaoManuseio;
	String? cargaEspecial;

	CteAereoModel({
		this.id,
		this.idCteCabecalho,
		this.numeroMinuta,
		this.numeroConhecimento,
		this.dataPrevistaEntrega,
		this.idEmissor,
		this.idInternaTomador,
		this.tarifaClasse,
		this.tarifaCodigo,
		this.tarifaValor,
		this.cargaDimensao,
		this.cargaInformacaoManuseio,
		this.cargaEspecial,
	});

	static List<String> dbColumns = <String>[
		'id',
		'numero_minuta',
		'numero_conhecimento',
		'data_prevista_entrega',
		'id_emissor',
		'id_interna_tomador',
		'tarifa_classe',
		'tarifa_codigo',
		'tarifa_valor',
		'carga_dimensao',
		'carga_informacao_manuseio',
		'carga_especial',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Numero Minuta',
		'Numero Conhecimento',
		'Data Prevista Entrega',
		'Id Emissor',
		'Id Interna Tomador',
		'Tarifa Classe',
		'Tarifa Codigo',
		'Tarifa Valor',
		'Carga Dimensao',
		'Carga Informacao Manuseio',
		'Carga Especial',
	];

	CteAereoModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idCteCabecalho = jsonData['idCteCabecalho'];
		numeroMinuta = jsonData['numeroMinuta'];
		numeroConhecimento = jsonData['numeroConhecimento'];
		dataPrevistaEntrega = jsonData['dataPrevistaEntrega'] != null ? DateTime.tryParse(jsonData['dataPrevistaEntrega']) : null;
		idEmissor = jsonData['idEmissor'];
		idInternaTomador = jsonData['idInternaTomador'];
		tarifaClasse = CteAereoDomain.getTarifaClasse(jsonData['tarifaClasse']);
		tarifaCodigo = jsonData['tarifaCodigo'];
		tarifaValor = jsonData['tarifaValor']?.toDouble();
		cargaDimensao = jsonData['cargaDimensao'];
		cargaInformacaoManuseio = CteAereoDomain.getCargaInformacaoManuseio(jsonData['cargaInformacaoManuseio']);
		cargaEspecial = CteAereoDomain.getCargaEspecial(jsonData['cargaEspecial']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idCteCabecalho'] = idCteCabecalho != 0 ? idCteCabecalho : null;
		jsonData['numeroMinuta'] = numeroMinuta;
		jsonData['numeroConhecimento'] = numeroConhecimento;
		jsonData['dataPrevistaEntrega'] = dataPrevistaEntrega != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataPrevistaEntrega!) : null;
		jsonData['idEmissor'] = idEmissor;
		jsonData['idInternaTomador'] = idInternaTomador;
		jsonData['tarifaClasse'] = CteAereoDomain.setTarifaClasse(tarifaClasse);
		jsonData['tarifaCodigo'] = tarifaCodigo;
		jsonData['tarifaValor'] = tarifaValor;
		jsonData['cargaDimensao'] = cargaDimensao;
		jsonData['cargaInformacaoManuseio'] = CteAereoDomain.setCargaInformacaoManuseio(cargaInformacaoManuseio);
		jsonData['cargaEspecial'] = CteAereoDomain.setCargaEspecial(cargaEspecial);
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idCteCabecalho = plutoRow.cells['idCteCabecalho']?.value;
		numeroMinuta = plutoRow.cells['numeroMinuta']?.value;
		numeroConhecimento = plutoRow.cells['numeroConhecimento']?.value;
		dataPrevistaEntrega = Util.stringToDate(plutoRow.cells['dataPrevistaEntrega']?.value);
		idEmissor = plutoRow.cells['idEmissor']?.value;
		idInternaTomador = plutoRow.cells['idInternaTomador']?.value;
		tarifaClasse = plutoRow.cells['tarifaClasse']?.value != '' ? plutoRow.cells['tarifaClasse']?.value : 'AAA';
		tarifaCodigo = plutoRow.cells['tarifaCodigo']?.value;
		tarifaValor = plutoRow.cells['tarifaValor']?.value?.toDouble();
		cargaDimensao = plutoRow.cells['cargaDimensao']?.value;
		cargaInformacaoManuseio = plutoRow.cells['cargaInformacaoManuseio']?.value != '' ? plutoRow.cells['cargaInformacaoManuseio']?.value : 'AAA';
		cargaEspecial = plutoRow.cells['cargaEspecial']?.value != '' ? plutoRow.cells['cargaEspecial']?.value : 'AAA';
	}	

	CteAereoModel clone() {
		return CteAereoModel(
			id: id,
			idCteCabecalho: idCteCabecalho,
			numeroMinuta: numeroMinuta,
			numeroConhecimento: numeroConhecimento,
			dataPrevistaEntrega: dataPrevistaEntrega,
			idEmissor: idEmissor,
			idInternaTomador: idInternaTomador,
			tarifaClasse: tarifaClasse,
			tarifaCodigo: tarifaCodigo,
			tarifaValor: tarifaValor,
			cargaDimensao: cargaDimensao,
			cargaInformacaoManuseio: cargaInformacaoManuseio,
			cargaEspecial: cargaEspecial,
		);			
	}

	
}