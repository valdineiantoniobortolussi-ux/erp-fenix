import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:nfe/app/infra/infra_imports.dart';
import 'package:nfe/app/data/domain/domain_imports.dart';

class NfeTransporteModel {
	int? id;
	int? idNfeCabecalho;
	int? idTransportadora;
	String? modalidadeFrete;
	String? cnpj;
	String? cpf;
	String? nome;
	String? inscricaoEstadual;
	String? endereco;
	String? nomeMunicipio;
	String? uf;
	double? valorServico;
	double? valorBcRetencaoIcms;
	double? aliquotaRetencaoIcms;
	double? valorIcmsRetido;
	int? cfop;
	int? municipio;
	String? placaVeiculo;
	String? ufVeiculo;
	String? rntcVeiculo;

	NfeTransporteModel({
		this.id,
		this.idNfeCabecalho,
		this.idTransportadora,
		this.modalidadeFrete,
		this.cnpj,
		this.cpf,
		this.nome,
		this.inscricaoEstadual,
		this.endereco,
		this.nomeMunicipio,
		this.uf,
		this.valorServico,
		this.valorBcRetencaoIcms,
		this.aliquotaRetencaoIcms,
		this.valorIcmsRetido,
		this.cfop,
		this.municipio,
		this.placaVeiculo,
		this.ufVeiculo,
		this.rntcVeiculo,
	});

	static List<String> dbColumns = <String>[
		'id',
		'id_transportadora',
		'modalidade_frete',
		'cnpj',
		'cpf',
		'nome',
		'inscricao_estadual',
		'endereco',
		'nome_municipio',
		'uf',
		'valor_servico',
		'valor_bc_retencao_icms',
		'aliquota_retencao_icms',
		'valor_icms_retido',
		'cfop',
		'municipio',
		'placa_veiculo',
		'uf_veiculo',
		'rntc_veiculo',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Id Transportadora',
		'Modalidade Frete',
		'Cnpj',
		'Cpf',
		'Nome',
		'Inscricao Estadual',
		'Endereco',
		'Nome Municipio',
		'Uf',
		'Valor Servico',
		'Valor Bc Retencao Icms',
		'Aliquota Retencao Icms',
		'Valor Icms Retido',
		'Cfop',
		'Municipio',
		'Placa Veiculo',
		'Uf Veiculo',
		'Rntc Veiculo',
	];

	NfeTransporteModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idNfeCabecalho = jsonData['idNfeCabecalho'];
		idTransportadora = jsonData['idTransportadora'];
		modalidadeFrete = NfeTransporteDomain.getModalidadeFrete(jsonData['modalidadeFrete']);
		cnpj = jsonData['cnpj'];
		cpf = jsonData['cpf'];
		nome = jsonData['nome'];
		inscricaoEstadual = jsonData['inscricaoEstadual'];
		endereco = jsonData['endereco'];
		nomeMunicipio = jsonData['nomeMunicipio'];
		uf = NfeTransporteDomain.getUf(jsonData['uf']);
		valorServico = jsonData['valorServico']?.toDouble();
		valorBcRetencaoIcms = jsonData['valorBcRetencaoIcms']?.toDouble();
		aliquotaRetencaoIcms = jsonData['aliquotaRetencaoIcms']?.toDouble();
		valorIcmsRetido = jsonData['valorIcmsRetido']?.toDouble();
		cfop = jsonData['cfop'];
		municipio = jsonData['municipio'];
		placaVeiculo = jsonData['placaVeiculo'];
		ufVeiculo = NfeTransporteDomain.getUfVeiculo(jsonData['ufVeiculo']);
		rntcVeiculo = jsonData['rntcVeiculo'];
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idNfeCabecalho'] = idNfeCabecalho != 0 ? idNfeCabecalho : null;
		jsonData['idTransportadora'] = idTransportadora;
		jsonData['modalidadeFrete'] = NfeTransporteDomain.setModalidadeFrete(modalidadeFrete);
		jsonData['cnpj'] = Util.removeMask(cnpj);
		jsonData['cpf'] = Util.removeMask(cpf);
		jsonData['nome'] = nome;
		jsonData['inscricaoEstadual'] = inscricaoEstadual;
		jsonData['endereco'] = endereco;
		jsonData['nomeMunicipio'] = nomeMunicipio;
		jsonData['uf'] = NfeTransporteDomain.setUf(uf);
		jsonData['valorServico'] = valorServico;
		jsonData['valorBcRetencaoIcms'] = valorBcRetencaoIcms;
		jsonData['aliquotaRetencaoIcms'] = aliquotaRetencaoIcms;
		jsonData['valorIcmsRetido'] = valorIcmsRetido;
		jsonData['cfop'] = cfop;
		jsonData['municipio'] = municipio;
		jsonData['placaVeiculo'] = placaVeiculo;
		jsonData['ufVeiculo'] = NfeTransporteDomain.setUfVeiculo(ufVeiculo);
		jsonData['rntcVeiculo'] = rntcVeiculo;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idNfeCabecalho = plutoRow.cells['idNfeCabecalho']?.value;
		idTransportadora = plutoRow.cells['idTransportadora']?.value;
		modalidadeFrete = plutoRow.cells['modalidadeFrete']?.value != '' ? plutoRow.cells['modalidadeFrete']?.value : 'AAA';
		cnpj = plutoRow.cells['cnpj']?.value;
		cpf = plutoRow.cells['cpf']?.value;
		nome = plutoRow.cells['nome']?.value;
		inscricaoEstadual = plutoRow.cells['inscricaoEstadual']?.value;
		endereco = plutoRow.cells['endereco']?.value;
		nomeMunicipio = plutoRow.cells['nomeMunicipio']?.value;
		uf = plutoRow.cells['uf']?.value != '' ? plutoRow.cells['uf']?.value : 'AC';
		valorServico = plutoRow.cells['valorServico']?.value?.toDouble();
		valorBcRetencaoIcms = plutoRow.cells['valorBcRetencaoIcms']?.value?.toDouble();
		aliquotaRetencaoIcms = plutoRow.cells['aliquotaRetencaoIcms']?.value?.toDouble();
		valorIcmsRetido = plutoRow.cells['valorIcmsRetido']?.value?.toDouble();
		cfop = plutoRow.cells['cfop']?.value;
		municipio = plutoRow.cells['municipio']?.value;
		placaVeiculo = plutoRow.cells['placaVeiculo']?.value;
		ufVeiculo = plutoRow.cells['ufVeiculo']?.value != '' ? plutoRow.cells['ufVeiculo']?.value : 'AC';
		rntcVeiculo = plutoRow.cells['rntcVeiculo']?.value;
	}	

	NfeTransporteModel clone() {
		return NfeTransporteModel(
			id: id,
			idNfeCabecalho: idNfeCabecalho,
			idTransportadora: idTransportadora,
			modalidadeFrete: modalidadeFrete,
			cnpj: cnpj,
			cpf: cpf,
			nome: nome,
			inscricaoEstadual: inscricaoEstadual,
			endereco: endereco,
			nomeMunicipio: nomeMunicipio,
			uf: uf,
			valorServico: valorServico,
			valorBcRetencaoIcms: valorBcRetencaoIcms,
			aliquotaRetencaoIcms: aliquotaRetencaoIcms,
			valorIcmsRetido: valorIcmsRetido,
			cfop: cfop,
			municipio: municipio,
			placaVeiculo: placaVeiculo,
			ufVeiculo: ufVeiculo,
			rntcVeiculo: rntcVeiculo,
		);			
	}

	
}