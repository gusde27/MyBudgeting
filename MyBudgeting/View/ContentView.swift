//
//  ContentView.swift
//  MyBudgeting
//
//  Created by I Gede Bagus Wirawan on 26/04/22.
//

import SwiftUI

//for custom method

struct StockMethod: Identifiable {
    var id = UUID()
    let title: String
    let value: Double
}

class MethodViewModel: ObservableObject {
    @Published var stocks: [StockMethod] = [
        //StockMethod(title: "Apple", value: 100),
    ]
}

//end custom method

struct ContentView: View {
    
    //var for stock
    @StateObject var viewModel = MethodViewModel()
    //for alert
    @State private var showAlert = false
    
    @State var salary: String = ""
    
    @State var persentase: String = ""
    @State var method = ""
    @State var sumPercentage: Double = 0
    
    @FocusState private var salaryForm : Bool
    
    //result method
    @State var result: String = ""
    
    enum Flavor: String, CaseIterable, Identifiable {
        case first, second, third, custom
        var id: Self { self }
    }

    @State private var selectedFlavor: Flavor = .first

    
    var body: some View {
        NavigationView {
            VStack {
                
                //form
                Form {
                    Section(header: Text("Budgeting your salary")) {
                        //salary form
                        TextField("Input Salary (IDR)", text: $salary)
                            .keyboardType(.decimalPad)
                            .focused($salaryForm)
                        //method form
                        //TextField("Budgeting Method", text: $model.method)
                        List {
                            Picker("Budgeting Method", selection: $selectedFlavor) {
                                Text("50/30/20").tag(Flavor.first)
                                Text("80/20").tag(Flavor.second)
                                Text("Li Ka-Shing").tag(Flavor.third)
                                Text("Custom Method").tag(Flavor.custom)
                            }
                        }
                    }
                    
                    //list for custom method
                    if Flavor.custom == selectedFlavor {
                        //for add budgeting
                        Section(header: Text("Add New Budgeting")) {
                            
                            TextField("Input Item", text: $method)
                                .keyboardType(.alphabet)
                                .focused($salaryForm)
                            
                            TextField("Input Percentage (%)", text: $persentase)
                                .keyboardType(.decimalPad)
                                .focused($salaryForm)
                            
                            Button(action: {
                                addNewBudget()
                                //for Text peringatan
//                                if sumPercentage > 100 {
//                                    showAlert = true
//                                }
                            }, label: {
                                Text("Add Budgeting Item")
//                                    .frame(width: 150, height: 40, alignment: .center)
//                                    .background(Color.blue)
//                                    .foregroundColor(.white)
//                                    .cornerRadius(8)
                            })
                            .alert(isPresented: $showAlert) {
                                Alert(
                                    title: Text("Input Failed"),
                                    message: Text("the percentage should not exceed 100%")
                                )
                            }
                            //.padding()
                            
                        }.onDisappear{
                            viewModel.stocks = []
                            sumPercentage = 0
                        }
                        
                        //for result budgeting
                        if viewModel.stocks.count != 0 {
                            Section(header: Text("Your Custom Budgeting")) {
                                List {
                                    ForEach(viewModel.stocks) { StockMethod in
                                        MethodItem(title_method: StockMethod.title, value_method: StockMethod.value)
                                    }
                                }
                            }
                        }
                        
                    } //end if
                    //end of list custom method
                    
                    NavigationLink(destination: MethodsView()) {
                        Button(action: {
                            
                        }, label: {
                            Text("Check Methods")
                        })
                    }
                    
                    Section(header: Text("Result")) {
                        //Result
                        Text("\(result)")
                    }
                    
                    
                }
                //end of form
                Button(action: {
                    calculateSalary()
                }, label: {
                    Text("Calculate")
                        .frame(width: 300, height: 50, alignment: .center)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                })
                .padding()
                .onDisappear{
                    result = ""
                }
            }
            .navigationTitle("MyBudgeting")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard){
                    Spacer()
                    Button("Done"){
                        salaryForm = false
                    }
                }
            }
            
            //add new
            
            
        } //end navigationview
         
    }
    
    //function logic
    func calculateSalary(){
        print(salary)
        print(selectedFlavor)
        
        if selectedFlavor == Flavor.first  {
            metode503020()
        } else if selectedFlavor == Flavor.second {
            metode8020()
        } else if selectedFlavor == Flavor.third {
            metode_Li_KaShing()
        } else if selectedFlavor == Flavor.custom {
            custom_method()
        }
        
        //result = salary
    }
    
    func metode503020() {
        
        let salary_int: Double? = Double(salary)
        
        let hasil50 : Double = salary_int! / 100 * 50
        let hasil30 : Double = salary_int! / 100 * 30
        let hasil20 : Double = salary_int! / 100 * 20
        
        result = "50% for life Rp. \(hasil50) \n\n30% for Entertainment Rp. \(hasil30) \n\n20% for invest Rp. \(hasil20)"
    }
    
    func metode8020() {
        
        let salary_int: Double? = Double(salary)
        
        let hasil80 : Double = salary_int! / 100 * 80
        let hasil20 : Double = salary_int! / 100 * 20
        
        result = "80% for life Rp. \(hasil80) \n\n20% for invest Rp. \(hasil20)"
    }
    
    func metode_Li_KaShing() {
        
        let salary_int: Double? = Double(salary)

        let hasilhidup : Double = salary_int! / 100 * 30
        let hasilsosial : Double = salary_int! / 100 * 20
        let hasildiri : Double = salary_int! / 100 * 15
        let hasiliburan : Double = salary_int! / 100 * 10
        let hasilinvest : Double = salary_int! / 100 * 25

        result = "30% for life Rp. \(hasilhidup) \n\n20% for Social Rp. \(hasilsosial) \n\n15% for Personal Rp. \(hasildiri) \n\n10% for Entertainment Rp. \(hasiliburan) \n\n25% for Invest Rp. \(hasilinvest)"
    }
    
    //for custom method
    struct MethodItem: View {
        let title_method: String
        let value_method: Double
        
        var body: some View {
            HStack {
                Text("\(value_method)%")
                Text("For")
                Text(title_method)
            }
            
        }
    }
    
    //add new budget
    func addNewBudget(){
        guard !method.trimmingCharacters(in: .whitespaces).isEmpty else {
            return
        }
        
        let persen_int: Double? = Double(persentase)
        
        sumPercentage += persen_int!
        
        if sumPercentage > 100 {
            print("Melebihi 100%")
            showAlert = true
            sumPercentage -= persen_int!
        } else {
            let newStock = StockMethod(title: method, value: persen_int!)
            viewModel.stocks.append(newStock)
        }
        
        
        
        //sumPercentage
        //
       // print(newStock)
       // print(viewModel.stocks) //disini
        
    }
    
    func custom_method(){
        
        let array = viewModel.stocks
        
        let salary_int: Double? = Double(salary)
        
        print(array)
        var hasil  = ""
        for budget in array {
            let hasilInvest : Double = salary_int! / 100 * budget.value
            hasil += budget.value.description + "% " + "for " + budget.title + " Rp." + hasilInvest.description + "\n"
        }

        result = hasil;

    }
    
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}



//TextField("Input Salary", value: $model.salary, format: .currency(code: Locale.current.currencyCode ?? "IDR")).keyboardType(.decimalPad)
