import 'dart:convert';
import 'package:ordem_servico/app/data/provider/api/api_provider_base.dart';
import 'package:ordem_servico/app/data/model/model_imports.dart';

class ProdutoGrupoApiProvider extends ApiProviderBase {

	Future<List<ProdutoGrupoModel>?> getList({Filter? filter}) async {
		List<ProdutoGrupoModel> produtoGrupoModelList = [];

		try {
			handleFilter(filter, '/produto-grupo/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var produtoGrupoModelJson = json.decode(response.body) as List<dynamic>;
					for (var produtoGrupoModel in produtoGrupoModelJson) {
						produtoGrupoModelList.add(ProdutoGrupoModel.fromJson(produtoGrupoModel));
					}
					return produtoGrupoModelList;
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

	Future<ProdutoGrupoModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/produto-grupo/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var produtoGrupoModelJson = json.decode(response.body);
					return ProdutoGrupoModel.fromJson(produtoGrupoModelJson);		 
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

	Future<ProdutoGrupoModel?>? insert(ProdutoGrupoModel produtoGrupoModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/produto-grupo')!,
				headers: ApiProviderBase.headerRequisition(),
				body: produtoGrupoModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var produtoGrupoModelJson = json.decode(response.body);
					return ProdutoGrupoModel.fromJson(produtoGrupoModelJson);
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

	Future<ProdutoGrupoModel?>? update(ProdutoGrupoModel produtoGrupoModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/produto-grupo')!,
				headers: ApiProviderBase.headerRequisition(),
				body: produtoGrupoModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var produtoGrupoModelJson = json.decode(response.body);
					return ProdutoGrupoModel.fromJson(produtoGrupoModelJson);
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
				Uri.tryParse('$endpoint/produto-grupo/$pk')!,
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
