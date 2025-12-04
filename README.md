
# SharEd
SharEd é um aplicativo desenvolvido em Flutter com Dart, criado para ser uma rede social que focada na combinação de educação + entretenimento,  oferecendo fluidez, confiabilidade e uma experiência otimizada para o usuário.

---
### Demonstrações / Screenshots

 <p align="center">
  <img src="./assets/images/screenshots/screenshot_01.png" width="200" />
  <img src="./assets/images/screenshots/screenshot_02.png" width="200" />
  <img src="./assets/images/screenshots/screenshot_03.png" width="200" /> 
  <img src="./assets/images/screenshots/screenshot_04.png" width="200" />
</p>

---

### Badges

![Flutter](https://img.shields.io/badge/Flutter-3.35.0-blue?logo=flutter)
![Dart](https://img.shields.io/badge/Dart-3.7-blue?logo=dart)
 ![Clean Architecture](https://img.shields.io/badge/Architecture-Clean%20Arch-brightgreen)
![SOLID](https://img.shields.io/badge/Principles-SOLID-orange) 



---

### 🚀Tecnologias e Arquitetura

- Framework: Flutter
- Linguagem: Dart
- Database: Firebase
- Arquitetura: Clean Architecture
- Gerenciador de estado: MobX


---


### 🧩 Principais Implementações
- Repository Strategy: organização modular com foco em desacoplamento e extensibilidade.
- Sistema de tratamento de exceções personalizado: unificando o fluxo de erros e mensagens de retorno.
- Sistema de estilo centralizado: incluindo tipografia, cores e espaçamentos padronizados.
- UI desacoplada da lógica de negócio: seguindo boas práticas de separação de responsabilidades.
- Uso de interfaces: reduzindo acoplamento entre camadas e facilitando testes unitários.
- Optimistic State: implementado em operações de busca, inserção e remoção, proporcionando respostas imediatas e reativas na interface.
- Design Pattern Builder: aplicado à criação de componentes de UI reutilizáveis.

---

### 💾 Persistência de Dados
Os dados são armazenados na nuvem utilizando o Firebase, garantindo rápido acesso e sincronização eficiente com as informações atualizadas.

---

### 🧠 Boas Práticas de Engenharia
- Redução de acoplamento entre camadas.
- Reuso de componentes e consistência visual.
- Responsabilidade única em cada classe.
- Modularização do código.

---

### 📱 Objetivo
Oferecer uma solução moderna, performática e escalável para ser uma rede social focada na combinação de educação + entretenimento, com foco em UX, arquitetura limpa e qualidade de código.

---

### ▶️ Executando o projeto

```bash
# Instalação do projeto
flutter pub get

# Executar em modo desenvolvimento  
flutter run --profile --dart-define-from-file=.env/dev_env.json

# Build para produção
flutter build apk --release --dart-define-from-file=.env/dev_env.json
```

---

### 🧑‍💻 Autor
Pedro Camargo Desenvolvedor Flutter | Arquitetura de Software | Design de Sistemas Modernos)
