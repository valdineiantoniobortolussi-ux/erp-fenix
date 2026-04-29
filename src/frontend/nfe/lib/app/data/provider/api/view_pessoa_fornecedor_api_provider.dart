import 'dart:convert';
import 'package:nfe/app/data/provider/api/api_provider_base.dart';
import 'package:nfe/app/data/model/model_imports.dart';

class ViewPessoaFornecedorApiProvider extends ApiProviderBase {

	Future<List<ViewPessoaFornecedorModel>?> getList({Filter? filter}) async {
		List<ViewPessoaFornecedorModel> viewPessoaFornecedorModelList = [];

		try {
			handleFilter(filter, '/view-pessoa-fornecedor/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var viewPessoaFornecedorModelJson = json.decode(response.body) as List<dynamic>;
					for (var viewPessoaFornecedorModel in viewPessoaFornecedorModelJson) {
						viewPessoaFornecedorModelList.add(ViewPessoaFornecedorModel.fromJson(viewPessoaFornecedorModel));
					}
					return viewPessoaFornecedorModelList;
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

	Future<ViewPessoaFornecedorModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/view-pessoa-fornecedor/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var viewPessoaFornecedorModelJson = json.decode(response.body);
					return ViewPessoaFornecedorModel.fromJson(viewPessoaFornecedorModelJson);		 
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

	Future<ViewPessoaFornecedorModel?>? insert(ViewPessoaFornecedorModel viewPessoaFornecedorModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/view-pessoa-fornecedor')!,
				headers: ApiProviderBase.headerRequisition(),
				body: viewPessoaFornecedorModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var viewPessoaFornecedorModelJson = json.decode(response.body);
					return ViewPessoaFornecedorModel.fromJson(viewPessoaFornecedorModelJson);
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

	Future<ViewPessoaFornecedorModel?>? update(ViewPessoaFornecedorModel viewPessoaFornecedorModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/view-pessoa-fornecedor')!,
				headers: ApiProviderBase.headerRequisition(),
				body: viewPessoaFornecedorModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var viewPessoaFornecedorModelJson = json.decode(response.body);
					return ViewPessoaFornecedorModel.fromJson(viewPessoaFornecedorModelJson);
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
				Uri.tryParse('$endpoint/view-pessoa-fornecedor/$pk')!,
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
