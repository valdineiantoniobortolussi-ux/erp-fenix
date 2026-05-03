class UsuarioDomain {
	UsuarioDomain._();

	static getAdministrador(String? administrador) { 
		switch (administrador) { 
			case '': 
			case 'S': 
				return 'Sim'; 
			case 'N': 
				return 'Não'; 
			default: 
				return null; 
		} 
	} 

	static setAdministrador(String? administrador) { 
		switch (administrador) { 
			case 'Sim': 
				return 'S'; 
			case 'Não': 
				return 'N'; 
			default: 
				return null; 
		} 
	}

}