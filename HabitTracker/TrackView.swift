//
//  TrackView.swift
//  HabitTracker
//
//  Created by Rhushabh Madurwar on 10/8/24.
//

import SwiftUI


struct Habit: Identifiable{
    let id = UUID().uuidString
    let name: String
    var isCompleted: Bool
    var count: Int
}

struct TrackView: View {
    @State var showNewHabitForm: Bool = false
    @State var allHabits: [Habit] = [
        Habit(name: "Exercise", isCompleted: true, count: 1),
        Habit(name: "Meditation", isCompleted: true, count: 1),
        Habit(name: "Music", isCompleted: true, count: 1)
    ]
    
    
    var body: some View {
        
        VStack{
            List{
                ForEach($allHabits){$habit in
                    HStack{
                        Text(habit.name)
                        Spacer()
                       
                        
                        Button("\(habit.count)", action: {
                            habit.isCompleted.toggle()
                            if habit.isCompleted{
                                habit.count+=1
                            }
                        })
   
                        

//                        
//                        Button("Reset", action: {habit.count = 0
//                            habit.isCompleted = false})
//                            .overlay{
//                                RoundedRectangle(cornerRadius: 20)
//                                    .stroke(.black, lineWidth: 1)
//                            }
//                            .font(.system(size: 10))
                 
                        
                        
                        
                        
                    }
                }
            }
            
            Button("Add Habit", action: {showNewHabitForm = true})
                .frame(width: 150, height: 50, alignment: .center)
                .overlay{
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(.black, lineWidth: 3)
                }
                .sheet(isPresented: $showNewHabitForm, content: {
                    FormView(habits: $allHabits)
                })

            Spacer()
        }
        
        
    }
}


struct FormView: View {
    @Binding var habits: [Habit]
    @State var habitText: String = ""
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack{
            TextField("add habit", text: $habitText)
                .frame(width: 300, height: 50, alignment: .center)
                .overlay{
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(.black, lineWidth: 3)
                }
                .onSubmit() {
                addHabit()
              
            }
                Button("Submit", action: addHabit )

        }
    }
    
    func addHabit(){
        
        var newHabit: Habit = Habit(name: habitText, isCompleted: false, count: 0)
        habits.append(newHabit)
        presentationMode.wrappedValue.dismiss()
        
    }
}

#Preview {
    TrackView()
}
