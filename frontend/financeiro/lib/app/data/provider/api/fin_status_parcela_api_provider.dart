import 'dart:convert';
import 'package:financeiro/app/data/provider/api/api_provider_base.dart';
import 'package:financeiro/app/data/model/model_imports.dart';

class FinStatusParcelaApiProvider extends ApiProviderBase {

	Future<List<FinStatusParcelaModel>?> getList({Filter? filter}) async {
		List<FinStatusParcelaModel> finStatusParcelaModelList = [];

		try {
			handleFilter(filter, '/fin-status-parcela/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var finStatusParcelaModelJson = json.decode(response.body) as List<dynamic>;
					for (var finStatusParcelaModel in finStatusParcelaModelJson) {
						finStatusParcelaModelList.add(FinStatusParcelaModel.fromJson(finStatusParcelaModel));
					}
					return finStatusParcelaModelList;
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

	Future<FinStatusParcelaModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/fin-status-parcela/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var finStatusParcelaModelJson = json.decode(response.body);
					return FinStatusParcelaModel.fromJson(finStatusParcelaModelJson);		 
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

	Future<FinStatusParcelaModel?>? insert(FinStatusParcelaModel finStatusParcelaModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/fin-status-parcela')!,
				headers: ApiProviderBase.headerRequisition(),
				body: finStatusParcelaModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var finStatusParcelaModelJson = json.decode(response.body);
					return FinStatusParcelaModel.fromJson(finStatusParcelaModelJson);
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

	Future<FinStatusParcelaModel?>? update(FinStatusParcelaModel finStatusParcelaModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/fin-status-parcela')!,
				headers: ApiProviderBase.headerRequisition(),
				body: finStatusParcelaModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var finStatusParcelaModelJson = json.decode(response.body);
					return FinStatusParcelaModel.fromJson(finStatusParcelaModelJson);
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
				Uri.tryParse('$endpoint/fin-status-parcela/$pk')!,
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
