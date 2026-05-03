from src.controller.bpe_cabecalho_controller import bpe_cabecalho_bp
from src.controller.view_controle_acesso_controller import view_controle_acesso_bp
from src.controller.view_pessoa_usuario_controller import view_pessoa_usuario_bp

# Register the blueprints with the Flask application
def register_blueprints(app):
		app.register_blueprint(bpe_cabecalho_bp)
		app.register_blueprint(view_controle_acesso_bp)
		app.register_blueprint(view_pessoa_usuario_bp)
