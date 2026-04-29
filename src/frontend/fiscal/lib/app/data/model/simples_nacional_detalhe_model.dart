import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';


class SimplesNacionalDetalheModel {
	int? id;
	int? idSimplesNacionalCabecalho;
	int? faixa;
	double? valorInicial;
	double? valorFinal;
	double? aliquota;
	double? irpj;
	double? csll;
	double? cofins;
	double? pisPasep;
	double? cpp;
	double? icms;
	double? ipi;
	double? iss;

	SimplesNacionalDetalheModel({
		this.id,
		this.idSimplesNacionalCabecalho,
		this.faixa,
		this.valorInicial,
		this.valorFinal,
		this.aliquota,
		this.irpj,
		this.csll,
		this.cofins,
		this.pisPasep,
		this.cpp,
		this.icms,
		this.ipi,
		this.iss,
	});

	static List<String> dbColumns = <String>[
		'id',
		'faixa',
		'valor_inicial',
		'valor_final',
		'aliquota',
		'irpj',
		'csll',
		'cofins',
		'pis_pasep',
		'cpp',
		'icms',
		'ipi',
		'iss',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Faixa',
		'Valor Inicial',
		'Valor Final',
		'Aliquota',
		'Irpj',
		'Csll',
		'Cofins',
		'Pis Pasep',
		'Cpp',
		'Icms',
		'Ipi',
		'Iss',
	];

	SimplesNacionalDetalheModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idSimplesNacionalCabecalho = jsonData['idSimplesNacionalCabecalho'];
		faixa = jsonData['faixa'];
		valorInicial = jsonData['valorInicial']?.toDouble();
		valorFinal = jsonData['valorFinal']?.toDouble();
		aliquota = jsonData['aliquota']?.toDouble();
		irpj = jsonData['irpj']?.toDouble();
		csll = jsonData['csll']?.toDouble();
		cofins = jsonData['cofins']?.toDouble();
		pisPasep = jsonData['pisPasep']?.toDouble();
		cpp = jsonData['cpp']?.toDouble();
		icms = jsonData['icms']?.toDouble();
		ipi = jsonData['ipi']?.toDouble();
		iss = jsonData['iss']?.toDouble();
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idSimplesNacionalCabecalho'] = idSimplesNacionalCabecalho != 0 ? idSimplesNacionalCabecalho : null;
		jsonData['faixa'] = faixa;
		jsonData['valorInicial'] = valorInicial;
		jsonData['valorFinal'] = valorFinal;
		jsonData['aliquota'] = aliquota;
		jsonData['irpj'] = irpj;
		jsonData['csll'] = csll;
		jsonData['cofins'] = cofins;
		jsonData['pisPasep'] = pisPasep;
		jsonData['cpp'] = cpp;
		jsonData['icms'] = icms;
		jsonData['ipi'] = ipi;
		jsonData['iss'] = iss;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idSimplesNacionalCabecalho = plutoRow.cells['idSimplesNacionalCabecalho']?.value;
		faixa = plutoRow.cells['faixa']?.value;
		valorInicial = plutoRow.cells['valorInicial']?.value?.toDouble();
		valorFinal = plutoRow.cells['valorFinal']?.value?.toDouble();
		aliquota = plutoRow.cells['aliquota']?.value?.toDouble();
		irpj = plutoRow.cells['irpj']?.value?.toDouble();
		csll = plutoRow.cells['csll']?.value?.toDouble();
		cofins = plutoRow.cells['cofins']?.value?.toDouble();
		pisPasep = plutoRow.cells['pisPasep']?.value?.toDouble();
		cpp = plutoRow.cells['cpp']?.value?.toDouble();
		icms = plutoRow.cells['icms']?.value?.toDouble();
		ipi = plutoRow.cells['ipi']?.value?.toDouble();
		iss = plutoRow.cells['iss']?.value?.toDouble();
	}	

	SimplesNacionalDetalheModel clone() {
		return SimplesNacionalDetalheModel(
			id: id,
			idSimplesNacionalCabecalho: idSimplesNacionalCabecalho,
			faixa: faixa,
			valorInicial: valorInicial,
			valorFinal: valorFinal,
			aliquota: aliquota,
			irpj: irpj,
			csll: csll,
			cofins: cofins,
			pisPasep: pisPasep,
			cpp: cpp,
			icms: icms,
			ipi: ipi,
			iss: iss,
		);			
	}

	
}