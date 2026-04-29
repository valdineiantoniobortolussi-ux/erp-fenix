import 'dart:convert';
import 'package:fiscal/app/data/provider/api/api_provider_base.dart';
import 'package:fiscal/app/data/model/model_imports.dart';

class FiscalLivroApiProvider extends ApiProviderBase {

	Future<List<FiscalLivroModel>?> getList({Filter? filter}) async {
		List<FiscalLivroModel> fiscalLivroModelList = [];

		try {
			handleFilter(filter, '/fiscal-livro/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var fiscalLivroModelJson = json.decode(response.body) as List<dynamic>;
					for (var fiscalLivroModel in fiscalLivroModelJson) {
						fiscalLivroModelList.add(FiscalLivroModel.fromJson(fiscalLivroModel));
					}
					return fiscalLivroModelList;
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

	Future<FiscalLivroModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/fiscal-livro/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var fiscalLivroModelJson = json.decode(response.body);
					return FiscalLivroModel.fromJson(fiscalLivroModelJson);		 
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

	Future<FiscalLivroModel?>? insert(FiscalLivroModel fiscalLivroModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/fiscal-livro')!,
				headers: ApiProviderBase.headerRequisition(),
				body: fiscalLivroModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var fiscalLivroModelJson = json.decode(response.body);
					return FiscalLivroModel.fromJson(fiscalLivroModelJson);
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

	Future<FiscalLivroModel?>? update(FiscalLivroModel fiscalLivroModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/fiscal-livro')!,
				headers: ApiProviderBase.headerRequisition(),
				body: fiscalLivroModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var fiscalLivroModelJson = json.decode(response.body);
					return FiscalLivroModel.fromJson(fiscalLivroModelJson);
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
				Uri.tryParse('$endpoint/fiscal-livro/$pk')!,
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
