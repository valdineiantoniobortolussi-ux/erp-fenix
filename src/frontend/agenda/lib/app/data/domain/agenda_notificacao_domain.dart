class AgendaNotificacaoDomain {
	AgendaNotificacaoDomain._();

	static getTipo(String? tipo) { 
		switch (tipo) { 
			case '': 
			case '0': 
				return 'Email'; 
			case '1': 
				return 'Mensagem na tela do computador'; 
			default: 
				return null; 
		} 
	} 

	static setTipo(String? tipo) { 
		switch (tipo) { 
			case 'Email': 
				return '0'; 
			case 'Mensagem na tela do computador': 
				return '1'; 
			default: 
				return null; 
		} 
	}

}