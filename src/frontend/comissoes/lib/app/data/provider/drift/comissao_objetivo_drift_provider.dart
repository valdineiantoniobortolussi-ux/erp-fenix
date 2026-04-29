import 'package:comissoes/app/data/provider/drift/database/database_imports.dart';
import 'package:comissoes/app/infra/infra_imports.dart';
import 'package:comissoes/app/data/provider/provider_base.dart';
import 'package:comissoes/app/data/provider/drift/database/database.dart';
import 'package:comissoes/app/data/model/model_imports.dart';

class ComissaoObjetivoDriftProvider extends ProviderBase {

	Future<List<ComissaoObjetivoModel>?> getList({Filter? filter}) async {
		List<ComissaoObjetivoGrouped> comissaoObjetivoDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				comissaoObjetivoDriftList = await Session.database.comissaoObjetivoDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				comissaoObjetivoDriftList = await Session.database.comissaoObjetivoDao.getGroupedList(); 
			}
			if (comissaoObjetivoDriftList.isNotEmpty) {
				return toListModel(comissaoObjetivoDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<ComissaoObjetivoModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.comissaoObjetivoDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<ComissaoObjetivoModel?>? insert(ComissaoObjetivoModel comissaoObjetivoModel) async {
		try {
			final lastPk = await Session.database.comissaoObjetivoDao.insertObject(toDrift(comissaoObjetivoModel));
			comissaoObjetivoModel.id = lastPk;
			return comissaoObjetivoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<ComissaoObjetivoModel?>? update(ComissaoObjetivoModel comissaoObjetivoModel) async {
		try {
			await Session.database.comissaoObjetivoDao.updateObject(toDrift(comissaoObjetivoModel));
			return comissaoObjetivoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.comissaoObjetivoDao.deleteObject(toDrift(ComissaoObjetivoModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<ComissaoObjetivoModel> toListModel(List<ComissaoObjetivoGrouped> comissaoObjetivoDriftList) {
		List<ComissaoObjetivoModel> listModel = [];
		for (var comissaoObjetivoDrift in comissaoObjetivoDriftList) {
			listModel.add(toModel(comissaoObjetivoDrift)!);
		}
		return listModel;
	}	

	ComissaoObjetivoModel? toModel(ComissaoObjetivoGrouped? comissaoObjetivoDrift) {
		if (comissaoObjetivoDrift != null) {
			return ComissaoObjetivoModel(
				id: comissaoObjetivoDrift.comissaoObjetivo?.id,
				idComissaoPerfil: comissaoObjetivoDrift.comissaoObjetivo?.idComissaoPerfil,
				codigo: comissaoObjetivoDrift.comissaoObjetivo?.codigo,
				nome: comissaoObjetivoDrift.comissaoObjetivo?.nome,
				descricao: comissaoObjetivoDrift.comissaoObjetivo?.descricao,
				taxaPagamento: comissaoObjetivoDrift.comissaoObjetivo?.taxaPagamento,
				valorPagamento: comissaoObjetivoDrift.comissaoObjetivo?.valorPagamento,
				valorMeta: comissaoObjetivoDrift.comissaoObjetivo?.valorMeta,
				dataInicio: comissaoObjetivoDrift.comissaoObjetivo?.dataInicio,
				dataFim: comissaoObjetivoDrift.comissaoObjetivo?.dataFim,
				comissaoPerfilModel: ComissaoPerfilModel(
					id: comissaoObjetivoDrift.comissaoPerfil?.id,
					codigo: comissaoObjetivoDrift.comissaoPerfil?.codigo,
					nome: comissaoObjetivoDrift.comissaoPerfil?.nome,
				),
			);
		} else {
			return null;
		}
	}


	ComissaoObjetivoGrouped toDrift(ComissaoObjetivoModel comissaoObjetivoModel) {
		return ComissaoObjetivoGrouped(
			comissaoObjetivo: ComissaoObjetivo(
				id: comissaoObjetivoModel.id,
				idComissaoPerfil: comissaoObjetivoModel.idComissaoPerfil,
				codigo: comissaoObjetivoModel.codigo,
				nome: comissaoObjetivoModel.nome,
				descricao: comissaoObjetivoModel.descricao,
				taxaPagamento: comissaoObjetivoModel.taxaPagamento,
				valorPagamento: comissaoObjetivoModel.valorPagamento,
				valorMeta: comissaoObjetivoModel.valorMeta,
				dataInicio: comissaoObjetivoModel.dataInicio,
				dataFim: comissaoObjetivoModel.dataFim,
			),
		);
	}

		
}
