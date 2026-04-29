import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:frotas/app/data/model/model_imports.dart';
import 'package:frotas/app/data/domain/domain_imports.dart';

class FrotaVeiculoModel {
	int? id;
	int? idFrotaVeiculoTipo;
	int? idFrotaCombustivelTipo;
	String? marca;
	String? modelo;
	String? modeloAno;
	String? placa;
	String? codigoFipe;
	String? renavam;
	String? ipvaMesVencimento;
	String? dpvatMesVencimento;
	List<FrotaIpvaControleModel>? frotaIpvaControleModelList;
	List<FrotaDpvatControleModel>? frotaDpvatControleModelList;
	List<FrotaVeiculoSinistroModel>? frotaVeiculoSinistroModelList;
	List<FrotaVeiculoMovimentacaoModel>? frotaVeiculoMovimentacaoModelList;
	List<FrotaVeiculoPneuModel>? frotaVeiculoPneuModelList;
	List<FrotaVeiculoManutencaoModel>? frotaVeiculoManutencaoModelList;
	List<FrotaMultaControleModel>? frotaMultaControleModelList;
	List<FrotaCombustivelControleModel>? frotaCombustivelControleModelList;
	FrotaVeiculoTipoModel? frotaVeiculoTipoModel;
	FrotaCombustivelTipoModel? frotaCombustivelTipoModel;

	FrotaVeiculoModel({
		this.id,
		this.idFrotaVeiculoTipo,
		this.idFrotaCombustivelTipo,
		this.marca,
		this.modelo,
		this.modeloAno,
		this.placa,
		this.codigoFipe,
		this.renavam,
		this.ipvaMesVencimento,
		this.dpvatMesVencimento,
		this.frotaIpvaControleModelList,
		this.frotaDpvatControleModelList,
		this.frotaVeiculoSinistroModelList,
		this.frotaVeiculoMovimentacaoModelList,
		this.frotaVeiculoPneuModelList,
		this.frotaVeiculoManutencaoModelList,
		this.frotaMultaControleModelList,
		this.frotaCombustivelControleModelList,
		this.frotaVeiculoTipoModel,
		this.frotaCombustivelTipoModel,
	});

	static List<String> dbColumns = <String>[
		'id',
		'marca',
		'modelo',
		'modelo_ano',
		'placa',
		'codigo_fipe',
		'renavam',
		'ipva_mes_vencimento',
		'dpvat_mes_vencimento',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Marca',
		'Modelo',
		'Modelo Ano',
		'Placa',
		'Codigo Fipe',
		'Renavam',
		'Ipva Mes Vencimento',
		'Dpvat Mes Vencimento',
	];

	FrotaVeiculoModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idFrotaVeiculoTipo = jsonData['idFrotaVeiculoTipo'];
		idFrotaCombustivelTipo = jsonData['idFrotaCombustivelTipo'];
		marca = jsonData['marca'];
		modelo = jsonData['modelo'];
		modeloAno = jsonData['modeloAno'];
		placa = jsonData['placa'];
		codigoFipe = jsonData['codigoFipe'];
		renavam = jsonData['renavam'];
		ipvaMesVencimento = FrotaVeiculoDomain.getIpvaMesVencimento(jsonData['ipvaMesVencimento']);
		dpvatMesVencimento = FrotaVeiculoDomain.getDpvatMesVencimento(jsonData['dpvatMesVencimento']);
		frotaIpvaControleModelList = (jsonData['frotaIpvaControleModelList'] as Iterable?)?.map((m) => FrotaIpvaControleModel.fromJson(m)).toList() ?? [];
		frotaDpvatControleModelList = (jsonData['frotaDpvatControleModelList'] as Iterable?)?.map((m) => FrotaDpvatControleModel.fromJson(m)).toList() ?? [];
		frotaVeiculoSinistroModelList = (jsonData['frotaVeiculoSinistroModelList'] as Iterable?)?.map((m) => FrotaVeiculoSinistroModel.fromJson(m)).toList() ?? [];
		frotaVeiculoMovimentacaoModelList = (jsonData['frotaVeiculoMovimentacaoModelList'] as Iterable?)?.map((m) => FrotaVeiculoMovimentacaoModel.fromJson(m)).toList() ?? [];
		frotaVeiculoPneuModelList = (jsonData['frotaVeiculoPneuModelList'] as Iterable?)?.map((m) => FrotaVeiculoPneuModel.fromJson(m)).toList() ?? [];
		frotaVeiculoManutencaoModelList = (jsonData['frotaVeiculoManutencaoModelList'] as Iterable?)?.map((m) => FrotaVeiculoManutencaoModel.fromJson(m)).toList() ?? [];
		frotaMultaControleModelList = (jsonData['frotaMultaControleModelList'] as Iterable?)?.map((m) => FrotaMultaControleModel.fromJson(m)).toList() ?? [];
		frotaCombustivelControleModelList = (jsonData['frotaCombustivelControleModelList'] as Iterable?)?.map((m) => FrotaCombustivelControleModel.fromJson(m)).toList() ?? [];
		frotaVeiculoTipoModel = jsonData['frotaVeiculoTipoModel'] == null ? FrotaVeiculoTipoModel() : FrotaVeiculoTipoModel.fromJson(jsonData['frotaVeiculoTipoModel']);
		frotaCombustivelTipoModel = jsonData['frotaCombustivelTipoModel'] == null ? FrotaCombustivelTipoModel() : FrotaCombustivelTipoModel.fromJson(jsonData['frotaCombustivelTipoModel']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idFrotaVeiculoTipo'] = idFrotaVeiculoTipo != 0 ? idFrotaVeiculoTipo : null;
		jsonData['idFrotaCombustivelTipo'] = idFrotaCombustivelTipo != 0 ? idFrotaCombustivelTipo : null;
		jsonData['marca'] = marca;
		jsonData['modelo'] = modelo;
		jsonData['modeloAno'] = modeloAno;
		jsonData['placa'] = placa;
		jsonData['codigoFipe'] = codigoFipe;
		jsonData['renavam'] = renavam;
		jsonData['ipvaMesVencimento'] = FrotaVeiculoDomain.setIpvaMesVencimento(ipvaMesVencimento);
		jsonData['dpvatMesVencimento'] = FrotaVeiculoDomain.setDpvatMesVencimento(dpvatMesVencimento);
		
		var frotaIpvaControleModelLocalList = []; 
		for (FrotaIpvaControleModel object in frotaIpvaControleModelList ?? []) { 
			frotaIpvaControleModelLocalList.add(object.toJson); 
		}
		jsonData['frotaIpvaControleModelList'] = frotaIpvaControleModelLocalList;
		
		var frotaDpvatControleModelLocalList = []; 
		for (FrotaDpvatControleModel object in frotaDpvatControleModelList ?? []) { 
			frotaDpvatControleModelLocalList.add(object.toJson); 
		}
		jsonData['frotaDpvatControleModelList'] = frotaDpvatControleModelLocalList;
		
		var frotaVeiculoSinistroModelLocalList = []; 
		for (FrotaVeiculoSinistroModel object in frotaVeiculoSinistroModelList ?? []) { 
			frotaVeiculoSinistroModelLocalList.add(object.toJson); 
		}
		jsonData['frotaVeiculoSinistroModelList'] = frotaVeiculoSinistroModelLocalList;
		
		var frotaVeiculoMovimentacaoModelLocalList = []; 
		for (FrotaVeiculoMovimentacaoModel object in frotaVeiculoMovimentacaoModelList ?? []) { 
			frotaVeiculoMovimentacaoModelLocalList.add(object.toJson); 
		}
		jsonData['frotaVeiculoMovimentacaoModelList'] = frotaVeiculoMovimentacaoModelLocalList;
		
		var frotaVeiculoPneuModelLocalList = []; 
		for (FrotaVeiculoPneuModel object in frotaVeiculoPneuModelList ?? []) { 
			frotaVeiculoPneuModelLocalList.add(object.toJson); 
		}
		jsonData['frotaVeiculoPneuModelList'] = frotaVeiculoPneuModelLocalList;
		
		var frotaVeiculoManutencaoModelLocalList = []; 
		for (FrotaVeiculoManutencaoModel object in frotaVeiculoManutencaoModelList ?? []) { 
			frotaVeiculoManutencaoModelLocalList.add(object.toJson); 
		}
		jsonData['frotaVeiculoManutencaoModelList'] = frotaVeiculoManutencaoModelLocalList;
		
		var frotaMultaControleModelLocalList = []; 
		for (FrotaMultaControleModel object in frotaMultaControleModelList ?? []) { 
			frotaMultaControleModelLocalList.add(object.toJson); 
		}
		jsonData['frotaMultaControleModelList'] = frotaMultaControleModelLocalList;
		
		var frotaCombustivelControleModelLocalList = []; 
		for (FrotaCombustivelControleModel object in frotaCombustivelControleModelList ?? []) { 
			frotaCombustivelControleModelLocalList.add(object.toJson); 
		}
		jsonData['frotaCombustivelControleModelList'] = frotaCombustivelControleModelLocalList;
		jsonData['frotaVeiculoTipoModel'] = frotaVeiculoTipoModel?.toJson;
		jsonData['frotaCombustivelTipoModel'] = frotaCombustivelTipoModel?.toJson;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idFrotaVeiculoTipo = plutoRow.cells['idFrotaVeiculoTipo']?.value;
		idFrotaCombustivelTipo = plutoRow.cells['idFrotaCombustivelTipo']?.value;
		marca = plutoRow.cells['marca']?.value;
		modelo = plutoRow.cells['modelo']?.value;
		modeloAno = plutoRow.cells['modeloAno']?.value;
		placa = plutoRow.cells['placa']?.value;
		codigoFipe = plutoRow.cells['codigoFipe']?.value;
		renavam = plutoRow.cells['renavam']?.value;
		ipvaMesVencimento = plutoRow.cells['ipvaMesVencimento']?.value != '' ? plutoRow.cells['ipvaMesVencimento']?.value : '01';
		dpvatMesVencimento = plutoRow.cells['dpvatMesVencimento']?.value != '' ? plutoRow.cells['dpvatMesVencimento']?.value : '01';
		frotaIpvaControleModelList = [];
		frotaDpvatControleModelList = [];
		frotaVeiculoSinistroModelList = [];
		frotaVeiculoMovimentacaoModelList = [];
		frotaVeiculoPneuModelList = [];
		frotaVeiculoManutencaoModelList = [];
		frotaMultaControleModelList = [];
		frotaCombustivelControleModelList = [];
		frotaVeiculoTipoModel = FrotaVeiculoTipoModel();
		frotaVeiculoTipoModel?.nome = plutoRow.cells['frotaVeiculoTipoModel']?.value;
		frotaCombustivelTipoModel = FrotaCombustivelTipoModel();
		frotaCombustivelTipoModel?.nome = plutoRow.cells['frotaCombustivelTipoModel']?.value;
	}	

