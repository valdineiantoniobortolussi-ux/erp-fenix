import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:nfe/app/infra/infra_imports.dart';
import 'package:intl/intl.dart';
import 'package:nfe/app/data/domain/domain_imports.dart';

class NfeDeclaracaoImportacaoModel {
	int? id;
	int? idNfeDetalhe;
	String? numeroDocumento;
	DateTime? dataRegistro;
	String? localDesembaraco;
	String? ufDesembaraco;
	DateTime? dataDesembaraco;
	String? viaTransporte;
	double? valorAfrmm;
	String? formaIntermediacao;
	String? cnpj;
	String? ufTerceiro;
	String? codigoExportador;

	NfeDeclaracaoImportacaoModel({
		this.id,
		this.idNfeDetalhe,
		this.numeroDocumento,
		this.dataRegistro,
		this.localDesembaraco,
		this.ufDesembaraco,
		this.dataDesembaraco,
		this.viaTransporte,
		this.valorAfrmm,
		this.formaIntermediacao,
		this.cnpj,
		this.ufTerceiro,
		this.codigoExportador,
	});

	static List<String> dbColumns = <String>[
		'id',
		'numero_documento',
		'data_registro',
		'local_desembaraco',
		'uf_desembaraco',
		'data_desembaraco',
		'via_transporte',
		'valor_afrmm',
		'forma_intermediacao',
		'cnpj',
		'uf_terceiro',
		'codigo_exportador',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Numero Documento',
		'Data Registro',
		'Local Desembaraco',
		'Uf Desembaraco',
		'Data Desembaraco',
		'Via Transporte',
		'Valor Afrmm',
		'Forma Intermediacao',
		'Cnpj',
		'Uf Terceiro',
		'Codigo Exportador',
	];

	NfeDeclaracaoImportacaoModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idNfeDetalhe = jsonData['idNfeDetalhe'];
		numeroDocumento = jsonData['numeroDocumento'];
		dataRegistro = jsonData['dataRegistro'] != null ? DateTime.tryParse(jsonData['dataRegistro']) : null;
		localDesembaraco = jsonData['localDesembaraco'];
		ufDesembaraco = NfeDeclaracaoImportacaoDomain.getUfDesembaraco(jsonData['ufDesembaraco']);
		dataDesembaraco = jsonData['dataDesembaraco'] != null ? DateTime.tryParse(jsonData['dataDesembaraco']) : null;
		viaTransporte = NfeDeclaracaoImportacaoDomain.getViaTransporte(jsonData['viaTransporte']);
		valorAfrmm = jsonData['valorAfrmm']?.toDouble();
		formaIntermediacao = NfeDeclaracaoImportacaoDomain.getFormaIntermediacao(jsonData['formaIntermediacao']);
		cnpj = jsonData['cnpj'];
		ufTerceiro = NfeDeclaracaoImportacaoDomain.getUfTerceiro(jsonData['ufTerceiro']);
		codigoExportador = jsonData['codigoExportador'];
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idNfeDetalhe'] = idNfeDetalhe != 0 ? idNfeDetalhe : null;
		jsonData['numeroDocumento'] = numeroDocumento;
		jsonData['dataRegistro'] = dataRegistro != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataRegistro!) : null;
		jsonData['localDesembaraco'] = localDesembaraco;
		jsonData['ufDesembaraco'] = NfeDeclaracaoImportacaoDomain.setUfDesembaraco(ufDesembaraco);
		jsonData['dataDesembaraco'] = dataDesembaraco != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataDesembaraco!) : null;
		jsonData['viaTransporte'] = NfeDeclaracaoImportacaoDomain.setViaTransporte(viaTransporte);
		jsonData['valorAfrmm'] = valorAfrmm;
		jsonData['formaIntermediacao'] = NfeDeclaracaoImportacaoDomain.setFormaIntermediacao(formaIntermediacao);
		jsonData['cnpj'] = Util.removeMask(cnpj);
		jsonData['ufTerceiro'] = NfeDeclaracaoImportacaoDomain.setUfTerceiro(ufTerceiro);
		jsonData['codigoExportador'] = codigoExportador;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idNfeDetalhe = plutoRow.cells['idNfeDetalhe']?.value;
		numeroDocumento = plutoRow.cells['numeroDocumento']?.value;
		dataRegistro = Util.stringToDate(plutoRow.cells['dataRegistro']?.value);
		localDesembaraco = plutoRow.cells['localDesembaraco']?.value;
		ufDesembaraco = plutoRow.cells['ufDesembaraco']?.value != '' ? plutoRow.cells['ufDesembaraco']?.value : 'AC';
		dataDesembaraco = Util.stringToDate(plutoRow.cells['dataDesembaraco']?.value);
		viaTransporte = plutoRow.cells['viaTransporte']?.value != '' ? plutoRow.cells['viaTransporte']?.value : 'AAA';
		valorAfrmm = plutoRow.cells['valorAfrmm']?.value?.toDouble();
		formaIntermediacao = plutoRow.cells['formaIntermediacao']?.value != '' ? plutoRow.cells['formaIntermediacao']?.value : 'AAA';
		cnpj = plutoRow.cells['cnpj']?.value;
		ufTerceiro = plutoRow.cells['ufTerceiro']?.value != '' ? plutoRow.cells['ufTerceiro']?.value : 'AC';
		codigoExportador = plutoRow.cells['codigoExportador']?.value;
	}	

	NfeDeclaracaoImportacaoModel clone() {
		return NfeDeclaracaoImportacaoModel(
			id: id,
			idNfeDetalhe: idNfeDetalhe,
			numeroDocumento: numeroDocumento,
			dataRegistro: dataRegistro,
			localDesembaraco: localDesembaraco,
			ufDesembaraco: ufDesembaraco,
			dataDesembaraco: dataDesembaraco,
			viaTransporte: viaTransporte,
			valorAfrmm: valorAfrmm,
			formaIntermediacao: formaIntermediacao,
			cnpj: cnpj,
			ufTerceiro: ufTerceiro,
			codigoExportador: codigoExportador,
		);			
	}

	
}