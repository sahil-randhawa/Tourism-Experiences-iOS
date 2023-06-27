//
//  Activity.swift
//  CityTourism
//
//  Created by super on 2023-06-14.
//

import Foundation

struct Activity {
    let name: String
    let price: String
    let photo: [String]
    let description: String
    let starRating: Int
    let host: String
//    let id:UUID = UUID()
}

class ActivityData:ObservableObject {
    static let shared = ActivityData()
    
    @Published var activities: [Activity] = [
        Activity(name: "The CN Tower", price: "$20", photo: ["cntower1", "cntower2", "cntower3", "cntower4"], description: "The CN Tower is a 553.3 m-high concrete communications and observation tower in Toronto, Ontario, Canada. Completed in 1976, it is located in downtown Toronto, built on the former Railway Lands. Its name CN referred to Canadian National, the railway company that built the tower. ", starRating: 4, host: "City Explorers"),
        Activity(name: "Royal Ontario Museum", price: "$45", photo: ["museum", "museum2"], description: "The Royal Ontario Museum is a museum of art, world culture and natural history in Toronto, Ontario, Canada. It is one of the largest museums in North America and the largest in Canada. It attracts more than one million visitors every year, making the ROM the most-visited museum in Canada. ", starRating: 5, host: "Museum Tours"),
        Activity(name: "Casa Loma Castle", price: "$10", photo: ["casaloma1", "casaloma2", "casaloma3", "casaloma4"], description: "The Casa Loma is a Gothic Revival castle-style mansion and garden in midtown Toronto, Ontario, Canada, that is now a historic house museum and landmark. It was constructed from 1911 to 1914 as a residence for financier Sir Henry Pellatt. The architect was E. J. Lennox, who designed several other city landmarks.", starRating: 3, host: "Castle Adventures"),
        Activity(name: "Ripley's Aquarium", price: "$30", photo: ["aquarium1", "aquarium2", "aquarium3"], description: "Ripley's Aquarium of Canada is a public aquarium in Toronto, Ontario, Canada. The aquarium is one of three aquariums owned and operated by Ripley Entertainment. It is located in downtown Toronto, just southeast of the CN Tower.", starRating: 4, host: "Aquatic Adventures"),
        Activity(name: "Toronto Islands", price: "$5", photo: ["island1", "island2", "island3"], description: "The Toronto Islands are a chain of small islands located in Lake Ontario, south of mainland Toronto, Ontario, Canada. The islands are a popular recreational destination and offer beautiful beaches, parks, and stunning views of the city skyline.", starRating: 4, host: "Island Escapes"),
        Activity(name: "Art Gallery of Ontario", price: "$25", photo: ["ago1", "ago2", "ago3"], description: "The Art Gallery of Ontario is an art museum in Toronto, Ontario, Canada. It is one of the largest art museums in North America and houses a diverse collection of over 95,000 works spanning various periods and styles. The AGO is located in downtown Toronto's Grange Park neighborhood.", starRating: 4, host: "Art Enthusiasts")

    ]
    
    @Published var favAct: [Activity] = []
}

