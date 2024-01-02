# SUS-LIFO-FRONTEND

> Processo Seletivo DOX - Teste técnico (SUS-LIFO)

O gerente (da UPA) ficou maluco! Precisamos de um sistema para gerenciar a fila de pacientes que não param de chegar e a regra é: o último a chegar é o primeiro a ser atendido.
Você deverá implementar um mini-sistema web com as seguintes caracteristicas:

- Front web em Flutter
- **Duas telas: a inicial mostrará o último paciente que chegou na fila, a alternativa deverá permitir ao usuário de registrar um novo paciente. O input do usuário nesse caso é somente seu nome**
- Backend em python usando o framework flask.
- Os dados deverão ser persistidos em um banco de dados MySQL.
- Tecnologia recomendada: sqlalchemy
- **Entregável: arquivo zip com o código para o front e o back com instruções de como rodar o código.**
- Será analisado sobretudo a organização do código

## Pre-requisitos

- [Flutter](https://docs.flutter.dev/get-started/install) (Channel stable, 3.16)
- Dart (3.2.3)

## Como usar

1. Clone o repositório ou baixe o arquivo zipado.
2. Incialize o [Backend](https://github.com/gloinho/sus-lifo-backend) para funcionalidade completa.
3. Inicialize o projeto

```bash
flutter run -d chrome
```
