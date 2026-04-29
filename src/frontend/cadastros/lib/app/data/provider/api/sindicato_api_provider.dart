import 'dart:convert';
import 'package:cadastros/app/data/provider/api/api_provider_base.dart';
import 'package:cadastros/app/data/model/model_imports.dart';

class SindicatoApiProvider extends ApiProviderBase {

	Future<List<SindicatoModel>?> getList({Filter? filter}) async {
		List<SindicatoModel> sindicatoModelList = [];

		try {
			handleFilter(filter, '/sindicato/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var sindicatoModelJson = json.decode(response.body) as List<dynamic>;
					for (var sindicatoModel in sindicatoModelJson) {
						sindicatoModelList.add(SindicatoModel.fromJson(sindicatoModel));
					}
					return sindicatoModelList;
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

	Future<SindicatoModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/sindicato/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var sindicatoModelJson = json.decode(response.body);
					return SindicatoModel.fromJson(sindicatoModelJson);		 
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

	Future<SindicatoModel?>? insert(SindicatoModel sindicatoModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/sindicato')!,
				headers: ApiProviderBase.headerRequisition(),
				body: sindicatoModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var sindicatoModelJson = json.decode(response.body);
					return SindicatoModel.fromJson(sindicatoModelJson);
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

	Future<SindicatoModel?>? update(SindicatoModel sindicatoModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/sindicato')!,
				headers: ApiProviderBase.headerRequisition(),
				body: sindicatoModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var sindicatoModelJson = json.decode(response.body);
					return SindicatoModel.fromJson(sindicatoModelJson);
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
				Uri.tryParse('$endpoint/sindicato/$pk')!,
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
