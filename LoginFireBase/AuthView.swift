//
//  AuthView.swift
//  LoginFireBase
//
//  Created by Francisco Misael Landero Ychante on 05/06/20.
//  Copyright © 2020 Francisco Misael Landero Ychante. All rights reserved.
//

import SwiftUI

struct SingInView: View {
    @State var email: String = ""
    @State var password: String = ""
    @State var error: String = ""
    @State var keyboardValue : CGFloat = 0
    
    @EnvironmentObject var session: SessionStore
    
    func signIn(){
        session.signIn(email: email, password: password) { (result, error) in
            if let error = error {
                self.error = error.localizedDescription
                
            } else {
                self.email = ""
                self.password = ""
            }
        }
    }
   var body: some View {
    GeometryReader { geometry in
        VStack{
             circleColorIcon()
                .frame(width: geometry.size.width / 4, height: geometry.size.width / 4)
                
            Text("App Name")
                .font(.largeTitle)
                .foregroundColor(.blue)
            Text("Ingresa para continuar")
                .font(.headline)
                .foregroundColor(.secondary)
            
            VStack (spacing: 18){
                HStack{
                    Image(systemName: "envelope.circle.fill")
                    TextField("Correo electronico", text: self.$email)
                        .autocapitalization(.none)
                    
                }
                .padding(12)
                .frame(minWidth:0, maxWidth: 400)
                .background(RoundedRectangle(cornerRadius: 50).strokeBorder(Color.blue))
                .foregroundColor(.blue)
                HStack{
                    Image(systemName: "lock.circle.fill")
                    SecureField("Contraseña", text: self.$password)
                }
                .padding(12)
                .frame(minWidth:0, maxWidth: 400)
                .background(RoundedRectangle(cornerRadius: 50).strokeBorder(Color.blue))
                .foregroundColor(.blue)
                NavigationLink(destination: resetPasswordView()) {
                   HStack{
                       Text("¿Olvidaste tu contraseña?")
                   }
                }
                
            }
            HStack{
                if (self.error != ""){
                    Text(self.error)
                        .font(.body)
                        .foregroundColor(.red)
                }
            }.padding(10)
            
            Spacer()
            Button(action: self.signIn){
               PrymaryButton(text: "Ingresa", icon: "chevron.right.circle.fill")
            }
            
          
            NavigationLink(destination: signUpView()) {
                VStack{
                    HStack {
                        Text("¿Aún no tienes cuenta?")
                            .foregroundColor(.primary)
                    }
                    HStack{
                        Image(systemName: "person.crop.circle.fill.badge.plus")
                        Text("Crea una cuenta ahora")
                    }
                }
            }
            Spacer()
            
        }
        .padding(.horizontal, 32)
        .offset(y: -self.keyboardValue)
        .animation(.spring())
        .onAppear{
            NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main){ (noti) in
                let value = noti.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
                let height = value.height
                self.keyboardValue = height
            }
            NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main){ (noti) in
              
                self.keyboardValue = 0
            }
        }
    }
        
    }
}

struct signUpView: View {
    @State var email: String = ""
    @State var password: String = ""
    @State var error: String = ""
    @State var keyboardValue : CGFloat = 0
    
    @EnvironmentObject var session: SessionStore
    
