class PessoaDomain {
	PessoaDomain._();

	static getTipo(String? tipo) { 
		switch (tipo) { 
			case '': 
			case 'F': 
				return 'Física'; 
			case 'J': 
				return 'Jurídica'; 
			default: 
				return null; 
		} 
	} 

	static setTipo(String? tipo) { 
		switch (tipo) { 
			case 'Física': 
				return 'F'; 
			case 'Jurídica': 
				return 'J'; 
			default: 
				return null; 
		} 
	}

	static getEhCliente(String? ehCliente) { 
		switch (ehCliente) { 
			case '': 
			case 'S': 
				return 'Sim'; 
			case 'N': 
				return 'Não'; 
			default: 
				return null; 
		} 
	} 

	static setEhCliente(String? ehCliente) { 
		switch (ehCliente) { 
			case 'Sim': 
				return 'S'; 
			case 'Não': 
				return 'N'; 
			default: 
				return null; 
		} 
	}

	static getEhFornecedor(String? ehFornecedor) { 
		switch (ehFornecedor) { 
			case '': 
			case 'S': 
				return 'Sim'; 
			case 'N': 
				return 'Não'; 
			default: 
				return null; 
		} 
	} 

	static setEhFornecedor(String? ehFornecedor) { 
		switch (ehFornecedor) { 
			case 'Sim': 
				return 'S'; 
			case 'Não': 
				return 'N'; 
			default: 
				return null; 
		} 
	}

	static getEhTransportadora(String? ehTransportadora) { 
		switch (ehTransportadora) { 
			case '': 
			case 'S': 
				return 'Sim'; 
			case 'N': 
				return 'Não'; 
			default: 
				return null; 
		} 
	} 

	static setEhTransportadora(String? ehTransportadora) { 
		switch (ehTransportadora) { 
			case 'Sim': 
				return 'S'; 
			case 'Não': 
				return 'N'; 
			default: 
				return null; 
		} 
	}

	static getEhColaborador(String? ehColaborador) { 
		switch (ehColaborador) { 
			case '': 
			case 'S': 
				return 'Sim'; 
			case 'N': 
				return 'Não'; 
			default: 
				return null; 
		} 
	} 

	static setEhColaborador(String? ehColaborador) { 
		switch (ehColaborador) { 
			case 'Sim': 
				return 'S'; 
			case 'Não': 
				return 'N'; 
			default: 
				return null; 
		} 
	}

	static getEhContador(String? ehContador) { 
		switch (ehContador) { 
			case '': 
			case 'S': 
				return 'Sim'; 
			case 'N': 
				return 'Não'; 
			default: 
				return null; 
		} 
	} 

	static setEhContador(String? ehContador) { 
		switch (ehContador) { 
			case 'Sim': 
				return 'S'; 
			case 'Não': 
				return 'N'; 
			default: 
				return null; 
		} 
	}

}