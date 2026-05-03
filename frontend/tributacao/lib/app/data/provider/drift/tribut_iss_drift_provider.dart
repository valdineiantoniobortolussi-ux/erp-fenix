import 'package:tributacao/app/data/provider/drift/database/database_imports.dart';
import 'package:tributacao/app/infra/infra_imports.dart';
import 'package:tributacao/app/data/provider/provider_base.dart';
import 'package:tributacao/app/data/provider/drift/database/database.dart';
import 'package:tributacao/app/data/model/model_imports.dart';
import 'package:tributacao/app/data/domain/domain_imports.dart';

class TributIssDriftProvider extends ProviderBase {

	Future<List<TributIssModel>?> getList({Filter? filter}) async {
		List<TributIssGrouped> tributIssDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				tributIssDriftList = await Session.database.tributIssDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				tributIssDriftList = await Session.database.tributIssDao.getGroupedList(); 
			}
			if (tributIssDriftList.isNotEmpty) {
				return toListModel(tributIssDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<TributIssModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.tributIssDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<TributIssModel?>? insert(TributIssModel tributIssModel) async {
		try {
			final lastPk = await Session.database.tributIssDao.insertObject(toDrift(tributIssModel));
			tributIssModel.id = lastPk;
			return tributIssModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<TributIssModel?>? update(TributIssModel tributIssModel) async {
		try {
			await Session.database.tributIssDao.updateObject(toDrift(tributIssModel));
			return tributIssModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.tributIssDao.deleteObject(toDrift(TributIssModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<TributIssModel> toListModel(List<TributIssGrouped> tributIssDriftList) {
		List<TributIssModel> listModel = [];
		for (var tributIssDrift in tributIssDriftList) {
			listModel.add(toModel(tributIssDrift)!);
		}
		return listModel;
	}	

	TributIssModel? toModel(TributIssGrouped? tributIssDrift) {
		if (tributIssDrift != null) {
			return TributIssModel(
				id: tributIssDrift.tributIss?.id,
				idTributOperacaoFiscal: tributIssDrift.tributIss?.idTributOperacaoFiscal,
				modalidadeBaseCalculo: TributIssDomain.getModalidadeBaseCalculo(tributIssDrift.tributIss?.modalidadeBaseCalculo),
				codigoTributacao: TributIssDomain.getCodigoTributacao(tributIssDrift.tributIss?.codigoTributacao),
				itemListaServico: tributIssDrift.tributIss?.itemListaServico,
				porcentoBaseCalculo: tributIssDrift.tributIss?.porcentoBaseCalculo,
				aliquotaPorcento: tributIssDrift.tributIss?.aliquotaPorcento,
				aliquotaUnidade: tributIssDrift.tributIss?.aliquotaUnidade,
				valorPrecoMaximo: tributIssDrift.tributIss?.valorPrecoMaximo,
				valorPautaFiscal: tributIssDrift.tributIss?.valorPautaFiscal,
				tributOperacaoFiscalModel: TributOperacaoFiscalModel(
					id: tributIssDrift.tributOperacaoFiscal?.id,
					cfop: tributIssDrift.tributOperacaoFiscal?.cfop,
					descricao: tributIssDrift.tributOperacaoFiscal?.descricao,
					descricaoNaNf: tributIssDrift.tributOperacaoFiscal?.descricaoNaNf,
					observacao: tributIssDrift.tributOperacaoFiscal?.observacao,
				),
			);
		} else {
			return null;
		}
	}


	TributIssGrouped toDrift(TributIssModel tributIssModel) {
		return TributIssGrouped(
			tributIss: TributIss(
				id: tributIssModel.id,
				idTributOperacaoFiscal: tributIssModel.idTributOperacaoFiscal,
				modalidadeBaseCalculo: TributIssDomain.setModalidadeBaseCalculo(tributIssModel.modalidadeBaseCalculo),
				codigoTributacao: TributIssDomain.setCodigoTributacao(tributIssModel.codigoTributacao),
				itemListaServico: tributIssModel.itemListaServico,
				porcentoBaseCalculo: tributIssModel.porcentoBaseCalculo,
				aliquotaPorcento: tributIssModel.aliquotaPorcento,
				aliquotaUnidade: tributIssModel.aliquotaUnidade,
				valorPrecoMaximo: tributIssModel.valorPrecoMaximo,
				valorPautaFiscal: tributIssModel.valorPautaFiscal,
			),
		);
	}

		
}
