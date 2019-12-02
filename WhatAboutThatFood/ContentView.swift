//
//  ContentView.swift
//  WhatAboutThatFood
//
//  Created by Harry Patsis on 28/11/19.
//  Copyright © 2019 Harry Patsis. All rights reserved.
//

// edemam
//  WhatAboutThatFood
//  Application ID
//    f80bf181
//  Application Keys
//    af4aa5c6e16a51de77a7105023e806b8
// ------------------------------------------
// FoodData Central
//  Api Key
//    hzgFl9NDcQJRskvQ8x3xmVlG9tR3VgE9hnaf4OWU
// -------------------------------------------
// Nutritionix
//  App ID
//    e7fc8726
//  App Key
//    d4df5dcfae0496ad98e99da5f4baba4d

import SwiftUI


extension URLRequest {
  
  public var curlString: String {
    // Logging URL requests in whole may expose sensitive data,
    // or open up possibility for getting access to your user data,
    // so make sure to disable this feature for production builds!
    #if !DEBUG
    return ""
    #else
    var result = "curl -k "
    
    if let method = httpMethod {
      result += "-X \(method) \\\n"
    }
    
    if let headers = allHTTPHeaderFields {
      for (header, value) in headers {
        result += "-H \"\(header): \(value)\" \\\n"
      }
    }
    
    if let body = httpBody, !body.isEmpty, let string = String(data: body, encoding: .utf8), !string.isEmpty {
      result += "-d '\(string)' \\\n"
    }
    
    if let url = url {
      result += url.absoluteString
    }
    
    return result
    #endif
  }
}

extension UIApplication {
  func endEditing(_ force: Bool) {
    self.windows
      .filter{$0.isKeyWindow}
      .first?
      .endEditing(force)
  }
}

//class FoodSearch: ObservableObject {
//  @Published var isLoaded: Bool = false
//  @Published var foodList:[Int: String] = [:]
//
//  func search(for name: String, page: Int = 1) {
//    let url = URL(string: "https://api.nal.usda.gov/fdc/v1/search?api_key=hzgFl9NDcQJRskvQ8x3xmVlG9tR3VgE9hnaf4OWU")!
//    var request = URLRequest(url: url)
//    request.httpMethod = "post"
//    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//    let param: [String: Any] = [
//      "generalSearchInput": name,
//      "pageNumber": String(page),
//      "includeDataTypes": ["Branded": false]
//    ]
//    request.httpBody = try? JSONSerialization.data(withJSONObject: param)
//    print(request.curlString)
//    let task = URLSession.shared.dataTask(with: request) {(data, response, error) in
//      guard error == nil else {
//        print("Error \(error!)")
//        return
//      }
//      guard let content = data else {
//        print("No data")
//        return
//      }
//      let json = try! JSONSerialization.jsonObject(with: content, options: [])
//      guard let obj = json as? [String: Any] else { return }
//      guard let foods = obj["foods"] as? [[String: Any]] else { return }
//      guard let totalPages = obj["totalPages"] as? Int else  { return }
//      guard let currentPage = obj["currentPage"] as? Int else { return }
//      for food in foods {
//        if let fdcId = food["fdcId"] as? Int, let description = food["description"] as? String {
//          DispatchQueue.main.async {
//            self.foodList[fdcId] = description
//          }
//        }
//      }
//      if (currentPage < totalPages) {
//        self.search(for: name, page: currentPage + 1)
//      } else {
//        DispatchQueue.main.async {
//          self.isLoaded = true
//        }
//      }
//    }
//    task.resume()
//  }
//}

struct Nutrient {
  var name: String = ""
  var unit: String = ""
  var id: Int = 0
  var value: Double = 0
}
struct FoodInfo {
  var name: String = ""
  var brand: String = ""
  var serving_qty: Int = 0
  var serving_unit: String = ""
  var nutrients: [Nutrient] = []
}

struct NutrientData {
  var name: String = ""
  var unit: String = ""
  init(_ name: String, _ unit: String) {
    self.name = name
    self.unit = unit
  }
}

