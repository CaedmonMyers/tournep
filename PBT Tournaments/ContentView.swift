//
//  ContentView.swift
//  PBT Tournaments
//
//  Created by Caedmon Myers on 4/28/23.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var dataManager: DataManager
    @State var shownID = ""
    
    let defaultHeight = CGFloat(150)
    
    @State var currentPadding = CGFloat(10)
    
    @State var theHeight = CGFloat(150)
    
    @State var offset = CGSize.zero
    
    @State var showJoin = false
    
    var body: some View {
        ZStack {
            NavigationStack {
                ZStack {
                    //Color(hex: "F6FBFF").ignoresSafeArea()
                    
                    ScrollView {
                        //ActiveVGrid(data: dataManager.tournaments).environmentObject(dataManager)
                        VStack {
                            ForEach(dataManager.tournaments, id:\.id) { event in
                                if shownID == event.id || shownID == "" {
                                    VStack {
                                        ZStack {
                                            Color("theblue")
                                                .cornerRadius(30)
                                                .frame(height: theHeight)
                                                .overlay {
                                                    RoundedRectangle(cornerRadius: 30)
                                                        .stroke(lineWidth: !shownID.isEmpty ? 0: 2)
                                                        .foregroundColor(.white)
                                                }
                                                .shadow(color: Color("theblue"), radius: 10, x: 0, y: 7)
                                            
                                            
                                            VStack {
                                                Text(event.name)
                                                    .bold()
                                                    .font(!shownID.isEmpty ? .title: .body)
                                                    .fontWidth(!shownID.isEmpty ? .expanded: .standard)
                                                    .foregroundColor(.white)
                                                    //.animation(.default)
                                                
                                                if !shownID.isEmpty {
                                                    Text("Total Spots: \(event.slots)")
                                                        .foregroundColor(.white)
                                                        .padding(10)
                                                    
                                                    Link(destination: URL(string: "\(event.location)")!) {
                                                        ZStack {
                                                            Color(hex: directionsButton)
                                                                .cornerRadius(15)
                                                            
                                                            HStack {
                                                                Image(systemName: "map")
                                                                    .resizable()
                                                                    .scaledToFit()
                                                                    .frame(height: 30)
                                                                    .foregroundColor(Color("theblue"))
                                                                    .shadow(color: Color("theblue"), radius: 5, x: 0, y: 7)
                                                                
                                                                Text("Get Directions")
                                                                    .padding(10)
                                                                    .foregroundColor(Color("theblue"))
                                                                    .shadow(color: Color("theblue"), radius: 5, x: 0, y: 7)
                                                            }
                                                            
                                                        }.frame(width: 250, height: 60).shadow(color: .white, radius: 10)
                                                    }
                                                }
                                            }
                                        }
                                        
                                        if !shownID.isEmpty {
                                            Text(event.description)
                                        }
                                        
                                    }.padding(5)
                                        .offset(x: offset.width, y: offset.height)
                                        .gesture(
                                            DragGesture()
                                                .onChanged { value in
                                                    let threshold: CGFloat = 50
                                                    if abs(value.translation.width) > threshold {
                                                        shownID != "" ? offset.width = min(max(value.translation.width, -60), 60) : ()
                                                    }
                                                    
                                                    if abs(value.translation.height) > threshold {
                                                        offset.height = min(max(value.translation.height, -40), 40)
                                                    }
                                                }
                                                .onEnded { value in
                                                    let threshold: CGFloat = 50
                                                    if abs(value.translation.width) > threshold {
                                                        if value.translation.width > 0 {
                                                            // Swiped to the right
                                                            shownID = ""
                                                            theHeight = defaultHeight
                                                            currentPadding = 10
                                                            
                                                        } else {
                                                            // Swiped to the left
                                                            shownID = ""
                                                            theHeight = defaultHeight
                                                            currentPadding = 10
                                                        }
                                                    }
                                                    withAnimation {
                                                        offset = .zero
                                                    }
                                                }
                                        )
                                        .onTapGesture {
                                            /*if shownID != "" {
                                             shownID = ""
                                             }
                                             else {
                                             shownID = event.id
                                             }
                                             
                                             if currentPadding != 0 {
                                             currentPadding = 0
                                             theHeight = 450
                                             }
                                             else {
                                             currentPadding = 10
                                             theHeight = 250
                                             }*/
                                            shownID = event.id
                                            theHeight = 450
                                            currentPadding = 0
                                        }
                                    //.transition(.move(edge: .bottom))
                                        .animation(.spring(response: 0.5, dampingFraction: 0.9, blendDuration: 0))
                                }
                            }
                            
                            Spacer()
                                .frame(height: 100)
                            
                            /*ZStack {
                             Color("theblue")
                             .frame(height: 250)
                             .cornerRadius(30)
                             }.padding(5)
                             ZStack {
                             Color("theblue")
                             .frame(height: 250)
                             .cornerRadius(30)
                             }.padding(5)*/
                        }.padding(currentPadding).ignoresSafeArea()
                        /*LazyVGrid(columns: shownID != "" ? [GridItem()]: [GridItem(), GridItem(spacing: 0)], content: {
                            ForEach(dataManager.tournaments, id:\.id) { event in
                                if shownID == event.id || shownID == "" {
                                    VStack {
                                        ZStack {
                                            Color("theblue")
                                                .cornerRadius(30)
                                                .frame(height: theHeight)
                                            
                                            VStack {
                                                Text(event.name)
                                                    .bold()
                                                    .foregroundColor(.white)
                                                    .animation(.default)
                                                
                                                if !shownID.isEmpty {
                                                    Link(destination: URL(string: "\(event.location)")!) {
                                                        ZStack {
                                                            Color(hex: directionsButton)
                                                                .cornerRadius(15)
                                                            
                                                            HStack {
                                                                Image(systemName: "map")
                                                                    .resizable()
                                                                    .scaledToFit()
                                                                    .frame(height: 30)
                                                                    .foregroundColor(Color("theblue"))
                                                                    .shadow(color: Color("theblue"), radius: 5, x: 0, y: 7)
                                                                
                                                                Text("Get Directions")
                                                                    .padding(10)
                                                                    .foregroundColor(Color("theblue"))
                                                                    .shadow(color: Color("theblue"), radius: 5, x: 0, y: 7)
                                                            }
                                                            
                                                        }.frame(width: 250, height: 60).shadow(color: .white, radius: 10)
                                                    }
                                                }
                                            }
                                        }
                                        
                                        if !shownID.isEmpty {
                                            Text(event.description)
                                        }
                                        
                                    }.padding(5)
                                        .offset(x: offset.width, y: offset.height)
                                        .gesture(
                                            DragGesture()
                                                .onChanged { value in
                                                    let threshold: CGFloat = 50
                                                    if abs(value.translation.width) > threshold {
                                                        shownID != "" ? offset.width = min(max(value.translation.width, -60), 60) : ()
                                                    }
                                                    
                                                    if abs(value.translation.height) > threshold {
                                                        offset.height = min(max(value.translation.height, -40), 40)
                                                    }
                                                }
                                                .onEnded { value in
                                                    let threshold: CGFloat = 50
                                                    if abs(value.translation.width) > threshold {
                                                        if value.translation.width > 0 {
                                                            // Swiped to the right
                                                            shownID = ""
                                                            theHeight = 250
                                                            currentPadding = 10
                                                            
                                                        } else {
                                                            // Swiped to the left
                                                            shownID = ""
                                                            theHeight = 250
                                                            currentPadding = 10
                                                        }
                                                    }
                                                    withAnimation {
                                                        offset = .zero
                                                    }
                                                }
                                        )
                                        .onTapGesture {
                                            /*if shownID != "" {
                                             shownID = ""
                                             }
                                             else {
                                             shownID = event.id
                                             }
                                             
                                             if currentPadding != 0 {
                                             currentPadding = 0
                                             theHeight = 450
                                             }
                                             else {
                                             currentPadding = 10
                                             theHeight = 250
                                             }*/
                                            shownID = event.id
                                            theHeight = 450
                                            currentPadding = 0
                                        }
                                    //.transition(.move(edge: .bottom))
                                        .animation(.spring(response: 0.5, dampingFraction: 0.9, blendDuration: 0))
                                }
                            }
                            
                            /*ZStack {
                             Color("theblue")
                             .frame(height: 250)
                             .cornerRadius(30)
                             }.padding(5)
                             ZStack {
                             Color("theblue")
                             .frame(height: 250)
                             .cornerRadius(30)
                             }.padding(5)*/
                        }).padding(currentPadding).ignoresSafeArea()*/
                    }.scrollDisabled(shownID == "" ? false: true)
                        .toolbar {
                            ToolbarItem {
                                HStack {
                                    Button {
                                        showJoin = true
                                    } label: {
                                        ZStack {
                                            Color(.white)
                                                .cornerRadius(10)
                                                .frame(width: 100, height: 40)
                                                .overlay {
                                                    RoundedRectangle(cornerRadius: 10)
                                                        .stroke(lineWidth: 1)
                                                        .foregroundColor(.white)
                                                }
                                            
                                            HStack {
                                                Image(systemName: "plus")
                                                    .resizable()
                                                    .scaledToFit()
                                                    .bold()
                                                    .frame(width: 20, height: 20)
                                                    .foregroundColor(Color("theblue"))
                                                    .shadow(color: Color("theblue"), radius: 5, x: 0, y: 7)
                                                
                                                Text("Join")
                                                    .foregroundColor(Color("theblue"))
                                                    .shadow(color: Color("theblue"), radius: 5, x: 0, y: 7)
                                            }
                                        }.hoverEffect(.highlight)
                                        .frame(width: 250, height: 60)
                                        .shadow(color: .white, radius: 10)
                                    }.offset(x: 0)
                                }
                            }
                        }
                }
                
            }.scrollContentBackground(.hidden)
        }.onAppear {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithTransparentBackground()
            appearance.shadowColor = .clear
            
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().compactAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
        }
    }
}

