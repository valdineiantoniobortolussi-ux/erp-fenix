import 'dart:convert';
import 'package:mdfe/app/data/provider/api/api_provider_base.dart';
import 'package:mdfe/app/data/model/model_imports.dart';

class MdfeRodoviarioMotoristaApiProvider extends ApiProviderBase {

	Future<List<MdfeRodoviarioMotoristaModel>?> getList({Filter? filter}) async {
		List<MdfeRodoviarioMotoristaModel> mdfeRodoviarioMotoristaModelList = [];

		try {
			handleFilter(filter, '/mdfe-rodoviario-motorista/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var mdfeRodoviarioMotoristaModelJson = json.decode(response.body) as List<dynamic>;
					for (var mdfeRodoviarioMotoristaModel in mdfeRodoviarioMotoristaModelJson) {
						mdfeRodoviarioMotoristaModelList.add(MdfeRodoviarioMotoristaModel.fromJson(mdfeRodoviarioMotoristaModel));
					}
					return mdfeRodoviarioMotoristaModelList;
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

	Future<MdfeRodoviarioMotoristaModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/mdfe-rodoviario-motorista/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var mdfeRodoviarioMotoristaModelJson = json.decode(response.body);
					return MdfeRodoviarioMotoristaModel.fromJson(mdfeRodoviarioMotoristaModelJson);		 
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

	Future<MdfeRodoviarioMotoristaModel?>? insert(MdfeRodoviarioMotoristaModel mdfeRodoviarioMotoristaModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/mdfe-rodoviario-motorista')!,
				headers: ApiProviderBase.headerRequisition(),
				body: mdfeRodoviarioMotoristaModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var mdfeRodoviarioMotoristaModelJson = json.decode(response.body);
					return MdfeRodoviarioMotoristaModel.fromJson(mdfeRodoviarioMotoristaModelJson);
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

	Future<MdfeRodoviarioMotoristaModel?>? update(MdfeRodoviarioMotoristaModel mdfeRodoviarioMotoristaModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/mdfe-rodoviario-motorista')!,
				headers: ApiProviderBase.headerRequisition(),
				body: mdfeRodoviarioMotoristaModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var mdfeRodoviarioMotoristaModelJson = json.decode(response.body);
					return MdfeRodoviarioMotoristaModel.fromJson(mdfeRodoviarioMotoristaModelJson);
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
				Uri.tryParse('$endpoint/mdfe-rodoviario-motorista/$pk')!,
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
