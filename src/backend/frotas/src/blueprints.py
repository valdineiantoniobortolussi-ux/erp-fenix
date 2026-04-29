from src.controller.login_controller import login_bp
from src.controller.frota_veiculo_controller import frota_veiculo_bp
from src.controller.frota_veiculo_tipo_controller import frota_veiculo_tipo_bp
from src.controller.frota_combustivel_tipo_controller import frota_combustivel_tipo_bp
from src.controller.frota_motorista_controller import frota_motorista_bp
from src.controller.view_controle_acesso_controller import view_controle_acesso_bp
from src.controller.view_pessoa_usuario_controller import view_pessoa_usuario_bp
from src.controller.view_pessoa_colaborador_controller import view_pessoa_colaborador_bp

# Register the blueprints with the Flask application
def register_blueprints(app):
		app.register_blueprint(frota_veiculo_bp)
		app.register_blueprint(frota_veiculo_tipo_bp)
		app.register_blueprint(frota_combustivel_tipo_bp)
		app.register_blueprint(frota_motorista_bp)
		app.register_blueprint(view_controle_acesso_bp)
		app.register_blueprint(view_pessoa_usuario_bp)
		app.register_blueprint(view_pessoa_colaborador_bp)
		app.register_blueprint(login_bp)