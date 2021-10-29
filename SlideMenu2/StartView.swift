//
//  StartView.swift
//  SlideMenu2
//
//  Created by Mher Melkonyan on 10/26/21.
//

import SwiftUI

struct StartView: View {
    @Environment(\.localStatusBarStyle) var statusBarStyle
    @Environment(\.presentationMode) var presentationMode

    @State var showMenu: Bool = false
    @State var darkModeOn: Bool = false
    //    @State var moonButtonDidTapped: Bool = false

    var body: some View {
        let drag = DragGesture()
            .onEnded {
                if $0.translation.width < -100 {
                    withAnimation {
                        self.showMenu = false
                    }
                }
            }
        
        if self.darkModeOn {
            self.statusBarStyle.currentStyle = .lightContent
        } else {
            self.statusBarStyle.currentStyle = .default
        }
        
        return NavigationView {
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    MainView(showMenu: self.$showMenu)
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .offset(x: self.showMenu ? geometry.size.width / 2 : 0)
                        .disabled(self.showMenu ? true : false)
                    if self.showMenu {
                        MenuView(darkModeOn: $darkModeOn)
                            .frame(width: geometry.size.width / 2)
                            .transition(.move(edge: .leading))
                    }
                }
                .gesture(drag)
                .navigationBarItems(
                    leading: (
                        Button(action: {
                            withAnimation {
                                self.showMenu.toggle()
                            }
                        }) {
                            Image(systemName: "line.horizontal.3")
                                .imageScale(.large)
                        }
                    )
                )
                
            }
            .background(darkModeOn ? Color.black : Color.white)
            .edgesIgnoringSafeArea(.all)
        }
    }
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
    }
}

struct MainView: View {
    @Binding var showMenu: Bool
    
    var buttonName: String = "Show Menu"
    
    var body: some View {
        Button(action: {
            withAnimation {
                self.showMenu = true
            }
        }, label: {
            Text("\(buttonName)")
        })
    }
}

//trailing: (
//    Button(action: {
//        self.moonButtonDidTapped.toggle()
//
//        if moonButtonDidTapped {
//            self.statusBarStyle.currentStyle = .lightContent
//        } else {
//            self.statusBarStyle.currentStyle = .default
//        }
//    }) {
//        Image(systemName: "moon.fill")
//            .imageScale(.large)
//    }
//)


// Firebase SlideMenu
// slidemenu-723b3


extension Color {
    static let loginPageColor = Color("login_page_color")
}


