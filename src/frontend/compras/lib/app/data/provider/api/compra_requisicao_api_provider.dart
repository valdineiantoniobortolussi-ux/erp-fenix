import 'dart:convert';
import 'package:compras/app/data/provider/api/api_provider_base.dart';
import 'package:compras/app/data/model/model_imports.dart';

class CompraRequisicaoApiProvider extends ApiProviderBase {

	Future<List<CompraRequisicaoModel>?> getList({Filter? filter}) async {
		List<CompraRequisicaoModel> compraRequisicaoModelList = [];

		try {
			handleFilter(filter, '/compra-requisicao/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var compraRequisicaoModelJson = json.decode(response.body) as List<dynamic>;
					for (var compraRequisicaoModel in compraRequisicaoModelJson) {
						compraRequisicaoModelList.add(CompraRequisicaoModel.fromJson(compraRequisicaoModel));
					}
					return compraRequisicaoModelList;
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

	Future<CompraRequisicaoModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/compra-requisicao/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var compraRequisicaoModelJson = json.decode(response.body);
					return CompraRequisicaoModel.fromJson(compraRequisicaoModelJson);		 
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

	Future<CompraRequisicaoModel?>? insert(CompraRequisicaoModel compraRequisicaoModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/compra-requisicao')!,
				headers: ApiProviderBase.headerRequisition(),
				body: compraRequisicaoModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var compraRequisicaoModelJson = json.decode(response.body);
					return CompraRequisicaoModel.fromJson(compraRequisicaoModelJson);
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

	Future<CompraRequisicaoModel?>? update(CompraRequisicaoModel compraRequisicaoModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/compra-requisicao')!,
				headers: ApiProviderBase.headerRequisition(),
				body: compraRequisicaoModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var compraRequisicaoModelJson = json.decode(response.body);
					return CompraRequisicaoModel.fromJson(compraRequisicaoModelJson);
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
				Uri.tryParse('$endpoint/compra-requisicao/$pk')!,
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
