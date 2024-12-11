//
//  WebView.swift
//  GCCBibleStudies
//
//  Created by Christian Abbott on 12/10/24.
//

import WebKit
import SwiftUI

struct WebView: UIViewRepresentable {
    
    let urlString: String
    
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        if let url = URL(string: urlString) {
            uiView.load(URLRequest(url: url))
        } else {
            uiView.load(URLRequest(url: URL(string: "https://biblegateway.org")!))
        }
    }
}

#Preview {
    WebView(urlString: "https://biblegateway.org")
}
