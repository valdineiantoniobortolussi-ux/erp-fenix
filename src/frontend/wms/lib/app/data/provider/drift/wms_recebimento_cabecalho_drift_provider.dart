import 'package:wms/app/data/provider/drift/database/database_imports.dart';
import 'package:wms/app/infra/infra_imports.dart';
import 'package:wms/app/data/provider/provider_base.dart';
import 'package:wms/app/data/provider/drift/database/database.dart';
import 'package:wms/app/data/model/model_imports.dart';
import 'package:wms/app/data/domain/domain_imports.dart';

class WmsRecebimentoCabecalhoDriftProvider extends ProviderBase {

	Future<List<WmsRecebimentoCabecalhoModel>?> getList({Filter? filter}) async {
		List<WmsRecebimentoCabecalhoGrouped> wmsRecebimentoCabecalhoDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				wmsRecebimentoCabecalhoDriftList = await Session.database.wmsRecebimentoCabecalhoDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				wmsRecebimentoCabecalhoDriftList = await Session.database.wmsRecebimentoCabecalhoDao.getGroupedList(); 
			}
			if (wmsRecebimentoCabecalhoDriftList.isNotEmpty) {
				return toListModel(wmsRecebimentoCabecalhoDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<WmsRecebimentoCabecalhoModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.wmsRecebimentoCabecalhoDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<WmsRecebimentoCabecalhoModel?>? insert(WmsRecebimentoCabecalhoModel wmsRecebimentoCabecalhoModel) async {
		try {
			final lastPk = await Session.database.wmsRecebimentoCabecalhoDao.insertObject(toDrift(wmsRecebimentoCabecalhoModel));
			wmsRecebimentoCabecalhoModel.id = lastPk;
			return wmsRecebimentoCabecalhoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<WmsRecebimentoCabecalhoModel?>? update(WmsRecebimentoCabecalhoModel wmsRecebimentoCabecalhoModel) async {
		try {
			await Session.database.wmsRecebimentoCabecalhoDao.updateObject(toDrift(wmsRecebimentoCabecalhoModel));
			return wmsRecebimentoCabecalhoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.wmsRecebimentoCabecalhoDao.deleteObject(toDrift(WmsRecebimentoCabecalhoModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<WmsRecebimentoCabecalhoModel> toListModel(List<WmsRecebimentoCabecalhoGrouped> wmsRecebimentoCabecalhoDriftList) {
		List<WmsRecebimentoCabecalhoModel> listModel = [];
		for (var wmsRecebimentoCabecalhoDrift in wmsRecebimentoCabecalhoDriftList) {
			listModel.add(toModel(wmsRecebimentoCabecalhoDrift)!);
		}
		return listModel;
	}	

	WmsRecebimentoCabecalhoModel? toModel(WmsRecebimentoCabecalhoGrouped? wmsRecebimentoCabecalhoDrift) {
		if (wmsRecebimentoCabecalhoDrift != null) {
			return WmsRecebimentoCabecalhoModel(
				id: wmsRecebimentoCabecalhoDrift.wmsRecebimentoCabecalho?.id,
				idWmsAgendamento: wmsRecebimentoCabecalhoDrift.wmsRecebimentoCabecalho?.idWmsAgendamento,
				dataRecebimento: wmsRecebimentoCabecalhoDrift.wmsRecebimentoCabecalho?.dataRecebimento,
				horaInicio: wmsRecebimentoCabecalhoDrift.wmsRecebimentoCabecalho?.horaInicio,
				horaFim: wmsRecebimentoCabecalhoDrift.wmsRecebimentoCabecalho?.horaFim,
				volumeRecebido: wmsRecebimentoCabecalhoDrift.wmsRecebimentoCabecalho?.volumeRecebido,
				pesoRecebido: wmsRecebimentoCabecalhoDrift.wmsRecebimentoCabecalho?.pesoRecebido,
				inconsistencia: WmsRecebimentoCabecalhoDomain.getInconsistencia(wmsRecebimentoCabecalhoDrift.wmsRecebimentoCabecalho?.inconsistencia),
				observacao: wmsRecebimentoCabecalhoDrift.wmsRecebimentoCabecalho?.observacao,
				wmsRecebimentoDetalheModelList: wmsRecebimentoDetalheDriftToModel(wmsRecebimentoCabecalhoDrift.wmsRecebimentoDetalheGroupedList),
				wmsAgendamentoModel: WmsAgendamentoModel(
					id: wmsRecebimentoCabecalhoDrift.wmsAgendamento?.id,
					dataOperacao: wmsRecebimentoCabecalhoDrift.wmsAgendamento?.dataOperacao,
					horaOperacao: wmsRecebimentoCabecalhoDrift.wmsAgendamento?.horaOperacao,
					localOperacao: wmsRecebimentoCabecalhoDrift.wmsAgendamento?.localOperacao,
					quantidadeVolume: wmsRecebimentoCabecalhoDrift.wmsAgendamento?.quantidadeVolume,
					pesoTotalVolume: wmsRecebimentoCabecalhoDrift.wmsAgendamento?.pesoTotalVolume,
					quantidadePessoa: wmsRecebimentoCabecalhoDrift.wmsAgendamento?.quantidadePessoa,
					quantidadeHora: wmsRecebimentoCabecalhoDrift.wmsAgendamento?.quantidadeHora,
				),
			);
		} else {
			return null;
		}
	}

	List<WmsRecebimentoDetalheModel> wmsRecebimentoDetalheDriftToModel(List<WmsRecebimentoDetalheGrouped>? wmsRecebimentoDetalheDriftList) { 
		List<WmsRecebimentoDetalheModel> wmsRecebimentoDetalheModelList = [];
		if (wmsRecebimentoDetalheDriftList != null) {
			for (var wmsRecebimentoDetalheGrouped in wmsRecebimentoDetalheDriftList) {
				wmsRecebimentoDetalheModelList.add(
					WmsRecebimentoDetalheModel(
						id: wmsRecebimentoDetalheGrouped.wmsRecebimentoDetalhe?.id,
						idWmsRecebimentoCabecalho: wmsRecebimentoDetalheGrouped.wmsRecebimentoDetalhe?.idWmsRecebimentoCabecalho,
						idProduto: wmsRecebimentoDetalheGrouped.wmsRecebimentoDetalhe?.idProduto,
						produtoModel: ProdutoModel(
							id: wmsRecebimentoDetalheGrouped.produto?.id,
							idTributIcmsCustomCab: wmsRecebimentoDetalheGrouped.produto?.idTributIcmsCustomCab,
							idTributGrupoTributario: wmsRecebimentoDetalheGrouped.produto?.idTributGrupoTributario,
							nome: wmsRecebimentoDetalheGrouped.produto?.nome,
							descricao: wmsRecebimentoDetalheGrouped.produto?.descricao,
							gtin: wmsRecebimentoDetalheGrouped.produto?.gtin,
							codigoInterno: wmsRecebimentoDetalheGrouped.produto?.codigoInterno,
							valorCompra: wmsRecebimentoDetalheGrouped.produto?.valorCompra,
							valorVenda: wmsRecebimentoDetalheGrouped.produto?.valorVenda,
							codigoNcm: wmsRecebimentoDetalheGrouped.produto?.codigoNcm,
							estoqueMinimo: wmsRecebimentoDetalheGrouped.produto?.estoqueMinimo,
							estoqueMaximo: wmsRecebimentoDetalheGrouped.produto?.estoqueMaximo,
							quantidadeEstoque: wmsRecebimentoDetalheGrouped.produto?.quantidadeEstoque,
							dataCadastro: wmsRecebimentoDetalheGrouped.produto?.dataCadastro,
						),
						quantidadeVolume: wmsRecebimentoDetalheGrouped.wmsRecebimentoDetalhe?.quantidadeVolume,
						quantidadeItemPorVolume: wmsRecebimentoDetalheGrouped.wmsRecebimentoDetalhe?.quantidadeItemPorVolume,
						quantidadeRecebida: wmsRecebimentoDetalheGrouped.wmsRecebimentoDetalhe?.quantidadeRecebida,
						destino: WmsRecebimentoDetalheDomain.getDestino(wmsRecebimentoDetalheGrouped.wmsRecebimentoDetalhe?.destino),
					)
				);
			}
			return wmsRecebimentoDetalheModelList;
		}
		return [];
	}


	WmsRecebimentoCabecalhoGrouped toDrift(WmsRecebimentoCabecalhoModel wmsRecebimentoCabecalhoModel) {
		return WmsRecebimentoCabecalhoGrouped(
			wmsRecebimentoCabecalho: WmsRecebimentoCabecalho(
				id: wmsRecebimentoCabecalhoModel.id,
				idWmsAgendamento: wmsRecebimentoCabecalhoModel.idWmsAgendamento,
				dataRecebimento: wmsRecebimentoCabecalhoModel.dataRecebimento,
				horaInicio: Util.removeMask(wmsRecebimentoCabecalhoModel.horaInicio),
				horaFim: Util.removeMask(wmsRecebimentoCabecalhoModel.horaFim),
				volumeRecebido: wmsRecebimentoCabecalhoModel.volumeRecebido,
				pesoRecebido: wmsRecebimentoCabecalhoModel.pesoRecebido,
				inconsistencia: WmsRecebimentoCabecalhoDomain.setInconsistencia(wmsRecebimentoCabecalhoModel.inconsistencia),
				observacao: wmsRecebimentoCabecalhoModel.observacao,
			),
			wmsRecebimentoDetalheGroupedList: wmsRecebimentoDetalheModelToDrift(wmsRecebimentoCabecalhoModel.wmsRecebimentoDetalheModelList),
		);
	}

	List<WmsRecebimentoDetalheGrouped> wmsRecebimentoDetalheModelToDrift(List<WmsRecebimentoDetalheModel>? wmsRecebimentoDetalheModelList) { 
		List<WmsRecebimentoDetalheGrouped> wmsRecebimentoDetalheGroupedList = [];
		if (wmsRecebimentoDetalheModelList != null) {
			for (var wmsRecebimentoDetalheModel in wmsRecebimentoDetalheModelList) {
				wmsRecebimentoDetalheGroupedList.add(
					WmsRecebimentoDetalheGrouped(
						wmsRecebimentoDetalhe: WmsRecebimentoDetalhe(
							id: wmsRecebimentoDetalheModel.id,
							idWmsRecebimentoCabecalho: wmsRecebimentoDetalheModel.idWmsRecebimentoCabecalho,
							idProduto: wmsRecebimentoDetalheModel.idProduto,
							quantidadeVolume: wmsRecebimentoDetalheModel.quantidadeVolume,
							quantidadeItemPorVolume: wmsRecebimentoDetalheModel.quantidadeItemPorVolume,
							quantidadeRecebida: wmsRecebimentoDetalheModel.quantidadeRecebida,
							destino: WmsRecebimentoDetalheDomain.setDestino(wmsRecebimentoDetalheModel.destino),
						),
					),
				);
			}
			return wmsRecebimentoDetalheGroupedList;
		}
		return [];
	}

		
}
