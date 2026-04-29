class BancoContaCaixaDomain {
	BancoContaCaixaDomain._();

	static getTipo(String? tipo) { 
		switch (tipo) { 
			case '': 
			case 'C': 
				return 'Corrente'; 
			case 'P': 
				return 'Poupança'; 
			default: 
				return null; 
		} 
	} 

	static setTipo(String? tipo) { 
		switch (tipo) { 
			case 'Corrente': 
				return 'C'; 
			case 'Poupança': 
				return 'P'; 
			default: 
				return null; 
		} 
	}

}