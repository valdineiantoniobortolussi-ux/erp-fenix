import 'dart:convert';
import 'package:contabil/app/data/provider/api/api_provider_base.dart';
import 'package:contabil/app/data/model/model_imports.dart';

class ContabilContaRateioApiProvider extends ApiProviderBase {

	Future<List<ContabilContaRateioModel>?> getList({Filter? filter}) async {
		List<ContabilContaRateioModel> contabilContaRateioModelList = [];

		try {
			handleFilter(filter, '/contabil-conta-rateio/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var contabilContaRateioModelJson = json.decode(response.body) as List<dynamic>;
					for (var contabilContaRateioModel in contabilContaRateioModelJson) {
						contabilContaRateioModelList.add(ContabilContaRateioModel.fromJson(contabilContaRateioModel));
					}
					return contabilContaRateioModelList;
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

	Future<ContabilContaRateioModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/contabil-conta-rateio/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var contabilContaRateioModelJson = json.decode(response.body);
					return ContabilContaRateioModel.fromJson(contabilContaRateioModelJson);		 
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

	Future<ContabilContaRateioModel?>? insert(ContabilContaRateioModel contabilContaRateioModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/contabil-conta-rateio')!,
				headers: ApiProviderBase.headerRequisition(),
				body: contabilContaRateioModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var contabilContaRateioModelJson = json.decode(response.body);
					return ContabilContaRateioModel.fromJson(contabilContaRateioModelJson);
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

	Future<ContabilContaRateioModel?>? update(ContabilContaRateioModel contabilContaRateioModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/contabil-conta-rateio')!,
				headers: ApiProviderBase.headerRequisition(),
				body: contabilContaRateioModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var contabilContaRateioModelJson = json.decode(response.body);
					return ContabilContaRateioModel.fromJson(contabilContaRateioModelJson);
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
				Uri.tryParse('$endpoint/contabil-conta-rateio/$pk')!,
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
