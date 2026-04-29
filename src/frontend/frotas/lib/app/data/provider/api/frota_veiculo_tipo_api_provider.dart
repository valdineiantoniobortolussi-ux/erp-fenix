import 'dart:convert';
import 'package:frotas/app/data/provider/api/api_provider_base.dart';
import 'package:frotas/app/data/model/model_imports.dart';

class FrotaVeiculoTipoApiProvider extends ApiProviderBase {

	Future<List<FrotaVeiculoTipoModel>?> getList({Filter? filter}) async {
		List<FrotaVeiculoTipoModel> frotaVeiculoTipoModelList = [];

		try {
			handleFilter(filter, '/frota-veiculo-tipo/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var frotaVeiculoTipoModelJson = json.decode(response.body) as List<dynamic>;
					for (var frotaVeiculoTipoModel in frotaVeiculoTipoModelJson) {
						frotaVeiculoTipoModelList.add(FrotaVeiculoTipoModel.fromJson(frotaVeiculoTipoModel));
					}
					return frotaVeiculoTipoModelList;
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

	Future<FrotaVeiculoTipoModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/frota-veiculo-tipo/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var frotaVeiculoTipoModelJson = json.decode(response.body);
					return FrotaVeiculoTipoModel.fromJson(frotaVeiculoTipoModelJson);		 
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

	Future<FrotaVeiculoTipoModel?>? insert(FrotaVeiculoTipoModel frotaVeiculoTipoModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/frota-veiculo-tipo')!,
				headers: ApiProviderBase.headerRequisition(),
				body: frotaVeiculoTipoModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var frotaVeiculoTipoModelJson = json.decode(response.body);
					return FrotaVeiculoTipoModel.fromJson(frotaVeiculoTipoModelJson);
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

	Future<FrotaVeiculoTipoModel?>? update(FrotaVeiculoTipoModel frotaVeiculoTipoModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/frota-veiculo-tipo')!,
				headers: ApiProviderBase.headerRequisition(),
				body: frotaVeiculoTipoModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var frotaVeiculoTipoModelJson = json.decode(response.body);
					return FrotaVeiculoTipoModel.fromJson(frotaVeiculoTipoModelJson);
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
				Uri.tryParse('$endpoint/frota-veiculo-tipo/$pk')!,
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
