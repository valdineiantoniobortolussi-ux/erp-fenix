import 'dart:convert';
import 'package:nfe/app/data/provider/api/api_provider_base.dart';
import 'package:nfe/app/data/model/model_imports.dart';

class ProdutoUnidadeApiProvider extends ApiProviderBase {

	Future<List<ProdutoUnidadeModel>?> getList({Filter? filter}) async {
		List<ProdutoUnidadeModel> produtoUnidadeModelList = [];

		try {
			handleFilter(filter, '/produto-unidade/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var produtoUnidadeModelJson = json.decode(response.body) as List<dynamic>;
					for (var produtoUnidadeModel in produtoUnidadeModelJson) {
						produtoUnidadeModelList.add(ProdutoUnidadeModel.fromJson(produtoUnidadeModel));
					}
					return produtoUnidadeModelList;
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

	Future<ProdutoUnidadeModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/produto-unidade/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var produtoUnidadeModelJson = json.decode(response.body);
					return ProdutoUnidadeModel.fromJson(produtoUnidadeModelJson);		 
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

	Future<ProdutoUnidadeModel?>? insert(ProdutoUnidadeModel produtoUnidadeModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/produto-unidade')!,
				headers: ApiProviderBase.headerRequisition(),
				body: produtoUnidadeModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var produtoUnidadeModelJson = json.decode(response.body);
					return ProdutoUnidadeModel.fromJson(produtoUnidadeModelJson);
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

	Future<ProdutoUnidadeModel?>? update(ProdutoUnidadeModel produtoUnidadeModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/produto-unidade')!,
				headers: ApiProviderBase.headerRequisition(),
				body: produtoUnidadeModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var produtoUnidadeModelJson = json.decode(response.body);
					return ProdutoUnidadeModel.fromJson(produtoUnidadeModelJson);
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
				Uri.tryParse('$endpoint/produto-unidade/$pk')!,
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
