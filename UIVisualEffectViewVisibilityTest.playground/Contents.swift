//Made with Xcode 8 beta 6

import UIKit
import PlaygroundSupport

let fontSize:CGFloat = 20.0

class SampleLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }

    func setup() {
        self.textAlignment = .center
        self.font = self.font.withSize(fontSize)
        self.text = "Some text"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class SimpleBlurView: UIView {

    override init(frame: CGRect) {
        let internalFrame = CGRect(origin: CGPoint(x: 0, y: 0), size: frame.size)
        let label = SampleLabel(frame: internalFrame)

        let blurEffect = UIBlurEffect(style: .light)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.layer.cornerRadius = 20.0
        blurView.layer.borderColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 0.49).cgColor
        blurView.layer.borderWidth = 1

        blurView.clipsToBounds = true
        blurView.frame = internalFrame

        blurView.addSubview(label)

        super.init(frame: frame)
        self.addSubview(blurView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class VibrancyBlurView: UIView {

    init(frame: CGRect, style: UIBlurEffectStyle) {
        let internalFrame = CGRect(origin: CGPoint(x: 0, y: 0), size: frame.size)
        let label = SampleLabel(frame: internalFrame)

        let blurEffect = UIBlurEffect(style: style)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.layer.cornerRadius = 20.0
        blurView.layer.borderColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 0.49).cgColor
        blurView.layer.borderWidth = 1
        blurView.clipsToBounds = true
        blurView.frame = internalFrame

        let vibrancyEffect = UIVibrancyEffect(blurEffect: blurEffect)
        let vibrancyView = UIVisualEffectView(effect: vibrancyEffect)
        vibrancyView.frame = internalFrame
        blurView.addSubview(vibrancyView)

        vibrancyView.contentView.addSubview(label)

        super.init(frame: frame)
        self.addSubview(blurView)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class HighVisibilityBlurView: UIView {

    override init(frame: CGRect) {
        let internalFrame = CGRect(origin: CGPoint(x: 0, y: 0), size: frame.size)
        let label = SampleLabel(frame: internalFrame)
        label.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 0.49)

        let blurEffect = UIBlurEffect(style: .light)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.layer.cornerRadius = 20.0
        blurView.layer.borderColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 0.49).cgColor
        blurView.layer.borderWidth = 1
        blurView.clipsToBounds = true
        blurView.frame = internalFrame
        blurView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.2970861486)

        blurView.addSubview(label)

        let vibrancyEffect = UIVibrancyEffect(blurEffect: blurEffect)
        let vibrancyView = UIVisualEffectView(effect: vibrancyEffect)
        vibrancyView.frame = internalFrame
        blurView.addSubview(vibrancyView)

        super.init(frame: frame)
        self.addSubview(blurView)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class SegmentContolHandler: NSObject {

    var viewToSwitch: UIView?
    let backgroundImage = #imageLiteral(resourceName: "checker.jpg")
    let backgroundImageView = UIImageView(image: #imageLiteral(resourceName: "checker.jpg"))

    func onSegmentControl(control: UISegmentedControl) {
        switch control.selectedSegmentIndex {
        case 0:
            self.changeViewColor(to: UIColor(patternImage: backgroundImage))
            break
        case 1:
            self.changeViewColor(to: .black)
            break
        case 2:
            self.changeViewColor(to: .white)
            break

        default:
            break
        }
    }

    func changeViewColor(to color: UIColor) {
        UIView.animate(withDuration: 0.5) { 
            self.viewToSwitch?.backgroundColor = color
        }
    }
}

let simpleBlurView = SimpleBlurView(frame: CGRect(x: 60.0, y: 50.0, width: 200.0, height: 50.0))
let lightVibrancyBlurView = VibrancyBlurView(frame: CGRect(x: 60.0, y: 120.0, width: 200.0, height: 50.0), style: .light)
let extraLightVibrancyBlurView = VibrancyBlurView(frame: CGRect(x: 60.0, y: 190.0, width: 200.0, height: 50.0), style: .extraLight)
let darkVibrancyBlurView = VibrancyBlurView(frame: CGRect(x: 60.0, y: 260.0, width: 200.0, height: 50.0), style: .dark)

let visibleBlurView = HighVisibilityBlurView(frame: CGRect(x: 60.0, y: 330.0, width: 200.0, height: 50.0))

let mainViewFrame = CGRect(x: 0, y: 0, width: 320, height: 560)
let segmentControl = UISegmentedControl(items: ["image", "black", "white"])
segmentControl.backgroundColor = .white
segmentControl.frame = CGRect(origin: CGPoint(x: 10, y: mainViewFrame.height - 50), size: CGSize(width: mainViewFrame.width - 20, height: 40))
segmentControl.tintColor = .darkGray

let mainView = UIView(frame: mainViewFrame)
mainView.backgroundColor = .white
mainView.addSubview(simpleBlurView)
mainView.addSubview(lightVibrancyBlurView)
mainView.addSubview(extraLightVibrancyBlurView)
mainView.addSubview(darkVibrancyBlurView)
mainView.addSubview(visibleBlurView)
mainView.addSubview(segmentControl)

let segmentControlHandler = SegmentContolHandler()
segmentControlHandler.viewToSwitch = mainView
segmentControl.addTarget(segmentControlHandler, action: #selector(segmentControlHandler.onSegmentControl), for: .valueChanged)

PlaygroundPage.current.liveView = mainView
