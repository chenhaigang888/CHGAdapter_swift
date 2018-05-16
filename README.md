# CHGAdapter swift版
主要解决UITableView 在每个controller中都需要设置dataSource和delegate的烦恼，并UITableViewCell与DataSource tableView解耦合
具体表现为

- Adapter与UITableView、Adapter与UITableViewCell完全解耦合。
- 只需要在controller中设置好adapter，给adapter需要显示的数据，adapter会把每个cell需要的数据赋予cell。
- UITableViewCell中按钮的点击事件、UITextField的输入事件、UISwitch等等都通过统一的CHGTableViewDidSelectRowBlock进行传输。
- controller少了很多有关UITableViewDelegate以及UITableViewDatasource的相关代码，controller代码更加清晰。
- 基于以上特点adapter、cell、HeaderFooterView都可以最大限度的复用

oc版：https://github.com/chenhaigang888/CHGAdapter

### Installation with CocoaPods


> pod 'CHGAdapter_swift', '~> 0.0.1'

### example

```
import UIKit

class CollectionViewController: UIViewController {
    
    @IBOutlet var collectionView:UICollectionView?
    
    lazy var adapter:CHGCollectionViewAdapter = {
        () -> CHGCollectionViewAdapter in
        let tempAdapter = CHGCollectionViewAdapter()
        tempAdapter.cellName = "Sample1CollectionViewCell"
        tempAdapter.headerName = "Sample1CollectionReusableView"
        tempAdapter.footerName = "Sample1CollectionReusableView"
        tempAdapter.rowsOfSectionKeyName = "test"
        return tempAdapter
    }()
    
    lazy var adapterData:CHGCollectionViewAdapterData = {
        () ->CHGCollectionViewAdapterData in
        let tempAdapterData = CHGCollectionViewAdapterData()
        tempAdapterData.cellDatas =
            [
                ["test":["1","2","3","4","5","6","7","8"]],
                ["test":["1","2","3","4","5","6","7","8"]],
                ["test":["1","2","3","4","5","6","7","8"]],
                ["test":["1","2","3","4","5","6","7","8"]]
        ]
        tempAdapterData.headerDatas = ["header1","header2"]
        tempAdapterData.footerDatas = ["footer1","footer2"]
        tempAdapterData.customData = NSMutableDictionary()
        return tempAdapterData
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 100, height: 100)
        layout.headerReferenceSize = CGSize(width: self.view.frame.width, height: 30)
        layout.footerReferenceSize = CGSize(width: self.view.frame.width, height: 30)
        self.collectionView?.collectionViewLayout = layout
        self.adapter.adapterData = self.adapterData
        self.collectionView?.collectionViewAdapter = self.adapter
        self.collectionView?.setEventTransmissionBlock(eventTransmissionBlock: { (target:AnyObject, params, tag:NSInteger, callBack:CHGCallBack?) -> AnyObject? in
            callBack!("jjj" as AnyObject)
            return nil
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

```
