import 'dart:convert';
import 'package:contratos/app/data/provider/api/api_provider_base.dart';
import 'package:contratos/app/data/model/model_imports.dart';

class ContratoTemplateApiProvider extends ApiProviderBase {

	Future<List<ContratoTemplateModel>?> getList({Filter? filter}) async {
		List<ContratoTemplateModel> contratoTemplateModelList = [];

		try {
			handleFilter(filter, '/contrato-template/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var contratoTemplateModelJson = json.decode(response.body) as List<dynamic>;
					for (var contratoTemplateModel in contratoTemplateModelJson) {
						contratoTemplateModelList.add(ContratoTemplateModel.fromJson(contratoTemplateModel));
					}
					return contratoTemplateModelList;
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

	Future<ContratoTemplateModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/contrato-template/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var contratoTemplateModelJson = json.decode(response.body);
					return ContratoTemplateModel.fromJson(contratoTemplateModelJson);		 
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

	Future<ContratoTemplateModel?>? insert(ContratoTemplateModel contratoTemplateModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/contrato-template')!,
				headers: ApiProviderBase.headerRequisition(),
				body: contratoTemplateModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var contratoTemplateModelJson = json.decode(response.body);
					return ContratoTemplateModel.fromJson(contratoTemplateModelJson);
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

	Future<ContratoTemplateModel?>? update(ContratoTemplateModel contratoTemplateModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/contrato-template')!,
				headers: ApiProviderBase.headerRequisition(),
				body: contratoTemplateModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var contratoTemplateModelJson = json.decode(response.body);
					return ContratoTemplateModel.fromJson(contratoTemplateModelJson);
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
				Uri.tryParse('$endpoint/contrato-template/$pk')!,
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
