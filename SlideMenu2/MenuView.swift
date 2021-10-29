//
//  MenuView.swift
//  SlideMenu2
//
//  Created by Mher Melkonyan on 10/26/21.
//

import SwiftUI

struct MenuView: View {
    @State private var showSettings = false
    @State private var showingSheet = false
    @Binding var darkModeOn: Bool
    
    @Environment(\.managedObjectContext) var moc
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "person")
                    .foregroundColor(.gray)
                    .imageScale(.large)
                Text("Profile")
                    .foregroundColor(.gray)
                    .font(.headline)
            }
            .padding(.top, 100)
            HStack {
                Image(systemName: "envelope")
                    .foregroundColor(.gray)
                    .imageScale(.large)
                Text("Messages")
                    .foregroundColor(.gray)
                    .font(.headline)
                }
            .padding(.top, 30)
            HStack {
                Image(systemName: "gear")
                    .foregroundColor(.gray)
                    .imageScale(.large)
                Text("Settings")
                    .foregroundColor(.gray)
                    .font(.headline)
            }
            .padding(.top, 30)
            .onTapGesture {
                withAnimation {
                    showSettings.toggle()
                }
            }
            if showSettings {
                VStack {
                    Text("See information about your account, download an archive of your data, or learn about your account deactivation options.")
                        .foregroundColor(.gray)
                        .font(.headline)
                        .multilineTextAlignment(.center)
                    Toggle("Dark Mode", isOn: $darkModeOn)
                        .onChange(of: darkModeOn) { _ in }
                        .foregroundColor(.gray)
                        .font(.headline)
                }
                .padding(.top, 30)
                .transition(.scale)
            }
            HStack {
                Image(systemName: "info.circle")
                    .foregroundColor(.gray)
                    .imageScale(.large)
                Text("About")
                    .foregroundColor(.gray)
                    .font(.headline)
                    
            }
            .padding(.top, 30)
            Button("To Do List") {
                showingSheet.toggle()
            }
            .padding(.top, 30)
            .foregroundColor(.gray)
            .sheet(isPresented: $showingSheet) {
                ToDoListView().environment(\.managedObjectContext, self.moc)
            }
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(red: 32/255, green: 32/255, blue: 32/255))
        .edgesIgnoringSafeArea(.all)
    }
}

//struct MenuView_Previews: PreviewProvider {
//    static var previews: some View {
//        MenuView()
//    }
//}

struct AboutMenu: View {
    @Binding var isHidden: Bool
    
    var body: some View {
        HStack {
            Text("SwiftUI is an innovative, exceptionally simple way to build user interfaces across all Apple platforms with the power of Swift.")
                .padding()
                .multilineTextAlignment(.center)
                .overlay(
                    Capsule(style: .continuous)
                        .stroke(
                            Color.gray, style: StrokeStyle(lineWidth: 2, dash: [20])
                        )
                )
                .foregroundColor(.gray)
                .opacity(isHidden ? 0 : 1)
        }
    }
}
