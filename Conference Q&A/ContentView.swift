/// Copyright (c) 2020 Razeware LLC
///
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
///
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
///
/// This project and source code may use libraries or frameworks that are
/// released under various Open-Source licenses. Use of those libraries and
/// frameworks are governed by their own individual licenses.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import SwiftUI

struct ContentView: View {

    // 1
    @State var newQuestion: String = ""
    
    // TODO: Remove following line when socket is implemented.
    @State var questions: [String] = []
    
    // 2
    @ObservedObject var keyboard: Keyboard = .init()
    @ObservedObject var socket: WebSocketController = .init()
    
    var body: some View {
      // 3
      VStack(spacing: 8) {
        Text("Your asked questions:")
        Divider()
        // 4
        // TODO: Update list when socket is implemented.
        List(self.questions, id: \.self) { q in
          VStack(alignment: .leading) {
            Text(q)
            Text("Status: Unanswered")
              .foregroundColor(.red)
          }
        }
        Divider()
        // 5
        TextField("Ask a new question", text: $newQuestion, onCommit: {
          guard !self.newQuestion.isEmpty else { return }
          self.socket.addQuestion(self.newQuestion)
          // TODO: Remove following line when socket is implemented.
          self.questions.append(self.newQuestion)
          self.newQuestion = ""
        })
          .textFieldStyle(RoundedBorderTextFieldStyle())
          .padding(.horizontal)
          .padding(.bottom, keyboard.height)
          .edgesIgnoringSafeArea(keyboard.height > 0 ? .bottom : [])
      }
      .padding(.vertical)
      // 6
      .alert(item: $socket.alertWrapper) { $0.alert }
    }}


struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