	FrotaVeiculoModel clone() {
		return FrotaVeiculoModel(
			id: id,
			idFrotaVeiculoTipo: idFrotaVeiculoTipo,
			idFrotaCombustivelTipo: idFrotaCombustivelTipo,
			marca: marca,
			modelo: modelo,
			modeloAno: modeloAno,
			placa: placa,
			codigoFipe: codigoFipe,
			renavam: renavam,
			ipvaMesVencimento: ipvaMesVencimento,
			dpvatMesVencimento: dpvatMesVencimento,
			frotaIpvaControleModelList: frotaIpvaControleModelListClone(frotaIpvaControleModelList!),
			frotaDpvatControleModelList: frotaDpvatControleModelListClone(frotaDpvatControleModelList!),
			frotaVeiculoSinistroModelList: frotaVeiculoSinistroModelListClone(frotaVeiculoSinistroModelList!),
			frotaVeiculoMovimentacaoModelList: frotaVeiculoMovimentacaoModelListClone(frotaVeiculoMovimentacaoModelList!),
			frotaVeiculoPneuModelList: frotaVeiculoPneuModelListClone(frotaVeiculoPneuModelList!),
			frotaVeiculoManutencaoModelList: frotaVeiculoManutencaoModelListClone(frotaVeiculoManutencaoModelList!),
			frotaMultaControleModelList: frotaMultaControleModelListClone(frotaMultaControleModelList!),
			frotaCombustivelControleModelList: frotaCombustivelControleModelListClone(frotaCombustivelControleModelList!),
		);			
	}

	frotaIpvaControleModelListClone(List<FrotaIpvaControleModel> frotaIpvaControleModelList) { 
		List<FrotaIpvaControleModel> resultList = [];
		for (var frotaIpvaControleModel in frotaIpvaControleModelList) {
			resultList.add(
				FrotaIpvaControleModel(
					id: frotaIpvaControleModel.id,
					idFrotaVeiculo: frotaIpvaControleModel.idFrotaVeiculo,
					ano: frotaIpvaControleModel.ano,
					parcela: frotaIpvaControleModel.parcela,
					dataVencimento: frotaIpvaControleModel.dataVencimento,
					dataPagamento: frotaIpvaControleModel.dataPagamento,
					valor: frotaIpvaControleModel.valor,
				)
			);
		}
		return resultList;
	}

	frotaDpvatControleModelListClone(List<FrotaDpvatControleModel> frotaDpvatControleModelList) { 
		List<FrotaDpvatControleModel> resultList = [];
		for (var frotaDpvatControleModel in frotaDpvatControleModelList) {
			resultList.add(
				FrotaDpvatControleModel(
					id: frotaDpvatControleModel.id,
					idFrotaVeiculo: frotaDpvatControleModel.idFrotaVeiculo,
					ano: frotaDpvatControleModel.ano,
					parcela: frotaDpvatControleModel.parcela,
					dataVencimento: frotaDpvatControleModel.dataVencimento,
					dataPagamento: frotaDpvatControleModel.dataPagamento,
					valor: frotaDpvatControleModel.valor,
				)
			);
		}
		return resultList;
	}

