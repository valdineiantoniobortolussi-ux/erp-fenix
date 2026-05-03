from src.controller.login_controller import login_bp
from src.controller.agenda_compromisso_controller import agenda_compromisso_bp
from src.controller.recado_remetente_controller import recado_remetente_bp
from src.controller.agenda_categoria_compromisso_controller import agenda_categoria_compromisso_bp
from src.controller.reuniao_sala_controller import reuniao_sala_bp
from src.controller.view_controle_acesso_controller import view_controle_acesso_bp
from src.controller.view_pessoa_usuario_controller import view_pessoa_usuario_bp
from src.controller.view_pessoa_colaborador_controller import view_pessoa_colaborador_bp

# Register the blueprints with the Flask application
def register_blueprints(app):
		app.register_blueprint(agenda_compromisso_bp)
		app.register_blueprint(recado_remetente_bp)
		app.register_blueprint(agenda_categoria_compromisso_bp)
		app.register_blueprint(reuniao_sala_bp)
		app.register_blueprint(view_controle_acesso_bp)
		app.register_blueprint(view_pessoa_usuario_bp)
		app.register_blueprint(view_pessoa_colaborador_bp)
		app.register_blueprint(login_bp)