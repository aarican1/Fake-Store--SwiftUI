//
//  SignInView.swift
//  Fake Store
//
//  Created by Abdurrahman Arıcan on 6.05.2025.
//


import SwiftUI

struct SignInView: View {
    @ObservedObject var viewModel : SignInViewModel = SignInViewModel()
    @Environment(Router.self) private var router
    @FocusState private var focusField: TextFieldView.FieldType?

    
    var body: some View {
        @Bindable var router = router
            VStack(alignment: .leading,){
                Spacer()
                Text("Welcome Back")
                    .font(.system(size: 28))
                    .frame(alignment: .leading)
                    .padding(.bottom,24)
                
                VStack(alignment: .leading,){
                    Text("Email")
                    TextFieldView(titleKey: "Enter your email address", text: $viewModel.requestModel.email, fieldType: .email)
                        .focused($focusField, equals: .email)
                        .onChange(of: viewModel.requestModel.email, { oldValue, newValue in
                            viewModel.validEmail()
                        })
                        .onSubmit {
                            focusField = .password
                        }
                        .submitLabel(.next)
                    
                    if !viewModel.emailError.isEmpty {
                        Text(viewModel.emailError)
                            .foregroundColor(.red)
                            .font(.caption)
                    }
                }
                .padding(.bottom, 16)
                
                
                VStack(alignment: .leading,){
                    Text("Password")
                    TextFieldView(titleKey: "Enter your password", text: $viewModel.requestModel.password, fieldType: .password)
                        .focused($focusField, equals: .password)
                        .onChange(of: viewModel.requestModel.password, { oldValue, newValue in
                            viewModel.validPassword()
                        })
                        .onSubmit {
                            focusField = nil
                        }
                    
                    if !viewModel.passwordError.isEmpty {
                        Text(viewModel.passwordError)
                            .foregroundColor(.red)
                            .font(.caption)
                    }
                    
                }
                .padding(.bottom,16)
                
                
                Button {
                    Task{
                        await  viewModel.signIn()
                    }
                } label: {
                    Text("Sign In")
                        .font(.title2)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .cornerRadius(12)
                }
                .padding(.bottom, 16)
                .alert(item:$viewModel.alertItem) {alertItem in
                    Alert(title: alertItem.title,message: alertItem.message,dismissButton: alertItem.dismissButton)
                }
                .onChange(of: viewModel.isSignIn) { oldValue, newValue in
                    if newValue == true {
                        router.setRoot(to:.mainTab)
                    }
                }
                
                HStack{
                    Spacer()
                    Button {
                        router.setRoot(to:.signUp)
                    } label: {
                        
                        if  viewModel.isLoading { ProgressView() }
                        else{
                            Text("Don't you have an account? Sign Up")
                                .font(.callout)
                                .foregroundStyle(.black)
                            
                        }
                        
                    }
                    Spacer()
                }
                Spacer()
            }
            .padding(.horizontal,24)
            .navigationBarBackButtonHidden()
    }
}

#Preview {
    SignInView()
        .environment(Router())
}
