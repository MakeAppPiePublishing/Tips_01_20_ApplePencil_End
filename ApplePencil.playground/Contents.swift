import UIKit
import PlaygroundSupport
class ViewController:UIViewController{
    
    //Views
    let square = UILabel()
    let statusLabel = UILabel()
    //touch object
    var touch = UITouch()
    
    var squareText = "Untouched"
    var statusText = "Touch And Pencil Demo"
    var force:CGFloat = 0.0
    var azimuth:CGFloat = 0.0
    var location = CGPoint(x: 200, y: 200)
    var squareSize = CGSize(width: 100, height: 100)
    var altitude:CGFloat = 0.0
    
    //radian conversions
    func degrees(_ radians:CGFloat)->CGFloat{
        return radians * (180.0 / CGFloat.pi)
    }
    
    func updateDisplay(touches: Set<UITouch>){
        // add your code here
        if let newTouch = touches.first{
            touch = newTouch
        }
        location = touch.location(in: view)
        altitude = touch.altitudeAngle
        azimuth = touch.azimuthAngle(in: view)
        force = touch.force 
        if force > 1.0 {
            squareText = "FIRM"
        }
        //update the labels
        statusText = String(format:"Stylus: X:%3.0f Y:%3.0f Azimuth:%2.3f(%2.1fº) Altitude:%2.3f(%2.1fº) Force:%2.3f",location.x,location.y,azimuth,degrees(azimuth),altitude,degrees(altitude),force)
        statusLabel.text = statusText
        square.frame.origin = location
        square.text = squareText
    }
    
    //MARK: - Touch events
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        squareText = "Touched"
        updateDisplay(touches: touches)
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        squareText = "Moved"
        updateDisplay(touches: touches)
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        squareText = "Ended"
        updateDisplay(touches: touches)
    }
    //MARK: -- Label configuration
    func addSquare(){
        view.addSubview(square)
        square.frame = CGRect(origin: location, size: squareSize)
        square.backgroundColor = .blue
        square.text = "untouched"
        square.textColor = .white
        square.textAlignment = .center
    }
    
    func addStatusLabel(){
        view.addSubview(statusLabel)
        statusLabel.text = "Touch and Pencil Demo"
        statusLabel.font = UIFont(name: "Menlo", size: 20)
        statusLabel.backgroundColor = UIColor.darkGray.withAlphaComponent(50)
        statusLabel.textColor = .white
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        var constraints = [NSLayoutConstraint]()
        constraints += [NSLayoutConstraint(item: statusLabel, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: 0.0)]
        constraints += [NSLayoutConstraint(item: statusLabel, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1.0, constant: 0.0)]
        constraints += [NSLayoutConstraint(item: statusLabel, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1.0, constant: 0.0)]
        view.addConstraints(constraints)
    }
    
    
    //MARK: -- Life Cycle 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        addStatusLabel()
        addSquare()

        

    }
    
}

let vc = ViewController()
PlaygroundPage.current.liveView = vc
