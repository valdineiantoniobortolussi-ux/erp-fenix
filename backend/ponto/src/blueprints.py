from src.controller.login_controller import login_bp
from src.controller.ponto_escala_controller import ponto_escala_bp
from src.controller.ponto_banco_horas_controller import ponto_banco_horas_bp
from src.controller.ponto_abono_controller import ponto_abono_bp
from src.controller.ponto_parametro_controller import ponto_parametro_bp
from src.controller.ponto_horario_controller import ponto_horario_bp
from src.controller.ponto_relogio_controller import ponto_relogio_bp
from src.controller.ponto_marcacao_controller import ponto_marcacao_bp
from src.controller.ponto_classificacao_jornada_controller import ponto_classificacao_jornada_bp
from src.controller.ponto_horario_autorizado_controller import ponto_horario_autorizado_bp
from src.controller.ponto_fechamento_jornada_controller import ponto_fechamento_jornada_bp
from src.controller.view_controle_acesso_controller import view_controle_acesso_bp
from src.controller.view_pessoa_usuario_controller import view_pessoa_usuario_bp
from src.controller.view_pessoa_colaborador_controller import view_pessoa_colaborador_bp

# Register the blueprints with the Flask application
def register_blueprints(app):
		app.register_blueprint(ponto_escala_bp)
		app.register_blueprint(ponto_banco_horas_bp)
		app.register_blueprint(ponto_abono_bp)
		app.register_blueprint(ponto_parametro_bp)
		app.register_blueprint(ponto_horario_bp)
		app.register_blueprint(ponto_relogio_bp)
		app.register_blueprint(ponto_marcacao_bp)
		app.register_blueprint(ponto_classificacao_jornada_bp)
		app.register_blueprint(ponto_horario_autorizado_bp)
		app.register_blueprint(ponto_fechamento_jornada_bp)
		app.register_blueprint(view_controle_acesso_bp)
		app.register_blueprint(view_pessoa_usuario_bp)
		app.register_blueprint(view_pessoa_colaborador_bp)
		app.register_blueprint(login_bp)