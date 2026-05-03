import 'dart:convert';
import 'package:comissoes/app/data/provider/api/api_provider_base.dart';
import 'package:comissoes/app/data/model/model_imports.dart';

class ComissaoObjetivoApiProvider extends ApiProviderBase {

	Future<List<ComissaoObjetivoModel>?> getList({Filter? filter}) async {
		List<ComissaoObjetivoModel> comissaoObjetivoModelList = [];

		try {
			handleFilter(filter, '/comissao-objetivo/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var comissaoObjetivoModelJson = json.decode(response.body) as List<dynamic>;
					for (var comissaoObjetivoModel in comissaoObjetivoModelJson) {
						comissaoObjetivoModelList.add(ComissaoObjetivoModel.fromJson(comissaoObjetivoModel));
					}
					return comissaoObjetivoModelList;
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

	Future<ComissaoObjetivoModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/comissao-objetivo/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var comissaoObjetivoModelJson = json.decode(response.body);
					return ComissaoObjetivoModel.fromJson(comissaoObjetivoModelJson);		 
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

	Future<ComissaoObjetivoModel?>? insert(ComissaoObjetivoModel comissaoObjetivoModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/comissao-objetivo')!,
				headers: ApiProviderBase.headerRequisition(),
				body: comissaoObjetivoModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var comissaoObjetivoModelJson = json.decode(response.body);
					return ComissaoObjetivoModel.fromJson(comissaoObjetivoModelJson);
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

	Future<ComissaoObjetivoModel?>? update(ComissaoObjetivoModel comissaoObjetivoModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/comissao-objetivo')!,
				headers: ApiProviderBase.headerRequisition(),
				body: comissaoObjetivoModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var comissaoObjetivoModelJson = json.decode(response.body);
					return ComissaoObjetivoModel.fromJson(comissaoObjetivoModelJson);
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
				Uri.tryParse('$endpoint/comissao-objetivo/$pk')!,
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
