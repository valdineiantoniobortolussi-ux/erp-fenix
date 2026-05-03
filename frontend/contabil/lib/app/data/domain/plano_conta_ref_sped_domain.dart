class PlanoContaRefSpedDomain {
	PlanoContaRefSpedDomain._();

	static getTipo(String? tipo) { 
		switch (tipo) { 
			case '': 
			case 'S': 
				return 'Sintética'; 
			case 'A': 
				return 'Analítica'; 
			default: 
				return null; 
		} 
	} 

	static setTipo(String? tipo) { 
		switch (tipo) { 
			case 'Sintética': 
				return 'S'; 
			case 'Analítica': 
				return 'A'; 
			default: 
				return null; 
		} 
	}

}