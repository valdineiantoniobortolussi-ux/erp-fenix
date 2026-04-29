import 'dart:convert';
import 'package:cadastros/app/data/provider/api/api_provider_base.dart';
import 'package:cadastros/app/data/model/model_imports.dart';

class TabelaPrecoApiProvider extends ApiProviderBase {

	Future<List<TabelaPrecoModel>?> getList({Filter? filter}) async {
		List<TabelaPrecoModel> tabelaPrecoModelList = [];

		try {
			handleFilter(filter, '/tabela-preco/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var tabelaPrecoModelJson = json.decode(response.body) as List<dynamic>;
					for (var tabelaPrecoModel in tabelaPrecoModelJson) {
						tabelaPrecoModelList.add(TabelaPrecoModel.fromJson(tabelaPrecoModel));
					}
					return tabelaPrecoModelList;
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

	Future<TabelaPrecoModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/tabela-preco/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var tabelaPrecoModelJson = json.decode(response.body);
					return TabelaPrecoModel.fromJson(tabelaPrecoModelJson);		 
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

	Future<TabelaPrecoModel?>? insert(TabelaPrecoModel tabelaPrecoModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/tabela-preco')!,
				headers: ApiProviderBase.headerRequisition(),
				body: tabelaPrecoModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var tabelaPrecoModelJson = json.decode(response.body);
					return TabelaPrecoModel.fromJson(tabelaPrecoModelJson);
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

	Future<TabelaPrecoModel?>? update(TabelaPrecoModel tabelaPrecoModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/tabela-preco')!,
				headers: ApiProviderBase.headerRequisition(),
				body: tabelaPrecoModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var tabelaPrecoModelJson = json.decode(response.body);
					return TabelaPrecoModel.fromJson(tabelaPrecoModelJson);
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
				Uri.tryParse('$endpoint/tabela-preco/$pk')!,
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
