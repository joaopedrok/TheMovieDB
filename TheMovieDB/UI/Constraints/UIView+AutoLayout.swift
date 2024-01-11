import UIKit

extension UIView {
    @discardableResult
    func under(to view: UIView, offset: CGFloat = 0) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = topAnchor.constraint(equalTo: view.bottomAnchor, constant: offset)
        constraint.isActive = true
        return constraint
    }

    
    @discardableResult
    func top(to view: UIView, offset: CGFloat = 0) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = topAnchor.constraint(equalTo: view.topAnchor, constant: offset)
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult
    func bottom(to view: UIView, offset: CGFloat = 0) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -offset)
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult
    func topToSafeArea(of view: UIView, offset: CGFloat = 0) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: offset)
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult
    func bottomToSafeArea(of view: UIView, offset: CGFloat = 0) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -offset)
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult
    func left(to view: UIView, offset: CGFloat = 0) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: offset)
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult
    func right(to view: UIView, offset: CGFloat = 0) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -offset)
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult
    func centerX(to view: UIView, offset: CGFloat = 0) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: offset)
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult
    func centerY(to view: UIView, offset: CGFloat = 0) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: offset)
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult
    func center(in view: UIView, offset: CGFloat = 0) -> [NSLayoutConstraint] {
        let centerXConstraint = centerX(to: view, offset: offset)
        let centerYConstraint = centerY(to: view, offset: offset)
        
        return [centerXConstraint, centerYConstraint]
    }
    
    @discardableResult
    func width(equalTo view: UIView, multiplier: CGFloat = 1) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: multiplier)
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult
    func height(equalTo view: UIView, multiplier: CGFloat = 1) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: multiplier)
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult
    func width(_ width: CGFloat) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = widthAnchor.constraint(equalToConstant: width)
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult
    func height(_ height: CGFloat) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = heightAnchor.constraint(equalToConstant: height)
        constraint.isActive = true
        return constraint
    }
}
