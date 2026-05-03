import 'dart:convert';
import 'package:nfe/app/data/provider/api/api_provider_base.dart';
import 'package:nfe/app/data/model/model_imports.dart';

class ViewPessoaColaboradorApiProvider extends ApiProviderBase {

	Future<List<ViewPessoaColaboradorModel>?> getList({Filter? filter}) async {
		List<ViewPessoaColaboradorModel> viewPessoaColaboradorModelList = [];

		try {
			handleFilter(filter, '/view-pessoa-colaborador/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var viewPessoaColaboradorModelJson = json.decode(response.body) as List<dynamic>;
					for (var viewPessoaColaboradorModel in viewPessoaColaboradorModelJson) {
						viewPessoaColaboradorModelList.add(ViewPessoaColaboradorModel.fromJson(viewPessoaColaboradorModel));
					}
					return viewPessoaColaboradorModelList;
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

	Future<ViewPessoaColaboradorModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/view-pessoa-colaborador/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var viewPessoaColaboradorModelJson = json.decode(response.body);
					return ViewPessoaColaboradorModel.fromJson(viewPessoaColaboradorModelJson);		 
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

	Future<ViewPessoaColaboradorModel?>? insert(ViewPessoaColaboradorModel viewPessoaColaboradorModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/view-pessoa-colaborador')!,
				headers: ApiProviderBase.headerRequisition(),
				body: viewPessoaColaboradorModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var viewPessoaColaboradorModelJson = json.decode(response.body);
					return ViewPessoaColaboradorModel.fromJson(viewPessoaColaboradorModelJson);
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

	Future<ViewPessoaColaboradorModel?>? update(ViewPessoaColaboradorModel viewPessoaColaboradorModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/view-pessoa-colaborador')!,
				headers: ApiProviderBase.headerRequisition(),
				body: viewPessoaColaboradorModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var viewPessoaColaboradorModelJson = json.decode(response.body);
					return ViewPessoaColaboradorModel.fromJson(viewPessoaColaboradorModelJson);
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
				Uri.tryParse('$endpoint/view-pessoa-colaborador/$pk')!,
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
