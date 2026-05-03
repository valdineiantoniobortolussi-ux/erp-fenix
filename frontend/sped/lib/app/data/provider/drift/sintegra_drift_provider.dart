import 'package:sped/app/data/provider/drift/database/database_imports.dart';
import 'package:sped/app/infra/infra_imports.dart';
import 'package:sped/app/data/provider/provider_base.dart';
import 'package:sped/app/data/provider/drift/database/database.dart';
import 'package:sped/app/data/model/model_imports.dart';
import 'package:sped/app/data/domain/domain_imports.dart';

class SintegraDriftProvider extends ProviderBase {

	Future<List<SintegraModel>?> getList({Filter? filter}) async {
		List<SintegraGrouped> sintegraDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				sintegraDriftList = await Session.database.sintegraDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				sintegraDriftList = await Session.database.sintegraDao.getGroupedList(); 
			}
			if (sintegraDriftList.isNotEmpty) {
				return toListModel(sintegraDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<SintegraModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.sintegraDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<SintegraModel?>? insert(SintegraModel sintegraModel) async {
		try {
			final lastPk = await Session.database.sintegraDao.insertObject(toDrift(sintegraModel));
			sintegraModel.id = lastPk;
			return sintegraModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<SintegraModel?>? update(SintegraModel sintegraModel) async {
		try {
			await Session.database.sintegraDao.updateObject(toDrift(sintegraModel));
			return sintegraModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.sintegraDao.deleteObject(toDrift(SintegraModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<SintegraModel> toListModel(List<SintegraGrouped> sintegraDriftList) {
		List<SintegraModel> listModel = [];
		for (var sintegraDrift in sintegraDriftList) {
			listModel.add(toModel(sintegraDrift)!);
		}
		return listModel;
	}	

	SintegraModel? toModel(SintegraGrouped? sintegraDrift) {
		if (sintegraDrift != null) {
			return SintegraModel(
				id: sintegraDrift.sintegra?.id,
				dataEmissao: sintegraDrift.sintegra?.dataEmissao,
				periodoInicial: sintegraDrift.sintegra?.periodoInicial,
				periodoFinal: sintegraDrift.sintegra?.periodoFinal,
				codigoConvenio: SintegraDomain.getCodigoConvenio(sintegraDrift.sintegra?.codigoConvenio),
				finalidadeArquivo: sintegraDrift.sintegra?.finalidadeArquivo,
				inventario: SintegraDomain.getInventario(sintegraDrift.sintegra?.inventario),
			);
		} else {
			return null;
		}
	}


	SintegraGrouped toDrift(SintegraModel sintegraModel) {
		return SintegraGrouped(
			sintegra: Sintegra(
				id: sintegraModel.id,
				dataEmissao: sintegraModel.dataEmissao,
				periodoInicial: sintegraModel.periodoInicial,
				periodoFinal: sintegraModel.periodoFinal,
				codigoConvenio: SintegraDomain.setCodigoConvenio(sintegraModel.codigoConvenio),
				finalidadeArquivo: sintegraModel.finalidadeArquivo,
				inventario: SintegraDomain.setInventario(sintegraModel.inventario),
			),
		);
	}

		
}
