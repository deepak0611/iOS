//
//  SearchViewModel.swift
//  microsoftR2-swiftui
//
//  Created by Deepak Kumar1 on 04/09/25.
//

import SwiftUI
import Combine

class SearchViewModel: ObservableObject {
    
    @Published var buildingData: [BuildingModel] = []
    @Published var cityData: [String] = []
    
    var bdsot = BuldingDataProvider.shared.getBuildingDetails()
    var cdsot: [String] = []
    
    init() {
        getBuildingData()
        
        buildingData
            .publisher.sink { _ in
                print("kdfm")
            } receiveValue: { [weak self] newValue in
                self?.updateCityData()
            }


    }
    
  
    func getBuildingData() {
        buildingData = bdsot
        cdsot = buildingData.map({ model in
            model.city
        })
        
        cityData = cdsot
        buildingData = bdsot
    }
    
    func getBuldingDataBasedOn(city: String) -> [BuildingModel] {
        let data = buildingData.filter { model in
            model.city == city
        }
        return data
    }
    
    func filterViewData(text: String) {
//        cityData = cdsot.filter({ city in
//            doesContains(seachtext: text, in: city)
//        })
        buildingData = bdsot.filter({ model in
            doesContains(seachtext: text, in: model.name) || doesContains(seachtext: text, in: model.city)
        })
    }
    
    func updateCityData() {
        cityData = buildingData.map { model in
            model.city
        }
    }
    
    func doesContains(seachtext: String, in text: String) -> Bool {
        text.lowercased().contains(seachtext.lowercased())
    }
}

class BuldingDataProvider {
    
    
    static let shared = BuldingDataProvider()
    
    private init() {}
    
    
    let indianCities = [
        "Ahmedabad","Agra","Aligarh","Amravati","Amritsar","Aurangabad","Bareilly",
        "Belgaum","Bhubaneswar","Bhopal","Chandigarh","Coimbatore","Delhi","Dhanbad",
        "Durgapur","Faridabad","Ghaziabad","Guntur","Gurgaon","Hubli-Dharwad",
        "Indore","Jabalpur","Jaipur","Jalandhar","Jamshedpur","Jodhpur","Kanpur",
        "Kochi","Kolhapur","Kolkata","Lucknow","Ludhiana","Madurai","Meerut","Moradabad",
        "Mumbai","Mysore","Nagpur","Nashik","Noida","Patna","Pune","Rajkot","Ranchi",
        "Saharanpur","Salem","Sangli-Miraj & Kupwad","Solapur","Surat","Thane","Thiruvananthapuram",
        "Trivandrum","Vadodara","Varanasi","Vijayawada","Visakhapatnam","Agartala","Ajmer",
        "Alappuzha","Amroha","Anand","Asansol","Bareilly","Bikaner","Chandrapur","Chennai",
        "Dehradun","Gaya","Gorakhpur","Hapur","Imphal","Jammu","Jammu","Kalyan-Dombivali",
        "Kharagpur","Kolhapur","Kota","Loni","Malda","Meerut","Nagercoil","Nellore","Puducherry",
        "Raipur","Rajahmundry","Rourkela","Salem","Silchar","Siliguri","Srinagar","Thanjavur",
        "Tiruchirappalli","Udaipur","Ujjain","Vijayawada","Warangal","Asansol","Dewas",
        "Ichalkaranji","Karnal","Ludhiana","Bathinda","Jalna","Eluru","Barasat","Purnia",
        "Satna","Mau","Sonipat","Farrukhabad","Sagar","Durg","Arrah","Anantapur",
        "Karimnagar","Etawah","Bharatpur","Begusarai","Gandhidham","Baranagar","Tiruvottiyur",
        "Sikar","Thoothukudi","Rewa","Mirzapur","Raichur","Pali","Ramagundam","Vizianagaram",
        "Katihar","Haridwar","Sri Ganganagar","Karawal Nagar","Bulandshahr","Bidar","Munger",
        "Panchkula","Burhanpur","Kharagpur","Dindigul","Gandhinagar","Hospet","Malda",
        "Ongole","Deoghar","Chapra","Haldia","Khandwa","Nandyal","Morena","Amroha",
        "Anand","Bhind","Bhiwani","Baharampur","Ambala","Morvi","Fatehpur","Rae Bareli",
        "Khora","Bhusawal","Orai","Bahraich","Anand","Chandigarh","Ahmedabad","Gandhinagar",
        "Vellore","Nalgonda","Rajnandgaon","Khajuraho","Buxar","Mysuru","Warangal"
    ]

    let buildingDescriptors = ["Heights","Plaza","Residency","Arcade","Gardens","Residency","Square","Vista","Tower","Residences"]

    func randomDescriptor(excluding used: inout Set<String>) -> String {
        // Loop until we get an unused descriptor
        var choice: String
        repeat {
            choice = buildingDescriptors.randomElement()!
        } while used.contains(choice)
        used.insert(choice)
        return choice
    }
   
    var buildings: [BuildingModel] = []

    
    func getBuildingDetails() -> [BuildingModel] {
        for city in Set(indianCities) {
            var usedDescriptors = Set<String>()
            let count = Int.random(in: 5...6)
            for idx in 1...count {
                let descriptor = randomDescriptor(excluding: &usedDescriptors)
                let randomSuffix = ["Alpha","Beta","Gamma","Prime","One","Oak","Emerald","Crest","Horizon","Central"].randomElement()!
                let name = "\(descriptor) \(randomSuffix)"
                buildings.append(BuildingModel(id: UUID(), name: name, city: city))
    //            print(name)
            }
        }
        
        return buildings
    }
    

    
}
