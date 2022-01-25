//
//  ViewController.swift
//  CoffeeSubscriptionApp
//
//  Created by WjdanMo on 02/01/2022.
//

import UIKit

class MenuViewController: UIViewController {
    
    @IBOutlet weak var selectedDay: HBSegmentedControl!
    
    @IBOutlet weak var cafeName: UILabel!
    
    @IBOutlet weak var menuCollectionView: UICollectionView!
    
    @IBOutlet weak var repeatOrderOption: UIButton!
    
    @IBOutlet weak var continueButton: UIButton!
    
    @IBOutlet weak var repeatOrderView: UIView!
    
    var menuItems = [MenuItem]()
    
    var firstDayCart = [MenuItem]()
    var secondDayCart = [MenuItem]()
    var thirdDayCart = [MenuItem]()
    var fourthDayCart = [MenuItem]()
    var fifthDayCart = [MenuItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        
    }
    
    func setupViews(){
        
        menuCollectionView.delegate = self
        menuCollectionView.dataSource = self
        menuCollectionView.allowsMultipleSelection = true
        
        let jsonData = NetworkManager.readLocalJSONFile(forName: "cafeNames")
        if let data = jsonData {
            if let decodedData = NetworkManager.parse(jsonData: data) {
                for cafe in decodedData{
                    if cafe.cafeId == Plan.plan.selectedCafe{
                        
                        if let menu = cafe.menu{
                            for item in menu{
                                menuItems.append(item)
                            }
                        }
                        
                        cafeName.text = cafe.cafeName
                    }
                }
            }
        }
        
        selectedDay.items = ["1st day", "2nd day", "3rd day", "4th day", "5th day"]
        selectedDay.font = UIFont(name: "Helvetica-bold", size: 12)
        selectedDay.borderColor = UIColor(named: "Gray")!
        selectedDay.selectedIndex = 0
        selectedDay.padding = 4
        selectedDay.isEnabled = false
        selectedDay.addTarget(self, action: #selector(selectedDayChanged(_:)), for: .valueChanged)
    }
    
    @objc func selectedDayChanged(_ sender: Any) {
        
        // get selected items
        menuCollectionView.reloadData()
        
    }
    
    @IBAction func repeatOrderForPlanChecked(_ sender: Any) {
        if Plan.plan.sameOrderForPlan == false {
            Plan.plan.sameOrderForPlan = true
            
            repeatOrderView.backgroundColor = #colorLiteral(red: 0.185415864, green: 0.3513295054, blue: 0.7834054828, alpha: 0.336817053)
            continueButton.setTitle("Continue", for: .normal)
            
            if selectedDay.selectedIndex != 0 {
                selectedDay.selectedIndex = 0
                firstDayCart.removeAll()
            }
            selectedDay.isEnabled = false
        }
        
        else {
            Plan.plan.sameOrderForPlan = false
            
            repeatOrderView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.4652835265)

            continueButton.setTitle("next", for: .normal)
            selectedDay.isEnabled = true
        }
    }
    
    
    @IBAction func confirmSelectionButtonClicked(_ sender: Any) {
        
            
            if Plan.plan.sameOrderForPlan {
                
                if !firstDayCart.isEmpty {
                    Plan.plan.orderDetails["1"]?.append(contentsOf: self.firstDayCart)
                    Plan.plan.orderDetails["2"]?.append(contentsOf: self.firstDayCart)
                    Plan.plan.orderDetails["3"]?.append(contentsOf: self.firstDayCart)
                    Plan.plan.orderDetails["4"]?.append(contentsOf: self.firstDayCart)
                    Plan.plan.orderDetails["5"]?.append(contentsOf: self.firstDayCart)
                    
                    performSegue(withIdentifier: K.navigateToPlanSetup, sender: self)
                }
                else{
                    // handle error
                }
            }
            
            else {
                
                switch selectedDay.selectedIndex {
                    
                case 0 :
                    if !firstDayCart.isEmpty {
                        selectedDay.selectedIndex = selectedDay.selectedIndex + 1
                        menuCollectionView.reloadData()
                        selectedDay.isEnabled = true
                    }
                    else {}
                    
                case 1 :
                    if !secondDayCart.isEmpty {
                        selectedDay.selectedIndex = selectedDay.selectedIndex + 1
                        menuCollectionView.reloadData()
                    }
                    else {}
                    
                case 2 :
                    if !thirdDayCart.isEmpty {
                        selectedDay.selectedIndex = selectedDay.selectedIndex + 1
                        menuCollectionView.reloadData()
                    }
                    else {}
                    
                case 3 :
                    if !fourthDayCart.isEmpty {
                        selectedDay.selectedIndex = selectedDay.selectedIndex + 1
                        menuCollectionView.reloadData()
                        continueButton.setTitle("Continue", for: .normal)
                        continueButton.backgroundColor = #colorLiteral(red: 0.1256147027, green: 0.1457214653, blue: 0.1624999642, alpha: 1)
                    }
                    else {}
                    
                case 4 :
                    if !fifthDayCart.isEmpty {
                        
                        Plan.plan.orderDetails["1"]?.append(contentsOf: self.firstDayCart)
                        Plan.plan.orderDetails["2"]?.append(contentsOf: self.secondDayCart)
                        Plan.plan.orderDetails["3"]?.append(contentsOf: self.thirdDayCart)
                        Plan.plan.orderDetails["4"]?.append(contentsOf: self.fourthDayCart)
                        Plan.plan.orderDetails["5"]?.append(contentsOf: self.fifthDayCart)
                        
                        performSegue(withIdentifier: K.navigateToPlanSetup, sender: self)
                        
                    }
                    else {
                        // select recommended from menu
                    }
                default :
                    print("errorrrr")
                }
            }
        }
}

