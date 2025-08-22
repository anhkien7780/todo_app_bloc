# ✅ Flutter Todo App (BLoC / Cubit)

A simple **Todo List application** built with **Flutter** using **BLoC (Cubit)** state management.  
It demonstrates clean state handling, separation of concerns, and interactive UI with `Dismissible`.

---

## 📸 Demo
![todo_bloc](https://github.com/user-attachments/assets/eed17be4-7e1c-4b4b-9f5a-0f7e1c584367)

---

## ✨ Features
- ➕ Add, ✏️ Edit, ❌ Delete todos
- ✅ Mark tasks as completed / uncompleted
- 👆 Swipe-to-delete with confirmation using `Dismissible`
- 🔄 State management powered by **Cubit (Flutter BLoC)**
- 📂 Well-structured project, easy to scale and maintain

---

## 🚀 Getting Started

### Prerequisites
- [Flutter SDK](https://docs.flutter.dev/get-started/install) (latest stable)
- Android Studio or VS Code with Flutter & Dart plugins
- A connected emulator or physical device

### Installation
1. Clone the repository:
   ```bash
   git clone https://github.com/anhkien7780/todo_app_bloc.git
   cd todo_app_bloc
2. Install dependencies
   flutter pub get
3. Run generator launcher icon and localizations
   dart run flutter_launcher_icons
   flutter pub run intl_utils:generate
## 📂 Project Structure
```
lib/
 ├── ui/                     # UI layer (pages, widgets)
 │    └── todo_list_page/
 │         ├── todo_list_cubit.dart
 │         ├── todo_list_state.dart
 │         ├── todo_list_view.dart
 │         └── widgets/ (TodoItem, Header, etc.)
 ├── model/                  # Data models (Todo, enums, etc.)
 ├── repositories/           # Repository layer (data handling)
 └── common/                 # Shared constants (colors, dimens, styles)
```
