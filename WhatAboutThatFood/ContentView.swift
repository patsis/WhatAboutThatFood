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

class FoodSearch: ObservableObject {
  @Published var isLoaded: Bool = false
//  @Published var json: String? = nil
  @Published var foodList:[Int: String] = [:]
  
  func search(for name: String, page: Int = 1) {
//    if page == 1 {
//      foodList = [:]
//      self.isLoaded = false
//    }
    let url = URL(string: "https://api.nal.usda.gov/fdc/v1/search?api_key=hzgFl9NDcQJRskvQ8x3xmVlG9tR3VgE9hnaf4OWU")!
    var request = URLRequest(url: url)
    request.httpMethod = "post"
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    let param: [String: Any] = [
      "generalSearchInput": name,
      "pageNumber": String(page),
      "includeDataTypes": ["Branded": false]
    ]
    request.httpBody = try? JSONSerialization.data(withJSONObject: param)
    print(request.curlString)
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
      guard let totalPages = obj["totalPages"] as? Int else  { return }
      guard let currentPage = obj["currentPage"] as? Int else { return }
      for food in foods {
        if let fdcId = food["fdcId"] as? Int, let description = food["description"] as? String {
          DispatchQueue.main.async {
            self.foodList[fdcId] = description
          }
        }
      }
      if (currentPage < totalPages) {
        self.search(for: name, page: currentPage + 1)
      } else {
        DispatchQueue.main.async {
          self.isLoaded = true
        }
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
