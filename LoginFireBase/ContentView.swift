//
//  ContentView.swift
//  LoginFireBase
//
//  Created by Francisco Misael Landero Ychante on 05/06/20.
//  Copyright © 2020 Francisco Misael Landero Ychante. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var session : SessionStore
    @State private var selection = 0
    
    private var NavigationBartitles = ["Inicio", "Clientes", "Productos"]
    
    func getUser(){
        session.listen()
    }
    
    var body: some View {
        Group {
            if (session.session != nil) {
                NavigationView{
                    TabView(selection: $selection){
                        Text("Hola \(session.session?.email ?? "No email")")
                        .tabItem {
                                VStack {
                                    Image(systemName: "house.fill")
                                    Text("Inicio")
                                }
                            }
                            .tag(0)
                        
                        Text("Second View")
                            .font(.title)
                             
                            .tabItem {
                                VStack {
                                    Image(systemName: "person.2")
                                    Text("Clientes")
                                }
                            }
                            .tag(1)
                        Text("Third View")
                            .font(.title)
                            .tabItem {
                                VStack {
                                    Image(systemName: "cube.box")
                                    Text("Productos")
                                }
                        }
                        .tag(2)
                    }
                    .navigationBarTitle(NavigationBartitles[selection])
                    .navigationBarItems( trailing: HStack {
                        NavigationLink(destination: UserSettingsView(session: self.session).environmentObject(SessionStore()) ) {
                                       Image(systemName: "gear")
                                   }
                    }.font(.headline))
                }
            } else {
                AuthView()
            }
        }.onAppear(perform: getUser)
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(SessionStore())
    }
}
