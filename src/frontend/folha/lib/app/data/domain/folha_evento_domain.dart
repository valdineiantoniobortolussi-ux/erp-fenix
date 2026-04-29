class FolhaEventoDomain {
	FolhaEventoDomain._();

	static getBaseCalculo(String? baseCalculo) { 
		switch (baseCalculo) { 
			case '': 
			case '0': 
				return '1=Salário contratual: define que a base de cálculo deve ser calculada sobre o valor do salário contratual'; 
			case '1': 
				return '2=Salário mínimo: define que a base de cálculo deve ser calculada sobre o valor do salário mínimo'; 
			case '2': 
				return '3=Piso Salarial: define que a base de cálculo deve ser calculada sobre o valor do piso salarial definido no cadastro de sindicatos'; 
			case '3': 
				return '4=Líquido: define que a base de cálculo deve ser calculada sobre o líquido da folha'; 
			default: 
				return null; 
		} 
	} 

	static setBaseCalculo(String? baseCalculo) { 
		switch (baseCalculo) { 
			case '1=Salário contratual: define que a base de cálculo deve ser calculada sobre o valor do salário contratual': 
				return '0'; 
			case '2=Salário mínimo: define que a base de cálculo deve ser calculada sobre o valor do salário mínimo': 
				return '1'; 
			case '3=Piso Salarial: define que a base de cálculo deve ser calculada sobre o valor do piso salarial definido no cadastro de sindicatos': 
				return '2'; 
			case '4=Líquido: define que a base de cálculo deve ser calculada sobre o líquido da folha': 
				return '3'; 
			default: 
				return null; 
		} 
	}

	static getTipo(String? tipo) { 
		switch (tipo) { 
			case '': 
			case 'P': 
				return 'Provento'; 
			case 'D': 
				return 'Desconto'; 
			default: 
				return null; 
		} 
	} 

	static setTipo(String? tipo) { 
		switch (tipo) { 
			case 'Provento': 
				return 'P'; 
			case 'Desconto': 
				return 'D'; 
			default: 
				return null; 
		} 
	}

	static getUnidade(String? unidade) { 
		switch (unidade) { 
			case '': 
			case 'V': 
				return 'Valor'; 
			case 'P': 
				return 'Percentual'; 
			default: 
				return null; 
		} 
	} 

	static setUnidade(String? unidade) { 
		switch (unidade) { 
			case 'Valor': 
				return 'V'; 
			case 'Percentual': 
				return 'P'; 
			default: 
				return null; 
		} 
	}

	static getRepercuteDsr(String? repercuteDsr) { 
		switch (repercuteDsr) { 
			case '': 
			case 'S': 
				return 'Sim'; 
			case 'N': 
				return 'Não'; 
			default: 
				return null; 
		} 
	} 

	static setRepercuteDsr(String? repercuteDsr) { 
		switch (repercuteDsr) { 
			case 'Sim': 
				return 'S'; 
			case 'Não': 
				return 'N'; 
			default: 
				return null; 
		} 
	}

	static getRepercute13(String? repercute13) { 
		switch (repercute13) { 
			case '': 
			case 'S': 
				return 'Sim'; 
			case 'N': 
				return 'Não'; 
			default: 
				return null; 
		} 
	} 

	static setRepercute13(String? repercute13) { 
		switch (repercute13) { 
			case 'Sim': 
				return 'S'; 
			case 'Não': 
				return 'N'; 
			default: 
				return null; 
		} 
	}

	static getRepercuteFerias(String? repercuteFerias) { 
		switch (repercuteFerias) { 
			case '': 
			case 'S': 
				return 'Sim'; 
			case 'N': 
				return 'Não'; 
			default: 
				return null; 
		} 
	} 

	static setRepercuteFerias(String? repercuteFerias) { 
		switch (repercuteFerias) { 
			case 'Sim': 
				return 'S'; 
			case 'Não': 
				return 'N'; 
			default: 
				return null; 
		} 
	}

	static getRepercuteAviso(String? repercuteAviso) { 
		switch (repercuteAviso) { 
			case '': 
			case 'S': 
				return 'Sim'; 
			case 'N': 
				return 'Não'; 
			default: 
				return null; 
		} 
	} 

	static setRepercuteAviso(String? repercuteAviso) { 
		switch (repercuteAviso) { 
			case 'Sim': 
				return 'S'; 
			case 'Não': 
				return 'N'; 
			default: 
				return null; 
		} 
	}

}