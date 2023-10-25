import SwiftUI

struct CustomColor {
    static let myColor = Color("Color")
    // Add more here...
}

struct ContentView: View {
    
    let RPC = ["🪨", "📃", "✂️"]
    
    enum Outcome {
        case win
        case lose
        case tie
    }
    
    @State private var displayedImage = Int.random(in: 0...2)
    @State private var shouldWin = Bool.random()
    @State private var score = 0
    @State private var gamesPlayed = 0
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    func winChecker(guess: String, displayedImage: String) -> Outcome {
        if guess == displayedImage {
            return Outcome.tie
        } else if guess == "🪨" {
            if displayedImage == "📃" {
                return Outcome.lose
            } else if displayedImage == "✂️" {
                return Outcome.win
            }
        } else if guess == "📃" {
            if displayedImage == "✂️" {
                return Outcome.lose
            } else if displayedImage == "🪨" {
                return Outcome.win
            }
        } else if guess == "✂️" {
            if displayedImage == "🪨" {
                return Outcome.lose
            } else if displayedImage == "📃" {
                return Outcome.win
            }
        }
        return Outcome.tie
    }
    
    func resetGame() {
        showAlert = false
        score = 0
        gamesPlayed = 0
        displayedImage = Int.random(in: 0...2)
        shouldWin.toggle()
    }
    
    func buttonPress(item: String) {
        gamesPlayed += 1
        if winChecker(guess: item, displayedImage: RPC[displayedImage]) == (shouldWin ? .win : .lose) {
            score += 100
        } else {
            score -= 100
        }
        displayedImage = Int.random(in: 0...2)
        shouldWin.toggle()
        if gamesPlayed >= 10 {
            showAlert = true
        }
        if score >= 500 {
            alertMessage = "Good score!"
        } else {
            alertMessage = "Good game."
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Score: \(score)")
                Spacer()
                Text(RPC[displayedImage])
                    .font(.system(size: 150))
                Spacer()
                HStack(spacing: 30) {
                    ForEach(RPC, id: \.self) { item in
                        Button(item) {
                            buttonPress(item: item)
                        }
                    }
                }
                .font(.system(size: 50))
                Spacer()
                Text("Your objective is to: \(shouldWin ? "Win" : "Lose")")
                    .foregroundStyle(.white)
            }
            .alert(alertMessage, isPresented: $showAlert) {
                Button("New Game", action: resetGame)
            } message: {
                Text("Your final score is \(score)")
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(CustomColor.myColor.gradient)
            .navigationTitle("RockPaperScissors")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

