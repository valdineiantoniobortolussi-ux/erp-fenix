class PessoaTelefoneDomain {
	PessoaTelefoneDomain._();

	static getTipo(String? tipo) { 
		switch (tipo) { 
			case '': 
			case '0': 
				return 'Fixo'; 
			case '1': 
				return 'Celular'; 
			case '2': 
				return 'Whatsapp'; 
			default: 
				return null; 
		} 
	} 

	static setTipo(String? tipo) { 
		switch (tipo) { 
			case 'Fixo': 
				return '0'; 
			case 'Celular': 
				return '1'; 
			case 'Whatsapp': 
				return '2'; 
			default: 
				return null; 
		} 
	}

}