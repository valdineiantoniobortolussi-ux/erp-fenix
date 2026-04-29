import 'package:frotas/app/data/provider/drift/database/database_imports.dart';
import 'package:frotas/app/infra/infra_imports.dart';
import 'package:frotas/app/data/provider/provider_base.dart';
import 'package:frotas/app/data/provider/drift/database/database.dart';
import 'package:frotas/app/data/model/model_imports.dart';
import 'package:frotas/app/data/domain/domain_imports.dart';

class FrotaVeiculoDriftProvider extends ProviderBase {

	Future<List<FrotaVeiculoModel>?> getList({Filter? filter}) async {
		List<FrotaVeiculoGrouped> frotaVeiculoDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				frotaVeiculoDriftList = await Session.database.frotaVeiculoDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				frotaVeiculoDriftList = await Session.database.frotaVeiculoDao.getGroupedList(); 
			}
			if (frotaVeiculoDriftList.isNotEmpty) {
				return toListModel(frotaVeiculoDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<FrotaVeiculoModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.frotaVeiculoDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<FrotaVeiculoModel?>? insert(FrotaVeiculoModel frotaVeiculoModel) async {
		try {
			final lastPk = await Session.database.frotaVeiculoDao.insertObject(toDrift(frotaVeiculoModel));
			frotaVeiculoModel.id = lastPk;
			return frotaVeiculoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<FrotaVeiculoModel?>? update(FrotaVeiculoModel frotaVeiculoModel) async {
		try {
			await Session.database.frotaVeiculoDao.updateObject(toDrift(frotaVeiculoModel));
			return frotaVeiculoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.frotaVeiculoDao.deleteObject(toDrift(FrotaVeiculoModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<FrotaVeiculoModel> toListModel(List<FrotaVeiculoGrouped> frotaVeiculoDriftList) {
		List<FrotaVeiculoModel> listModel = [];
		for (var frotaVeiculoDrift in frotaVeiculoDriftList) {
			listModel.add(toModel(frotaVeiculoDrift)!);
		}
		return listModel;
	}	

	FrotaVeiculoModel? toModel(FrotaVeiculoGrouped? frotaVeiculoDrift) {
		if (frotaVeiculoDrift != null) {
			return FrotaVeiculoModel(
				id: frotaVeiculoDrift.frotaVeiculo?.id,
				idFrotaVeiculoTipo: frotaVeiculoDrift.frotaVeiculo?.idFrotaVeiculoTipo,
				idFrotaCombustivelTipo: frotaVeiculoDrift.frotaVeiculo?.idFrotaCombustivelTipo,
				marca: frotaVeiculoDrift.frotaVeiculo?.marca,
				modelo: frotaVeiculoDrift.frotaVeiculo?.modelo,
				modeloAno: frotaVeiculoDrift.frotaVeiculo?.modeloAno,
				placa: frotaVeiculoDrift.frotaVeiculo?.placa,
				codigoFipe: frotaVeiculoDrift.frotaVeiculo?.codigoFipe,
				renavam: frotaVeiculoDrift.frotaVeiculo?.renavam,
				ipvaMesVencimento: FrotaVeiculoDomain.getIpvaMesVencimento(frotaVeiculoDrift.frotaVeiculo?.ipvaMesVencimento),
				dpvatMesVencimento: FrotaVeiculoDomain.getDpvatMesVencimento(frotaVeiculoDrift.frotaVeiculo?.dpvatMesVencimento),
				frotaIpvaControleModelList: frotaIpvaControleDriftToModel(frotaVeiculoDrift.frotaIpvaControleGroupedList),
				frotaDpvatControleModelList: frotaDpvatControleDriftToModel(frotaVeiculoDrift.frotaDpvatControleGroupedList),
				frotaVeiculoSinistroModelList: frotaVeiculoSinistroDriftToModel(frotaVeiculoDrift.frotaVeiculoSinistroGroupedList),
				frotaVeiculoMovimentacaoModelList: frotaVeiculoMovimentacaoDriftToModel(frotaVeiculoDrift.frotaVeiculoMovimentacaoGroupedList),
				frotaVeiculoPneuModelList: frotaVeiculoPneuDriftToModel(frotaVeiculoDrift.frotaVeiculoPneuGroupedList),
				frotaVeiculoManutencaoModelList: frotaVeiculoManutencaoDriftToModel(frotaVeiculoDrift.frotaVeiculoManutencaoGroupedList),
				frotaMultaControleModelList: frotaMultaControleDriftToModel(frotaVeiculoDrift.frotaMultaControleGroupedList),
				frotaCombustivelControleModelList: frotaCombustivelControleDriftToModel(frotaVeiculoDrift.frotaCombustivelControleGroupedList),
				frotaVeiculoTipoModel: FrotaVeiculoTipoModel(
					id: frotaVeiculoDrift.frotaVeiculoTipo?.id,
					codigo: frotaVeiculoDrift.frotaVeiculoTipo?.codigo,
					nome: frotaVeiculoDrift.frotaVeiculoTipo?.nome,
				),
				frotaCombustivelTipoModel: FrotaCombustivelTipoModel(
					id: frotaVeiculoDrift.frotaCombustivelTipo?.id,
					codigo: frotaVeiculoDrift.frotaCombustivelTipo?.codigo,
					nome: frotaVeiculoDrift.frotaCombustivelTipo?.nome,
				),
			);
		} else {
			return null;
		}
	}

	List<FrotaIpvaControleModel> frotaIpvaControleDriftToModel(List<FrotaIpvaControleGrouped>? frotaIpvaControleDriftList) { 
		List<FrotaIpvaControleModel> frotaIpvaControleModelList = [];
		if (frotaIpvaControleDriftList != null) {
			for (var frotaIpvaControleGrouped in frotaIpvaControleDriftList) {
				frotaIpvaControleModelList.add(
					FrotaIpvaControleModel(
						id: frotaIpvaControleGrouped.frotaIpvaControle?.id,
						idFrotaVeiculo: frotaIpvaControleGrouped.frotaIpvaControle?.idFrotaVeiculo,
						ano: frotaIpvaControleGrouped.frotaIpvaControle?.ano,
						parcela: frotaIpvaControleGrouped.frotaIpvaControle?.parcela,
						dataVencimento: frotaIpvaControleGrouped.frotaIpvaControle?.dataVencimento,
						dataPagamento: frotaIpvaControleGrouped.frotaIpvaControle?.dataPagamento,
						valor: frotaIpvaControleGrouped.frotaIpvaControle?.valor,
					)
				);
			}
			return frotaIpvaControleModelList;
		}
		return [];
	}

	List<FrotaDpvatControleModel> frotaDpvatControleDriftToModel(List<FrotaDpvatControleGrouped>? frotaDpvatControleDriftList) { 
		List<FrotaDpvatControleModel> frotaDpvatControleModelList = [];
		if (frotaDpvatControleDriftList != null) {
			for (var frotaDpvatControleGrouped in frotaDpvatControleDriftList) {
				frotaDpvatControleModelList.add(
					FrotaDpvatControleModel(
						id: frotaDpvatControleGrouped.frotaDpvatControle?.id,
						idFrotaVeiculo: frotaDpvatControleGrouped.frotaDpvatControle?.idFrotaVeiculo,
						ano: frotaDpvatControleGrouped.frotaDpvatControle?.ano,
						parcela: frotaDpvatControleGrouped.frotaDpvatControle?.parcela,
						dataVencimento: frotaDpvatControleGrouped.frotaDpvatControle?.dataVencimento,
						dataPagamento: frotaDpvatControleGrouped.frotaDpvatControle?.dataPagamento,
						valor: frotaDpvatControleGrouped.frotaDpvatControle?.valor,
					)
				);
			}
			return frotaDpvatControleModelList;
		}
		return [];
	}

	List<FrotaVeiculoSinistroModel> frotaVeiculoSinistroDriftToModel(List<FrotaVeiculoSinistroGrouped>? frotaVeiculoSinistroDriftList) { 
		List<FrotaVeiculoSinistroModel> frotaVeiculoSinistroModelList = [];
		if (frotaVeiculoSinistroDriftList != null) {
			for (var frotaVeiculoSinistroGrouped in frotaVeiculoSinistroDriftList) {
				frotaVeiculoSinistroModelList.add(
					FrotaVeiculoSinistroModel(
						id: frotaVeiculoSinistroGrouped.frotaVeiculoSinistro?.id,
						idFrotaVeiculo: frotaVeiculoSinistroGrouped.frotaVeiculoSinistro?.idFrotaVeiculo,
						dataSinistro: frotaVeiculoSinistroGrouped.frotaVeiculoSinistro?.dataSinistro,
						observacao: frotaVeiculoSinistroGrouped.frotaVeiculoSinistro?.observacao,
					)
				);
			}
			return frotaVeiculoSinistroModelList;
		}
		return [];
	}

	List<FrotaVeiculoMovimentacaoModel> frotaVeiculoMovimentacaoDriftToModel(List<FrotaVeiculoMovimentacaoGrouped>? frotaVeiculoMovimentacaoDriftList) { 
		List<FrotaVeiculoMovimentacaoModel> frotaVeiculoMovimentacaoModelList = [];
		if (frotaVeiculoMovimentacaoDriftList != null) {
			for (var frotaVeiculoMovimentacaoGrouped in frotaVeiculoMovimentacaoDriftList) {
				frotaVeiculoMovimentacaoModelList.add(
					FrotaVeiculoMovimentacaoModel(
						id: frotaVeiculoMovimentacaoGrouped.frotaVeiculoMovimentacao?.id,
						idFrotaVeiculo: frotaVeiculoMovimentacaoGrouped.frotaVeiculoMovimentacao?.idFrotaVeiculo,
						idFrotaMotorista: frotaVeiculoMovimentacaoGrouped.frotaVeiculoMovimentacao?.idFrotaMotorista,
						frotaMotoristaModel: FrotaMotoristaModel(
							id: frotaVeiculoMovimentacaoGrouped.frotaMotorista?.id,
							idColaborador: frotaVeiculoMovimentacaoGrouped.frotaMotorista?.idColaborador,
							nome: frotaVeiculoMovimentacaoGrouped.frotaMotorista?.nome,
							numeroCnh: frotaVeiculoMovimentacaoGrouped.frotaMotorista?.numeroCnh,
							cnhCategoria: frotaVeiculoMovimentacaoGrouped.frotaMotorista?.cnhCategoria,
						),
						dataSaida: frotaVeiculoMovimentacaoGrouped.frotaVeiculoMovimentacao?.dataSaida,
						horaSaida: frotaVeiculoMovimentacaoGrouped.frotaVeiculoMovimentacao?.horaSaida,
						dataEntrada: frotaVeiculoMovimentacaoGrouped.frotaVeiculoMovimentacao?.dataEntrada,
						horaEntrada: frotaVeiculoMovimentacaoGrouped.frotaVeiculoMovimentacao?.horaEntrada,
						observacao: frotaVeiculoMovimentacaoGrouped.frotaVeiculoMovimentacao?.observacao,
					)
				);
			}
			return frotaVeiculoMovimentacaoModelList;
		}
		return [];
	}

	List<FrotaVeiculoPneuModel> frotaVeiculoPneuDriftToModel(List<FrotaVeiculoPneuGrouped>? frotaVeiculoPneuDriftList) { 
		List<FrotaVeiculoPneuModel> frotaVeiculoPneuModelList = [];
		if (frotaVeiculoPneuDriftList != null) {
			for (var frotaVeiculoPneuGrouped in frotaVeiculoPneuDriftList) {
				frotaVeiculoPneuModelList.add(
					FrotaVeiculoPneuModel(
						id: frotaVeiculoPneuGrouped.frotaVeiculoPneu?.id,
						idFrotaVeiculo: frotaVeiculoPneuGrouped.frotaVeiculoPneu?.idFrotaVeiculo,
						dataTroca: frotaVeiculoPneuGrouped.frotaVeiculoPneu?.dataTroca,
						valorTroca: frotaVeiculoPneuGrouped.frotaVeiculoPneu?.valorTroca,
						posicaoPneu: frotaVeiculoPneuGrouped.frotaVeiculoPneu?.posicaoPneu,
						marcaPneu: frotaVeiculoPneuGrouped.frotaVeiculoPneu?.marcaPneu,
					)
				);
			}
			return frotaVeiculoPneuModelList;
		}
		return [];
	}

	List<FrotaVeiculoManutencaoModel> frotaVeiculoManutencaoDriftToModel(List<FrotaVeiculoManutencaoGrouped>? frotaVeiculoManutencaoDriftList) { 
		List<FrotaVeiculoManutencaoModel> frotaVeiculoManutencaoModelList = [];
		if (frotaVeiculoManutencaoDriftList != null) {
			for (var frotaVeiculoManutencaoGrouped in frotaVeiculoManutencaoDriftList) {
				frotaVeiculoManutencaoModelList.add(
					FrotaVeiculoManutencaoModel(
						id: frotaVeiculoManutencaoGrouped.frotaVeiculoManutencao?.id,
						idFrotaVeiculo: frotaVeiculoManutencaoGrouped.frotaVeiculoManutencao?.idFrotaVeiculo,
						tipo: FrotaVeiculoManutencaoDomain.getTipo(frotaVeiculoManutencaoGrouped.frotaVeiculoManutencao?.tipo),
						dataManutencao: frotaVeiculoManutencaoGrouped.frotaVeiculoManutencao?.dataManutencao,
						valorManutencao: frotaVeiculoManutencaoGrouped.frotaVeiculoManutencao?.valorManutencao,
						observacao: frotaVeiculoManutencaoGrouped.frotaVeiculoManutencao?.observacao,
					)
				);
			}
			return frotaVeiculoManutencaoModelList;
		}
		return [];
	}

	List<FrotaMultaControleModel> frotaMultaControleDriftToModel(List<FrotaMultaControleGrouped>? frotaMultaControleDriftList) { 
		List<FrotaMultaControleModel> frotaMultaControleModelList = [];
		if (frotaMultaControleDriftList != null) {
			for (var frotaMultaControleGrouped in frotaMultaControleDriftList) {
				frotaMultaControleModelList.add(
					FrotaMultaControleModel(
						id: frotaMultaControleGrouped.frotaMultaControle?.id,
						idFrotaVeiculo: frotaMultaControleGrouped.frotaMultaControle?.idFrotaVeiculo,
						dataMulta: frotaMultaControleGrouped.frotaMultaControle?.dataMulta,
						pontos: frotaMultaControleGrouped.frotaMultaControle?.pontos,
						valor: frotaMultaControleGrouped.frotaMultaControle?.valor,
						observacao: frotaMultaControleGrouped.frotaMultaControle?.observacao,
					)
				);
			}
			return frotaMultaControleModelList;
		}
		return [];
	}

	List<FrotaCombustivelControleModel> frotaCombustivelControleDriftToModel(List<FrotaCombustivelControleGrouped>? frotaCombustivelControleDriftList) { 
		List<FrotaCombustivelControleModel> frotaCombustivelControleModelList = [];
		if (frotaCombustivelControleDriftList != null) {
			for (var frotaCombustivelControleGrouped in frotaCombustivelControleDriftList) {
				frotaCombustivelControleModelList.add(
					FrotaCombustivelControleModel(
						id: frotaCombustivelControleGrouped.frotaCombustivelControle?.id,
						idFrotaVeiculo: frotaCombustivelControleGrouped.frotaCombustivelControle?.idFrotaVeiculo,
						dataAbastecimento: frotaCombustivelControleGrouped.frotaCombustivelControle?.dataAbastecimento,
						horaAbastecimento: frotaCombustivelControleGrouped.frotaCombustivelControle?.horaAbastecimento,
						valorAbastecimento: frotaCombustivelControleGrouped.frotaCombustivelControle?.valorAbastecimento,
					)
				);
			}
			return frotaCombustivelControleModelList;
		}
		return [];
	}


	FrotaVeiculoGrouped toDrift(FrotaVeiculoModel frotaVeiculoModel) {
		return FrotaVeiculoGrouped(
			frotaVeiculo: FrotaVeiculo(
				id: frotaVeiculoModel.id,
				idFrotaVeiculoTipo: frotaVeiculoModel.idFrotaVeiculoTipo,
				idFrotaCombustivelTipo: frotaVeiculoModel.idFrotaCombustivelTipo,
				marca: frotaVeiculoModel.marca,
				modelo: frotaVeiculoModel.modelo,
				modeloAno: frotaVeiculoModel.modeloAno,
				placa: frotaVeiculoModel.placa,
				codigoFipe: frotaVeiculoModel.codigoFipe,
				renavam: frotaVeiculoModel.renavam,
				ipvaMesVencimento: FrotaVeiculoDomain.setIpvaMesVencimento(frotaVeiculoModel.ipvaMesVencimento),
				dpvatMesVencimento: FrotaVeiculoDomain.setDpvatMesVencimento(frotaVeiculoModel.dpvatMesVencimento),
			),
			frotaIpvaControleGroupedList: frotaIpvaControleModelToDrift(frotaVeiculoModel.frotaIpvaControleModelList),
			frotaDpvatControleGroupedList: frotaDpvatControleModelToDrift(frotaVeiculoModel.frotaDpvatControleModelList),
			frotaVeiculoSinistroGroupedList: frotaVeiculoSinistroModelToDrift(frotaVeiculoModel.frotaVeiculoSinistroModelList),
			frotaVeiculoMovimentacaoGroupedList: frotaVeiculoMovimentacaoModelToDrift(frotaVeiculoModel.frotaVeiculoMovimentacaoModelList),
			frotaVeiculoPneuGroupedList: frotaVeiculoPneuModelToDrift(frotaVeiculoModel.frotaVeiculoPneuModelList),
			frotaVeiculoManutencaoGroupedList: frotaVeiculoManutencaoModelToDrift(frotaVeiculoModel.frotaVeiculoManutencaoModelList),
			frotaMultaControleGroupedList: frotaMultaControleModelToDrift(frotaVeiculoModel.frotaMultaControleModelList),
			frotaCombustivelControleGroupedList: frotaCombustivelControleModelToDrift(frotaVeiculoModel.frotaCombustivelControleModelList),
		);
	}

	List<FrotaIpvaControleGrouped> frotaIpvaControleModelToDrift(List<FrotaIpvaControleModel>? frotaIpvaControleModelList) { 
		List<FrotaIpvaControleGrouped> frotaIpvaControleGroupedList = [];
		if (frotaIpvaControleModelList != null) {
			for (var frotaIpvaControleModel in frotaIpvaControleModelList) {
				frotaIpvaControleGroupedList.add(
					FrotaIpvaControleGrouped(
						frotaIpvaControle: FrotaIpvaControle(
							id: frotaIpvaControleModel.id,
							idFrotaVeiculo: frotaIpvaControleModel.idFrotaVeiculo,
							ano: frotaIpvaControleModel.ano,
							parcela: frotaIpvaControleModel.parcela,
							dataVencimento: frotaIpvaControleModel.dataVencimento,
							dataPagamento: frotaIpvaControleModel.dataPagamento,
							valor: frotaIpvaControleModel.valor,
						),
					),
				);
			}
			return frotaIpvaControleGroupedList;
		}
		return [];
	}

	List<FrotaDpvatControleGrouped> frotaDpvatControleModelToDrift(List<FrotaDpvatControleModel>? frotaDpvatControleModelList) { 
		List<FrotaDpvatControleGrouped> frotaDpvatControleGroupedList = [];
		if (frotaDpvatControleModelList != null) {
			for (var frotaDpvatControleModel in frotaDpvatControleModelList) {
				frotaDpvatControleGroupedList.add(
					FrotaDpvatControleGrouped(
						frotaDpvatControle: FrotaDpvatControle(
							id: frotaDpvatControleModel.id,
							idFrotaVeiculo: frotaDpvatControleModel.idFrotaVeiculo,
							ano: frotaDpvatControleModel.ano,
							parcela: frotaDpvatControleModel.parcela,
							dataVencimento: frotaDpvatControleModel.dataVencimento,
							dataPagamento: frotaDpvatControleModel.dataPagamento,
							valor: frotaDpvatControleModel.valor,
						),
					),
				);
			}
			return frotaDpvatControleGroupedList;
		}
		return [];
	}

	List<FrotaVeiculoSinistroGrouped> frotaVeiculoSinistroModelToDrift(List<FrotaVeiculoSinistroModel>? frotaVeiculoSinistroModelList) { 
		List<FrotaVeiculoSinistroGrouped> frotaVeiculoSinistroGroupedList = [];
		if (frotaVeiculoSinistroModelList != null) {
			for (var frotaVeiculoSinistroModel in frotaVeiculoSinistroModelList) {
				frotaVeiculoSinistroGroupedList.add(
					FrotaVeiculoSinistroGrouped(
						frotaVeiculoSinistro: FrotaVeiculoSinistro(
							id: frotaVeiculoSinistroModel.id,
							idFrotaVeiculo: frotaVeiculoSinistroModel.idFrotaVeiculo,
							dataSinistro: frotaVeiculoSinistroModel.dataSinistro,
							observacao: frotaVeiculoSinistroModel.observacao,
						),
					),
				);
			}
			return frotaVeiculoSinistroGroupedList;
		}
		return [];
	}

	List<FrotaVeiculoMovimentacaoGrouped> frotaVeiculoMovimentacaoModelToDrift(List<FrotaVeiculoMovimentacaoModel>? frotaVeiculoMovimentacaoModelList) { 
		List<FrotaVeiculoMovimentacaoGrouped> frotaVeiculoMovimentacaoGroupedList = [];
		if (frotaVeiculoMovimentacaoModelList != null) {
			for (var frotaVeiculoMovimentacaoModel in frotaVeiculoMovimentacaoModelList) {
				frotaVeiculoMovimentacaoGroupedList.add(
					FrotaVeiculoMovimentacaoGrouped(
						frotaVeiculoMovimentacao: FrotaVeiculoMovimentacao(
							id: frotaVeiculoMovimentacaoModel.id,
							idFrotaVeiculo: frotaVeiculoMovimentacaoModel.idFrotaVeiculo,
							idFrotaMotorista: frotaVeiculoMovimentacaoModel.idFrotaMotorista,
							dataSaida: frotaVeiculoMovimentacaoModel.dataSaida,
							horaSaida: Util.removeMask(frotaVeiculoMovimentacaoModel.horaSaida),
							dataEntrada: frotaVeiculoMovimentacaoModel.dataEntrada,
							horaEntrada: Util.removeMask(frotaVeiculoMovimentacaoModel.horaEntrada),
							observacao: frotaVeiculoMovimentacaoModel.observacao,
						),
					),
				);
			}
			return frotaVeiculoMovimentacaoGroupedList;
		}
		return [];
	}

	List<FrotaVeiculoPneuGrouped> frotaVeiculoPneuModelToDrift(List<FrotaVeiculoPneuModel>? frotaVeiculoPneuModelList) { 
		List<FrotaVeiculoPneuGrouped> frotaVeiculoPneuGroupedList = [];
		if (frotaVeiculoPneuModelList != null) {
			for (var frotaVeiculoPneuModel in frotaVeiculoPneuModelList) {
				frotaVeiculoPneuGroupedList.add(
					FrotaVeiculoPneuGrouped(
						frotaVeiculoPneu: FrotaVeiculoPneu(
							id: frotaVeiculoPneuModel.id,
							idFrotaVeiculo: frotaVeiculoPneuModel.idFrotaVeiculo,
							dataTroca: frotaVeiculoPneuModel.dataTroca,
							valorTroca: frotaVeiculoPneuModel.valorTroca,
							posicaoPneu: frotaVeiculoPneuModel.posicaoPneu,
							marcaPneu: frotaVeiculoPneuModel.marcaPneu,
						),
					),
				);
			}
			return frotaVeiculoPneuGroupedList;
		}
		return [];
	}

	List<FrotaVeiculoManutencaoGrouped> frotaVeiculoManutencaoModelToDrift(List<FrotaVeiculoManutencaoModel>? frotaVeiculoManutencaoModelList) { 
		List<FrotaVeiculoManutencaoGrouped> frotaVeiculoManutencaoGroupedList = [];
		if (frotaVeiculoManutencaoModelList != null) {
			for (var frotaVeiculoManutencaoModel in frotaVeiculoManutencaoModelList) {
				frotaVeiculoManutencaoGroupedList.add(
					FrotaVeiculoManutencaoGrouped(
						frotaVeiculoManutencao: FrotaVeiculoManutencao(
							id: frotaVeiculoManutencaoModel.id,
							idFrotaVeiculo: frotaVeiculoManutencaoModel.idFrotaVeiculo,
							tipo: FrotaVeiculoManutencaoDomain.setTipo(frotaVeiculoManutencaoModel.tipo),
							dataManutencao: frotaVeiculoManutencaoModel.dataManutencao,
							valorManutencao: frotaVeiculoManutencaoModel.valorManutencao,
							observacao: frotaVeiculoManutencaoModel.observacao,
						),
					),
				);
			}
			return frotaVeiculoManutencaoGroupedList;
		}
		return [];
	}

	List<FrotaMultaControleGrouped> frotaMultaControleModelToDrift(List<FrotaMultaControleModel>? frotaMultaControleModelList) { 
		List<FrotaMultaControleGrouped> frotaMultaControleGroupedList = [];
		if (frotaMultaControleModelList != null) {
			for (var frotaMultaControleModel in frotaMultaControleModelList) {
				frotaMultaControleGroupedList.add(
					FrotaMultaControleGrouped(
						frotaMultaControle: FrotaMultaControle(
							id: frotaMultaControleModel.id,
							idFrotaVeiculo: frotaMultaControleModel.idFrotaVeiculo,
							dataMulta: frotaMultaControleModel.dataMulta,
							pontos: frotaMultaControleModel.pontos,
							valor: frotaMultaControleModel.valor,
							observacao: frotaMultaControleModel.observacao,
						),
					),
				);
			}
			return frotaMultaControleGroupedList;
		}
		return [];
	}

	List<FrotaCombustivelControleGrouped> frotaCombustivelControleModelToDrift(List<FrotaCombustivelControleModel>? frotaCombustivelControleModelList) { 
		List<FrotaCombustivelControleGrouped> frotaCombustivelControleGroupedList = [];
		if (frotaCombustivelControleModelList != null) {
			for (var frotaCombustivelControleModel in frotaCombustivelControleModelList) {
				frotaCombustivelControleGroupedList.add(
					FrotaCombustivelControleGrouped(
						frotaCombustivelControle: FrotaCombustivelControle(
							id: frotaCombustivelControleModel.id,
							idFrotaVeiculo: frotaCombustivelControleModel.idFrotaVeiculo,
							dataAbastecimento: frotaCombustivelControleModel.dataAbastecimento,
							horaAbastecimento: Util.removeMask(frotaCombustivelControleModel.horaAbastecimento),
							valorAbastecimento: frotaCombustivelControleModel.valorAbastecimento,
						),
					),
				);
			}
			return frotaCombustivelControleGroupedList;
		}
		return [];
	}

		
}
