//
//  SignUpView.swift
//  Fake Store
//
//  Created by Abdurrahman Arıcan on 11.05.2025.
//

import SwiftUI

struct SignUpView: View {
    @ObservedObject var viewModel = SignUpViewModel()
    @Environment(Router.self) private var router
    @FocusState private var focusField: TextFieldView.FieldType?
    
    var body: some View {
        @Bindable var router = router
        VStack(alignment: .leading,){
            Spacer()
            Text("Create Account")
                .font(.system(size: 28))
                .frame(alignment: .leading)
                .padding(.bottom,24)
            
            VStack(alignment: .leading,){
                Text("Name")
                TextFieldView(titleKey: "Enter your name", text: $viewModel.requestModel.name, fieldType: .text)
                    .focused($focusField, equals: .text)
                    .onChange(of: viewModel.requestModel.name, { oldValue, newValue in
                        viewModel.validName()
                    })
                    .onSubmit {
                        focusField = .email
                    }
                    .submitLabel(.next)
                
                if !viewModel.nameError.isEmpty {
                    Text(viewModel.nameError)
                        .foregroundColor(.red)
                        .font(.caption)
                }
            }
            .padding(.bottom, 16)
            
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
                    await  viewModel.signUp()
                }
            } label: {
                if  viewModel.isLoading { ProgressView() }
                else{  Text("Sign Up")
                        .font(.title2)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .cornerRadius(12)
                }
            }
            .padding(.bottom, 16)
            .alert(item:$viewModel.alertItem) {alertItem in
                Alert(title: alertItem.title,message: alertItem.message,dismissButton: alertItem.dismissButton)
            }
            .onChange(of: viewModel.isSignUp) { oldValue, newValue in
                if newValue == true {
                    router.setRoot(to:.signIn)
                }
            }
            
            HStack{
                Spacer()
                Button {
                    router.setRoot(to:.signUp)
                } label: { Text("Do you have an account? Sign In")
                            .font(.callout)
                            .foregroundStyle(.black)
                }
                Spacer()
            }
            
            Spacer()
            
               
        }
            .overlay(alignment: .bottom) {
                if viewModel.isShowingToast {
                    CustomToastView(message: "Your account has been created successfully.")
                        .allowsHitTesting(false)
                        .transition(.move(edge: .top).combined(with: .opacity))
                        .frame(minWidth: 500)
                        .onChange(of:viewModel.isShowingToast) { oldValue, newValue in
                    	  if newValue {
                    	       DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    	           withAnimation {
                    	       viewModel.isShowingToast = false
                    	          }
                    	      }
                    	    }
                    	  }
            }
            
        }
            .padding(.horizontal,24)
            .navigationBarBackButtonHidden()
            .navigationDestination(for: Router.Destination.self) { destination in
               
                if destination == Router.Destination.signIn {
                    SignInView()
                }
            
        }
    }
}

#Preview {
    SignUpView()
        .environment(Router())
}
