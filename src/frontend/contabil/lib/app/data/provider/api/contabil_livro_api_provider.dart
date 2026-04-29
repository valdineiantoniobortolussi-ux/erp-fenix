import 'dart:convert';
import 'package:contabil/app/data/provider/api/api_provider_base.dart';
import 'package:contabil/app/data/model/model_imports.dart';

class ContabilLivroApiProvider extends ApiProviderBase {

	Future<List<ContabilLivroModel>?> getList({Filter? filter}) async {
		List<ContabilLivroModel> contabilLivroModelList = [];

		try {
			handleFilter(filter, '/contabil-livro/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var contabilLivroModelJson = json.decode(response.body) as List<dynamic>;
					for (var contabilLivroModel in contabilLivroModelJson) {
						contabilLivroModelList.add(ContabilLivroModel.fromJson(contabilLivroModel));
					}
					return contabilLivroModelList;
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

	Future<ContabilLivroModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/contabil-livro/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var contabilLivroModelJson = json.decode(response.body);
					return ContabilLivroModel.fromJson(contabilLivroModelJson);		 
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

	Future<ContabilLivroModel?>? insert(ContabilLivroModel contabilLivroModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/contabil-livro')!,
				headers: ApiProviderBase.headerRequisition(),
				body: contabilLivroModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var contabilLivroModelJson = json.decode(response.body);
					return ContabilLivroModel.fromJson(contabilLivroModelJson);
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

	Future<ContabilLivroModel?>? update(ContabilLivroModel contabilLivroModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/contabil-livro')!,
				headers: ApiProviderBase.headerRequisition(),
				body: contabilLivroModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var contabilLivroModelJson = json.decode(response.body);
					return ContabilLivroModel.fromJson(contabilLivroModelJson);
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
				Uri.tryParse('$endpoint/contabil-livro/$pk')!,
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
