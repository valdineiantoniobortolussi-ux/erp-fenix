import 'dart:convert';
import 'package:mdfe/app/data/provider/api/api_provider_base.dart';
import 'package:mdfe/app/data/model/model_imports.dart';

class MdfeRodoviarioPedagioApiProvider extends ApiProviderBase {

	Future<List<MdfeRodoviarioPedagioModel>?> getList({Filter? filter}) async {
		List<MdfeRodoviarioPedagioModel> mdfeRodoviarioPedagioModelList = [];

		try {
			handleFilter(filter, '/mdfe-rodoviario-pedagio/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var mdfeRodoviarioPedagioModelJson = json.decode(response.body) as List<dynamic>;
					for (var mdfeRodoviarioPedagioModel in mdfeRodoviarioPedagioModelJson) {
						mdfeRodoviarioPedagioModelList.add(MdfeRodoviarioPedagioModel.fromJson(mdfeRodoviarioPedagioModel));
					}
					return mdfeRodoviarioPedagioModelList;
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

	Future<MdfeRodoviarioPedagioModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/mdfe-rodoviario-pedagio/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var mdfeRodoviarioPedagioModelJson = json.decode(response.body);
					return MdfeRodoviarioPedagioModel.fromJson(mdfeRodoviarioPedagioModelJson);		 
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

	Future<MdfeRodoviarioPedagioModel?>? insert(MdfeRodoviarioPedagioModel mdfeRodoviarioPedagioModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/mdfe-rodoviario-pedagio')!,
				headers: ApiProviderBase.headerRequisition(),
				body: mdfeRodoviarioPedagioModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var mdfeRodoviarioPedagioModelJson = json.decode(response.body);
					return MdfeRodoviarioPedagioModel.fromJson(mdfeRodoviarioPedagioModelJson);
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

	Future<MdfeRodoviarioPedagioModel?>? update(MdfeRodoviarioPedagioModel mdfeRodoviarioPedagioModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/mdfe-rodoviario-pedagio')!,
				headers: ApiProviderBase.headerRequisition(),
				body: mdfeRodoviarioPedagioModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var mdfeRodoviarioPedagioModelJson = json.decode(response.body);
					return MdfeRodoviarioPedagioModel.fromJson(mdfeRodoviarioPedagioModelJson);
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
				Uri.tryParse('$endpoint/mdfe-rodoviario-pedagio/$pk')!,
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
