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
                            if winChecker(guess: item, displayedImage: RPC[displayedImage]) == (shouldWin ? .win : .lose) {
                                score += 100
                            } else {
                                score -= 100
                            }
                            displayedImage = Int.random(in: 0...2)
                            shouldWin.toggle()                        }
                    }
                }
                .font(.system(size: 50))
                Spacer()
                Text("Your objective is to: \(shouldWin ? "Win" : "Lose")")
                    .foregroundStyle(.white)
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

