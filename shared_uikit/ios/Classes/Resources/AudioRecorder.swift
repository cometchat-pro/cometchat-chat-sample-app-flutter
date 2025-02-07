//
//  AudioRecorder.swift
//  cometchat
//
//  Created by nabhodipta on 31/07/23.
//

import Foundation
import AVFAudio
import Flutter

public class AudioRecorder: NSObject, AVAudioRecorderDelegate, AVAudioPlayerDelegate {
    var recordingSession: AVAudioSession!
    var audioRecorder: AVAudioRecorder!
    var audioFilename: URL!
    var lastPlaybackTime: CMTime?
    let dateFormatter = DateFormatter()
    var timer: Timer?
    var binaryMessenger: FlutterBinaryMessenger
    
    
    
    
    private let eventChannelName = "cometchat_uikit_shared_audio_intensity"
    
    var player: AVAudioPlayer?
    
    init(binaryMessenger: FlutterBinaryMessenger) {
        self.binaryMessenger = binaryMessenger
        
        super.init()
        setupEventChannel()
    }
    
    func setupRecorder(result: @escaping FlutterResult) {
        recordingSession = AVAudioSession.sharedInstance()
        do {
            try recordingSession.setCategory(.playAndRecord, mode: .default)
            try recordingSession.setActive(true)
            recordingSession.requestRecordPermission() { [unowned self] allowed in
                DispatchQueue.main.async {
                    if allowed {
                        self.startRecording()
                        result(true)
                    } else {
                        // failed to record
                    }}}
        } catch { // failed to record

        }
    }
    
    func setupEventChannel(){
        let eventChannel = FlutterEventChannel(name: eventChannelName, binaryMessenger: binaryMessenger)
        eventChannel.setStreamHandler(self)
        
    }
    
    
    func startRecording() {
        audioFilename = getFileURL()
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        do {
            audioRecorder = try AVAudioRecorder(url: audioFilename, settings: settings)
            audioRecorder?.delegate = self
            audioRecorder?.isMeteringEnabled = true
            audioRecorder?.record()
        } catch {
            stopRecording(success: false)
        }
    }
    
    func stopRecording(success: Bool) -> String? {
        if success {
            audioRecorder?.stop()
            audioRecorder = nil
            
            do {
                try recordingSession.setActive(false)
            } catch {
                print("Error stopping recording: \(error.localizedDescription)")
            }
            return audioFilename.path
        } else {
            
            return nil
        }
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    func getFileURL() -> URL {
        dateFormatter.dateFormat = "yyyyMMddHHmmss"
        let path = getDocumentsDirectory().appendingPathComponent("audio-recording-\(dateFormatter.string(from: Date())).m4a")
        return path as URL
    }
    
    func preparePlayer() {
        var error: NSError?
        do {
            player = try AVAudioPlayer(contentsOf: audioFilename)
        } catch let error1 as NSError {
            error = error1
            player = nil
        }
        if let err = error {
            print("AVAudioPlayer error: \(err.localizedDescription)")
        } else {
            player?.delegate = self
            player?.prepareToPlay()
            player?.volume = 10.0
        }
    }
    
    public func startPlaying(){
        preparePlayer()
        player?.play()
    }
    
    public func pausePlaying(){
        player?.pause()
    }
    
    private func stopPlaying(){
        player?.stop()
        player = nil
    }
    
    public func releaseMediaResources(){
        if audioRecorder != nil || audioRecorder?.isRecording == true {
            stopRecording(success: true)
        }
        
        if player != nil || player?.isPlaying == true {
            stopPlaying()
        }
    }
    
    public func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if  !flag {
            stopRecording(success: false)
        }
    }
    
    func pauseRecording() {
            if let recorder = audioRecorder, recorder.isRecording {
                recorder.pause()
            }
        }
    
    func resumeRecording(result: @escaping FlutterResult) {
        if let recorder = audioRecorder, !recorder.isRecording {
            recorder.record()
            result(true)
        }else{
            result(false)
        }
    }
    
}

extension AudioRecorder: FlutterStreamHandler {
    
    
    public func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        // Send data through the eventSink
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            self.audioRecorder?.updateMeters()
            let decibels = self.audioRecorder?.averagePower(forChannel: 0)
            // Convert the decibels to a linear scale (0.0 to 1.0)
            if decibels != nil {
                let linear = pow(10, (decibels!) / 20)
                events(linear)
            }
        }
        
        return nil
    }
    
    public func onCancel(withArguments arguments: Any?) -> FlutterError? {
        timer?.invalidate()
        return nil
    }
    
}
