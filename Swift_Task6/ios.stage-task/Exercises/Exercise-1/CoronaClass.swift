import Foundation

class CoronaClass {
 
     var studentsCount: Int = 0
     var seats = [Int]()
     let desksCount: Int

     init(n: Int) {
        self.desksCount = n
     }
     
     func seat() -> Int {
        if studentsCount == 0 {
            studentsCount += 1
            seats.append(0)
            return 0
        }
        if studentsCount == 1 {
            studentsCount += 1
            seats.append(desksCount - 1)
            return desksCount - 1
        }
        if !seats.contains(0) {
            studentsCount += 1
            seats.append(0)
            return 0
        }
        if !seats.contains(desksCount - 1) {
            studentsCount += 1
            seats.append(desksCount - 1)
            return desksCount - 1
        }
        studentsCount += 1
        var minDistance = 0
        let options = distanses()
        var resultSeat = 0
        for option in options {
            let distance = option.1 - option.0
            if distance > resultSeat {
                minDistance = distance
                resultSeat = option.1
            }
        }
        seats.append(resultSeat)
        seats.sort(by: { $0 < $1})
        return resultSeat
     }
    
    func distanses() -> [(Int, Int)] {
        var options = [(Int, Int)]()
        var newSeats = seats
        for (index, seat) in newSeats.enumerated() {
            if index == newSeats.count - 1 {
                break
            }
            let nextSeat = newSeats[index + 1]
            let distanse = nextSeat - seat
            let partDistance = distanse / 2
            let resultSeat = seat + partDistance
            options.append((seat, resultSeat))
        }
        return options
    }
     
     func leave(_ p: Int) {
         guard seats.contains(p) else { return }
         studentsCount -= 1
         if let indexP = seats.firstIndex(of: p) {
            seats.remove(at: indexP)
         }
     }
}

