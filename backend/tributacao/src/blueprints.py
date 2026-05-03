from src.controller.tribut_icms_custom_cab_controller import tribut_icms_custom_cab_bp
from src.controller.tribut_configura_of_gt_controller import tribut_configura_of_gt_bp
from src.controller.tribut_grupo_tributario_controller import tribut_grupo_tributario_bp
from src.controller.tribut_operacao_fiscal_controller import tribut_operacao_fiscal_bp
from src.controller.tribut_iss_controller import tribut_iss_bp
from src.controller.view_controle_acesso_controller import view_controle_acesso_bp
from src.controller.view_pessoa_usuario_controller import view_pessoa_usuario_bp
from src.controller.login_controller import login_bp

# Register the blueprints with the Flask application
def register_blueprints(app):
		app.register_blueprint(tribut_icms_custom_cab_bp)
		app.register_blueprint(tribut_configura_of_gt_bp)
		app.register_blueprint(tribut_grupo_tributario_bp)
		app.register_blueprint(tribut_operacao_fiscal_bp)
		app.register_blueprint(tribut_iss_bp)
		app.register_blueprint(view_controle_acesso_bp)
		app.register_blueprint(view_pessoa_usuario_bp)
		app.register_blueprint(login_bp)
