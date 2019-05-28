//
//  ViewController.swift
//  face_detection
//
//  Created by A.S.D.Vinay on 21/01/17.
//  Copyright © 2017 A.S.D.Vinay. All rights reserved.
//

import UIKit
import ProjectOxfordFace

class ViewController: UIViewController {

    @IBOutlet weak var imageVC: UIImageView!
    @IBOutlet weak var imageVC1: UIImageView!
    
    var faceFromPhoto1: MPOFace!
    var faceFromPhoto2: MPOFace!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        findface()
      
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    func findface(){
        let client = MPOFaceServiceClient(subscriptionKey: "8f16684192cc4dca9b6264f7128c00a7")!
        
        let data1 = UIImageJPEGRepresentation(imageVC.image!, 0.8)
        let data2 = UIImageJPEGRepresentation(imageVC1.image!, 0.8)
        
        
        
        client.detect(with: data2!, returnFaceId: true, returnFaceLandmarks: true, returnFaceAttributes: [], completionBlock: { (faces, error) in
            if error != nil{
                print(error!)
                return
            }
            
            if  faces!.count == 0 {
                print("no faces atall")
                return
            }
            
            
            self.faceFromPhoto2 = faces![0]
            
            
            
            client.detect(with: data1!, returnFaceId: true, returnFaceLandmarks: true, returnFaceAttributes: [], completionBlock: {(faces,error) in
                if error != nil{
                    print(error!)
                    return
                }
                
                
                if  faces!.count == 0 {
                    print("no faces atall")
                    return
                }
                
                
            
                
                
                    
                    self.faceFromPhoto1 = faces![0]
                    client.verify(withFirstFaceId: self.faceFromPhoto1.faceId, faceId2: self.faceFromPhoto2.faceId, completionBlock: {(result,error) in
                        
                        if error != nil{
                            print(error!)
                            return
                        }
                        
                        
                        
                        if result!.isIdentical{
                            
                            print("same")
                        }
                        else{
                            
                            print("not same")
                            
                        }
                        
                    })
                    
                
            })
        })
    }
}
