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


> pod 'CHGAdapter_swift', '~> 0.2.2'


### example 最简单的用法（不使用Adapter）

```
import UIKit

class SampleAdapterDemoViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var address:[CHGAddress] =
        [
            CHGAddress.init(type: 0, address: nil, fullAddress: nil),
            CHGAddress.init(type: 1, address: "陆家嘴", fullAddress: "上海市浦东新区陆家嘴环路")
        ]
    
    var headerData =
        [
            SectionHeaderTitleModel.init(title: "地址一", headerClass: "SectionHeaderTitleHeaderFooterView"),
            SectionHeaderTitleModel.init(title: "地址二",headerClass: "SectionHeaderTitleHeaderFooterView")
        ]
    
    var footerData =
        [
            SectionFooterDescriptionModel.init(descriptionContent: "地址一描述"),
            SectionFooterDescriptionModel.init(descriptionContent: "地址二描述")
        ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "SampleAdapterDemo"
        
        tableView.cellDatas = address as NSArray
        tableView.headerDatas = headerData as NSArray
        tableView.footerDatas = footerData as NSArray
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

```

### example UITableView 使用Adapter

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


### example UICollectionView

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

### example  CHGSimpleTableViewAdapter快速布局

- CHGSimpleTableViewAdapter中Cell的数据（Model）必须实现协议CHGTableViewCellModelProtocol并且实现并且实现其方法
- CHGSimpleTableViewAdapter中的HeaderFooter的数据（Model）必须实现协议CHGTableViewHeaderFooterModelProtocol并且实现并且实现其方法

```
具体使用请参考Demo中的SimpleAdapterViewController页面
```

### example 自定义Adapter

CHGTableViewAdapter和CHGCollectionViewAdapter默认实现一种类型的Cell和一种类型的HeaderView以及FooterView，如果你的TableView、CollectionView想显示不通风格的Cell、HeaderView、FooterView；可以通过集成CHGCollectionViewAdapter、CHGCollectionViewAdapter方式扩展。通过扩展实现以下几个方法返回不同类型,以及在Adapter的子类中实现TableView的DataSource、Delegate方法。CollectionView同理

```
/**
 获取cell的类名

 @param data indexPath的数据
 @param tableView tableView对象
 @param indexPath indexPath
 @return 返回indexPath的cell 类名
 */
func obtainCellNameWithCell(_ data:AnyObject ,tableView:UITableView, cellForRowAtIndexPath indexPath:IndexPath) -> NSString
    

/**
 获取header的类名

 @param data 当前header的数据
 @param tableView tableView对象
 @param section section
 @return 返回section的类名
 */
 func obtainHeaderNameWithHeader(_ data:AnyObject,tableView:UITableView, viewForHeaderInSection section:NSInteger) -> NSString
    
/**
 获取footer的类名
 
 @param data 当前footer的数据
 @param tableView tableView对象
 @param section section
 @return 返回section的类名
 */
 func obtainFooterNameWithFooter(_ data:AnyObject,tableView:UITableView, viewForFooterInSection section:NSInteger) -> NSString
```
