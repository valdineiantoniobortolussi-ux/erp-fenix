import 'package:mdfe/app/data/provider/drift/database/database_imports.dart';
import 'package:mdfe/app/infra/infra_imports.dart';
import 'package:mdfe/app/data/provider/provider_base.dart';
import 'package:mdfe/app/data/provider/drift/database/database.dart';
import 'package:mdfe/app/data/model/model_imports.dart';

class MdfeInformacaoCteDriftProvider extends ProviderBase {

	Future<List<MdfeInformacaoCteModel>?> getList({Filter? filter}) async {
		List<MdfeInformacaoCteGrouped> mdfeInformacaoCteDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				mdfeInformacaoCteDriftList = await Session.database.mdfeInformacaoCteDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				mdfeInformacaoCteDriftList = await Session.database.mdfeInformacaoCteDao.getGroupedList(); 
			}
			if (mdfeInformacaoCteDriftList.isNotEmpty) {
				return toListModel(mdfeInformacaoCteDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<MdfeInformacaoCteModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.mdfeInformacaoCteDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<MdfeInformacaoCteModel?>? insert(MdfeInformacaoCteModel mdfeInformacaoCteModel) async {
		try {
			final lastPk = await Session.database.mdfeInformacaoCteDao.insertObject(toDrift(mdfeInformacaoCteModel));
			mdfeInformacaoCteModel.id = lastPk;
			return mdfeInformacaoCteModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<MdfeInformacaoCteModel?>? update(MdfeInformacaoCteModel mdfeInformacaoCteModel) async {
		try {
			await Session.database.mdfeInformacaoCteDao.updateObject(toDrift(mdfeInformacaoCteModel));
			return mdfeInformacaoCteModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.mdfeInformacaoCteDao.deleteObject(toDrift(MdfeInformacaoCteModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<MdfeInformacaoCteModel> toListModel(List<MdfeInformacaoCteGrouped> mdfeInformacaoCteDriftList) {
		List<MdfeInformacaoCteModel> listModel = [];
		for (var mdfeInformacaoCteDrift in mdfeInformacaoCteDriftList) {
			listModel.add(toModel(mdfeInformacaoCteDrift)!);
		}
		return listModel;
	}	

	MdfeInformacaoCteModel? toModel(MdfeInformacaoCteGrouped? mdfeInformacaoCteDrift) {
		if (mdfeInformacaoCteDrift != null) {
			return MdfeInformacaoCteModel(
				id: mdfeInformacaoCteDrift.mdfeInformacaoCte?.id,
				idMdfeMunicipioDescarrega: mdfeInformacaoCteDrift.mdfeInformacaoCte?.idMdfeMunicipioDescarrega,
				chaveCte: mdfeInformacaoCteDrift.mdfeInformacaoCte?.chaveCte,
				segundoCodigoBarra: mdfeInformacaoCteDrift.mdfeInformacaoCte?.segundoCodigoBarra,
				indicadorReentrega: mdfeInformacaoCteDrift.mdfeInformacaoCte?.indicadorReentrega,
				mdfeMunicipioDescarregaModel: MdfeMunicipioDescarregaModel(
					id: mdfeInformacaoCteDrift.mdfeMunicipioDescarrega?.id,
					idMdfeCabecalho: mdfeInformacaoCteDrift.mdfeMunicipioDescarrega?.idMdfeCabecalho,
					codigoMunicipio: mdfeInformacaoCteDrift.mdfeMunicipioDescarrega?.codigoMunicipio,
					nomeMunicipio: mdfeInformacaoCteDrift.mdfeMunicipioDescarrega?.nomeMunicipio,
				),
			);
		} else {
			return null;
		}
	}


	MdfeInformacaoCteGrouped toDrift(MdfeInformacaoCteModel mdfeInformacaoCteModel) {
		return MdfeInformacaoCteGrouped(
			mdfeInformacaoCte: MdfeInformacaoCte(
				id: mdfeInformacaoCteModel.id,
				idMdfeMunicipioDescarrega: mdfeInformacaoCteModel.idMdfeMunicipioDescarrega,
				chaveCte: mdfeInformacaoCteModel.chaveCte,
				segundoCodigoBarra: mdfeInformacaoCteModel.segundoCodigoBarra,
				indicadorReentrega: mdfeInformacaoCteModel.indicadorReentrega,
			),
		);
	}

		
}
