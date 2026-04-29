import 'dart:convert';
import 'package:folha/app/data/provider/api/api_provider_base.dart';
import 'package:folha/app/data/model/model_imports.dart';

class FolhaFechamentoApiProvider extends ApiProviderBase {

	Future<List<FolhaFechamentoModel>?> getList({Filter? filter}) async {
		List<FolhaFechamentoModel> folhaFechamentoModelList = [];

		try {
			handleFilter(filter, '/folha-fechamento/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var folhaFechamentoModelJson = json.decode(response.body) as List<dynamic>;
					for (var folhaFechamentoModel in folhaFechamentoModelJson) {
						folhaFechamentoModelList.add(FolhaFechamentoModel.fromJson(folhaFechamentoModel));
					}
					return folhaFechamentoModelList;
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

	Future<FolhaFechamentoModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/folha-fechamento/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var folhaFechamentoModelJson = json.decode(response.body);
					return FolhaFechamentoModel.fromJson(folhaFechamentoModelJson);		 
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

	Future<FolhaFechamentoModel?>? insert(FolhaFechamentoModel folhaFechamentoModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/folha-fechamento')!,
				headers: ApiProviderBase.headerRequisition(),
				body: folhaFechamentoModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var folhaFechamentoModelJson = json.decode(response.body);
					return FolhaFechamentoModel.fromJson(folhaFechamentoModelJson);
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

	Future<FolhaFechamentoModel?>? update(FolhaFechamentoModel folhaFechamentoModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/folha-fechamento')!,
				headers: ApiProviderBase.headerRequisition(),
				body: folhaFechamentoModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var folhaFechamentoModelJson = json.decode(response.body);
					return FolhaFechamentoModel.fromJson(folhaFechamentoModelJson);
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
				Uri.tryParse('$endpoint/folha-fechamento/$pk')!,
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
