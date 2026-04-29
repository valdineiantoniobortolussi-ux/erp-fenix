class OsProdutoServicoDomain {
	OsProdutoServicoDomain._();

	static getTipo(String? tipo) { 
		switch (tipo) { 
			case '': 
			case 'P': 
				return 'Produto'; 
			case 'S': 
				return 'Serviço'; 
			default: 
				return null; 
		} 
	} 

	static setTipo(String? tipo) { 
		switch (tipo) { 
			case 'Produto': 
				return 'P'; 
			case 'Serviço': 
				return 'S'; 
			default: 
				return null; 
		} 
	}

}