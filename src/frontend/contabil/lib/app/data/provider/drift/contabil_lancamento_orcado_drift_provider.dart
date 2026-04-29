import 'package:contabil/app/data/provider/drift/database/database_imports.dart';
import 'package:contabil/app/infra/infra_imports.dart';
import 'package:contabil/app/data/provider/provider_base.dart';
import 'package:contabil/app/data/provider/drift/database/database.dart';
import 'package:contabil/app/data/model/model_imports.dart';

class ContabilLancamentoOrcadoDriftProvider extends ProviderBase {

	Future<List<ContabilLancamentoOrcadoModel>?> getList({Filter? filter}) async {
		List<ContabilLancamentoOrcadoGrouped> contabilLancamentoOrcadoDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				contabilLancamentoOrcadoDriftList = await Session.database.contabilLancamentoOrcadoDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				contabilLancamentoOrcadoDriftList = await Session.database.contabilLancamentoOrcadoDao.getGroupedList(); 
			}
			if (contabilLancamentoOrcadoDriftList.isNotEmpty) {
				return toListModel(contabilLancamentoOrcadoDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<ContabilLancamentoOrcadoModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.contabilLancamentoOrcadoDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<ContabilLancamentoOrcadoModel?>? insert(ContabilLancamentoOrcadoModel contabilLancamentoOrcadoModel) async {
		try {
			final lastPk = await Session.database.contabilLancamentoOrcadoDao.insertObject(toDrift(contabilLancamentoOrcadoModel));
			contabilLancamentoOrcadoModel.id = lastPk;
			return contabilLancamentoOrcadoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<ContabilLancamentoOrcadoModel?>? update(ContabilLancamentoOrcadoModel contabilLancamentoOrcadoModel) async {
		try {
			await Session.database.contabilLancamentoOrcadoDao.updateObject(toDrift(contabilLancamentoOrcadoModel));
			return contabilLancamentoOrcadoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.contabilLancamentoOrcadoDao.deleteObject(toDrift(ContabilLancamentoOrcadoModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<ContabilLancamentoOrcadoModel> toListModel(List<ContabilLancamentoOrcadoGrouped> contabilLancamentoOrcadoDriftList) {
		List<ContabilLancamentoOrcadoModel> listModel = [];
		for (var contabilLancamentoOrcadoDrift in contabilLancamentoOrcadoDriftList) {
			listModel.add(toModel(contabilLancamentoOrcadoDrift)!);
		}
		return listModel;
	}	

	ContabilLancamentoOrcadoModel? toModel(ContabilLancamentoOrcadoGrouped? contabilLancamentoOrcadoDrift) {
		if (contabilLancamentoOrcadoDrift != null) {
			return ContabilLancamentoOrcadoModel(
				id: contabilLancamentoOrcadoDrift.contabilLancamentoOrcado?.id,
				idContabilConta: contabilLancamentoOrcadoDrift.contabilLancamentoOrcado?.idContabilConta,
				ano: contabilLancamentoOrcadoDrift.contabilLancamentoOrcado?.ano,
				janeiro: contabilLancamentoOrcadoDrift.contabilLancamentoOrcado?.janeiro,
				fevereiro: contabilLancamentoOrcadoDrift.contabilLancamentoOrcado?.fevereiro,
				marco: contabilLancamentoOrcadoDrift.contabilLancamentoOrcado?.marco,
				abril: contabilLancamentoOrcadoDrift.contabilLancamentoOrcado?.abril,
				maio: contabilLancamentoOrcadoDrift.contabilLancamentoOrcado?.maio,
				junho: contabilLancamentoOrcadoDrift.contabilLancamentoOrcado?.junho,
				julho: contabilLancamentoOrcadoDrift.contabilLancamentoOrcado?.julho,
				agosto: contabilLancamentoOrcadoDrift.contabilLancamentoOrcado?.agosto,
				setembro: contabilLancamentoOrcadoDrift.contabilLancamentoOrcado?.setembro,
				outubro: contabilLancamentoOrcadoDrift.contabilLancamentoOrcado?.outubro,
				novembro: contabilLancamentoOrcadoDrift.contabilLancamentoOrcado?.novembro,
				dezembro: contabilLancamentoOrcadoDrift.contabilLancamentoOrcado?.dezembro,
				contabilContaModel: ContabilContaModel(
					id: contabilLancamentoOrcadoDrift.contabilConta?.id,
					idPlanoConta: contabilLancamentoOrcadoDrift.contabilConta?.idPlanoConta,
					idPlanoContaRefSped: contabilLancamentoOrcadoDrift.contabilConta?.idPlanoContaRefSped,
					idContabilConta: contabilLancamentoOrcadoDrift.contabilConta?.idContabilConta,
					classificacao: contabilLancamentoOrcadoDrift.contabilConta?.classificacao,
					tipo: contabilLancamentoOrcadoDrift.contabilConta?.tipo,
					descricao: contabilLancamentoOrcadoDrift.contabilConta?.descricao,
					dataInclusao: contabilLancamentoOrcadoDrift.contabilConta?.dataInclusao,
					situacao: contabilLancamentoOrcadoDrift.contabilConta?.situacao,
					natureza: contabilLancamentoOrcadoDrift.contabilConta?.natureza,
					patrimonioResultado: contabilLancamentoOrcadoDrift.contabilConta?.patrimonioResultado,
					livroCaixa: contabilLancamentoOrcadoDrift.contabilConta?.livroCaixa,
					dfc: contabilLancamentoOrcadoDrift.contabilConta?.dfc,
					codigoEfd: contabilLancamentoOrcadoDrift.contabilConta?.codigoEfd,
					ordem: contabilLancamentoOrcadoDrift.contabilConta?.ordem,
					codigoReduzido: contabilLancamentoOrcadoDrift.contabilConta?.codigoReduzido,
				),
			);
		} else {
			return null;
		}
	}


	ContabilLancamentoOrcadoGrouped toDrift(ContabilLancamentoOrcadoModel contabilLancamentoOrcadoModel) {
		return ContabilLancamentoOrcadoGrouped(
			contabilLancamentoOrcado: ContabilLancamentoOrcado(
				id: contabilLancamentoOrcadoModel.id,
				idContabilConta: contabilLancamentoOrcadoModel.idContabilConta,
				ano: contabilLancamentoOrcadoModel.ano,
				janeiro: contabilLancamentoOrcadoModel.janeiro,
				fevereiro: contabilLancamentoOrcadoModel.fevereiro,
				marco: contabilLancamentoOrcadoModel.marco,
				abril: contabilLancamentoOrcadoModel.abril,
				maio: contabilLancamentoOrcadoModel.maio,
				junho: contabilLancamentoOrcadoModel.junho,
				julho: contabilLancamentoOrcadoModel.julho,
				agosto: contabilLancamentoOrcadoModel.agosto,
				setembro: contabilLancamentoOrcadoModel.setembro,
				outubro: contabilLancamentoOrcadoModel.outubro,
				novembro: contabilLancamentoOrcadoModel.novembro,
				dezembro: contabilLancamentoOrcadoModel.dezembro,
			),
		);
	}

		
}
