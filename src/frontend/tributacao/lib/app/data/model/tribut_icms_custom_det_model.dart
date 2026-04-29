import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:tributacao/app/data/domain/domain_imports.dart';

class TributIcmsCustomDetModel {
	int? id;
	int? idTributIcmsCustomCab;
	String? ufDestino;
	String? cst;
	String? csosn;
	String? modalidadeBc;
	int? cfop;
	double? aliquota;
	double? valorPauta;
	double? valorPrecoMaximo;
	double? mva;
	double? porcentoBc;
	String? modalidadeBcSt;
	double? aliquotaInternaSt;
	double? aliquotaInterestadualSt;
	double? porcentoBcSt;
	double? aliquotaIcmsSt;
	double? valorPautaSt;
	double? valorPrecoMaximoSt;

	TributIcmsCustomDetModel({
		this.id,
		this.idTributIcmsCustomCab,
		this.ufDestino,
		this.cst,
		this.csosn,
		this.modalidadeBc,
		this.cfop,
		this.aliquota,
		this.valorPauta,
		this.valorPrecoMaximo,
		this.mva,
		this.porcentoBc,
		this.modalidadeBcSt,
		this.aliquotaInternaSt,
		this.aliquotaInterestadualSt,
		this.porcentoBcSt,
		this.aliquotaIcmsSt,
		this.valorPautaSt,
		this.valorPrecoMaximoSt,
	});

	static List<String> dbColumns = <String>[
		'id',
		'uf_destino',
		'cst',
		'csosn',
		'modalidade_bc',
		'cfop',
		'aliquota',
		'valor_pauta',
		'valor_preco_maximo',
		'mva',
		'porcento_bc',
		'modalidade_bc_st',
		'aliquota_interna_st',
		'aliquota_interestadual_st',
		'porcento_bc_st',
		'aliquota_icms_st',
		'valor_pauta_st',
		'valor_preco_maximo_st',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Uf Destino',
		'Cst',
		'Csosn',
		'Modalidade Bc',
		'Cfop',
		'Aliquota',
		'Valor Pauta',
		'Valor Preco Maximo',
		'Mva',
		'Porcento Bc',
		'Modalidade Bc St',
		'Aliquota Interna St',
		'Aliquota Interestadual St',
		'Porcento Bc St',
		'Aliquota Icms St',
		'Valor Pauta St',
		'Valor Preco Maximo St',
	];

	TributIcmsCustomDetModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idTributIcmsCustomCab = jsonData['idTributIcmsCustomCab'];
		ufDestino = TributIcmsCustomDetDomain.getUfDestino(jsonData['ufDestino']);
		cst = TributIcmsCustomDetDomain.getCst(jsonData['cst']);
		csosn = TributIcmsCustomDetDomain.getCsosn(jsonData['csosn']);
		modalidadeBc = TributIcmsCustomDetDomain.getModalidadeBc(jsonData['modalidadeBc']);
		cfop = jsonData['cfop'];
		aliquota = jsonData['aliquota']?.toDouble();
		valorPauta = jsonData['valorPauta']?.toDouble();
		valorPrecoMaximo = jsonData['valorPrecoMaximo']?.toDouble();
		mva = jsonData['mva']?.toDouble();
		porcentoBc = jsonData['porcentoBc']?.toDouble();
		modalidadeBcSt = TributIcmsCustomDetDomain.getModalidadeBcSt(jsonData['modalidadeBcSt']);
		aliquotaInternaSt = jsonData['aliquotaInternaSt']?.toDouble();
		aliquotaInterestadualSt = jsonData['aliquotaInterestadualSt']?.toDouble();
		porcentoBcSt = jsonData['porcentoBcSt']?.toDouble();
		aliquotaIcmsSt = jsonData['aliquotaIcmsSt']?.toDouble();
		valorPautaSt = jsonData['valorPautaSt']?.toDouble();
		valorPrecoMaximoSt = jsonData['valorPrecoMaximoSt']?.toDouble();
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idTributIcmsCustomCab'] = idTributIcmsCustomCab != 0 ? idTributIcmsCustomCab : null;
		jsonData['ufDestino'] = TributIcmsCustomDetDomain.setUfDestino(ufDestino);
		jsonData['cst'] = TributIcmsCustomDetDomain.setCst(cst);
		jsonData['csosn'] = TributIcmsCustomDetDomain.setCsosn(csosn);
		jsonData['modalidadeBc'] = TributIcmsCustomDetDomain.setModalidadeBc(modalidadeBc);
		jsonData['cfop'] = cfop;
		jsonData['aliquota'] = aliquota;
		jsonData['valorPauta'] = valorPauta;
		jsonData['valorPrecoMaximo'] = valorPrecoMaximo;
		jsonData['mva'] = mva;
		jsonData['porcentoBc'] = porcentoBc;
		jsonData['modalidadeBcSt'] = TributIcmsCustomDetDomain.setModalidadeBcSt(modalidadeBcSt);
		jsonData['aliquotaInternaSt'] = aliquotaInternaSt;
		jsonData['aliquotaInterestadualSt'] = aliquotaInterestadualSt;
		jsonData['porcentoBcSt'] = porcentoBcSt;
		jsonData['aliquotaIcmsSt'] = aliquotaIcmsSt;
		jsonData['valorPautaSt'] = valorPautaSt;
		jsonData['valorPrecoMaximoSt'] = valorPrecoMaximoSt;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idTributIcmsCustomCab = plutoRow.cells['idTributIcmsCustomCab']?.value;
		ufDestino = plutoRow.cells['ufDestino']?.value != '' ? plutoRow.cells['ufDestino']?.value : 'AC';
		cst = plutoRow.cells['cst']?.value != '' ? plutoRow.cells['cst']?.value : '00';
		csosn = plutoRow.cells['csosn']?.value != '' ? plutoRow.cells['csosn']?.value : '101';
		modalidadeBc = plutoRow.cells['modalidadeBc']?.value != '' ? plutoRow.cells['modalidadeBc']?.value : '0-Margem Valor Agregado';
		cfop = plutoRow.cells['cfop']?.value;
		aliquota = plutoRow.cells['aliquota']?.value?.toDouble();
		valorPauta = plutoRow.cells['valorPauta']?.value?.toDouble();
		valorPrecoMaximo = plutoRow.cells['valorPrecoMaximo']?.value?.toDouble();
		mva = plutoRow.cells['mva']?.value?.toDouble();
		porcentoBc = plutoRow.cells['porcentoBc']?.value?.toDouble();
		modalidadeBcSt = plutoRow.cells['modalidadeBcSt']?.value != '' ? plutoRow.cells['modalidadeBcSt']?.value : '0-Valor Preço Máximo';
		aliquotaInternaSt = plutoRow.cells['aliquotaInternaSt']?.value?.toDouble();
		aliquotaInterestadualSt = plutoRow.cells['aliquotaInterestadualSt']?.value?.toDouble();
		porcentoBcSt = plutoRow.cells['porcentoBcSt']?.value?.toDouble();
		aliquotaIcmsSt = plutoRow.cells['aliquotaIcmsSt']?.value?.toDouble();
		valorPautaSt = plutoRow.cells['valorPautaSt']?.value?.toDouble();
		valorPrecoMaximoSt = plutoRow.cells['valorPrecoMaximoSt']?.value?.toDouble();
	}	

	TributIcmsCustomDetModel clone() {
		return TributIcmsCustomDetModel(
			id: id,
			idTributIcmsCustomCab: idTributIcmsCustomCab,
			ufDestino: ufDestino,
			cst: cst,
			csosn: csosn,
			modalidadeBc: modalidadeBc,
			cfop: cfop,
			aliquota: aliquota,
			valorPauta: valorPauta,
			valorPrecoMaximo: valorPrecoMaximo,
			mva: mva,
			porcentoBc: porcentoBc,
			modalidadeBcSt: modalidadeBcSt,
			aliquotaInternaSt: aliquotaInternaSt,
			aliquotaInterestadualSt: aliquotaInterestadualSt,
			porcentoBcSt: porcentoBcSt,
			aliquotaIcmsSt: aliquotaIcmsSt,
			valorPautaSt: valorPautaSt,
			valorPrecoMaximoSt: valorPrecoMaximoSt,
		);			
	}

	
}