//
//  TabView.swift
//  PBT Tournaments
//
//  Created by Caedmon Myers on 4/28/23.
//

import SwiftUI


struct OtherView: View {
    var body: some View {
        Text("Coming Soon")
            .font(.title)
            .padding()
    }
}

struct CustomTabView: View {
    @State private var selectedTab = 0
    let borderColor = Color("theblue")
    
    @EnvironmentObject var dataManager: DataManager
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                switch selectedTab {
                case 0:
                    ContentView()
                        .environmentObject(dataManager)
                case 1:
                    OtherView()
                case 2:
                    Create()
                        .environmentObject(dataManager)
                case 3:
                    OtherView()
                default:
                    ContentView()
                        .environmentObject(dataManager)
                }
                
                VStack {
                    Spacer()
                    
                    ZStack {
                        Color(hex: "F6FBFF")
                            .frame(height: 100)
                            .cornerRadius(40)
                            .overlay(
                                RoundedRectangle(cornerRadius: 40)
                                    .stroke(Color(hex: "DBDFE4"), lineWidth: 2)
                            )
                            
                        HStack {
                            Spacer()
                                .frame(width: selectedTab == 3 ? .infinity: 60)
                            
                            RoundedRectangle(cornerRadius: 40)
                                .stroke(Color("theblue"), lineWidth: 2)
                                .frame(width: 55, height: 20)
                                .padding([.top], 20)
                                .transition(.move(edge: .bottom))
                                .animation(.spring(response: 0.5, dampingFraction: 0.8, blendDuration: 0))
                            
                            Spacer()
                                .frame(width: selectedTab == 0 ? .infinity: 60)
                        }
                        
                        HStack {
                            
                            Spacer()
                                .frame(width: 50)
                            
                            Button(action: {
                                selectedTab = 0
                                impact.impactOccurred()
                            }) {
                                TabIcon(iconName: "figure.pickleball", labelText: "Home").hoverEffect(.highlight)
                                /*VStack {
                                 Image(systemName: "figure.pickleball")
                                 .resizable()
                                 .bold()
                                 .scaledToFit()
                                 .frame(height: 30)
                                 
                                 Text("Home")
                                 .padding(2)
                                 .padding([.leading, .trailing], 10)
                                 .overlay(
                                 RoundedRectangle(cornerRadius: 50)
                                 .stroke(selectedTab == 0 ? borderColor : Color.clear, lineWidth: 2)
                                 )
                                 }*/
                            }.shadow(color: Color(hex: "81C0FF"), radius: 15, x: 0, y: 0)
                            .accentColor(selectedTab == 0 ? borderColor: Color("thegrey"))
                            
                            //Spacer()
                            
                            /*Button(action: {
                                selectedTab = 1
                            }) {
                                TabIcon(iconName: "sportscourt", labelText: "Brackets")
                            }*/
                            
                            Spacer()
                            
                            Button(action: {
                                selectedTab = 2
                                impact.impactOccurred()
                            }) {
                                TabIcon(iconName: "pencil.and.outline", labelText: "Create").hoverEffect(.highlight)
                            }.accentColor(selectedTab == 2 ? borderColor: Color("thegrey"))
                            
                            Spacer()
                            
                            Button(action: {
                                selectedTab = 3
                                impact.impactOccurred()
                            }) {
                                TabIcon(iconName: "person.crop.circle", labelText: "Profile").hoverEffect(.highlight)
                            }.accentColor(selectedTab == 3 ? borderColor: Color("thegrey"))
                            
                            Spacer()
                                .frame(width: 50)
                            
                        }.padding([.bottom], 0)
                            .padding(.bottom)
                    }
                }.ignoresSafeArea()
            }
        }
    }
}


struct TabIcon: View {
    @State var iconName: String
    @State var labelText: String
    var body: some View {
        VStack {
            Image(systemName: iconName)
                .resizable()
                .bold()
                .scaledToFit()
                .frame(maxWidth: 30, maxHeight: 25)
            
            Text(labelText)
                .font(.caption)
                .bold()
                //.padding(2)
                //.padding([.leading, .trailing], 10)
        }.frame(width: 75)
    }
}


struct CustomTabView_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabView()
    }
}

