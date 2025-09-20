# 📘 Interview Questions and Answers

This repository contains a collection of common technical questions and their answers.  
Use the links below to jump directly to each answer.  

---

## 📑 Table of Contents
1. [What is Encapsulation?](#what-is-encapsulation)
2. [What is Abstraction?](#what-is-abstraction)
3. [What is an Interface?](#what-is-an-interface)
4. [What are Constructors?](#what-are-constructors)
5. [What is the difference between a Class and an Object?](#what-is-the-difference-between-a-class-and-an-object)

---

## ❓ Questions & Answers

### What is Encapsulation?
Encapsulation is the process of bundling data (variables) and methods (functions) together into a single unit (class).  
It helps to **hide implementation details** and provides **data security** by controlling access through access modifiers like `private`, `protected`, and `public`.

---

### What is Abstraction?
Abstraction is the concept of **hiding the implementation details** and exposing only the functionality to the user.  
For example, when you call a method like `.Sort()` on a list, you don’t need to know the sorting algorithm—it’s abstracted away.

---

### What is an Interface?
An **interface** is a contract that specifies a set of methods (without implementation) that a class must implement.  
It enables multiple classes to follow the same structure and supports multiple inheritance in languages like C#.

---

### What are Constructors?
A **constructor** is a special method in a class that is automatically called when an object of that class is created.  
Constructors are used to initialize object properties.

Example in C#:
```csharp
public class Student {
    public string Name;
    
    // Constructor
    public Student(string name) {
        Name = name;
    }
}
