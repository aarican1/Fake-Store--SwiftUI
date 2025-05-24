//
//  UserInformationView.swift
//  Fake Store
//
//  Created by Abdurrahman Arıcan on 24.05.2025.
//

import SwiftUI

struct UserInformationView: View {
    let profile : ProfileResponseModel
    var body: some View {
        HStack(alignment: .top, spacing:24){
            CustomAsyncImageView(url: profile.avatar)
                .frame(width:96, height: 96)
                .clipShape(Circle())
            
            VStack(alignment:.leading, spacing:16) {
                Text(profile.name)
                    .font(.title2)
                    .bold()
                
                Text(profile.email)
                    .font(.subheadline)
                
            }
            Spacer()
            Button {
                print("edit button tapped")
            } label: {
                Image(systemName: "pencil")
                    .resizable()
                    .foregroundStyle(Color.gray)
                    .frame(width: 20,height: 20)
            }

            
            
        }
        .padding()
        .background(Color.green.opacity(0.09))
        .cornerRadius(12)
        
      

       
    }
    
}

#Preview {
    UserInformationView(profile: mockProfile)
}
