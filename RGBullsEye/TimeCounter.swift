import Foundation
import Combine


class TimeCounter: ObservableObject {
    
    var timer: Timer?   //fires after a certain time interval has elapsed, sending a specified message to a target object
    @Published var counter = 0
    
    @objc func updateCounter() {
        counter += 1
    }
    
    init() {
        timer = Timer.scheduledTimer(timeInterval:1, target: self, selector:#selector(updateCounter), userInfo: nil, repeats: true)
    }
    
    func killTimer() {
      timer?.invalidate()   //Stops the timer from ever firing again
      timer = nil
    }

    
    
}
