import 'package:financeiro/app/data/provider/drift/database/database_imports.dart';
import 'package:financeiro/app/infra/infra_imports.dart';
import 'package:financeiro/app/data/provider/provider_base.dart';
import 'package:financeiro/app/data/provider/drift/database/database.dart';
import 'package:financeiro/app/data/model/model_imports.dart';
import 'package:financeiro/app/data/domain/domain_imports.dart';

class TalonarioChequeDriftProvider extends ProviderBase {

	Future<List<TalonarioChequeModel>?> getList({Filter? filter}) async {
		List<TalonarioChequeGrouped> talonarioChequeDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				talonarioChequeDriftList = await Session.database.talonarioChequeDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				talonarioChequeDriftList = await Session.database.talonarioChequeDao.getGroupedList(); 
			}
			if (talonarioChequeDriftList.isNotEmpty) {
				return toListModel(talonarioChequeDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<TalonarioChequeModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.talonarioChequeDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<TalonarioChequeModel?>? insert(TalonarioChequeModel talonarioChequeModel) async {
		try {
			final lastPk = await Session.database.talonarioChequeDao.insertObject(toDrift(talonarioChequeModel));
			talonarioChequeModel.id = lastPk;
			return talonarioChequeModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<TalonarioChequeModel?>? update(TalonarioChequeModel talonarioChequeModel) async {
		try {
			await Session.database.talonarioChequeDao.updateObject(toDrift(talonarioChequeModel));
			return talonarioChequeModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.talonarioChequeDao.deleteObject(toDrift(TalonarioChequeModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<TalonarioChequeModel> toListModel(List<TalonarioChequeGrouped> talonarioChequeDriftList) {
		List<TalonarioChequeModel> listModel = [];
		for (var talonarioChequeDrift in talonarioChequeDriftList) {
			listModel.add(toModel(talonarioChequeDrift)!);
		}
		return listModel;
	}	

	TalonarioChequeModel? toModel(TalonarioChequeGrouped? talonarioChequeDrift) {
		if (talonarioChequeDrift != null) {
			return TalonarioChequeModel(
				id: talonarioChequeDrift.talonarioCheque?.id,
				idBancoContaCaixa: talonarioChequeDrift.talonarioCheque?.idBancoContaCaixa,
				talao: talonarioChequeDrift.talonarioCheque?.talao,
				numero: talonarioChequeDrift.talonarioCheque?.numero,
				statusTalao: TalonarioChequeDomain.getStatusTalao(talonarioChequeDrift.talonarioCheque?.statusTalao),
				chequeModelList: chequeDriftToModel(talonarioChequeDrift.chequeGroupedList),
				bancoContaCaixaModel: BancoContaCaixaModel(
					id: talonarioChequeDrift.bancoContaCaixa?.id,
					idBancoAgencia: talonarioChequeDrift.bancoContaCaixa?.idBancoAgencia,
					numero: talonarioChequeDrift.bancoContaCaixa?.numero,
					digito: talonarioChequeDrift.bancoContaCaixa?.digito,
					nome: talonarioChequeDrift.bancoContaCaixa?.nome,
					tipo: talonarioChequeDrift.bancoContaCaixa?.tipo,
					descricao: talonarioChequeDrift.bancoContaCaixa?.descricao,
				),
			);
		} else {
			return null;
		}
	}

	List<ChequeModel> chequeDriftToModel(List<ChequeGrouped>? chequeDriftList) { 
		List<ChequeModel> chequeModelList = [];
		if (chequeDriftList != null) {
			for (var chequeGrouped in chequeDriftList) {
				chequeModelList.add(
					ChequeModel(
						id: chequeGrouped.cheque?.id,
						idTalonarioCheque: chequeGrouped.cheque?.idTalonarioCheque,
						numero: chequeGrouped.cheque?.numero,
						statusCheque: ChequeDomain.getStatusCheque(chequeGrouped.cheque?.statusCheque),
						dataStatus: chequeGrouped.cheque?.dataStatus,
					)
				);
			}
			return chequeModelList;
		}
		return [];
	}


	TalonarioChequeGrouped toDrift(TalonarioChequeModel talonarioChequeModel) {
		return TalonarioChequeGrouped(
			talonarioCheque: TalonarioCheque(
				id: talonarioChequeModel.id,
				idBancoContaCaixa: talonarioChequeModel.idBancoContaCaixa,
				talao: talonarioChequeModel.talao,
				numero: talonarioChequeModel.numero,
				statusTalao: TalonarioChequeDomain.setStatusTalao(talonarioChequeModel.statusTalao),
			),
			chequeGroupedList: chequeModelToDrift(talonarioChequeModel.chequeModelList),
		);
	}

	List<ChequeGrouped> chequeModelToDrift(List<ChequeModel>? chequeModelList) { 
		List<ChequeGrouped> chequeGroupedList = [];
		if (chequeModelList != null) {
			for (var chequeModel in chequeModelList) {
				chequeGroupedList.add(
					ChequeGrouped(
						cheque: Cheque(
							id: chequeModel.id,
							idTalonarioCheque: chequeModel.idTalonarioCheque,
							numero: chequeModel.numero,
							statusCheque: ChequeDomain.setStatusCheque(chequeModel.statusCheque),
							dataStatus: chequeModel.dataStatus,
						),
					),
				);
			}
			return chequeGroupedList;
		}
		return [];
	}

		
}
