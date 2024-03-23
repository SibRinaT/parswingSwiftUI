//
//  ContentView.swift
//  parsingSite
//
//  Created by Ainur on 23.03.2024.
//

import SwiftUI
import SwiftSoup

struct ContentView: View {
    @State private var headlines: [String] = []

    var body: some View {
        NavigationView {
            List(headlines, id: \.self) { headline in
                Text(headline)
            }
            .navigationTitle("All <p> from site")
            .onAppear(perform: fetchData)
        }
    }

    func fetchData() {
        guard let url = URL(string: "https://hcdev.ru/html/h2/") else {
            return
        }

        do {
            let html = try String(contentsOf: url)
            let doc = try SwiftSoup.parse(html)
            let elements = try doc.select("p")

            var headlines: [String] = []

            for element in elements {
                let headline = try element.text()
                headlines.append(headline)
            }

            DispatchQueue.main.async {
                self.headlines = headlines
            }
        } catch {
            print("Error fetching or parsing data: \(error)")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
