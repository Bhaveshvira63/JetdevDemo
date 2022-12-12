//
//  UIImageViewExtensions.swift
//  JetDemo
//
//  Created by Virani Bhavesh Madhavajibhai on 12/12/22.
//

import Foundation
import Kingfisher
import UIKit


enum ImageSource {
    case server(url: URL, placeholder: UIImage)
    case local(image: UIImage)
    case placeholder(image: UIImage)
}

let imageCache = NSCache<NSString, UIImage>()
extension UIImageView {

    /// To able to set tintColor from IB
    override open func awakeFromNib() {
        super.awakeFromNib()

        tintColorDidChange()
    }

    func setImage(imageSource: ImageSource, completionHandler: (() -> Void)? = nil) {
        switch imageSource {
        case let .server(url, defaultPlaceholder):
            let placeholder = self.image != nil ? self.image : defaultPlaceholder

            self.kf.setImage(with: url, placeholder: placeholder, options: [.transition(.fade(0.2))], progressBlock: { (downloaded, imageSize) in
                if downloaded == imageSize {
                    completionHandler?()
                }
            })
        case let .local(image):
            self.image = image
        case let .placeholder(image):
            self.image = image
        }
    }

    
    func roundImage(borderColor:UIColor = .clear, borderWidth:CGFloat)
    {
        self.layer.cornerRadius = self.frame.size.width / 2
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = borderWidth
        self.clipsToBounds = true

    }
}

extension UIImage {
    static func resizedImage(at url: URL, for size: CGSize) -> UIImage? {
        
        if let imageFromCache = imageCache.object(forKey: url.absoluteString as NSString){
            return imageFromCache
        }
        
        guard let imageSource = CGImageSourceCreateWithURL(url as NSURL, nil),
            let image = CGImageSourceCreateImageAtIndex(imageSource, 0, nil)
            else {
                return nil
        }
        
        let context = CGContext(data: nil,
                                width: Int(size.width),
                                height: Int(size.height),
                                bitsPerComponent: image.bitsPerComponent,
                                bytesPerRow: image.bytesPerRow,
                                space: image.colorSpace ?? CGColorSpace(name: CGColorSpace.sRGB)!,
                                bitmapInfo: image.bitmapInfo.rawValue)
        context?.interpolationQuality = .high
        context?.draw(image, in: CGRect(origin: .zero, size: size))
        
        guard let scaledImage = context?.makeImage() else { return nil }
        imageCache.setObject(UIImage(cgImage: scaledImage), forKey: url.absoluteString as NSString)
        return UIImage(cgImage: scaledImage)
    }
    
}
