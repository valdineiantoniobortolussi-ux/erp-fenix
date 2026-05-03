import 'dart:convert';
import 'package:nfe/app/data/provider/api/api_provider_base.dart';
import 'package:nfe/app/data/model/model_imports.dart';

class ViewPessoaClienteApiProvider extends ApiProviderBase {

	Future<List<ViewPessoaClienteModel>?> getList({Filter? filter}) async {
		List<ViewPessoaClienteModel> viewPessoaClienteModelList = [];

		try {
			handleFilter(filter, '/view-pessoa-cliente/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var viewPessoaClienteModelJson = json.decode(response.body) as List<dynamic>;
					for (var viewPessoaClienteModel in viewPessoaClienteModelJson) {
						viewPessoaClienteModelList.add(ViewPessoaClienteModel.fromJson(viewPessoaClienteModel));
					}
					return viewPessoaClienteModelList;
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

	Future<ViewPessoaClienteModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/view-pessoa-cliente/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var viewPessoaClienteModelJson = json.decode(response.body);
					return ViewPessoaClienteModel.fromJson(viewPessoaClienteModelJson);		 
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

	Future<ViewPessoaClienteModel?>? insert(ViewPessoaClienteModel viewPessoaClienteModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/view-pessoa-cliente')!,
				headers: ApiProviderBase.headerRequisition(),
				body: viewPessoaClienteModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var viewPessoaClienteModelJson = json.decode(response.body);
					return ViewPessoaClienteModel.fromJson(viewPessoaClienteModelJson);
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

	Future<ViewPessoaClienteModel?>? update(ViewPessoaClienteModel viewPessoaClienteModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/view-pessoa-cliente')!,
				headers: ApiProviderBase.headerRequisition(),
				body: viewPessoaClienteModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var viewPessoaClienteModelJson = json.decode(response.body);
					return ViewPessoaClienteModel.fromJson(viewPessoaClienteModelJson);
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
				Uri.tryParse('$endpoint/view-pessoa-cliente/$pk')!,
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
