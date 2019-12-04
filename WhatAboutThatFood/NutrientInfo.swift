//
//  NutrientLookUp.swift
//  WhatAboutThatFood
//
//  Created by Harry Patsis on 3/12/19.
//  Copyright © 2019 Harry Patsis. All rights reserved.
//

import Foundation

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
  var daily: Double = 0
  init(_ name: String, _ unit: String, _ daily: Double) {
    self.name = name
    self.unit = unit
    self.daily = daily
  }
}

var NutrientLookUp: [Int: NutrientData] = [
  203: NutrientData("Protein", "g", 50),
  204: NutrientData("Dat","g", 78),
  205: NutrientData("Carbohydrates","g", 275),
  207: NutrientData("Ash","g", 0),
  208: NutrientData("Energy","kcal", 0),
  209: NutrientData("Starch","g", 0),
  210: NutrientData("Sucrose","g", 0),
  211: NutrientData("Glucose (dextrose)","g", 0),
  212: NutrientData("Fructose","g", 0),
  213: NutrientData("Lactose","g", 0),
  214: NutrientData("Maltose","g", 0),
  221: NutrientData("Alcohol, ethyl","g", 0),
  255: NutrientData("Water","g", 0),
  257: NutrientData("Adjusted Protein","g", 0),
  262: NutrientData("Caffeine","mg", 0),
  263: NutrientData("Theobromine","mg", 0),
  268: NutrientData("Energy","kJ", 0),
  269: NutrientData("Sugars, total","g", 0),
  287: NutrientData("Galactose","g", 0),
  291: NutrientData("Dietary Fiber","g", 28),
  301: NutrientData("Calcium","mg", 1300),
  303: NutrientData("Iron","mg", 18),
  304: NutrientData("Magnesium","mg", 420),
  305: NutrientData("Phosphorus","mg", 1250),
  306: NutrientData("Potassium","mg", 4700),
  307: NutrientData("Sodium","mg", 2300),
  309: NutrientData("Zinc","mg", 11),
  312: NutrientData("Copper","mg", 0.9),
  313: NutrientData("Fluoride, F","µg", 3500),
  315: NutrientData("Manganese, Mn","mg", 2.3),
  317: NutrientData("Selenium, Se","µg", 55),
  318: NutrientData("Vitamin A","IU", 0),
  319: NutrientData("Retinol","µg", 0),
  320: NutrientData("Vitamin A, RAE","µg", 0),
  321: NutrientData("Carotene, beta","µg", 0),
  322: NutrientData("Carotene, alpha","µg", 0),
  323: NutrientData("Vitamin E (alpha-tocopherol)","mg", 0),
  324: NutrientData("Vitamin D","IU", 0),
  325: NutrientData("Vitamin D2 (ergocalciferol)","µg", 0),
  326: NutrientData("Vitamin D3 (cholecalciferol)","µg", 0),
  328: NutrientData("Vitamin D (D2 + D3)","µg", 0),
  334: NutrientData("Cryptoxanthin, beta","µg", 0),
  337: NutrientData("Lycopene","µg", 0),
  338: NutrientData("Lutein + zeaxanthin","µg", 0),
  341: NutrientData("Tocopherol, beta","mg", 0),
  342: NutrientData("Tocopherol, gamma","mg", 0),
  343: NutrientData("Tocopherol, delta","mg", 0),
  401: NutrientData("Vitamin C","mg", 90),
  404: NutrientData("Thiamin","mg", 0),
  405: NutrientData("Riboflavin","mg", 0),
  406: NutrientData("Niacin","mg", 0),
  410: NutrientData("Pantothenic acid","mg", 0),
  415: NutrientData("Vitamin B-6","mg", 0),
  417: NutrientData("Folate, total","µg", 0),
  418: NutrientData("Vitamin B-12","µg", 0),
  421: NutrientData("Choline, total","mg", 0),
  428: NutrientData("Menaquinone-4","µg", 0),
  429: NutrientData("Dihydrophylloquinone","µg", 0),
  430: NutrientData("Vitamin K (phylloquinone)","µg", 0),
  431: NutrientData("Folic acid","µg", 0),
  432: NutrientData("Folate, food","µg", 0),
  435: NutrientData("Folate, DFE","µg", 0),
  454: NutrientData("Betaine","mg", 0),
  501: NutrientData("Tryptophan","g", 0),
  502: NutrientData("Threonine","g", 0),
  503: NutrientData("Isoleucine","g", 0),
  504: NutrientData("Leucine","g", 0),
  505: NutrientData("Lysine","g", 0),
  506: NutrientData("Methionine","g", 0),
  507: NutrientData("Cystine","g", 0),
  508: NutrientData("Phenylalanine","g", 0),
  509: NutrientData("Tyrosine","g", 0),
  510: NutrientData("Valine","g", 0),
  511: NutrientData("Arginine","g", 0),
  512: NutrientData("Histidine","g", 0),
  513: NutrientData("Alanine","g", 0),
  514: NutrientData("Aspartic acid","g", 0),
  515: NutrientData("Glutamic acid","g", 0),
  516: NutrientData("Glycine","g", 0),
  517: NutrientData("Proline","g", 0),
  518: NutrientData("Serine","g", 0),
  521: NutrientData("Hydroxyproline","g", 0),
  539: NutrientData("Sugars, added","g", 0),
  573: NutrientData("Vitamin E, added","mg", 0),
  578: NutrientData("Vitamin B-12, added","µg", 0),
  601: NutrientData("Cholesterol","mg", 0),
  605: NutrientData("Fatty acids, total trans","g", 0),
  606: NutrientData("Fatty acids, total saturated","g", 0),
  607: NutrientData("4:00","g", 0),
  608: NutrientData("6:00","g", 0),
  609: NutrientData("8:00","g", 0),
  610: NutrientData("10:00","g", 0),
  611: NutrientData("12:00","g", 0),
  612: NutrientData("14:00","g", 0),
  613: NutrientData("16:00","g", 0),
  614: NutrientData("18:00","g", 0),
  615: NutrientData("20:00","g", 0),
  617: NutrientData("18:1 undifferentiated","g", 0),
  618: NutrientData("18:2 undifferentiated","g", 0),
  619: NutrientData("18:3 undifferentiated","g", 0),
  620: NutrientData("20:4 undifferentiated","g", 0),
  621: NutrientData("Omega-3 (DHA)","g", 0),
  624: NutrientData("22:00","g", 0),
  625: NutrientData("14:01","g", 0),
  626: NutrientData("16:1 undifferentiated","g", 0),
  627: NutrientData("18:04","g", 0),
  628: NutrientData("20:01","g", 0),
  629: NutrientData("Omega-3 (EPA)","g", 0),
  630: NutrientData("22:1 undifferentiated","g", 0),
  631: NutrientData("22:5 n-3 (DPA)","g", 0),
  636: NutrientData("Phytosterols","mg", 0),
  638: NutrientData("Stigmasterol","mg", 0),
  639: NutrientData("Campesterol","mg", 0),
  641: NutrientData("Beta-sitosterol","mg", 0),
  645: NutrientData("Fatty acids, total monounsaturated","g", 0),
  646: NutrientData("Fatty acids, total polyunsaturated","g", 0),
  652: NutrientData("15:00","g", 0),
  653: NutrientData("17:00","g", 0),
  654: NutrientData("24:00:00","g", 0),
  662: NutrientData("16:1 t","g", 0),
  663: NutrientData("18:1 t","g", 0),
  664: NutrientData("22:1 t","g", 0),
  665: NutrientData("18:2 t not further defined","g", 0),
  666: NutrientData("18:2 i","g", 0),
  669: NutrientData("18:2 t,t","g", 0),
  670: NutrientData("18:2 CLAs","g", 0),
  671: NutrientData("24:1 c","g", 0),
  672: NutrientData("20:2 n-6 c,c","g", 0),
  673: NutrientData("16:1 c","g", 0),
  674: NutrientData("18:1 c","g", 0),
  675: NutrientData("18:2 n-6 c,c","g", 0),
  676: NutrientData("22:1 c","g", 0),
  685: NutrientData("18:3 n-6 c,c,c","g", 0),
  687: NutrientData("17:01","g", 0),
  689: NutrientData("20:3 undifferentiated","g", 0),
  693: NutrientData("Fatty acids, total trans-monoenoic","g", 0),
  695: NutrientData("Fatty acids, total trans-polyenoic","g", 0),
  696: NutrientData("13:00","g", 0),
  697: NutrientData("15:01","g", 0),
  851: NutrientData("Omega-3 (ALA)","g", 0),
  852: NutrientData("20:3 n-3","g", 0),
  853: NutrientData("20:3 n-6","g", 0),
  855: NutrientData("20:4 n-6","g", 0),
  856: NutrientData("18:3i","g", 0),
  857: NutrientData("21:05","g", 0),
  858: NutrientData("22:04","g", 0),
  859: NutrientData("18:1-11t (18:1t n-7)","g", 0)
]
