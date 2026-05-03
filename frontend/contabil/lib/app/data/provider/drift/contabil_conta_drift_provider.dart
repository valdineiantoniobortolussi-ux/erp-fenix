import 'package:contabil/app/data/provider/drift/database/database_imports.dart';
import 'package:contabil/app/infra/infra_imports.dart';
import 'package:contabil/app/data/provider/provider_base.dart';
import 'package:contabil/app/data/provider/drift/database/database.dart';
import 'package:contabil/app/data/model/model_imports.dart';
import 'package:contabil/app/data/domain/domain_imports.dart';

class ContabilContaDriftProvider extends ProviderBase {

	Future<List<ContabilContaModel>?> getList({Filter? filter}) async {
		List<ContabilContaGrouped> contabilContaDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				contabilContaDriftList = await Session.database.contabilContaDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				contabilContaDriftList = await Session.database.contabilContaDao.getGroupedList(); 
			}
			if (contabilContaDriftList.isNotEmpty) {
				return toListModel(contabilContaDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<ContabilContaModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.contabilContaDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<ContabilContaModel?>? insert(ContabilContaModel contabilContaModel) async {
		try {
			final lastPk = await Session.database.contabilContaDao.insertObject(toDrift(contabilContaModel));
			contabilContaModel.id = lastPk;
			return contabilContaModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<ContabilContaModel?>? update(ContabilContaModel contabilContaModel) async {
		try {
			await Session.database.contabilContaDao.updateObject(toDrift(contabilContaModel));
			return contabilContaModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.contabilContaDao.deleteObject(toDrift(ContabilContaModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<ContabilContaModel> toListModel(List<ContabilContaGrouped> contabilContaDriftList) {
		List<ContabilContaModel> listModel = [];
		for (var contabilContaDrift in contabilContaDriftList) {
			listModel.add(toModel(contabilContaDrift)!);
		}
		return listModel;
	}	

	ContabilContaModel? toModel(ContabilContaGrouped? contabilContaDrift) {
		if (contabilContaDrift != null) {
			return ContabilContaModel(
				id: contabilContaDrift.contabilConta?.id,
				idPlanoConta: contabilContaDrift.contabilConta?.idPlanoConta,
				idPlanoContaRefSped: contabilContaDrift.contabilConta?.idPlanoContaRefSped,
				idContabilConta: contabilContaDrift.contabilConta?.idContabilConta,
				classificacao: contabilContaDrift.contabilConta?.classificacao,
				tipo: ContabilContaDomain.getTipo(contabilContaDrift.contabilConta?.tipo),
				descricao: contabilContaDrift.contabilConta?.descricao,
				dataInclusao: contabilContaDrift.contabilConta?.dataInclusao,
				situacao: ContabilContaDomain.getSituacao(contabilContaDrift.contabilConta?.situacao),
				natureza: ContabilContaDomain.getNatureza(contabilContaDrift.contabilConta?.natureza),
				patrimonioResultado: ContabilContaDomain.getPatrimonioResultado(contabilContaDrift.contabilConta?.patrimonioResultado),
				livroCaixa: ContabilContaDomain.getLivroCaixa(contabilContaDrift.contabilConta?.livroCaixa),
				dfc: ContabilContaDomain.getDfc(contabilContaDrift.contabilConta?.dfc),
				codigoEfd: contabilContaDrift.contabilConta?.codigoEfd,
				ordem: contabilContaDrift.contabilConta?.ordem,
				codigoReduzido: contabilContaDrift.contabilConta?.codigoReduzido,
				planoContaModel: PlanoContaModel(
					id: contabilContaDrift.planoConta?.id,
					nome: contabilContaDrift.planoConta?.nome,
					dataInclusao: contabilContaDrift.planoConta?.dataInclusao,
					mascara: contabilContaDrift.planoConta?.mascara,
					niveis: contabilContaDrift.planoConta?.niveis,
				),
				planoContaRefSpedModel: PlanoContaRefSpedModel(
					id: contabilContaDrift.planoContaRefSped?.id,
					codCtaRef: contabilContaDrift.planoContaRefSped?.codCtaRef,
					inicioValidade: contabilContaDrift.planoContaRefSped?.inicioValidade,
					fimValidade: contabilContaDrift.planoContaRefSped?.fimValidade,
					tipo: contabilContaDrift.planoContaRefSped?.tipo,
					descricao: contabilContaDrift.planoContaRefSped?.descricao,
					orientacoes: contabilContaDrift.planoContaRefSped?.orientacoes,
				),
			);
		} else {
			return null;
		}
	}


	ContabilContaGrouped toDrift(ContabilContaModel contabilContaModel) {
		return ContabilContaGrouped(
			contabilConta: ContabilConta(
				id: contabilContaModel.id,
				idPlanoConta: contabilContaModel.idPlanoConta,
				idPlanoContaRefSped: contabilContaModel.idPlanoContaRefSped,
				idContabilConta: contabilContaModel.idContabilConta,
				classificacao: contabilContaModel.classificacao,
				tipo: ContabilContaDomain.setTipo(contabilContaModel.tipo),
				descricao: contabilContaModel.descricao,
				dataInclusao: contabilContaModel.dataInclusao,
				situacao: ContabilContaDomain.setSituacao(contabilContaModel.situacao),
				natureza: ContabilContaDomain.setNatureza(contabilContaModel.natureza),
				patrimonioResultado: ContabilContaDomain.setPatrimonioResultado(contabilContaModel.patrimonioResultado),
				livroCaixa: ContabilContaDomain.setLivroCaixa(contabilContaModel.livroCaixa),
				dfc: ContabilContaDomain.setDfc(contabilContaModel.dfc),
				codigoEfd: contabilContaModel.codigoEfd,
				ordem: contabilContaModel.ordem,
				codigoReduzido: contabilContaModel.codigoReduzido,
			),
		);
	}

		
}