var NutrientLookUp: [Int: NutrientData] = [
  203: NutrientData("Protein", "g"),
  204: NutrientData("Total lipid (fat)","g"),
  205: NutrientData("Carbohydrate, by difference","g"),
  207: NutrientData("Ash","g"),
  208: NutrientData("Energy","kcal"),
  209: NutrientData("Starch","g"),
  210: NutrientData("Sucrose","g"),
  211: NutrientData("Glucose (dextrose)","g"),
  212: NutrientData("Fructose","g"),
  213: NutrientData("Lactose","g"),
  214: NutrientData("Maltose","g"),
  221: NutrientData("Alcohol, ethyl","g"),
  255: NutrientData("Water","g"),
  257: NutrientData("Adjusted Protein","g"),
  262: NutrientData("Caffeine","mg"),
  263: NutrientData("Theobromine","mg"),
  268: NutrientData("Energy","kJ"),
  269: NutrientData("Sugars, total","g"),
  287: NutrientData("Galactose","g"),
  291: NutrientData("Fiber, total dietary","g"),
  301: NutrientData("Calcium, Ca","mg"),
  303: NutrientData("Iron, Fe","mg"),
  304: NutrientData("Magnesium, Mg","mg"),
  305: NutrientData("Phosphorus, P","mg"),
  306: NutrientData("Potassium, K","mg"),
  307: NutrientData("Sodium, Na","mg"),
  309: NutrientData("Zinc, Zn","mg"),
  312: NutrientData("Copper, Cu","mg"),
  313: NutrientData("Fluoride, F","Âµg"),
  315: NutrientData("Manganese, Mn","mg"),
  317: NutrientData("Selenium, Se","Âµg"),
  318: NutrientData("Vitamin A, IU","IU"),
  319: NutrientData("Retinol","Âµg"),
  320: NutrientData("Vitamin A, RAE","Âµg"),
  321: NutrientData("Carotene, beta","Âµg"),
  322: NutrientData("Carotene, alpha","Âµg"),
  323: NutrientData("Vitamin E (alpha-tocopherol)","mg"),
  324: NutrientData("Vitamin D","IU"),
  325: NutrientData("Vitamin D2 (ergocalciferol)","Âµg"),
  326: NutrientData("Vitamin D3 (cholecalciferol)","Âµg"),
  328: NutrientData("Vitamin D (D2 + D3)","Âµg"),
  334: NutrientData("Cryptoxanthin, beta","Âµg"),
  337: NutrientData("Lycopene","Âµg"),
  338: NutrientData("Lutein + zeaxanthin","Âµg"),
  341: NutrientData("Tocopherol, beta","mg"),
  342: NutrientData("Tocopherol, gamma","mg"),
  343: NutrientData("Tocopherol, delta","mg"),
  401: NutrientData("Vitamin C, total ascorbic acid","mg"),
  404: NutrientData("Thiamin","mg"),
  405: NutrientData("Riboflavin","mg"),
  406: NutrientData("Niacin","mg"),
  410: NutrientData("Pantothenic acid","mg"),
  415: NutrientData("Vitamin B-6","mg"),
  417: NutrientData("Folate, total","Âµg"),
  418: NutrientData("Vitamin B-12","Âµg"),
  421: NutrientData("Choline, total","mg"),
  428: NutrientData("Menaquinone-4","Âµg"),
  429: NutrientData("Dihydrophylloquinone","Âµg"),
  430: NutrientData("Vitamin K (phylloquinone)","Âµg"),
  431: NutrientData("Folic acid","Âµg"),
  432: NutrientData("Folate, food","Âµg"),
  435: NutrientData("Folate, DFE","Âµg"),
  454: NutrientData("Betaine","mg"),
  501: NutrientData("Tryptophan","g"),
  502: NutrientData("Threonine","g"),
  503: NutrientData("Isoleucine","g"),
  504: NutrientData("Leucine","g"),
  505: NutrientData("Lysine","g"),
  506: NutrientData("Methionine","g"),
  507: NutrientData("Cystine","g"),
  508: NutrientData("Phenylalanine","g"),
  509: NutrientData("Tyrosine","g"),
  510: NutrientData("Valine","g"),
  511: NutrientData("Arginine","g"),
  512: NutrientData("Histidine","g"),
  513: NutrientData("Alanine","g"),
  514: NutrientData("Aspartic acid","g"),
  515: NutrientData("Glutamic acid","g"),
  516: NutrientData("Glycine","g"),
  517: NutrientData("Proline","g"),
  518: NutrientData("Serine","g"),
  521: NutrientData("Hydroxyproline","g"),
  539: NutrientData("Sugars, added","g"),
  573: NutrientData("Vitamin E, added","mg"),
  578: NutrientData("Vitamin B-12, added","Âµg"),
  601: NutrientData("Cholesterol","mg"),
  605: NutrientData("Fatty acids, total trans","g"),
  606: NutrientData("Fatty acids, total saturated","g"),
  607: NutrientData("4:00","g"),
  608: NutrientData("6:00","g"),
  609: NutrientData("8:00","g"),
  610: NutrientData("10:00","g"),
  611: NutrientData("12:00","g"),
  612: NutrientData("14:00","g"),
  613: NutrientData("16:00","g"),
  614: NutrientData("18:00","g"),
  615: NutrientData("20:00","g"),
  617: NutrientData("18:1 undifferentiated","g"),
  618: NutrientData("18:2 undifferentiated","g"),
  619: NutrientData("18:3 undifferentiated","g"),
  620: NutrientData("20:4 undifferentiated","g"),
  621: NutrientData("Omega-3 (DHA)","g"),
  624: NutrientData("22:00","g"),
  625: NutrientData("14:01","g"),
  626: NutrientData("16:1 undifferentiated","g"),
  627: NutrientData("18:04","g"),
  628: NutrientData("20:01","g"),
  629: NutrientData("Omega-3 (EPA)","g"),
  630: NutrientData("22:1 undifferentiated","g"),
  631: NutrientData("22:5 n-3 (DPA)","g"),
  636: NutrientData("Phytosterols","mg"),
  638: NutrientData("Stigmasterol","mg"),
  639: NutrientData("Campesterol","mg"),
  641: NutrientData("Beta-sitosterol","mg"),
  645: NutrientData("Fatty acids, total monounsaturated","g"),
  646: NutrientData("Fatty acids, total polyunsaturated","g"),
  652: NutrientData("15:00","g"),
  653: NutrientData("17:00","g"),
  654: NutrientData("24:00:00","g"),
  662: NutrientData("16:1 t","g"),
  663: NutrientData("18:1 t","g"),
  664: NutrientData("22:1 t","g"),
  665: NutrientData("18:2 t not further defined","g"),
  666: NutrientData("18:2 i","g"),
  669: NutrientData("18:2 t,t","g"),
  670: NutrientData("18:2 CLAs","g"),
  671: NutrientData("24:1 c","g"),
  672: NutrientData("20:2 n-6 c,c","g"),
  673: NutrientData("16:1 c","g"),
  674: NutrientData("18:1 c","g"),
  675: NutrientData("18:2 n-6 c,c","g"),
  676: NutrientData("22:1 c","g"),
  685: NutrientData("18:3 n-6 c,c,c","g"),
  687: NutrientData("17:01","g"),
  689: NutrientData("20:3 undifferentiated","g"),
  693: NutrientData("Fatty acids, total trans-monoenoic","g"),
  695: NutrientData("Fatty acids, total trans-polyenoic","g"),
  696: NutrientData("13:00","g"),
  697: NutrientData("15:01","g"),
  851: NutrientData("Omega-3 (ALA)","g"),
  852: NutrientData("20:3 n-3","g"),
  853: NutrientData("20:3 n-6","g"),
  855: NutrientData("20:4 n-6","g"),
  856: NutrientData("18:3i","g"),
  857: NutrientData("21:05","g"),
  858: NutrientData("22:04","g"),
  859: NutrientData("18:1-11t (18:1t n-7)","g")
]


