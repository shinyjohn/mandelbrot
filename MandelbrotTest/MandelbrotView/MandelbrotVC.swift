//
//  MandelbrotVC.swift
//  MandelbrotTest
//
//  Created by APPLE on 22/09/23.
//

import UIKit

class MandelbrotVC: UIViewController {

    @IBOutlet weak var imgScroller: UIScrollView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var containerView: UIView!
    let size:CGFloat = 300
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.drawMandelbrot()
        imgView.image = containerView.asImage()
        containerView.isHidden = true
        
    }

    func drawMandelbrot(){
        let width = containerView.frame.width
        // To Create 2*2 matrix
        for x in 0...Int(width) {
            for y in 0...Int(width) {

                var a = scale(value: CGFloat(x), min1: 0, max1: width, min2:-2, max2: 2)
                var b = scale(value: CGFloat(y), min1: 0, max1: width, min2:-2, max2: 2)

                var total = 0
                let copya = a
                let copyb = b

                //Zn = (Zn-1)^2 + c = a ^ 2 - b ^ 2 + 2abi

                while total < 100 {
                    let squara = a*a - b*b
                    let squareb = 2*a*b

                    //check next coordinates
                    a = squara + copya
                    b = squareb + copyb
                    if abs(a+b) > 2{
                        break
                    }

                    total = total + 1
                }

                let color = scale(value:CGFloat(total) , min1: 0, max1: 100, min2: 0, max2: 255)

                let matrix = CAShapeLayer()
                matrix.path = UIBezierPath(rect: CGRect(x: x, y: y, width: 1, height: 1)).cgPath
                if total == 100 {
                    matrix.fillColor = UIColor.black.cgColor
                } else {
                    matrix.fillColor = UIColor(hue: color/255, saturation: 1, brightness: 1, alpha: 1).cgColor
                }

                containerView.layer.addSublayer(matrix)
            }
        }
        
    }
    
    func scale(value:CGFloat,min1:CGFloat,max1:CGFloat,min2:CGFloat,max2:CGFloat) -> CGFloat {
        let val1 = max1 - min1
        let val2 = max2 - min2
        let n = val2/val1
        return (value - min1)*n + min2
    }


}

//To convert UIView to UIImage
extension UIView {
    func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
}

extension MandelbrotVC: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imgView
    }
    
    func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        
    }
}
