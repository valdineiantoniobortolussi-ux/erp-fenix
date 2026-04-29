# Procedimento de Debug - Flutter

## Chrome (web)

### Passos para debugar

1. Conectar dispositivo:
```bash
flutter devices
```

2. Executar no Chrome:
```bash
flutter run -d chrome
```

3. Abrir DevTools:
- URL: http://127.0.0.1:9106?uri=http://127.0.0.1:63031/8-aqUGeDFVw=

---

## Windows (desktop)

### Pré-requisitos

1. Habilitar Developer Mode:
```bash
start ms-settings:developers
```
- Ativar "Developer Mode" nas configurações do Windows

2. Resolver symlinks conflitantes:
```bash
Remove-Item -Recurse -Force "windows\flutter\ephemeral\.plugin_symlinks" -ErrorAction SilentlyContinue
```

### Passos para debugar

1. Conectar dispositivo:
```bash
flutter devices
```

2. Executar no Windows:
```bash
flutter run -d windows
```

3. Abrir DevTools:
- http://127.0.0.1:9100

### Erros comuns

- **errno = 183** "Não é possível criar um arquivo já existente": Executar comando Remove-Item acima para remover symlinks conflitantes
- **"Building with plugins requires symlink support"**: Habilitar Developer Mode nas configurações do Windows