# Project Overview

Thank you for taking the time to review the project. I look forward to your feedback.

## Architecture

This project follows a **protocol-oriented, modular architecture** based on **Clean Architecture principles** to maximize reusability and maintainability.

- **Domain Module**: Contains common models, `NetworkService`, and `StorageService`, encapsulating their implementation.  
- **NetworkService**: Implemented via `LiveNetworkService` and `MockNetworkService` to maximize reusability and testability.  
- **StorageService**: Handles secure storage through a trimmed version of my [StorageService package](https://github.com/Anything-That-Works/StorageService), encapsulating `KeyChainManager`.  
- **DesignSystem**: Holds static resources such as colors, icons, and fonts. It is injected into the environment for easy access across all views.

The **project itself uses a feature-based MVVM architecture**, which is ideal for larger teams working collaboratively without introducing dependencies.

For **project navigation**, I used [WayFinder](git@github.com:Anything-That-Works/WayFinder.git), a wrapper package I'm working on for unified programmatic navigation across iOS versions (supporting iOS 14+).

## Running the Project

No special setup is required. Simply clone the repository or download the project and run it as usual.

## Limitations

- Secure Enclave support is not included. While it could provide added security alongside KeyChain, including a secure enclave key in the project is not desirable.
