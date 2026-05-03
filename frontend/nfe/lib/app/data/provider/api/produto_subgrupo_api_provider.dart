import 'dart:convert';
import 'package:nfe/app/data/provider/api/api_provider_base.dart';
import 'package:nfe/app/data/model/model_imports.dart';

class ProdutoSubgrupoApiProvider extends ApiProviderBase {

	Future<List<ProdutoSubgrupoModel>?> getList({Filter? filter}) async {
		List<ProdutoSubgrupoModel> produtoSubgrupoModelList = [];

		try {
			handleFilter(filter, '/produto-subgrupo/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var produtoSubgrupoModelJson = json.decode(response.body) as List<dynamic>;
					for (var produtoSubgrupoModel in produtoSubgrupoModelJson) {
						produtoSubgrupoModelList.add(ProdutoSubgrupoModel.fromJson(produtoSubgrupoModel));
					}
					return produtoSubgrupoModelList;
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

	Future<ProdutoSubgrupoModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/produto-subgrupo/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var produtoSubgrupoModelJson = json.decode(response.body);
					return ProdutoSubgrupoModel.fromJson(produtoSubgrupoModelJson);		 
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

	Future<ProdutoSubgrupoModel?>? insert(ProdutoSubgrupoModel produtoSubgrupoModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/produto-subgrupo')!,
				headers: ApiProviderBase.headerRequisition(),
				body: produtoSubgrupoModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var produtoSubgrupoModelJson = json.decode(response.body);
					return ProdutoSubgrupoModel.fromJson(produtoSubgrupoModelJson);
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

	Future<ProdutoSubgrupoModel?>? update(ProdutoSubgrupoModel produtoSubgrupoModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/produto-subgrupo')!,
				headers: ApiProviderBase.headerRequisition(),
				body: produtoSubgrupoModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var produtoSubgrupoModelJson = json.decode(response.body);
					return ProdutoSubgrupoModel.fromJson(produtoSubgrupoModelJson);
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
				Uri.tryParse('$endpoint/produto-subgrupo/$pk')!,
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
