import UIKit
import Quick
import Nimble

@testable import TheMovieDB

final class UIViewAutoLayoutTests: QuickSpec {
    override func spec() {
        describe("under") {
            it("has to set top and bottom constraints") {
                let contentView = UIView()
                let firstView = UIView()
                let secondView = UIView()
                contentView.addSubview(firstView)
                contentView.addSubview(secondView)
                
                let constraint = firstView.under(to: secondView, offset: 10)

                expect(constraint.constant).to(equal(10))
                expect(constraint.isActive).to(beTrue())
                expect(constraint.firstAnchor).to(equal(firstView.topAnchor))
                expect(constraint.secondAnchor).to(equal(secondView.bottomAnchor))
            }
        }
        
        describe("topToSafeArea") {
            it("has to set bottom safeArea constraints") {
                let parentView = UIView()
                let childView = UIView()
                parentView.addSubview(childView)
                
                let constraint = childView.topToSafeArea(of: parentView, offset: 10)
                
                expect(constraint.isActive).to(beTrue())
                expect(constraint.constant).to(equal(10))
                expect(constraint.firstAnchor).to(equal(childView.topAnchor))
                expect(constraint.secondAnchor).to(equal(parentView.safeAreaLayoutGuide.topAnchor))
            }
        }

        describe("top") {
            it("has to set top constraints") {
                let parentView = UIView()
                let childView = UIView()
                parentView.addSubview(childView)
                
                let constraint = childView.top(to: parentView, offset: 10)

                expect(constraint.constant).to(equal(10))
                expect(constraint.isActive).to(beTrue())
                expect(constraint.firstAnchor).to(equal(childView.topAnchor))
                expect(constraint.secondAnchor).to(equal(parentView.topAnchor))
            }
        }
        
        describe("left") {
            it("has to set left constraints") {
                let parentView = UIView()
                let childView = UIView()
                parentView.addSubview(childView)
                
                let constraint = childView.left(to: parentView, offset: 10)

                expect(constraint.constant).to(equal(10))
                expect(constraint.isActive).to(beTrue())
                expect(constraint.firstAnchor).to(equal(childView.leadingAnchor))
                expect(constraint.secondAnchor).to(equal(parentView.leadingAnchor))
            }
        }
        
        describe("right") {
            it("has to set right constraints") {
                let parentView = UIView()
                let childView = UIView()
                parentView.addSubview(childView)
                
                let constraint = childView.right(to: parentView, offset: 10)

                expect(constraint.constant).to(equal(-10))
                expect(constraint.isActive).to(beTrue())
                expect(constraint.firstAnchor).to(equal(childView.trailingAnchor))
                expect(constraint.secondAnchor).to(equal(parentView.trailingAnchor))
            }
        }
        
        describe("bottom") {
            it("has to set bottom constraints") {
                let parentView = UIView()
                let childView = UIView()
                parentView.addSubview(childView)
                
                let constraint = childView.bottom(to: parentView, offset: 10)

                expect(constraint.constant).to(equal(-10))
                expect(constraint.isActive).to(beTrue())
                expect(constraint.firstAnchor).to(equal(childView.bottomAnchor))
                expect(constraint.secondAnchor).to(equal(parentView.bottomAnchor))
            }
        }
        
        describe("bottomToSafeArea") {
            it("has to set bottom safeArea constraints") {
                let parentView = UIView()
                let childView = UIView()
                parentView.addSubview(childView)
                
                let constraint = childView.bottomToSafeArea(of: parentView, offset: 10)
                
                expect(constraint.isActive).to(beTrue())
                expect(constraint.constant).to(equal(-10))
                expect(constraint.firstAnchor).to(equal(childView.bottomAnchor))
                expect(constraint.secondAnchor).to(equal(parentView.safeAreaLayoutGuide.bottomAnchor))
            }
        }
        
        describe("centerX") {
            it("has to set centerX constraints") {
                let parentView = UIView()
                let childView = UIView()
                parentView.addSubview(childView)
                
                let constraint = childView.centerX(to: parentView)

                expect(constraint.constant).to(equal(0))
                expect(constraint.isActive).to(beTrue())
                expect(constraint.firstAnchor).to(equal(childView.centerXAnchor))
                expect(constraint.secondAnchor).to(equal(parentView.centerXAnchor))
            }
        }
        
        describe("centerY") {
            it("has to set centerY constraints") {
                let parentView = UIView()
                let childView = UIView()
                parentView.addSubview(childView)
                
                let constraint = childView.centerY(to: parentView)

                expect(constraint.constant).to(equal(0))
                expect(constraint.isActive).to(beTrue())
                expect(constraint.firstAnchor).to(equal(childView.centerYAnchor))
                expect(constraint.secondAnchor).to(equal(parentView.centerYAnchor))
            }
        }
        
        describe("center") {
            it("has to set centerX and centerY constraints") {
                let parentView = UIView()
                let childView = UIView()
                parentView.addSubview(childView)
                
                let constraints = childView.center(in: parentView)

                expect(constraints[0].constant).to(equal(0))
                expect(constraints[0].isActive).to(beTrue())
                expect(constraints[0].firstAnchor).to(equal(childView.centerXAnchor))
                expect(constraints[0].secondAnchor).to(equal(parentView.centerXAnchor))
                expect(constraints[1].constant).to(equal(0))
                expect(constraints[1].isActive).to(beTrue())
                expect(constraints[1].firstAnchor).to(equal(childView.centerYAnchor))
                expect(constraints[1].secondAnchor).to(equal(parentView.centerYAnchor))
            }
        }
        
        describe("width") {
            describe("when equalTo parameters is sent") {
                it("has to set width constraints") {
                    let parentView = UIView()
                    let childView = UIView()
                    parentView.addSubview(childView)
                    
                    let constraint = childView.width(equalTo: parentView)
                    
                    expect(constraint.constant).to(equal(0))
                    expect(constraint.isActive).to(beTrue())
                    expect(constraint.firstAnchor).to(equal(childView.widthAnchor))
                    expect(constraint.secondAnchor).to(equal(parentView.widthAnchor))
                }
            }
            
            describe("when a number is sent") {
                it("has to set width constraints") {
                    let parentView = UIView()
                    let childView = UIView()
                    parentView.addSubview(childView)
                    
                    let constraint = childView.width(100)
                    
                    expect(constraint.constant).to(equal(100))
                    expect(constraint.isActive).to(beTrue())
                    expect(constraint.firstAnchor).to(equal(childView.widthAnchor))
                    expect(constraint.secondAnchor).to(beNil())
                }
            }
        }
        
        describe("height") {
            describe("when equalTo parameters is sent") {
                it("has to set top constraints") {
                    let parentView = UIView()
                    let childView = UIView()
                    parentView.addSubview(childView)
                    
                    let constraint = childView.height(equalTo: parentView)
                    
                    expect(constraint.constant).to(equal(0))
                    expect(constraint.isActive).to(beTrue())
                    expect(constraint.firstAnchor).to(equal(childView.heightAnchor))
                    expect(constraint.secondAnchor).to(equal(parentView.heightAnchor))
                }
            }
            
            describe("when a number is sent") {
                it("has to set top constraints") {
                    let parentView = UIView()
                    let childView = UIView()
                    parentView.addSubview(childView)
                    
                    let constraint = childView.height(100)
                    
                    expect(constraint.constant).to(equal(100))
                    expect(constraint.isActive).to(beTrue())
                    expect(constraint.firstAnchor).to(equal(childView.heightAnchor))
                    expect(constraint.secondAnchor).to(beNil())
                }
            }
        }
    }
}
