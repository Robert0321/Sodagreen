//
//  ViewController.swift
//  Sodagreen
//
//  Created by user on 9/3/23.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var pictureView: UIImageView!
    @IBOutlet weak var datepicker: UIDatePicker!
    @IBOutlet weak var timePointSlider: UISlider!
    
    
    
    let dateFormatter = DateFormatter()
    var dateString:String = ""
    var timer:Timer?
    var imgnum = 0
    var slidernum = 0
    let img = ["20050903","20061020","20071102","20080502","20090508","20090911","20100827","20111111","200130918","20151104"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        datepicker.locale=Locale(identifier: "zh_TW")
        dateFormatter.dateFormat = "yyyy/MM/dd"
    }
    //比對陣列內的照片,num預設0
        func compare(){
    //如果到最後一張照片時則從第一張開始,不是的話繼續跑照片num+=1
            if imgnum>=img.count{
                imgnum=0
                choosePicture(num2: imgnum)
                pictureView.image=UIImage(named: img[imgnum])
            }else{
                choosePicture(num2: imgnum)
                pictureView.image=UIImage(named: img[imgnum])
            }
    //連動Slider
            timePointSlider.value = Float(imgnum)
            imgnum+=1
        }
        
        func time(){
            timer=Timer.scheduledTimer(withTimeInterval: 1, repeats: true){(timer) in self.compare()}
        }
    
    @IBAction func changeValueSlider(_ sender: UISlider) {
        sender.value.round()
        slidernum=Int(sender.value)
        pictureView.image=UIImage(named: img[slidernum])
        print(slidernum)
        choosePicture(num2: slidernum)
    }
    
    @IBAction func autoPlaySwitch(_ sender: UISwitch) {
        if sender.isOn {
            time()
            imgnum = slidernum
            timePointSlider.value = Float(imgnum)
        }else{
            timer?.invalidate()
        }
    }
    //用switch-case選照片
        func choosePicture(num2:Int) {
            switch num2 {
            case 0:
                dateString = "2005/09/03"
            case 1:
                dateString = "2006/10/20"
            case 2:
                dateString = "2007/11/02"
            case 3:
                dateString = "2008/05/02"
            case 4:
                dateString = "2009/05/08"
            case 5:
                dateString = "2009/09/11"
            case 6:
                dateString = "2010/08/27"
            case 7:
                dateString = "2011/11/11"
            case 8:
                dateString = "2013/09/18"
            default:
                dateString = "2015/11/04"
            }
            let date = dateFormatter.date(from: dateString)
            datepicker.date=date!
        }
        override func viewDidDisappear(_ animated: Bool) {
            timer?.invalidate()
        }
}

