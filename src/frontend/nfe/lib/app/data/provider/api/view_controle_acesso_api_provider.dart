import 'dart:convert';
import 'package:nfe/app/data/provider/api/api_provider_base.dart';
import 'package:nfe/app/data/model/model_imports.dart';

class ViewControleAcessoApiProvider extends ApiProviderBase {

	Future<List<ViewControleAcessoModel>?> getList({Filter? filter}) async {
		List<ViewControleAcessoModel> viewControleAcessoModelList = [];

		try {
			handleFilter(filter, '/view-controle-acesso/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var viewControleAcessoModelJson = json.decode(response.body) as List<dynamic>;
					for (var viewControleAcessoModel in viewControleAcessoModelJson) {
						viewControleAcessoModelList.add(ViewControleAcessoModel.fromJson(viewControleAcessoModel));
					}
					return viewControleAcessoModelList;
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

	Future<ViewControleAcessoModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/view-controle-acesso/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var viewControleAcessoModelJson = json.decode(response.body);
					return ViewControleAcessoModel.fromJson(viewControleAcessoModelJson);		 
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

	Future<ViewControleAcessoModel?>? insert(ViewControleAcessoModel viewControleAcessoModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/view-controle-acesso')!,
				headers: ApiProviderBase.headerRequisition(),
				body: viewControleAcessoModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var viewControleAcessoModelJson = json.decode(response.body);
					return ViewControleAcessoModel.fromJson(viewControleAcessoModelJson);
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

	Future<ViewControleAcessoModel?>? update(ViewControleAcessoModel viewControleAcessoModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/view-controle-acesso')!,
				headers: ApiProviderBase.headerRequisition(),
				body: viewControleAcessoModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var viewControleAcessoModelJson = json.decode(response.body);
					return ViewControleAcessoModel.fromJson(viewControleAcessoModelJson);
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
				Uri.tryParse('$endpoint/view-controle-acesso/$pk')!,
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
