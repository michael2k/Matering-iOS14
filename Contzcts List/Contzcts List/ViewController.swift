//
//  ViewController.swift
//  Contzcts List
//
//  Created by Michael M. Kim on 2021/06/20.
//

import UIKit
import Contacts

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        requestContacts()
    }

    private func requestContacts() {
        
        let store = CNContactStore()
        let authorizationStatus = CNContactStore.authorizationStatus(for: .contacts)
        if authorizationStatus == .notDetermined {
            store.requestAccess(for: .contacts) { [weak self] didAuthorize, error in
                if didAuthorize {
                    self?.retrieveContacts(from: store)
                }
            }
        } else if authorizationStatus == .authorized {
            retrieveContacts(from: store)
        }
    }

    func retrieveContacts(from store: CNContactStore) {
        let containerId = store.defaultContainerIdentifier()
        let predicate = CNContact.predicateForContactsInContainer(withIdentifier: containerId)
        let keysToFetch = [CNContactGivenNameKey as CNKeyDescriptor, CNContactFamilyNameKey as CNKeyDescriptor, CNContactImageDataAvailableKey as CNKeyDescriptor, CNContactImageDataKey as CNKeyDescriptor]
        
        let contacts = try! store.unifiedContacts(matching: predicate, keysToFetch: keysToFetch)
        
    }
    
    class ContactCell: UITableViewCell {
        @IBOutlet weak var nameLabel: UILabel!
        @IBOutlet weak var contactImageView: UIImageView!
        
    }
}

