import 'dart:convert';
import 'package:compras/app/data/provider/api/api_provider_base.dart';
import 'package:compras/app/data/model/model_imports.dart';

class CompraCotacaoApiProvider extends ApiProviderBase {

	Future<List<CompraCotacaoModel>?> getList({Filter? filter}) async {
		List<CompraCotacaoModel> compraCotacaoModelList = [];

		try {
			handleFilter(filter, '/compra-cotacao/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var compraCotacaoModelJson = json.decode(response.body) as List<dynamic>;
					for (var compraCotacaoModel in compraCotacaoModelJson) {
						compraCotacaoModelList.add(CompraCotacaoModel.fromJson(compraCotacaoModel));
					}
					return compraCotacaoModelList;
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

	Future<CompraCotacaoModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/compra-cotacao/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var compraCotacaoModelJson = json.decode(response.body);
					return CompraCotacaoModel.fromJson(compraCotacaoModelJson);		 
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

	Future<CompraCotacaoModel?>? insert(CompraCotacaoModel compraCotacaoModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/compra-cotacao')!,
				headers: ApiProviderBase.headerRequisition(),
				body: compraCotacaoModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var compraCotacaoModelJson = json.decode(response.body);
					return CompraCotacaoModel.fromJson(compraCotacaoModelJson);
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

	Future<CompraCotacaoModel?>? update(CompraCotacaoModel compraCotacaoModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/compra-cotacao')!,
				headers: ApiProviderBase.headerRequisition(),
				body: compraCotacaoModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var compraCotacaoModelJson = json.decode(response.body);
					return CompraCotacaoModel.fromJson(compraCotacaoModelJson);
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
				Uri.tryParse('$endpoint/compra-cotacao/$pk')!,
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
