class EmpresaCnaeDomain {
	EmpresaCnaeDomain._();

	static getPrincipal(String? principal) { 
		switch (principal) { 
			case '': 
			case 'S': 
				return 'Sim'; 
			case 'N': 
				return 'Não'; 
			default: 
				return null; 
		} 
	} 

	static setPrincipal(String? principal) { 
		switch (principal) { 
			case 'Sim': 
				return 'S'; 
			case 'Não': 
				return 'N'; 
			default: 
				return null; 
		} 
	}

}