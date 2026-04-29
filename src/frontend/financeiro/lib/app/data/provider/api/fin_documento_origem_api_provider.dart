import 'dart:convert';
import 'package:financeiro/app/data/provider/api/api_provider_base.dart';
import 'package:financeiro/app/data/model/model_imports.dart';

class FinDocumentoOrigemApiProvider extends ApiProviderBase {

	Future<List<FinDocumentoOrigemModel>?> getList({Filter? filter}) async {
		List<FinDocumentoOrigemModel> finDocumentoOrigemModelList = [];

		try {
			handleFilter(filter, '/fin-documento-origem/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var finDocumentoOrigemModelJson = json.decode(response.body) as List<dynamic>;
					for (var finDocumentoOrigemModel in finDocumentoOrigemModelJson) {
						finDocumentoOrigemModelList.add(FinDocumentoOrigemModel.fromJson(finDocumentoOrigemModel));
					}
					return finDocumentoOrigemModelList;
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

	Future<FinDocumentoOrigemModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/fin-documento-origem/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var finDocumentoOrigemModelJson = json.decode(response.body);
					return FinDocumentoOrigemModel.fromJson(finDocumentoOrigemModelJson);		 
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

	Future<FinDocumentoOrigemModel?>? insert(FinDocumentoOrigemModel finDocumentoOrigemModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/fin-documento-origem')!,
				headers: ApiProviderBase.headerRequisition(),
				body: finDocumentoOrigemModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var finDocumentoOrigemModelJson = json.decode(response.body);
					return FinDocumentoOrigemModel.fromJson(finDocumentoOrigemModelJson);
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

	Future<FinDocumentoOrigemModel?>? update(FinDocumentoOrigemModel finDocumentoOrigemModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/fin-documento-origem')!,
				headers: ApiProviderBase.headerRequisition(),
				body: finDocumentoOrigemModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var finDocumentoOrigemModelJson = json.decode(response.body);
					return FinDocumentoOrigemModel.fromJson(finDocumentoOrigemModelJson);
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
				Uri.tryParse('$endpoint/fin-documento-origem/$pk')!,
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
