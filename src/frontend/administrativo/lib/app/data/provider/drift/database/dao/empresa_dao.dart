import 'package:drift/drift.dart';
import 'package:administrativo/app/data/provider/drift/database/database.dart';
import 'package:administrativo/app/data/provider/drift/database/database_imports.dart';

part 'empresa_dao.g.dart';

@DriftAccessor(tables: [
	Empresas,
	EmpresaContatos,
	EmpresaTelefones,
	EmpresaCnaes,
	Cnaes,
	EmpresaEnderecos,
])
class EmpresaDao extends DatabaseAccessor<AppDatabase> with _$EmpresaDaoMixin {
	final AppDatabase db;

	List<Empresa> empresaList = []; 
	List<EmpresaGrouped> empresaGroupedList = []; 

	EmpresaDao(this.db) : super(db);

	Future<List<Empresa>> getList() async {
		empresaList = await select(empresas).get();
		return empresaList;
	}

	Future<List<Empresa>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		empresaList = await (select(empresas)..where((t) => expression)).get();
		return empresaList;	 
	}

	Future<List<EmpresaGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(empresas)
			.join([]);

		if (field != null && field != '') { 
			final column = empresas.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		empresaGroupedList = await query.map((row) {
			final empresa = row.readTableOrNull(empresas); 

			return EmpresaGrouped(
				empresa: empresa, 

			);
		}).get();

		// fill internal lists
		dynamic expression;
		for (var empresaGrouped in empresaGroupedList) {
			empresaGrouped.empresaContatoGroupedList = [];
			final queryEmpresaContato = ' id_empresa = ${empresaGrouped.empresa!.id}';
			expression = CustomExpression<bool>(queryEmpresaContato);
			final empresaContatoList = await (select(empresaContatos)..where((t) => expression)).get();
			for (var empresaContato in empresaContatoList) {
				EmpresaContatoGrouped empresaContatoGrouped = EmpresaContatoGrouped(
					empresaContato: empresaContato,
				);
				empresaGrouped.empresaContatoGroupedList!.add(empresaContatoGrouped);
			}

			empresaGrouped.empresaTelefoneGroupedList = [];
			final queryEmpresaTelefone = ' id_empresa = ${empresaGrouped.empresa!.id}';
			expression = CustomExpression<bool>(queryEmpresaTelefone);
			final empresaTelefoneList = await (select(empresaTelefones)..where((t) => expression)).get();
			for (var empresaTelefone in empresaTelefoneList) {
				EmpresaTelefoneGrouped empresaTelefoneGrouped = EmpresaTelefoneGrouped(
					empresaTelefone: empresaTelefone,
				);
				empresaGrouped.empresaTelefoneGroupedList!.add(empresaTelefoneGrouped);
			}

			empresaGrouped.empresaCnaeGroupedList = [];
			final queryEmpresaCnae = ' id_empresa = ${empresaGrouped.empresa!.id}';
			expression = CustomExpression<bool>(queryEmpresaCnae);
			final empresaCnaeList = await (select(empresaCnaes)..where((t) => expression)).get();
			for (var empresaCnae in empresaCnaeList) {
				EmpresaCnaeGrouped empresaCnaeGrouped = EmpresaCnaeGrouped(
					empresaCnae: empresaCnae,
					cnae: await (select(cnaes)..where((t) => t.id.equals(empresaCnae.idCnae!))).getSingleOrNull(),
				);
				empresaGrouped.empresaCnaeGroupedList!.add(empresaCnaeGrouped);
			}

			empresaGrouped.empresaEnderecoGroupedList = [];
			final queryEmpresaEndereco = ' id_empresa = ${empresaGrouped.empresa!.id}';
			expression = CustomExpression<bool>(queryEmpresaEndereco);
			final empresaEnderecoList = await (select(empresaEnderecos)..where((t) => expression)).get();
			for (var empresaEndereco in empresaEnderecoList) {
				EmpresaEnderecoGrouped empresaEnderecoGrouped = EmpresaEnderecoGrouped(
					empresaEndereco: empresaEndereco,
				);
				empresaGrouped.empresaEnderecoGroupedList!.add(empresaEnderecoGrouped);
			}

		}		

		return empresaGroupedList;	
	}

	Future<Empresa?> getObject(dynamic pk) async {
		return await (select(empresas)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<Empresa?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM empresa WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as Empresa;		 
	} 

	Future<EmpresaGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(EmpresaGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.empresa = object.empresa!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(empresas).insert(object.empresa!);
			object.empresa = object.empresa!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(EmpresaGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(empresas).replace(object.empresa!);
		});	 
	} 

	Future<int> deleteObject(EmpresaGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(empresas).delete(object.empresa!);
		});		
	}

	Future<void> insertChildren(EmpresaGrouped object) async {
		for (var empresaContatoGrouped in object.empresaContatoGroupedList!) {
			empresaContatoGrouped.empresaContato = empresaContatoGrouped.empresaContato?.copyWith(
				id: const Value(null),
				idEmpresa: Value(object.empresa!.id),
			);
			await into(empresaContatos).insert(empresaContatoGrouped.empresaContato!);
		}
		for (var empresaTelefoneGrouped in object.empresaTelefoneGroupedList!) {
			empresaTelefoneGrouped.empresaTelefone = empresaTelefoneGrouped.empresaTelefone?.copyWith(
				id: const Value(null),
				idEmpresa: Value(object.empresa!.id),
			);
			await into(empresaTelefones).insert(empresaTelefoneGrouped.empresaTelefone!);
		}
		for (var empresaCnaeGrouped in object.empresaCnaeGroupedList!) {
			empresaCnaeGrouped.empresaCnae = empresaCnaeGrouped.empresaCnae?.copyWith(
				id: const Value(null),
				idEmpresa: Value(object.empresa!.id),
			);
			await into(empresaCnaes).insert(empresaCnaeGrouped.empresaCnae!);
		}
		for (var empresaEnderecoGrouped in object.empresaEnderecoGroupedList!) {
			empresaEnderecoGrouped.empresaEndereco = empresaEnderecoGrouped.empresaEndereco?.copyWith(
				id: const Value(null),
				idEmpresa: Value(object.empresa!.id),
			);
			await into(empresaEnderecos).insert(empresaEnderecoGrouped.empresaEndereco!);
		}
	}
	
	Future<void> deleteChildren(EmpresaGrouped object) async {
		await (delete(empresaContatos)..where((t) => t.idEmpresa.equals(object.empresa!.id!))).go();
		await (delete(empresaTelefones)..where((t) => t.idEmpresa.equals(object.empresa!.id!))).go();
		await (delete(empresaCnaes)..where((t) => t.idEmpresa.equals(object.empresa!.id!))).go();
		await (delete(empresaEnderecos)..where((t) => t.idEmpresa.equals(object.empresa!.id!))).go();
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from empresa").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}