import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:nfe/app/infra/infra_imports.dart';
import 'package:nfe/app/data/domain/domain_imports.dart';

class NfeDetalheImpostoIpiModel {
	int? id;
	int? idNfeDetalhe;
	String? cnpjProdutor;
	String? codigoSeloIpi;
	int? quantidadeSeloIpi;
	String? enquadramentoLegalIpi;
	String? cstIpi;
	double? valorBaseCalculoIpi;
	double? quantidadeUnidadeTributavel;
	double? valorUnidadeTributavel;
	double? aliquotaIpi;
	double? valorIpi;

	NfeDetalheImpostoIpiModel({
		this.id,
		this.idNfeDetalhe,
		this.cnpjProdutor,
		this.codigoSeloIpi,
		this.quantidadeSeloIpi,
		this.enquadramentoLegalIpi,
		this.cstIpi,
		this.valorBaseCalculoIpi,
		this.quantidadeUnidadeTributavel,
		this.valorUnidadeTributavel,
		this.aliquotaIpi,
		this.valorIpi,
	});

	static List<String> dbColumns = <String>[
		'id',
		'cnpj_produtor',
		'codigo_selo_ipi',
		'quantidade_selo_ipi',
		'enquadramento_legal_ipi',
		'cst_ipi',
		'valor_base_calculo_ipi',
		'quantidade_unidade_tributavel',
		'valor_unidade_tributavel',
		'aliquota_ipi',
		'valor_ipi',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Cnpj Produtor',
		'Codigo Selo Ipi',
		'Quantidade Selo Ipi',
		'Enquadramento Legal Ipi',
		'Cst Ipi',
		'Valor Base Calculo Ipi',
		'Quantidade Unidade Tributavel',
		'Valor Unidade Tributavel',
		'Aliquota Ipi',
		'Valor Ipi',
	];

	NfeDetalheImpostoIpiModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idNfeDetalhe = jsonData['idNfeDetalhe'];
		cnpjProdutor = jsonData['cnpjProdutor'];
		codigoSeloIpi = jsonData['codigoSeloIpi'];
		quantidadeSeloIpi = jsonData['quantidadeSeloIpi'];
		enquadramentoLegalIpi = NfeDetalheImpostoIpiDomain.getEnquadramentoLegalIpi(jsonData['enquadramentoLegalIpi']);
		cstIpi = NfeDetalheImpostoIpiDomain.getCstIpi(jsonData['cstIpi']);
		valorBaseCalculoIpi = jsonData['valorBaseCalculoIpi']?.toDouble();
		quantidadeUnidadeTributavel = jsonData['quantidadeUnidadeTributavel']?.toDouble();
		valorUnidadeTributavel = jsonData['valorUnidadeTributavel']?.toDouble();
		aliquotaIpi = jsonData['aliquotaIpi']?.toDouble();
		valorIpi = jsonData['valorIpi']?.toDouble();
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idNfeDetalhe'] = idNfeDetalhe != 0 ? idNfeDetalhe : null;
		jsonData['cnpjProdutor'] = Util.removeMask(cnpjProdutor);
		jsonData['codigoSeloIpi'] = codigoSeloIpi;
		jsonData['quantidadeSeloIpi'] = quantidadeSeloIpi;
		jsonData['enquadramentoLegalIpi'] = NfeDetalheImpostoIpiDomain.setEnquadramentoLegalIpi(enquadramentoLegalIpi);
		jsonData['cstIpi'] = NfeDetalheImpostoIpiDomain.setCstIpi(cstIpi);
		jsonData['valorBaseCalculoIpi'] = valorBaseCalculoIpi;
		jsonData['quantidadeUnidadeTributavel'] = quantidadeUnidadeTributavel;
		jsonData['valorUnidadeTributavel'] = valorUnidadeTributavel;
		jsonData['aliquotaIpi'] = aliquotaIpi;
		jsonData['valorIpi'] = valorIpi;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idNfeDetalhe = plutoRow.cells['idNfeDetalhe']?.value;
		cnpjProdutor = plutoRow.cells['cnpjProdutor']?.value;
		codigoSeloIpi = plutoRow.cells['codigoSeloIpi']?.value;
		quantidadeSeloIpi = plutoRow.cells['quantidadeSeloIpi']?.value;
		enquadramentoLegalIpi = plutoRow.cells['enquadramentoLegalIpi']?.value != '' ? plutoRow.cells['enquadramentoLegalIpi']?.value : 'AAA';
		cstIpi = plutoRow.cells['cstIpi']?.value != '' ? plutoRow.cells['cstIpi']?.value : 'AAA';
		valorBaseCalculoIpi = plutoRow.cells['valorBaseCalculoIpi']?.value?.toDouble();
		quantidadeUnidadeTributavel = plutoRow.cells['quantidadeUnidadeTributavel']?.value?.toDouble();
		valorUnidadeTributavel = plutoRow.cells['valorUnidadeTributavel']?.value?.toDouble();
		aliquotaIpi = plutoRow.cells['aliquotaIpi']?.value?.toDouble();
		valorIpi = plutoRow.cells['valorIpi']?.value?.toDouble();
	}	

	NfeDetalheImpostoIpiModel clone() {
		return NfeDetalheImpostoIpiModel(
			id: id,
			idNfeDetalhe: idNfeDetalhe,
			cnpjProdutor: cnpjProdutor,
			codigoSeloIpi: codigoSeloIpi,
			quantidadeSeloIpi: quantidadeSeloIpi,
			enquadramentoLegalIpi: enquadramentoLegalIpi,
			cstIpi: cstIpi,
			valorBaseCalculoIpi: valorBaseCalculoIpi,
			quantidadeUnidadeTributavel: quantidadeUnidadeTributavel,
			valorUnidadeTributavel: valorUnidadeTributavel,
			aliquotaIpi: aliquotaIpi,
			valorIpi: valorIpi,
		);			
	}

	
}