extension MenuViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        menuItems.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.itemCellID, for: indexPath) as! MenuItemCell
        
        switch Plan.plan.selectedCafe {
            
        case "Dunkin Donuts" :
            cell.itemImage.image = Images.dunkinDonutsMenuImages[indexPath.row]
        case "Cove Coffee & Roastery" :
            cell.itemImage.image = Images.coveMenuImages[indexPath.row]
        case "Press Coffee" :
            cell.itemImage.image = Images.pressMenuImages[indexPath.row]
//        case "Daylight Coffee" :
//            cell.itemImage.image = Images.dayLightMenuImages[indexPath.row]
        default:
            print("menu images not found")
        }
        
        cell.itemName.text = menuItems[indexPath.row].name
        cell.itemPrice.text = K.priceFormatter.string(from: NSNumber(value: menuItems[indexPath.row].price ?? 0.00))
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        if selectedDay.selectedIndex == 0 {
            firstDayCart.append(menuItems[indexPath.row])
        }
        else if selectedDay.selectedIndex == 1 {
            secondDayCart.append(menuItems[indexPath.row])
        }
        else if selectedDay.selectedIndex == 2 {
            thirdDayCart.append(menuItems[indexPath.row])
        }
        else if selectedDay.selectedIndex == 3 {
            fourthDayCart.append(menuItems[indexPath.row])
        }
        else if selectedDay.selectedIndex == 4 {
            fifthDayCart.append(menuItems[indexPath.row])
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
        if selectedDay.selectedIndex == 0 {
            firstDayCart.removeAll { $0.id == menuItems[indexPath.row].id }
        }
        else if selectedDay.selectedIndex == 1 {
            secondDayCart.removeAll { $0.id == menuItems[indexPath.row].id }
        }
        else if selectedDay.selectedIndex == 2 {
            thirdDayCart.removeAll { $0.id == menuItems[indexPath.row].id }
        }
        else if selectedDay.selectedIndex == 3 {
            fourthDayCart.removeAll { $0.id == menuItems[indexPath.row].id }
        }
        else if selectedDay.selectedIndex == 4 {
            fifthDayCart.removeAll { $0.id == menuItems[indexPath.row].id }
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: (collectionView.frame.size.width / 2) - 28, height: ( collectionView.frame.size.height / 3 ) + 20)
    }
    
}


