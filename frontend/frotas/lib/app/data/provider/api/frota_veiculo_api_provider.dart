import 'dart:convert';
import 'package:frotas/app/data/provider/api/api_provider_base.dart';
import 'package:frotas/app/data/model/model_imports.dart';

class FrotaVeiculoApiProvider extends ApiProviderBase {

	Future<List<FrotaVeiculoModel>?> getList({Filter? filter}) async {
		List<FrotaVeiculoModel> frotaVeiculoModelList = [];

		try {
			handleFilter(filter, '/frota-veiculo/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var frotaVeiculoModelJson = json.decode(response.body) as List<dynamic>;
					for (var frotaVeiculoModel in frotaVeiculoModelJson) {
						frotaVeiculoModelList.add(FrotaVeiculoModel.fromJson(frotaVeiculoModel));
					}
					return frotaVeiculoModelList;
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

	Future<FrotaVeiculoModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/frota-veiculo/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var frotaVeiculoModelJson = json.decode(response.body);
					return FrotaVeiculoModel.fromJson(frotaVeiculoModelJson);		 
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

	Future<FrotaVeiculoModel?>? insert(FrotaVeiculoModel frotaVeiculoModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/frota-veiculo')!,
				headers: ApiProviderBase.headerRequisition(),
				body: frotaVeiculoModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var frotaVeiculoModelJson = json.decode(response.body);
					return FrotaVeiculoModel.fromJson(frotaVeiculoModelJson);
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

	Future<FrotaVeiculoModel?>? update(FrotaVeiculoModel frotaVeiculoModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/frota-veiculo')!,
				headers: ApiProviderBase.headerRequisition(),
				body: frotaVeiculoModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var frotaVeiculoModelJson = json.decode(response.body);
					return FrotaVeiculoModel.fromJson(frotaVeiculoModelJson);
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
				Uri.tryParse('$endpoint/frota-veiculo/$pk')!,
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
