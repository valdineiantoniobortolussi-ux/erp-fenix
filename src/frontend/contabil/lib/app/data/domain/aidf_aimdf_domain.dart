class AidfAimdfDomain {
	AidfAimdfDomain._();

	static getFormularioDisponivel(String? formularioDisponivel) { 
		switch (formularioDisponivel) { 
			case '': 
			case 'S': 
				return 'Sim'; 
			case 'N': 
				return 'Não'; 
			default: 
				return null; 
		} 
	} 

	static setFormularioDisponivel(String? formularioDisponivel) { 
		switch (formularioDisponivel) { 
			case 'Sim': 
				return 'S'; 
			case 'Não': 
				return 'N'; 
			default: 
				return null; 
		} 
	}

}