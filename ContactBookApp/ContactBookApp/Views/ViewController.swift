//
//  ViewController.swift
//  ContactBookApp
//
//  Created by antikiller on 4/4/23.
//

import UIKit



class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    class ContactCell: UITableViewCell{
       
        var id = UILabel()
        var name = UILabel()
        var phone = UILabel()
        var email = UILabel()
        
        
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
                super.init(style: style, reuseIdentifier: "contactCell")
                
                contentView.addSubview(id)
                contentView.addSubview(name)
                contentView.addSubview(phone)
                contentView.addSubview(email)
                
                // Set label properties
                id.font = UIFont.boldSystemFont(ofSize: 14)
                name.font = UIFont.systemFont(ofSize: 16)
                phone.font = UIFont.systemFont(ofSize: 14)
                email.font = UIFont.systemFont(ofSize: 14)
                
                // Set label constraints
                let padding: CGFloat = 10
                id.translatesAutoresizingMaskIntoConstraints = false
                name.translatesAutoresizingMaskIntoConstraints = false
                phone.translatesAutoresizingMaskIntoConstraints = false
                email.translatesAutoresizingMaskIntoConstraints = false
                
                NSLayoutConstraint.activate([
                    id.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
                    id.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
                    name.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
                    name.topAnchor.constraint(equalTo: id.bottomAnchor, constant: padding),
                    phone.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
                    phone.topAnchor.constraint(equalTo: name.bottomAnchor, constant: padding),
                    email.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
                    email.topAnchor.constraint(equalTo: phone.bottomAnchor, constant: padding),
                    email.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding)
                ])
            }
            
            required init?(coder aDecoder: NSCoder) {
                fatalError("init(coder:) has not been implemented")
            }
        
    }
    
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
    
    

    var safeArea: UILayoutGuide{
        return self.view.safeAreaLayoutGuide
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemMint
        view.addSubview(contactTableView)
        configureTableView()
        constrainTableView()
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

