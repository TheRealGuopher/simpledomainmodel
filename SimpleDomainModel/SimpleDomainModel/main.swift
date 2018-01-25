//
//  main.swift
//  SimpleDomainModel
//
//  Created by Ted Neward on 4/6/16.
//  Copyright © 2016 Ted Neward. All rights reserved.
//

import Foundation

print("Hello, World!")

public func testMe() -> String {
  return "I have been tested"
}

open class TestMe {
  open func Please() -> String {
    return "I have been tested"
  }
}

////////////////////////////////////
// Money
//

public struct Money {
    public var amount : Int
    public var currency : String

    init(amount: Int, currency: String) {
        self.amount = amount
        self.currency = currency
    }
    public func convert(_ to: String) -> Money {
        var mon = Money(amount: 0, currency: "default")
        if (self.currency == "GBP") {
            mon.amount = rate(self.amount, 2)
            mon.currency = "USD"
        } else if (self.currency == "EUR") {
            mon.amount = rate(self.amount, 2/3)
            mon.currency = "USD"
        } else if (self.currency == "CAN") {
            mon.amount = rate(self.amount, 4/5)
            mon.currency = "USD"
        }
        if (mon.currency == "USD") {
            if (to == "GBP") {
                mon.amount = rate(mon.amount, 0.5)
                mon.currency = "GBP"
            } else if (to == "EUR") {
                mon.amount = rate(mon.amount, 1.5)
                mon.currency = "EUR"
            } else if (to == "CAN") {
                mon.amount = rate(self.amount, 1.25)
                mon.currency = "CAN"
            }
        }
        return mon
    }
    
    public func rate(_ orig: Int, _ num: Double) -> Int {
        return Int(Double(orig) * num)
    }

    public func add(_ to: Money) -> Money {
        let first = self.convert("USD")
        let second = to.convert("USD")
        let sum = first.amount + second.amount
        return Money(amount: sum, currency: to.currency)
    }
    public func subtract(_ from: Money) -> Money {
        let first = self.convert("USD")
        let second = from.convert("USD")
        let sum = second.amount - first.amount
        return Money(amount: sum, currency: from.currency)
    }
}

////////////////////////////////////
// Job
//
open class Job {
    fileprivate var title : String
    fileprivate var type : JobType

    public enum JobType {
        case Hourly(Double)
        case Salary(Int)
    }

    public init(title : String, type : JobType) {
        self.title = title
        self.type = type
    }

    open func calculateIncome(_ hours: Int) -> Int {
        switch self.type {
        case .Hourly(let rate):
            return Int(rate * Double(hours))
        case .Salary(let rate):
            return rate
        default:
            return 1
        }
    }

    open func raise(_ amt : Double) {
        switch self.type {
        case .Hourly(let rate):
            rate += amt
        case .Salary(let rate):
            Double(rate) += amt
        default:
        }
    }
}

////////////////////////////////////
// Person
//
//open class Person {
//  open var firstName : String = ""
//  open var lastName : String = ""
//  open var age : Int = 0
//
//  fileprivate var _job : Job? = nil
//  open var job : Job? {
//    get { }
//    set(value) {
//    }
//  }
//
//  fileprivate var _spouse : Person? = nil
//  open var spouse : Person? {
//    get { }
//    set(value) {
//    }
//  }
//
//  public init(firstName : String, lastName: String, age : Int) {
//    self.firstName = firstName
//    self.lastName = lastName
//    self.age = age
//  }
//
//  open func toString() -> String {
//  }
//}

////////////////////////////////////
// Family
//
//open class Family {
//  fileprivate var members : [Person] = []
//  
//  public init(spouse1: Person, spouse2: Person) {
//  }
//  
//  open func haveChild(_ child: Person) -> Bool {
//  }
//
//  open func householdIncome() -> Int {
//  }
//}





