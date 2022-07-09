//
//  ContentView.swift
//  MyBudgeting
//
//  Created by I Gede Bagus Wirawan on 26/04/22.
//

import SwiftUI
import Combine

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
    @State var showModal = false
    //@Environment(\.dismiss) var dismiss

    
    @State var salary: String = ""
    
    @State var persentase: String = ""
    @State var method = ""
    @State var sumPercentage: Double = 0
    
//    struct budgetPercentage: Identifiable {
//        var id = UUID()
//        var budgetName: String
//        var percentage: Int
//    }
//
//    struct customBudget: Identifiable {
//        var id = UUID()
//        var nameBudget: String
//        var percentage: [budgetPercentage]
//    }
//
    @State var pokemonList = [
        customBudget(nameBudget: "Test Method", percentage: [budgetPercentage(budgetName: "naruto", percentage: 10)])
    ];
    
    @FocusState private var salaryForm : Bool
    
    //result method
    @State var result: String = ""
    
    enum Flavor: String, CaseIterable, Identifiable {
        case first, second, third, custom, pokemonList
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
                            .accessibility(label: Text("Form Salary"))
                            .keyboardType(.decimalPad)
                            .focused($salaryForm)
                            .onReceive(Just(salary)) { newValue in
                                        let filtered = newValue.filter { "0123456789.".contains($0) }
                                        if filtered != newValue {
                                            self.salary = filtered
                                        }
                            }
                            
                        //method form
                        //TextField("Budgeting Method", text: $model.method)
                        
                            Picker("Budgeting Method", selection: $selectedFlavor) {
                                Text("50/30/20").tag(Flavor.first)
                                Text("80/20").tag(Flavor.second)
                                Text("Li Ka-Shing").tag(Flavor.third)
                                Text("Custom method").tag(Flavor.custom)
                                //try to add automatic
//                                ForEach(pokemonList) { pokemon in
//                                    Text("\(pokemon.nameBudget)").tag(Flavor.pokemonList)
//                                }
                            }.accessibility(label: Text("Choose Method"))
                        
                    }

                    
                    //list for custom method
                    if Flavor.custom == selectedFlavor {
                        
                        Section(){
                        Button(action: { self.showModal.toggle() }) { // Button to show the modal view by toggling the state
                                    Text("Make your own budgeting")
                                }
                                .sheet(isPresented: $showModal) { // Passing the state to the sheet API
                                    HStack{
                                        Button {
                                            showModal = false
                                        } label: {
                                            Text("Cancel")
                                        }
                                        .padding()
                                        .accessibility(label: Text("Cancel")) //accessibility
                                        
                                        Spacer()
                                        Text("Custom Method")
                                            .bold()
                                            .padding()
                                        Spacer()
                                        
                                        EditButton()
                                            .accessibility(label: Text("Edit")) //accessibility
                                            .padding()
                                    }
    
                                    //form for custom method
                                    Form {
                                        //for add budgeting
                                        Section(header: Text("Add New Budgeting")) {
                                            
                                            TextField("Input Item", text: $method)
                                                .accessibility(label: Text("Form Item")) //accessibility
                                                .keyboardType(.alphabet)
                                                .focused($salaryForm)
                                                
                                            
                                            TextField("Input Percentage (%)", text: $persentase)
                                                .accessibility(label: Text("Form Percentage")) //accessibility
                                                .keyboardType(.decimalPad)
                                                .focused($salaryForm)
                                                .onReceive(Just(persentase)) { newValue in
                                                            let filtered = newValue.filter { "0123456789.".contains($0) }
                                                            if filtered != newValue {
                                                                self.persentase = filtered
                                                            }
                                                }
                                                
                                            //button
                                            Button(action: {
                                                addNewBudget()
                                            }, label: {
                                                Text("Add Budgeting Item")
                                            })
                                            .alert(isPresented: $showAlert) {
                                                Alert(
                                                    title: Text("Input Failed"),
                                                    message: Text("the percentage should not exceed 100%")
                                                )
                                            }
                                            
                                        }
                                        
                                        //for result budgeting
                                        if viewModel.stocks.count != 0 {
                                            Section(header: Text("Your Custom Budgeting")) {
                                                
                                                List {
                                                    ForEach(viewModel.stocks) { StockMethod in
                                                        MethodItem(title_method: StockMethod.title, value_method: StockMethod.value)
                                                    }
                                                    .onDelete(perform: { IndexSet in
                                                        for row in IndexSet{
                                                            print(row)
                                                            print(viewModel.stocks[row].value)
                                                            sumPercentage -= viewModel.stocks[row].value
                                                        }
                                                        viewModel.stocks.remove(atOffsets: IndexSet)
                                                        //print(viewModel.stocks.remove(atOffsets: IndexSet))
                                                    })
                                                }//end list
                                                
                                            } //end of section
                                        }
                                        
                                    }//end of form
                                    
                                    Button(action: {
                                        calculateSalary()
                                        showModal = false
                                    }, label: {
                                        Text("Calculate")
                                    })
                                    .accessibility(label: Text("Calculate")) //accessibility
                                    .padding()
                                }//end of sheet
                        }
                        
                        
                    } //end if
                    //end of list custom method
                
                    
                    
                    NavigationLink(destination: MethodsView()) {
                        Button(action: {
                            print("go to methods page")
                        }, label: {
                            Text("Check Methods") //accessibility
                        })
                    }
                    .accessibility(label: Text("Check Methods"))
                    
                    //for result
                    Section(header: Text("Result")) {
                        //Result
                        Text("\(result)")
                            .accessibility(label: Text("Result form"))
                            .accessibility(value: Text("\(result)")) //accessibility
                            .accessibilityAction(named: Text("Clear")) {
                                result = ""
                            }
                    }
                    
                    
                } //end of form
                
                Button(action: {
                    calculateSalary()
                }, label: {
                    Text("Calculate")
                        .bold()
                        .font(.title3)
                        .frame(width: 300, height: 50, alignment: .center)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                })
                .accessibility(label: Text("Calculate")) //accessibility
                .padding()
//                .onDisappear{
//                    result = ""
//                }
                //tutup button calculate
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
        
        if(salary == "" || salary == "."){
            result = "Salary cannot be empty"
            return
        }
            
        //print(salary)
        //print(selectedFlavor)
        
        if selectedFlavor == Flavor.first  {
            metode503020()
        } else if selectedFlavor == Flavor.second {
            metode8020()
        } else if selectedFlavor == Flavor.third {
            metode_Li_KaShing()
        } else if selectedFlavor == Flavor.custom {
            custom_method()
        } else if selectedFlavor == Flavor.pokemonList {
            metode_pokemon()
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
    
    func metode_pokemon() {
        
        //let salary_int: Double? = Double(salary)

//        if(){
//
//        }

        //result = salary_int
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
        
        //let newStock = StockMethod(title: method, value: persen_int!)
        //viewModel.stocks.append(newStock)
        
        
        
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

//for modal
//struct SheetView: View {
//   @Environment(\.dismiss) var dismiss
//
//    var body: some View {
//        VStack {
//           Button {
//              dismiss()
//           } label: {
//               Text("Cancel")
//           }
//         }
//         .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
//         .padding()
//    } //end sheetview
//}