class FoodSearch: ObservableObject {
  @Published var isLoaded: Bool = false
//  @Published var foodList:[Int: String] = [:]
  @Published var foodInfo: FoodInfo = FoodInfo()
  
  func search(for name: String, page: Int = 1) {
    let url = URL(string: "https://trackapi.nutritionix.com/v2/natural/nutrients")!
    var request = URLRequest(url: url)
    request.httpMethod = "post"
    request.addValue("e7fc8726", forHTTPHeaderField: "x-app-id")
    request.addValue("d4df5dcfae0496ad98e99da5f4baba4d", forHTTPHeaderField: "x-app-key")
    request.addValue("0", forHTTPHeaderField: "x-remote-user-id")
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    let param: [String: Any] = [
        "query": name,
//        "num_servings": 0,
//        "aggregate": "string",
//        "line_delimited": false,
//        "use_raw_foods": false,
//        "include_subrecipe": false,
//        "timezone": "string",
//        "consumed_at": "string",
//        "lat": 0,
//        "lng": 0,
//        "meal_type": 0,
        "use_branded_foods": false
//        "locale": "string"
//      "generalSearchInput": name,
//      "pageNumber": String(page),
//      "includeDataTypes": ["Branded": false]
    ]
    request.httpBody = try? JSONSerialization.data(withJSONObject: param)
    let task = URLSession.shared.dataTask(with: request) {(data, response, error) in
      guard error == nil else {
        print("Error \(error!)")
        return
      }
      guard let content = data else {
        print("No data")
        return
      }
      let json = try! JSONSerialization.jsonObject(with: content, options: [])
      guard let obj = json as? [String: Any] else { return }
      guard let foods = obj["foods"] as? [[String: Any]] else { return }
      for food in foods {
        DispatchQueue.main.async {
          if let food_name = food["food_name"] as? String {
            self.foodInfo.name = food_name
          }
          if let brand_name = food["brand_name"] as? String {
            self.foodInfo.brand = brand_name
          }
          if let serving_qty = food["serving_qty"] as? Int {
            self.foodInfo.serving_qty = serving_qty
          }
          if let serving_unit = food["serving_unit"] as? String {
            self.foodInfo.serving_unit = serving_unit
          }
          if let full_nutrients = food["full_nutrients"] as? [[String: Any]] {
            for nutrient in full_nutrients {
              if let attr = nutrient["attr_id"] as? Int, let value = nutrient["value"] as? Double {
                let name = NutrientLookUp[attr]?.name ?? ""
                let unit = NutrientLookUp[attr]?.unit ?? ""
                self.foodInfo.nutrients.append(Nutrient(name: name, unit: unit, id: attr, value: value))
              }
            }
          }
          self.isLoaded = true
        }
        break
      }
    }
    task.resume()
  }
}

