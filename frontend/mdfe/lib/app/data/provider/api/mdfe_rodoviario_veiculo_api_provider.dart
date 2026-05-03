import 'dart:convert';
import 'package:mdfe/app/data/provider/api/api_provider_base.dart';
import 'package:mdfe/app/data/model/model_imports.dart';

class MdfeRodoviarioVeiculoApiProvider extends ApiProviderBase {

	Future<List<MdfeRodoviarioVeiculoModel>?> getList({Filter? filter}) async {
		List<MdfeRodoviarioVeiculoModel> mdfeRodoviarioVeiculoModelList = [];

		try {
			handleFilter(filter, '/mdfe-rodoviario-veiculo/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var mdfeRodoviarioVeiculoModelJson = json.decode(response.body) as List<dynamic>;
					for (var mdfeRodoviarioVeiculoModel in mdfeRodoviarioVeiculoModelJson) {
						mdfeRodoviarioVeiculoModelList.add(MdfeRodoviarioVeiculoModel.fromJson(mdfeRodoviarioVeiculoModel));
					}
					return mdfeRodoviarioVeiculoModelList;
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

	Future<MdfeRodoviarioVeiculoModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/mdfe-rodoviario-veiculo/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var mdfeRodoviarioVeiculoModelJson = json.decode(response.body);
					return MdfeRodoviarioVeiculoModel.fromJson(mdfeRodoviarioVeiculoModelJson);		 
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

	Future<MdfeRodoviarioVeiculoModel?>? insert(MdfeRodoviarioVeiculoModel mdfeRodoviarioVeiculoModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/mdfe-rodoviario-veiculo')!,
				headers: ApiProviderBase.headerRequisition(),
				body: mdfeRodoviarioVeiculoModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var mdfeRodoviarioVeiculoModelJson = json.decode(response.body);
					return MdfeRodoviarioVeiculoModel.fromJson(mdfeRodoviarioVeiculoModelJson);
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

	Future<MdfeRodoviarioVeiculoModel?>? update(MdfeRodoviarioVeiculoModel mdfeRodoviarioVeiculoModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/mdfe-rodoviario-veiculo')!,
				headers: ApiProviderBase.headerRequisition(),
				body: mdfeRodoviarioVeiculoModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var mdfeRodoviarioVeiculoModelJson = json.decode(response.body);
					return MdfeRodoviarioVeiculoModel.fromJson(mdfeRodoviarioVeiculoModelJson);
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
				Uri.tryParse('$endpoint/mdfe-rodoviario-veiculo/$pk')!,
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
