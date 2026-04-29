import 'dart:convert';
import 'package:nfe/app/data/provider/api/api_provider_base.dart';
import 'package:nfe/app/data/model/model_imports.dart';

class ProdutoMarcaApiProvider extends ApiProviderBase {

	Future<List<ProdutoMarcaModel>?> getList({Filter? filter}) async {
		List<ProdutoMarcaModel> produtoMarcaModelList = [];

		try {
			handleFilter(filter, '/produto-marca/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var produtoMarcaModelJson = json.decode(response.body) as List<dynamic>;
					for (var produtoMarcaModel in produtoMarcaModelJson) {
						produtoMarcaModelList.add(ProdutoMarcaModel.fromJson(produtoMarcaModel));
					}
					return produtoMarcaModelList;
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

	Future<ProdutoMarcaModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/produto-marca/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var produtoMarcaModelJson = json.decode(response.body);
					return ProdutoMarcaModel.fromJson(produtoMarcaModelJson);		 
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

	Future<ProdutoMarcaModel?>? insert(ProdutoMarcaModel produtoMarcaModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/produto-marca')!,
				headers: ApiProviderBase.headerRequisition(),
				body: produtoMarcaModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var produtoMarcaModelJson = json.decode(response.body);
					return ProdutoMarcaModel.fromJson(produtoMarcaModelJson);
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

	Future<ProdutoMarcaModel?>? update(ProdutoMarcaModel produtoMarcaModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/produto-marca')!,
				headers: ApiProviderBase.headerRequisition(),
				body: produtoMarcaModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var produtoMarcaModelJson = json.decode(response.body);
					return ProdutoMarcaModel.fromJson(produtoMarcaModelJson);
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
				Uri.tryParse('$endpoint/produto-marca/$pk')!,
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
