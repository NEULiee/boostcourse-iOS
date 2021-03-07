//
//  ViewController.swift
//  MyMusicPlayer
//
//  Created by Ha Neul Iee on 2021/03/02.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate {
    
    // MARK:- Properties
    var player: AVAudioPlayer!
    var timer: Timer!
    
    // MARK: IBOutlet
    @IBOutlet var playPauseButton: UIButton!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var progressSlider: UISlider!
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        addViewWithCode()
        initializePlayer()
    }
    
    // MARK:- Methods
    // MARK: Custom Methos
    func initializePlayer() {
        guard let soundAsset: NSDataAsset = NSDataAsset(name: "sound") else {
            print("No sound asset here")
            return
        }
        
        do {
            try self.player = AVAudioPlayer(data: soundAsset.data)
            self.player.delegate = self
        } catch let error as NSError {
            print("code: \(error), message: \(error.localizedDescription)")
        }
        
        self.progressSlider.maximumValue = Float(self.player.duration)
        self.progressSlider.minimumValue = 0
        self.progressSlider.value = Float(self.player.currentTime)
    }

    func updateTimeLabel(time: TimeInterval) {
        let minute: Int = Int(time / 60)
        let second: Int = Int(time.truncatingRemainder(dividingBy: 60))
        let millisecond: Int = Int(time.truncatingRemainder(dividingBy: 1) * 100)
        
        let timeText: String = String(format: "%02d:%02d:%02d", minute, second, millisecond)
        
        self.timeLabel.text = timeText
    }

    func makeAndFireTimer() {
        // 0.01초마다 반복
        self.timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: { [unowned self] (timer: Timer) in
            // UISlider의 isTracking과 UIButton의 isTracking
            if self.progressSlider.isTracking {
                return
            }
            updateTimeLabel(time: self.player.currentTime)
            self.progressSlider.value = Float(self.player.currentTime)
        })
        self.timer.fire()
    }
    
    func invalidateTimer() {
        self.timer.invalidate()
        self.timer = nil
    }
    
    func addViewWithCode() {
        addPlayPauseButton()
        addTimeLabel()
        addProgressSlider()
    }
    
    func addPlayPauseButton() {
        let button: UIButton = UIButton(type: UIButton.ButtonType.custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        // addSubview
        self.view.addSubview(button)
        
        button.setImage(UIImage(named: "button_play"), for: UIControl.State.normal)
        button.setImage(UIImage(named: "button_pause"), for: UIControl.State.selected)
        
        // addTarget
        button.addTarget(self, action: #selector(self.touchUpPlayPauseButton(_:)), for: UIControl.Event.touchUpInside)
        
        let centerX: NSLayoutConstraint
        centerX = button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        
        let centerY: NSLayoutConstraint
        centerY = NSLayoutConstraint(item: button, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.view, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 0.8, constant: 0)
        
        let width: NSLayoutConstraint
        width = button.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.5)
        
        // ratio ?
        let ratio: NSLayoutConstraint
        ratio = button.heightAnchor.constraint(equalTo: button.heightAnchor, multiplier: 1)
        
        centerX.isActive = true
        centerY.isActive = true
        width.isActive = true
        ratio.isActive = true
        
        self.playPauseButton = button
    }
    
    func addTimeLabel() {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(label)
        
        label.textColor = UIColor.black
        label.textAlignment = NSTextAlignment.center
        // font 스타일
        label.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.headline)
        
        let centerX: NSLayoutConstraint
        centerX = label.centerXAnchor.constraint(equalTo: self.playPauseButton.centerXAnchor)
        
        let top: NSLayoutConstraint
        top = label.topAnchor.constraint(equalTo: self.playPauseButton.bottomAnchor, constant: 10)
        
        centerX.isActive = true
        top.isActive = true
        
        self.timeLabel = label
        self.updateTimeLabel(time: 0)
    }
    
    func addProgressSlider() {
        let slider: UISlider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(slider)
        
        slider.tintColor = UIColor.systemPink
        
        slider.addTarget(self, action: #selector(sliderValueChanged(_:)), for: UIControl.Event.valueChanged)
        
        let safeAreaGuide: UILayoutGuide = self.view.safeAreaLayoutGuide
        
        let centerX: NSLayoutConstraint
        centerX = slider.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        
        let top: NSLayoutConstraint
        top = slider.topAnchor.constraint(equalTo: self.timeLabel.bottomAnchor, constant: 4)
        
        let leading: NSLayoutConstraint
        leading = slider.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor, constant: 16)
        
        let trailing: NSLayoutConstraint
        trailing = slider.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor, constant: -16)
        
        centerX.isActive = true
        top.isActive = true
        leading.isActive = true
        trailing.isActive = true
        
        self.progressSlider = slider
    }
    
    // MARK: IBActions
    @IBAction func touchUpPlayPauseButton(_ sender: UIButton!) {
        sender.isSelected = !sender.isSelected
        
        if sender.isSelected {
            self.player?.play()
            self.makeAndFireTimer()
        }
        else {
            self.player?.pause()
            self.invalidateTimer()
        }
    }
    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        self.updateTimeLabel(time: TimeInterval(sender.value))
        if sender.isTracking {
            return
        }
        self.player.currentTime = TimeInterval(sender.value)
    }
    
    // MARK: AudioPlayerDelegate
    func audioPlayerDecodeErrorDidOccur(_ player: AVAudioPlayer, error: Error?) {
        guard let error: Error = error else {
            print("오디오 플레이어 디코드 오류 발생")
            return
        }
        
        let message: String
        message = "오류: \(error.localizedDescription)"
        
        let alert: UIAlertController = UIAlertController(title: "알림", message: message, preferredStyle: UIAlertController.Style.alert)
        
        let okAction: UIAlertAction = UIAlertAction(title: "확인", style: UIAlertAction.Style.default) {
            (action: UIAlertAction)-> Void in
            self.dismiss(animated: true, completion: nil)
        }
        
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        self.playPauseButton.isSelected = false
        self.progressSlider.value = 0
        self.updateTimeLabel(time: 0)
        self.invalidateTimer()
    }
}

