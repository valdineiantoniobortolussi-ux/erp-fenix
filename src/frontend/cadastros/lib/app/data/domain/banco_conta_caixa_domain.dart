class BancoContaCaixaDomain {
	BancoContaCaixaDomain._();

	static getTipo(String? tipo) { 
		switch (tipo) { 
			case '': 
			case '0': 
				return 'Corrente'; 
			case '1': 
				return 'Poupança'; 
			case '2': 
				return 'Investimento'; 
			case '3': 
				return 'Caixa Interno'; 
			default: 
				return null; 
		} 
	} 

	static setTipo(String? tipo) { 
		switch (tipo) { 
			case 'Corrente': 
				return '0'; 
			case 'Poupança': 
				return '1'; 
			case 'Investimento': 
				return '2'; 
			case 'Caixa Interno': 
				return '3'; 
			default: 
				return null; 
		} 
	}

}