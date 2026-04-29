class PontoFechamentoJornadaDomain {
	PontoFechamentoJornadaDomain._();

	static getDiaSemana(String? diaSemana) { 
		switch (diaSemana) { 
			case '': 
			case 'DOMINGO': 
				return 'DOMINGO'; 
			case 'SEGUNDA': 
				return 'SEGUNDA'; 
			case 'TERCA': 
				return 'TERCA'; 
			case 'QUARTA': 
				return 'QUARTA'; 
			case 'QUINTA': 
				return 'QUINTA'; 
			case 'SEXTA': 
				return 'SEXTA'; 
			case 'SABADO': 
				return 'SABADO'; 
			default: 
				return null; 
		} 
	} 

	static setDiaSemana(String? diaSemana) { 
		switch (diaSemana) { 
			case 'DOMINGO': 
				return 'DOMINGO'; 
			case 'SEGUNDA': 
				return 'SEGUNDA'; 
			case 'TERCA': 
				return 'TERCA'; 
			case 'QUARTA': 
				return 'QUARTA'; 
			case 'QUINTA': 
				return 'QUINTA'; 
			case 'SEXTA': 
				return 'SEXTA'; 
			case 'SABADO': 
				return 'SABADO'; 
			default: 
				return null; 
		} 
	}

	static getModalidadeHoraExtra01(String? modalidadeHoraExtra01) { 
		switch (modalidadeHoraExtra01) { 
			case '': 
			case 'D': 
				return 'Diurna'; 
			case 'N': 
				return 'Noturna'; 
			default: 
				return null; 
		} 
	} 

	static setModalidadeHoraExtra01(String? modalidadeHoraExtra01) { 
		switch (modalidadeHoraExtra01) { 
			case 'Diurna': 
				return 'D'; 
			case 'Noturna': 
				return 'N'; 
			default: 
				return null; 
		} 
	}

	static getModalidadeHoraExtra02(String? modalidadeHoraExtra02) { 
		switch (modalidadeHoraExtra02) { 
			case '': 
			case 'D': 
				return 'Diurna'; 
			case 'N': 
				return 'Noturna'; 
			default: 
				return null; 
		} 
	} 

	static setModalidadeHoraExtra02(String? modalidadeHoraExtra02) { 
		switch (modalidadeHoraExtra02) { 
			case 'Diurna': 
				return 'D'; 
			case 'Noturna': 
				return 'N'; 
			default: 
				return null; 
		} 
	}

	static getModalidadeHoraExtra03(String? modalidadeHoraExtra03) { 
		switch (modalidadeHoraExtra03) { 
			case '': 
			case 'D': 
				return 'Diurna'; 
			case 'N': 
				return 'Noturna'; 
			default: 
				return null; 
		} 
	} 

	static setModalidadeHoraExtra03(String? modalidadeHoraExtra03) { 
		switch (modalidadeHoraExtra03) { 
			case 'Diurna': 
				return 'D'; 
			case 'Noturna': 
				return 'N'; 
			default: 
				return null; 
		} 
	}

	static getModalidadeHoraExtra04(String? modalidadeHoraExtra04) { 
		switch (modalidadeHoraExtra04) { 
			case '': 
			case 'D': 
				return 'Diurna'; 
			case 'N': 
				return 'Noturna'; 
			default: 
				return null; 
		} 
	} 

	static setModalidadeHoraExtra04(String? modalidadeHoraExtra04) { 
		switch (modalidadeHoraExtra04) { 
			case 'Diurna': 
				return 'D'; 
			case 'Noturna': 
				return 'N'; 
			default: 
				return null; 
		} 
	}

	static getCompensar(String? compensar) { 
		switch (compensar) { 
			case '': 
			case '0': 
				return 'Horas a mais'; 
			case '1': 
				return 'Horas a menos'; 
			default: 
				return null; 
		} 
	} 

	static setCompensar(String? compensar) { 
		switch (compensar) { 
			case 'Horas a mais': 
				return '0'; 
			case 'Horas a menos': 
				return '1'; 
			default: 
				return null; 
		} 
	}

}