struct ContentView: View {
  @State var name: String = ""
  @State var showCancelButton: Bool = false
  @ObservedObject var foodSearch : FoodSearch = FoodSearch()
  var body: some View {
    VStack {
      HStack {
        HStack {
          if showCancelButton {
            Button(action: {
              print("button pressed")
              UIApplication.shared.endEditing(true) // this must be placed before the other commands here
              self.showCancelButton = false
            }) {
              Image(systemName: "chevron.left")
                .foregroundColor(Color.primary)
            }
          } else {
            Image(systemName: "magnifyingglass")
              .foregroundColor(Color.primary)
          }
          
          TextField("search for food...", text: $name, onEditingChanged: { isEditing in
            if isEditing {
              self.showCancelButton = true
            } else {
              self.showCancelButton = false
            }
          }, onCommit: {
            self.foodSearch.search(for: self.name)
          }).textFieldStyle(PlainTextFieldStyle())
          
          Button(action: {
            self.name = ""
          })
          {
            Image(systemName: "xmark").opacity(name == "" ? 0 : 1)
              .foregroundColor(Color.primary)
          }
        }
        .padding(EdgeInsets(top: 6, leading: 12, bottom: 6, trailing: 12))
        .background(Color(UIColor.systemBackground))
        .cornerRadius(20)
//        .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.primary, lineWidth: 1)).opacity(0.5)
        .padding()
        .shadow(color: Color.secondary, radius: 2, x: 1, y: 1 )
      }
      Spacer()
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
      .background(Color(UIColor.systemBackground))
//      .colorScheme(.dark)
  }
}
