import 'package:folha/app/data/provider/drift/database/database_imports.dart';
import 'package:folha/app/infra/infra_imports.dart';
import 'package:folha/app/data/provider/provider_base.dart';
import 'package:folha/app/data/provider/drift/database/database.dart';
import 'package:folha/app/data/model/model_imports.dart';
import 'package:folha/app/data/domain/domain_imports.dart';

class FolhaEventoDriftProvider extends ProviderBase {

	Future<List<FolhaEventoModel>?> getList({Filter? filter}) async {
		List<FolhaEventoGrouped> folhaEventoDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				folhaEventoDriftList = await Session.database.folhaEventoDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				folhaEventoDriftList = await Session.database.folhaEventoDao.getGroupedList(); 
			}
			if (folhaEventoDriftList.isNotEmpty) {
				return toListModel(folhaEventoDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<FolhaEventoModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.folhaEventoDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<FolhaEventoModel?>? insert(FolhaEventoModel folhaEventoModel) async {
		try {
			final lastPk = await Session.database.folhaEventoDao.insertObject(toDrift(folhaEventoModel));
			folhaEventoModel.id = lastPk;
			return folhaEventoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<FolhaEventoModel?>? update(FolhaEventoModel folhaEventoModel) async {
		try {
			await Session.database.folhaEventoDao.updateObject(toDrift(folhaEventoModel));
			return folhaEventoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.folhaEventoDao.deleteObject(toDrift(FolhaEventoModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<FolhaEventoModel> toListModel(List<FolhaEventoGrouped> folhaEventoDriftList) {
		List<FolhaEventoModel> listModel = [];
		for (var folhaEventoDrift in folhaEventoDriftList) {
			listModel.add(toModel(folhaEventoDrift)!);
		}
		return listModel;
	}	

	FolhaEventoModel? toModel(FolhaEventoGrouped? folhaEventoDrift) {
		if (folhaEventoDrift != null) {
			return FolhaEventoModel(
				id: folhaEventoDrift.folhaEvento?.id,
				codigo: folhaEventoDrift.folhaEvento?.codigo,
				nome: folhaEventoDrift.folhaEvento?.nome,
				descricao: folhaEventoDrift.folhaEvento?.descricao,
				baseCalculo: FolhaEventoDomain.getBaseCalculo(folhaEventoDrift.folhaEvento?.baseCalculo),
				tipo: FolhaEventoDomain.getTipo(folhaEventoDrift.folhaEvento?.tipo),
				unidade: FolhaEventoDomain.getUnidade(folhaEventoDrift.folhaEvento?.unidade),
				taxa: folhaEventoDrift.folhaEvento?.taxa,
				rubricaEsocial: folhaEventoDrift.folhaEvento?.rubricaEsocial,
				codIncidenciaPrevidencia: folhaEventoDrift.folhaEvento?.codIncidenciaPrevidencia,
				codIncidenciaIrrf: folhaEventoDrift.folhaEvento?.codIncidenciaIrrf,
				codIncidenciaFgts: folhaEventoDrift.folhaEvento?.codIncidenciaFgts,
				codIncidenciaSindicato: folhaEventoDrift.folhaEvento?.codIncidenciaSindicato,
				repercuteDsr: FolhaEventoDomain.getRepercuteDsr(folhaEventoDrift.folhaEvento?.repercuteDsr),
				repercute13: FolhaEventoDomain.getRepercute13(folhaEventoDrift.folhaEvento?.repercute13),
				repercuteFerias: FolhaEventoDomain.getRepercuteFerias(folhaEventoDrift.folhaEvento?.repercuteFerias),
				repercuteAviso: FolhaEventoDomain.getRepercuteAviso(folhaEventoDrift.folhaEvento?.repercuteAviso),
			);
		} else {
			return null;
		}
	}


	FolhaEventoGrouped toDrift(FolhaEventoModel folhaEventoModel) {
		return FolhaEventoGrouped(
			folhaEvento: FolhaEvento(
				id: folhaEventoModel.id,
				codigo: folhaEventoModel.codigo,
				nome: folhaEventoModel.nome,
				descricao: folhaEventoModel.descricao,
				baseCalculo: FolhaEventoDomain.setBaseCalculo(folhaEventoModel.baseCalculo),
				tipo: FolhaEventoDomain.setTipo(folhaEventoModel.tipo),
				unidade: FolhaEventoDomain.setUnidade(folhaEventoModel.unidade),
				taxa: folhaEventoModel.taxa,
				rubricaEsocial: folhaEventoModel.rubricaEsocial,
				codIncidenciaPrevidencia: folhaEventoModel.codIncidenciaPrevidencia,
				codIncidenciaIrrf: folhaEventoModel.codIncidenciaIrrf,
				codIncidenciaFgts: folhaEventoModel.codIncidenciaFgts,
				codIncidenciaSindicato: folhaEventoModel.codIncidenciaSindicato,
				repercuteDsr: FolhaEventoDomain.setRepercuteDsr(folhaEventoModel.repercuteDsr),
				repercute13: FolhaEventoDomain.setRepercute13(folhaEventoModel.repercute13),
				repercuteFerias: FolhaEventoDomain.setRepercuteFerias(folhaEventoModel.repercuteFerias),
				repercuteAviso: FolhaEventoDomain.setRepercuteAviso(folhaEventoModel.repercuteAviso),
			),
		);
	}

		
}
