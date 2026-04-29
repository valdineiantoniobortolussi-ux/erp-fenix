import 'package:vendas/app/data/provider/drift/database/database_imports.dart';
import 'package:vendas/app/infra/infra_imports.dart';
import 'package:vendas/app/data/provider/provider_base.dart';
import 'package:vendas/app/data/provider/drift/database/database.dart';
import 'package:vendas/app/data/model/model_imports.dart';
import 'package:vendas/app/data/domain/domain_imports.dart';

class VendaCondicoesPagamentoDriftProvider extends ProviderBase {

	Future<List<VendaCondicoesPagamentoModel>?> getList({Filter? filter}) async {
		List<VendaCondicoesPagamentoGrouped> vendaCondicoesPagamentoDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				vendaCondicoesPagamentoDriftList = await Session.database.vendaCondicoesPagamentoDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				vendaCondicoesPagamentoDriftList = await Session.database.vendaCondicoesPagamentoDao.getGroupedList(); 
			}
			if (vendaCondicoesPagamentoDriftList.isNotEmpty) {
				return toListModel(vendaCondicoesPagamentoDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<VendaCondicoesPagamentoModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.vendaCondicoesPagamentoDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<VendaCondicoesPagamentoModel?>? insert(VendaCondicoesPagamentoModel vendaCondicoesPagamentoModel) async {
		try {
			final lastPk = await Session.database.vendaCondicoesPagamentoDao.insertObject(toDrift(vendaCondicoesPagamentoModel));
			vendaCondicoesPagamentoModel.id = lastPk;
			return vendaCondicoesPagamentoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<VendaCondicoesPagamentoModel?>? update(VendaCondicoesPagamentoModel vendaCondicoesPagamentoModel) async {
		try {
			await Session.database.vendaCondicoesPagamentoDao.updateObject(toDrift(vendaCondicoesPagamentoModel));
			return vendaCondicoesPagamentoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.vendaCondicoesPagamentoDao.deleteObject(toDrift(VendaCondicoesPagamentoModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<VendaCondicoesPagamentoModel> toListModel(List<VendaCondicoesPagamentoGrouped> vendaCondicoesPagamentoDriftList) {
		List<VendaCondicoesPagamentoModel> listModel = [];
		for (var vendaCondicoesPagamentoDrift in vendaCondicoesPagamentoDriftList) {
			listModel.add(toModel(vendaCondicoesPagamentoDrift)!);
		}
		return listModel;
	}	

	VendaCondicoesPagamentoModel? toModel(VendaCondicoesPagamentoGrouped? vendaCondicoesPagamentoDrift) {
		if (vendaCondicoesPagamentoDrift != null) {
			return VendaCondicoesPagamentoModel(
				id: vendaCondicoesPagamentoDrift.vendaCondicoesPagamento?.id,
				nome: vendaCondicoesPagamentoDrift.vendaCondicoesPagamento?.nome,
				descricao: vendaCondicoesPagamentoDrift.vendaCondicoesPagamento?.descricao,
				faturamentoMinimo: vendaCondicoesPagamentoDrift.vendaCondicoesPagamento?.faturamentoMinimo,
				faturamentoMaximo: vendaCondicoesPagamentoDrift.vendaCondicoesPagamento?.faturamentoMaximo,
				indiceCorrecao: vendaCondicoesPagamentoDrift.vendaCondicoesPagamento?.indiceCorrecao,
				diasTolerancia: vendaCondicoesPagamentoDrift.vendaCondicoesPagamento?.diasTolerancia,
				valorTolerancia: vendaCondicoesPagamentoDrift.vendaCondicoesPagamento?.valorTolerancia,
				prazoMedio: vendaCondicoesPagamentoDrift.vendaCondicoesPagamento?.prazoMedio,
				vistaPrazo: VendaCondicoesPagamentoDomain.getVistaPrazo(vendaCondicoesPagamentoDrift.vendaCondicoesPagamento?.vistaPrazo),
				vendaCondicoesParcelasModelList: vendaCondicoesParcelasDriftToModel(vendaCondicoesPagamentoDrift.vendaCondicoesParcelasGroupedList),
			);
		} else {
			return null;
		}
	}

	List<VendaCondicoesParcelasModel> vendaCondicoesParcelasDriftToModel(List<VendaCondicoesParcelasGrouped>? vendaCondicoesParcelasDriftList) { 
		List<VendaCondicoesParcelasModel> vendaCondicoesParcelasModelList = [];
		if (vendaCondicoesParcelasDriftList != null) {
			for (var vendaCondicoesParcelasGrouped in vendaCondicoesParcelasDriftList) {
				vendaCondicoesParcelasModelList.add(
					VendaCondicoesParcelasModel(
						id: vendaCondicoesParcelasGrouped.vendaCondicoesParcelas?.id,
						idVendaCondicoesPagamento: vendaCondicoesParcelasGrouped.vendaCondicoesParcelas?.idVendaCondicoesPagamento,
						parcela: vendaCondicoesParcelasGrouped.vendaCondicoesParcelas?.parcela,
						dias: vendaCondicoesParcelasGrouped.vendaCondicoesParcelas?.dias,
						taxa: vendaCondicoesParcelasGrouped.vendaCondicoesParcelas?.taxa,
					)
				);
			}
			return vendaCondicoesParcelasModelList;
		}
		return [];
	}


	VendaCondicoesPagamentoGrouped toDrift(VendaCondicoesPagamentoModel vendaCondicoesPagamentoModel) {
		return VendaCondicoesPagamentoGrouped(
			vendaCondicoesPagamento: VendaCondicoesPagamento(
				id: vendaCondicoesPagamentoModel.id,
				nome: vendaCondicoesPagamentoModel.nome,
				descricao: vendaCondicoesPagamentoModel.descricao,
				faturamentoMinimo: vendaCondicoesPagamentoModel.faturamentoMinimo,
				faturamentoMaximo: vendaCondicoesPagamentoModel.faturamentoMaximo,
				indiceCorrecao: vendaCondicoesPagamentoModel.indiceCorrecao,
				diasTolerancia: vendaCondicoesPagamentoModel.diasTolerancia,
				valorTolerancia: vendaCondicoesPagamentoModel.valorTolerancia,
				prazoMedio: vendaCondicoesPagamentoModel.prazoMedio,
				vistaPrazo: VendaCondicoesPagamentoDomain.setVistaPrazo(vendaCondicoesPagamentoModel.vistaPrazo),
			),
			vendaCondicoesParcelasGroupedList: vendaCondicoesParcelasModelToDrift(vendaCondicoesPagamentoModel.vendaCondicoesParcelasModelList),
		);
	}

	List<VendaCondicoesParcelasGrouped> vendaCondicoesParcelasModelToDrift(List<VendaCondicoesParcelasModel>? vendaCondicoesParcelasModelList) { 
		List<VendaCondicoesParcelasGrouped> vendaCondicoesParcelasGroupedList = [];
		if (vendaCondicoesParcelasModelList != null) {
			for (var vendaCondicoesParcelasModel in vendaCondicoesParcelasModelList) {
				vendaCondicoesParcelasGroupedList.add(
					VendaCondicoesParcelasGrouped(
						vendaCondicoesParcelas: VendaCondicoesParcelas(
							id: vendaCondicoesParcelasModel.id,
							idVendaCondicoesPagamento: vendaCondicoesParcelasModel.idVendaCondicoesPagamento,
							parcela: vendaCondicoesParcelasModel.parcela,
							dias: vendaCondicoesParcelasModel.dias,
							taxa: vendaCondicoesParcelasModel.taxa,
						),
					),
				);
			}
			return vendaCondicoesParcelasGroupedList;
		}
		return [];
	}

		
}
