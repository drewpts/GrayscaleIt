//
//  UIViewExtensions.swift
//
//  Created by Andrey Poltavets aka drewpts on 1/13/16.
//


import Foundation

extension UIView {

    /*
     * Please note if you want to use following function
     * you should assign unique tags to your widgets before!
     */

    static private var alreadyGrayscaled = [Int:UIImage]()
    func grayscaleIt() {

        //make an empty UIImageView at first
        let imageView = UIImageView()

        //check for cached image
        if let cached = UIView.alreadyGrayscaled[self.tag] {
            imageView.image = cached
        } else {
            //get a screen capture
            UIGraphicsBeginImageContext(self.bounds.size)
            self.layer.renderInContext(UIGraphicsGetCurrentContext()!)
            let viewImg = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()

            //grayscale the image
            let inputImg = CIImage(CGImage: viewImg.CGImage!)
            let filter = CIFilter(name: "CIColorMonochrome")
            filter?.setValuesForKeysWithDictionary(
                [
                    kCIInputImageKey: inputImg,
                    "inputIntensity": 0.05,
                    "inputColor": CIColor(CGColor: UIColor.blackColor().CGColor)
                ]
            )
            let outputImage = filter?.outputImage
            let resultImage = UIImage(CIImage: outputImage!)

            imageView.image = resultImage

            //put to the cache
            UIView.alreadyGrayscaled[self.tag] = resultImage
        }

        //layout it
        imageView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(imageView)
        let constraints =
        [
            NSLayoutConstraint(item: imageView, attribute: .Leading, relatedBy: .Equal, toItem: self, attribute: .Leading, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: imageView, attribute: .Trailing, relatedBy: .Equal, toItem: self, attribute: .Trailing, multiplier: 1, constant: 1),
            NSLayoutConstraint(item: imageView, attribute: .Top, relatedBy: .Equal, toItem: self, attribute: .Top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: imageView, attribute: .Bottom, relatedBy: .Equal, toItem: self, attribute: .Bottom, multiplier: 1, constant: 1)
        ]

        self.addConstraints(constraints)

    }
}                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               
