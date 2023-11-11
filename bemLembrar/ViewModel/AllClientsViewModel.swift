//
//  AllClientsViewModel.swift
//  bemLembrar
//
//  Created by Henrique Semmer on 02/11/23.
//

import Foundation
import Contacts
import Combine

class AllClientsViewModel: ObservableObject {
    @Published var allClients = [Client]()
    
    @Published var client = Client.test
    
    @Published var searchText: String = ""
    
    @Published var isEditing = false
    @Published var isPresented = false
    
    var bag = Set<AnyCancellable>()
    
    func subscribe() {
        ClientDataSource.shared.$allClients.sink { clients in
            self.updateList()
        }.store(in: &bag)
    }
    
    func cancelSubscription() {
        for item in bag {
            item.cancel()
        }
        bag.removeAll()
    }
    
    func updateList() {
        allClients = ClientDataSource.shared.allClients
        
        if searchText != "" {
            allClients = allClients.filter{ c in
                let textFormat = searchText.lowercased()
                
                return c.fullName.lowercased().contains(textFormat)
            }
        }
    }
    
    func editList() {
        if isEditing {
            ClientDataSource.shared.allClients = allClients
        }
        
        if !allClients.isEmpty {
            isEditing.toggle()
        }
    }
    
    func delete() {
        ClientDataSource.shared.allClients.removeAll { c in
            c.identifier == client.identifier
        }
        
        updateList()
        
        recreateNotifications()
        
        if allClients.isEmpty {
            isEditing.toggle()
            ClientDataSource.shared.allClients = allClients
        }
    }
    
    func recreateNotifications() {
        NotificationManager.shared.cancelAllNotifications()
        
        for i in ClientDataSource.shared.allClients {
            if i.birthday != nil {
                NotificationManager.shared.scheduleNotification(fullName: i.fullName, date: i.birthday!.getMonthDay(), repeats: true)
            }
        }
    }
}
