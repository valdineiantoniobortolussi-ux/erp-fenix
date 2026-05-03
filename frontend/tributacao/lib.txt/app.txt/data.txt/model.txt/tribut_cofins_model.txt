import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:tributacao/app/data/domain/domain_imports.dart';

class TributCofinsModel {
	int? id;
	int? idTributConfiguraOfGt;
	String? cstCofins;
	String? modalidadeBaseCalculo;
	String? efdTabela435;
	double? porcentoBaseCalculo;
	double? aliquotaPorcento;
	double? aliquotaUnidade;
	double? valorPrecoMaximo;
	double? valorPautaFiscal;

	TributCofinsModel({
		this.id,
		this.idTributConfiguraOfGt,
		this.cstCofins,
		this.modalidadeBaseCalculo,
		this.efdTabela435,
		this.porcentoBaseCalculo,
		this.aliquotaPorcento,
		this.aliquotaUnidade,
		this.valorPrecoMaximo,
		this.valorPautaFiscal,
	});

	static List<String> dbColumns = <String>[
		'id',
		'cst_cofins',
		'modalidade_base_calculo',
		'efd_tabela_435',
		'porcento_base_calculo',
		'aliquota_porcento',
		'aliquota_unidade',
		'valor_preco_maximo',
		'valor_pauta_fiscal',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Cst Cofins',
		'Modalidade Base Calculo',
		'Efd Tabela 435',
		'Porcento Base Calculo',
		'Aliquota Porcento',
		'Aliquota Unidade',
		'Valor Preco Maximo',
		'Valor Pauta Fiscal',
	];

	TributCofinsModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idTributConfiguraOfGt = jsonData['idTributConfiguraOfGt'];
		cstCofins = TributCofinsDomain.getCstCofins(jsonData['cstCofins']);
		modalidadeBaseCalculo = TributCofinsDomain.getModalidadeBaseCalculo(jsonData['modalidadeBaseCalculo']);
		efdTabela435 = jsonData['efdTabela435'];
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
		jsonData['cstCofins'] = TributCofinsDomain.setCstCofins(cstCofins);
		jsonData['modalidadeBaseCalculo'] = TributCofinsDomain.setModalidadeBaseCalculo(modalidadeBaseCalculo);
		jsonData['efdTabela435'] = efdTabela435;
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
		cstCofins = plutoRow.cells['cstCofins']?.value != '' ? plutoRow.cells['cstCofins']?.value : '00';
		modalidadeBaseCalculo = plutoRow.cells['modalidadeBaseCalculo']?.value != '' ? plutoRow.cells['modalidadeBaseCalculo']?.value : '0-Percentual';
		efdTabela435 = plutoRow.cells['efdTabela435']?.value;
		porcentoBaseCalculo = plutoRow.cells['porcentoBaseCalculo']?.value?.toDouble();
		aliquotaPorcento = plutoRow.cells['aliquotaPorcento']?.value?.toDouble();
		aliquotaUnidade = plutoRow.cells['aliquotaUnidade']?.value?.toDouble();
		valorPrecoMaximo = plutoRow.cells['valorPrecoMaximo']?.value?.toDouble();
		valorPautaFiscal = plutoRow.cells['valorPautaFiscal']?.value?.toDouble();
	}	

	TributCofinsModel clone() {
		return TributCofinsModel(
			id: id,
			idTributConfiguraOfGt: idTributConfiguraOfGt,
			cstCofins: cstCofins,
			modalidadeBaseCalculo: modalidadeBaseCalculo,
			efdTabela435: efdTabela435,
			porcentoBaseCalculo: porcentoBaseCalculo,
			aliquotaPorcento: aliquotaPorcento,
			aliquotaUnidade: aliquotaUnidade,
			valorPrecoMaximo: valorPrecoMaximo,
			valorPautaFiscal: valorPautaFiscal,
		);			
	}

	
}