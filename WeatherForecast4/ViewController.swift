 

import UIKit

class ViewController: UIViewController {
    
    var btnA: UIButton!
    var btnB: UIButton!
    var btnC: UIButton!
    var btnD: UIButton!
    var btnE: UIButton!
    var btnF: UIButton!
    var btnG: UIButton!
    var btnH: UIButton!
    var btnI: UIButton!
    var btnJ: UIButton!
        
    var secVC: Nationwide!
    var thrVC: Gyeongsangnam!
    var forVC: Gyeongsangbuk!
    var fivVC: Jeollabuk!
    var sixVC: Jeollanam!
    var sevVC: Jeju!
    var eghVC: Gyeonggi!
    var ninVC: Gangwon!
    var tenVC: Chungcheongbuk!
    var elvVC: Chungcheongnam!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black
        
        self.title = "지역 선택"
        
        let width = self.view.bounds.width
        let height = self.view.bounds.height
        secVC = Nationwide()
        thrVC = Gyeongsangnam()
        forVC = Gyeongsangbuk()
        fivVC = Jeollabuk()
        sixVC = Jeollanam()
        sevVC = Jeju()
        eghVC = Gyeonggi()
        ninVC = Gangwon()
        tenVC = Chungcheongbuk()
        elvVC = Chungcheongnam()
        
        
        btnA = UIButton(type: UIButton.ButtonType.system)
        btnA.backgroundColor = UIColor.white
        btnA.setTitleColor(UIColor.black, for: UIControl.State.normal)
        btnA.setTitle("전국", for: .normal)
        btnA.frame = CGRect(x: 0, y: 65, width: width/2, height: (height-65)/5)
        btnA.addTarget(self, action: #selector(btnPressedA(btn:)), for: UIControl.Event.touchUpInside)
        
        btnB = UIButton(type: UIButton.ButtonType.system)
        btnB.backgroundColor = UIColor.white
        btnB.setTitleColor(UIColor.black, for: UIControl.State.normal)
        btnB.setTitle("경상남도", for: .normal)
        btnB.frame = CGRect(x: 0, y: (height-65)/5+65, width: width/2, height: (height-65)/5)
        btnB.addTarget(self, action: #selector(btnPressedB(btn:)), for: UIControl.Event.touchUpInside)
        
        btnC = UIButton(type: UIButton.ButtonType.system)
        btnC.backgroundColor = UIColor.white
        btnC.setTitleColor(UIColor.black, for: UIControl.State.normal)
        btnC.setTitle("경상북도", for: .normal)
        btnC.frame = CGRect(x: 0, y: (height-65)/5*2+65, width: width/2, height: (height-65)/5)
        btnC.addTarget(self, action: #selector(btnPressedC(btn:)), for: UIControl.Event.touchUpInside)
        
        btnD = UIButton(type: UIButton.ButtonType.system)
        btnD.backgroundColor = UIColor.white
        btnD.setTitleColor(UIColor.black, for: UIControl.State.normal)
        btnD.setTitle("전라북도", for: .normal)
        btnD.frame = CGRect(x: 0, y: (height-65)/5*3+65, width: width/2, height: (height-65)/5)
        btnD.addTarget(self, action: #selector(btnPressedD(btn:)), for: UIControl.Event.touchUpInside)
        
        btnE = UIButton(type: UIButton.ButtonType.system)
        btnE.backgroundColor = UIColor.white
        btnE.setTitleColor(UIColor.black, for: UIControl.State.normal)
        btnE.setTitle("전라남도", for: .normal)
        btnE.frame = CGRect(x: 0, y: (height-65)/5*4+65, width: width/2, height: (height-65)/5)
        btnE.addTarget(self, action: #selector(btnPressedE(btn:)), for: UIControl.Event.touchUpInside)
        
        
        btnF = UIButton(type: UIButton.ButtonType.system)
        btnF.backgroundColor = UIColor.white
        btnF.setTitleColor(UIColor.black, for: UIControl.State.normal)
        btnF.setTitle("제주도", for: .normal)
        btnF.frame = CGRect(x: width/2, y: 65, width: width/2, height: (height-65)/5)
        btnF.addTarget(self, action: #selector(btnPressedF(btn:)), for: UIControl.Event.touchUpInside)
        
        btnG = UIButton(type: UIButton.ButtonType.system)
        btnG.backgroundColor = UIColor.white
        btnG.setTitleColor(UIColor.black, for: UIControl.State.normal)
        btnG.setTitle("경기도", for: .normal)
        btnG.frame = CGRect(x: width/2, y: (height-65)/5+65, width: width/2, height: (height-65)/5)
        btnG.addTarget(self, action: #selector(btnPressedG(btn:)), for: UIControl.Event.touchUpInside)
        
        btnH = UIButton(type: UIButton.ButtonType.system)
        btnH.backgroundColor = UIColor.white
        btnH.setTitleColor(UIColor.black, for: UIControl.State.normal)
        btnH.setTitle("강원도", for: .normal)
        btnH.frame = CGRect(x: width/2, y: (height-65)/5*2+65, width: width/2, height: (height-65)/5)
        btnH.addTarget(self, action: #selector(btnPressedH(btn:)), for: UIControl.Event.touchUpInside)
        
        btnI = UIButton(type: UIButton.ButtonType.system)
        btnI.backgroundColor = UIColor.white
        btnI.setTitleColor(UIColor.black, for: UIControl.State.normal)
        btnI.setTitle("충청북도", for: .normal)
        btnI.frame = CGRect(x: width/2, y: (height-65)/5*3+65, width: width/2, height: (height-65)/5)
        btnI.addTarget(self, action: #selector(btnPressedI(btn:)), for: UIControl.Event.touchUpInside)
        
        btnJ = UIButton(type: UIButton.ButtonType.system)
        btnJ.backgroundColor = UIColor.white
        btnJ.setTitleColor(UIColor.black, for: UIControl.State.normal)
        btnJ.setTitle("충청남도", for: .normal)
        btnJ.frame = CGRect(x: width/2, y: (height-65)/5*4+65, width: width/2, height: (height-65)/5)
        btnJ.addTarget(self, action: #selector(btnPressedJ(btn:)), for: UIControl.Event.touchUpInside)
        
        
        btnA.layer.borderWidth = 1
        btnA.layer.borderColor = UIColor.black.cgColor
        btnA.layer.cornerRadius = 10
        
        btnB.layer.borderWidth = 1
        btnB.layer.borderColor = UIColor.black.cgColor
        btnB.layer.cornerRadius = 10
        
        btnC.layer.borderWidth = 1
        btnC.layer.borderColor = UIColor.black.cgColor
        btnC.layer.cornerRadius = 10
        
        btnD.layer.borderWidth = 1
        btnD.layer.borderColor = UIColor.black.cgColor
        btnD.layer.cornerRadius = 10
        
        btnE.layer.borderWidth = 1
        btnE.layer.borderColor = UIColor.black.cgColor
        btnE.layer.cornerRadius = 10
        
        btnF.layer.borderWidth = 1
        btnF.layer.borderColor = UIColor.black.cgColor
        btnF.layer.cornerRadius = 10
        
        btnG.layer.borderWidth = 1
        btnG.layer.borderColor = UIColor.black.cgColor
        btnG.layer.cornerRadius = 10
        
        btnH.layer.borderWidth = 1
        btnH.layer.borderColor = UIColor.black.cgColor
        btnH.layer.cornerRadius = 10
        
        btnI.layer.borderWidth = 1
        btnI.layer.borderColor = UIColor.black.cgColor
        btnI.layer.cornerRadius = 10
        
        btnJ.layer.borderWidth = 1
        btnJ.layer.borderColor = UIColor.black.cgColor
        btnJ.layer.cornerRadius = 10
        
        
        self.view.addSubview(self.btnA)
        self.view.addSubview(self.btnB)
        self.view.addSubview(self.btnC)
        self.view.addSubview(self.btnD)
        self.view.addSubview(self.btnE)
        self.view.addSubview(self.btnF)
        self.view.addSubview(self.btnG)
        self.view.addSubview(self.btnH)
        self.view.addSubview(self.btnI)
        self.view.addSubview(self.btnJ)
        
    }
    
    @objc func btnPressedA(btn:UIButton) {
        self.navigationController?.pushViewController(secVC, animated: true)
    }
    
    @objc func btnPressedB(btn:UIButton) {
        self.navigationController?.pushViewController(thrVC, animated: true)
    }
    
    @objc func btnPressedC(btn:UIButton) {
        self.navigationController?.pushViewController(forVC, animated: true)
    }
    
    @objc func btnPressedD(btn:UIButton) {
        self.navigationController?.pushViewController(fivVC, animated: true)
    }
    
    @objc func btnPressedE(btn:UIButton) {
        self.navigationController?.pushViewController(sixVC, animated: true)
    }
    
    @objc func btnPressedF(btn:UIButton) {
        self.navigationController?.pushViewController(sevVC, animated: true)
    }
    
    @objc func btnPressedG(btn:UIButton) {
        self.navigationController?.pushViewController(eghVC, animated: true)
    }
    
    @objc func btnPressedH(btn:UIButton) {
        self.navigationController?.pushViewController(ninVC, animated: true)
    }
    
    @objc func btnPressedI(btn:UIButton) {
        self.navigationController?.pushViewController(tenVC, animated: true)
    }
    
    @objc func btnPressedJ(btn:UIButton) {
        self.navigationController?.pushViewController(elvVC, animated: true)
    }
    
}


