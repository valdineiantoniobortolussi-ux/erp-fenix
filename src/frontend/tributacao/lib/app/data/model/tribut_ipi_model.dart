import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:tributacao/app/data/domain/domain_imports.dart';

class TributIpiModel {
	int? id;
	int? idTributConfiguraOfGt;
	String? cstIpi;
	String? modalidadeBaseCalculo;
	double? porcentoBaseCalculo;
	double? aliquotaPorcento;
	double? aliquotaUnidade;
	double? valorPrecoMaximo;
	double? valorPautaFiscal;

	TributIpiModel({
		this.id,
		this.idTributConfiguraOfGt,
		this.cstIpi,
		this.modalidadeBaseCalculo,
		this.porcentoBaseCalculo,
		this.aliquotaPorcento,
		this.aliquotaUnidade,
		this.valorPrecoMaximo,
		this.valorPautaFiscal,
	});

	static List<String> dbColumns = <String>[
		'id',
		'cst_ipi',
		'modalidade_base_calculo',
		'porcento_base_calculo',
		'aliquota_porcento',
		'aliquota_unidade',
		'valor_preco_maximo',
		'valor_pauta_fiscal',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Cst Ipi',
		'Modalidade Base Calculo',
		'Porcento Base Calculo',
		'Aliquota Porcento',
		'Aliquota Unidade',
		'Valor Preco Maximo',
		'Valor Pauta Fiscal',
	];

	TributIpiModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idTributConfiguraOfGt = jsonData['idTributConfiguraOfGt'];
		cstIpi = TributIpiDomain.getCstIpi(jsonData['cstIpi']);
		modalidadeBaseCalculo = TributIpiDomain.getModalidadeBaseCalculo(jsonData['modalidadeBaseCalculo']);
		porcentoBaseCalculo = jsonData['porcentoBaseCalculo']?.toDouble();
		aliquotaPorcento = jsonData['aliquotaPorcento']?.toDouble();
		aliquotaUnidade = jsonData['aliquotaUnidade']?.toDouble();
		valorPrecoMaximo = jsonData['valorPrecoMaximo']?.toDouble();
		valorPautaFiscal = jsonData['valorPautaFiscal']?.toDouble();
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idTributConfiguraOfGt'] = idTributConfiguraOfGt != 0 ? idTributConfiguraOfGt : null;
		jsonData['cstIpi'] = TributIpiDomain.setCstIpi(cstIpi);
		jsonData['modalidadeBaseCalculo'] = TributIpiDomain.setModalidadeBaseCalculo(modalidadeBaseCalculo);
		jsonData['porcentoBaseCalculo'] = porcentoBaseCalculo;
		jsonData['aliquotaPorcento'] = aliquotaPorcento;
		jsonData['aliquotaUnidade'] = aliquotaUnidade;
		jsonData['valorPrecoMaximo'] = valorPrecoMaximo;
		jsonData['valorPautaFiscal'] = valorPautaFiscal;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idTributConfiguraOfGt = plutoRow.cells['idTributConfiguraOfGt']?.value;
		cstIpi = plutoRow.cells['cstIpi']?.value != '' ? plutoRow.cells['cstIpi']?.value : '00';
		modalidadeBaseCalculo = plutoRow.cells['modalidadeBaseCalculo']?.value != '' ? plutoRow.cells['modalidadeBaseCalculo']?.value : '0-Percentual';
		porcentoBaseCalculo = plutoRow.cells['porcentoBaseCalculo']?.value?.toDouble();
		aliquotaPorcento = plutoRow.cells['aliquotaPorcento']?.value?.toDouble();
		aliquotaUnidade = plutoRow.cells['aliquotaUnidade']?.value?.toDouble();
		valorPrecoMaximo = plutoRow.cells['valorPrecoMaximo']?.value?.toDouble();
		valorPautaFiscal = plutoRow.cells['valorPautaFiscal']?.value?.toDouble();
	}	

	TributIpiModel clone() {
		return TributIpiModel(
			id: id,
			idTributConfiguraOfGt: idTributConfiguraOfGt,
			cstIpi: cstIpi,
			modalidadeBaseCalculo: modalidadeBaseCalculo,
			porcentoBaseCalculo: porcentoBaseCalculo,
			aliquotaPorcento: aliquotaPorcento,
			aliquotaUnidade: aliquotaUnidade,
			valorPrecoMaximo: valorPrecoMaximo,
			valorPautaFiscal: valorPautaFiscal,
		);			
	}

	
}