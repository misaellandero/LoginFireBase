//
//  UserSettingsView.swift
//  LoginFireBase
//
//  Created by Francisco Misael Landero Ychante on 06/04/20.
//  Copyright © 2020 Francisco Misael Landero Ychante. All rights reserved.
//

import SwiftUI

struct UserSettingsView: View {
    @ObservedObject var session : SessionStore
    var body: some View {
            List {
                Section (header: HStack{Image(systemName: "person.crop.circle.fill")
                    Text("Datos de la sesión")}){
                    HStack{
                        Image(systemName: "envelope.circle.fill")
                        Text(String(session.session?.email ?? "No especificado")) 
                    }
                    NavigationLink(destination: resetPasswordView()) {
                       HStack{
                        Image(systemName: "arrow.clockwise.circle.fill")
                        Text("Restablece tu contraseña")
                       }
                    }
                     
                    HStack{
                        Image(systemName: "xmark.circle.fill")
                        Button(action: session.signOut){
                            Text("Salir")
                        }
                    }
                    .foregroundColor(.red)
                }
                
                Section (header: HStack{Image(systemName: "info.circle.fill")
                    Text("Acerca de ")}){
                        HStack{
                            Text("Version de la App")
                            Spacer()
                            Text("Alfa 0.1")
                                .foregroundColor(.secondary)
                        }
                        NavigationLink(destination: Text("Landercorp.mx")) {
                            HStack{
                                Text("Acerca del desarrollador")
                            }
                        }
                }
            }
            .listStyle(GroupedListStyle())
            .environment(\.horizontalSizeClass, .regular)
            .navigationBarTitle("Configuraciones")
    
    }
}

struct UserSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        UserSettingsView(session: SessionStore())
    }
}
