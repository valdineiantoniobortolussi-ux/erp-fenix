import 'dart:convert';
import 'package:folha/app/data/provider/api/api_provider_base.dart';
import 'package:folha/app/data/model/model_imports.dart';

class OperadoraPlanoSaudeApiProvider extends ApiProviderBase {

	Future<List<OperadoraPlanoSaudeModel>?> getList({Filter? filter}) async {
		List<OperadoraPlanoSaudeModel> operadoraPlanoSaudeModelList = [];

		try {
			handleFilter(filter, '/operadora-plano-saude/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var operadoraPlanoSaudeModelJson = json.decode(response.body) as List<dynamic>;
					for (var operadoraPlanoSaudeModel in operadoraPlanoSaudeModelJson) {
						operadoraPlanoSaudeModelList.add(OperadoraPlanoSaudeModel.fromJson(operadoraPlanoSaudeModel));
					}
					return operadoraPlanoSaudeModelList;
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

	Future<OperadoraPlanoSaudeModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/operadora-plano-saude/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var operadoraPlanoSaudeModelJson = json.decode(response.body);
					return OperadoraPlanoSaudeModel.fromJson(operadoraPlanoSaudeModelJson);		 
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

	Future<OperadoraPlanoSaudeModel?>? insert(OperadoraPlanoSaudeModel operadoraPlanoSaudeModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/operadora-plano-saude')!,
				headers: ApiProviderBase.headerRequisition(),
				body: operadoraPlanoSaudeModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var operadoraPlanoSaudeModelJson = json.decode(response.body);
					return OperadoraPlanoSaudeModel.fromJson(operadoraPlanoSaudeModelJson);
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

	Future<OperadoraPlanoSaudeModel?>? update(OperadoraPlanoSaudeModel operadoraPlanoSaudeModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/operadora-plano-saude')!,
				headers: ApiProviderBase.headerRequisition(),
				body: operadoraPlanoSaudeModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var operadoraPlanoSaudeModelJson = json.decode(response.body);
					return OperadoraPlanoSaudeModel.fromJson(operadoraPlanoSaudeModelJson);
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
				Uri.tryParse('$endpoint/operadora-plano-saude/$pk')!,
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
