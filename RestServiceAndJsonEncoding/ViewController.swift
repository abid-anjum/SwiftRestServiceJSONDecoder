//
//  ViewController.swift
//  RestServiceAndJsonEncoding
//
//  Created by abid hussain on 18/10/1440 AH.
//  Copyright © 1440 abid hussain. All rights reserved.
//

import UIKit

class ViewController: UIViewController , UITableViewDelegate, UITableViewDataSource {
    
    var location: [String] = []
    let cellReuseIdentifier = "cell"
    @IBOutlet weak var tableReport: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if Reachability.isConnectedToNetwork(){
            print("Internet Connection Available!")

        }else{
            print("Internet Connection not Available!")


            UIApplication.shared.statusBarView?.backgroundColor = UIColor.red
            

        }

        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.location.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableReport.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath)
        cell.textLabel?.text = location[indexPath.row]
        return cell;
       
    }
    
    @IBAction func CallRestService(_ sender: Any) {

    let session = URLSession.shared
    let url = URL(string: "http://test.primebird.com/sa.gov.rcj.android/search.php?key=aisC2018")!
    
    let task = session.dataTask(with: url) { data, response, error in
        
        if error != nil || data == nil {
            print("Client error!")
            return
        }
        
        guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
            print("Server error!")
            return
        }
        
        //guard let mime = response.mimeType, mime == "application/json" else {
       //     print("Wrong MIME type!")
       //     return
       // }
        
        do {
            
            let decoder = JSONDecoder()
            
            let string1 = String(data: data!, encoding: String.Encoding.utf8) ?? "Data could not be printed"
            
            print(string1)
        
            let locinfo: [LocationInfo] = [try decoder.decode(LocationInfo.self, from: data!)]
          
            self.location.append(locinfo[0].objects[0].country)
            self.location.append(locinfo[0].objects[0].city)
            self.location.append(locinfo[0].objects[0].label)
            

            DispatchQueue.main.async {
                self.tableReport.reloadData()
            }
            
            //print(locinfo[0].objects[0].city)
        
            
        } catch {
            print("JSON error: \(error.localizedDescription)")
        }
    }
    
    task.resume()
    
    }

}

extension UIApplication {
    
    var statusBarView: UIView? {
        return value(forKey: "statusBar") as? UIView
    }
    
}
