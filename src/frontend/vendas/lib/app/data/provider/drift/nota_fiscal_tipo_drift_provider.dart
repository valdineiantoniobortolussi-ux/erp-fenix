import 'package:vendas/app/data/provider/drift/database/database_imports.dart';
import 'package:vendas/app/infra/infra_imports.dart';
import 'package:vendas/app/data/provider/provider_base.dart';
import 'package:vendas/app/data/provider/drift/database/database.dart';
import 'package:vendas/app/data/model/model_imports.dart';

class NotaFiscalTipoDriftProvider extends ProviderBase {

	Future<List<NotaFiscalTipoModel>?> getList({Filter? filter}) async {
		List<NotaFiscalTipoGrouped> notaFiscalTipoDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				notaFiscalTipoDriftList = await Session.database.notaFiscalTipoDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				notaFiscalTipoDriftList = await Session.database.notaFiscalTipoDao.getGroupedList(); 
			}
			if (notaFiscalTipoDriftList.isNotEmpty) {
				return toListModel(notaFiscalTipoDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<NotaFiscalTipoModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.notaFiscalTipoDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<NotaFiscalTipoModel?>? insert(NotaFiscalTipoModel notaFiscalTipoModel) async {
		try {
			final lastPk = await Session.database.notaFiscalTipoDao.insertObject(toDrift(notaFiscalTipoModel));
			notaFiscalTipoModel.id = lastPk;
			return notaFiscalTipoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<NotaFiscalTipoModel?>? update(NotaFiscalTipoModel notaFiscalTipoModel) async {
		try {
			await Session.database.notaFiscalTipoDao.updateObject(toDrift(notaFiscalTipoModel));
			return notaFiscalTipoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.notaFiscalTipoDao.deleteObject(toDrift(NotaFiscalTipoModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<NotaFiscalTipoModel> toListModel(List<NotaFiscalTipoGrouped> notaFiscalTipoDriftList) {
		List<NotaFiscalTipoModel> listModel = [];
		for (var notaFiscalTipoDrift in notaFiscalTipoDriftList) {
			listModel.add(toModel(notaFiscalTipoDrift)!);
		}
		return listModel;
	}	

	NotaFiscalTipoModel? toModel(NotaFiscalTipoGrouped? notaFiscalTipoDrift) {
		if (notaFiscalTipoDrift != null) {
			return NotaFiscalTipoModel(
				id: notaFiscalTipoDrift.notaFiscalTipo?.id,
				idNotaFiscalModelo: notaFiscalTipoDrift.notaFiscalTipo?.idNotaFiscalModelo,
				nome: notaFiscalTipoDrift.notaFiscalTipo?.nome,
				descricao: notaFiscalTipoDrift.notaFiscalTipo?.descricao,
				serie: notaFiscalTipoDrift.notaFiscalTipo?.serie,
				serieScan: notaFiscalTipoDrift.notaFiscalTipo?.serieScan,
				ultimoNumero: notaFiscalTipoDrift.notaFiscalTipo?.ultimoNumero,
				notaFiscalModeloModel: NotaFiscalModeloModel(
					id: notaFiscalTipoDrift.notaFiscalModelo?.id,
					codigo: notaFiscalTipoDrift.notaFiscalModelo?.codigo,
					descricao: notaFiscalTipoDrift.notaFiscalModelo?.descricao,
					modelo: notaFiscalTipoDrift.notaFiscalModelo?.modelo,
				),
			);
		} else {
			return null;
		}
	}


	NotaFiscalTipoGrouped toDrift(NotaFiscalTipoModel notaFiscalTipoModel) {
		return NotaFiscalTipoGrouped(
			notaFiscalTipo: NotaFiscalTipo(
				id: notaFiscalTipoModel.id,
				idNotaFiscalModelo: notaFiscalTipoModel.idNotaFiscalModelo,
				nome: notaFiscalTipoModel.nome,
				descricao: notaFiscalTipoModel.descricao,
				serie: notaFiscalTipoModel.serie,
				serieScan: notaFiscalTipoModel.serieScan,
				ultimoNumero: notaFiscalTipoModel.ultimoNumero,
			),
		);
	}

		
}
