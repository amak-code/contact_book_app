//
//  ViewController.swift
//  ContactBookApp
//
//  Created by antikiller on 4/4/23.
//

import UIKit



class ContactsTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    //Cell class
    
    class ContactCell: UITableViewCell{
       
        var id = UILabel()
        var name = UILabel()
        var phone = UILabel()
        var email = UILabel()
        let button = UIButton()
        
        
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
                super.init(style: style, reuseIdentifier: "contactCell")
                
                button.setTitle("Edit", for: .normal)
                button.addTarget(self, action: #selector(buttonEdit(_:)), for: .touchUpInside)
                contentView.addSubview(id)
                contentView.addSubview(name)
                contentView.addSubview(phone)
                contentView.addSubview(email)
                contentView.addSubview(button)
            
                // Set label properties
                id.font = UIFont.boldSystemFont(ofSize: 14)
                name.font = UIFont.systemFont(ofSize: 16)
                phone.font = UIFont.systemFont(ofSize: 14)
                email.font = UIFont.systemFont(ofSize: 14)
                button.backgroundColor = .systemMint
                
                // Set label constraints
                let padding: CGFloat = 10
                id.translatesAutoresizingMaskIntoConstraints = false
                name.translatesAutoresizingMaskIntoConstraints = false
                phone.translatesAutoresizingMaskIntoConstraints = false
                email.translatesAutoresizingMaskIntoConstraints = false
                button.translatesAutoresizingMaskIntoConstraints = false
                
                NSLayoutConstraint.activate([
                    id.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
                    id.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
                    name.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
                    name.topAnchor.constraint(equalTo: id.bottomAnchor, constant: padding),
                    phone.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
                    phone.topAnchor.constraint(equalTo: name.bottomAnchor, constant: padding),
                    email.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
                    email.topAnchor.constraint(equalTo: phone.bottomAnchor, constant: padding),
                    email.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding),
                    button.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
                    button.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant:  -16),
                    button.widthAnchor.constraint(equalToConstant: 110)
                ])
            }
        
            @objc func buttonEdit(_ sender: UIButton){
                sender.backgroundColor = UIColor.gray
                
                print("Edit button")
            
            }
            
            required init?(coder aDecoder: NSCoder) {
                fatalError("init(coder:) has not been implemented")
            }
        
    }//end of Cell class
    
    
    
    var contacts: [Contact] = []

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        
        let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath) as! ContactCell
        let contact = contacts[indexPath.row]
        
        cell.id.text = String(contact.id)
        cell.name.text = contact.name
        cell.phone.text = contact.phone
        cell.email.text = contact.email
        
        
        return cell
        
    }
    
    
    //delete method
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            let deletedContact = contacts[indexPath.row]
            ContactController.deleteContact(contactId: deletedContact.id) { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success():
                        self.contacts.remove(at: indexPath.row)
                        self.contactTableView.deleteRows(at: [indexPath], with: .fade)
                    case .failure(let error):
                        print("Error in function : \(error.localizedDescription)  \(error)")
                    }
                }
            }
            
        }
        
    }
    

    var safeArea: UILayoutGuide{
        return self.view.safeAreaLayoutGuide
        
    }
    
    
    
    
    //method for addButton to perform the action when the button is tapped
    @objc func addButtonTapped() {
        let addContactScreen = AddContactViewController()
        navigationController?.pushViewController(addContactScreen, animated:
                                                    false)
        addContactScreen.title = "Create new contact"
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemMint
        view.addSubview(contactTableView)
        configureTableView()
        constrainTableView()
        
        
        // create a navigation controller
       // let navController = UINavigationController(rootViewController: self)
        //navController.navigationBar.prefersLargeTitles = true

        // set the navigation controller as the root view controller
//        UIApplication.shared.windows.first?.rootViewController = navController
//        UIApplication.shared.windows.first?.makeKeyAndVisible()
        
        //adding "add" button to the navigation menu
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem = addButton
    
        
        //fetching contacts
        ContactController.fetchContacts { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let contacts):
                    self.contacts = contacts
                    self.contactTableView.reloadData()
                case .failure(let error):
                    print("Error in function : \(error.localizedDescription)  \(error)")
                }
            }
        }
    }
    
  
    
    //creating table
    let contactTableView:UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    func configureTableView(){
        contactTableView.dataSource = self
        contactTableView.delegate = self
        contactTableView.register(ContactCell.self, forCellReuseIdentifier: "contactCell")
        contactTableView.allowsSelection = false
    }
    
    func constrainTableView(){
        NSLayoutConstraint.activate([
            contactTableView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            contactTableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            contactTableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            contactTableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor)
        
        ])
    }

}