struct HomeNavigationBar: View {
    @State var showJoin = false
    var body: some View {
        //GeometryReader { geo in
            HStack {
                ZStack {
                    Color(.white)
                        .cornerRadius(10)
                        .frame(width: 100, height: 40)
                        .overlay {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(lineWidth: 1)
                                .foregroundColor(.white)
                        }
                    
                    Text("Home")
                        .font(.body.width(.expanded))
                        .bold()
                        .foregroundColor(Color("theblue"))
                        .shadow(color: Color("theblue"), radius: 5, x: 0, y: 7)
                }.frame(width: 250, height: 60)
                    .shadow(color: .white, radius: 20)
                
                Spacer()
                    //.frame(minWidth: 150)
                
                Button {
                    showJoin = true
                } label: {
                    ZStack {
                        Color(.white)
                            .cornerRadius(10)
                            .frame(width: 100, height: 40)
                            .overlay {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(lineWidth: 1)
                                    .foregroundColor(.white)
                            }
                        
                        HStack {
                            Image(systemName: "plus")
                                .resizable()
                                .scaledToFit()
                                .bold()
                                .frame(width: 20, height: 20)
                                .foregroundColor(Color("theblue"))
                                .shadow(color: Color("theblue"), radius: 5, x: 0, y: 7)
                            
                            Text("Join")
                                .foregroundColor(Color("theblue"))
                                .shadow(color: Color("theblue"), radius: 5, x: 0, y: 7)
                        }
                    }.hoverEffect(.highlight)
                    .frame(width: 250, height: 60)
                    .shadow(color: .white, radius: 10)
                }.offset(x: 0)
            }.sheet(isPresented: $showJoin) {
                VStack {
                    
                }
            }
        //}
    }
}