    func singUp(){
        session.signUp(email: email, password: password) { (result, error) in
            if let error = error {
                self.error = error.localizedDescription
            } else {
                self.email = ""
                self.password = ""
            }
            
        }
    }
   var body: some View {
    GeometryReader { geometry in
        VStack{
            circleColorIconSystem(name: "person.crop.circle.fill.badge.plus")
                .frame(width: geometry.size.width / 3.4, height: geometry.size.width / 4)
            
            Text("Crear una cuenta nueva")
                    .font(.largeTitle)
                    .foregroundColor(.blue)

            Text("Registra tus datos para comenzar")
                .font(.headline)
                .foregroundColor(.secondary)
            
            VStack (spacing: 18){
                HStack{
                    Image(systemName: "envelope.circle.fill")
                    TextField("Correo electronico", text: self.$email)
                        .autocapitalization(.none)
                    
                }
                .padding(12)
                .frame(minWidth:0, maxWidth: 400)
                .background(RoundedRectangle(cornerRadius: 50).strokeBorder(Color.blue))
                .foregroundColor(.blue)
                
                HStack{
                    Image(systemName: "lock.circle.fill")
                    SecureField("Contraseña", text: self.$password)
                }
                .padding(12)
                .frame(minWidth:0, maxWidth: 400)
                .background(RoundedRectangle(cornerRadius: 50).strokeBorder(Color.blue))
                .foregroundColor(.blue)
                 
                
            }
          
            HStack{
                if (self.error != ""){
                    Text(self.error)
                        .font(.body)
                        .foregroundColor(.red)
                }
            }.padding(10)
                Spacer()
            
            Button(action: self.singUp){
                PrymaryButton(text: "Crea una cuenta", icon: "person.crop.circle.fill.badge.plus")
            }
            
            NavigationLink(destination: Text("Terminos y condiciones")) {
                VStack{
                        HStack {
                            Text("Al registrarte se entiende que aceptas ")
                                .foregroundColor(.primary)
                        }
                        HStack{
                            Image(systemName: "doc.plaintext")
                            Text("Nuestros Terminos y condiciones")
                        }
                    }
            }
            Spacer()
        }
        .padding(.horizontal, 32)
        .offset(y: -self.keyboardValue)
        .animation(.easeInOut(duration: 0.5))
        .onAppear{
            NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main){ (noti) in
                let value = noti.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
                let height = value.height
                self.keyboardValue = height
            }
            NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main){ (noti) in
              
                self.keyboardValue = 0
            }
        }
    }

    
    }
        
}

struct resetPasswordView: View {
    @State var email: String = ""
    @State var error: String = ""
    @State var keyboardValue : CGFloat = 0
    
    @EnvironmentObject var session: SessionStore
    
    func resetPassword(){
        session.sendPasswordReset(email: email) { (error) in
            if let error = error {
                self.error = error.localizedDescription
            } else {
                self.email = ""
            }
        }
    }
   var body: some View {
    GeometryReader { geometry in
        VStack{
            circleColorIconSystem(name: "arrow.clockwise.circle.fill")
                .frame(width: geometry.size.width / 3.4, height: geometry.size.width / 4)
            
            Text("Recupera tu contraseña")
                    .font(.largeTitle)
                    .foregroundColor(.blue)

            Text("Ingresa tu correo y te enviaremos un mensaje para que puedas recuperar tu contraseña.")
                .font(.headline)
                .foregroundColor(.secondary)
            
            VStack (spacing: 18){
                HStack{
                    Image(systemName: "envelope.circle.fill")
                    TextField("Correo electronico", text: self.$email)
                        .autocapitalization(.none)
                }
                .padding(12)
                .frame(minWidth:0, maxWidth: 400)
                .background(RoundedRectangle(cornerRadius: 50).strokeBorder(Color.blue))
                .foregroundColor(.blue)
                Text("Si tu correo esta registrado en nuestros servidores recibiras un mensaje en unos minutos.")
                .font(.headline)
                .foregroundColor(.secondary)
            }
          
            HStack{
                if (self.error != ""){
                    Text(self.error)
                        .font(.body)
                        .foregroundColor(.red)
                }
            }.padding(10)
                Spacer()
            
            Button(action: self.resetPassword){
                PrymaryButton(text: "Recuperar contraseña", icon: "arrow.clockwise.circle.fill")
            }
            
           
            Spacer()
        }
        .padding(.horizontal, 32)
        .offset(y: -self.keyboardValue)
        .animation(.easeInOut(duration: 0.5))
        .onAppear{
            NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main){ (noti) in
                let value = noti.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
                let height = value.height
                self.keyboardValue = height
            }
            NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main){ (noti) in
                self.keyboardValue = 0
            }
        }
    }
    }
}
struct AuthView: View {
    var body: some View {
        NavigationView {
            SingInView()
        }
    }
}

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView().environmentObject(SessionStore())
    }
}
