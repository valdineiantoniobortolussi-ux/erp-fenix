import 'dart:convert';
import 'package:vendas/app/data/provider/api/api_provider_base.dart';
import 'package:vendas/app/data/model/model_imports.dart';

class VendaCondicoesPagamentoApiProvider extends ApiProviderBase {

	Future<List<VendaCondicoesPagamentoModel>?> getList({Filter? filter}) async {
		List<VendaCondicoesPagamentoModel> vendaCondicoesPagamentoModelList = [];

		try {
			handleFilter(filter, '/venda-condicoes-pagamento/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var vendaCondicoesPagamentoModelJson = json.decode(response.body) as List<dynamic>;
					for (var vendaCondicoesPagamentoModel in vendaCondicoesPagamentoModelJson) {
						vendaCondicoesPagamentoModelList.add(VendaCondicoesPagamentoModel.fromJson(vendaCondicoesPagamentoModel));
					}
					return vendaCondicoesPagamentoModelList;
				}
			} else {
				handleResultError(response.body, response.headers);
				return null;
			}
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<VendaCondicoesPagamentoModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/venda-condicoes-pagamento/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var vendaCondicoesPagamentoModelJson = json.decode(response.body);
					return VendaCondicoesPagamentoModel.fromJson(vendaCondicoesPagamentoModelJson);		 
				}
			} else {
				handleResultError(response.body, response.headers);
				return null;
			}
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<VendaCondicoesPagamentoModel?>? insert(VendaCondicoesPagamentoModel vendaCondicoesPagamentoModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/venda-condicoes-pagamento')!,
				headers: ApiProviderBase.headerRequisition(),
				body: vendaCondicoesPagamentoModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var vendaCondicoesPagamentoModelJson = json.decode(response.body);
					return VendaCondicoesPagamentoModel.fromJson(vendaCondicoesPagamentoModelJson);
				}
			} else {
				handleResultError(response.body, response.headers);
				return null;
			}
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<VendaCondicoesPagamentoModel?>? update(VendaCondicoesPagamentoModel vendaCondicoesPagamentoModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/venda-condicoes-pagamento')!,
				headers: ApiProviderBase.headerRequisition(),
				body: vendaCondicoesPagamentoModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var vendaCondicoesPagamentoModelJson = json.decode(response.body);
					return VendaCondicoesPagamentoModel.fromJson(vendaCondicoesPagamentoModelJson);
				}
			} else {
				handleResultError(response.body, response.headers);
				return null;
			}
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.delete(
				Uri.tryParse('$endpoint/venda-condicoes-pagamento/$pk')!,
				headers: ApiProviderBase.headerRequisition(),
			);

			if (response.statusCode == 200) {
				return true;
			} else {
				handleResultError(response.body, response.headers);
				return null;
			}
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	
}
