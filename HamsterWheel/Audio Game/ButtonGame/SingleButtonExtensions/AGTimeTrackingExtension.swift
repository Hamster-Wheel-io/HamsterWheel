//
//  AGTimeTrackingExtension.swift
//  HamsterWheel
//
//  Created by Bob De Kort on 3/1/18.
//  Copyright © 2018 Bob De Kort. All rights reserved.
//
<<<<<<< HEAD
=======

>>>>>>> development
import Foundation

extension SingleButtonAudioLevel {
    // Sets the end time and calculates the time spent on the level using the start time
    func setEndTimeAndCalculateDifference() {
        // end time when level is complete
        self.end = DispatchTime.now()
        
        // Difference in nano seconds (UInt64) converted to a Double
        let nanoTime = Double((self.end?.uptimeNanoseconds)!) - Double((self.start?.uptimeNanoseconds)!)
        let timeInterval = (nanoTime / 1000000000)
        
        self.totalTime = timeInterval
    }
}
