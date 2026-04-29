import 'package:vendas/app/data/provider/drift/database/database_imports.dart';
import 'package:vendas/app/infra/infra_imports.dart';
import 'package:vendas/app/data/provider/provider_base.dart';
import 'package:vendas/app/data/provider/drift/database/database.dart';
import 'package:vendas/app/data/model/model_imports.dart';
import 'package:vendas/app/data/domain/domain_imports.dart';

class NotaFiscalModeloDriftProvider extends ProviderBase {

	Future<List<NotaFiscalModeloModel>?> getList({Filter? filter}) async {
		List<NotaFiscalModeloGrouped> notaFiscalModeloDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				notaFiscalModeloDriftList = await Session.database.notaFiscalModeloDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				notaFiscalModeloDriftList = await Session.database.notaFiscalModeloDao.getGroupedList(); 
			}
			if (notaFiscalModeloDriftList.isNotEmpty) {
				return toListModel(notaFiscalModeloDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<NotaFiscalModeloModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.notaFiscalModeloDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<NotaFiscalModeloModel?>? insert(NotaFiscalModeloModel notaFiscalModeloModel) async {
		try {
			final lastPk = await Session.database.notaFiscalModeloDao.insertObject(toDrift(notaFiscalModeloModel));
			notaFiscalModeloModel.id = lastPk;
			return notaFiscalModeloModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<NotaFiscalModeloModel?>? update(NotaFiscalModeloModel notaFiscalModeloModel) async {
		try {
			await Session.database.notaFiscalModeloDao.updateObject(toDrift(notaFiscalModeloModel));
			return notaFiscalModeloModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.notaFiscalModeloDao.deleteObject(toDrift(NotaFiscalModeloModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<NotaFiscalModeloModel> toListModel(List<NotaFiscalModeloGrouped> notaFiscalModeloDriftList) {
		List<NotaFiscalModeloModel> listModel = [];
		for (var notaFiscalModeloDrift in notaFiscalModeloDriftList) {
			listModel.add(toModel(notaFiscalModeloDrift)!);
		}
		return listModel;
	}	

	NotaFiscalModeloModel? toModel(NotaFiscalModeloGrouped? notaFiscalModeloDrift) {
		if (notaFiscalModeloDrift != null) {
			return NotaFiscalModeloModel(
				id: notaFiscalModeloDrift.notaFiscalModelo?.id,
				codigo: NotaFiscalModeloDomain.getCodigo(notaFiscalModeloDrift.notaFiscalModelo?.codigo),
				descricao: notaFiscalModeloDrift.notaFiscalModelo?.descricao,
				modelo: notaFiscalModeloDrift.notaFiscalModelo?.modelo,
			);
		} else {
			return null;
		}
	}


	NotaFiscalModeloGrouped toDrift(NotaFiscalModeloModel notaFiscalModeloModel) {
		return NotaFiscalModeloGrouped(
			notaFiscalModelo: NotaFiscalModelo(
				id: notaFiscalModeloModel.id,
				codigo: NotaFiscalModeloDomain.setCodigo(notaFiscalModeloModel.codigo),
				descricao: notaFiscalModeloModel.descricao,
				modelo: notaFiscalModeloModel.modelo,
			),
		);
	}

		
}
