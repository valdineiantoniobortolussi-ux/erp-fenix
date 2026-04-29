import 'package:drift/drift.dart';
import 'package:ordem_servico/app/data/provider/drift/database/database.dart';
import 'package:ordem_servico/app/data/provider/drift/database/database_imports.dart';

part 'os_abertura_dao.g.dart';

@DriftAccessor(tables: [
	OsAberturas,
	OsAberturaEquipamentos,
	OsEquipamentos,
	OsProdutoServicos,
	Produtos,
	OsEvolucaos,
	ViewPessoaClientes,
	ViewPessoaColaboradors,
	OsStatuss,
])
class OsAberturaDao extends DatabaseAccessor<AppDatabase> with _$OsAberturaDaoMixin {
	final AppDatabase db;

	List<OsAbertura> osAberturaList = []; 
	List<OsAberturaGrouped> osAberturaGroupedList = []; 

	OsAberturaDao(this.db) : super(db);

	Future<List<OsAbertura>> getList() async {
		osAberturaList = await select(osAberturas).get();
		return osAberturaList;
	}

	Future<List<OsAbertura>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		osAberturaList = await (select(osAberturas)..where((t) => expression)).get();
		return osAberturaList;	 
	}

	Future<List<OsAberturaGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(osAberturas)
			.join([ 
				leftOuterJoin(viewPessoaClientes, viewPessoaClientes.id.equalsExp(osAberturas.idCliente)), 
			]).join([ 
				leftOuterJoin(viewPessoaColaboradors, viewPessoaColaboradors.id.equalsExp(osAberturas.idColaborador)), 
			]).join([ 
				leftOuterJoin(osStatuss, osStatuss.id.equalsExp(osAberturas.idOsStatus)), 
			]);

		if (field != null && field != '') { 
			final column = osAberturas.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		osAberturaGroupedList = await query.map((row) {
			final osAbertura = row.readTableOrNull(osAberturas); 
			final viewPessoaCliente = row.readTableOrNull(viewPessoaClientes); 
			final viewPessoaColaborador = row.readTableOrNull(viewPessoaColaboradors); 
			final osStatus = row.readTableOrNull(osStatuss); 

			return OsAberturaGrouped(
				osAbertura: osAbertura, 
				viewPessoaCliente: viewPessoaCliente, 
				viewPessoaColaborador: viewPessoaColaborador, 
				osStatus: osStatus, 

			);
		}).get();

		// fill internal lists
		dynamic expression;
		for (var osAberturaGrouped in osAberturaGroupedList) {
			osAberturaGrouped.osAberturaEquipamentoGroupedList = [];
			final queryOsAberturaEquipamento = ' id_os_abertura = ${osAberturaGrouped.osAbertura!.id}';
			expression = CustomExpression<bool>(queryOsAberturaEquipamento);
			final osAberturaEquipamentoList = await (select(osAberturaEquipamentos)..where((t) => expression)).get();
			for (var osAberturaEquipamento in osAberturaEquipamentoList) {
				OsAberturaEquipamentoGrouped osAberturaEquipamentoGrouped = OsAberturaEquipamentoGrouped(
					osAberturaEquipamento: osAberturaEquipamento,
					osEquipamento: await (select(osEquipamentos)..where((t) => t.id.equals(osAberturaEquipamento.idOsEquipamento!))).getSingleOrNull(),
				);
				osAberturaGrouped.osAberturaEquipamentoGroupedList!.add(osAberturaEquipamentoGrouped);
			}

			osAberturaGrouped.osProdutoServicoGroupedList = [];
			final queryOsProdutoServico = ' id_os_abertura = ${osAberturaGrouped.osAbertura!.id}';
			expression = CustomExpression<bool>(queryOsProdutoServico);
			final osProdutoServicoList = await (select(osProdutoServicos)..where((t) => expression)).get();
			for (var osProdutoServico in osProdutoServicoList) {
				OsProdutoServicoGrouped osProdutoServicoGrouped = OsProdutoServicoGrouped(
					osProdutoServico: osProdutoServico,
					produto: await (select(produtos)..where((t) => t.id.equals(osProdutoServico.idProduto!))).getSingleOrNull(),
				);
				osAberturaGrouped.osProdutoServicoGroupedList!.add(osProdutoServicoGrouped);
			}

			osAberturaGrouped.osEvolucaoGroupedList = [];
			final queryOsEvolucao = ' id_os_abertura = ${osAberturaGrouped.osAbertura!.id}';
			expression = CustomExpression<bool>(queryOsEvolucao);
			final osEvolucaoList = await (select(osEvolucaos)..where((t) => expression)).get();
			for (var osEvolucao in osEvolucaoList) {
				OsEvolucaoGrouped osEvolucaoGrouped = OsEvolucaoGrouped(
					osEvolucao: osEvolucao,
				);
				osAberturaGrouped.osEvolucaoGroupedList!.add(osEvolucaoGrouped);
			}

		}		

		return osAberturaGroupedList;	
	}

	Future<OsAbertura?> getObject(dynamic pk) async {
		return await (select(osAberturas)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<OsAbertura?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM os_abertura WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as OsAbertura;		 
	} 

	Future<OsAberturaGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(OsAberturaGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.osAbertura = object.osAbertura!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(osAberturas).insert(object.osAbertura!);
			object.osAbertura = object.osAbertura!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(OsAberturaGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(osAberturas).replace(object.osAbertura!);
		});	 
	} 

	Future<int> deleteObject(OsAberturaGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(osAberturas).delete(object.osAbertura!);
		});		
	}

	Future<void> insertChildren(OsAberturaGrouped object) async {
		for (var osAberturaEquipamentoGrouped in object.osAberturaEquipamentoGroupedList!) {
			osAberturaEquipamentoGrouped.osAberturaEquipamento = osAberturaEquipamentoGrouped.osAberturaEquipamento?.copyWith(
				id: const Value(null),
				idOsAbertura: Value(object.osAbertura!.id),
			);
			await into(osAberturaEquipamentos).insert(osAberturaEquipamentoGrouped.osAberturaEquipamento!);
		}
		for (var osProdutoServicoGrouped in object.osProdutoServicoGroupedList!) {
			osProdutoServicoGrouped.osProdutoServico = osProdutoServicoGrouped.osProdutoServico?.copyWith(
				id: const Value(null),
				idOsAbertura: Value(object.osAbertura!.id),
			);
			await into(osProdutoServicos).insert(osProdutoServicoGrouped.osProdutoServico!);
		}
		for (var osEvolucaoGrouped in object.osEvolucaoGroupedList!) {
			osEvolucaoGrouped.osEvolucao = osEvolucaoGrouped.osEvolucao?.copyWith(
				id: const Value(null),
				idOsAbertura: Value(object.osAbertura!.id),
			);
			await into(osEvolucaos).insert(osEvolucaoGrouped.osEvolucao!);
		}
	}
	
	Future<void> deleteChildren(OsAberturaGrouped object) async {
		await (delete(osAberturaEquipamentos)..where((t) => t.idOsAbertura.equals(object.osAbertura!.id!))).go();
		await (delete(osProdutoServicos)..where((t) => t.idOsAbertura.equals(object.osAbertura!.id!))).go();
		await (delete(osEvolucaos)..where((t) => t.idOsAbertura.equals(object.osAbertura!.id!))).go();
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from os_abertura").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}