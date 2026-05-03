import 'dart:convert';
import 'package:folha/app/data/provider/api/api_provider_base.dart';
import 'package:folha/app/data/model/model_imports.dart';

class FolhaInssServicoApiProvider extends ApiProviderBase {

	Future<List<FolhaInssServicoModel>?> getList({Filter? filter}) async {
		List<FolhaInssServicoModel> folhaInssServicoModelList = [];

		try {
			handleFilter(filter, '/folha-inss-servico/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var folhaInssServicoModelJson = json.decode(response.body) as List<dynamic>;
					for (var folhaInssServicoModel in folhaInssServicoModelJson) {
						folhaInssServicoModelList.add(FolhaInssServicoModel.fromJson(folhaInssServicoModel));
					}
					return folhaInssServicoModelList;
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

	Future<FolhaInssServicoModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/folha-inss-servico/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var folhaInssServicoModelJson = json.decode(response.body);
					return FolhaInssServicoModel.fromJson(folhaInssServicoModelJson);		 
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

	Future<FolhaInssServicoModel?>? insert(FolhaInssServicoModel folhaInssServicoModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/folha-inss-servico')!,
				headers: ApiProviderBase.headerRequisition(),
				body: folhaInssServicoModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var folhaInssServicoModelJson = json.decode(response.body);
					return FolhaInssServicoModel.fromJson(folhaInssServicoModelJson);
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

	Future<FolhaInssServicoModel?>? update(FolhaInssServicoModel folhaInssServicoModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/folha-inss-servico')!,
				headers: ApiProviderBase.headerRequisition(),
				body: folhaInssServicoModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var folhaInssServicoModelJson = json.decode(response.body);
					return FolhaInssServicoModel.fromJson(folhaInssServicoModelJson);
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
				Uri.tryParse('$endpoint/folha-inss-servico/$pk')!,
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
