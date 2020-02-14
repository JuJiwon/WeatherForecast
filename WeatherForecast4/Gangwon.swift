

import UIKit

class Gangwon: UIViewController, XMLParserDelegate, UITableViewDelegate, UITableViewDataSource {
    
    var cityArr: Array = [String]()
    var weatherDic: Dictionary = [String:[[String:[String]]]]()        //channel-item-description-body-location           Dic[key:Str value:Arr<Dic>] value 인 arr 안에 Dic[key:Str value:Arr<Str>]
    var key: String!                                                    //각종 엘리먼트 네임을 넣을 변수
    var firstKey: String!                                               //weatherDic에 값을 넣을 때 필요한 변수, tmEf 안의 값 입력
    var count: Int = 0                                                  //weatherDic에 값을 넣을 때 필요한 변수, data를 거칠 때마다 1씩 늘어남
    var bigCt: Int = -1                                                 //weatherDic에 값을 넣을 때 필요한 변수, city를 거칠 때마다 1씩 늘어남
    var isItLocation: Bool = false
    
    var myTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "강원도 날씨"
        
        self.myTable = UITableView()
        
        self.view.backgroundColor = UIColor.white
        
        self.myTable.delegate = self
        self.myTable.dataSource = self
        
        self.myTable.register(UINib(nibName: "CustomCellB", bundle: Bundle.main), forCellReuseIdentifier: "cellB")
        self.view.addSubview(self.myTable)
        
        self.myTable.translatesAutoresizingMaskIntoConstraints = false
        self.view.addConstraint(NSLayoutConstraint(item: self.myTable!, attribute: .top, relatedBy: .equal, toItem: self.view, attribute:  .top, multiplier: 1.0, constant: 0))
        
        self.view.addConstraint(NSLayoutConstraint(item: self.myTable!, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute:  .bottom, multiplier: 1.0, constant: 0))
        
        self.view.addConstraint(NSLayoutConstraint(item: self.myTable!, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute:  .leading, multiplier: 1.0, constant: 0))
        
        self.view.addConstraint(NSLayoutConstraint(item: self.myTable!, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute:  .trailing, multiplier: 1.0, constant: 0))
        
        let sessionConfig = URLSessionConfiguration.default
        let sessionA = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
        let requestA = NSMutableURLRequest(url: URL(string: "http://www.kma.go.kr/weather/forecast/mid-term-rss3.jsp?stnId=105")!)
        requestA.httpMethod = "GET"
        let taskA = sessionA.dataTask(with: requestA as URLRequest) { (dataA, resA, errA) in
            let parserA: XMLParser = XMLParser(data: dataA!)
            parserA.delegate = self
            parserA.parse()
        }
        taskA.resume()
        
        
    }
    
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        
        if isItLocation == true && elementName == "city" {
            self.key = elementName
        }
        
        if elementName == "location" {
            self.isItLocation = true
        }
        if isItLocation == true {
            if elementName == "tmEf" || elementName == "wf" || elementName == "tmn" || elementName == "tmx" || elementName == "reliability" {
                self.key = elementName
            }
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        
        if self.key == "city" {
            self.cityArr.append(string)
            self.bigCt = self.bigCt+1
        }
        
        if key == "tmEf" {
            self.firstKey = string
            
        } else if key == "wf" {
            if weatherDic[self.cityArr[bigCt]] == nil {
                var dicTemp = [[String:[String]]]()
                dicTemp.append([firstKey : [string]])
                self.weatherDic[self.cityArr[bigCt]] = dicTemp
            } else {
                self.weatherDic[self.cityArr[bigCt]]?.append(([firstKey : [string]]))
            }
        } else if key == "tmn" {
            self.weatherDic[self.cityArr[bigCt]]![count][firstKey]!.append("최저 온도: \(string)")
        } else if key == "tmx" {
            self.weatherDic[self.cityArr[bigCt]]![count][firstKey]!.append("최고 온도: \(string)")
            self.count = self.count + 1
//        } else if key == "reliability" {
//            self.weatherDic[self.cityArr[bigCt]]![count][firstKey]!.append("신뢰도: \(string)")
//            self.count = self.count + 1
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        if elementName == "location" {
            self.isItLocation = false
            self.count = 0
        }
        if elementName == "data" {
            self.firstKey = nil
        }
        
        self.key = nil
    }
    
    func parserDidEndDocument(_ parser: XMLParser) {
//        for i in 0...self.data.count-1 {
//            print(data[i])
//        }
        for i in 0...self.weatherDic.count-1 {
            print(cityArr[i])
            
            for x in 0...(self.weatherDic[cityArr[i]]?.count)!-1 {
                print(weatherDic[cityArr[i]]![x])
            }
            
            print("\n")
        }
        
        DispatchQueue.main.async {
            self.myTable.reloadData()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return cityArr.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return cityArr[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherDic[cityArr[0]]!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CustomCellB = self.myTable.dequeueReusableCell(withIdentifier: "cellB", for: indexPath) as! CustomCellB
        
        let aCityWeather:[[String:[String]]] = weatherDic[cityArr[indexPath.section]]!
        let keyNow: String = aCityWeather[indexPath.row].keys.sorted()[0]
        let data: [String] = aCityWeather[indexPath.row][keyNow]!
        
        cell.time.text = keyNow
        cell.wf.text = data[0]
//        cell.reliability.text = data[3]
        cell.tmn.text = data[1]
        cell.tmx.text = data[2]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110.5
    }
    
}

