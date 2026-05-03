import 'dart:convert';
import 'package:contabil/app/data/provider/api/api_provider_base.dart';
import 'package:contabil/app/data/model/model_imports.dart';

class PlanoCentroResultadoApiProvider extends ApiProviderBase {

	Future<List<PlanoCentroResultadoModel>?> getList({Filter? filter}) async {
		List<PlanoCentroResultadoModel> planoCentroResultadoModelList = [];

		try {
			handleFilter(filter, '/plano-centro-resultado/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var planoCentroResultadoModelJson = json.decode(response.body) as List<dynamic>;
					for (var planoCentroResultadoModel in planoCentroResultadoModelJson) {
						planoCentroResultadoModelList.add(PlanoCentroResultadoModel.fromJson(planoCentroResultadoModel));
					}
					return planoCentroResultadoModelList;
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

	Future<PlanoCentroResultadoModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/plano-centro-resultado/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var planoCentroResultadoModelJson = json.decode(response.body);
					return PlanoCentroResultadoModel.fromJson(planoCentroResultadoModelJson);		 
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

	Future<PlanoCentroResultadoModel?>? insert(PlanoCentroResultadoModel planoCentroResultadoModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/plano-centro-resultado')!,
				headers: ApiProviderBase.headerRequisition(),
				body: planoCentroResultadoModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var planoCentroResultadoModelJson = json.decode(response.body);
					return PlanoCentroResultadoModel.fromJson(planoCentroResultadoModelJson);
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

	Future<PlanoCentroResultadoModel?>? update(PlanoCentroResultadoModel planoCentroResultadoModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/plano-centro-resultado')!,
				headers: ApiProviderBase.headerRequisition(),
				body: planoCentroResultadoModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var planoCentroResultadoModelJson = json.decode(response.body);
					return PlanoCentroResultadoModel.fromJson(planoCentroResultadoModelJson);
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
				Uri.tryParse('$endpoint/plano-centro-resultado/$pk')!,
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
