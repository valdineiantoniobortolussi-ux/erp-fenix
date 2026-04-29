import 'package:nfe/app/data/provider/drift/database/database_imports.dart';
import 'package:nfe/app/infra/infra_imports.dart';
import 'package:nfe/app/data/provider/provider_base.dart';
import 'package:nfe/app/data/provider/drift/database/database.dart';
import 'package:nfe/app/data/model/model_imports.dart';
import 'package:nfe/app/data/domain/domain_imports.dart';

class VendaCabecalhoDriftProvider extends ProviderBase {

	Future<List<VendaCabecalhoModel>?> getList({Filter? filter}) async {
		List<VendaCabecalhoGrouped> vendaCabecalhoDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				vendaCabecalhoDriftList = await Session.database.vendaCabecalhoDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				vendaCabecalhoDriftList = await Session.database.vendaCabecalhoDao.getGroupedList(); 
			}
			if (vendaCabecalhoDriftList.isNotEmpty) {
				return toListModel(vendaCabecalhoDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<VendaCabecalhoModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.vendaCabecalhoDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<VendaCabecalhoModel?>? insert(VendaCabecalhoModel vendaCabecalhoModel) async {
		try {
			final lastPk = await Session.database.vendaCabecalhoDao.insertObject(toDrift(vendaCabecalhoModel));
			vendaCabecalhoModel.id = lastPk;
			return vendaCabecalhoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<VendaCabecalhoModel?>? update(VendaCabecalhoModel vendaCabecalhoModel) async {
		try {
			await Session.database.vendaCabecalhoDao.updateObject(toDrift(vendaCabecalhoModel));
			return vendaCabecalhoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.vendaCabecalhoDao.deleteObject(toDrift(VendaCabecalhoModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<VendaCabecalhoModel> toListModel(List<VendaCabecalhoGrouped> vendaCabecalhoDriftList) {
		List<VendaCabecalhoModel> listModel = [];
		for (var vendaCabecalhoDrift in vendaCabecalhoDriftList) {
			listModel.add(toModel(vendaCabecalhoDrift)!);
		}
		return listModel;
	}	

	VendaCabecalhoModel? toModel(VendaCabecalhoGrouped? vendaCabecalhoDrift) {
		if (vendaCabecalhoDrift != null) {
			return VendaCabecalhoModel(
				id: vendaCabecalhoDrift.vendaCabecalho?.id,
				idVendaOrcamentoCabecalho: vendaCabecalhoDrift.vendaCabecalho?.idVendaOrcamentoCabecalho,
				idVendaCondicoesPagamento: vendaCabecalhoDrift.vendaCabecalho?.idVendaCondicoesPagamento,
				idNotaFiscalTipo: vendaCabecalhoDrift.vendaCabecalho?.idNotaFiscalTipo,
				idTransportadora: vendaCabecalhoDrift.vendaCabecalho?.idTransportadora,
				dataVenda: vendaCabecalhoDrift.vendaCabecalho?.dataVenda,
				dataSaida: vendaCabecalhoDrift.vendaCabecalho?.dataSaida,
				horaSaida: vendaCabecalhoDrift.vendaCabecalho?.horaSaida,
				numeroFatura: vendaCabecalhoDrift.vendaCabecalho?.numeroFatura,
				localEntrega: vendaCabecalhoDrift.vendaCabecalho?.localEntrega,
				localCobranca: vendaCabecalhoDrift.vendaCabecalho?.localCobranca,
				valorSubtotal: vendaCabecalhoDrift.vendaCabecalho?.valorSubtotal,
				taxaComissao: vendaCabecalhoDrift.vendaCabecalho?.taxaComissao,
				valorComissao: vendaCabecalhoDrift.vendaCabecalho?.valorComissao,
				taxaDesconto: vendaCabecalhoDrift.vendaCabecalho?.taxaDesconto,
				valorDesconto: vendaCabecalhoDrift.vendaCabecalho?.valorDesconto,
				valorTotal: vendaCabecalhoDrift.vendaCabecalho?.valorTotal,
				tipoFrete: VendaCabecalhoDomain.getTipoFrete(vendaCabecalhoDrift.vendaCabecalho?.tipoFrete),
				formaPagamento: VendaCabecalhoDomain.getFormaPagamento(vendaCabecalhoDrift.vendaCabecalho?.formaPagamento),
				valorFrete: vendaCabecalhoDrift.vendaCabecalho?.valorFrete,
				valorSeguro: vendaCabecalhoDrift.vendaCabecalho?.valorSeguro,
				observacao: vendaCabecalhoDrift.vendaCabecalho?.observacao,
				situacao: VendaCabecalhoDomain.getSituacao(vendaCabecalhoDrift.vendaCabecalho?.situacao),
				diaFixoParcela: VendaCabecalhoDomain.getDiaFixoParcela(vendaCabecalhoDrift.vendaCabecalho?.diaFixoParcela),
			);
		} else {
			return null;
		}
	}


	VendaCabecalhoGrouped toDrift(VendaCabecalhoModel vendaCabecalhoModel) {
		return VendaCabecalhoGrouped(
			vendaCabecalho: VendaCabecalho(
				id: vendaCabecalhoModel.id,
				idVendaOrcamentoCabecalho: vendaCabecalhoModel.idVendaOrcamentoCabecalho,
				idVendaCondicoesPagamento: vendaCabecalhoModel.idVendaCondicoesPagamento,
				idNotaFiscalTipo: vendaCabecalhoModel.idNotaFiscalTipo,
				idTransportadora: vendaCabecalhoModel.idTransportadora,
				dataVenda: vendaCabecalhoModel.dataVenda,
				dataSaida: vendaCabecalhoModel.dataSaida,
				horaSaida: vendaCabecalhoModel.horaSaida,
				numeroFatura: vendaCabecalhoModel.numeroFatura,
				localEntrega: vendaCabecalhoModel.localEntrega,
				localCobranca: vendaCabecalhoModel.localCobranca,
				valorSubtotal: vendaCabecalhoModel.valorSubtotal,
				taxaComissao: vendaCabecalhoModel.taxaComissao,
				valorComissao: vendaCabecalhoModel.valorComissao,
				taxaDesconto: vendaCabecalhoModel.taxaDesconto,
				valorDesconto: vendaCabecalhoModel.valorDesconto,
				valorTotal: vendaCabecalhoModel.valorTotal,
				tipoFrete: VendaCabecalhoDomain.setTipoFrete(vendaCabecalhoModel.tipoFrete),
				formaPagamento: VendaCabecalhoDomain.setFormaPagamento(vendaCabecalhoModel.formaPagamento),
				valorFrete: vendaCabecalhoModel.valorFrete,
				valorSeguro: vendaCabecalhoModel.valorSeguro,
				observacao: vendaCabecalhoModel.observacao,
				situacao: VendaCabecalhoDomain.setSituacao(vendaCabecalhoModel.situacao),
				diaFixoParcela: VendaCabecalhoDomain.setDiaFixoParcela(vendaCabecalhoModel.diaFixoParcela),
			),
		);
	}

		
}
