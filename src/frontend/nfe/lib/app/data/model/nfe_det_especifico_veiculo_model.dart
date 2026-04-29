import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:nfe/app/data/domain/domain_imports.dart';

class NfeDetEspecificoVeiculoModel {
	int? id;
	int? idNfeDetalhe;
	String? tipoOperacao;
	String? chassi;
	String? cor;
	String? descricaoCor;
	String? potenciaMotor;
	String? cilindradas;
	String? pesoLiquido;
	String? pesoBruto;
	String? numeroSerie;
	String? tipoCombustivel;
	String? numeroMotor;
	String? capacidadeMaximaTracao;
	String? distanciaEixos;
	String? anoModelo;
	String? anoFabricacao;
	String? tipoPintura;
	String? tipoVeiculo;
	String? especieVeiculo;
	String? condicaoVin;
	String? condicaoVeiculo;
	String? codigoMarcaModelo;
	String? codigoCorDenatran;
	int? lotacaoMaxima;
	String? restricao;

	NfeDetEspecificoVeiculoModel({
		this.id,
		this.idNfeDetalhe,
		this.tipoOperacao,
		this.chassi,
		this.cor,
		this.descricaoCor,
		this.potenciaMotor,
		this.cilindradas,
		this.pesoLiquido,
		this.pesoBruto,
		this.numeroSerie,
		this.tipoCombustivel,
		this.numeroMotor,
		this.capacidadeMaximaTracao,
		this.distanciaEixos,
		this.anoModelo,
		this.anoFabricacao,
		this.tipoPintura,
		this.tipoVeiculo,
		this.especieVeiculo,
		this.condicaoVin,
		this.condicaoVeiculo,
		this.codigoMarcaModelo,
		this.codigoCorDenatran,
		this.lotacaoMaxima,
		this.restricao,
	});

	static List<String> dbColumns = <String>[
		'id',
		'tipo_operacao',
		'chassi',
		'cor',
		'descricao_cor',
		'potencia_motor',
		'cilindradas',
		'peso_liquido',
		'peso_bruto',
		'numero_serie',
		'tipo_combustivel',
		'numero_motor',
		'capacidade_maxima_tracao',
		'distancia_eixos',
		'ano_modelo',
		'ano_fabricacao',
		'tipo_pintura',
		'tipo_veiculo',
		'especie_veiculo',
		'condicao_vin',
		'condicao_veiculo',
		'codigo_marca_modelo',
		'codigo_cor_denatran',
		'lotacao_maxima',
		'restricao',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Tipo Operacao',
		'Chassi',
		'Cor',
		'Descricao Cor',
		'Potencia Motor',
		'Cilindradas',
		'Peso Liquido',
		'Peso Bruto',
		'Numero Serie',
		'Tipo Combustivel',
		'Numero Motor',
		'Capacidade Maxima Tracao',
		'Distancia Eixos',
		'Ano Modelo',
		'Ano Fabricacao',
		'Tipo Pintura',
		'Tipo Veiculo',
		'Especie Veiculo',
		'Condicao Vin',
		'Condicao Veiculo',
		'Codigo Marca Modelo',
		'Codigo Cor Denatran',
		'Lotacao Maxima',
		'Restricao',
	];

	NfeDetEspecificoVeiculoModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idNfeDetalhe = jsonData['idNfeDetalhe'];
		tipoOperacao = NfeDetEspecificoVeiculoDomain.getTipoOperacao(jsonData['tipoOperacao']);
		chassi = jsonData['chassi'];
		cor = jsonData['cor'];
		descricaoCor = jsonData['descricaoCor'];
		potenciaMotor = jsonData['potenciaMotor'];
		cilindradas = jsonData['cilindradas'];
		pesoLiquido = jsonData['pesoLiquido'];
		pesoBruto = jsonData['pesoBruto'];
		numeroSerie = jsonData['numeroSerie'];
		tipoCombustivel = NfeDetEspecificoVeiculoDomain.getTipoCombustivel(jsonData['tipoCombustivel']);
		numeroMotor = jsonData['numeroMotor'];
		capacidadeMaximaTracao = jsonData['capacidadeMaximaTracao'];
		distanciaEixos = jsonData['distanciaEixos'];
		anoModelo = NfeDetEspecificoVeiculoDomain.getAnoModelo(jsonData['anoModelo']);
		anoFabricacao = NfeDetEspecificoVeiculoDomain.getAnoFabricacao(jsonData['anoFabricacao']);
		tipoPintura = NfeDetEspecificoVeiculoDomain.getTipoPintura(jsonData['tipoPintura']);
		tipoVeiculo = NfeDetEspecificoVeiculoDomain.getTipoVeiculo(jsonData['tipoVeiculo']);
		especieVeiculo = NfeDetEspecificoVeiculoDomain.getEspecieVeiculo(jsonData['especieVeiculo']);
		condicaoVin = NfeDetEspecificoVeiculoDomain.getCondicaoVin(jsonData['condicaoVin']);
		condicaoVeiculo = NfeDetEspecificoVeiculoDomain.getCondicaoVeiculo(jsonData['condicaoVeiculo']);
		codigoMarcaModelo = jsonData['codigoMarcaModelo'];
		codigoCorDenatran = NfeDetEspecificoVeiculoDomain.getCodigoCorDenatran(jsonData['codigoCorDenatran']);
		lotacaoMaxima = jsonData['lotacaoMaxima'];
		restricao = NfeDetEspecificoVeiculoDomain.getRestricao(jsonData['restricao']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idNfeDetalhe'] = idNfeDetalhe != 0 ? idNfeDetalhe : null;
		jsonData['tipoOperacao'] = NfeDetEspecificoVeiculoDomain.setTipoOperacao(tipoOperacao);
		jsonData['chassi'] = chassi;
		jsonData['cor'] = cor;
		jsonData['descricaoCor'] = descricaoCor;
		jsonData['potenciaMotor'] = potenciaMotor;
		jsonData['cilindradas'] = cilindradas;
		jsonData['pesoLiquido'] = pesoLiquido;
		jsonData['pesoBruto'] = pesoBruto;
		jsonData['numeroSerie'] = numeroSerie;
		jsonData['tipoCombustivel'] = NfeDetEspecificoVeiculoDomain.setTipoCombustivel(tipoCombustivel);
		jsonData['numeroMotor'] = numeroMotor;
		jsonData['capacidadeMaximaTracao'] = capacidadeMaximaTracao;
		jsonData['distanciaEixos'] = distanciaEixos;
		jsonData['anoModelo'] = NfeDetEspecificoVeiculoDomain.setAnoModelo(anoModelo);
		jsonData['anoFabricacao'] = NfeDetEspecificoVeiculoDomain.setAnoFabricacao(anoFabricacao);
		jsonData['tipoPintura'] = NfeDetEspecificoVeiculoDomain.setTipoPintura(tipoPintura);
		jsonData['tipoVeiculo'] = NfeDetEspecificoVeiculoDomain.setTipoVeiculo(tipoVeiculo);
		jsonData['especieVeiculo'] = NfeDetEspecificoVeiculoDomain.setEspecieVeiculo(especieVeiculo);
		jsonData['condicaoVin'] = NfeDetEspecificoVeiculoDomain.setCondicaoVin(condicaoVin);
		jsonData['condicaoVeiculo'] = NfeDetEspecificoVeiculoDomain.setCondicaoVeiculo(condicaoVeiculo);
		jsonData['codigoMarcaModelo'] = codigoMarcaModelo;
		jsonData['codigoCorDenatran'] = NfeDetEspecificoVeiculoDomain.setCodigoCorDenatran(codigoCorDenatran);
		jsonData['lotacaoMaxima'] = lotacaoMaxima;
		jsonData['restricao'] = NfeDetEspecificoVeiculoDomain.setRestricao(restricao);
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idNfeDetalhe = plutoRow.cells['idNfeDetalhe']?.value;
		tipoOperacao = plutoRow.cells['tipoOperacao']?.value != '' ? plutoRow.cells['tipoOperacao']?.value : 'AAA';
		chassi = plutoRow.cells['chassi']?.value;
		cor = plutoRow.cells['cor']?.value;
		descricaoCor = plutoRow.cells['descricaoCor']?.value;
		potenciaMotor = plutoRow.cells['potenciaMotor']?.value;
		cilindradas = plutoRow.cells['cilindradas']?.value;
		pesoLiquido = plutoRow.cells['pesoLiquido']?.value;
		pesoBruto = plutoRow.cells['pesoBruto']?.value;
		numeroSerie = plutoRow.cells['numeroSerie']?.value;
		tipoCombustivel = plutoRow.cells['tipoCombustivel']?.value != '' ? plutoRow.cells['tipoCombustivel']?.value : 'AAA';
		numeroMotor = plutoRow.cells['numeroMotor']?.value;
		capacidadeMaximaTracao = plutoRow.cells['capacidadeMaximaTracao']?.value;
		distanciaEixos = plutoRow.cells['distanciaEixos']?.value;
		anoModelo = plutoRow.cells['anoModelo']?.value != '' ? plutoRow.cells['anoModelo']?.value : 'AAA';
		anoFabricacao = plutoRow.cells['anoFabricacao']?.value != '' ? plutoRow.cells['anoFabricacao']?.value : 'AAA';
		tipoPintura = plutoRow.cells['tipoPintura']?.value != '' ? plutoRow.cells['tipoPintura']?.value : 'AAA';
		tipoVeiculo = plutoRow.cells['tipoVeiculo']?.value != '' ? plutoRow.cells['tipoVeiculo']?.value : 'AAA';
		especieVeiculo = plutoRow.cells['especieVeiculo']?.value != '' ? plutoRow.cells['especieVeiculo']?.value : 'AAA';
		condicaoVin = plutoRow.cells['condicaoVin']?.value != '' ? plutoRow.cells['condicaoVin']?.value : 'AAA';
		condicaoVeiculo = plutoRow.cells['condicaoVeiculo']?.value != '' ? plutoRow.cells['condicaoVeiculo']?.value : 'AAA';
		codigoMarcaModelo = plutoRow.cells['codigoMarcaModelo']?.value;
		codigoCorDenatran = plutoRow.cells['codigoCorDenatran']?.value != '' ? plutoRow.cells['codigoCorDenatran']?.value : 'AAA';
		lotacaoMaxima = plutoRow.cells['lotacaoMaxima']?.value;
		restricao = plutoRow.cells['restricao']?.value != '' ? plutoRow.cells['restricao']?.value : 'AAA';
	}	

	NfeDetEspecificoVeiculoModel clone() {
		return NfeDetEspecificoVeiculoModel(
			id: id,
			idNfeDetalhe: idNfeDetalhe,
			tipoOperacao: tipoOperacao,
			chassi: chassi,
			cor: cor,
			descricaoCor: descricaoCor,
			potenciaMotor: potenciaMotor,
			cilindradas: cilindradas,
			pesoLiquido: pesoLiquido,
			pesoBruto: pesoBruto,
			numeroSerie: numeroSerie,
			tipoCombustivel: tipoCombustivel,
			numeroMotor: numeroMotor,
			capacidadeMaximaTracao: capacidadeMaximaTracao,
			distanciaEixos: distanciaEixos,
			anoModelo: anoModelo,
			anoFabricacao: anoFabricacao,
			tipoPintura: tipoPintura,
			tipoVeiculo: tipoVeiculo,
			especieVeiculo: especieVeiculo,
			condicaoVin: condicaoVin,
			condicaoVeiculo: condicaoVeiculo,
			codigoMarcaModelo: codigoMarcaModelo,
			codigoCorDenatran: codigoCorDenatran,
			lotacaoMaxima: lotacaoMaxima,
			restricao: restricao,
		);			
	}

	
}