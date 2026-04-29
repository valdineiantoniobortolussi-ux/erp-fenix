import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:nfe/app/infra/infra_imports.dart';
import 'package:intl/intl.dart';
import 'package:nfe/app/data/domain/domain_imports.dart';

class NfeCupomFiscalReferenciadoModel {
	int? id;
	int? idNfeCabecalho;
	String? modeloDocumentoFiscal;
	int? numeroOrdemEcf;
	int? coo;
	DateTime? dataEmissaoCupom;
	int? numeroCaixa;
	String? numeroSerieEcf;

	NfeCupomFiscalReferenciadoModel({
		this.id,
		this.idNfeCabecalho,
		this.modeloDocumentoFiscal,
		this.numeroOrdemEcf,
		this.coo,
		this.dataEmissaoCupom,
		this.numeroCaixa,
		this.numeroSerieEcf,
	});

	static List<String> dbColumns = <String>[
		'id',
		'modelo_documento_fiscal',
		'numero_ordem_ecf',
		'coo',
		'data_emissao_cupom',
		'numero_caixa',
		'numero_serie_ecf',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Modelo Documento Fiscal',
		'Numero Ordem Ecf',
		'Coo',
		'Data Emissao Cupom',
		'Numero Caixa',
		'Numero Serie Ecf',
	];

	NfeCupomFiscalReferenciadoModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idNfeCabecalho = jsonData['idNfeCabecalho'];
		modeloDocumentoFiscal = NfeCupomFiscalReferenciadoDomain.getModeloDocumentoFiscal(jsonData['modeloDocumentoFiscal']);
		numeroOrdemEcf = jsonData['numeroOrdemEcf'];
		coo = jsonData['coo'];
		dataEmissaoCupom = jsonData['dataEmissaoCupom'] != null ? DateTime.tryParse(jsonData['dataEmissaoCupom']) : null;
		numeroCaixa = jsonData['numeroCaixa'];
		numeroSerieEcf = jsonData['numeroSerieEcf'];
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idNfeCabecalho'] = idNfeCabecalho != 0 ? idNfeCabecalho : null;
		jsonData['modeloDocumentoFiscal'] = NfeCupomFiscalReferenciadoDomain.setModeloDocumentoFiscal(modeloDocumentoFiscal);
		jsonData['numeroOrdemEcf'] = numeroOrdemEcf;
		jsonData['coo'] = coo;
		jsonData['dataEmissaoCupom'] = dataEmissaoCupom != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataEmissaoCupom!) : null;
		jsonData['numeroCaixa'] = numeroCaixa;
		jsonData['numeroSerieEcf'] = numeroSerieEcf;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idNfeCabecalho = plutoRow.cells['idNfeCabecalho']?.value;
		modeloDocumentoFiscal = plutoRow.cells['modeloDocumentoFiscal']?.value != '' ? plutoRow.cells['modeloDocumentoFiscal']?.value : 'AAA';
		numeroOrdemEcf = plutoRow.cells['numeroOrdemEcf']?.value;
		coo = plutoRow.cells['coo']?.value;
		dataEmissaoCupom = Util.stringToDate(plutoRow.cells['dataEmissaoCupom']?.value);
		numeroCaixa = plutoRow.cells['numeroCaixa']?.value;
		numeroSerieEcf = plutoRow.cells['numeroSerieEcf']?.value;
	}	

	NfeCupomFiscalReferenciadoModel clone() {
		return NfeCupomFiscalReferenciadoModel(
			id: id,
			idNfeCabecalho: idNfeCabecalho,
			modeloDocumentoFiscal: modeloDocumentoFiscal,
			numeroOrdemEcf: numeroOrdemEcf,
			coo: coo,
			dataEmissaoCupom: dataEmissaoCupom,
			numeroCaixa: numeroCaixa,
			numeroSerieEcf: numeroSerieEcf,
		);			
	}

	
}