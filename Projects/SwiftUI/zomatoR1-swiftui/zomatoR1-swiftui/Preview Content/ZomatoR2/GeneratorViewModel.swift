//
//  GeneratorViewModel.swift
//  zomatoR1-swiftui
//
//  Created by Deepak Kumar1 on 07/08/25.
//
import SwiftUI

class A {

    var t: Int = 5
    var x: (() -> Void)?

    init() {
        t = 10
        x = { [weak self] in
            self?.t = 20
        }
    }
}


class GeneratorViewModel: ObservableObject {
    @Published var data: [String] = []
    @Published var dataToShow: String = ""
    
    var lastTS: DispatchTime = .now()
    
    init() {
        var a: A! = A()
        unowned var b: A = a

        print(a.t) //10
        a = nil
        print(b.t) //crash
    }
    
    
    func updateLatestNumebr() {
        
        let newWorkItem: DispatchWorkItem = DispatchWorkItem { [weak self] in
            if(!(self?.data.isEmpty ?? false)) {
                let text = self?.data.first ?? ""
                self?.data.removeFirst()
                self?.dataToShow = text
            } else {
                self?.dataToShow = ""
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: lastTS, execute: newWorkItem)
        lastTS = lastTS + .seconds(2)
        
        
        
        
    }
    
    func test() {
        var p = Person(name: "John")
        let c = Car(model: "i20", owner: p)
        p.car = c
        
        UIView.animate(withDuration: .zero) {
            self.data = []
        }
        
        DispatchQueue.global().sync {
            self.data = []
        }
        
    }
}

class Car {
    var model: String
    var owner: Person
    
    init(model: String, owner: Person) {
        self.model = model
        self.owner = owner
    }
}

class Person {
    var name: String
    var car: Car?
    
    init(name: String, car: Car? = nil) {
        self.name = name
        self.car = car
    }
}







