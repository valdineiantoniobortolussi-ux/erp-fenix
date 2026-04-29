class ContratoSolicitacaoServicoDomain {
	ContratoSolicitacaoServicoDomain._();

	static getUrgente(String? urgente) { 
		switch (urgente) { 
			case '': 
			case '0': 
				return 'S'; 
			case '1': 
				return 'N'; 
			default: 
				return null; 
		} 
	} 

	static setUrgente(String? urgente) { 
		switch (urgente) { 
			case 'S': 
				return '0'; 
			case 'N': 
				return '1'; 
			default: 
				return null; 
		} 
	}

	static getStatusSolicitacao(String? statusSolicitacao) { 
		switch (statusSolicitacao) { 
			case '': 
			case 'A': 
				return 'Aguardando'; 
			case 'D': 
				return 'Deferido'; 
			case 'I': 
				return 'Indeferido'; 
			default: 
				return null; 
		} 
	} 

	static setStatusSolicitacao(String? statusSolicitacao) { 
		switch (statusSolicitacao) { 
			case 'Aguardando': 
				return 'A'; 
			case 'Deferido': 
				return 'D'; 
			case 'Indeferido': 
				return 'I'; 
			default: 
				return null; 
		} 
	}

}