//
//  ContentView.swift
//  WhatAboutThatFood
//
//  Created by Harry Patsis on 28/11/19.
//  Copyright © 2019 Harry Patsis. All rights reserved.
//

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

class FoodSearch: ObservableObject {
  @Published var isLoaded: Bool = false
//  @Published var foodList:[Int: String] = [:]
  @Published var foodInfo: FoodInfo = FoodInfo()
  
  func search(for name: String, page: Int = 1) {
    isLoaded = false
    foodInfo = FoodInfo()
    let url = URL(string: "https://trackapi.nutritionix.com/v2/natural/nutrients")!
    var request = URLRequest(url: url)
    request.httpMethod = "post"
    request.addValue("e7fc8726", forHTTPHeaderField: "x-app-id")
    request.addValue("d4df5dcfae0496ad98e99da5f4baba4d", forHTTPHeaderField: "x-app-key")
    request.addValue("0", forHTTPHeaderField: "x-remote-user-id")
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    let param: [String: Any] = [
        "query": name,
        "use_branded_foods": false
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
      if true {//foodSearch.isLoaded {
        Text("Nutrition Facts")
          .font(.largeTitle)
        HStack {
          Text("Amount per serving: ")
//            .font(.system(size: 15))
//          Spacer()
          Text("120 gr")
        }
        HStack {
          Text("Calories: ")
          Text("220 KCal")
        }
//      .padding()
        
//        List(foodSearch.$foodInfo)
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
