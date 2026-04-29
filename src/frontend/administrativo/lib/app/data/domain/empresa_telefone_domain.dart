class EmpresaTelefoneDomain {
	EmpresaTelefoneDomain._();

	static getTipo(String? tipo) { 
		switch (tipo) { 
			case '': 
			case '0': 
				return 'Fixo'; 
			case '1': 
				return 'Celular'; 
			case '2': 
				return 'WhatsApp'; 
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
			case 'WhatsApp': 
				return '2'; 
			default: 
				return null; 
		} 
	}

}