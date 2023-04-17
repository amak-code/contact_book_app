//
//  AddContactViewController.swift
//  ContactBookApp
//
//  Created by antikiller on 4/10/23.
//

import UIKit



class AddContactViewController: UIViewController {
    
    weak var delegate: AddContactViewControllerDelegate?

    // MARK: - Properties

     let nameTextField = UITextField()
     let phoneTextField = UITextField()
     let emailTextField = UITextField()

     // MARK: - View Lifecycle

     override func viewDidLoad() {
         super.viewDidLoad()
         view.backgroundColor = .systemBackground
         //text fields
         nameTextField.placeholder = "Name"
         phoneTextField.placeholder = "Phone"
         emailTextField.placeholder = "Email"
         emailTextField.keyboardType = .emailAddress

         //buttons
         let cancelButton = UIButton(type: .system)
         cancelButton.setTitle("Cancel", for: .normal)
         cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)

         let saveButton = UIButton(type: .system)
         saveButton.setTitle("Save", for: .normal)
         saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)

         //separators
         let separator1 = UIView()
         separator1.backgroundColor = .lightGray
         separator1.translatesAutoresizingMaskIntoConstraints = false

         let separator2 = UIView()
         separator2.backgroundColor = .lightGray
         separator2.translatesAutoresizingMaskIntoConstraints = false

         //stack views
         let buttonStackView = UIStackView(arrangedSubviews: [cancelButton, saveButton])
         buttonStackView.axis = .horizontal
         buttonStackView.distribution = .fillEqually
         buttonStackView.spacing = 16
         buttonStackView.translatesAutoresizingMaskIntoConstraints = false

         let stackView = UIStackView(arrangedSubviews: [nameTextField, separator1, phoneTextField, separator2, emailTextField, buttonStackView])
         stackView.axis = .vertical
         stackView.spacing = 16
         stackView.translatesAutoresizingMaskIntoConstraints = false

         //stack view to view hierarchy
         view.addSubview(stackView)

         //constraints
         NSLayoutConstraint.activate([
             stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
             stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
             stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
             stackView.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
             separator1.heightAnchor.constraint(equalToConstant: 1),
             separator2.heightAnchor.constraint(equalToConstant: 1),
             buttonStackView.heightAnchor.constraint(equalToConstant: 44) // Height of buttons
         ])

         //  separator constraints
         separator1.leadingAnchor.constraint(equalTo: stackView.leadingAnchor).isActive = true
         separator1.trailingAnchor.constraint(equalTo: stackView.trailingAnchor).isActive = true
         separator2.leadingAnchor.constraint(equalTo: stackView.leadingAnchor).isActive = true
         separator2.trailingAnchor.constraint(equalTo: stackView.trailingAnchor).isActive = true
     }

     // MARK: - Button Actions

    //handle cancel button tapped
     @objc func cancelButtonTapped() {
         
     }

    //handle save button
     @objc func saveButtonTapped() {
         
         ContactController.addContact(
            contactName: nameTextField.text?.isEmpty == true ? "No name" : nameTextField.text ?? "No name",
            contactPhone: phoneTextField.text?.isEmpty == true ? "No phone" : phoneTextField.text ?? "No phone",
            contactEmail: emailTextField.text?.isEmpty == true ? "No email" : emailTextField.text ?? "no email"){ result in
             DispatchQueue.main.async {
                 switch result {
                 case .success(let contact):
                     self.delegate?.didSaveContact(contact: contact)
                     self.dismiss(animated: true, completion: nil)
                     
                 case .failure(let error):
                     print("Error in function : \(error.localizedDescription)  \(error)")
                 }
             }
         }
         
     }
}


protocol AddContactViewControllerDelegate: AnyObject {
    func didSaveContact(contact: Contact)
}
