import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';


class NfeDetalheImpostoIcmsUfdestModel {
	int? id;
	int? idNfeDetalhe;
	double? valorBcIcmsUfDestino;
	double? valorBcFcpUfDestino;
	double? percentualFcpUfDestino;
	double? aliquotaInternaUfDestino;
	double? aliquotaInteresdatualUfEnvolvidas;
	double? percentualProvisorioPartilhaIcms;
	double? valorIcmsFcpUfDestino;
	double? valorInterestadualUfDestino;
	double? valorInterestadualUfRemetente;

	NfeDetalheImpostoIcmsUfdestModel({
		this.id,
		this.idNfeDetalhe,
		this.valorBcIcmsUfDestino,
		this.valorBcFcpUfDestino,
		this.percentualFcpUfDestino,
		this.aliquotaInternaUfDestino,
		this.aliquotaInteresdatualUfEnvolvidas,
		this.percentualProvisorioPartilhaIcms,
		this.valorIcmsFcpUfDestino,
		this.valorInterestadualUfDestino,
		this.valorInterestadualUfRemetente,
	});

	static List<String> dbColumns = <String>[
		'id',
		'valor_bc_icms_uf_destino',
		'valor_bc_fcp_uf_destino',
		'percentual_fcp_uf_destino',
		'aliquota_interna_uf_destino',
		'aliquota_interesdatual_uf_envolvidas',
		'percentual_provisorio_partilha_icms',
		'valor_icms_fcp_uf_destino',
		'valor_interestadual_uf_destino',
		'valor_interestadual_uf_remetente',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Valor Bc Icms Uf Destino',
		'Valor Bc Fcp Uf Destino',
		'Percentual Fcp Uf Destino',
		'Aliquota Interna Uf Destino',
		'Aliquota Interesdatual Uf Envolvidas',
		'Percentual Provisorio Partilha Icms',
		'Valor Icms Fcp Uf Destino',
		'Valor Interestadual Uf Destino',
		'Valor Interestadual Uf Remetente',
	];

	NfeDetalheImpostoIcmsUfdestModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idNfeDetalhe = jsonData['idNfeDetalhe'];
		valorBcIcmsUfDestino = jsonData['valorBcIcmsUfDestino']?.toDouble();
		valorBcFcpUfDestino = jsonData['valorBcFcpUfDestino']?.toDouble();
		percentualFcpUfDestino = jsonData['percentualFcpUfDestino']?.toDouble();
		aliquotaInternaUfDestino = jsonData['aliquotaInternaUfDestino']?.toDouble();
		aliquotaInteresdatualUfEnvolvidas = jsonData['aliquotaInteresdatualUfEnvolvidas']?.toDouble();
		percentualProvisorioPartilhaIcms = jsonData['percentualProvisorioPartilhaIcms']?.toDouble();
		valorIcmsFcpUfDestino = jsonData['valorIcmsFcpUfDestino']?.toDouble();
		valorInterestadualUfDestino = jsonData['valorInterestadualUfDestino']?.toDouble();
		valorInterestadualUfRemetente = jsonData['valorInterestadualUfRemetente']?.toDouble();
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idNfeDetalhe'] = idNfeDetalhe != 0 ? idNfeDetalhe : null;
		jsonData['valorBcIcmsUfDestino'] = valorBcIcmsUfDestino;
		jsonData['valorBcFcpUfDestino'] = valorBcFcpUfDestino;
		jsonData['percentualFcpUfDestino'] = percentualFcpUfDestino;
		jsonData['aliquotaInternaUfDestino'] = aliquotaInternaUfDestino;
		jsonData['aliquotaInteresdatualUfEnvolvidas'] = aliquotaInteresdatualUfEnvolvidas;
		jsonData['percentualProvisorioPartilhaIcms'] = percentualProvisorioPartilhaIcms;
		jsonData['valorIcmsFcpUfDestino'] = valorIcmsFcpUfDestino;
		jsonData['valorInterestadualUfDestino'] = valorInterestadualUfDestino;
		jsonData['valorInterestadualUfRemetente'] = valorInterestadualUfRemetente;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idNfeDetalhe = plutoRow.cells['idNfeDetalhe']?.value;
		valorBcIcmsUfDestino = plutoRow.cells['valorBcIcmsUfDestino']?.value?.toDouble();
		valorBcFcpUfDestino = plutoRow.cells['valorBcFcpUfDestino']?.value?.toDouble();
		percentualFcpUfDestino = plutoRow.cells['percentualFcpUfDestino']?.value?.toDouble();
		aliquotaInternaUfDestino = plutoRow.cells['aliquotaInternaUfDestino']?.value?.toDouble();
		aliquotaInteresdatualUfEnvolvidas = plutoRow.cells['aliquotaInteresdatualUfEnvolvidas']?.value?.toDouble();
		percentualProvisorioPartilhaIcms = plutoRow.cells['percentualProvisorioPartilhaIcms']?.value?.toDouble();
		valorIcmsFcpUfDestino = plutoRow.cells['valorIcmsFcpUfDestino']?.value?.toDouble();
		valorInterestadualUfDestino = plutoRow.cells['valorInterestadualUfDestino']?.value?.toDouble();
		valorInterestadualUfRemetente = plutoRow.cells['valorInterestadualUfRemetente']?.value?.toDouble();
	}	

	NfeDetalheImpostoIcmsUfdestModel clone() {
		return NfeDetalheImpostoIcmsUfdestModel(
			id: id,
			idNfeDetalhe: idNfeDetalhe,
			valorBcIcmsUfDestino: valorBcIcmsUfDestino,
			valorBcFcpUfDestino: valorBcFcpUfDestino,
			percentualFcpUfDestino: percentualFcpUfDestino,
			aliquotaInternaUfDestino: aliquotaInternaUfDestino,
			aliquotaInteresdatualUfEnvolvidas: aliquotaInteresdatualUfEnvolvidas,
			percentualProvisorioPartilhaIcms: percentualProvisorioPartilhaIcms,
			valorIcmsFcpUfDestino: valorIcmsFcpUfDestino,
			valorInterestadualUfDestino: valorInterestadualUfDestino,
			valorInterestadualUfRemetente: valorInterestadualUfRemetente,
		);			
	}

	
}