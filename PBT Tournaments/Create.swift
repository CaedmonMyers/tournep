//
//  Create.swift
//  PBT Tournaments
//
//  Created by Caedmon Myers on 5/4/23.
//

import SwiftUI

struct Create: View {
    @EnvironmentObject var dataManager: DataManager
    
    @State var name = ""
    @State var time = ""
    @State var location = ""
    @State var publicCode = ""
    @State var privateCode = ""
    @State var description = ""
    @State var slots = ""
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    ZStack {
                        Color("theblue")
                            .cornerRadius(20)
                            .frame(height: 50)
                            .overlay {
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(lineWidth: 2)
                                    .foregroundColor(.white)
                            }
                            .shadow(color: Color("theblue"), radius: 10, x: 0, y: 7)
                        
                        TextField("", text: $name)
                            .padding(10)
                            .foregroundColor(.white)
                            .placeholder(when: name.isEmpty) {
                                Text("Tournament Name")
                                    .foregroundColor(.white)
                                    .padding(10)
                            }
                    }
                    
                    ZStack {
                        Color("theblue")
                            .cornerRadius(20)
                            .frame(height: 50)
                            .overlay {
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(lineWidth: 2)
                                    .foregroundColor(.white)
                            }
                            .shadow(color: Color("theblue"), radius: 10, x: 0, y: 7)
                        
                        TextField("", text: $time)
                            .padding(10)
                            .foregroundColor(.white)
                            .placeholder(when: time.isEmpty) {
                                Text("Start Time")
                                    .foregroundColor(.white)
                                    .padding(10)
                            }
                    }
                    
                    
                    ZStack {
                        Color("theblue")
                            .cornerRadius(20)
                            .frame(height: 50)
                            .overlay {
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(lineWidth: 2)
                                    .foregroundColor(.white)
                            }
                            .shadow(color: Color("theblue"), radius: 10, x: 0, y: 7)
                        
                        TextField("", text: $location)
                            .padding(10)
                            .foregroundColor(.white)
                            .placeholder(when: location.isEmpty) {
                                Text("Location")
                                    .foregroundColor(.white)
                                    .padding(10)
                            }
                    }
                    
                    
                    ZStack {
                        Color("theblue")
                            .cornerRadius(20)
                            .frame(height: 50)
                            .overlay {
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(lineWidth: 2)
                                    .foregroundColor(.white)
                            }
                            .shadow(color: Color("theblue"), radius: 10, x: 0, y: 7)
                        
                        TextField("", text: $description)
                            .padding(10)
                            .foregroundColor(.white)
                            .placeholder(when: description.isEmpty) {
                                Text("Description")
                                    .foregroundColor(.white)
                                    .padding(10)
                            }
                    }
                    
                    
                    ZStack {
                        Color("theblue")
                            .cornerRadius(20)
                            .frame(height: 50)
                            .overlay {
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(lineWidth: 2)
                                    .foregroundColor(.white)
                            }
                            .shadow(color: Color("theblue"), radius: 10, x: 0, y: 7)
                        TextField("", text: $slots)
                            .padding(10)
                            .keyboardType(.numberPad)
                            .foregroundColor(.white)
                            .placeholder(when: slots.isEmpty) {
                                Text("Slots #")
                                    .foregroundColor(.white)
                                    .padding(10)
                            }
                    }
                    
                    Spacer()
                        .frame(height: 20)
                    
                    Button {
                        dataManager.addTournament(name: name, time: time, location: location, slots: slots, description: description)
                        
                        dataManager.fetchAll()
                    } label: {
                        ZStack {
                            Color("theblue")
                                .cornerRadius(20)
                                .frame(width: 250, height: 85)
                                .overlay {
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(lineWidth: 2)
                                        .foregroundColor(.white)
                                }
                                .shadow(color: Color("theblue"), radius: 10, x: 0, y: 7)
                            
                            Text("Add Tournament")
                                .foregroundColor(.white)
                                .shadow(color: Color(.white), radius: 10, x: 0, y: 7)
                        }
                    }
                    
                    
                }.navigationTitle("Create")
            }
        }
    }
}

struct Create_Previews: PreviewProvider {
    static var previews: some View {
        Create()
    }
}
