class AgendaCompromissoDomain {
	AgendaCompromissoDomain._();

	static getTipo(String? tipo) { 
		switch (tipo) { 
			case '': 
			case 'P': 
				return 'Pessoal'; 
			case 'G': 
				return 'Gerencial'; 
			default: 
				return null; 
		} 
	} 

	static setTipo(String? tipo) { 
		switch (tipo) { 
			case 'Pessoal': 
				return 'P'; 
			case 'Gerencial': 
				return 'G'; 
			default: 
				return null; 
		} 
	}

}