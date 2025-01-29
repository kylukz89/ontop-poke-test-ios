# Pokédex App (iOS)

A SwiftUI-based Pokémon Pokédex application built with **MVVM architecture**, unit and snapshot tests, and robust error handling. The project follows **SOLID principles** and **Clean Code** practices while leveraging external libraries for snapshot testing.

📌 **Repository:** [GitHub - kylukz89/ontop-poke-test-ios](https://github.com/kylukz89/ontop-poke-test-ios)  

---

## **Features**

✅ **SwiftUI with MVVM** – Clean separation of concerns.  
✅ **API Error Handling** – Gracefully handles API errors and displays user-friendly messages.  
✅ **Offline/Online Alerts** – Notifies users when the internet connection is lost or restored.  
✅ **Unit Tests** – Ensures business logic correctness.  
✅ **Snapshot Tests** – Uses **[swift-snapshot-testing](https://github.com/pointfreeco/swift-snapshot-testing)** to verify UI consistency.  
✅ **Design Patterns:**  
  - **Singleton** – Used for shared instances.  
  - **Factory Method** – Simplifies object creation.  
  - **Dependency Injection** – Enhances testability and maintainability.  
✅ **SOLID & Clean Code** – Maintains high-quality, scalable, and readable code.  

---

## **Architecture**

The app follows the **MVVM (Model-View-ViewModel)** architecture to maintain a **clear separation of concerns** and **enhance testability**.

### **Tech Stack**
- **SwiftUI** – Modern UI framework.  
- **Combine** – Handles asynchronous events.  
- **URLSession** – API requests.  
- **Dependency Injection** – Improves modularity.  

---

## **Development Approach**

As part of showcasing **modern iOS development skills**, I, **Igor Maximo**, decided to build this project **entirely from scratch** in SwiftUI, instead of using prebuilt templates. This aligns with the company’s preference for adopting cutting-edge technologies.

---

## **Testing**

🛠 **Unit Tests**  
- Validates business logic and core functionalities.  

🖼 **Snapshot Tests (swift-snapshot-testing)**  
- Ensures UI consistency across different runs.  
- Tests are **based on iPhone 13 screen size** (compatible with **iPhone 13, 14, 15, and 16**).  

---

## **Installation**

### **Requirements**
- **Xcode 15+**  
- **iOS 17+**  

### **Clone the Repository**

```sh
git clone https://github.com/kylukz89/ontop-poke-test-ios.git
cd ontop-poke-test-ios
```

### **Open the Project**

```sh
xed .
```

### **Run the App**
- Select an **iPhone 13/14/15/16** simulator in Xcode.  
- Press `Cmd + R` to run the app.  

---

## **Running Tests**

To execute all tests, run:

```sh
Cmd + U
```

For **snapshot tests**, ensure you are using an **iPhone 13 simulator** for consistency.

---

## **License**

This project is **open-source** under the [MIT License](LICENSE).
