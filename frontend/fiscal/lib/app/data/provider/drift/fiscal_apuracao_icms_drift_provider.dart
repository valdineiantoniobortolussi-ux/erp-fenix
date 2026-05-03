import 'package:fiscal/app/data/provider/drift/database/database_imports.dart';
import 'package:fiscal/app/infra/infra_imports.dart';
import 'package:fiscal/app/data/provider/provider_base.dart';
import 'package:fiscal/app/data/provider/drift/database/database.dart';
import 'package:fiscal/app/data/model/model_imports.dart';

class FiscalApuracaoIcmsDriftProvider extends ProviderBase {

	Future<List<FiscalApuracaoIcmsModel>?> getList({Filter? filter}) async {
		List<FiscalApuracaoIcmsGrouped> fiscalApuracaoIcmsDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				fiscalApuracaoIcmsDriftList = await Session.database.fiscalApuracaoIcmsDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				fiscalApuracaoIcmsDriftList = await Session.database.fiscalApuracaoIcmsDao.getGroupedList(); 
			}
			if (fiscalApuracaoIcmsDriftList.isNotEmpty) {
				return toListModel(fiscalApuracaoIcmsDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<FiscalApuracaoIcmsModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.fiscalApuracaoIcmsDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<FiscalApuracaoIcmsModel?>? insert(FiscalApuracaoIcmsModel fiscalApuracaoIcmsModel) async {
		try {
			final lastPk = await Session.database.fiscalApuracaoIcmsDao.insertObject(toDrift(fiscalApuracaoIcmsModel));
			fiscalApuracaoIcmsModel.id = lastPk;
			return fiscalApuracaoIcmsModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<FiscalApuracaoIcmsModel?>? update(FiscalApuracaoIcmsModel fiscalApuracaoIcmsModel) async {
		try {
			await Session.database.fiscalApuracaoIcmsDao.updateObject(toDrift(fiscalApuracaoIcmsModel));
			return fiscalApuracaoIcmsModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.fiscalApuracaoIcmsDao.deleteObject(toDrift(FiscalApuracaoIcmsModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<FiscalApuracaoIcmsModel> toListModel(List<FiscalApuracaoIcmsGrouped> fiscalApuracaoIcmsDriftList) {
		List<FiscalApuracaoIcmsModel> listModel = [];
		for (var fiscalApuracaoIcmsDrift in fiscalApuracaoIcmsDriftList) {
			listModel.add(toModel(fiscalApuracaoIcmsDrift)!);
		}
		return listModel;
	}	

	FiscalApuracaoIcmsModel? toModel(FiscalApuracaoIcmsGrouped? fiscalApuracaoIcmsDrift) {
		if (fiscalApuracaoIcmsDrift != null) {
			return FiscalApuracaoIcmsModel(
				id: fiscalApuracaoIcmsDrift.fiscalApuracaoIcms?.id,
				competencia: fiscalApuracaoIcmsDrift.fiscalApuracaoIcms?.competencia,
				valorTotalDebito: fiscalApuracaoIcmsDrift.fiscalApuracaoIcms?.valorTotalDebito,
				valorAjusteDebito: fiscalApuracaoIcmsDrift.fiscalApuracaoIcms?.valorAjusteDebito,
				valorTotalAjusteDebito: fiscalApuracaoIcmsDrift.fiscalApuracaoIcms?.valorTotalAjusteDebito,
				valorEstornoCredito: fiscalApuracaoIcmsDrift.fiscalApuracaoIcms?.valorEstornoCredito,
				valorTotalCredito: fiscalApuracaoIcmsDrift.fiscalApuracaoIcms?.valorTotalCredito,
				valorAjusteCredito: fiscalApuracaoIcmsDrift.fiscalApuracaoIcms?.valorAjusteCredito,
				valorTotalAjusteCredito: fiscalApuracaoIcmsDrift.fiscalApuracaoIcms?.valorTotalAjusteCredito,
				valorEstornoDebito: fiscalApuracaoIcmsDrift.fiscalApuracaoIcms?.valorEstornoDebito,
				valorSaldoCredorAnterior: fiscalApuracaoIcmsDrift.fiscalApuracaoIcms?.valorSaldoCredorAnterior,
				valorSaldoApurado: fiscalApuracaoIcmsDrift.fiscalApuracaoIcms?.valorSaldoApurado,
				valorTotalDeducao: fiscalApuracaoIcmsDrift.fiscalApuracaoIcms?.valorTotalDeducao,
				valorIcmsRecolher: fiscalApuracaoIcmsDrift.fiscalApuracaoIcms?.valorIcmsRecolher,
				valorSaldoCredorTransp: fiscalApuracaoIcmsDrift.fiscalApuracaoIcms?.valorSaldoCredorTransp,
				valorDebitoEspecial: fiscalApuracaoIcmsDrift.fiscalApuracaoIcms?.valorDebitoEspecial,
			);
		} else {
			return null;
		}
	}


	FiscalApuracaoIcmsGrouped toDrift(FiscalApuracaoIcmsModel fiscalApuracaoIcmsModel) {
		return FiscalApuracaoIcmsGrouped(
			fiscalApuracaoIcms: FiscalApuracaoIcms(
				id: fiscalApuracaoIcmsModel.id,
				competencia: Util.removeMask(fiscalApuracaoIcmsModel.competencia),
				valorTotalDebito: fiscalApuracaoIcmsModel.valorTotalDebito,
				valorAjusteDebito: fiscalApuracaoIcmsModel.valorAjusteDebito,
				valorTotalAjusteDebito: fiscalApuracaoIcmsModel.valorTotalAjusteDebito,
				valorEstornoCredito: fiscalApuracaoIcmsModel.valorEstornoCredito,
				valorTotalCredito: fiscalApuracaoIcmsModel.valorTotalCredito,
				valorAjusteCredito: fiscalApuracaoIcmsModel.valorAjusteCredito,
				valorTotalAjusteCredito: fiscalApuracaoIcmsModel.valorTotalAjusteCredito,
				valorEstornoDebito: fiscalApuracaoIcmsModel.valorEstornoDebito,
				valorSaldoCredorAnterior: fiscalApuracaoIcmsModel.valorSaldoCredorAnterior,
				valorSaldoApurado: fiscalApuracaoIcmsModel.valorSaldoApurado,
				valorTotalDeducao: fiscalApuracaoIcmsModel.valorTotalDeducao,
				valorIcmsRecolher: fiscalApuracaoIcmsModel.valorIcmsRecolher,
				valorSaldoCredorTransp: fiscalApuracaoIcmsModel.valorSaldoCredorTransp,
				valorDebitoEspecial: fiscalApuracaoIcmsModel.valorDebitoEspecial,
			),
		);
	}

		
}
