import 'dart:convert';
import 'package:contabil/app/data/provider/api/api_provider_base.dart';
import 'package:contabil/app/data/model/model_imports.dart';

class RateioCentroResultadoCabApiProvider extends ApiProviderBase {

	Future<List<RateioCentroResultadoCabModel>?> getList({Filter? filter}) async {
		List<RateioCentroResultadoCabModel> rateioCentroResultadoCabModelList = [];

		try {
			handleFilter(filter, '/rateio-centro-resultado-cab/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var rateioCentroResultadoCabModelJson = json.decode(response.body) as List<dynamic>;
					for (var rateioCentroResultadoCabModel in rateioCentroResultadoCabModelJson) {
						rateioCentroResultadoCabModelList.add(RateioCentroResultadoCabModel.fromJson(rateioCentroResultadoCabModel));
					}
					return rateioCentroResultadoCabModelList;
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

	Future<RateioCentroResultadoCabModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/rateio-centro-resultado-cab/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var rateioCentroResultadoCabModelJson = json.decode(response.body);
					return RateioCentroResultadoCabModel.fromJson(rateioCentroResultadoCabModelJson);		 
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

	Future<RateioCentroResultadoCabModel?>? insert(RateioCentroResultadoCabModel rateioCentroResultadoCabModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/rateio-centro-resultado-cab')!,
				headers: ApiProviderBase.headerRequisition(),
				body: rateioCentroResultadoCabModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var rateioCentroResultadoCabModelJson = json.decode(response.body);
					return RateioCentroResultadoCabModel.fromJson(rateioCentroResultadoCabModelJson);
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

	Future<RateioCentroResultadoCabModel?>? update(RateioCentroResultadoCabModel rateioCentroResultadoCabModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/rateio-centro-resultado-cab')!,
				headers: ApiProviderBase.headerRequisition(),
				body: rateioCentroResultadoCabModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var rateioCentroResultadoCabModelJson = json.decode(response.body);
					return RateioCentroResultadoCabModel.fromJson(rateioCentroResultadoCabModelJson);
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
				Uri.tryParse('$endpoint/rateio-centro-resultado-cab/$pk')!,
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
