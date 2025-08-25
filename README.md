# Cumpri

Aplicativo de gerenciamento de tarefas desenvolvido em Flutter, pensado para ser simples e minimalista.

---

## 🎬 Demonstração 

https://github.com/user-attachments/assets/215135c6-8b99-45da-9fe8-6b848256a78d

## 🚀 Funcionalidades

| Funcionalidade                | Descrição                                                     |
| ----------------------------- | ------------------------------------------------------------- |
| 📝 Lista de Tarefas            | Adicione, edite e remova tarefas de forma rápida.            |
| ✅ Marcar como Concluída        | Marque tarefas como feitas e acompanhe seu progresso.        |
| 🔄 Atualizar Arrastando         | Atualize a lista de tarefas puxando para baixo (pull to refresh). |
| 🌙 Alternância de Tema          | Troque entre modo claro e modo escuro conforme sua preferência. |

---

## 🏗️ Arquitetura

O projeto segue o padrão **MVVM (Model-View-ViewModel)**, garantindo separação clara entre UI, lógica de estado e dados:

- **Model** → Representação das tarefas e seus dados (ex: título, descrição, status).  
- **ViewModel (MobX Stores)** → Camada reativa que gerencia estados observáveis, computed values e regras de negócio.  
- **View** → Interface Flutter, consumindo dados do ViewModel via **Observer**.

---

## 📦 Pacotes

- **[Drift](https://pub.dev/packages/drift)** → persistência local e gerenciamento de banco de dados SQLite.  
- **[MobX](https://pub.dev/packages/mobx)** → gerenciamento de estado reativo.  
- **[flutter_mobx](https://pub.dev/packages/flutter_mobx)** → integração do MobX com Flutter (Observer, Reaction, etc.).  
- **[mobx_codegen](https://pub.dev/packages/mobx_codegen)** → geração de código para Stores do MobX.  
- **[build_runner](https://pub.dev/packages/build_runner)** → ferramenta de geração de código necessária para o Mobx.  
- **[Path Provider](https://pub.dev/packages/path_provider)** → local para salvar arquivos e banco de dados no dispositivo.  

---

## ⚙️ Como executar

1. Clone o repositório:

   ```bash
   git clone https://github.com/savioluis/cumpri.git
   ```

2. Entre na pasta:

   ```bash
   cd cumpri
   ```

3. Instale as dependências:

   ```bash
   flutter pub get
   ```

4. Execute o app:

   ```bash
   flutter run
   ```
