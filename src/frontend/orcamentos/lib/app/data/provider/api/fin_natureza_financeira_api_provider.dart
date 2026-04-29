import 'dart:convert';
import 'package:orcamentos/app/data/provider/api/api_provider_base.dart';
import 'package:orcamentos/app/data/model/model_imports.dart';

class FinNaturezaFinanceiraApiProvider extends ApiProviderBase {

	Future<List<FinNaturezaFinanceiraModel>?> getList({Filter? filter}) async {
		List<FinNaturezaFinanceiraModel> finNaturezaFinanceiraModelList = [];

		try {
			handleFilter(filter, '/fin-natureza-financeira/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var finNaturezaFinanceiraModelJson = json.decode(response.body) as List<dynamic>;
					for (var finNaturezaFinanceiraModel in finNaturezaFinanceiraModelJson) {
						finNaturezaFinanceiraModelList.add(FinNaturezaFinanceiraModel.fromJson(finNaturezaFinanceiraModel));
					}
					return finNaturezaFinanceiraModelList;
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

	Future<FinNaturezaFinanceiraModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/fin-natureza-financeira/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var finNaturezaFinanceiraModelJson = json.decode(response.body);
					return FinNaturezaFinanceiraModel.fromJson(finNaturezaFinanceiraModelJson);		 
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

	Future<FinNaturezaFinanceiraModel?>? insert(FinNaturezaFinanceiraModel finNaturezaFinanceiraModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/fin-natureza-financeira')!,
				headers: ApiProviderBase.headerRequisition(),
				body: finNaturezaFinanceiraModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var finNaturezaFinanceiraModelJson = json.decode(response.body);
					return FinNaturezaFinanceiraModel.fromJson(finNaturezaFinanceiraModelJson);
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

	Future<FinNaturezaFinanceiraModel?>? update(FinNaturezaFinanceiraModel finNaturezaFinanceiraModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/fin-natureza-financeira')!,
				headers: ApiProviderBase.headerRequisition(),
				body: finNaturezaFinanceiraModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var finNaturezaFinanceiraModelJson = json.decode(response.body);
					return FinNaturezaFinanceiraModel.fromJson(finNaturezaFinanceiraModelJson);
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
				Uri.tryParse('$endpoint/fin-natureza-financeira/$pk')!,
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
