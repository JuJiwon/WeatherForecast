

import UIKit

class Nationwide: UIViewController, XMLParserDelegate, UITableViewDelegate, UITableViewDataSource {
    
    var cityArr: Array = [String]()
    var weatherDic: Dictionary = [String:[[String:[String]]]]()
    var key: String!
//    var key2: String!
    var firstKey: String!
    var bigCt: Int = -1
    var ct: Int = 0
    var isItLocation: Bool = false
    var date: String!
    
    var myTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(self.view.bounds.height)
        self.title = "전국 날씨"
        
        self.myTable = UITableView()
        self.view.backgroundColor = UIColor.white
        
        self.myTable.delegate = self
        self.myTable.dataSource = self
        
        self.myTable.register(UINib(nibName: "CustomCell", bundle: Bundle.main), forCellReuseIdentifier: "cellA")
        self.view.addSubview(self.myTable)
        
        self.myTable.translatesAutoresizingMaskIntoConstraints = false
        self.view.addConstraint(NSLayoutConstraint(item: self.myTable!, attribute: .top, relatedBy: .equal, toItem: self.view, attribute:  .top, multiplier: 1.0, constant: 0))
        
        self.view.addConstraint(NSLayoutConstraint(item: self.myTable!, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute:  .bottom, multiplier: 1.0, constant: 0))
        
        self.view.addConstraint(NSLayoutConstraint(item: self.myTable!, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute:  .leading, multiplier: 1.0, constant: 0))
        
        self.view.addConstraint(NSLayoutConstraint(item: self.myTable!, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute:  .trailing, multiplier: 1.0, constant: 0))
        
        
        let sessionConfig = URLSessionConfiguration.default
        let sessionA = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
        let requestA = NSMutableURLRequest(url: URL(string: "http://www.kma.go.kr/weather/forecast/mid-term-rss3.jsp?stnId=108")!)
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
                dicTemp.append([firstKey : ["날씨: \(string)"]])
                self.weatherDic[self.cityArr[bigCt]] = dicTemp
            } else {
                self.weatherDic[self.cityArr[bigCt]]?.append(([firstKey : ["날씨: \(string)"]]))
            }
        } else if key == "tmn" {
            self.weatherDic[self.cityArr[bigCt]]![ct][firstKey]!.append("최저 온도: \(string)")
        } else if key == "tmx" {
            self.weatherDic[self.cityArr[bigCt]]![ct][firstKey]!.append("최고 온도: \(string)")
            self.ct = self.ct + 1
//        } else if key == "reliability" {
//            if self.weatherDic[self.cityArr[bigCt]]![ct][firstKey] != nil {
//                self.weatherDic[self.cityArr[bigCt]]![ct][firstKey]!.append("신뢰도: \(string)")
//            }
//            self.ct = self.ct + 1
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        if elementName == "location" {
            self.isItLocation = false
            self.ct = 0
        }
        if elementName == "data" {
            self.firstKey = nil
        }
        
        self.key = nil
    }
    
    func parserDidEndDocument(_ parser: XMLParser) {
        
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
        return cityArr.count-1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return cityArr[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherDic[cityArr[0]]!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CustomCell = self.myTable.dequeueReusableCell(withIdentifier: "cellA", for: indexPath) as! CustomCell
        
        let aCityWeather:[[String:[String]]] = weatherDic[cityArr[indexPath.section]]!
        let keyNow: String = aCityWeather[indexPath.row].keys.sorted()[0]
        let data: [String] = aCityWeather[indexPath.row][keyNow]!
        
        cell.city.text = cityArr[indexPath.section]
        cell.time00.text = keyNow
        cell.time12.text = data[0] + "," + data[1] + "," + data[2]// + "," + data[3]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110.5
    }
    
}
