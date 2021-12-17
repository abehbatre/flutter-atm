# ATM

## Problem Statement
You are asked to develop a Command Line Interface (CLI) to simulate an interaction of an ATM with a retail bank.

## Commands
* `login [name]` - Logs in as this customer and creates the customer if not exist [DONE]
* `deposit [amount]` - Deposits this amount to the logged in customer []
* `withdraw [amount]` - Withdraws this amount from the logged in customer
* `transfer [target] [amount]` - Transfers this amount from the logged in customer to the target customer
* `logout` - Logs out of the current customer

## Example Session
Your console output should contain at least the following output depending on the scenario and commands. But feel free
to add extra output as you see fit.

---

this project generate by **Flutter 2** supports **null safety** using **GetX Ecosystem** and **drift**  
Project Design Pattern : ![image](https://user-images.githubusercontent.com/36602270/142856185-6f6f9a2d-d90f-4d34-a76e-6e3c834d13ae.png)

### REFERENCE
- [Flutter Doc. Official](https://flutter.dev/docs/development)
- [GetX](https://github.com/jonataslaw/getx#about-get)
- [VelocityX](https://velocityx.dev/)
- [drift](https://drift.simonbinder.eu/docs/getting-started/)
- [DartX](https://github.com/leisim/dartx)
- [ExIconCheatSheet](https://www.flaticon.com/uicons)

---

### Project Tree
```editorconfig
├── app
│   ├── base
│   │   ├── exception
│   │   ├── lifecycle
│   │   ├── networking
│   │   ├── resource
│   │   ├── scope
│   │   └── socket
│   ├── constants
│   ├── models
│   ├── module
│   │   ├── bindings
│   │   ├── controller
│   │   └── view
│   ├── repository
│   │   ├── local
│   │   ├── remote
│   ├── routes
│   └── translate
├── .env.development
├── .env.production
├── .env.staging
└── main.dart
```