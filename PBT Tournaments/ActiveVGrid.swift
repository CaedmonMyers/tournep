//
//  ActiveVGrid.swift
//  PBT Tournaments
//
//  Created by Caedmon Myers on 5/5/23.
//

import SwiftUI

struct ActiveVGrid: View {
    let data: [Tournaments] // Replace 'YourDataModel' with your actual data model type
    let columns: Int = 2
    
    @State var shownID = ""
    
    let defaultHeight = 250
    
    @State var currentPadding = CGFloat(10)
    
    @State var theHeight = CGFloat(250)
    
    @State var offset = CGSize.zero
    
    @State var showJoin = false
    
    @EnvironmentObject var dataManager: DataManager
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            ForEach(0..<(dataManager.tournaments.count + columns - 1) / columns) { rowIndex in
                HStack(spacing: 16) {
                    ForEach(0..<columns) { columnIndex in
                        let index = rowIndex * columns + columnIndex
                        if index < dataManager.tournaments.count {
                            let event = dataManager.tournaments[index]
                            // Your grid item view here
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
                        } else {
                            Spacer()
                        }
                    }
                }
            }
        }
    }
}

