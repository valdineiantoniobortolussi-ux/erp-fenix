import 'package:etiquetas/app/data/provider/drift/database/database_imports.dart';
import 'package:etiquetas/app/infra/infra_imports.dart';
import 'package:etiquetas/app/data/provider/provider_base.dart';
import 'package:etiquetas/app/data/provider/drift/database/database.dart';
import 'package:etiquetas/app/data/model/model_imports.dart';
import 'package:etiquetas/app/data/domain/domain_imports.dart';

class EtiquetaLayoutDriftProvider extends ProviderBase {

	Future<List<EtiquetaLayoutModel>?> getList({Filter? filter}) async {
		List<EtiquetaLayoutGrouped> etiquetaLayoutDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				etiquetaLayoutDriftList = await Session.database.etiquetaLayoutDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				etiquetaLayoutDriftList = await Session.database.etiquetaLayoutDao.getGroupedList(); 
			}
			if (etiquetaLayoutDriftList.isNotEmpty) {
				return toListModel(etiquetaLayoutDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<EtiquetaLayoutModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.etiquetaLayoutDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<EtiquetaLayoutModel?>? insert(EtiquetaLayoutModel etiquetaLayoutModel) async {
		try {
			final lastPk = await Session.database.etiquetaLayoutDao.insertObject(toDrift(etiquetaLayoutModel));
			etiquetaLayoutModel.id = lastPk;
			return etiquetaLayoutModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<EtiquetaLayoutModel?>? update(EtiquetaLayoutModel etiquetaLayoutModel) async {
		try {
			await Session.database.etiquetaLayoutDao.updateObject(toDrift(etiquetaLayoutModel));
			return etiquetaLayoutModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.etiquetaLayoutDao.deleteObject(toDrift(EtiquetaLayoutModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<EtiquetaLayoutModel> toListModel(List<EtiquetaLayoutGrouped> etiquetaLayoutDriftList) {
		List<EtiquetaLayoutModel> listModel = [];
		for (var etiquetaLayoutDrift in etiquetaLayoutDriftList) {
			listModel.add(toModel(etiquetaLayoutDrift)!);
		}
		return listModel;
	}	

	EtiquetaLayoutModel? toModel(EtiquetaLayoutGrouped? etiquetaLayoutDrift) {
		if (etiquetaLayoutDrift != null) {
			return EtiquetaLayoutModel(
				id: etiquetaLayoutDrift.etiquetaLayout?.id,
				idFormatoPapel: etiquetaLayoutDrift.etiquetaLayout?.idFormatoPapel,
				codigoFabricante: etiquetaLayoutDrift.etiquetaLayout?.codigoFabricante,
				quantidade: etiquetaLayoutDrift.etiquetaLayout?.quantidade,
				quantidadeHorizontal: etiquetaLayoutDrift.etiquetaLayout?.quantidadeHorizontal,
				quantidadeVertical: etiquetaLayoutDrift.etiquetaLayout?.quantidadeVertical,
				margemSuperior: etiquetaLayoutDrift.etiquetaLayout?.margemSuperior,
				margemInferior: etiquetaLayoutDrift.etiquetaLayout?.margemInferior,
				margemEsquerda: etiquetaLayoutDrift.etiquetaLayout?.margemEsquerda,
				margemDireita: etiquetaLayoutDrift.etiquetaLayout?.margemDireita,
				espacamentoHorizontal: etiquetaLayoutDrift.etiquetaLayout?.espacamentoHorizontal,
				espacamentoVertical: etiquetaLayoutDrift.etiquetaLayout?.espacamentoVertical,
				etiquetaTemplateModelList: etiquetaTemplateDriftToModel(etiquetaLayoutDrift.etiquetaTemplateGroupedList),
				etiquetaFormatoPapelModel: EtiquetaFormatoPapelModel(
					id: etiquetaLayoutDrift.etiquetaFormatoPapel?.id,
					nome: etiquetaLayoutDrift.etiquetaFormatoPapel?.nome,
					altura: etiquetaLayoutDrift.etiquetaFormatoPapel?.altura,
					largura: etiquetaLayoutDrift.etiquetaFormatoPapel?.largura,
				),
			);
		} else {
			return null;
		}
	}

	List<EtiquetaTemplateModel> etiquetaTemplateDriftToModel(List<EtiquetaTemplateGrouped>? etiquetaTemplateDriftList) { 
		List<EtiquetaTemplateModel> etiquetaTemplateModelList = [];
		if (etiquetaTemplateDriftList != null) {
			for (var etiquetaTemplateGrouped in etiquetaTemplateDriftList) {
				etiquetaTemplateModelList.add(
					EtiquetaTemplateModel(
						id: etiquetaTemplateGrouped.etiquetaTemplate?.id,
						idEtiquetaLayout: etiquetaTemplateGrouped.etiquetaTemplate?.idEtiquetaLayout,
						tabela: etiquetaTemplateGrouped.etiquetaTemplate?.tabela,
						campo: etiquetaTemplateGrouped.etiquetaTemplate?.campo,
						formato: EtiquetaTemplateDomain.getFormato(etiquetaTemplateGrouped.etiquetaTemplate?.formato),
						quantidadeRepeticoes: etiquetaTemplateGrouped.etiquetaTemplate?.quantidadeRepeticoes,
						filtro: etiquetaTemplateGrouped.etiquetaTemplate?.filtro,
					)
				);
			}
			return etiquetaTemplateModelList;
		}
		return [];
	}


	EtiquetaLayoutGrouped toDrift(EtiquetaLayoutModel etiquetaLayoutModel) {
		return EtiquetaLayoutGrouped(
			etiquetaLayout: EtiquetaLayout(
				id: etiquetaLayoutModel.id,
				idFormatoPapel: etiquetaLayoutModel.idFormatoPapel,
				codigoFabricante: etiquetaLayoutModel.codigoFabricante,
				quantidade: etiquetaLayoutModel.quantidade,
				quantidadeHorizontal: etiquetaLayoutModel.quantidadeHorizontal,
				quantidadeVertical: etiquetaLayoutModel.quantidadeVertical,
				margemSuperior: etiquetaLayoutModel.margemSuperior,
				margemInferior: etiquetaLayoutModel.margemInferior,
				margemEsquerda: etiquetaLayoutModel.margemEsquerda,
				margemDireita: etiquetaLayoutModel.margemDireita,
				espacamentoHorizontal: etiquetaLayoutModel.espacamentoHorizontal,
				espacamentoVertical: etiquetaLayoutModel.espacamentoVertical,
			),
			etiquetaTemplateGroupedList: etiquetaTemplateModelToDrift(etiquetaLayoutModel.etiquetaTemplateModelList),
		);
	}

	List<EtiquetaTemplateGrouped> etiquetaTemplateModelToDrift(List<EtiquetaTemplateModel>? etiquetaTemplateModelList) { 
		List<EtiquetaTemplateGrouped> etiquetaTemplateGroupedList = [];
		if (etiquetaTemplateModelList != null) {
			for (var etiquetaTemplateModel in etiquetaTemplateModelList) {
				etiquetaTemplateGroupedList.add(
					EtiquetaTemplateGrouped(
						etiquetaTemplate: EtiquetaTemplate(
							id: etiquetaTemplateModel.id,
							idEtiquetaLayout: etiquetaTemplateModel.idEtiquetaLayout,
							tabela: etiquetaTemplateModel.tabela,
							campo: etiquetaTemplateModel.campo,
							formato: EtiquetaTemplateDomain.setFormato(etiquetaTemplateModel.formato),
							quantidadeRepeticoes: etiquetaTemplateModel.quantidadeRepeticoes,
							filtro: etiquetaTemplateModel.filtro,
						),
					),
				);
			}
			return etiquetaTemplateGroupedList;
		}
		return [];
	}

		
}