	frotaVeiculoSinistroModelListClone(List<FrotaVeiculoSinistroModel> frotaVeiculoSinistroModelList) { 
		List<FrotaVeiculoSinistroModel> resultList = [];
		for (var frotaVeiculoSinistroModel in frotaVeiculoSinistroModelList) {
			resultList.add(
				FrotaVeiculoSinistroModel(
					id: frotaVeiculoSinistroModel.id,
					idFrotaVeiculo: frotaVeiculoSinistroModel.idFrotaVeiculo,
					dataSinistro: frotaVeiculoSinistroModel.dataSinistro,
					observacao: frotaVeiculoSinistroModel.observacao,
				)
			);
		}
		return resultList;
	}

	frotaVeiculoMovimentacaoModelListClone(List<FrotaVeiculoMovimentacaoModel> frotaVeiculoMovimentacaoModelList) { 
		List<FrotaVeiculoMovimentacaoModel> resultList = [];
		for (var frotaVeiculoMovimentacaoModel in frotaVeiculoMovimentacaoModelList) {
			resultList.add(
				FrotaVeiculoMovimentacaoModel(
					id: frotaVeiculoMovimentacaoModel.id,
					idFrotaVeiculo: frotaVeiculoMovimentacaoModel.idFrotaVeiculo,
					idFrotaMotorista: frotaVeiculoMovimentacaoModel.idFrotaMotorista,
					dataSaida: frotaVeiculoMovimentacaoModel.dataSaida,
					horaSaida: frotaVeiculoMovimentacaoModel.horaSaida,
					dataEntrada: frotaVeiculoMovimentacaoModel.dataEntrada,
					horaEntrada: frotaVeiculoMovimentacaoModel.horaEntrada,
					observacao: frotaVeiculoMovimentacaoModel.observacao,
				)
			);
		}
		return resultList;
	}

	frotaVeiculoPneuModelListClone(List<FrotaVeiculoPneuModel> frotaVeiculoPneuModelList) { 
		List<FrotaVeiculoPneuModel> resultList = [];
		for (var frotaVeiculoPneuModel in frotaVeiculoPneuModelList) {
			resultList.add(
				FrotaVeiculoPneuModel(
					id: frotaVeiculoPneuModel.id,
					idFrotaVeiculo: frotaVeiculoPneuModel.idFrotaVeiculo,
					dataTroca: frotaVeiculoPneuModel.dataTroca,
					valorTroca: frotaVeiculoPneuModel.valorTroca,
					posicaoPneu: frotaVeiculoPneuModel.posicaoPneu,
					marcaPneu: frotaVeiculoPneuModel.marcaPneu,
				)
			);
		}
		return resultList;
	}

	frotaVeiculoManutencaoModelListClone(List<FrotaVeiculoManutencaoModel> frotaVeiculoManutencaoModelList) { 
		List<FrotaVeiculoManutencaoModel> resultList = [];
		for (var frotaVeiculoManutencaoModel in frotaVeiculoManutencaoModelList) {
			resultList.add(
				FrotaVeiculoManutencaoModel(
					id: frotaVeiculoManutencaoModel.id,
					idFrotaVeiculo: frotaVeiculoManutencaoModel.idFrotaVeiculo,
					tipo: frotaVeiculoManutencaoModel.tipo,
					dataManutencao: frotaVeiculoManutencaoModel.dataManutencao,
					valorManutencao: frotaVeiculoManutencaoModel.valorManutencao,
					observacao: frotaVeiculoManutencaoModel.observacao,
				)
			);
		}
		return resultList;
	}

	frotaMultaControleModelListClone(List<FrotaMultaControleModel> frotaMultaControleModelList) { 
		List<FrotaMultaControleModel> resultList = [];
		for (var frotaMultaControleModel in frotaMultaControleModelList) {
			resultList.add(
				FrotaMultaControleModel(
					id: frotaMultaControleModel.id,
					idFrotaVeiculo: frotaMultaControleModel.idFrotaVeiculo,
					dataMulta: frotaMultaControleModel.dataMulta,
					pontos: frotaMultaControleModel.pontos,
					valor: frotaMultaControleModel.valor,
					observacao: frotaMultaControleModel.observacao,
				)
			);
		}
		return resultList;
	}

	frotaCombustivelControleModelListClone(List<FrotaCombustivelControleModel> frotaCombustivelControleModelList) { 
		List<FrotaCombustivelControleModel> resultList = [];
		for (var frotaCombustivelControleModel in frotaCombustivelControleModelList) {
			resultList.add(
				FrotaCombustivelControleModel(
					id: frotaCombustivelControleModel.id,
					idFrotaVeiculo: frotaCombustivelControleModel.idFrotaVeiculo,
					dataAbastecimento: frotaCombustivelControleModel.dataAbastecimento,
					horaAbastecimento: frotaCombustivelControleModel.horaAbastecimento,
					valorAbastecimento: frotaCombustivelControleModel.valorAbastecimento,
				)
			);
		}
		return resultList;
	}

	
}