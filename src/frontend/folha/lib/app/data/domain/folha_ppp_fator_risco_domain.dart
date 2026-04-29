class FolhaPppFatorRiscoDomain {
	FolhaPppFatorRiscoDomain._();

	static getTipo(String? tipo) { 
		switch (tipo) { 
			case '': 
			case 'F': 
				return 'F=Físico'; 
			case 'Q': 
				return 'Q=Químico'; 
			case 'B': 
				return 'B=Biológico'; 
			case 'E': 
				return 'E=Ergonômico/Psicossocial'; 
			case 'M': 
				return 'M=Mecânico/de Acidente'; 
			default: 
				return null; 
		} 
	} 

	static setTipo(String? tipo) { 
		switch (tipo) { 
			case 'F=Físico': 
				return 'F'; 
			case 'Q=Químico': 
				return 'Q'; 
			case 'B=Biológico': 
				return 'B'; 
			case 'E=Ergonômico/Psicossocial': 
				return 'E'; 
			case 'M=Mecânico/de Acidente': 
				return 'M'; 
			default: 
				return null; 
		} 
	}

	static getEpcEficaz(String? epcEficaz) { 
		switch (epcEficaz) { 
			case '': 
			case 'S': 
				return 'Sim'; 
			case 'N': 
				return 'Não'; 
			default: 
				return null; 
		} 
	} 

	static setEpcEficaz(String? epcEficaz) { 
		switch (epcEficaz) { 
			case 'Sim': 
				return 'S'; 
			case 'Não': 
				return 'N'; 
			default: 
				return null; 
		} 
	}

	static getEpiEficaz(String? epiEficaz) { 
		switch (epiEficaz) { 
			case '': 
			case 'S': 
				return 'Sim'; 
			case 'N': 
				return 'Não'; 
			default: 
				return null; 
		} 
	} 

	static setEpiEficaz(String? epiEficaz) { 
		switch (epiEficaz) { 
			case 'Sim': 
				return 'S'; 
			case 'Não': 
				return 'N'; 
			default: 
				return null; 
		} 
	}

	static getAtendimentoNr061(String? atendimentoNr061) { 
		switch (atendimentoNr061) { 
			case '': 
			case 'S': 
				return 'Sim'; 
			case 'N': 
				return 'Não'; 
			default: 
				return null; 
		} 
	} 

	static setAtendimentoNr061(String? atendimentoNr061) { 
		switch (atendimentoNr061) { 
			case 'Sim': 
				return 'S'; 
			case 'Não': 
				return 'N'; 
			default: 
				return null; 
		} 
	}

	static getAtendimentoNr062(String? atendimentoNr062) { 
		switch (atendimentoNr062) { 
			case '': 
			case 'S': 
				return 'Sim'; 
			case 'N': 
				return 'Não'; 
			default: 
				return null; 
		} 
	} 

	static setAtendimentoNr062(String? atendimentoNr062) { 
		switch (atendimentoNr062) { 
			case 'Sim': 
				return 'S'; 
			case 'Não': 
				return 'N'; 
			default: 
				return null; 
		} 
	}

	static getAtendimentoNr063(String? atendimentoNr063) { 
		switch (atendimentoNr063) { 
			case '': 
			case 'S': 
				return 'Sim'; 
			case 'N': 
				return 'Não'; 
			default: 
				return null; 
		} 
	} 

	static setAtendimentoNr063(String? atendimentoNr063) { 
		switch (atendimentoNr063) { 
			case 'Sim': 
				return 'S'; 
			case 'Não': 
				return 'N'; 
			default: 
				return null; 
		} 
	}

	static getAtendimentoNr064(String? atendimentoNr064) { 
		switch (atendimentoNr064) { 
			case '': 
			case 'S': 
				return 'Sim'; 
			case 'N': 
				return 'Não'; 
			default: 
				return null; 
		} 
	} 

	static setAtendimentoNr064(String? atendimentoNr064) { 
		switch (atendimentoNr064) { 
			case 'Sim': 
				return 'S'; 
			case 'Não': 
				return 'N'; 
			default: 
				return null; 
		} 
	}

	static getAtendimentoNr065(String? atendimentoNr065) { 
		switch (atendimentoNr065) { 
			case '': 
			case 'S': 
				return 'Sim'; 
			case 'N': 
				return 'Não'; 
			default: 
				return null; 
		} 
	} 

	static setAtendimentoNr065(String? atendimentoNr065) { 
		switch (atendimentoNr065) { 
			case 'Sim': 
				return 'S'; 
			case 'Não': 
				return 'N'; 
			default: 
				return null; 
		} 
	}

}