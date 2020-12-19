import SwiftUI

struct ContentView: View {
    
    var rTarget = Double.random(in: 0..<1)
    var gTarget = Double.random(in: 0..<1)
    var bTarget = Double.random(in: 0..<1)
    //@State variables are owned by the view
    @State private var rGuess: Double = 0.5
    @State private var gGuess: Double = 0.5
    @State private var bGuess: Double = 0.5
    @State var showAlert = false
    @ObservedObject var timer = TimeCounter()   //declares dependency on a reference type that conforms to the ObservableObject protocol

    
    
    
    func computeScore() -> Int {
        
        let rDiff = rGuess - rTarget
        let gDiff = gGuess - gTarget
        let bDiff = bGuess - bTarget
        let diff = sqrt( (rDiff * rDiff + gDiff * gDiff + bDiff * bDiff) / 3.0)
        return lround((1.0 - diff) * 100.0)
        
    }
    
    
    mutating func reset() {
        rTarget = Double.random(in: 0..<1)
        gTarget = Double.random(in: 0..<1)
        bTarget = Double.random(in: 0..<1)
    }
    
    
    var body: some View {
        
        NavigationView {
            VStack {
                
                HStack {
                    VStack {
                        Color(red: rTarget, green: gTarget, blue: bTarget)
                        self.showAlert ? Text("R: \(Int(rTarget * 255.0))" + "  G: \(Int(gTarget * 255.0))" + "  B: \(Int(bTarget * 255.0))")
                            : Text("Match this color")
                        
                    }
                    VStack {
                        ZStack {
                            Color(red: rGuess, green: gGuess, blue: bGuess)
                            Text(String(timer.counter))
                                .padding(.all, 5)
                                .background(Color.white)
                                .mask(Circle())
                            
                        }
                        
                        Text("R: \(Int(rGuess * 255.0))" + "  G: \(Int(gGuess * 255.0))" + "  B: \(Int(bGuess * 255.0))")
                    }
                }
                Button(action: {
                        self.showAlert = true
                        self.timer.killTimer()
                }) {
                    Text("Hit me!")
                }
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Your Score"),message: Text(String(computeScore())), dismissButton: .default (Text("OK")) {
                        //reset()
                    })
                }
                .padding()
                
                VStack {
                    ColorSlider(value: $rGuess, textColor: .red)
                    ColorSlider(value: $gGuess, textColor: .green)
                    ColorSlider(value: $bGuess, textColor: .blue)
                }
                .padding(.horizontal)
                
                
            }
            .background(Color(.systemBackground))
        }
        .navigationViewStyle(StackNavigationViewStyle())
        
        
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewLayout(.fixed(width: 568, height: 320))
    }
}

struct ColorSlider: View {
    
    @Binding var value: Double  //@Binding declares dependency on a @State var owned by another view
    var textColor: Color
    
    var body: some View {
        
        HStack {
            Text("0")
                .foregroundColor(textColor)
            Slider(value: $value)
                .background(textColor)
                .cornerRadius(10)
            Text("255")
                .foregroundColor(textColor)
        }
        
    }
    
}
