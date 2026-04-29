import 'dart:convert';
import 'package:nfe/app/data/provider/api/api_provider_base.dart';
import 'package:nfe/app/data/model/model_imports.dart';

class ViewPessoaVendedorApiProvider extends ApiProviderBase {

	Future<List<ViewPessoaVendedorModel>?> getList({Filter? filter}) async {
		List<ViewPessoaVendedorModel> viewPessoaVendedorModelList = [];

		try {
			handleFilter(filter, '/view-pessoa-vendedor/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var viewPessoaVendedorModelJson = json.decode(response.body) as List<dynamic>;
					for (var viewPessoaVendedorModel in viewPessoaVendedorModelJson) {
						viewPessoaVendedorModelList.add(ViewPessoaVendedorModel.fromJson(viewPessoaVendedorModel));
					}
					return viewPessoaVendedorModelList;
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

	Future<ViewPessoaVendedorModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/view-pessoa-vendedor/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var viewPessoaVendedorModelJson = json.decode(response.body);
					return ViewPessoaVendedorModel.fromJson(viewPessoaVendedorModelJson);		 
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

	Future<ViewPessoaVendedorModel?>? insert(ViewPessoaVendedorModel viewPessoaVendedorModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/view-pessoa-vendedor')!,
				headers: ApiProviderBase.headerRequisition(),
				body: viewPessoaVendedorModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var viewPessoaVendedorModelJson = json.decode(response.body);
					return ViewPessoaVendedorModel.fromJson(viewPessoaVendedorModelJson);
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

	Future<ViewPessoaVendedorModel?>? update(ViewPessoaVendedorModel viewPessoaVendedorModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/view-pessoa-vendedor')!,
				headers: ApiProviderBase.headerRequisition(),
				body: viewPessoaVendedorModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var viewPessoaVendedorModelJson = json.decode(response.body);
					return ViewPessoaVendedorModel.fromJson(viewPessoaVendedorModelJson);
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
				Uri.tryParse('$endpoint/view-pessoa-vendedor/$pk')!,
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
