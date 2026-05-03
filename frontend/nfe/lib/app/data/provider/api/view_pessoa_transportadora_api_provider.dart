import 'dart:convert';
import 'package:nfe/app/data/provider/api/api_provider_base.dart';
import 'package:nfe/app/data/model/model_imports.dart';

class ViewPessoaTransportadoraApiProvider extends ApiProviderBase {

	Future<List<ViewPessoaTransportadoraModel>?> getList({Filter? filter}) async {
		List<ViewPessoaTransportadoraModel> viewPessoaTransportadoraModelList = [];

		try {
			handleFilter(filter, '/view-pessoa-transportadora/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var viewPessoaTransportadoraModelJson = json.decode(response.body) as List<dynamic>;
					for (var viewPessoaTransportadoraModel in viewPessoaTransportadoraModelJson) {
						viewPessoaTransportadoraModelList.add(ViewPessoaTransportadoraModel.fromJson(viewPessoaTransportadoraModel));
					}
					return viewPessoaTransportadoraModelList;
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

	Future<ViewPessoaTransportadoraModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/view-pessoa-transportadora/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var viewPessoaTransportadoraModelJson = json.decode(response.body);
					return ViewPessoaTransportadoraModel.fromJson(viewPessoaTransportadoraModelJson);		 
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

	Future<ViewPessoaTransportadoraModel?>? insert(ViewPessoaTransportadoraModel viewPessoaTransportadoraModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/view-pessoa-transportadora')!,
				headers: ApiProviderBase.headerRequisition(),
				body: viewPessoaTransportadoraModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var viewPessoaTransportadoraModelJson = json.decode(response.body);
					return ViewPessoaTransportadoraModel.fromJson(viewPessoaTransportadoraModelJson);
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

	Future<ViewPessoaTransportadoraModel?>? update(ViewPessoaTransportadoraModel viewPessoaTransportadoraModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/view-pessoa-transportadora')!,
				headers: ApiProviderBase.headerRequisition(),
				body: viewPessoaTransportadoraModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var viewPessoaTransportadoraModelJson = json.decode(response.body);
					return ViewPessoaTransportadoraModel.fromJson(viewPessoaTransportadoraModelJson);
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
				Uri.tryParse('$endpoint/view-pessoa-transportadora/$pk')!,
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
