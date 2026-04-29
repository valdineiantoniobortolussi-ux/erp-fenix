class FinExtratoContaBancoDomain {
	FinExtratoContaBancoDomain._();

	static getConciliado(String? conciliado) { 
		switch (conciliado) { 
			case '': 
			case 'S': 
				return 'S'; 
			case 'N': 
				return 'N'; 
			default: 
				return null; 
		} 
	} 

	static setConciliado(String? conciliado) { 
		switch (conciliado) { 
			case 'S': 
				return 'S'; 
			case 'N': 
				return 'N'; 
			default: 
				return null; 
		} 
	}

}