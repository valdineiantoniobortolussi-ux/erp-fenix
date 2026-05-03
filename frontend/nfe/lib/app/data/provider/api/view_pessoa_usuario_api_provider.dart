import 'dart:convert';
import 'package:nfe/app/data/provider/api/api_provider_base.dart';
import 'package:nfe/app/data/model/model_imports.dart';
import 'package:nfe/app/infra/infra_imports.dart';

class ViewPessoaUsuarioApiProvider extends ApiProviderBase {

	Future<List<ViewPessoaUsuarioModel>?> getList({Filter? filter}) async {
		List<ViewPessoaUsuarioModel> viewPessoaUsuarioModelList = [];

		try {
			handleFilter(filter, '/view-pessoa-usuario/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var viewPessoaUsuarioModelJson = json.decode(response.body) as List<dynamic>;
					for (var viewPessoaUsuarioModel in viewPessoaUsuarioModelJson) {
						viewPessoaUsuarioModelList.add(ViewPessoaUsuarioModel.fromJson(viewPessoaUsuarioModel));
					}
					return viewPessoaUsuarioModelList;
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

	Future<ViewPessoaUsuarioModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/view-pessoa-usuario/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var viewPessoaUsuarioModelJson = json.decode(response.body);
					return ViewPessoaUsuarioModel.fromJson(viewPessoaUsuarioModelJson);		 
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

	Future<ViewPessoaUsuarioModel?>? insert(ViewPessoaUsuarioModel viewPessoaUsuarioModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/view-pessoa-usuario')!,
				headers: ApiProviderBase.headerRequisition(),
				body: viewPessoaUsuarioModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var viewPessoaUsuarioModelJson = json.decode(response.body);
					return ViewPessoaUsuarioModel.fromJson(viewPessoaUsuarioModelJson);
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

	Future<ViewPessoaUsuarioModel?>? update(ViewPessoaUsuarioModel viewPessoaUsuarioModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/view-pessoa-usuario')!,
				headers: ApiProviderBase.headerRequisition(),
				body: viewPessoaUsuarioModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var viewPessoaUsuarioModelJson = json.decode(response.body);
					return ViewPessoaUsuarioModel.fromJson(viewPessoaUsuarioModelJson);
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
				Uri.tryParse('$endpoint/view-pessoa-usuario/$pk')!,
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

  Future<ViewPessoaUsuarioModel?> doLogin(ViewPessoaUsuarioModel viewPessoaUsuarioModel) async {
    try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/login')!,
				headers: ApiProviderBase.headerRequisition(),
				body: Util.crypt(viewPessoaUsuarioModel.objectEncodeJson()),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
          final result = json.decode(response.body);
          Session.tokenJWT = Util.decrypt(result["token"]);
					var userModelJson = json.decode(Util.decrypt(result["user"]));
					return ViewPessoaUsuarioModel.fromJson(userModelJson);
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
}
