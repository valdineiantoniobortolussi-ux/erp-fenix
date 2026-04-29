import 'dart:convert';
import 'package:folha/app/data/provider/api/api_provider_base.dart';
import 'package:folha/app/data/model/model_imports.dart';

class FolhaPlanoSaudeApiProvider extends ApiProviderBase {

	Future<List<FolhaPlanoSaudeModel>?> getList({Filter? filter}) async {
		List<FolhaPlanoSaudeModel> folhaPlanoSaudeModelList = [];

		try {
			handleFilter(filter, '/folha-plano-saude/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var folhaPlanoSaudeModelJson = json.decode(response.body) as List<dynamic>;
					for (var folhaPlanoSaudeModel in folhaPlanoSaudeModelJson) {
						folhaPlanoSaudeModelList.add(FolhaPlanoSaudeModel.fromJson(folhaPlanoSaudeModel));
					}
					return folhaPlanoSaudeModelList;
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

	Future<FolhaPlanoSaudeModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/folha-plano-saude/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var folhaPlanoSaudeModelJson = json.decode(response.body);
					return FolhaPlanoSaudeModel.fromJson(folhaPlanoSaudeModelJson);		 
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

	Future<FolhaPlanoSaudeModel?>? insert(FolhaPlanoSaudeModel folhaPlanoSaudeModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/folha-plano-saude')!,
				headers: ApiProviderBase.headerRequisition(),
				body: folhaPlanoSaudeModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var folhaPlanoSaudeModelJson = json.decode(response.body);
					return FolhaPlanoSaudeModel.fromJson(folhaPlanoSaudeModelJson);
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

	Future<FolhaPlanoSaudeModel?>? update(FolhaPlanoSaudeModel folhaPlanoSaudeModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/folha-plano-saude')!,
				headers: ApiProviderBase.headerRequisition(),
				body: folhaPlanoSaudeModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var folhaPlanoSaudeModelJson = json.decode(response.body);
					return FolhaPlanoSaudeModel.fromJson(folhaPlanoSaudeModelJson);
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
				Uri.tryParse('$endpoint/folha-plano-saude/$pk')!,
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
