# 📱 Expense Tracker App (Flutter)

A modern **Expense Tracker mobile application** built using **Flutter** that allows users to manage daily expenses efficiently.
The app performs **full CRUD operations** by interacting with a **RESTful backend API**, with a clean UI and real-world features.

---

## ✨ Features

* ➕ Add new expenses
* 📄 View all expenses in a list
* ✏️ Edit existing expenses
* 🗑️ Delete single or multiple expenses
* ✅ Multi-select mode for bulk delete
* 🎨 Modern card-based UI with category color indicators
* 🔄 Real-time UI refresh after API operations

---

## 🛠️ Tech Stack

### Frontend

* **Flutter**
* Dart
* Material UI

### Backend (API)

* **MockAPI** (RESTful API)
* JSON-based communication

---

## 🔁 REST API Operations Used

| Operation      | HTTP Method | Description                     |
| -------------- | ----------- | ------------------------------- |
| Fetch expenses | GET         | Retrieve all expenses           |
| Add expense    | POST        | Create a new expense            |
| Update expense | PUT         | Edit existing expense           |
| Delete expense | DELETE      | Remove one or multiple expenses |

---

## 📂 Project Structure

```
lib/
├── main.dart
├── models/
│   └── expense_model.dart
├── services/
│   └── api_service.dart
├── screens/
│   ├── expense_list_screen.dart
│   ├── add_expense_screen.dart
│   └── edit_expense_screen.dart
└── utils/
    └── constants.dart
```

---

## 🧠 Key Learnings

* Consuming REST APIs in Flutter using the `http` package
* JSON serialization & deserialization using model classes
* Handling async operations with `FutureBuilder`
* Navigation between screens with data passing
* State management using `StatefulWidget`
* Building reusable and clean UI components
* Implementing real-world UX patterns like multi-select & confirmation dialogs

---

## ▶️ How to Run the Project

1. Clone the repository

   ```bash
   git clone <repository-url>
   ```

2. Navigate to the project directory

   ```bash
   cd expense_tracker_app
   ```

3. Install dependencies

   ```bash
   flutter pub get
   ```

4. Run the app

   ```bash
   flutter run
   ```

> Make sure Flutter SDK is properly installed and a device/emulator is running.

---

## 🔮 Future Improvements

* 🔐 User authentication (login & register)
* 📊 Expense analytics (charts & summaries)
* 🌙 Dark mode
* 🗓️ Date picker & filters
* 🧾 Monthly & category-wise reports
* 🔄 Replace MockAPI with custom backend (PHP / Node.js + DB)

---

## 👨‍💻 Author

**Bibek Ghimire Sharma**
BTech CSE | Flutter & Full-Stack Development Enthusiast

---

