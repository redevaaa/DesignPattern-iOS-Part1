# DesignPattern-iOS-Part1

## Intro

- Types of Design Pattern
  - Structural design pattern: How objects are comined into larger structures.
    - MVC, MVVM, Facade
  - Behavioral design pattern: How objects communicate with each other.
    - Delegation, Strategy, Observer
  - Creational design pattern: How to create or instantiate objects.
    - Builder, Singleton, Prototype
- Class Diagram

## Structural Design Pattern

- **Model-View-Controller(MVC)** - separates objects into three distinct types.

![avartar](https://assets.alexandria.raywenderlich.com/books/des/images/2f95e65151a4dc63665deb6a6c6ecd975c6bdec168447511d3352de081fae919/original.png)

1. **Models** hold application data. They are usually structs or simple classes.
2. **Views** display visual elements and controls on screen. They are usually subclasses of `UIView`.
3. **Controllers** coordinate between models and views. They are usually subclasses of `UIViewController`.











## Behavioral Design Pattern

- **Delegation Pattern** - enables an object to use another “helper” object to provide data or perform a task rather than do the task itself.

![avartar](https://assets.alexandria.raywenderlich.com/books/des/images/40fd4482df4d438b6f9ebc0b9d1d3c691ad8f2b54462104e6d443576a33de048/original.png)

1. An **object needing a delegate**, also known as the **delegating object.** It’s the object that *has* a delegate. The delegate is usually held as a weak property to avoid a retain cycle where the delegating object retains the delegate, which retains the delegating object.
2. A **delegate protocol**, which defines the methods a delegate may or should implement.
3. A **delegate**, which is the helper object that implements the delegate protocol.

- **Strategy Pattern** - defines a family of interchangeable objects that can be set or switched at runtime.

![avartar](https://assets.alexandria.raywenderlich.com/books/des/images/a9ba374ddb314c66e823a8864b1958071d4e374da480c36527bb252f24bc159e/original.png)

1. The **object using a strategy**. This is most often a view controller when the pattern is used in iOS app development, but it can technically be any kind of object that needs interchangeable behavior.
2. The **strategy protocol** defines methods that every strategy must implement.
3. The **strategies** are objects that conform to the strategy protocol.

- **Memento Pattern** - allows an object to be saved and restored.

![avartar](https://assets.alexandria.raywenderlich.com/books/des/images/c67c93d001662195b5307b4569defd6d0eda0b2d587b8409dfdd0117ba7facb7/original.png)

1. The **originator** is the object to be saved or restored.
2. The **memento** represents a stored state.
3. The **caretaker** requests a save from the originator and receives a memento in response. The caretaker is responsible for persisting the memento and, later on, providing the memento back to the originator to restore the originator’s state.

- **Observer Pattern** -  lets one object observe changes on another object.

![avartar](https://assets.alexandria.raywenderlich.com/books/des/images/4ac19e2deab6993c3237b02b14f55b1b87591e5f0873e94b311ac552237ee362/original.png)

1. The **subscriber** is the “observer” object and receives updates.
2. The **publisher** is the “observable” object and sends updates.
3. The **value** is the underlying object that’s changed.

```swift
import Combine

public class User {
    
    @Published var name: String
    
    public init(name: String) {
        self.name = name
    }
}

let user = User(name: "Ray")
let publisher = user.$name
var subscriber: AnyCancellable? = publisher.sink() {
    print("User's name is \($0)")
}

user.name = "Vicki"

subscriber = nil
user.name = "Ray has left the building"
```





## Creational Design Pttern

- **Singleton Pattern** - restricts a class to only *one* instance.

  ![avatar](https://assets.alexandria.raywenderlich.com/books/des/images/8cadecd3ed48f7fdda5ca8ca7628212c6e9573f2cccbd8ba6429e50b11de985f/original.png)

  - Singleton

  ```swift
  import UIKit
  
  // MARK: - Singleton
  let app = UIApplication.shared
  // Compile Error
  // let app2 = UIApplication() 
  
  public class MySingleton {
    static let shared = MySingleton()
    private init() { }
  }
  let mySingleton = MySingleton.shared
  // Compile Error
  // let mySingleton2 = MySingleton()
  ```

  - Singleton Plus

  ```swift
  // MARK: - Singleton Plus
  let defaultFileManager = FileManager.default
  let customFileManager = FileManager() //using it on a background thread
  
  public class MySingletonPlus {
    static let shared = MySingletonPlus()
    public init() { }
  }
  let singletonPlus = MySingletonPlus.shared
  let singletonPlus2 = MySingletonPlus()
  ```

- **Builder Pattern** -  create complex objects by providing inputs step-by-step, instead of requiring all inputs upfront via an initializer. 

![avatar](https://assets.alexandria.raywenderlich.com/books/des/images/06272e94624ac4835411d41e69a30f2399bddc2aeb82b0798152d5d489f909bb/original.png)

1. The **director** accepts inputs and coordinates with the builder. This is usually a view controller or a helper class that’s used by a view controller.
2. The **product** is the complex object to be created. This can be either a struct or a class, depending on desired reference semantics. It’s usually a model, but it can be any type depending on your use case.
3. The **builder** accepts step-by-step inputs and handles the creation of the product. This is often a class, so it can be reused by reference.


https://sarunw.com/posts/how-to-create-new-xcode-project-without-storyboard/#xcode-11







