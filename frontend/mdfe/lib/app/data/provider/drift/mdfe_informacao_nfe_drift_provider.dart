import 'package:mdfe/app/data/provider/drift/database/database_imports.dart';
import 'package:mdfe/app/infra/infra_imports.dart';
import 'package:mdfe/app/data/provider/provider_base.dart';
import 'package:mdfe/app/data/provider/drift/database/database.dart';
import 'package:mdfe/app/data/model/model_imports.dart';

class MdfeInformacaoNfeDriftProvider extends ProviderBase {

	Future<List<MdfeInformacaoNfeModel>?> getList({Filter? filter}) async {
		List<MdfeInformacaoNfeGrouped> mdfeInformacaoNfeDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				mdfeInformacaoNfeDriftList = await Session.database.mdfeInformacaoNfeDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				mdfeInformacaoNfeDriftList = await Session.database.mdfeInformacaoNfeDao.getGroupedList(); 
			}
			if (mdfeInformacaoNfeDriftList.isNotEmpty) {
				return toListModel(mdfeInformacaoNfeDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<MdfeInformacaoNfeModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.mdfeInformacaoNfeDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<MdfeInformacaoNfeModel?>? insert(MdfeInformacaoNfeModel mdfeInformacaoNfeModel) async {
		try {
			final lastPk = await Session.database.mdfeInformacaoNfeDao.insertObject(toDrift(mdfeInformacaoNfeModel));
			mdfeInformacaoNfeModel.id = lastPk;
			return mdfeInformacaoNfeModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<MdfeInformacaoNfeModel?>? update(MdfeInformacaoNfeModel mdfeInformacaoNfeModel) async {
		try {
			await Session.database.mdfeInformacaoNfeDao.updateObject(toDrift(mdfeInformacaoNfeModel));
			return mdfeInformacaoNfeModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.mdfeInformacaoNfeDao.deleteObject(toDrift(MdfeInformacaoNfeModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<MdfeInformacaoNfeModel> toListModel(List<MdfeInformacaoNfeGrouped> mdfeInformacaoNfeDriftList) {
		List<MdfeInformacaoNfeModel> listModel = [];
		for (var mdfeInformacaoNfeDrift in mdfeInformacaoNfeDriftList) {
			listModel.add(toModel(mdfeInformacaoNfeDrift)!);
		}
		return listModel;
	}	

	MdfeInformacaoNfeModel? toModel(MdfeInformacaoNfeGrouped? mdfeInformacaoNfeDrift) {
		if (mdfeInformacaoNfeDrift != null) {
			return MdfeInformacaoNfeModel(
				id: mdfeInformacaoNfeDrift.mdfeInformacaoNfe?.id,
				idMdfeMunicipioDescarrega: mdfeInformacaoNfeDrift.mdfeInformacaoNfe?.idMdfeMunicipioDescarrega,
				chaveNfe: mdfeInformacaoNfeDrift.mdfeInformacaoNfe?.chaveNfe,
				segundoCodigoBarra: mdfeInformacaoNfeDrift.mdfeInformacaoNfe?.segundoCodigoBarra,
				indicadorReentrega: mdfeInformacaoNfeDrift.mdfeInformacaoNfe?.indicadorReentrega,
				mdfeMunicipioDescarregaModel: MdfeMunicipioDescarregaModel(
					id: mdfeInformacaoNfeDrift.mdfeMunicipioDescarrega?.id,
					idMdfeCabecalho: mdfeInformacaoNfeDrift.mdfeMunicipioDescarrega?.idMdfeCabecalho,
					codigoMunicipio: mdfeInformacaoNfeDrift.mdfeMunicipioDescarrega?.codigoMunicipio,
					nomeMunicipio: mdfeInformacaoNfeDrift.mdfeMunicipioDescarrega?.nomeMunicipio,
				),
			);
		} else {
			return null;
		}
	}


	MdfeInformacaoNfeGrouped toDrift(MdfeInformacaoNfeModel mdfeInformacaoNfeModel) {
		return MdfeInformacaoNfeGrouped(
			mdfeInformacaoNfe: MdfeInformacaoNfe(
				id: mdfeInformacaoNfeModel.id,
				idMdfeMunicipioDescarrega: mdfeInformacaoNfeModel.idMdfeMunicipioDescarrega,
				chaveNfe: mdfeInformacaoNfeModel.chaveNfe,
				segundoCodigoBarra: mdfeInformacaoNfeModel.segundoCodigoBarra,
				indicadorReentrega: mdfeInformacaoNfeModel.indicadorReentrega,
			),
		);
	}

		
}
