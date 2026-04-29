import 'dart:convert';
import 'package:vendas/app/data/provider/api/api_provider_base.dart';
import 'package:vendas/app/data/model/model_imports.dart';

class VendaOrcamentoCabecalhoApiProvider extends ApiProviderBase {

	Future<List<VendaOrcamentoCabecalhoModel>?> getList({Filter? filter}) async {
		List<VendaOrcamentoCabecalhoModel> vendaOrcamentoCabecalhoModelList = [];

		try {
			handleFilter(filter, '/venda-orcamento-cabecalho/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var vendaOrcamentoCabecalhoModelJson = json.decode(response.body) as List<dynamic>;
					for (var vendaOrcamentoCabecalhoModel in vendaOrcamentoCabecalhoModelJson) {
						vendaOrcamentoCabecalhoModelList.add(VendaOrcamentoCabecalhoModel.fromJson(vendaOrcamentoCabecalhoModel));
					}
					return vendaOrcamentoCabecalhoModelList;
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

	Future<VendaOrcamentoCabecalhoModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/venda-orcamento-cabecalho/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var vendaOrcamentoCabecalhoModelJson = json.decode(response.body);
					return VendaOrcamentoCabecalhoModel.fromJson(vendaOrcamentoCabecalhoModelJson);		 
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

	Future<VendaOrcamentoCabecalhoModel?>? insert(VendaOrcamentoCabecalhoModel vendaOrcamentoCabecalhoModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/venda-orcamento-cabecalho')!,
				headers: ApiProviderBase.headerRequisition(),
				body: vendaOrcamentoCabecalhoModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var vendaOrcamentoCabecalhoModelJson = json.decode(response.body);
					return VendaOrcamentoCabecalhoModel.fromJson(vendaOrcamentoCabecalhoModelJson);
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

	Future<VendaOrcamentoCabecalhoModel?>? update(VendaOrcamentoCabecalhoModel vendaOrcamentoCabecalhoModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/venda-orcamento-cabecalho')!,
				headers: ApiProviderBase.headerRequisition(),
				body: vendaOrcamentoCabecalhoModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var vendaOrcamentoCabecalhoModelJson = json.decode(response.body);
					return VendaOrcamentoCabecalhoModel.fromJson(vendaOrcamentoCabecalhoModelJson);
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
				Uri.tryParse('$endpoint/venda-orcamento-cabecalho/$pk')!,
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
